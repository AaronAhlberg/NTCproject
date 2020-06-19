<cfcomponent>
	<cffunction name="getExamSessions" access="remote" output="No">
		<cfset var sessionQuery="">
		<cfquery name="sessionQuery" datasource="ntcDatabase">
		select * from exam_session
		join exam on exam_session.examId = exam.examId
		join testing_center on exam_session.centerId = testing_center.centerId;
		</cfquery>
		<cfreturn sessionQuery>
	</cffunction>

	<cffunction name="filterExamSessions" access="remote" output="No">
		<cfset var sessionQuery="">
		<cfif IsDefined("FORM.startDate")>
			<cfset startDate= #Form.startDate#>
		<cfelse>
			<cfset startDate= '0000-00-00'>
			>
		</cfif>
		<cfif IsDefined("FORM.endDate")>
			<cfset endDate= #Form.endDate#>
		<cfelse>
			<cfset endDate= '9999-00-00'>
		</cfif>
		<cftry>
			<cfset examInfo= deserializeJSON(#FORM.examList#)>
			<cfcatch>
				<cfset examInfo= {id= "%", name= "%"}>
			</cfcatch>
		</cftry>
		<cftry>
			<cfset testingCenterInfo= deserializeJSON(#FORM.testingCenterList#)>
			<cfcatch>
				<cfset testingCenterInfo= {id= "%"}>
			</cfcatch>
		</cftry>
		<cfquery name="sessionQuery" datasource="ntcDatabase">
			select es.sessionId, es.testDate, es.startTime, es.endTime, e.examId, e.examName, t.centerId, t.centerName, t.addressline1, t.city, t.region, t.phone from exam_session es
			join exam e on es.examId = e.examId
			join testing_center t on es.centerId = t.centerId
			where e.examId like "#examInfo.id#"
			and t.centerId like "#testingCenterInfo.id#"
			and (es.testDate between '#startDate#' and '#endDate#');
		</cfquery>
		<cfreturn sessionQuery>
	</cffunction>

</cfcomponent>
