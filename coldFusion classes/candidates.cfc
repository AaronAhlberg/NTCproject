<cfcomponent>
	<cffunction name="getCandidates" access="remote">
		<cfset var canQuery="">
		<cfquery name="canQuery" datasource="ntcDatabase">
		SELECT * FROM candidate
		</cfquery>
		<cfreturn canQuery>
	</cffunction>
</cfcomponent>
