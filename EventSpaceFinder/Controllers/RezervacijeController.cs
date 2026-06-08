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
            if (Session["id_korisnika"] == null)
            {
                return RedirectToAction("Login", "Korisnici");
            }

            int id_korisnika = Convert.ToInt32(Session["id_korisnika"]);

            if (datum_dogadjaja <= DateTime.Now)
            {
                TempData["Poruka"] = "Datum događaja mora biti u budućnosti.";
                return RedirectToAction("Create", new { id_prostora = id_prostora });
            }

            if (broj_gostiju <= 0)
            {
                TempData["Poruka"] = "Broj gostiju mora biti veći od 0.";
                return RedirectToAction("Create", new { id_prostora = id_prostora });
            }

            StatusRezervacije otkazanaStatus = db.StatusRezervacijes
                .FirstOrDefault(s => s.naziv_statusa == "Otkazana");

            int idOtkazana = 0;

            if (otkazanaStatus != null)
            {
                idOtkazana = otkazanaStatus.id_statusa;
            }

            Rezervacija postojecaRezervacija = db.Rezervacijas.FirstOrDefault(r =>
                r.id_korisnika == id_korisnika &&
                r.id_prostora == id_prostora &&
                r.datum_dogadjaja == datum_dogadjaja &&
                (idOtkazana == 0 || r.id_statusa != idOtkazana)
            );

            if (postojecaRezervacija != null)
            {
                TempData["Poruka"] = "Već imate rezervaciju za ovaj prostor na izabrani datum.";
                return RedirectToAction("MojeRezervacije");
            }

            try
            {
                db.Database.ExecuteSqlCommand(
                    "EXEC sp_DodajRezervaciju @id_korisnika, @id_prostora, @id_paketa, @datum_dogadjaja, @broj_gostiju, @napomena",
                    new SqlParameter("@id_korisnika", id_korisnika),
                    new SqlParameter("@id_prostora", id_prostora),
                    new SqlParameter("@id_paketa", id_paketa),
                    new SqlParameter("@datum_dogadjaja", datum_dogadjaja),
                    new SqlParameter("@broj_gostiju", broj_gostiju),
                    new SqlParameter("@napomena", napomena ?? "")
                );

                TempData["Poruka"] = "Zahtjev za rezervaciju je uspješno poslat.";
                return RedirectToAction("MojeRezervacije");
            }
            catch (Exception ex)
            {
                TempData["Poruka"] = "Greška pri slanju rezervacije: " + ex.Message;
                return RedirectToAction("Create", new { id_prostora = id_prostora });
            }
        }

        public ActionResult MojeRezervacije()
        {
            if (Session["id_korisnika"] == null)
            {
                return RedirectToAction("Login", "Korisnici");
            }

            int id_korisnika = Convert.ToInt32(Session["id_korisnika"]);

            var rezervacije = db.Rezervacijas
                .Where(r => r.id_korisnika == id_korisnika)
                .ToList();

            return View(rezervacije);
        }

        public ActionResult SveRezervacije()
        {
            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }
            var rezervacije = db.Rezervacijas
                .OrderByDescending(r => r.datum_rezervacije)
                .ToList();

            return View(rezervacije);
        }

        [HttpPost]
        public ActionResult PromijeniStatus(int id_rezervacije, int id_statusa)
        {

            if (Session["uloga"] == null || Session["uloga"].ToString() != "Admin")
            {
                return RedirectToAction("Login", "Korisnici");
            }

            Rezervacija rezervacija = db.Rezervacijas.Find(id_rezervacije);



            if (rezervacija == null)
            {
                return HttpNotFound();
            }

            rezervacija.id_statusa = id_statusa;

            db.SaveChanges();

            return RedirectToAction("SveRezervacije");
        }

        [HttpPost]
        public ActionResult Otkazi(int id_rezervacije)
        {
            if (Session["id_korisnika"] == null)
            {
                return RedirectToAction("Login", "Korisnici");
            }

            int id_korisnika = Convert.ToInt32(Session["id_korisnika"]);

            Rezervacija rezervacija = db.Rezervacijas.FirstOrDefault(r => r.id_rezervacije == id_rezervacije && r.id_korisnika == id_korisnika);

            if (rezervacija == null)
            {
                return HttpNotFound();
            }

            if (rezervacija.datum_dogadjaja <= DateTime.Now.AddDays(10))
            {
                TempData["Poruka"] = "Rezervaciju možete otkazati najkasnije 10 dana prije događaja.";
                return RedirectToAction("MojeRezervacije");
            }

            StatusRezervacije status = db.StatusRezervacijes.FirstOrDefault(s => s.naziv_statusa == "Otkazana");

            if (status != null)
            {
                rezervacija.id_statusa = status.id_statusa;
                db.SaveChanges();
            }

            return RedirectToAction("MojeRezervacije");
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