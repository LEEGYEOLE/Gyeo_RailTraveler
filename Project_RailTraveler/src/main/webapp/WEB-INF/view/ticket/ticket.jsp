<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>




<link rel="stylesheet"
	href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css"type="text/css">
<script type="text/javascript"src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript"src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
 <script type="text/javascript" src="libs/angular/angular.js"></script>
 <script type="text/javascript" src="libs/angular/angular-animate.js"></script>
<style>
.form-control[readonly] {
	cursor: pointer;
	background: white;
	text-align: center;
}


</style>

<script type="text/javascript">


//date객체 YYYY-MM-DD 변환함수
function dateToYYYYMMDD(date){
    function pad(num) {
        num = num + '';
        return num.length < 2 ? '0' + num : num;
    }
    return date.getFullYear() + '-' + pad(date.getMonth()+1) + '-' + pad(date.getDate());
}


$(function() {

	var ticketday;
    var cnt= false;
	$("#secondperson").hide();
	
    $("input[name=jb-radio]").change(function() {
    	ticketday=0;
  	  //라디오 값 가져오기
        var radioVal = $('input[name="jb-radio"]:checked').val();
        
        //일수와 가격을 나누기
        var value = radioVal.split("-"); 
        	
        	ticketNum = value[0];
        	ticketday=value[1];
        	tprice = value[2];
        	
        	
        	tName = value[3];
        	
			$("#ticketprice").val(tprice);		
			$("#ticketNum").val(ticketNum);		
			
			$("#aaa").text("선택한 티켓 : 코레일 티켓 "+tName);
			$("#bbb").text("티켓 가격 : "+tprice+"원");
			
			if(ticketNum==4 ||ticketNum==5||ticketNum==6){
				$("#secondperson").show();
			}else if(ticketNum==1 ||ticketNum==2||ticketNum==3){
				$("#secondperson").hide();
			}
  		});
	
	

    
	$("#startdatepicker").datepicker(
			{   minDate: 0,
				onSelect : function(dateText) {

					if(! $('input[name="jb-radio"]').is(":checked")){
						 $("#modalPush").modal();
						return;
					}
					
					var split = dateText.split("-");  
					var year =split[0];
					var month = split[1];
					var day = split[2];
					
					var period = parseInt(ticketday)-1;
					
					var edate = new Date(year,month-1,day);
																			
					edate.setDate(edate.getDate() + period); //ticketday일 더하여 setting								
					var e= dateToYYYYMMDD(edate);
															
					$( "#enddatepicker" ).val(e);
					
					
					$("#sdate").val(dateText);		
					$("#edate").val(e);	
					

				}
			});
	

});
	

 

 </script>
<script type="text/javascript">
function paymemberOk() {
	var f = document.payInfoForm;
	var str;
	
	if(! $('input[name="jb-radio"]').is(":checked")){
		$("#modaltext").text("티켓을 선택해주세요!");
		 $("#modalPush").modal();
		return;
	}
	 
	if($("#sdate").val()==-1){
		$("#modaltext").text("시작 날짜를 선택해주세요!");
		$("#modalPush").modal();
		return;
	}

	
    str = f.userName.value;
	str = str.trim();
    if(!str) {
        alert("이름을 입력하세요. ");
        f.userName.focus();
        return;
    }
    f.userName.value = str;

   
    
    str = f.tel1.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel1.focus();
        return;
    }

    str = f.tel2.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel2.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.tel2.focus();
        return;
    }

    str = f.tel3.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel3.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.tel3.focus();
        return;
    }
    
    str = f.email.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.email.focus();
        return;
    }
	
    if(ticketNum==4 ||ticketNum==5||ticketNum==6){
    	str = f.userName2.value;
    	str = str.trim();
        if(!str) {
            alert("2P의 이름을 입력하세요. ");
            f.userName2.focus();
            return;
        }
        f.userName2.value = str;
        
                   
        str = f.email2.value;
    	str = str.trim();
        if(!str) {
            alert("2P의 이메일을 입력하세요. ");
            f.email2.focus();
            return;
        }
        
        str = f.tel12.value;
    	str = str.trim();
        if(!str) {
            alert("2P의 전화번호를 입력하세요. ");
            f.tel12.focus();
            return;
        }
        
        if(!/^(\d+)$/.test(str)) {
            alert("숫자만 가능합니다. ");
            f.tel12.focus();
            return;
        }

        str = f.tel22.value;
    	str = str.trim();
        if(!str) {
            alert("2P의 전화번호를 입력하세요. ");
            f.tel22.focus();
            return;
        }
        if(!/^(\d+)$/.test(str)) {
            alert("숫자만 가능합니다. ");
            f.tel22.focus();
            return;
        }

        str = f.tel32.value;
    	str = str.trim();
        if(!str) {
            alert("2P의 전화번호를 입력하세요. ");
            f.tel32.focus();
            return;
        }
        if(!/^(\d+)$/.test(str)) {
            alert("숫자만 가능합니다. ");
            f.tel32.focus();
            return;
        }

              
       
	}


 	f.action = "<%=cp%>/ticket/purchaseticket";

		f.submit();
	}
</script>

<div class="body-content-container container tim-container"
	style="max-width: 1200px; padding-top: 50px">

	<div class="page-three-title mt40">
		<div class="box1" style="width: 100%; border: 2px solid #eeeeee">
			<!--상단 메뉴-->
			<div style="margin-top: 20px">
				<div style="width: 93%; margin-top: 10px;">
					<h3 align="center">코레일 티켓 발권하기</h3>
				</div>
			</div>
		</div>
	</div>



	<div>
		<div style="widows: 100%">
			<table
            style="width: 100%; height: 40%; border-spacing: 10px; border-collapse: separate;">
		
            <tr height="100px">
            <c:forEach var="vo" items="${list}">
               <td><img style="max-width: 100%; height: auto;"
                  src="<%=cp%>/resource/img/ticket${vo.ticketNum}.jpg" /></td>
            </c:forEach>
            </tr>
          

            <tr>
            <c:forEach var="vo" items="${list}">
					<td align="center"><input type="radio" value="${vo.ticketNum}-${vo.tDays}-${vo.tprice}-${vo.tName}" name="jb-radio" 
					id="jb-radio-${vo.ticketNum}"></td>			
				</c:forEach>
            </tr>
         </table>
		</div>

		<div style="padding-bottom: 50px; width: 50%; margin: 20px auto;">
			<div class="form-group" style="margin: 15px 0; float: left">
				<p
					style="text-align: center; font-weight: 600; margin-bottom: 5px; color: #334393;">시작
					날짜</p>
				<div class="input-group">

					<input type="text" class="form-control" type="text" name="birth"
						id="startdatepicker" value="" placeholder="시작 날짜를 선택해주세요" readonly="readonly">
				</div>
			</div>


			<div class="form-group" style="margin: 15px 0; float: right">
				<p
					style="text-align: center; font-weight: 600; margin-bottom: 5px; color: #334393;">마지막
					날짜</p>
				<div class="input-group">

					<input type="text" class="form-control" type="text" name="birth"
						id="enddatepicker" placeholder="마지막 날짜" value="" readonly="readonly">
				</div>
			</div>
		</div>

		<div>
			<!--선택 정보-->

			<div class="box1"
				style="padding-right: 10px; float: left; width: 45%; margin-bottom: 100px">
				<h3 align="left" style="margin-top: 30px">선택정보</h3>
				<div class="box1"
					style="width: 100%; border: 1px solid #eeeeee; margin: 10px auto;">

					<div class="col"
						style="font-size: 18px; font-weight: 600; margin-top: 10px; margin-left: 10px">
						<p id="aaa">티켓을 선택해주세요</p>

						<p id="bbb"></p>
					</div>
				</div>

				<div class="box1"
					style="width: 100%; height: 200px; border: 1px solid #eeeeee; margin: 10px auto;">
					<img style="width: 100%; height: 100%;"
						src="<%=cp%>/resource/img/adver.jpg" />

				</div>

			</div>

			<!--구매자 정보-->
			<div class="box1"
				style="padding-left: 10px; float: right; width: 55%;">
				<h3 align="left" style="margin-top: 30px">결제 정보</h3>
				<div class="box1"
					style="margin: 10px auto; width: 100%; border: 1px solid #eeeeee; ">



					<form class="form-horizontal" name="payInfoForm" method="post">

					<div>
						<div class="form-group" style="margin: 30px auto;">
							<label for="inputinputName" class="col-sm-2 control-label">Name</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="userName"
									name="userName" value="${dto.userName}" style="width: 90%">
							</div>
						</div>


						<div class="form-group" style="margin: 30px auto;">
							<label for="inputEmail3" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="email" name="email"
									value="${dto.email}" style="width: 90%">
							</div>
						</div>
						
					
						<div class="form-group" style="margin: 30px auto;"
							style="float: left">
							<label for="inputEmail3" class="col-sm-2 control-label">Tel</label>

							<div style="float: left; padding-left: 15px;">
								<input type="tel" class="form-control" id="tel1" name="tel1"
									value="${dto.tel1}" style="width: 100px">
							</div>
							<div style="float: left; margin: 0px 10px;">_</div>
							<div class="" style="float: left">
								<input type="tel" class="form-control" id="tel2" name="tel2"
									value="${dto.tel2}" style="width: 142px">
							</div>

							<div style="float: left; margin: 0px 10px;">_</div>
							<div class="" style="float: left">
								<input type="tel" class="form-control" id="tel3" name="tel3"
									value="${dto.tel3}"  style="width: 142px">
								</div>
							</div>
						</div>
						
						
					<div id="secondperson">
						
						<div class="form-group" style="margin: 30px auto;">
						
							<label for="inputinputName" class="col-sm-2 control-label">2P.Name</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="userName2"
									name="userName2" placeholder="두번째 사람의 이름" style="width: 90%">
							</div>
						</div>


						<div class="form-group" style="margin: 30px auto;">
							<label for="inputEmail3" class="col-sm-2 control-label">2P.Email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="email2" name="email2"
									placeholder="두번째 사람의 이메일" style="width: 90%">
							</div>
						</div>
						
					
						<div class="form-group" style="margin: 30px auto;"
							style="float: left">
							<label for="inputEmail3" class="col-sm-2 control-label">2P.Tel</label>

							<div style="float: left; padding-left: 15px;">
								<input type="tel" class="form-control" id="tel12" name="tel12"
									style="width: 100px">
							</div>
							<div style="float: left; margin: 0px 10px;">_</div>
							<div class="" style="float: left">
								<input type="tel" class="form-control" id="tel22" name="tel22"
									 style="width: 142px">
							</div>

							<div style="float: left; margin: 0px 10px;">_</div>
							<div class="" style="float: left">
								<input type="tel" class="form-control" id="tel32" name="tel32"
									  style="width: 142px">
								</div>
							</div>
						</div>
						
						
						
						
						
						<input type="hidden"  id="ticketprice" value="0" name="tprice"> 
						<input type="hidden"  id="ticketNum"  name="ticketNum">
						
					<input type="hidden"  id="sdate" value="-1" name="sDate"> 
					<input type="hidden"  id="edate" value="" name="eDate"> 

						<div class="form-group">
							<div align="center">
								<button type="button" class="btn" onclick="paymemberOk();">
									결제하기</button>

							</div>
						</div>
					</form>
				</div>

			</div>

		</div>
	</div>
</div>



  
<!--Modal: modalPush-->
<div class="modal fade  bd-example-modal-sm" id="modalPush" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
  aria-hidden="true">
  <div class="modal-dialog modal-sm" role="document" style="width: 490px;">
    <!--Content-->
    <div class="modal-content text-center">
      <!--Header-->
      <div class="modal-header d-flex justify-content-center">
        <p class="heading" style="font-size:25px;font-weight: 700">Rail Traveler</p>
      </div>

      <!--Body-->
      <div class="modal-body" style="padding: 5px 5px;">
        <i class="fas fa-bell fa-3x animated rotateIn mb-3"></i>

        <p id="modaltext" style="font-size: 17px; font-weight:500; margin-top: 10px;">티켓을 먼저 선택해 주세요!</p>

      </div>

      <!--Footer-->
      <div class="modal-footer flex-center" style="margin-top: 5px;">
        <a type="button" class="btn  btn-info waves-effect" data-dismiss="modal">Yes</a>
      </div>
    </div>
  </div>
</div>
<!--Modal: modalPush-->


