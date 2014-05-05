package fi.softala.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import fi.softala.bean.Koulutustilaisuus;
import fi.softala.bean.Osallistuja;
import fi.softala.service.KoulutusHakuService;
import fi.softala.service.OsallistujaService;

/**
 * 
 * @author Timo Kottonen
 * @author Teemu Kälviäinen
 *
 */

@Controller
@RequestMapping(value = "/")
public class KoulutusHakuController {

	@Inject
	private KoulutusHakuService hakuservice;

	public KoulutusHakuService getService() {
		return hakuservice;
	}

	public void setService(KoulutusHakuService service) {
		this.hakuservice = service;
	}
	
	@Inject
	private OsallistujaService osallistujaservice;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String listaaTulevatKoulutukset(Model model) {
		List<Koulutustilaisuus> koulutukset = hakuservice.haeTulevat();
		model.addAttribute("koulutukset", koulutukset);
		return "listausuusi";
	}
	
	@RequestMapping(value = "menneet", method = RequestMethod.GET)
	public String listaaMenneetKoulutukset(Model model) {
		List<Koulutustilaisuus> koulutukset = hakuservice.haeMenneet();
		model.addAttribute("koulutukset", koulutukset);
		return "listausuusi";
	}
	
	@RequestMapping(value="hakutulokset", method=RequestMethod.GET)
	public String listaaKoulutuksetHakusanalla(Model model, ServletRequest request) throws UnsupportedEncodingException {
		String ehto = new String(request.getParameter("haku").getBytes("iso-8859-1"), "UTF-8");
		List<Koulutustilaisuus> koulutukset = hakuservice.haeHakusanalla(ehto);
		model.addAttribute("koulutukset", koulutukset);
		model.addAttribute("hakusana", ehto);
		return "listausuusi";
	}
	
	@RequestMapping(value="avainsana", method=RequestMethod.GET)
	public String listaaKoulutuksetAvainsanalla(Model model, ServletRequest request) throws UnsupportedEncodingException {
		String ehto = new String(request.getParameter("avainsana").getBytes("iso-8859-1"), "UTF-8");
		List<Koulutustilaisuus> koulutukset = hakuservice.haeAvainsanalla(ehto);
		model.addAttribute("koulutukset", koulutukset);
		model.addAttribute("hakusana", ehto);
		return "listausuusi";
	}

	@RequestMapping(value="ilmoittaudu", method=RequestMethod.POST)
	public String talletaOsallistuja(Model model, ServletRequest request){
		String osallistumiset = request.getParameter("valitutkoulutukset");
		String enimi = request.getParameter("etunimi");
		String snimi = request.getParameter("sukunimi");
		String onro = request.getParameter("opiskelijanro");
		Osallistuja osallistuja = new Osallistuja(onro, enimi, snimi);
		osallistujaservice.tallenna(osallistuja, osallistumiset);
		return "redirect:/";
	}
}
