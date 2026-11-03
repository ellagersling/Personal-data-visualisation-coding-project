// Personal data visualisation: weekly sleep bar chart
// Bar height = average hours of sleep. Bar colour = average sleep score (red = low, green = high).

// Settings
// Variables that sit outside setup() and draw() so every function can use them.
// Keeping the numbers up here means they only need changing in one place.

Table sleepData;           // holds the whole CSV file (one row per week)

int leftMargin = 60;       // empty space on the left of the window
int bottomMargin = 80;     // empty space at the bottom (room for the week numbers)
int barWidth = 80;         // width of each bar in pixels
int barSpacing = 40;       // gap between bars in pixels
float maxBarHeight = 400;  // height in pixels of the tallest possible bar

float minHours = 4;        // sleep hours shown at the bottom of the y axis
float maxHours = 9;        // sleep hours shown at the top of the y axis
float minScore = 60;       // sleep score that gets the fully red colour
float maxScore = 90;       // sleep score that gets the fully green colour

float baseline;            // y position of the line the bars sit on (set in setup)
color badSleep;            // colour for a low sleep score (set in setup)
color goodSleep;           // colour for a high sleep score (set in setup)


// SETUP: runs once when you press Run 
void setup() {
  size(800, 600);

  // The bars sit on a line near the bottom of the window
  baseline = height - bottomMargin;

  // The colours are created here because color() can't be used before setup() runs
  badSleep = color(255, 80, 80);
  goodSleep = color(80, 200, 120);

  // CSV from the data folder. "header" means row 1 holds the column names
  sleepData = loadTable("sleep_data.csv", "header");

  // loadTable() gives back null if the file can't be found
  if (sleepData == null) {
    println("Couldn't load sleep_data.csv. Check it is inside the data folder.");
  } else {
    println("Rows loaded: " + sleepData.getRowCount());
  }
}


// DRAW: runs over and over, redrawing the chart 
void draw() {
  background(255);

  // Stops here if the data didn't load, so i don't get more errors.
  if (sleepData == null) {
    return;
  }

  // Centre align all text and make the size 14 pixels
  textAlign(CENTER);
  textSize(14);

  // Go through the table one row (one week) at a time.
  // i counts the rows: 0 for the first week, 1 for the second, and so on.
  for (int i = 0; i < sleepData.getRowCount(); i++) {
    TableRow row = sleepData.getRow(i);

    // Read this week's values. The text in quotes matches the CSV column names exactly.
    int week = row.getInt("week");
    float hours = row.getFloat("avg_sleep_hours");
    float score = row.getFloat("avg_sleep_score");

    // Where this bar goes. Each bar sits one (bar width + gap) further right than the last
    float x = leftMargin + i * (barWidth + barSpacing);

    // map() rescales hours (4 to 9) into a bar height in pixels (0 to 400).
    // The bar's top edge is the baseline minus its height, because y gets bigger going down.
    float barHeight = map(hours, minHours, maxHours, 0, maxBarHeight);
    float y = baseline - barHeight;

    // map() rescales the score (60 to 90) into 0 to 1. constrain() keeps it inside that range.
    // lerpColor() then blends between red (0) and green (1) by that amount.
    float colorAmount = constrain(map(score, minScore, maxScore, 0, 1), 0, 1);
    color barColor = lerpColor(badSleep, goodSleep, colorAmount);

    // Draw the bar.
    noStroke();
    fill(barColor);
    rect(x, y, barWidth, barHeight);

    // Labels in black: the week number under the bar and the sleep score above it.
    // int(score) drops the decimal, and str(week) turns the number into text.
    fill(0);
    text(str(week), x + barWidth / 2, baseline + 25);
    text("Score: " + int(score), x + barWidth / 2, y - 10);
  }

  drawAxes();
  drawColourKey();
}


// AXES: the two lines, the hour numbers and the axis titles 
void drawAxes() {
  // The y axis sits just left of the first bar. The x axis ends just past the last bar.
  float axisX = leftMargin - 15;
  float axisRight = leftMargin + sleepData.getRowCount() * (barWidth + barSpacing) - barSpacing + 20;

  // The two axis lines.
  stroke(0);
  strokeWeight(1);
  line(axisX, baseline, axisRight, baseline);
  line(axisX, baseline - maxBarHeight, axisX, baseline);

  // A 'tick' mark and number for each whole hour. map() puts each one at the same
  // height a bar of that many hours would reach.
  fill(0);
  textAlign(RIGHT);
  textSize(12);
  for (int h = int(minHours); h <= int(maxHours); h++) {
    float tickY = baseline - map(h, minHours, maxHours, 0, maxBarHeight);
    line(axisX - 5, tickY, axisX, tickY);
    text(str(h), axisX - 8, tickY + 4);
  }

  // Axis titles. The y axis title is turned a quarter turn so it reads upwards.
  // pushMatrix() and popMatrix() make sure the turn only affects this one piece of text.
  textAlign(CENTER);
  textSize(14);
  pushMatrix();
  translate(15, baseline - maxBarHeight / 2);
  rotate(-HALF_PI);
  text("Average sleep duration (hours)", 0, 0);
  popMatrix();
  text("Week", (axisX + axisRight) / 2, baseline + 55);

  noStroke();
}


// COLOUR KEY: explains what the bar colours mean 
void drawColourKey() {
  fill(0);
  textAlign(CENTER);
  textSize(12);
  text("Sleep quality", 700, 125);
  text("(score)", 700, 140);

  // A strip made of 200 thin lines, each a slightly different blend from green to red.
  for (int i = 0; i < 200; i++) {
    stroke(lerpColor(goodSleep, badSleep, i / 199.0));
    line(690, 150 + i, 710, 150 + i);
  }
  noStroke();

  // Labels at each end of the strip, using the same numbers the bar colours are based on.
  fill(0);
  textAlign(LEFT);
  text(int(maxScore) + " - good", 717, 158);
  text(int(minScore) + " - poor", 717, 350);
}
