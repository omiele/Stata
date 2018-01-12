** This is a stata analysis of airline data which seeked to find out the trend for bookings done within a given airline and
* trend for the given transctions within the booking portal. The data can be obtained from 
* https://www.dropbox.com/s/6yzk7szzqppuhrg/airline3_data_updated_analysis_JOYCEE.dta?dl=0

** DATA PREPARATION
destring selected_fare, replace force ignore(" ")
destring max_fare, replace force ignore(" ")
destring min_fare, replace force ignore(" ")
destring selected_ratio_to_cheapest, replace force ignore(" ")
destring transaction_count, replace force ignore(" ")
destring availability_traveller_count, replace force ignore(" ")
destring rank_of_selection, replace force ignore(" ")
destring booking_insurance, replace force ignore(" ")
destring booking_hotel, replace force ignore(" ")
destring booking_car, replace force ignore(" ")
destring error_number, replace force ignore(" ")
destring distinct_servlets_count, replace force ignore(" ")
destring availability_advance_purchase, replace force ignore(" ")
destring availability_traveller_count, replace force ignore(" ")
destring response_time, replace force ignore(" ")


** DESCRIPTIVES FOR DIFFERENT VARIABLES
summarize transaction_count selected_fare error_number distinct_servlets_count booking_hotel booking_insurance booking_car
histogram transaction_count
histogram distinct_servlets_count

** ANALYSIS OF ADVANCE PURCHASES, TRANSACTION COUNT AND TRAVELLERS IN DIFFERENT CITY PAIRS
tabstat transaction_count availability_traveller_count availability_advance_purchase, statistics( mean ) by(citypair) columns(variables)

** ANALYSIS OF ADVANCE PURCHASES, TRANSACTION COUNT AND TRAVELLERS IN DIFFERENT DESTINATIONCITY AND ORIGINCITY
tabstat transaction_count availability_traveller_count availability_advance_purchase, statistics( mean ) by(destinationcity) columns(variables)
tabstat transaction_count availability_traveller_count availability_advance_purchase, statistics( mean ) by(origincity) columns(variables)

** STUDYING CUSTOMER BEHAVIOR THROUGH CORRELATION
correlate transaction_count availability_traveller_count
correlate transaction_count availability_advance_purchase
correlate availability_traveller_count availability_advance_purchase

** PERFORMANCE OF THE WEBSITE
tabstat distinct_servlets_count, statistics( mean ) by(day) columns(variables)
tabulate next_transaction_servlet
tabstat response_time, statistics( mean ) by(day) columns(variables)

** STUDY OF BOOKINGS WITH REGARDS TO DAYS
tabstat transaction_count availability_traveller_count availability_advance_purchase, statistics( mean ) by(day) columns(variables)
