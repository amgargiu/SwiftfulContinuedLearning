//
//  LocalNotificationsView.swift
//  SwiftfulContinuedLearning
//
//  Created by Antonio Gargiulo on 12/9/25.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
   
    
    static let instance: NotificationManager = NotificationManager() //Singleton
    
    //Request permission from user
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error requesting notification permission: \(error)")
            } else {
                print("success!")
            }
            
        }
    }
    
    
    func scheduleNotification() {
        
        //creating the notification content
        let content = UNMutableNotificationContent()
        content.title = "this is my first notification"
        content.subtitle = "this was easy"
        content.sound = .default
        content.badge = 1
        
        //trigers:
        
        // (1) time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
       
        // (2) calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 17 // in military time
//        dateComponents.minute = 29
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        
        
        // (3) location
        
        let centerCoordinates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        let region = CLCircularRegion(
            center: centerCoordinates,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnExit = true
        region.notifyOnEntry = false
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        
        
        
        
        //actually schedule and request a notification
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()

    }
    
    
}



struct LocalNotificationsView: View {
    var body: some View {
        
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel notifications") {
                NotificationManager.instance.cancelNotifications()
            }
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
    }
}

#Preview {
    LocalNotificationsView()
}
