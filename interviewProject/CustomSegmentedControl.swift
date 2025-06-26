//
//  CustomSegmentedControl.swift
//  interviewProject
//
//  Created by hamza yasin on 20/06/2025.
//

import SwiftUI
import UIKit

struct CustomSegmentedControl: UIViewRepresentable {
    @Binding var selectedIndex: Int
    var titles: [String]

    func makeUIView(context: Context) -> UISegmentedControl {
        let control = UISegmentedControl(items: titles)
        
        control.setTitleTextAttributes([
            .foregroundColor: UIColor.white
        ], for: .normal)
        
        control.setTitleTextAttributes([
            .foregroundColor: UIColor.black
        ], for: .selected)
        
        control.selectedSegmentTintColor = .white
        
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateSelectedIndex(sender:)),
            for: .valueChanged
        )
        
        return control
    }

    func updateUIView(_ uiView: UISegmentedControl, context: Context) {
        uiView.selectedSegmentIndex = selectedIndex
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: CustomSegmentedControl

        init(_ parent: CustomSegmentedControl) {
            self.parent = parent
        }

        @objc func updateSelectedIndex(sender: UISegmentedControl) {
            parent.selectedIndex = sender.selectedSegmentIndex
        }
    }
} 

