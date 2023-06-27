//
//  DocumentPickerUploadController.swift
//  Filestack
//
//  Created by Ruben Nine on 12/1/17.
//  Copyright © 2017 Filestack. All rights reserved.
//

import FilestackSDK
import UIKit

class DocumentPickerUploadController: URLPickerUploadController {
    let picker: UIDocumentPickerViewController

    init(uploader: (Uploader & DeferredAdd)?,
         viewController: UIViewController,
         config: Config,
         completionBlock: (([URL]) -> Void)? = nil) {
        self.picker = UIDocumentPickerViewController(documentTypes: config.documentPickerAllowedUTIs, in: .import)

        super.init(uploader: uploader,
                   viewController: viewController,
                   presentedViewController: picker,
                   config: config,
                   completionBlock: completionBlock)

        self.picker.delegate = self
    }
}

extension DocumentPickerUploadController: UIDocumentPickerDelegate {
    // called if the user dismisses the document picker without selecting a document (using the Cancel button)
    func documentPickerWasCancelled(_: UIDocumentPickerViewController) {
        cancel()
    }

    // Required
    func documentPicker(_: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        completionBlock?(urls)

        if uploader != nil {
            upload(urls: urls)
        }
    }
}
