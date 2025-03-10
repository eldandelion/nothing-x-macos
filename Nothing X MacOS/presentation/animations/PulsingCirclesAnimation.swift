//
//  PulsingCirclesAnimation.swift
//  Nothing X MacOS
//
//  Created by Daniel on 2025/3/10.
//

import Foundation
import SwiftUI
class PulsingCirclesAnimation : ObservableObject {
    static let shared = PulsingCirclesAnimation()
    
    private init() {}
    
    @Published var scale: CGFloat = 1.0 // Initial scale for the first circle
    @Published var opacity: Double = 1.0 // Initial opacity for the first circle
    @Published var isRunning = true
    private var animationWorkItem: DispatchWorkItem?
    private var secondCircleWorkItem: DispatchWorkItem?
    
    @Published private var isAnimating: Bool = false
    private var animationQueue: DispatchQueue = DispatchQueue(label: "animationQueue")
    @Published var showSecondCircle: Bool = false // State variable to control the visibility of the
    @Published var secondCircleScale: CGFloat = 1.0 // Initial scale for the second circle
    @Published var secondCircleOpacity: Double = 0.0 // Initial opacity for the second circle

    
    
    func startAnimation() {
        
        guard isRunning else { return }
        
        // Check if already animating
        if isAnimating {
            return // Prevent starting a new animation if one is already running
        }
        
        isAnimating = true // Set the animation state to true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showSecondCircle = true // Show the second circle
            self.startSecondCircleAnimation() // Start the animation for the second circle
        }
        // Animate to scale 3 and fade out
        withAnimation(.easeOut(duration: 1.0)) {
            scale = 3.0
            opacity = 0.0
        }
   
        // Create a new work item for the reset task
        animationWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            // Check if the animation should continue
            guard isRunning else {
                DispatchQueue.main.async {
                    self.isAnimating = false // Reset animation state
                }
                return
            }
            
            // Reset to original scale and opacity
            DispatchQueue.main.async {
                self.scale = 1.0
                self.opacity = 1.0
                self.isAnimating = false // Reset animation state
                // Call the function again to create a loop
                self.startAnimation()
            }
        }
        
        // Delay to allow the scale and fade out to complete
        animationQueue.asyncAfter(deadline: .now() + 1.0, execute: animationWorkItem!)
    }
    
    private func startSecondCircleAnimation() {
        guard isRunning else { return }
        
        // Cancel any existing second circle animation work item
        secondCircleWorkItem?.cancel()
        
        // Create a new work item for the second circle animation
        secondCircleWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            // Ensure that the animation updates are performed on the main thread
            DispatchQueue.main.async {
                // Animate the second circle to scale 3 and fade out
                withAnimation(.easeOut(duration: 1)) {
                    self.secondCircleScale = 3.0
                    self.secondCircleOpacity = 0.0
                }
                
                // Delay to allow the scale and fade in to complete
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    // Reset the second circle to original scale and opacity
                    self.secondCircleScale = 1.0
                    self.secondCircleOpacity = 1.0
                }
            }
        }
        
        // Execute the second circle work item on the main queue
        DispatchQueue.main.async(execute: secondCircleWorkItem!)
    }
    
    func stopAnimation() {
        isRunning = false // Set the running flag to false
        // Optionally reset the animation state immediately
        animationWorkItem?.cancel() // Cancel any pending animation work
        animationWorkItem = nil // Clean up the work item
        secondCircleWorkItem?.cancel() // Cancel any pending second circle animation work
        secondCircleWorkItem = nil // Clean up the second circle work item
        
        // Optionally reset the animation state immediately
        scale = 1.0
        opacity = 1.0
        secondCircleScale = 1.0
        secondCircleOpacity = 1.0
        showSecondCircle = false // Hide the second circle
        isAnimating = false
    }
}
