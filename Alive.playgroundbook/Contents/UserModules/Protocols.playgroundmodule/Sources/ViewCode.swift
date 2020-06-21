
public protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfigurantion()
    func setupView()
}

extension ViewCode {
    public func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfigurantion()
    }
    
    public func setupAdditionalConfigurantion() {
        //
    }
}
