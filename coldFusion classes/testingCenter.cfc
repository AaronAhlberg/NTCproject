<cfcomponent>
	<cffunction name="getTestingCenters" access="remote">
		<cfset var testCenterQuery="">
		<cfquery name="testCenterQuery" datasource="ntcDatabase">
		SELECT * FROM testing_center
		</cfquery>
		<cfreturn testCenterQuery>
	</cffunction>
</cfcomponent>
