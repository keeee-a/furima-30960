function salesCommission() {
  const ItemYen = document.getElementById("item-price")
  console.log(ItemYen)
  const addTaxPrice = document.getElementById("add-tax-price")
  console.log(addTaxPrice)
  console.log(ItemYen.innerHTML)
  ItemYen.addEventListener('change', function(){
    console.log(ItemYen.value)
  addTaxPrice.innerHTML = ItemYen.value * 0.1
  })

}

window.addEventListener('load', salesCommission)