//
//  NotificationManager.swift
//  CountryVisited
//
//  Created by Muhammad Hamza Khalil on 16/12/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    static func scheduleMemoryReminder(for memory: CountryMemory) {
        let content = UNMutableNotificationContent()
        content.title = "Memory of \(memory.country)"
        content.body = memory.description
        content.sound = .default

        // Trigger after a delay (e.g., 5 seconds for testing)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: memory.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}
