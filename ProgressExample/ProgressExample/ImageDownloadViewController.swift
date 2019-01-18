//
//  ImageDownloadViewController.swift
//  ProgressExample
//
//  Created by Kaira Diagne on 06/01/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit

final class ImageDownloadViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet var imageView: UIImageView!

    @IBOutlet var downloadButton: UIButton!

    @IBOutlet var progressView: UIProgressView!

    @IBOutlet var progressDescriptionLabel: UILabel!

    @IBOutlet var progressLabel: UILabel!

    // MARK: Properties

    private let downloadService: ImageDownloader

    private var observation: NSKeyValueObservation?

    private var downloadProgress: Progress? {
        didSet {
            observation?.invalidate()
            progressView.observedProgress = nil

            guard let progress = downloadProgress else {
                return
            }

            progressView.observedProgress = progress
            progressDescriptionLabel.text = progress.localizedDescription

            observation = progress.observe(\.localizedAdditionalDescription, options: [.initial, .new]) { [weak self] _, change in
                DispatchQueue.main.async {
                    self?.progressLabel.text = change.newValue
                }
            }

        }
    }

    // MARK: Initialize

    init(downloadService: ImageDownloader = ImageDownloader()) {
        self.downloadService = downloadService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        observation?.invalidate()
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setDownloadViews(hidden: true)
    }

    // MARK: Actions

    @IBAction func downloadAction(_ sender: Any) {
        imageView.image = nil
        setDownloadViews(hidden: false)

        assertionFailure("Replace the next line with an url of an image of your liking.")
        let imageString = ""
        guard let imageURL = URL(string: imageString) else {
            return 
        }

        downloadProgress = downloadService.downloadImage(with: imageURL) { [weak self] image in
            guard let self = self else {
                return
            }

            DispatchQueue.main.async {
                self.setDownloadViews(hidden: true)
                self.imageView.image = image
                self.downloadProgress = nil
            }
        }
    }

    // MARK: Helpers

    private func setDownloadViews(hidden: Bool) {
        progressDescriptionLabel.isHidden = hidden
        progressLabel.isHidden = hidden
        progressView.isHidden = hidden
    }
}
