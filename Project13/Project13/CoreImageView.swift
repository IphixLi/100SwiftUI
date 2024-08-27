//
//  ContentView.swift
//  Project13
//
//  Created by Iphigenie Bera on 8/26/24.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

//There is some interoperability between the various image types:
//
//We can create a UIImage from a CGImage, and create a CGImage from a UIImage.
//We can create a CIImage from a UIImage and from a CGImage, and can create a CGImage from a CIImage.
//We can create a SwiftUI Image from both a UIImage and a CGImage.

struct CoreImageView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage(){
        let inputImage = UIImage(resource:.example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
//        let currentFilter=CIFilter.sepiaTone()
//        currentFilter.inputImage=beginImage
//        currentFilter.intensity=1
        
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage
        currentFilter.radius = 200
        
//        let currentFilter = CIFilter.twirlDistortion()
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 1000
//        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
        
//        let currentFilter = CIFilter.twirlDistortion()
//        currentFilter.inputImage = beginImage
//
//        let amount = 1.0
//
//        let inputKeys = currentFilter.inputKeys
//
//        if inputKeys.contains(kCIInputIntensityKey) {
//            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
//        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
//        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
//        
//        
//        our context to create a CGImage from that output image.
//        Convert that CGImage into a UIImage.
//        Convert that UIImage into a SwiftUI Image.
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        // convert that to a UIImage
        let uiImage = UIImage(cgImage: cgImage)

        // and convert that to a SwiftUI image
        image = Image(uiImage: uiImage)
    }
    
}

#Preview {
    CoreImageView()
}
