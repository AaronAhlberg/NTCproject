<cfobject component="candidates" name="candidatesObj">
<cfinvoke component="#candidatesObj#" method="getCandidates" returnvariable="candidates">
<cfobject component="exam" name="examObj">
<cfinvoke component="#examObj#" method="getExams" returnvariable="exams">
<cfobject component="testingCenter" name="testingCenterObj">
<cfinvoke component="#testingCenterObj#" method="getTestingCenters" returnvariable="testingCenters">
<cfobject component="examSession" name="examSessionObj">
<cfinvoke component="#examSessionObj#" method="filterExamSessions" returnvariable="allSessions">
<cfobject component="appointments" name="appointmentsObj">
<cfinvoke component="#appointmentsObj#" method="getAppointments" returnvariable="appointments">
<cfform name="form" action= "#appointmentsObj.insertAppointment()#" method= "POST">
	<h1>
		Available Exams
	</h1>
	<select name="sessionList" size="10" required>
		<cfoutput query= allSessions>
			<cfset sessionInfo={sessionId= #sessionId# }>
			<cfset serialString= serializeJSON(#sessionInfo#)>
			<option value=#serialString#>
				#examName# #testDate# #startTime# #endTime# #city# #region#
			</option>
		</cfoutput>
	</select>
	</br>
	<p>
		To schedule an exam: select an option from above, select a candidate, press "Schedule".
	</p>
	<label>
		candidate:
	</label>
	<select name="name" default="">
		<cfoutput query="candidates">
			<cfset candidateInfo={name = "#name#", id= "#candidateId#"}>
			<cfset serialString= serializeJSON(#candidateInfo#)>
			<option value=#serialString#>
				#name#
			</option>
		</cfoutput>
	</select>
	<input type="Submit" value="Scheudule">
</cfform>
<cfform name="form">
	<h2>
		Filter Exams
	</h2>
	<p>
		Select an option to filter available exams above. Leave blank to see all options for that category.
	</p>
	<select name="examList">
		<option selected value="">
			-- filter by test --
		</option>
		<cfoutput query="exams">
			<cfset examInfo={name=#examName#, id=#examId#}>
			<cfset serialString= serializeJSON(#examInfo#)>
			<option value=#serialString#>
				#examName#
			</option>
		</cfoutput>
	</select>
	<select name="testingCenterList">
		<option selected >
			-- filter by testing center --
		</option>
		<cfoutput query="testingCenters">
			<cfset testingCenterInfo= {id= #centerId#}>
			<cfset serialString= serializeJSON(#testingCenterInfo#)>
			<option value=#serialString#>
				#centerName# #city#, #region#
			</option>
		</cfoutput>
	</select>
	<br>
	<br>
	<label>
	date available:
	<label>
	<br>
	<cfoutput>
		<cfinput type="date" name="startDate"
			value=#DateFormat(Now(),'yyyy-mm-dd')#>
		<cfinput type="date" name="endDate" value= #DateFormat(Now()+30,'yyyy-mm-dd')#>
	</cfoutput>
	<br>
	<input type="Submit" value="Apply">
</cfform>
<cfform>
	<h1>
		List of Scheduled Appointments
	</h1>
	<table style=>
		<tr>
			<th style="padding:20px">
				Apt ID
			</th>
			<th style="padding:20px">
				Date
			</th>
			<th style="padding:20px">
				Name
			</th>
			<th style="padding:20px">
				Site
			</th>
			<th style="padding:20px">
				Exam
			</th>
			<th style="padding:20px">
				Start
			</th>
			<th style="padding:20px">
				End
			</th>
			<th style="padding:20px">
				City
			</th>
			<th style="padding:20px">
				State
			</th>
		</tr>
		<cfoutput query="appointments">
			<tr>
				<td style="padding:20px">
					#appointmentId#
				</td>
				<td style="padding:20px">
					#testDate#
				</td>
				<td style="padding:20px">
					#name#
				</td>
				<td style="padding:20px">
					#centerName#
				</td>
				<td style="padding:20px">
					#examName#
				</td>
				<td style="padding:20px">
					#startTime#
				</td>
				<td style="padding:20px">
					#endTime#
				</td>
				<td style="padding:20px">
					#city#
				</td>
				<td style="padding:20px">
					#region#
				</td>
			</tr>
		</cfoutput>
	</table>
</cfform>
<style>
	table { font-family: arial, sans-serif; border-collapse: collapse; width: 80%; } td, th { border: 1px solid #dddddd; text-align: left; padding: 8px; } tr:nth-child(even) { background-color: #dddddd; }
</style>
