<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType='text/html; charset=UTF-8' %>
<%@ taglib uri="/WEB-INF/MyTag.tld" prefix="l"%>
<!DOCTYPE html>
<html lang="ru">
	<head>
		<meta charset="UTF-8"/>
		<title>IT ROAD. Аккаунт</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="../css/account_style.css" type="text/css">
		<link rel="stylesheet" href="../css/menu.css" type="text/css">
		<link rel="stylesheet" href="../css/media.css" type="text/css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Cuprum&display=swap">
		<link rel="stylesheet" type="text/css" href="../css/modal_contact.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	</head>

	<body>
		<jsp:useBean id="vacancyDao" class="by.epam.ft.dao.VacancyDAO"  scope="session"/>

		<c:if test="${id==null}">
			<c:redirect url="/html/authorization.jsp"/>;
		</c:if>
		<jsp:include page="common/header.jsp" />
		<jsp:include page="common/confirmPopup.jsp" />

		<main class="content">

			<div class="title">
				<l:locale name="ahtitle"/>
			</div>
			<jsp:useBean id="hrDao" class="by.epam.ft.dao.HrDAO"/>
			<c:set var="Hr" value="${hrDao.showByAccountId(idAcc)}"/>
			<div>
			    <table class="info">
			    	<caption><l:locale name="ainfo"/></caption>
			    	<tr>
			    		<td width="50%"><l:locale name="ahuridhr"/></td>
			    		<td>${Hr.idHr}</td>
			    	</tr>
			    	<tr>
			    		<td><l:locale name="alogin"/></td>
			    		<td>${login}</td>
			    	</tr>
			    	<tr>
			    		<td><l:locale name="aname"/></td>
			    		<td>${name}</td>
			    	</tr>
			    	<tr>
			    		<td><l:locale name="asur"/></td>
			    		<td>${surname}</td>
			    	</tr>
			    	<tr>
			    		<td>Email</td>
			    		<td>
							${mail}
							<c:choose>
								<c:when test="${!isConfirmed}">
									<a type="button" class="red_text" href="#confirmPopup" id="confirmAccountBtn"><l:locale name="click_to_confirm_email" /></a>
								</c:when>
								<c:otherwise>
									<div class="green_text"><l:locale name="email_confirmed" /></div>
								</c:otherwise>
							</c:choose>
						</td>
			    	</tr>
			    	<tr>
			    		<td><l:locale name="abirthday"/></td>
			    		<td>${birthday}</td>
			    	</tr>
                    <tr>
                        <td><l:locale name="pass"/></td>
                        <td>**********</td>
                    </tr>
                    <tr>
                        <td colspan="2"><a type="button" style="margin: 2% auto" class="simple-btn" href="#confirmPopup" id="changeAccountInfo"><l:locale name="change_account_info"/></a></td>
                    </tr>
			    </table>

			    <jsp:useBean id="vacDao" class="by.epam.ft.dao.VacancyDAO"  scope="session" />
			    <jsp:useBean id="accountDao" class="by.epam.ft.dao.AccountDAO" />
			    <jsp:useBean id="selectionDao" class="by.epam.ft.dao.SelectionDAO" />
			    <c:set var="selectionList" value="${selectionDao.showAll()}"/>

				<%--BUTTON GO TO ANALYTICS--%>
				<div style="margin-bottom: 50px;">
					<a href="/html/controller?command=open_analytics" class="simple-btn"><l:locale name="go_to_analytics"/></a>
				</div>

			    <form method="post">
			    	<table class="vacancies">
			    		<caption><l:locale name="ahrequest"/></caption>
			    		<tr bgcolor="#225e83" style="color: white">
			    			<th><l:locale name="ahidrequest"/></th>
			    			<th><l:locale name="ahnamesurnamecand"/></th>
			    			<td><l:locale name="usermail"/></td>
			    			<th><l:locale name="avac"/></th>
			    			<th><l:locale name="vacstatus"/></th>
			    			<th><l:locale name="ahnamesurnamehr"/></th>
			    			<th><l:locale name="astatus"/></th>
			    			<th><l:locale name="aselectiondate"/></th>
			    			<th><l:locale name="aregistrationdate"/></th>
                            <th><l:locale name="mchange"/></th>
			    			<th><l:locale name="ahdelete"/></th>
			    		</tr>
                        <c:choose>
                            <c:when test="${filter_list != null}">
                                <c:set var="selectionList" value="${filter_list}"/>
                            </c:when>
                        </c:choose>
			    		<c:forEach var="item" items="${selectionList}">
			    			<c:set var="accountCandidate" value="${accountDao.showByIdUser(item.idCandidate, false)}"/>
			    			<c:set var="accountHR" value="${accountDao.showByIdUser(item.idHr, true)}"/>
			    			<tr id="selection_row_${item.idSelection}">
			    				<td>${item.idSelection}</td>
								<td><a href="#confirmPopup" id="showUserInfoBtn_${item.idSelection}">${accountCandidate.name} ${accountCandidate.surname}</a></td>
			    				<td>${accountCandidate.email}</td>
			    				<td>${vacDao.showById(item.idVacancy).name}</td>
			    				<c:choose>
			    					<c:when test="${vacancyDao.showById(item.idVacancy).status.equals('closed')}">
			    						<td bgcolor="#ffdab9">
			    							<l:locale name="closed"/>
			    						</td>
			    					</c:when>
			    					<c:otherwise>
			    						<td bgcolor="#afffaa">
			    							<l:locale name="opened"/>
			    						</td>
			    					</c:otherwise>
			    				</c:choose>
			    				<td>
			    					<c:set var="nameSurname" value="${accountHR.name} ${accountHR.surname}"/>
			    					<c:choose>
			    						<c:when test="${accountHR.name==null&&accountHR.surname==null}">
			    							<l:locale name="anohr"/>
			    						</c:when>
			    						<c:otherwise>
			    							<c:out value="${nameSurname}"/>
			    						</c:otherwise>
			    					</c:choose>
			    				</td>
			    				<td class="selectionStatus_table">${item.status}</td>
			    				<td class="selectionDate_table">
                                    <c:choose>
			    					    <c:when test="${item.selectionDate!=null}">
			    					    	<c:out value="${item.selectionDate}"/>
			    					    </c:when>
			    					    <c:otherwise>
			    					    	<c:out value="--"/>
			    					    </c:otherwise>
			    				    </c:choose>
                                </td>
			    				<td>
			    					<c:choose>
			    						<c:when test="${item.registrationDate!=null}">
			    							<c:out value="${item.registrationDate}"/>
			    						</c:when>
			    						<c:otherwise>
			    							<c:out value="--"/>
			    						</c:otherwise>
			    					</c:choose>
			    				</td>
                                <td>
                                    <a type="button" href='#changeSelectionForm' id="changeBtn_${item.idSelection}" class="simple-btn">
                                        <l:locale name="mchange"/>
                                    </a>
                                </td>
			    				<td>
									<a type="button" class="simple-btn" href="#confirmPopup" id="deleteBtn_${item.idSelection}"><l:locale name="arevoke"/></a>
			    				</td>
								<td style="display: none" id="hidden_resume_${item.idSelection}">${accountDao.showByIdUser(item.idCandidate, false).resume}</td>
			    			</tr>
			    		</c:forEach>
			    	</table>
			    </form>

			    <!-- Модальное окно фильтрации-->
			    <a href="#x" class="overlay" id="filterForm"></a>
			    <div class="popup">
			    	<a class="close" title="<l:locale name="ahclose"/>" href="#close"></a>
			    	<div class="ipopup">
			    		<form>
			    			<h1><l:locale name="afilter"/></h1>
			    			<p><l:locale name="ahnamesurnamehr"/></p>
			    			<input type="text" class="inputp" name="hr_name" />
			    			<p><l:locale name="ahnamesurnamecand"/></p>
			    			<input type="text" class="inputp" name="candidate_name"/>
			    			<p><l:locale name="astatus"/></p>
			    			<input type="text" name="status" class="inputp"/>
			    			<p><l:locale name="ahnvacname"/></p>
			    			<input type="text" name="vacancy_name" class="inputp"/>
			    			<p><l:locale name="aselectiondate"/></p>
			    			<input type="date" name="selection_date" class="date"/>
			    			<p><l:locale name="aregistrationdate"/></p>
			    			<input type="date" name="registration_date" class="date"/>
			    			<input type="submit" formaction="/html/controller?command=open_account" class="show-btn" formmethod="post" value="<l:locale name="aconfirm"/>"/>
			    		</form>
			    	</div>
			    </div>
			    <a type="button" href='#filterForm' class="show-btn"><l:locale name="afilter"/></a>

			    <!-- Модальное окно изменения -->
			    <a href="#x" class="overlay" id="changeSelectionForm"></a>
			    <div class="popup">
			    	<a class="close" title="<l:locale name="ahclose"/>" href="#close"></a>
			    	<div class="ipopup">
			    		<form>
			    			<h1><l:locale name="mchangerequest"/></h1>
			    			<p><l:locale name="mnumberrequest"/></p>
			    			<input type="text" class="inputp" name="idSelection" id="idSelection_change" required readonly/>
			    			<p>ID HR</p>
			    			<input type="text" class="inputp" name="idHr" id="idHr_change" placeholder="<l:locale name="murid"/> ${Hr.idHr}"/>
			    			<p><l:locale name="astatus"/></p>
			    			<select name="status" class="status" id="selectionStatus_change">
			    				<option value="Заявка на рассмотрении" selected><l:locale name="mreqconsid"/></option>
			    				<option value="Ожидание собеседования"><l:locale name="mwaiting"/></option>
			    				<option value="Не прошел собеседование"><l:locale name="mnotpass"/></option>
			    				<option value="Прошел собеседование"><l:locale name="mpass"/></option>
			    			</select>
			    			<p id="selectionDateLabel_change"><l:locale name="aselectiondate"/></p>
			    			<input type="date" name="selectionDate" class="date" id="selectionDateInput_change"/>
			    			<input type="submit" formaction="/html/controller?command=change_selection" class="show-btn" formmethod="post" value="<l:locale name="aconfirm"/>"/>
			    		</form>
			    	</div>
			    </div>

				<form action="/html/controller?command=change_password" name = "vform" method="post">
					<div class="password_change">
						<h2><l:locale name="achangepass"/></h2>
						<p><l:locale name="aoldpass"/></p>
						<input type="password" name="oldpass" class="field" required/>
						<p><l:locale name="anewpass"/></p>
						<input type="password" name="password" class="field" required/>
						<p><l:locale name="arepeatpass"/></p>
						<input type="password" name="repeat_password" class="field" required/>
						</p>
						<input type="submit" id="registration" value="<l:locale name="aconfirm"/>" class="confirm_change"/>
					</div>
				</form>
			</div>
		</main>
		<jsp:include page="common/footer.jsp" />
	</body>

    <script type="text/javascript" src="../js/popup_generator.js"></script>
	<script type="text/javascript" src = "../js/back_security.js"></script>
	<script type="text/javascript" src = "../js/change_password_script.js"></script>
    <script>
        $(document).ready(function () {

            $("#changeAccountInfo").on('click', function () {
                removeDefaultFields();

                addLabelWithInput("p_name_label", "p_name_input", "name");
                $("#p_name_label")[0].innerText = "<l:locale name="aname"/>";
                $("#p_name_input")[0].value = "${name}";

                addLabelWithInput("p_surname_label", "p_surname_input", "surname");
                $("#p_surname_label")[0].innerText = "<l:locale name="asur"/>";
                $("#p_surname_input")[0].value = "${surname}";

                addLabelWithInput("p_email_label", "p_email_input", "email");
                $("#p_email_label")[0].innerText = "Email";
                $("#p_email_input")[0].value = "${mail}";

                var popup_confirm = "popup_confirm";
                addConfirmButton(popup_confirm);
                $("#" + popup_confirm).attr("formaction",
                    "/html/controller?command=update_account&id=${accountDao.showIdAccountByLogin(login)}");
                $("#" + popup_confirm).value="<l:locale name="aconfirm"/>";
            });

            //Подстановка значения id заявки при изменении значения
            <c:forEach items="${selectionList}" var="selection">
                $("#changeBtn_${selection.idSelection}").on('click', function () {
                    $("#idSelection_change").attr("value", "${selection.idSelection}");
                    $("#idHr_change").attr("value", "${selection.idHr != 0 ? selection.idHr : ""}");
					fillTheFields(${selection.idSelection});
					var status = $("#selection_row_${selection.idSelection} > .selectionStatus_table")[0].innerText;
					$("#selectionStatus_change")[0].value = status;
					checkStatusPicker();
                });

				$("#showUserInfoBtn_${selection.idSelection}").on('click', function () {
					removeDefaultFields();

					<c:set var="account" value="${accountDao.showByIdUser(selectionDao.showById(selection.idSelection).idCandidate, false)}" />
					addLabel("p_login");
					addLabel("p_name");
					addLabel("p_surname");
					addLabel("p_birthday");
					addLabel("p_email");
					addLabelWithTextarea("p_resume", "p_textarea_resume", "resume");


					$("#p_login")[0].innerText = "<l:locale name="alogin"/>: ${account.login}";
					$("#p_name")[0].innerText = "<l:locale name="aname"/>: ${account.name}";
					$("#p_surname")[0].innerText = "<l:locale name="asur"/>: ${account.surname}";
					$("#p_birthday")[0].innerText = "<l:locale name="abirthday"/>: ${account.birthday}";
					$("#p_email")[0].innerText = "Email: ${account.email}";
					$("#p_resume")[0].innerText = "<l:locale name="aresume"/>:";
					$("#p_textarea_resume")[0].innerHTML = $("#hidden_resume_${selection.idSelection}")[0].innerText
						!= "undefined" ? $("#hidden_resume_${selection.idSelection}")[0].innerText : "";
					$("#p_textarea_resume").attr("readonly", "readonly");
				});

				$("#deleteBtn_${selection.idSelection}").on('click', function () {
					removeDefaultFields();
					addDefaultFields();
					$("#popup_title")[0].innerText = "<l:locale name="confirm_action"/>";
					$("#popup_text")[0].innerText = "<l:locale name="deleting_request"/> ${selection.idSelection}?";

					var popup_confirm = "popup_confirm";
					addConfirmButton(popup_confirm);
					$("#popup_confirm").attr("formaction", "/html/controller?command=revoke_vacancy&idSelection=${selection.idSelection}");
					$("#" + popup_confirm)[0].value="<l:locale name="aconfirm"/>";
				});
            </c:forEach>

			$("#confirmAccountBtn").on('click', function () {
				removeDefaultFields();
				addDefaultFields();
				$("#popup_title")[0].innerText = "<l:locale name="confirm_action"/>";
				$("#popup_text")[0].innerText = "<l:locale name="send_confirmation_email"/>";
				$("#popup_small_text")[0].innerText = "<l:locale name="if_message_not_received"/>";

                var popup_confirm = "popup_confirm";
                addConfirmButton(popup_confirm);
				$("#popup_confirm").attr("formaction",
						"/html/controller?command=send_request_confirm_account&email=${mail}&id=${accountDao.showByIdUser(Hr.idHr, true).idAccount}");
				$("#" + popup_confirm)[0].value="<l:locale name="aconfirm"/>";
			});

            $("#selectionStatus_change").on('change', function () {
                fillTheFields($("#idSelection_change")[0].value);
                checkStatusPicker()
            });

            function fillTheFields(idSelection) {
                var date = $("#selection_row_" + idSelection + " > .selectionDate_table")[0].innerText;
                $("#selectionDateInput_change").attr("value", date);
            }

            function checkStatusPicker() {
                switch ($("#selectionStatus_change")[0].value) {
                    case "Заявка на рассмотрении": {
                        $("#selectionDateInput_change").hide();
                        $("#selectionDateLabel_change").hide();
                        break;
                    }
                    case "Ожидание собеседования": {
                        $("#selectionDateInput_change").show();
                        $("#selectionDateLabel_change").show();
                        break;
                    }
                    case "Не прошел собеседование": {
                        $("#selectionDateInput_change").hide();
                        $("#selectionDateLabel_change").hide();
                        break;
                    }
                    case "Прошел собеседование": {
                        $("#selectionDateInput_change").hide();
                        $("#selectionDateLabel_change").hide();
                    }
                }
            }
        })
    </script>
</html>