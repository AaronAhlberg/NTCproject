<cfcomponent>
	<cffunction name="getExams" access="remote">
		<cfset var examQuery="">
		<cfquery name="examQuery" datasource="ntcDatabase">
		SELECT * FROM exam
		</cfquery>
		<cfreturn examQuery>
	</cffunction>
</cfcomponent>
