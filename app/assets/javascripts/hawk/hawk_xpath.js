
$(document).ready(function() {
  //To validate Xpath is valid or not
  $('.xpath_class').each(function(i,ele){
    var xpath = ele.value;
    if(xpath != "" && Hawk.getElementByXpath(xpath) == null)
      $('#' + ele.id.replace('hawker_xpath_','hawker_message_')).html('&nbsp;Invalid xpath');
  });
});

Hawk = {
  // XPath
  /**
   * Gets an XPath for an element which describes its hierarchical location.
   */
  getElementXPath : function(element) {
    if (element && element.id)
      return '//*[@id="' + element.id + '"]';
    else
      return Hawk.getElementTreeXPath(element);
  },

  getElementTreeXPath : function(element) {
    var paths = [];
    // Use nodeName (instead of localName) so namespace prefix is included (if any).
    for (; element && element.nodeType == 1; element = element.parentNode)
    {
      var index = 0;
      for (var sibling = element.previousSibling; sibling; sibling = sibling.previousSibling)
      {
        // Ignore document type declaration.
        if (sibling.nodeType == Node.DOCUMENT_TYPE_NODE)
          continue;

        if (sibling.nodeName == element.nodeName)
          ++index;
      }

      var tagName = element.nodeName.toLowerCase();
      var pathIndex = (index ? "[" + (index+1) + "]" : "");
      paths.splice(0, 0, tagName + pathIndex);
    }
    return paths.length ? "/" + paths.join("/") : null;
  },

  // This will create xpath and copy it to field.
    generateXpath : function(this_ele){
    var xpath_field_id = this_ele.id.replace('hawker_generate_','hawker_xpath_'),
    selection = document.getSelection();
    if(selection && (selection.anchorNode != null)) {
      var e = selection.anchorNode.parentNode,
        x_path = Hawk.getElementXPath(e);
      if(x_path.indexOf('hawker') == -1) {
        $("#" + xpath_field_id).val(x_path);
        $("#" + this_ele.id.replace('hawker_generate_','hawker_message_')).html('');
      }else {
        $("#" + this_ele.id.replace('hawker_generate_','hawker_message_')).html('&nbsp;Invalid selection');
      }
    }
  },

  // To add new row for Xpath selection.
  addXpathRow : function(){
    var curtime = new Date(),
    row_html = "";
    var new_row_id = "new_row_" + curtime.getHours() + "_" + curtime.getMinutes() + "_" + curtime.getSeconds() + "_" + curtime.getMilliseconds();
    row_html = row_html + "<tr id='xpath_tr_row_" + new_row_id + "'>";
    row_html = row_html + "<td><input type='text' class='xpath_targate_name' name='xpath["+ new_row_id + "][name]' value=''> </td>";
    row_html = row_html + "<td><input type='text' class='xpath_class' id='hawker_xpath_" + new_row_id + "' name='xpath["+ new_row_id + "][xpath]' value=''> </td>";
    row_html = row_html + "<td><input type='button' class='generate_xpath' onclick='Hawk.generateXpath(this);' value='Generate' id='hawker_generate_" + new_row_id + "'/><span class='xpath_message' id='hawker_message_" + new_row_id +"'></span></td>";
    row_html = row_html + "<td><div class='delete_hawker' onclick='Hawk.deleteXpath(\"xpath_tr_row_" + new_row_id + "\",\"\")'>&nbsp;</div></td>";
    row_html = row_html + "</tr>";

    $("#hawker_xpath_row_container").append(row_html);
  },

  // To get element via xpath.
  getElementByXpath : function (path) {
    return document.evaluate(path, document, null, 9, null).singleNodeValue;
  },

  deleteXpath : function(ele_id,path){
    if(confirm('Are you sure you want to delete this?'))
    {
      if(path != ""){
        $.ajax({
          url: path,
          // data: {id: id},
          success: function(res_text) {
            $("#" + ele_id).remove();
          },
          fail: function(res_text){
            alert("Something went wrong. Unable to delete");
          }
        });
      }else{
        $("#" + ele_id).remove();
      }
    }
  },

  validateBlankFields : function(){
    var class_name = ['.xpath_class', '.xpath_targate_name'],
      ret_val = true;
    for(var i= 0; i <= class_name.length; i++){
      $(class_name[i]).each(function(i,ele){
        if(ele.value == "")
          ret_val = false;
      });
    }
    if(!ret_val)
      alert("Please enter value in blank fields");
    return ret_val;
  },

  validateBlankUrl : function(){
    if($('#hawker_url').val() == ""){
      $('#hawker_error_explanation').html("<ul><li>Url can't be blank</li></ul>");
      return false;
    }
    return true;
  }
}
