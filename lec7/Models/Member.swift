//
//  Member.swift
//  lec7
//
//  Created by Vin Bui on 10/31/23.
//

import Foundation

struct Member {
    let name: String
    let subteam: String
    let position: String
}

extension Member {

    static let dummyData = [
        Member(name: "Vin Bui", subteam: "iOS", position: "Course Instructor"),
        Member(name: "Richie Sun", subteam: "iOS", position: "Course Instructor"),
        Member(name: "Jennifer Gu", subteam: "iOS", position: "Pod Lead"),
        Member(name: "Christina Zeng", subteam: "Design", position: "Subteam Lead"),
        Member(name: "Liam Du", subteam: "Design", position: "Member"),
        Member(name: "Lindsey Cheng", subteam: "Design", position: "Member"),
        Member(name: "Justin Guo", subteam: "Android", position: "Member")
    ]

}
