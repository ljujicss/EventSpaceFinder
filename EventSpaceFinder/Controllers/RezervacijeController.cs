using System;
using System.Linq;
using System.Web.Mvc;
using System.Data.SqlClient;

namespace EventSpaceFinder.Controllers
{
    public class RezervacijeController : Controller
    {
        private EventSpaceFinderEntities db = new EventSpaceFinderEntities();

        public ActionResult Create(int id_prostora)
        {
            Prostor prostor = db.Prostors.Find(id_prostora);

            if (prostor == null)
            {
                return HttpNotFound();
            }

            ViewBag.id_prostora = id_prostora;
            ViewBag.naziv_prostora = prostor.naziv;
            ViewBag.id_paketa = new SelectList(db.Pakets.Where(p => p.id_prostora == id_prostora && p.aktivan == true), "id_paketa", "naziv_paketa");

            return View();
        }

        [HttpPost]
        public ActionResult Create(int id_prostora, int id_paketa, DateTime datum_dogadjaja, int broj_gostiju, string napomena)
        {
            int id_korisnika = 2;

            db.Database.ExecuteSqlCommand(
                "EXEC sp_DodajRezervaciju @id_korisnika, @id_prostora, @id_paketa, @datum_dogadjaja, @broj_gostiju, @napomena",
                new SqlParameter("@id_korisnika", id_korisnika),
                new SqlParameter("@id_prostora", id_prostora),
                new SqlParameter("@id_paketa", id_paketa),
                new SqlParameter("@datum_dogadjaja", datum_dogadjaja),
                new SqlParameter("@broj_gostiju", broj_gostiju),
                new SqlParameter("@napomena", napomena ?? "")
            );

            return RedirectToAction("Index", "Prostori");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }

            base.Dispose(disposing);
        }
    }
}