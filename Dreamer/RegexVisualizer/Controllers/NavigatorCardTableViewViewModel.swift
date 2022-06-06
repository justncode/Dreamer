//
//  NavigatorCardTableViewViewModel.swift
//  Dreamer
//
//  Created by Conner Maddalozzo on 6/5/22.
//  Copyright © 2022 justncode LLC. All rights reserved.
//

import UIKit

struct NavigationCellDatasource {
    var title: String
    var body: String
    var img: UIImage
}


class NavigatorCardTableViewViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    let ds = [
        NavigationCellDatasource(title: "Clock In", body: "Meditate on last nights entry", img: UIImage(systemName: "calendar.badge.clock")!),
        NavigationCellDatasource(title: "Update Past/Future", body: "Update Past/Future", img: UIImage(systemName: "calendar.day.timeline.leading")!),
        NavigationCellDatasource(title: "°rz~", body: "Organize Dots On calendar", img: UIImage(systemName: "mappin")!)
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IconedStyledCard.self)) as? IconedStyledCard else {return UITableViewCell()}
        cell.entry = ds[indexPath.row]
        if indexPath.row == 1 {
            cell.datePickerOverride.toggle()
            cell.dateHandler = { date in
                tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
            }
            cell.contentView.isUserInteractionEnabled = false
        }
        return cell
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    
    
}
