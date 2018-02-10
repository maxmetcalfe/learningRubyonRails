/* global document */
/*eslint-disable no-unused-vars, no-undef */

function addLikelyRacersListener() {
    "use strict";
    var likelyTable = document.getElementById("likely-table");
    if (likelyTable) {
        likelyTable.addEventListener("click", function(event) {
            var row = likelyTable.rows[event.target.parentNode.rowIndex];
            var name = row.cells[0].textContent;
            var bib = row.cells[1].textContent;
            var racerField = document.getElementById("start_item_racer_id");
            racerField.value = name;
            var bibField = document.getElementById("start_item_bib");
            bibField.value = bib;
        });
    }
}

function runAutocompleteDance() {
  "use strict";
  var startItemRacerIdDiv = document.getElementById("start_item_racer_id");
  var startItemRacerIdHiddenDiv = document.getElementById("start_item_racer_id_hidden");
  if (startItemRacerIdDiv && startItemRacerIdHiddenDiv) {
    $("#start_item_racer_id").bind("railsAutocomplete.select", function(event, data){
      startItemRacerIdDiv.value = data.item.label;
      startItemRacerIdHiddenDiv.value = data.item.value;
    });
  }
}