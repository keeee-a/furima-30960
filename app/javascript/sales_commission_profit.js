function salesCommissionAndSalesProfit() {
  const ItemYen = document.getElementById("item-price")
  const addTaxPrice = document.getElementById("add-tax-price")
  const profit = document.getElementById("profit")
  ItemYen.addEventListener('change', function(){
  addTaxPrice.innerHTML = Math.floor(ItemYen.value * 0.1)
  profit.innerHTML = ItemYen.value - addTaxPrice.innerHTML
  })

}

window.addEventListener('load', salesCommissionAndSalesProfit)