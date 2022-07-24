//
//  FormatStyle-LocalCurrency.swift
//  iExpense
//
//  Created by Scott Gurney on 24/07/2022.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}
