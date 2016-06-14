//
//  ContainerBuilder.swift
//  DITranquillity
//
//  Created by Alexander Ivlev on 09/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

public class ContainerBuilder {
  public init() {
  }
  
  public func register<T>(rClass: T.Type) -> RegistrationBuilderProtocol {
    return RegistrationBuilder<T>(self.rTypeContainer, rClass)
  }
  
  public func build() throws -> ScopeProtocol {
    var errors: [Error] = []
    
    for rType in rTypeContainer.list() {
      if !rType.hasInitializer {
        errors.append(Error.NotSetInitializer(typeName: String(rType.implementedType)))
      }
    }
    
    if !errors.isEmpty {
      throw Error.Build(errors: errors)
    }
    
    return Scope(registeredTypes: rTypeContainer)
  }
  
  private let rTypeContainer = RTypeContainer()
}
