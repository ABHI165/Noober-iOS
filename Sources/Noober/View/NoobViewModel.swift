import Foundation
import Combine

enum UserAction {
    case tappedShareAccount
    case tappedRestoreAccount
    case tappedContribute
    case tappedShare(msg: String)
    case tappedChangePrefValue(newVal: String, forKey: String)
    case tappedChangeURL(newURL: String, oldURL: String)
    case revertSearchQuery
}

class NoobViewModel: ObservableObject {
    private let repository: NoobRepository
    private var cancellbag = Set<AnyCancellable>()
    
    @Published
    private(set) var apiListState = [APIInfoState]()
    
    @Published
    private(set) var logListState = [LogState]()
    
    @Published
    private(set) var userPropertiesListState = [UserPropertiesState]()
    
    @Published
    private(set) var filteredDataState =  FilteredDataState()
    
    @Published
    var searchText = ""
    
    init(repository: NoobRepository = NoobRepository.shared) {
        self.repository = repository
        observeChange()
        repository.getAllUserProperties()
        filteredDataState = FilteredDataState(apiCalls: apiListState, userProperties: userPropertiesListState, logs: logListState)
    }
    
    public func send(_ action: UserAction) {
        switch action {
            case .tappedShareAccount:
                let link = repository.generateDeepLink()
                NoobHelper.shared.share(link)
                
            case .tappedRestoreAccount:
                repository.restoreProperties()
                
            case .tappedContribute:
                NoobHelper.shared.openNoobGithubRepository()
                
            case .tappedShare(let msg):
                NoobHelper.shared.share(msg)
                
            case .tappedChangePrefValue(let newVal, let key):
                repository.updateValueInUserDefaults(forKey: key, newValue: newVal)
                
            case .tappedChangeURL(let newURL, let oldURL):
                Noober.shared.replace(url: oldURL, with: newURL)
                
            case .revertSearchQuery:
                searchText = ""
        }
    }
    
    private func observeChange() {
        repository
            .apiModelListPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] apiModels in
                guard let self = self else {return}
                self.apiListState = apiModels.map {$0.convertToState()}
            }
            .store(in: &cancellbag)
        
        repository
            .logsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] logModels in
                guard let self = self else {return}
                self.logListState = logModels.map {$0.convertToState()}
            }
            .store(in: &cancellbag)
        
        repository
            .userPropertiesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] prop in
                guard let self = self else {return}
                self.userPropertiesListState = UserPropertiesState.convertToState(prop)
            }
            .store(in: &cancellbag)
        
        $searchText
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .sink {[weak self] query in
                guard let self = self else {return}
                
                if searchText.isEmpty || searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    filteredDataState = FilteredDataState(apiCalls: apiListState, userProperties: userPropertiesListState, logs: logListState)
                    return
                }
                
                let filteredAPI = apiListState.filter {$0.matchesQuery(query)}
                let filteredLogs = logListState.filter {$0.matchesQuery(query)}
                let filteredUserProperties = userPropertiesListState.filter {$0.matchesQuery(query)}
                
                filteredDataState = FilteredDataState(apiCalls: filteredAPI, userProperties: filteredUserProperties, logs: filteredLogs)
            }
            .store(in: &cancellbag)
    }
}

