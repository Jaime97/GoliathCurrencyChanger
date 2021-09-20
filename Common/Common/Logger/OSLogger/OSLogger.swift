//
//  OSLogger.swift
//  GitHubStatistic
//
//  Created by Jaime Alcántara on 22/08/2021.
//

import Foundation
import OSLog

public class OSLogger:LoggerProtocol {
    
    private static var subsystem = Bundle.main.bundleIdentifier ?? "Logger"
    private let logger: Logger
    
    
    required public init(category: LogCategory) {
        self.logger = Logger(subsystem: Self.subsystem, category: category.rawValue)
    }
    
    public func logDebug(event: String, isPrivate: Bool) {
        if isPrivate {
            self.logger.debug("\(event, privacy: .private)")
        } else {
            self.logger.debug("\(event, privacy: .public)")
        }
    }
    
    public func logError(event: String, isPrivate: Bool) {
        if isPrivate {
            self.logger.error("\(event, privacy: .private)")
        } else {
            self.logger.error("\(event, privacy: .public)")
        }
    }
    
    public func logInfo(event: String, isPrivate: Bool) {
        if isPrivate {
            self.logger.info("\(event, privacy: .private)")
        } else {
            self.logger.info("\(event, privacy: .public)")
        }
    }
    
}
