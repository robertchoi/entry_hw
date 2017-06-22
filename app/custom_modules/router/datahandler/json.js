'use strict';
function JsonHandler(id) {
	this.data = {
		version: 0x01,
		network: 0x00,
		protocol: 'json'
	};
	
	var data = this.data;
	var str = id.slice(0, 2); // company id
	data.company = parseInt(str, 16) & 0xff;
	str = id.slice(2, 4); // model id
	data.model = parseInt(str, 16) & 0xff;
	str = id.slice(4, 6); // variation id
	data.variation = parseInt(str, 16) & 0xff;
}

JsonHandler.prototype.encode = function() {
	if(this.data) {
		return JSON.stringify(this.data);
	}
};

JsonHandler.prototype.decode = function(data) { // data: array buffer
	try {
		this.data = JSON.parse(data);
	} catch (e) {
	}
};

JsonHandler.prototype.e = function(key) {
	var data = this.data;
	if(data) {
		var value = data[key];
		if(value != undefined) {
			return true;
		}
	}
	return false;
};

JsonHandler.prototype.read = function(key) {
	var data = this.data;
	if(data) {
		var value = data[key];
		if(value != undefined) {
			return value;
		}
	}
	return 0;
};

JsonHandler.prototype.write = function(key, value) {
	var data = this.data;
	if(data) {
		data[key] = value;
		return true;
	}
	return false;
};

module.exports.create = function(id) {
	return new JsonHandler(id);
};