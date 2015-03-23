import Text.CSV

main = do
  let fileName = "data/input.csv"
  input <- readFile fileName
  let csv = parseCSV fileName input
  either handleError doWork csv

handleError csv = print "not a CSV"

doWork csv = print $ filter (\row -> last row == "1") $ rows csv
rows csv = filter (\x -> length x == length (head csv)) $ tail csv
