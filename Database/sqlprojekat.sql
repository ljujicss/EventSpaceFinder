USE EventSpaceFinder;
GO

INSERT INTO Grad(naziv_grada) VALUES
('Podgorica'),
('Nikši?'),
('Bar'),
('Budva'),
('Herceg Novi'),
('Žabljak'),
('Tivat');
GO

INSERT INTO Korisnik(ime, prezime, email, lozinka, telefon, uloga) VALUES
('Admin', 'Sistema', 'admin@eventspace.com', 'admin123', '067111222', 'Admin'),
('Olga', 'Danilovi?', 'olga@gmail.com', 'olga123', '067222333', 'Korisnik'),
('Marko', 'Radonji?', 'marko@gmail.com', 'marko123', '068333444', 'Korisnik'),
('Ana', 'Savi?', 'ana@gmail.com', 'ana123', '069444555', 'Korisnik'),
('Stevan', 'Joveti?', 'stevan@gmail.com', 'stevan123', '067555666', 'Korisnik');
GO

INSERT INTO TipDogadjaja(naziv_tipa, opis) VALUES
('Svadba', 'Prostor pogodan za organizaciju svadbi.'),
('Ro?endan', 'Prostor za dje?ije i odrasle ro?endane.'),
('Matura', 'Prostor za maturske i apsolventske ve?eri.'),
('Krštenje', 'Prostor za porodi?ne proslave i krštenja.'),
('Outdoor dogadjaj', 'Dogadjaj na otvorenom prostoru u prirodi.'),
('Poslovni dogadjaj', 'Prostor za poslovne proslave i konferencije.');
GO

INSERT INTO Usluga(naziv_usluge, opis) VALUES
('Parking', 'Obezbije?en parking za goste.'),
('Ketering', 'Hrana i pi?e u okviru ponude.'),
('Dekoracija', 'Dekoracija prostora po želji korisnika.'),
('Muzika', 'Mogu?nost organizacije muzike uživo ili DJ-a.'),
('Fotograf', 'Fotografisanje doga?aja.'),
('Terasa', 'Prostor posjeduje otvorenu terasu.'),
('Bazen', 'Prostor posjeduje bazen.'),
('Igraonica', 'Dio za djecu i animatore.');
GO

INSERT INTO Prostor(id_grada, naziv, opis, adresa, kapacitet, osnovna_cijena, tip_prostora) VALUES
(1, 'Restoran Stara ku?a', 'Nacionalni restoran sa autenti?nim ambijentom, pogodan za ro?endane, manje svadbe, korporativne i privatne proslave.', 'Iva Andri?a 5, Podgorica', 60, 1600.00, 'Restoran'),
(1, 'Hotel Hilton', 'Moderna sala za svadbe,mature i velike proslave.', 'Bulevar Svetog Petra Cetinjskog 2', 150, 2000.00, 'Hotel'),
(1, '?elebi? Sport Club', 'Restoran za svadbe, ro?endane, manje svadbe, korporativne i privatne proslave.', 'Donja Gorica bb', 200, 2000.00, 'Restoran'),
(1, 'Hotel Podgorica', 'Moderna sala za svadbe i velike proslave.', 'Ulica Svetlane Kane Radevi? 1', 300, 1500.00, 'Hotel'),
(2, 'Manitovac', 'Restoran sa baštom, pogodan za manje proslave.', 'Hercegova?ki put', 50, 200.00, 'Restoran'),
(2, 'Hotel Onogošt', 'Hotelska sala za konferencije i proslave.', 'Njegoševa 15', 200, 900.00, 'Hotel'),
(5, 'One&Only Portonovi', 'Ekskluzivni resort u Portonovom, pogodan za luksuzne svadbe, outdoor proslave i velike doga?aje.', 'Portonovi, Herceg Novi', 300, 18000.00, 'Luksuzni resort'),
(4, 'Splendid Conference & Spa Resort', 'Luksuzni hotel na obali u Be?i?ima, pogodan za velike svadbe, gala ve?ere i proslave.', 'Be?i?i bb', 500, 10000.00, 'Hotel'),
(4, 'Avala Resort & Villas', 'Hotel pored Starog grada, sa salama i panoramskim prostorom pogodnim za sve?ane doga?aje.', 'Mediteranska / Slovenska obala, Budva', 180, 9000.00, 'Hotel'),
(4, 'Villa Azzura', 'Vila sa bazenom za privatne proslave.', 'Rezevici bb', 30, 300.00, 'Vila'),
(3, 'Hotel Princess', 'Hotel na obali mora u Baru, pogodan za svadbe, gala ve?ere, koktele, poslovne doga?aje i manje/ve?e proslave. Ima restoran sa pogledom na more i konferencijske sale za doga?aje.', 'Jovana Tomaševi?a 21, 85000 Bar', 150, 2000.00, 'Hotel');
GO

INSERT INTO StatusRezervacije(naziv_statusa) VALUES
('Na cekanju'),
('Prihvacena'),
('Odbijena'),
('Otkazana'),
('Zavrsena');
GO

INSERT INTO ProstorTipDogadjaja(id_prostora, id_tipa_dogadjaja) VALUES
(1, 1),
(1, 2),
(1, 6),
(1, 4),

(2, 1),
(2, 3),
(2, 6),

(3, 1),
(3, 2),
(3, 6),

(4, 1),
(4, 3),
(4, 6),

(5, 2),
(5, 4),
(5, 5),

(6, 1),
(6, 3),
(6, 6),

(7, 1),
(7, 5),
(7, 6),

(8, 1),
(8, 3),
(8, 6),

(9, 1),
(9, 2),
(9, 6),

(10, 2),
(10, 5),

(11, 1),
(11, 3),
(11, 6);
GO

INSERT INTO ProstorUsluga(id_prostora, id_usluge) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),

(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 7),

(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 6),

(4, 1),
(4, 2),
(4, 3),
(4, 5),
(4, 6),

(5, 1),
(5, 2),
(5, 6),
(5, 8),

(6, 1),
(6, 2),
(6, 3),
(6, 6),

(7, 1),
(7, 2),
(7, 3),
(7, 4),
(7, 5),
(7, 6),
(7, 7),

(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(8, 6),

(9, 1),
(9, 2),
(9, 3),
(9, 4),
(9, 6),
(9, 7),

(10, 1),
(10, 2),
(10, 6),
(10, 7),

(11, 1),
(11, 2),
(11, 3),
(11, 4),
(11, 5),
(11, 6);
GO

INSERT INTO Paket(id_prostora, naziv_paketa, opis, cijena, broj_sati) VALUES
(1, 'Osnovni paket', 'Zakup prostora, stolovi i osnovna usluga.', 1600.00, 5),
(1, 'Standard paket', 'Zakup prostora, ketering i dekoracija.', 2300.00, 6),

(2, 'Svecani paket', 'Zakup sale, ketering, dekoracija i muzika.', 4000.00, 7),
(2, 'Premium paket', 'Kompletna organizacija velike proslave.', 7000.00, 8),

(3, 'Osnovni paket', 'Zakup prostora, stolovi i osnovna usluga.', 1600.00, 5),
(3, 'Biznis paket', 'Paket za poslovne dogadjaje i korporativne proslave.', 2800.00, 6),

(4, 'Hotel paket', 'Zakup sale, hrana, pice i osnovna dekoracija.', 3000.00, 6),
(4, 'Gala paket', 'Paket za vece svadbe i svecane dogadjaje.', 5500.00, 8),

(5, 'Mali paket', 'Paket za manje porodicne proslave.', 500.00, 4),
(5, 'Basta paket', 'Zakup restorana sa bastom i keteringom.', 900.00, 5),

(6, 'Osnovni paket', 'Zakup prostora, stolovi i osnovna usluga.', 1700.00, 6),
(6, 'Konferencijski paket', 'Paket za poslovne dogadjaje i prezentacije.', 1500.00, 6),

(7, 'Luxury paket', 'Luksuzni paket za svadbe i velike dogadjaje.', 25000.00, 8),
(7, 'Outdoor luxury paket', 'Ekskluzivna organizacija dogadjaja na otvorenom.', 30000.00, 8),

(8, 'Splendid standard paket', 'Paket za svadbe i gala vecere.', 15000.00, 8),
(8, 'Splendid premium paket', 'Kompletna luksuzna organizacija dogadjaja.', 22000.00, 10),

(9, 'Osnovni paket', 'Zakup prostora, stolovi i osnovna usluga.', 17000.00, 7),
(9, 'Gala paket', 'Paket za vece svadbe i svecane dogadjaje.', 20000.00, 8),


(10, 'Privatni paket', 'Paket za privatne proslave u vili.', 800.00, 5),
(10, 'Pool paket', 'Paket sa koriscenjem bazena i dekoracijom.', 1200.00, 6),

(11, 'Osnovni paket', 'Zakup prostora, stolovi i osnovna usluga.', 3600.00, 6),
(11, 'Business paket', 'Paket za poslovne dogadjaje i koktele.', 3500.00, 5);
GO

INSERT INTO PaketUsluga(id_paketa, id_usluge) VALUES
(1, 1),
(1, 6),

(2, 1),
(2, 2),
(2, 3),
(2, 6),

(3, 1),
(3, 2),
(3, 3),
(3, 4),

(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 6),
(4, 7),

(5, 1),
(5, 6),

(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 6),

(7, 1),
(7, 2),
(7, 3),
(7, 5),

(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(8, 6),

(9, 1),
(9, 2),
(9, 8),

(10, 1),
(10, 2),
(10, 3),
(10, 6),
(10, 8),

(11, 1),
(11, 6),

(12, 1),
(12, 2),
(12, 6),

(13, 1),
(13, 2),
(13, 3),
(13, 4),
(13, 5),
(13, 6),
(13, 7),

(14, 1),
(14, 2),
(14, 3),
(14, 4),
(14, 5),
(14, 6),
(14, 7),

(15, 1),
(15, 2),
(15, 3),
(15, 4),
(15, 5),
(15, 6),

(16, 1),
(16, 2),
(16, 3),
(16, 4),
(16, 5),
(16, 6),
(16, 7),
(16, 8),

(17, 1),
(17, 6),

(18, 1),
(18, 2),
(18, 3),
(18, 4),
(18, 6),

(19, 1),
(19, 2),
(19, 6),

(20, 1),
(20, 2),
(20, 3),
(20, 6),
(20, 7),

(21, 1),
(21, 6),

(22, 1),
(22, 2),
(22, 3),
(22, 4),
(22, 5),
(22, 6);
GO

INSERT INTO SlikaProstora(id_prostora, putanja_slike, opis, glavna_slika) VALUES
(1, 'https://starakuca.me/wp-content/uploads/2024/02/Restoran-Stara-kuca-Restoranski-dio-7-1.webp', 'Ekterijer restorana Stara ku?a', 1),
(1, 'https://starakuca.me/wp-content/uploads/2024/02/Restoran-Stara-kuca-Basta-restorana-9.webp', 'Restoran Stara ku?a', 0),
(2, 'https://www.hilton.com/im/en/TGDPMHI/3347137/restaurant-crna-gora-1.jpg?impolicy=crop&cw=5000&ch=2669&gravity=NorthWest&xposition=0&yposition=331&rw=768&rh=410', 'Hotel Hilton', 1),
(2, 'https://www.hilton.com/im/en/TGDPMHI/3345711/sky-bar-8.jpg?impolicy=crop&cw=7153&ch=4004&gravity=NorthWest&xposition=0&yposition=382&rw=768&rh=430', 'Hotel Hilton', 0),
(2, 'https://www.hilton.com/im/en/TGDPMHI/3348631/jelena-theatre-4.jpg?impolicy=crop&cw=5000&ch=2799&gravity=NorthWest&xposition=0&yposition=267&rw=768&rh=430', 'Hotel Hilton', 0),
(3, 'https://vjencaj.me/galerija/v-celebic-sport-club-1513688169-10.jpg', '?elebi? Sport Club', 1),
(3, 'https://vjencaj.me/galerija/v-centreville-hotel-&-experiences-1513757963-82.jpg', '?elebi? Sport Club', 0),
(4, 'https://vjencaj.me/galerija/v-hotel-podgorica-1513689936-3.jpg', 'Hotel Podgorica', 1),
(4, 'https://moja-djelatnost.me/Image/IndexFile?name=HotelucentrunaobaliMora%C4%8DePodgorica1.jpg', 'Hotel Podgorica', 0),
(5, 'https://foodbook.me/storage/restaurants/5aYCiErhYfmy0J36ZzaL38q16eUvRlk0RxuAQDRD.jpeg', 'Manitovac', 1),
(6, 'https://media.pobjeda.me/media/1584533618-onogost-i_1280x800.jpg?cacheControl=1584533619', 'Hotel Onogošt', 1),
(6, 'https://foodbook.me/storage/restaurants/364/uiBvSns3yZ1fkT0oDkmaOsrcreE8wCN7D5uOJGT4.jpeg', 'Hotel Onogošt', 0),
(7, 'https://cdn.globtourmontenegro.com/inc/img/resources/7850-OneOnly_Portonovi_Architectural_Resort_Drone_1680_MASTER.jpg', 'One&Only Portonovi', 1),
(7, 'https://assets.kerzner.com/api/public/content/697ef13b9069412cbd93836bd3a544ed?v=7944afb7&t=w576', 'One&Only Portonovi', 0),
(8, 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/219930339.jpg?k=f35f3863c8874b4a023b551f1be7fd3d9ed96635b1295853956be26143149988&o=', 'Splendid Conference & Spa Resort', 1),
(8, 'https://montenegrostars.com/images/mshg/weddings/w2.jpg', 'Splendid Conference & Spa Resort', 0),
(9, 'https://traveltravel.rs/pic/279207742.jpg', 'Avala Resort & Villas', 1),
(9, 'https://cdn.globtourmontenegro.com/inc/img/resources/8624-Hote_Avala_Budva_Montenegro_4.jpg', 'Avala Resort & Villas', 0),
(10, 'https://www.apartmontenegro.com/files/images/wm/1778135366-villa-azzurra-0009.jpg', 'Villa Azzura', 1),
(10, 'https://www.apartmontenegro.com/files/images/wm/1778135366-villa-azzurra-0008.jpg', 'Villa Azzura', 0),
(11, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdPr8JTu2g6Z0sQn11bD-BeEqUqL9mnuSatg&s', 'Hotel Princess', 0),
(11, 'https://forzatravel.rs/fajlovi/product/princess-hotel-985.jpg', 'Hotel Princess', 1);
GO

INSERT INTO Ocjena(id_korisnika, id_prostora, ocjena) VALUES
(2, 1, 5),
(2, 2, 4),
(2, 5, 5),
(2, 10, 4),

(3, 3, 5),
(3, 6, 4),
(3, 7, 5),

(4, 4, 4),
(4, 8, 5),
(4, 11, 5),

(5, 1, 4),
(5, 9, 5),
(5, 10, 5);
GO

INSERT INTO Komentar(id_korisnika, id_prostora, tekst_komentara, odobren) VALUES
(2, 1, 'Prelijep ambijent i odli?na usluga za porodi?ne proslave.', 1),
(2, 5, 'odli?an za manje proslave i okupljanja.', 1),
(2, 10, 'Villa Azzura je super izbor za privatnu proslavu.', 1),

(3, 3, 'Dobar prostor, pogodan i za ve?e proslave.', 1),
(3, 7, 'Luksuzan prostor i veoma profesionalna organizacija.', 1),

(4, 4, 'Ima bas lijepu salu i dobru lokaciju.', 1),
(4, 8, 'Odli?an za sve?ane doga?aje i velike svadbe.', 1),
(4, 11, 'Ima lijep pogled i dobar prostor za doga?aje.', 1),

(5, 1, 'Ima veoma prijatan i tradicionalan ambijent. Hrana je super.', 1),
(5, 9, 'Vrlo lukuzan hotel, u samom centru pored Starog grada.', 1);
GO

INSERT INTO OmiljeniProstor(id_korisnika, id_prostora) VALUES
(2, 1),
(2, 5),
(2, 10),

(3, 3),
(3, 7),
(3, 8),

(4, 4),
(4, 8),
(4, 11),

(5, 1),
(5, 9),
(5, 10);
GO

INSERT INTO Rezervacija(id_korisnika, id_prostora, id_paketa, id_statusa, datum_dogadjaja, broj_gostiju, ukupna_cijena, napomena) VALUES
(2, 1, 2, 1, '2026-07-15', 50, 2300.00, 'Ro?endan za 50 osoba.'),
(3, 3, 6, 2, '2026-08-20', 120, 2800.00, 'Poslovni doga?aj.'),
(4, 8, 15, 2, '2026-09-05', 300, 15000.00, 'Svadba.'),
(5, 9, 18, 1, '2026-06-18', 150, 20000.00, 'Sve?ana proslava.'),
(2, 10, 20, 1, '2026-07-25', 25, 1200.00, 'Privatna proslava u vili.'),
(4, 11, 22, 3, '2026-05-30', 80, 3500.00, 'Poslovni koktel.');
GO

INSERT INTO KalendarZauzetosti(id_prostora, id_rezervacije, datum, status_datuma, napomena) VALUES
(1, 1, '2026-07-15', 'Na cekanju', 'Rezervacija za ro?endan.'),
(3, 2, '2026-08-20', 'Zauzeto', 'Prihva?ena rezervacija za poslovni doga?aj.'),
(8, 3, '2026-09-05', 'Zauzeto', 'Prihva?ena rezervacija za svadbu.'),
(9, 4, '2026-06-18', 'Na cekanju', 'Rezervacija za sve?anu proslavu.'),
(10, 5, '2026-07-25', 'Na cekanju', 'Privatna proslava u vili.'),
(11, 6, '2026-05-30', 'Zauzeto', 'Odbijena rezervacija, ali termin evidentiran.');
GO

SELECT * FROM Grad;
SELECT * FROM Korisnik;
SELECT * FROM TipDogadjaja;
SELECT * FROM Usluga;
SELECT * FROM Prostor;
SELECT * FROM ProstorTipDogadjaja;
SELECT * FROM ProstorUsluga;
SELECT * FROM Paket;
SELECT * FROM PaketUsluga;
SELECT * FROM Rezervacija;
SELECT * FROM KalendarZauzetosti;
SELECT * FROM Ocjena;
SELECT * FROM Komentar;
SELECT * FROM OmiljeniProstor;
GO