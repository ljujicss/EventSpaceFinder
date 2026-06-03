using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EventSpaceFinder.Controllers
{
    public class ProstoriController : Controller
    {
        private EventSpaceFinderEntities db = new EventSpaceFinderEntities();

        public ActionResult Index(string search)
        {
            var prostori = db.Prostors.AsQueryable();

            if (!String.IsNullOrEmpty(search))
            {
                prostori = prostori.Where(p =>
                    p.naziv.Contains(search) ||
                    p.opis.Contains(search) ||
                    p.adresa.Contains(search) ||
                    p.tip_prostora.Contains(search) ||
                    p.Grad.naziv_grada.Contains(search)
                );
            }

            ViewBag.Search = search;

            return View(prostori.ToList());
        }


        public ActionResult DetaljnaPretraga()
        {
            ViewBag.id_grada = new SelectList(db.Grads, "id_grada", "naziv_grada");
            ViewBag.id_tipa_dogadjaja = new SelectList(db.TipDogadjajas, "id_tipa_dogadjaja", "naziv_tipa");

            return View();
        }

        [HttpPost]
        public ActionResult DetaljnaPretraga(int? id_grada, int? id_tipa_dogadjaja, int? broj_gostiju, decimal? budzet, DateTime? datum_dogadjaja)
        {
            var prostori = db.Prostors.AsQueryable();

            if (id_grada != null)
            {
                prostori = prostori.Where(p => p.id_grada == id_grada);
            }

            if (broj_gostiju != null)
            {
                prostori = prostori.Where(p => p.kapacitet >= broj_gostiju);
            }

            if (budzet != null)
            {
                prostori = prostori.Where(p => p.Pakets.Any(pk => pk.cijena <= budzet));
            }

            if (id_tipa_dogadjaja != null)
            {
                prostori = prostori.Where(p => p.TipDogadjajas.Any(t => t.id_tipa_dogadjaja == id_tipa_dogadjaja));
            }

            if (datum_dogadjaja != null)
            {
                prostori = prostori.Where(p => !p.KalendarZauzetostis.Any(k =>
                    k.datum == datum_dogadjaja &&
                    (k.status_datuma == "Zauzeto" || k.status_datuma == "Na cekanju")
                ));
            }

            ViewBag.id_grada = new SelectList(db.Grads, "id_grada", "naziv_grada", id_grada);
            ViewBag.id_tipa_dogadjaja = new SelectList(db.TipDogadjajas, "id_tipa_dogadjaja", "naziv_tipa", id_tipa_dogadjaja);

            return View("RezultatiPretrage", prostori.ToList());
        }

        public ActionResult Details(int id)
        {
            Prostor prostor = db.Prostors.Find(id);

            if (prostor == null)
            {
                return HttpNotFound();
            }

            return View(prostor);
        }

        public ActionResult Create()
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            ViewBag.id_grada = new SelectList(db.Grads, "id_grada", "naziv_grada");

            return View();
        }

        [HttpPost]
        public ActionResult Create(Prostor prostor)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            if (ModelState.IsValid)
            {
                prostor.aktivan = true;

                db.Prostors.Add(prostor);
                db.SaveChanges();

                return RedirectToAction("Index");
            }

            ViewBag.id_grada = new SelectList(db.Grads, "id_grada", "naziv_grada", prostor.id_grada);

            return View(prostor);
        }

        public ActionResult Edit(int id)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            Prostor prostor = db.Prostors.Find(id);

            if (prostor == null)
            {
                return HttpNotFound();
            }

            ViewBag.id_grada = new SelectList(db.Grads, "id_grada", "naziv_grada", prostor.id_grada);

            return View(prostor);
        }

        [HttpPost]
        public ActionResult Edit(Prostor prostor)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            Prostor stariProstor = db.Prostors.Find(prostor.id_prostora);

            if (stariProstor == null)
            {
                return HttpNotFound();
            }

            if (ModelState.IsValid)
            {
                stariProstor.id_grada = prostor.id_grada;
                stariProstor.naziv = prostor.naziv;
                stariProstor.opis = prostor.opis;
                stariProstor.adresa = prostor.adresa;
                stariProstor.kapacitet = prostor.kapacitet;
                stariProstor.osnovna_cijena = prostor.osnovna_cijena;
                stariProstor.tip_prostora = prostor.tip_prostora;
                stariProstor.aktivan = prostor.aktivan;

                db.SaveChanges();

                return RedirectToAction("Index");
            }

            ViewBag.id_grada = new SelectList(db.Grads, "id_grada", "naziv_grada", prostor.id_grada);

            return View(prostor);
        }

        public ActionResult Delete(int id)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            Prostor prostor = db.Prostors.Find(id);

            if (prostor == null)
            {
                return HttpNotFound();
            }

            return View(prostor);
        }

        [HttpPost]
        public ActionResult DeleteConfirmed(int id)
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            Prostor prostor = db.Prostors.Find(id);

            if (prostor == null)
            {
                return HttpNotFound();
            }

            prostor.aktivan = false;
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