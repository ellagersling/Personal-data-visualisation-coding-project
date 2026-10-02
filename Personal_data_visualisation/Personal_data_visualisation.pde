 // These are called "global variables" because they sit outside setup()
// and draw(), which means both functions can see and use them.
// Keeping layout numbers like these up here (instead of buried in the
// drawing code) makes them easy to find and adjust later.

// How much empty space to leave on the left side of the window.
// Useful later if you add a y-axis with numbers down the side.
int leftMargin = 60;

// How much empty space to leave at the bottom of the window.
// This is where the "Week 6" label sits, below the bar itself.
int bottomMargin = 80;

// How wide each bar is, in pixels.
int barWidth = 80;
 
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

// create a rectangle/coloured bar graph to showcase week 6 sleep, green colour to represent good end of sleep scale
void draw() {
  background(255);

  if (sleepData == null) {
    return;
  }

  // findRow(value, columnName) searches the table and returns the first row where that column matches. Here i'm asking for the row where "week" 
  //equals "6". It has to be given as text, even though week is a number, which is why it's "6" in quotes.
  TableRow week6 = sleepData.findRow("6", "week");

  // Read this one row's values, exactly like done in the loop before.
  float hours = week6.getFloat("avg_sleep_hours");
  float score = week6.getFloat("avg_sleep_score");

  // Work out the bar's height from hours, same as before.
  float barHeight = map(hours, 4, 9, 0, 400);
  float baseline = height - bottomMargin;
  float y = baseline - barHeight;

  // Work out the bar's colour from score, same as before.
  float colorAmount = map(score, 0, 100, 0, 1);
  color badSleep = color(255, 80, 80);
  color goodSleep = color(80, 200, 120);
  color barColor = lerpColor(badSleep, goodSleep, colorAmount);

  // Draw just this one bar, at a fixed x position since there's only one.
  fill(barColor);
  noStroke();
  rect(leftMargin, y, barWidth, barHeight);
}
