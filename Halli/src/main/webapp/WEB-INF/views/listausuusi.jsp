

<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!doctype html>

<html lang="en">
<head>

<meta charset="utf-8">

<title>Halli</title>
<meta name="description"
	content="Halli: Koulutusten hallinta- ja ilmoittautumisjärjestelmä">
<meta name="author" content="Haaga-Helia">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/style.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/colorbox.css">

<!--[if lt IE 9]>
            <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
            <![endif]-->
</head>

<body>
	<div class="container">
		<div class="sivumenu">
			<a href="./">
				<div class="nav-item">
					<div class="nav-icon tulevat"></div>
					<div class="nav-text">Tulevat luennot</div>
				</div>
			</a> <a href="./menneet">
				<div class="nav-item">
					<div class="nav-icon menneet"></div>
					<div class="nav-text">Menneet luennot</div>
				</div>
			</a>
			<div class="nav-item">
				<div class="nav-icon palaute"></div>
				<div class="nav-text">Anna palautetta</div>
			</div>
		</div>
		<div class="main clearfix">
		<div class="ylapalkit">
			<div class="yla1">Halli: Koulutusten hallinta- ja
				ilmoittautumisjärjestelmä</div>
			<div class="yla2"><div class="yla2-icon admin"></div><a href="./admin">Kirjaudu sisään järjestelmänvalvojana</a></div>
		</div>
			<div class="fifty lista">
				<form id="haku" action="hakutulokset">
					<input type="text" name="haku" autocomplete="off"
						placeholder="Suodata koulutuksia hakusanan perusteella"
						value="${hakusana}"><input type="submit" value=" "><c:if test="${!empty hakusana}"><c:out escapeXml="false" value="<a class='sulkemisnappi' href='./'></a>" /></c:if>
				</form>
				<ul>
					<c:if test="${empty koulutukset}">
						<c:out value="Koulutuksia ei löytynyt hakusanan perusteella" />
					</c:if>
					<c:forEach items="${koulutukset}" var="k">
						<li divid="<c:out value="${k.id}"/>" class="aihe"><input
							type="checkbox" name="box" class="box" value="${k.id}" id="checkboxi" disabled />
							<label for="checkboxi"></label>
							<c:out value="${k.aihe}" /> <span class="pvm"><c:out
									value="${k.suomiPvm}" /></span></li>
					</c:forEach>
				</ul>
			</div>
			<div class="fifty tiedot">
				<div class="table-container">
					<c:choose>
						<c:when test="${viesti==null}">
							<span
								style="display: block; text-align: center; margin-top: 96px; margin-bottom: 96px;">Tervetuloa
								HAAGA-HELIA ammattikorkeakoulun ilmoittautumisjärjestelmään!
								Tarvitset opiskelijatunnuksen. Valitse koulutukset vasemmalta.</span>
							<br />
						</c:when>

						<c:otherwise>
							<span
								style="display: block; text-align: center; margin-top: 96px; margin-bottom: 96px; color:green; font-size:30px;">
								Kiitos ilmoittautumisesta!</span>
							<br />
						</c:otherwise>
					</c:choose>
				</div>
				<c:forEach items="${koulutukset}" var="k">
					<input type="hidden" name="aihe" value="${k.aihe}" />
					<div class="table-container" id="<c:out value="${k.id}"/>"
						style="display: none">
						<table>
							<tr>
								<td class="koulutus-otsikko" colspan="2">Koulutuksen tiedot</td>
							</tr>
							<tr>
								<td class="bold">Aihe</td>
								<td><c:out value="${k.aihe}" /></td>
							</tr>
							<tr>
								<td class="bold">Kouluttajat</td>
								<td><c:forEach items="${k.kouluttajat}" var="koul"
										varStatus="loopStatus">
										<c:out value="${koul.etunimi} " />
										<c:out value="${koul.sukunimi}" />
										<c:if test="${!loopStatus.last}">
											<c:out value=", " />
										</c:if>
									</c:forEach></td>
							</tr>
							<tr>
								<td class="bold">Päivämäärä</td>
								<td><c:out value="${k.suomiPvm}" /></td>
							</tr>
							<tr>
								<td class="bold">Kellonaika</td>
								<td><c:out value="${k.suomiKlo}" /> - <c:out
										value="${k.suomiLoppuKlo}" /></td>
							</tr>
							<tr>
								<td class="bold">Avainsanat</td>
								<td><c:forEach items="${k.avainsanat}" var="a">
										<span class="tagi"><a href="avainsana?avainsana=${a}"
											class="tagi"><c:out value="${a}" /></a></span>
									</c:forEach></td>
							</tr>
							<tr>
								<td class="bold">Lähtötaso</td>
								<td><c:out value="${k.lahtotaso}" /></td>
							</tr>
							<tr>
								<td class="bold">Paikka</td>
								<td><c:out value="${k.paikka}" /></td>
							</tr>
							<tr>
								<td class="bold">Kuvaus</td>
								<td><p>
										<c:out value="${k.kuvaus}" />
									</p></td>
							</tr>
							
							<jsp:useBean id="now" class="java.util.Date" />
							<fmt:parseDate value="${k.suomiPvm}" pattern="dd.MM.yyyy"
								var="pvm" />
							<fmt:formatDate value="${pvm}" pattern="yyyy-MM-dd" var="pvm" />
							<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nyt" />
							<tr>
								<td></td>
								<td><c:choose>
										<c:when test="${pvm > nyt}">
											<button type="button" value="${k.id}" class="lisaa">Valitse
												koulutus</button>
										</c:when>
									</c:choose></td>
							</tr>
							</table>
					</div>
				</c:forEach>
			</div>
			<div class="alapalkki">
			<c:choose>
				<c:when test="${pvm > nyt}">
				<button type="submit" name="vahvista" href="#lightbox_sisalto" class="vahvistus"
				 disabled>Vahvista ilmoittautumiset</button>
				</c:when>
			</c:choose>
			</div>
		</div>

	</div>

	<!-- lightboxin sisältö -->

	<div style='display: none'>
		<div id='lightbox_sisalto' style='padding: 20px; background: #fff;'>
			<div class="lightbox-inner-sisalto">
				<p>Olet valinnut seuraavat koulutukset:</p>
				<br />
				<ul id="valitut"></ul>
				<br />
				<p>Anna vielä tietosi ilmoittautumista varten:</p>
				<br />

				<form id="ilmoittautuminen" method="post" action="ilmoittaudu"
					name="ilmoittaudu">

					<input type="hidden" id="valitutkoulutukset"
						name="valitutkoulutukset" />

					<table>
						<tr>
							<td>Etunimi</td>
							<td>Sukunimi</td>
						</tr>
						<tr>
							<td><input type="text" name="etunimi"></td>
							<td><input type="text" name="sukunimi"></td>
						</tr>
						<tr>
							<td colspan="2">Opiskelijanumero</td>
						</tr>
						<tr>
							<td colspan="2"><input type="text" name="opiskelijanro"></td>
						</tr>
					</table>
			</div>


			<div class="modaalin-kontrollit clearfix">
				<button type="submit" id="ilmoittaudu" disabled>
					Ilmoittaudu koulutuksiin</button>

				<input type="button" onclick="$.colorbox.close()"
					value="Sulje ikkuna" />

			</div>
			</form>
		</div>
	</div>

	<!-- lightboxin sisältö päättyy -->
	<script
		src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/js/jquery-1.11.0.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/js/jquery.colorbox.js"></script>

	<script
		src="<%=request.getContextPath()%>/resources/js/jquery.validate.min.js"></script>

	<script
		src="<%=request.getContextPath()%>/resources/js/additional-methods.js"></script>
	<script type="application/javascript"
		src="<%=request.getContextPath()%>/resources/js/script.js"></script>
</body>
</html>

