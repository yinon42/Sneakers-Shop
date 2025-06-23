import Foundation
import SwiftUI

struct Product: Identifiable, Hashable {
    var id: String
    var name: String
    var brand: String
    
    var price: Double
    var image: String 
}

var productList = [
    Product(id: "1", name: "Air Max 97", brand: "Nike", price: 120.0, image: "airmax97"),
    Product(id: "2", name: "Yeezy Boost 350", brand: "Adidas", price: 250.0, image: "yeezy350"),
    Product(id: "3", name: "Chuck Taylor", brand: "Converse", price: 75.0, image: "chucktaylor"),
    Product(id: "4", name: "Jordan 1 Retro", brand: "Nike", price: 180.0, image: "jordan1"),
    Product(id: "5", name: "New Balance 550", brand: "New Balance", price: 110.0, image: "nb550"),
    Product(id: "6", name: "Puma RS-X", brand: "Puma", price: 90.0, image: "pumarsx"),
    Product(id: "7", name: "Reebok Classic", brand: "Reebok", price: 85.0, image: "reebokclassic"),
    Product(id: "8", name: "Asics Gel-Lyte III", brand: "Asics", price: 95.0, image: "asicsgel"),
    Product(id: "9", name: "Vans Old Skool", brand: "Vans", price: 70.0, image: "vansoldskool"),
    Product(id: "10", name: "Nike Blazer Mid '77", brand: "Nike", price: 100.0, image: "blazermid")
]
