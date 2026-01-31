//
//  TabBarController.swift
//  GGUK
//
//  Created by VnPaz on 1/27/26.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.tintColor = .systemRed
        delegate = self
    }
    
    // "이미 선택된 탭"을 다시 탭했을 때 호출됨
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        
        guard let nav = viewController as? UINavigationController else { return } // 전환 때마다 루트 고정
    }
    
    private func setupTabs() {
        let mainVC = MainVC()
        mainVC.tabBarItem = UITabBarItem(title: "메인", image: UIImage(systemName: "house"), tag: 0)
        
        let staticVC = StaticVC()
        staticVC.tabBarItem = UITabBarItem(title: "통계", image: UIImage(systemName: "chart.bar"), tag: 1)
        
        let settingVC = SettingVC()
        settingVC.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gear"), tag: 2)
        
        // 각 탭에서 push 화면(예: "오늘의 모든 기록") 쓰려면 NavController로 감싸는 게 좋음
        viewControllers = [
            UINavigationController(rootViewController: mainVC),
            UINavigationController(rootViewController: staticVC),
            UINavigationController(rootViewController: settingVC)
        ]
    }
}
