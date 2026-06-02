using System;
using System.Web.Mvc;

namespace EventSpaceFinder.Controllers
{
    public class KomentariController : Controller
    {
        private EventSpaceFinderEntities db = new EventSpaceFinderEntities();

        [HttpPost]
        public ActionResult Create(int id_prostora, string tekst_komentara)
        {
            int id_korisnika = 2;

            if (!String.IsNullOrEmpty(tekst_komentara))
            {
                Komentar komentar = new Komentar();

                komentar.id_korisnika = id_korisnika;
                komentar.id_prostora = id_prostora;
                komentar.tekst_komentara = tekst_komentara;
                komentar.datum_komentara = DateTime.Now;
                komentar.odobren = true;

                db.Komentars.Add(komentar);
                db.SaveChanges();
            }

            return RedirectToAction("Details", "Prostori", new { id = id_prostora });
        }
        [HttpPost]
        public ActionResult Delete(int id_komentara, int id_prostora)
        {
            Komentar komentar = db.Komentars.Find(id_komentara);

            if (komentar != null)
            {
                db.Komentars.Remove(komentar);
                db.SaveChanges();
            }

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