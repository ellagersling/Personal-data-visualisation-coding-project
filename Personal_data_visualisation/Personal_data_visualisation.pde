 // personal data visualisation step 1: import my CSV sleep data and ensure it loads correctly

 //import table into processing
 //this line creates empty variable called sleepData, that will hold the CSV
 //sits outside setup so the whole sketch can use it later (when drawing visualisations)
Table sleepData;

 // setup() is a function Processing runs once, when you press Run.
void setup() {

 // size of sketch window, width and height
  size(800, 600);

 // loadTable() opens a CSV file and stores its contents in a Table.
 // "header" tells it the first row holds column names, not data.
  sleepData = loadTable("sleep_data.csv", "header");

 // If Processing couldn't find the file, loadTable() gives back null (meaning "nothing").
 // This check stops the sketch and shows a helpful message instead of a confusing error.
  if (sleepData == null) {

 // println() prints text to the black console at the bottom of Processing.
    println("Couldn't load sleep_data.csv. Check it is inside the data folder.");

    // return exits setup() early, so the rest of the code doesn't run.
    return;
  }

  // getRowCount() counts how many rows of data the table has (not including the header).
  // The + joins text and the number together into one message.
  println("Rows loaded: " + sleepData.getRowCount());

  // This is a for loop. It repeats the code inside the curly brackets once for every row.
  // Each time round, the variable row holds the current row.
  // rows() gives us all the rows in the table.
  for (TableRow row : sleepData.rows()) {

  // getInt() reads a whole number from a column, using the column name from the CSV.
    int week = row.getInt("week");

  // getFloat() reads a number that can have decimals (like 7.25).
  // The text in quotes must match the CSV column name exactly.
    float hours = row.getFloat("avg_sleep_hours");
    float hrv = row.getFloat("avg_hrv");
    float score = row.getFloat("avg_sleep_score");

   // Print this row's values to the console so we can check the data loaded correctly.
    println("Week " + week + ": " + hours + " hrs, HRV " + hrv + " ms, score " + score);
  }
}
