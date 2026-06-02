using System;
using System.Linq;
using System.Web.Mvc;

namespace EventSpaceFinder.Controllers
{
    public class OmiljeniProstoriController : Controller
    {
        private EventSpaceFinderEntities db = new EventSpaceFinderEntities();

        [HttpPost]
        public ActionResult Dodaj(int id_prostora)
        {
            int id_korisnika = 2;

            OmiljeniProstor omiljeni = db.OmiljeniProstors.FirstOrDefault(o => o.id_korisnika == id_korisnika && o.id_prostora == id_prostora);

            if (omiljeni == null)
            {
                OmiljeniProstor novi = new OmiljeniProstor();

                novi.id_korisnika = id_korisnika;
                novi.id_prostora = id_prostora;
                novi.datum_dodavanja = DateTime.Now;

                db.OmiljeniProstors.Add(novi);
                db.SaveChanges();
            }

            return RedirectToAction("Details", "Prostori", new { id = id_prostora });
        }

        [HttpPost]
        public ActionResult Ukloni(int id_prostora)
        {
            int id_korisnika = 2;

            OmiljeniProstor omiljeni = db.OmiljeniProstors.FirstOrDefault(o => o.id_korisnika == id_korisnika && o.id_prostora == id_prostora);

            if (omiljeni != null)
            {
                db.OmiljeniProstors.Remove(omiljeni);
                db.SaveChanges();
            }

            return RedirectToAction("Details", "Prostori", new { id = id_prostora });
        }

        public ActionResult MojiOmiljeni()
        {
            int id_korisnika = 2;

            var omiljeni = db.OmiljeniProstors.Where(o => o.id_korisnika == id_korisnika).ToList();

            return View(omiljeni);
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