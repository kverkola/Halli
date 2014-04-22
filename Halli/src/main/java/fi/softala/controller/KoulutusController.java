package fi.softala.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import fi.softala.bean.Aikatauluslotti;
import fi.softala.dao.KoulutusDAO;

/*
 * Testi
 */

@Controller
public class KoulutusController {
	
	@Inject
	private KoulutusDAO dao;
	
	public KoulutusDAO getDao() {
		return dao;
	}

	public void setDao(KoulutusDAO dao) {
		this.dao = dao;
	}
		
		@RequestMapping(value="/koulutuslistaus", method=RequestMethod.GET)
		public String getCreateForm(Model model) {
			List<Aikatauluslotti> koulutuslista = dao.haeKoulutukset();
			
			model.addAttribute("koulutukset", koulutuslista);
			
			return "koulutuslista";
		}
		
		
		 //T�m� metodi kuuntelee valuessa olevaa osoitetta koulutuslistat.jsp:lt�.	
		@RequestMapping(value = "/koulutuslistaus/{DaoId}", method = RequestMethod.GET)
	    public String siirryKoulutukseen(Model model, @PathVariable Integer DaoId) {
	       Aikatauluslotti koulutus = dao.haeKoulutus(DaoId);
	        
	        model.addAttribute("ks", koulutus);
	        
	        return "koulutustiedot";
	    } 
		
		

		
	}

