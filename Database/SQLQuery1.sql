--Za svaki hotel izlistati naziv kao i broj soba u tom hotelu pod uslovom da je
--taj broj veci od 10

SELECT h.naziv,s.id_hotela,COUNT(*) br_soba
FROM soba AS s
INNER JOIN hotel h ON h.id=s.id_hotela
GROUP BY h.naziv,s.id_hotela
HAVING COUNT(*) > 2;

--Naci hotel sa najvise zvjezdica
SELECT *
FROM hotel h
WHERE h.broj_zvjezdica = (SELECT MAX(broj_zvjezdica) FROM hotel)


--II nacin) koriscenje order by-on redja 
SELECT TOP 1 *   --ali nije dobro jer moze da ima vis ehotela sa max zvjezdica
FROM hotel h
ORDER BY broj_zvjezdica DESC


--Naci klijenta koji je iznajmljivao u svim hotelima
--ovo smo u relacionoj rjesavali /, 

SELECT i.id_klijenta,COUNT(*)
FROM iznajmljivanje
GROUP BY i.id_klijenta