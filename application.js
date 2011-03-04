var pricingScheme = new PricingScheme();
var settings = new Settings();
var duckFamilyAmount = 5;
var duckFlockAmount = 10;
var duckOodleAmount = 20;
function PricingScheme() {
  var pricings = [];
  this.addPricing = function(quantity,price) {
    pricings.push([quantity,price]);
  };
  this.addPricings = function(array) {
    pricings = array;
  };
  this.getPricings = function() {
    return pricings;
  }
}
function Settings() {
    var duckInventory;
    this.setInventoryCount = function(count) {
        duckInventory = count;
    }
    this.getInventoryCount = function() {
        return duckInventory;
    }
}
function updateTotal(input) {
    var duckCount = $(input).val();
    $("#duck-form-total").text(duck_price(duckCount));

    //if more than one duck
    if(duckCount > 1 || duckCount == 0) {
        //pluralize word "duck"
        $("#duck-count").text("ducks")
    }else{
        $("#duck-count").text("duck")
    }
    if(duckCount != 0 && (duckCount <= settings.getInventoryCount() || !settings.getInventoryCount())) {
        $('#adoption_submit').removeAttr("disabled");
        $("#adoption_submit").addClass('blue-button');
        $("#adoption_submit").removeClass('blue-button-disabled');
    }else {
        $('#adoption_submit').attr("disabled", "disabled");
        $("#adoption_submit").addClass('blue-button-disabled');
        $("#adoption_submit").removeClass('blue-button');
    }
}
var keyCodes = [ 37, 38, 39, 40, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 8, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105 ];			   
$(document).ready(function() {
    var input = $("#adoption_duck_count");
	//$('#adoption_submit').attr("disabled", "disabled");
    if (!input.val) {
        input.val(0);
    }
	input.focus(function() {
		if(input.val() == 0) {		
			input.val('');
		}
	});
	input.blur(function() {
		if(input.val() == '') {
			input.val(0);
		}						
	});
	input.numeric();	
	input.keyup(function(event) {		
		updateTotal(this);
	});
    $('#family-button').click(function() {
        var amount = duckFamilyAmount;        
        input.val(amount);
        updateTotal(input);
    });
    $('#flock-button').click(function() {
        var amount = duckFlockAmount;
        input.val(amount);
        updateTotal(input);
    });
    $('#oodle-button').click(function() {
        var amount = duckOodleAmount;
        input.val(amount);
        updateTotal(input);
    })
});
function duck_price(duckCount) {
  var index=0;
  var not_true = true;
  var pricing;
  var pricings = pricingScheme.getPricings();
  var price;
  if(pricings.length > 0) {
	  while(not_true) {
	    pricing = pricings[index];
	    if(pricing) {	
	      if(duckCount > pricing['quantity']) {
	        not_true = false;
	      }
	      index++;
            }else{
             not_true = false;
            }
	  }
	  if(!pricing) {
	    pricing = pricings[pricings.length-1]
	  }
  	  price = pricing['price']*duckCount
  } else {
    price = duckCount*50;
  } 
  return 'Total: $'+(price/100).toFixed(2);
}

