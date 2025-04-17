//
//  ScanProductView.swift
//  PharmaFlowMobileBusiness
//
//  Created by Nicholas Sullivan on 2025-03-10.
//

import SwiftUI
import AVFoundation

struct BarcodeScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String?
    @Binding var isScanning: Bool

    init(scannedCode: Binding<String?>, isScanning: Binding<Bool>) {
        self._scannedCode = scannedCode
        self._isScanning = isScanning
    }

    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: BarcodeScannerView

        init(parent: BarcodeScannerView) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                parent.scannedCode = stringValue
                parent.isScanning = false
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return viewController }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return viewController
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }

        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.dataMatrix, .ean8, .ean13, .qr]
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)

        captureSession.startRunning()

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct ScanProductView: View {
    
    let username: String
    @Binding var isNavigatedToHome: Bool
    
    @State private var scannedCode: String? = nil
    @State private var isScanning: Bool = false
    @State private var showMatchedView: Bool = false
    @State private var showUnmatchedView: Bool = false
    
    private let referenceCode = "123456" // Hard-coded reference code
    
    var body: some View {
        VStack {
            if let scannedCode = scannedCode {
                Text("Product Scanned!")
                    .font(.headline)
                    .padding()
                
                // Display buttons for navigation
                if scannedCode == referenceCode {
                    Button(action: {
                        showMatchedView = true
                    }) {
                        Text("Update Product")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .sheet(isPresented: $showMatchedView) {
                        UpdateProductView(isNavigatedToHome: $isNavigatedToHome, username: username)
                    }
                } else {
                    Button(action: {
                        showUnmatchedView = true
                    }) {
                        Text("Add Product")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    .sheet(isPresented: $showUnmatchedView) {
                        AddProductView(barcode: scannedCode)
                    }
                }
            }
            
            Button(action: {
                isScanning.toggle()
            }) {
                Text(isScanning ? "Stop Scanning" : "Start Scanning")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(isScanning ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            
            if isScanning {
                BarcodeScannerView(scannedCode: $scannedCode, isScanning: $isScanning)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle("Barcode Scanner")
    }
}



