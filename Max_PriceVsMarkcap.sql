WITH MaxPr as -- Grouped max price by contry
   (
	Select x.Country, Max(x.Cast_Price) as Max_price
	From 
		( Select *, cast(cast(price_usd as float) as numeric(10,2)) as Cast_Price
		  From Company_list) x
	Group by Country
    ),
	MaxMC as -- Grouped max Market Capital by contry
	(
	Select x.Country, Max(x.Cast_MktCap) as Max_MarketCap
    From 
		( Select *, cast(cast(Marketcap as float) as numeric(20,2)) as Cast_MktCap
	      From Company_list) x
	Group by Country
	), 
	Join_PrMC as -- Join of CTE1 & CTE2
	(
	 Select MaxPr.Country, Max_Price, Max_MarketCap From MaxPr Join MaxMC on MaxPr.Country= MaxMC.Country
	)
Insert Into [dbo].[Max_PriceMarkCap]
(Country, Max_Price, Max_MarketCapital)

Select * from Join_PrMC;
-- End
Select * from [dbo].[Max_PriceMarkCap];
