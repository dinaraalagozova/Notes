//
//  LoadingViewController.swift
//  Notes + CoreData
//
//  Created by Dinara Alagozova on 06.02.2022.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 156))
        imageView.image = UIImage(named: "illustration")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animation()
        }

    }
    
    private func animation() {
        UIView.animate(withDuration: 1.0, animations:  {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
        })
        
        UIView.animate(withDuration: 1.5, animations: {
                    self.imageView.alpha = 0
                }, completion: { done in
                    if done {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            if let viewController = UIStoryboard(name: "MainViewController", bundle: nil).instantiateViewController(withIdentifier: "Main") as? MainViewController {
                                self.navigationController?.pushViewController(viewController, animated: true)
                            }
                        })
                    }
        })
    }
}
