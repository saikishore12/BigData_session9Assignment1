distributer_details = LOAD 'petrol_details.txt' USING PigStorage(',') AS (district_id:chararray, distributer_name:chararray, buy_rate:chararray,sell_rate:chararray,volumeIN:int,volumeOUT:int,year:int);
distributer_details_volume = FOREACH distributer_details generate district_id, volumeIN;
distributer_desc_order = ORDER distributer_details_volume by volumeIN desc;
top_ten_distributer_ids= limit distributer_desc_order 10;
dump top_ten_distributer_ids;