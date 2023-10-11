import SwiftUI

struct ProfileTab: View {
    @State var selectedPlaylist:Playlist?
    @State var isPlaylistSelected:Bool = false
    @Namespace var namespace
    @StateObject var vm: ViewModel = ViewModel()
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        if let model = vm.model {
            ZStack{
                PlaylistScrollView(namespace: namespace, selectedPlaylist: $selectedPlaylist, isPlaylistSelected: $isPlaylistSelected, userId: model.id)
                    .safeAreaInset(edge: .top) {
                        VStack(spacing: 0){
                            ProfileHeader(model: model)
                                .background(
                                    UnevenRoundedRectangle(cornerRadius: 66.w, corners: [.bottomLeft, .bottomRight])
                                        .fill(Color(.ColorSet.blackAndWhite))
                                        .brightness( colorScheme == .dark ?  0.2 : 0)
                                        .ignoresSafeArea()
                                )
                                .background(alignment: .bottom) {
                                    Rectangle()
                                        .fill(Color(.ColorSet.background))
                                    
                                }
                            
                            
                            Text("**PlayList**")
                                .font(fontSize: 16.w)
                                .frame(height: 20.w)
                                .frame(maxWidth: .infinity, alignment:.leading)
                                .padding(.horizontal, 30.w)
                                .padding(.top, 15.w)
                                .background{
                                    Color(.ColorSet.background)
                                        .offset(y: -1.5.w)
                                }
                                .zIndex(1)
                            
                            Rectangle()
                                .fill(.linearGradient(.init(colors: [Color(.ColorSet.background), .clear]), startPoint: .top, endPoint: .bottom))
                                .frame(height: (15).w)
                                .offset(y:-1.5.w)
                            
                            
                        }
                        .opacity(isPlaylistSelected ? 0 : 1)
                    }
                
                
                if let playlist = selectedPlaylist, isPlaylistSelected {
                    ExplorePlaylist(namespace: namespace, playlistModel: playlist, isPlaylistSelected: $isPlaylistSelected)

                        .transition(.scale(scale:1))
                       
                        
                }
            }
            
            
        }
    }
}

struct ProfileHeader: View {
    let model: User
    
    var body: some View {
        
        
        Color.clear
            .overlay(alignment: .bottom) {
                ProfileStatsView(model: model)
            }
            .overlay(alignment: .top) {
                ProfileHeaderView(model: model)
            }
            .frame(height: 318.w )
            .frame(maxWidth: .infinity)
        
    }
}

struct ProfileStatsView: View {
    let model: User
    
    var body: some View {
        HStack {
            ProfileStatView(value: "\(model.followers.total)", label: "Follow")
            Spacer()
            ProfileStatView(value: "243", label: "Followers")
        }
        .padding(.horizontal, 89.w)
        .padding(.bottom, 21.w)
    }
}

struct ProfileStatView: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 10.w) {
            Text(value)
                .fontWeight(.bold)
                .lineLimit(1)
                .font(fontSize: 18.w)
                .frame(width: 85.w)
            Text(label)
                .fontWeight(.light)
                .font(fontSize: 15.5.w)
        }
    }
}

struct ProfileHeaderView: View {
    let model: User
    
    var body: some View {
        VStack {
            TopNavBar(title: Text("**Profile**")
                .font(fontSize: 15.w)
            )
            
            CachedImage(photoURL: model.images[1].url, placeholder: {
                Rectangle()
            })
            .frame(width: 93.w, height: 93.w)
            .clipShape(Circle())
            .padding(.top, 16.w)
            
            Text(verbatim: "\(model.email)")
                .fontWeight(.light)
                .font(fontSize: 12.w)
                .lineLimit(1)
                .padding(.top, 11.w)
            
            Text(verbatim: "\(model.display_name)")
                .fontWeight(.semibold)
                .font(fontSize: 16.w)
                .padding(.top, 8.w)
        }
        .padding(.horizontal, 30.w)
    }
}
