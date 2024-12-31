//
//  MemberTableViewCell.swift
//  lec7
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    // MARK: - Properties (view)

    private let label = UILabel()

    // MARK: - Properties (data)

    static let reuse: String = "MemberTableViewCellReuse"

    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure

    func configure(member: Member) {
        label.text = "\(member.name), \(member.subteam), \(member.position)"
    }

    // MARK: - Set Up Views

    private func setupLabel() {
        label.textColor = .label

        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 16
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding)
        ])
    }

}
