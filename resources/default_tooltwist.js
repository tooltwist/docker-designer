exports.config = {
	
	/*
	 *      Mode should be one of the following:
	 *        designer - Run the ToolTwist designer in standalone mode.
	 *
	 *        deploy - Generate, validate, and install the project to a
	 *                 remote location.
	 *
	 *        controller - Similar to deploy mode, but is compatible
	 *                 with the v8.2 Controller (i.e. it uses config
	 *                 files beneath /ContollerV8).
	 */
	"mode" : "designer",
	"version" : "8.5.0-SNAPSHOT",

	"designer" : {

		/*
		 *	The port where the Designer will run. (default is 5000)
		 */
		//"port": 8888,

		/*
		 *	This section defines the web design project we are working with. Access to
		 *	the Git repo should be available without login credentials (ie. via SSH).
		 *
		 *	Not required for controller mode.
		 */
		"name" : "ttdemo",
		"repo" : "https://github.com/tooltwist/ttdemo.git",
		"branch" : "master",

		/*
		 *	This section defines the repository used to find JAR files and other
		 *	dependencies required by your webdesign project. The dependencies
		 *	themselves are defined in project.json in the webdesign project.
		 */
		"resolve_contextUrl" : "http://repo.tooltwist.com/artifactory/",
		"resolve_repo" : "tooltwist-all-in-one",
		"repository_user": "",					// anonymous access.
		"repository_password": ""
		// "repository_user": "fred.smith",		// credentials from Artifactory.
		// "repository_password": "{DESede}xyxyxyxyxyxyxyxyxyxyxy=="

		// Example using ARTIFACTORY_USER and ARTIFACTORY_PASSWORD properties,
		// which can be defined system-wide in ~/.gradle/gradle.properties.
		/*
		"resolve_contextUrl" : "property.RESOLVE_CONTEXTURL",
		"resolve_repo" : "property.RESOLVE_REPO",
		"repository_user": "property.ARTIFACTORY_USER",
		"repository_password": "property.ARTIFACTORY_PASSWORD"
		*/
	}

};
