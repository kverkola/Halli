<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
	<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/bootstrap-modal.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/koulutuslistaustyylit.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/jquery-ui-1.10.4.min.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/jquery.timepicker.css">



<script src="<%=request.getContextPath()%>/resources/js/jquery-1.11.0.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery-ui-1.10.4.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery.timepicker.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap-modal.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/bootstrap-modalmanager.js"></script>

<script> 
 	$(document).ready(function() {
 		$( "#datepicker" ).datepicker({dateFormat: 'dd.mm.yy'});
 		$( ".timepicker" ).timepicker({ 'timeFormat': 'H:i', 
 			'minTime': '07:00',
 			'maxTime': '21:00'
 		});
 	});
 </script>

<!-- Avaa Modal valikko, mik�li muokkauskent�ss� on virheit� -->
<c:if test="${avaaModal != null }">
	<script src="<%=request.getContextPath()%>/resources/js/modalAvaus.js"></script>
</c:if>

<title>Koulutustiedot</title>
</head>


<body>


<div class="panel panel-default">
  <!-- Default panel contents -->
  
  <div class="panel-heading">${ks.aihe}</div>
  
  <div class="panel-body">    
    <p>${ks.kuvaus}</p>    
  </div>

  <!-- Table -->
  <table class="table">
  
  <tr>
    	<th>P�iv�m��r�</th>
    	<td>${ks.aikaslotti.pvm}</td> 
    </tr>
  	
  	<tr> 
  		<th>Alkaa</th>
  		<td>${ks.aikaslotti.alkukello} </td>
  	</tr>
  	
  	<tr>  	
		<th>Loppuu</th>	  
	    <td>${ks.aikaslotti.loppukello}</td>    
    </tr>
    
    <tr>
    	<th>Koulutustila</th>
    	<td>${ks.aikaslotti.koulutustila}</td> 
    </tr>
    
    <tr>
    	<th>L�ht�taso</th>
    	<td>${ks.lahtotaso}</td> 
    </tr>
    
    <!--
    <tr>
    	<th>N�kyvyys</th>
    	<td>${ks.nakyvyys}</td> 
    </tr> -->
    
  </table>
</div>
<a class="btn btn-primary" href="../koulutuslistaus">Takaisin listaukseen</a>
<a id="muokkausPainike" type="button" class="btn btn-primary"  href="#test_modal" data-toggle="modal">Muokkaa</a>
<button class="btn btn-danger" data-toggle="modal" href="#peruutusModal">Peruuta Koulutus</button>
<br /><br />


<!-- Jos muokkaus onnistui, n�ytet��n k�ytt�j�lle teksti siit� -->
<c:if test="${muokkausOnnistui != null}">
	<p id="mop" class="text-success bg-success" style="padding: 30px; font-size: 2em;">
		<c:out value="${muokkausOnnistui}" />
	</p>
</c:if>

<!-- Modal-popup, jolla voidaan peruuttaa koulutus -->
<div id="peruutusModal" class="modal fade">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
    <div class="modal-header">
    	<h3><c:out value="${ks.aihe}" /></h3>
    </div>
    	<div class="modal-body">
      		Haluatko varmasti peruuttaa koulutuksen?
        </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">Sulje</button>
      <a href="peruutus/${ks.id}" class="btn btn-primary">Peruuta</a>
      </div>
    </div>
  </div>
</div>


<!-- Modal-popup, jolla voidaan muokata tietoja -->
<div class="modal fade" id="test_modal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      <h3><c:out value="${ks.aihe}" /></h3>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title"><c:out value="${ks.aikaslotti.pvm}" />, <c:out value="${ks.aikaslotti.alkukello}" />-<c:out value="${ks.aikaslotti.loppukello}" /></h4>
      </div>
       <form:form id="modal-form" modelAttribute="muokattavaKoulutus"  method="POST">
      <div class="modal-body">


           <table class="table">
      
        
			  <tr>
			  	<th><form:label path="aihe">Aihe</form:label></th>	 		  
			  	<td><form:input path="aihe" value="${ks.aihe}"/>  </td> 
			  	<td><form:errors path="aihe"></form:errors></td>
			  	
			  </tr>  
			  
			  <tr>
			  	<th><form:label path="kuvaus">Kuvaus</form:label></th>
			  	<td><form:textarea path="kuvaus" style="resize:none;" value="${ks.kuvaus}" cols="40" rows="5"/> </td>
			  	<td><form:errors path="kuvaus"></form:errors></td>
			  	
			  </tr>    
			  
			  <tr>
			    <th><form:label path="aikaslotti.pvm">P�iv�m��r�</form:label></th>
			  	<td><form:input path="aikaslotti.pvm" class="zDepth" id="datepicker" value="${ks.aikaslotti.pvm}"/> </td>
			  	<td><form:errors path="aikaslotti.pvm"></form:errors></td> 
			  </tr>
			  	
			  <tr> 
			  	<th><form:label path="aikaslotti.alkukello">Alkaa</form:label></th>
			  	<td><form:input path="aikaslotti.alkukello" class="timepicker zDepth" value="${ks.aikaslotti.alkukello}"/></td>
			  	<td><form:errors path="aikaslotti.alkukello"></form:errors></td> 
			  </tr>
			  	
			  	<tr>  	
					<th><form:label path="aikaslotti.loppukello">Loppuu</form:label></th>
			  		<td><form:input path="aikaslotti.loppukello" class="timepicker" value="${ks.aikaslotti.loppukello}"/> </td>    
			  		<td><form:errors path="aikaslotti.loppukello"></form:errors></td>
			  </tr>
			    
			    <tr>
			    	<th><form:label path="aikaslotti.koulutustila">Koulutustila</form:label></th>
			  	<td><form:input path="aikaslotti.koulutustila" value="${ks.aikaslotti.koulutustila}"/></td> 
			  	<td><form:errors path="aikaslotti.koulutustila"></form:errors></td>
			    </tr>
			    
			    <tr>
			    	<th><form:label path="lahtotaso">L�ht�taso</form:label></th>
			  	<td><form:input path="lahtotaso" value="${ks.lahtotaso}"/> </td>
			  	<td><form:errors path="lahtotaso"></form:errors></td>
			    </tr>
			    
			   <!--  <tr>
			    	<th><form:label path="nakyvyys">N�kyvyys</form:label></th>
			  		<td><form:input path="nakyvyys" value="${ks.nakyvyys}"/> </td> 
			  		<td><form:errors path="nakyvyys"></form:errors></td>
			    </tr> -->
			    
			    </table>
			    
		  
    
 
  
  			<div class="modal-footer">
			    <button type="button" class="btn btn-default" data-dismiss="modal">Sulje</button>
        	<button id="modal-form-submit2" type="submit" class="btn btn-primary">Tallenna muutokset</button>
        	 </div>
 	

      </div>
      </form:form> 
      	
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


</body>
</html>