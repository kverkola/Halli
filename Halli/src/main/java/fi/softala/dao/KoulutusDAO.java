package fi.softala.dao;

import java.util.List;

import fi.softala.bean.Kouluttaja;
import fi.softala.bean.Koulutustilaisuus;

public interface KoulutusDAO {
	
	public List<Koulutustilaisuus> haeKoulutukset();

	public Koulutustilaisuus haeKoulutus(int id);
	
	public void paivitaKoulutus(Koulutustilaisuus koulutus);
	
	public void peruutaKoulutus(int id);
<<<<<<< HEAD

	public void siirraKoulutus(int koulutusId, int aikaId);
=======
	
	public List<Kouluttaja> haeKouluttajat(int id);
>>>>>>> ed880b4550ad46b9d301009f9aae58ddd13be819
}
