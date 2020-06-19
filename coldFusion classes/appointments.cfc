<cfcomponent>

	<cffunction name="getAppointments" access="remote">
		<cfset var aptQuery="">
		<cfquery name="aptQuery" datasource="ntcDatabase">
		select * from appointments a
				join exam_session es on a.sessionId = es.sessionId
				join testing_center t on es.centerId = t.centerId
		        join exam ex on es.examId = ex.examId
		        join candidate c on a.candidateId = c.candidateId;
		</cfquery>
		<cfreturn aptQuery>
	</cffunction>

	<cffunction name="insertAppointment" access="remote">
		<cfif IsDefined("FORM.sessionList")
		and IsDefined("Form.name")>
			<cfset sessionInfo= deserializeJSON(#FORM.sessionList#)>
			<cfoutput>			<label>"#FORM.name#"</label></cfoutput>
			<cfset candidateInfo= DeserializeJSON(#FORM.name#)>
			<cfquery name="canQuery" datasource="ntcDatabase">
			insert into appointments (candidateId, sessionId) values(#candidateInfo.id#,#sessionInfo.sessionId#)
			</cfquery>
			<cflocation url="Home.cfm" addToken="false" />
		</cfif>
	</cffunction>


</cfcomponent>
