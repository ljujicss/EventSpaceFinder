using System;
using System.Linq;
using System.Web.Mvc;

namespace EventSpaceFinder.Controllers
{
    public class OcjeneController : Controller
    {
        private EventSpaceFinderEntities db = new EventSpaceFinderEntities();

        [HttpPost]
        public ActionResult Create(int id_prostora, int ocjena)
        {
            if (Session["id_korisnika"] == null)
            {
                return RedirectToAction("Login", "Korisnici");
            }

            int id_korisnika = Convert.ToInt32(Session["id_korisnika"]);

            if (ocjena < 1 || ocjena > 5)
            {
                return RedirectToAction("Details", "Prostori", new { id = id_prostora });
            }

            Ocjena postojecaOcjena = db.Ocjenas.FirstOrDefault(o => o.id_korisnika == id_korisnika && o.id_prostora == id_prostora);

            if (postojecaOcjena == null)
            {
                Ocjena novaOcjena = new Ocjena();

                novaOcjena.id_korisnika = id_korisnika;
                novaOcjena.id_prostora = id_prostora;
                novaOcjena.ocjena1 = ocjena;
                novaOcjena.datum_ocjene = DateTime.Now;

                db.Ocjenas.Add(novaOcjena);
            }
            else
            {
                postojecaOcjena.ocjena1 = ocjena;
                postojecaOcjena.datum_ocjene = DateTime.Now;
            }

            db.SaveChanges();

            return RedirectToAction("Details", "Prostori", new { id = id_prostora });
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