using System;
using System.Linq;
using System.Web.Mvc;

namespace EventSpaceFinder.Controllers
{
    public class KorisniciController : Controller
    {
        private EventSpaceFinderEntities db = new EventSpaceFinderEntities();

        public ActionResult Register()
        {
            return View();
        }


        [HttpPost]
        public ActionResult Register(string ime, string prezime, string email, string lozinka, string telefon)
        {
            if (String.IsNullOrWhiteSpace(ime) ||
                String.IsNullOrWhiteSpace(prezime) ||
                String.IsNullOrWhiteSpace(email) ||
                String.IsNullOrWhiteSpace(lozinka))
            {
                ViewBag.Poruka = "Morate popuniti sva obavezna polja.";
                return View();
            }

            Korisnik postojeci = db.Korisniks.FirstOrDefault(k => k.email == email);

            if (postojeci != null)
            {
                ViewBag.Poruka = "Korisnik sa ovim emailom već postoji.";
                return View();
            }

            Korisnik korisnik = new Korisnik();

            korisnik.ime = ime;
            korisnik.prezime = prezime;
            korisnik.email = email;
            korisnik.lozinka = lozinka;
            korisnik.telefon = telefon;
            korisnik.uloga = "Korisnik";
            korisnik.datum_registracije = DateTime.Now;
            korisnik.aktivan = true;

            db.Korisniks.Add(korisnik);
            db.SaveChanges();

            return RedirectToAction("Login");
        }
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string email, string lozinka)
        {
            Korisnik korisnik = db.Korisniks.FirstOrDefault(k => k.email == email && k.lozinka == lozinka && k.aktivan == true);

            if (korisnik == null)
            {
                ViewBag.Poruka = "Pogresan email ili lozinka.";
                return View();
            }

            Session["id_korisnika"] = korisnik.id_korisnika;
            Session["ime"] = korisnik.ime;
            Session["uloga"] = korisnik.uloga;

            return RedirectToAction("Index", "Prostori");
        }

        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Index", "Home");
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