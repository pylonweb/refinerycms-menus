function moveSelectedPage(from, to) {
  $(from + ' option:selected').each(function(){
    $(this).detach();
    $(to).append($(this).attr('selected', null));
  });
  sortSelect(to);
}

function sortSelect(list){
  swapped = true
  
  while(swapped) {
    swapped = false
    options = $(list).children('option')
    options.each(function(i){
      if ( parseInt($(options[i]).attr('data-lft')) > parseInt($(options[i+1]).attr('data-lft')) ) {
        tmp = $(options[i]).detach();
        $(options[i+1]).after(tmp);
        swapped = true;
      }
    });
  }
}

function selectAll (list){
  $(list).children('option').each(function(){
    this.selected = true;
  });
}