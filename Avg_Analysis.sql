Select a.*
Into Average_Analysis
From
(
Select z.*,
(case when z.Price_Diff <= 0.50*z.Avg_Price
  Then 'Emerging'
   Else 'Struggling'
   End) as Growth_Status
	from 
	 (Select y.*,
	   (Avg_Price-Cast_price) as Price_Diff, 
	   (case when y.Cast_price >= y.Avg_Price
		Then 'More'
		 Else 'Less'
		 End) as Cmp_AP
		 from
		  (
			Select x.Name, x.Symbol, x.Country, x.Cast_price, 
			avg(cast_price) over(partition by country) as Avg_Price
			from
			 (
			  Select *, CAST(CAST(price_usd as float) as numeric(10,2)) as Cast_price
				from Company_List
			 ) x
			) y
		)z
	Where z.Cmp_AP ='Less')a;

Select * from Average_Analysis