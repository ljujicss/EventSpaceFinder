using System.Linq;
using System.Web.Mvc;

namespace EventSpaceFinder.Controllers
{
    public class PaketiController : Controller
    {
        private EventSpaceFinderEntities db = new EventSpaceFinderEntities();

        public ActionResult Index()
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            var paketi = db.Pakets
            .Where(p => p.aktivan == true)
            .ToList();

            return View(paketi);
        }

        public ActionResult Create()
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            ViewBag.id_prostora = new SelectList(db.Prostors, "id_prostora", "naziv");

            return View();
        }

        [HttpPost]
        public ActionResult Create(Paket paket)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            if (ModelState.IsValid)
            {
                paket.aktivan = true;

                db.Pakets.Add(paket);
                db.SaveChanges();

                return RedirectToAction("Index");
            }

            ViewBag.id_prostora = new SelectList(db.Prostors, "id_prostora", "naziv", paket.id_prostora);

            return View(paket);
        }

        public ActionResult Edit(int id)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            Paket paket = db.Pakets.Find(id);

            if (paket == null)
            {
                return HttpNotFound();
            }

            ViewBag.id_prostora = new SelectList(db.Prostors, "id_prostora", "naziv", paket.id_prostora);

            return View(paket);
        }

        [HttpPost]
        public ActionResult Edit(Paket paket)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            Paket stariPaket = db.Pakets.Find(paket.id_paketa);

            if (stariPaket == null)
            {
                return HttpNotFound();
            }

            if (ModelState.IsValid)
            {
                stariPaket.id_prostora = paket.id_prostora;
                stariPaket.naziv_paketa = paket.naziv_paketa;
                stariPaket.opis = paket.opis;
                stariPaket.cijena = paket.cijena;
                stariPaket.broj_sati = paket.broj_sati;
                stariPaket.aktivan = paket.aktivan;

                db.SaveChanges();

                return RedirectToAction("Index");
            }

            ViewBag.id_prostora = new SelectList(db.Prostors, "id_prostora", "naziv", paket.id_prostora);

            return View(paket);
        }

        public ActionResult Delete(int id)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            Paket paket = db.Pakets.Find(id);

            if (paket == null)
            {
                return HttpNotFound();
            }

            return View(paket);
        }

        [HttpPost]
        public ActionResult DeleteConfirmed(int id)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            Paket paket = db.Pakets.Find(id);

            if (paket == null)
            {
                return HttpNotFound();
            }

            paket.aktivan = false;
            db.SaveChanges();

            return RedirectToAction("Index");
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