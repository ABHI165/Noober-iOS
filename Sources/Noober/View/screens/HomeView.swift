import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel: NoobViewModel
    @State private var selectedTab = TabBarItem.api
    @State private var isSearching = false
    
    init(viewModel: NoobViewModel) {
        self._viewModel = ObservedObject(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader {proxy in
                VStack {
                    NoobTopAppBar(isSearching: $isSearching, text: $viewModel.searchText)
                    
                    if isSearching {
                        SearchResultView(state: viewModel.filteredDataState, sendAction: viewModel.send)
                            .transition(.move(edge: .trailing))
                    } else {
                        NoobTabView(selection: $selectedTab) {
                            
                            APICallsTabView(state: viewModel.apiListState) {msg in
                                viewModel.send(.tappedShare(msg: msg))
                            }
                            .noobTabItem(.api, selection: $selectedTab)
                            
                            UserPropertiesTabView(state: viewModel.userPropertiesListState) {key, newVal in
                                viewModel.send(.tappedChangePrefValue(newVal: newVal, forKey: key))
                            }
                            .noobTabItem(.sharedPref, selection: $selectedTab)
                            
                            LogsTabView(state: viewModel.logListState)
                                .noobTabItem(.logs, selection: $selectedTab)
                            
                            MoreTabView(sendAction: viewModel.send)
                                .noobTabItem(.more, selection: $selectedTab)
                        }
                        .padding(.bottom, proxy.safeAreaInsets.bottom == 0 ? 10 : 0)
                        .onAppear {
                            viewModel.send(.revertSearchQuery)
                        }
                        .transition(.move(edge: .leading))
                        
                    }
                    
                }
                .navigationBarHidden(true)
            }
        }
        .colorScheme(.light)
    }
}

#if DEBUG
#Preview {
    HomeView(viewModel: NoobViewModel())
}
#endif
