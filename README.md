# Shiny, hover labels quickly disappear with ggplot output

![](images/shiny_ggplot_hover_values_disappear_1.png)

Solution requires an initial, non-reactive ggplot object, 
   an initial reactive plot output object,
   and an observeEvent for the hover item, this triggers 
   a graph update with the hover as well as text info dialog updates
     
 2017-01-07 in response to Google Groups thread by Jannik Vindelov 
Response from Stephen McDaniel at PowerTrip Analytics
Program: app.R 
   Data: mtcars

License: MIT License
Attribution, package authors for shiny and ggplot2 on CRAN.

## 🎉 About YakData

[YakData](https://yakdata.com/) is an agile forecasting firm delivering critical-path forecasts for new products, product acquisition, ad growth and sales force expansion to scale and grow your business. 

We build strategic forecasts for your business based on modern, advanced analytic languages and modular data stacks that are quick to develop and share with key stakeholders in your business.

[Successful projects](https://yakdata.com/success) have included forecasting new customer revenue by marketing channel at a leading subscription business, planning a 9-figure acquisition and investment decision at a leading biotech company, optimizing online ad-spend at a leading billion-dollar retailer, building mix-model multi-channel marketing forecasts at a multi-billion dollar video platform and estimating customer lifetime value in real-time at a leading online streaming business.

When you [hire YakData](https://yakdata.com/pricing/), our principals perform the majority of your high-value project work. Our primary mission is to be your trusted confidante as you make critical business investments and decisions. We deliver results that are presentation-ready for executive teams, boards of directors and key investors.

