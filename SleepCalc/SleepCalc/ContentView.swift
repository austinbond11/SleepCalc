//
//  ContentView.swift
//  SleepCalc
//
//  Created by Austin Bond on 6/13/24.
//
import CoreML
import SwiftUI

// Define the main view of the application
struct ContentView: View {
    
    // State variables to store user inputs and app status
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    // State variables to handle alert presentation
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    // Static property to provide a default wake-up time of 7:00 AM
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    // The body property defines the content and layout of the view
    var body: some View {
        // NavigationStack for a navigation-based interface
        NavigationStack {
            // ScrollView to make the content scrollable
            ScrollView {
                VStack(alignment: .leading) {
                    // Section for wake-up time input
                    VStack(alignment: .leading, spacing: 16) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden() // Hide default labels of DatePicker
                    }
                    // Style the section
                    .padding()
                    .background(Color.white.opacity(0.7).cornerRadius(10).shadow(radius: 5))
                    .padding()
                    
                    // Section for desired amount of sleep input
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        // Stepper to increase/decrease sleep amount in intervals of 0.25 hours
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    // Style the section
                    .padding()
                    .background(Color.white.opacity(0.7).cornerRadius(10).shadow(radius: 5))
                    .padding()
                    
                    // Section for daily coffee intake input
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Daily coffee intake")
                            .font(.headline)
                        // Stepper to increase/decrease the number of coffee cups
                        Stepper("^[\(coffeeAmount) cup](inflect:true)", value: $coffeeAmount, in: 0...20)
                    }
                    // Style the section
                    .padding()
                    .background(Color.white.opacity(0.7).cornerRadius(10).shadow(radius: 5))
                    .padding()
                    
                }
            }
            // Set navigation title
            .navigationTitle("SleepCalc")
            // Toolbar with a Calculate button
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            // Present an alert based on `showingAlert` state
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    // Function to calculate the ideal bedtime
    func calculateBedtime() {
        do {
            // Load the CoreML model
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            // Get the hours and minutes from the wake-up time
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60  // Convert hours to seconds
            let minute = (components.minute ?? 0) * 60   // Convert minutes to seconds
            
            // Make a prediction using the model based on wake time, sleep amount, and coffee intake
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            // Calculate the time to go to bed
            let sleepTime = wakeUp - prediction.actualSleep
            
            // Update the alert title and message with the calculated bedtime
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            // Handle any errors during prediction
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        // Show the alert
        showingAlert = true
    }
}

// Preview provider for SwiftUI previews in Xcode
#Preview {
    ContentView()
}
