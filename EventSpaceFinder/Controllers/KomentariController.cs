using System;
using System.Linq;
using System.Web.Mvc;

namespace EventSpaceFinder.Controllers
{
    public class KomentariController : Controller
    {
        private EventSpaceFinderEntities db = new EventSpaceFinderEntities();

        [HttpPost]
        public ActionResult Create(int id_prostora, string tekst_komentara)
        {
            if (Session["id_korisnika"] == null)
            {
                return RedirectToAction("Login", "Korisnici");
            }

            int id_korisnika = Convert.ToInt32(Session["id_korisnika"]);

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

        public ActionResult AdminKomentari()
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            var komentari = db.Komentars.ToList();

            return View(komentari);
        }

        [HttpPost]
        public ActionResult PromijeniOdobren(int id_komentara)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            Komentar komentar = db.Komentars.Find(id_komentara);

            if (komentar == null)
            {
                return HttpNotFound();
            }

            komentar.odobren = !komentar.odobren;

            db.SaveChanges();

            return RedirectToAction("AdminKomentari");
        }

        [HttpPost]
        public ActionResult AdminDelete(int id_komentara)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            Komentar komentar = db.Komentars.Find(id_komentara);

            if (komentar != null)
            {
                db.Komentars.Remove(komentar);
                db.SaveChanges();
            }

            return RedirectToAction("AdminKomentari");
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