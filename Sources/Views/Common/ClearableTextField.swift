//
//  ClearableTextField.swift
//  GitY
//
//  Created by Sergey on 09.03.2026.
//

import Foundation
import SwiftUI

struct ClearableTextField: View {
    
    let placeholder: String
    @Binding var text: String
    
    // Optional parameters
    var promptSymbol: String? = nil
    var height: CGFloat = 36
    var cornerRadius: CGFloat = 16
    var backgroundColor: Color = Color(.systemFill)
    var textColor: Color = .primary
    var placeholderColor: Color = .gray
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            if let symbol = promptSymbol {
                Text(symbol)
                    .font(.system(size: 16))
            }
            
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .foregroundColor(textColor)
                .textFieldStyle(.plain)
                .accentColor(.blue)           // cursor color
                .font(.system(size: 15))
                .autocorrectionDisabled(true) // optional
            
            // Clear button – only when there's text
            if !text.isEmpty {
                Button {
                    text = ""
                    // Optional: keep focus after clear
                    // isFocused = true
                } label: {
                    Image(.system("xmark.circle.fill"))
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .symbolRenderingMode(.hierarchical)
                }
                .buttonStyle(.plain)
                // Makes hit area a bit larger
                .contentShape(Circle())
                .padding(.trailing, 4)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(isFocused ? Color.blue.opacity(0.5) : Color(.systemGray), lineWidth: 1.5)
        )
    }
}

#Preview {
    VStack(spacing: 24) {
        ClearableTextField(
            placeholder: "Subject, Author, SHA",
            text: .constant(""),
            promptSymbol: "🔍",
        )
        
        ClearableTextField(
            placeholder: "Search…",
            text: .constant("test query"),
            promptSymbol: "🔍",
        )
        
        ClearableTextField(
            placeholder: "Filter",
            text: .constant(""),
            height: 34,
            cornerRadius: 6,
            backgroundColor: Color(.systemFill)
        )
    }
    .padding()
}
