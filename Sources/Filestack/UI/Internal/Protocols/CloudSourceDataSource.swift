//
//  CloudSourceDataSource.swift
//  Filestack
//
//  Created by Ruben Nine on 11/16/17.
//  Copyright © 2017 Filestack. All rights reserved.
//

import FilestackSDK
import MobileCoreServices.UTType
import UIKit

protocol CloudSourceDataSource: AnyObject {
    var client: Client! { get }
    var storeOptions: StorageOptions! { get }
    var source: CloudSource! { get }
    var path: String! { get set }
    var nextPageToken: String? { get set }
    var items: [CloudItem]? { get }
    var thumbnailCache: NSCache<NSURL, UIImage> { get }

    func store(item: CloudItem)
    func navigate(to item: CloudItem)
    func loadNextPage(completionHandler: @escaping (() -> Void))
    func search(text: String, completionHandler: @escaping (() -> Void))
    func refresh(completionHandler: @escaping (() -> Void))
    func cacheThumbnail(for item: CloudItem, completionHandler: @escaping ((UIImage) -> Void))
}

extension CloudSourceDataSource {
    // Based on user config, can `item` be selected?
    func canSelect(item: CloudItem) -> Bool {
        let config = client.config
        if item.isFolder || config.cloudSourceAllowedUTIs.isEmpty {
            return true
        }
        guard let uti = item.name.UTI else { return false }
        // hard code a restriction for "plain text" UTI to prevent google docs from being picked..
        // This is a workaround to prevent cryptic error when picking google doc files.
        if UTTypeConformsTo(uti, "public.plain-text" as CFString) {
            return false
        }
        // Try to find at least an UTI in `cloudSourceAllowedUTIs` that comforms to our item's UTI,
        // or return false if none match.
        for allowedUTI in config.cloudSourceAllowedUTIs {
            if UTTypeConformsTo(uti, allowedUTI as CFString) {
                return true
            }
        }
        return false
    }
}
