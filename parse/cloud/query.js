exports.query = function() {
	
	var mysqlLike = function(regex, startpos){
	
	 var indexOf = this.substring(startpos || 0).search(regex);
    return (indexOf >= 0) ? (indexOf + (startpos || 0)) : indexOf;
	
	}

}

