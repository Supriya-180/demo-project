jQuery(document).ready(function($){
  $(document).on('change', '.variant_select', function(evt) {
    var variant_id = $(this).val()
    ind = $(this).attr('id').split("attributes")[1].split("_")[1]

    return $.ajax('/admin/variants/' + variant_id + '/get_variant_attributes', 
      {
        type: 'GET',
        dataType: 'html',
        error: function(jqXHR, textStatus, errorThrown) {
    
          return console.log("AJAX Error: " + textStatus);
        },
        success: function(data, textStatus, jqXHR) {
          $(`select#product_product_variants_attributes_${ind}_variant_attribute_id.variantP option`).remove();
          var row = "<option value=\"" + "" + "\">" + "Variant attribute" + "</option>";
          $(row).appendTo(`select#product_product_variants_attributes_${ind}_variant_attribute_id.variantP option`);
          data = JSON.parse(data)
          $.each(data['variant_attributes'], function(i, j) {
            row = "<option value=\"" + j.id + "\">" + j.name + "</option>";
            $(row).appendTo(`select#product_product_variants_attributes_${ind}_variant_attribute_id.variantP`);
          });
        }
      });
  });
});