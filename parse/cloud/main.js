Parse.Cloud.define("getMedia", function(request, response) {
	
  var query = new Parse.Query("Media");
  //query.equalTo("Picture", "type");
  query.find({
    success: function(results) {
		
		var objects = [];
		
		for (var i = 0; i < results.length; ++i) {
		
		var media = {};
        media = {
		  caption:results[i].get("caption"),
		  category:results[i].get("category"),
		  location:results[i].get("location")
		  };
		  
		  objects.push(media);
    
		}
      response.success(objects);
    },
    error: function() {
      response.error("caption not retrieved");
    }
  });
  
});

