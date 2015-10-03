function ResourceLoader(baseurl) {
	this.BASEURL = baseurl;
}

ResourceLoader.prototype.loadResource = function(resource, callback) {
	var self = this;
	evaluateScripts([resource], function(success) {
		if(success) {
			var resource = Template.call(self);
			callback.call(self, resource);
		} else {
			var title = "Resource Loader Error",
			    description = `Error loading resource '${resource}'. \n\n Try again later.`,
			    alert = createAlert(title, description);
			navigationDocument.presentModal(alert);
		}
	});
}