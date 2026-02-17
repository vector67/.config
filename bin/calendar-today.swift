#!/usr/bin/env swift
// calendar-today.swift — outputs today's calendar events as a markdown table
// Used by the `morning` script

import EventKit
import Foundation

let store = EKEventStore()
let semaphore = DispatchSemaphore(value: 0)
store.requestFullAccessToEvents { _, _ in
    semaphore.signal()
}
semaphore.wait()

let cal = Calendar.current
let start = cal.startOfDay(for: Date())
let end = cal.date(byAdding: .day, value: 1, to: start)!
let predicate = store.predicateForEvents(withStart: start, end: end, calendars: nil)
let events = store.events(matching: predicate)

if events.isEmpty {
    exit(0)
}

let formatter = DateFormatter()
formatter.dateFormat = "HH:mm"

// Deduplicate by title + time
var seen = Set<String>()
for event in events {
    let title = event.title ?? "?"
    let startStr = event.isAllDay ? "All day" : formatter.string(from: event.startDate)
    let endStr = event.isAllDay ? "" : formatter.string(from: event.endDate)
    let calTitle = event.calendar.title ?? "?"

    let key = "\(title)|\(startStr)|\(endStr)"
    guard !seen.contains(key) else { continue }
    seen.insert(key)

    print("| \(title) | \(startStr) | \(endStr) | \(calTitle) |")
}
