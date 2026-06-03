using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;

namespace EventSpaceFinder.Controllers
{
    public class PreporukaController : Controller
    {
        private EventSpaceFinderEntities db = new EventSpaceFinderEntities();

        public ActionResult Index()
        {
            ViewBag.id_grada = new SelectList(db.Grads, "id_grada", "naziv_grada");
            ViewBag.id_tipa_dogadjaja = new SelectList(db.TipDogadjajas, "id_tipa_dogadjaja", "naziv_tipa");

            return View();
        }

        [HttpPost]
        public ActionResult Index(int? id_grada, int? id_tipa_dogadjaja, int? broj_gostiju, decimal? budzet, DateTime? datum_dogadjaja)
        {
            ViewBag.id_grada = new SelectList(db.Grads, "id_grada", "naziv_grada", id_grada);
            ViewBag.id_tipa_dogadjaja = new SelectList(db.TipDogadjajas, "id_tipa_dogadjaja", "naziv_tipa", id_tipa_dogadjaja);

            var rezultat = db.Database.SqlQuery<PreporukaRezultat>(
            "EXEC dbo.sp_PreporuciNajboljiProstor @id_grada, @id_tipa_dogadjaja, @broj_gostiju, @budzet, @datum_dogadjaja",
            new SqlParameter("@id_grada", (object)id_grada ?? DBNull.Value),
            new SqlParameter("@id_tipa_dogadjaja", (object)id_tipa_dogadjaja ?? DBNull.Value),
            new SqlParameter("@broj_gostiju", (object)broj_gostiju ?? DBNull.Value),
            new SqlParameter("@budzet", (object)budzet ?? DBNull.Value),
            new SqlParameter("@datum_dogadjaja", (object)datum_dogadjaja ?? DBNull.Value)
        ).ToList();

            rezultat = rezultat
                .GroupBy(p => p.id_prostora)
                .Select(g => g.First())
                .OrderByDescending(p => p.bodovi)
                .Take(1)
                .ToList();

            return View(rezultat);
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

    public class PreporukaRezultat
    {
        public int id_prostora { get; set; }
        public string naziv { get; set; }
        public string grad { get; set; }
        public string adresa { get; set; }
        public int kapacitet { get; set; }
        public decimal osnovna_cijena { get; set; }
        public string tip_prostora { get; set; }
        public decimal prosjecna_ocjena { get; set; }
        public int broj_ocjena { get; set; }
        public string najbolji_paket { get; set; }
        public decimal cijena_paketa { get; set; }
        public decimal bodovi { get; set; }
    }
}