//
//  ImageDownloader.swift
//  ProgressExample
//
//  Created by Kaira Diagne on 06/01/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit

final class ImageDownloader {

    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func downloadImage(with url: URL, completion: @escaping ((UIImage?) -> Void)) -> Progress {
        let task = session.downloadTask(with: url) { (url, response, error) in
            guard error == nil else {
                completion(nil)
                return
            }

            guard let url = url else {
                completion(nil)
                return
            }

            do {
                let imageData = try Data(contentsOf: url)
                let image = UIImage(data: imageData)

                completion(image)
            } catch {
                completion(nil)
            }
        }

        task.progress.localizedDescription = "Downloading image..."

        task.resume()

        return task.progress
    }
}
