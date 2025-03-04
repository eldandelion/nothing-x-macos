//
//  JsonEncoder.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/2/25.
//

import Foundation



class JsonEncoder {
    private let fileName: String
    private var devices: [String: NothingDeviceDTO] = [:] // Hashmap for MAC to device entity
    
    static let shared = JsonEncoder(fileName: "configurations")
    
    private init(fileName: String) {
        self.fileName = fileName
        loadDevices()
    }
    
    // Load devices from the JSON file
    private func loadDevices() {
        let decoder = JSONDecoder()
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Document directory not found.")
            return
        }
        
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).json")
        
        // Check if the file exists
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            // Create an empty JSON file
            createEmptyJsonFile(at: fileURL)
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let loadedDevices = try decoder.decode([NothingDeviceDTO].self, from: data)
            devices = Dictionary(uniqueKeysWithValues: loadedDevices.map { ($0.bluetoothDetails.mac, $0) }) // Convert to hashmap
        } catch {
            print("Error loading devices: \(error)")
        }
    }
    
    // Create an empty JSON file
    private func createEmptyJsonFile(at url: URL) {
        do {
            let emptyData = Data() // Empty data to write
            try emptyData.write(to: url) // Create the file
            print("Created empty JSON file at \(url.path)")
        } catch {
            print("Error creating empty JSON file: \(error)")
        }
    }
    
    // Save devices to the JSON file
    private func saveDevices() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(Array(devices.values)) // Encode values of the hashmap
            let fileURL = getFileURL()
            try jsonData.write(to: fileURL)
            print("Devices saved to \(fileURL.path)")
        } catch {
            print("Error saving devices: \(error)")
        }
    }
    
    // Add or update a device
    func addOrUpdateDevice(_ device: NothingDeviceDTO) {
        devices[device.bluetoothDetails.mac] = device // Add or update the device
        saveDevices()
    }
    
    // Delete a device by MAC address
    func deleteDevice(mac: String) {
        devices.removeValue(forKey: mac) // Remove the device from the hashmap
        saveDevices()
    }
    
    // Retrieve all devices
    func getAllDevices() -> [NothingDeviceDTO] {
        return Array(devices.values) // Return values as an array
    }
    
    // Helper function to get the file URL
    private func getFileURL() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("\(fileName).json")
    }
}
