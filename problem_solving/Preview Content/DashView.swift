import SwiftUI
import SwiftData
import Firebase

struct DashView: View {
    @Environment(\.modelContext) private var modelContext


    var body: some View {
        TabView{
            // First tab
            NavigationView {
                VStack {
                    Text("This is the third tab!")
                    // Add your content for the third tab as needed
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .tabItem {
                Label("Leaderboard", systemImage: "person.3.fill")
            }
            
            // Second tab
            NavigationView {
                PathView()
                        .navigationBarTitle("Select an item")
                }
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
            
            ProfileView()
            
            .tabItem {
                Label("Profile", systemImage: "person.circle.fill")
            }
        }
    }
}
struct ProfileView: View {
    let profileLinkNames: [String] = ["Saved Articles", "Followers", "Following"]

    var body: some View {
        NavigationView {
            List(profileLinkNames, id: \.self) { profileLinkName in
                NavigationLink(destination: Text("Details for \(profileLinkName)")) {
                    ProfileLink(profileLinkName: profileLinkName)
                }
            }
            .navigationTitle("Profile")
            .navigationBarItems(
                trailing:
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .foregroundColor(Color.blue)
                    .padding()
            )
        }
    }
}

struct ProfileLink: View {
    let profileLinkName: String // Add this line to accept profileLinkName as a parameter

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(profileLinkName)
                    .font(.body)
                Spacer()
            }
            .padding(EdgeInsets(top: 17, leading: 21, bottom: 17, trailing: 21))
            Divider()
        }
    }
}


#Preview {
        DashView()
    }
