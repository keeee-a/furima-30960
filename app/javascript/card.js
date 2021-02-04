const pay = () => {
  Payjp.setPublicKey("pk_test_e6c9aa3e52aec2ac62474e7a");
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
    const card = {
      number: formData.get("card-number"),
      card_exp_month: formData.get("card-exp-month"),
      card_exp_year: `20${formData.get("card-exp-year")}`,
      cvc: formData.get("card-cvc")
    };
    console.log(card)
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        console.log(token)
      }
    });
  });

};

window.addEventListener("load", pay);