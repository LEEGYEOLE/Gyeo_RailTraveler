<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<c:forEach var="vo" items="${listReplyAnswer}">
    <div class='answer' style='padding: 0px 10px;'>
        <div style='clear:both; padding: 10px 0px;'>
            <div style='float: left; width: 5%;'>└</div>
            <div style='float: left; width:95%;'>

                <div style='float: left;'><b>${vo.userName}</b></div>
                <div style='float: right;'>
                
               <c:choose>
            		<c:when test="${vo.deleted !=1}">
            			<span>${vo.created}</span> |
                    <c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">
                    	<span class='deleteReplyAnswer' style='cursor: pointer;' data-replyNum='${vo.replyNum}' data-answer='${vo.answer}'>삭제</span>
                    </c:if>
                    <c:if test="${sessionScope.member.userId!=vo.userId && sessionScope.member.userId!='admin'}">
                    	<span style="cursor: pointer;" class="notifyReply" onclick="replySingo('${vo.replyNum}');"
                    	data-replyNum='${vo.replyNum}'
						data-page='${pageNo}'>신고</span>
                    </c:if>
            		</c:when>          	
            	</c:choose>
                </div>
            </div>
        </div>
        <div style='clear:both; padding: 5px 5px 5px 5%; border-bottom: 1px solid #ccc;'>
            <c:choose>
	           	<c:when test="${vo.deleted ==1 && vo.deleteId =='admin'}">
	           	운영자에 의해 삭제된 리플입니다.
	           	</c:when>
	           	
	           	<c:when test="${vo.deleted ==1 && vo.deleteId !='admin'}">
	           	삭제된 리플입니다.
	           	</c:when>
	           
	           <c:otherwise>
	           ${vo.content}
	           </c:otherwise>
	           
	           </c:choose>               
        </div>
    </div>			            
</c:forEach>