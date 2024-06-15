# SleepCalc

SleepCalc is a SwiftUI app designed to help you calculate your ideal bedtime based on your desired wake-up time, the amount of sleep you want, and your daily coffee intake. This project demonstrates the integration of CoreML for making sleep-related predictions.

### Disclaimer
> **This app is a mockup. The CoreML data used in this app should not be used for health decisions. Always consult a professional for health-related advice.**

## Overview

SleepCalc allows users to input their desired wake-up time, the number of hours they want to sleep, and their daily coffee intake. The app then uses a CoreML model to predict the optimal bedtime to achieve the desired amount of sleep.

## Features

-  **Wake-up Time Input**: Select the time you want to wake up using a DatePicker.
-  **Sleep Amount Input**: Choose your desired amount of sleep using a Stepper.
-  **Coffee Intake Input**: Log the number of cups of coffee you drink per day using a Stepper.
-  **Bedtime Calculation**: Calculate and display the ideal bedtime based on the inputs using a CoreML model.

## Installation

1. **Clone the repository**
    ```shell
    git clone https://github.com/austinbond11/sleepcalc.git
    ```

2. **Open the project in Xcode**
    ```shell
    cd sleepcalc
    open SleepCalc.xcodeproj
    ```

3. **Run the app**
    - Select the desired device or simulator.
    - Press `Cmd + R` to build and run the app.

## Usage

1. **Select your desired wake-up time**.
2. **Adjust the amount of sleep you want** using the Stepper control.
3. **Log your daily coffee intake** using the Stepper control.
4. **Press the Calculate button**. The app will display your optimal bedtime in an alert.

## Built With

-  Swift
-  SwiftUI
-  CoreML

## Author

-  **Created by**: Austin Bond
