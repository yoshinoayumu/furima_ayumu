window.addEventListener("DOMContentLoaded", () => {
  const path = location.pathname
  const pathRegex = /^(?=.*item)(?=.*edit)/
  if (path === "/items/new" || path === "/items" || pathRegex.test(path)) {
    //    出品ページの場合　||　出品ページの検証にかかった場合 || 商品編集の場合
    const priceInput = document.getElementById("item_price");
    console.log(priceInput)
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    priceInput.addEventListener("input", () => {
      const inputRegex = /^([1-9]\d*|0)$/
      const inputValue = document.getElementById("item_price").value;
      if (inputRegex.test(inputValue)) {
      //.test:文字列を正規表現でチェックする     https://www.sejuku.net/blog/58332
        addTaxDom.innerHTML = Math.floor(inputValue * 0.1).toLocaleString();
        profitDom.innerHTML = Math.floor(inputValue * 0.9).toLocaleString();
      } else {
        addTaxDom.innerHTML = '半角数字のみ入力可能'
        profitDom.innerHTML = '半角数字のみ入力可能'
      }
    })
  }
});