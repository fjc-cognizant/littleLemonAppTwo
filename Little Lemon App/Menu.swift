import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("Logo")
                    .padding(.leading)
                Spacer()
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .padding([.leading, .trailing])
            
            Group {
                ZStack{
                    Rectangle().foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                    VStack(alignment: .leading){
                        HStack{
                            Text("Little Lemon")
                                .foregroundColor(Color(red: 244/255, green: 206/255, blue: 20/255))
                                .font(Font.custom("Georgia", size: 40))
                                .bold()
                                .padding([.leading], 20)
                            Spacer()
                        }
                        .frame(height: 45)
                        HStack (alignment: .center) {
                            VStack(alignment: .leading) {
                                Text("Chicago")
                                    .foregroundColor(Color(red: 237/255, green: 239/255, blue: 238/255))
                                    .font(Font.custom("Georgia", size: 30))
                                    .fontWeight(.medium)
                                    .frame(height: 40)
                                Text("We are family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                    .foregroundColor(Color(red: 237/255, green: 239/255, blue: 238/255))
                                    .font(Font.system(size: 16, weight: .medium))
                                    .frame(height: 100)
                                
                                
                            }
                            Rectangle()
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    Image("Hero image")
                                        .resizable()
                                        .scaledToFill()
                                )
                                .clipShape(Rectangle())
                                .cornerRadius(15)
                                .frame(width: 150, height: 150)
                            
                            
                        }
                        .padding([.leading, .trailing])
                        .padding(.bottom, 20)
                        HStack {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .resizable()
                                .foregroundColor(Color(red: 230/255, green: 230/255, blue: 230/255))
                                .frame(width: 40, height: 40)
                            
                            TextField(" Search...", text: $searchText)
                                .padding(10)
                                .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                .cornerRadius(20)
                                .padding(.leading, 5)
                        }
                        .padding([.leading, .trailing])
                        
                    }
                }
                .frame(height: 300)
            }
            Group{
                VStack(alignment: .leading){
                    Text("ORDER FOR DELIVERY!")
                        .font(Font.system(size: 18, weight: .bold))
                    HStack {
                        Button("Starters") {
                        }
                        .font(Font.system(size: 16, weight: .bold))
                        .padding([.leading, .trailing], 8)
                        .padding([.top, .bottom], 10)
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .background(Color(red: 237/255, green: 239/255, blue: 238/255))
                        .cornerRadius(13)
                        Spacer()
                        Button("Mains") {
                        }
                        .font(Font.system(size: 16, weight: .bold))
                        .padding([.leading, .trailing], 8)
                        .padding([.top, .bottom], 10)
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .background(Color(red: 237/255, green: 239/255, blue: 238/255))
                        .cornerRadius(13)
                        Spacer()
                        Button("Desserts") {
                        }
                        .font(Font.system(size: 16, weight: .bold))
                        .padding([.leading, .trailing], 8)
                        .padding([.top, .bottom], 10)
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .background(Color(red: 237/255, green: 239/255, blue: 238/255))
                        .cornerRadius(13)
                        Spacer()
                        Button("Drinks") {
                        }
                        .font(Font.system(size: 16, weight: .bold))
                        .padding([.leading, .trailing], 8)
                        .padding([.top, .bottom], 10)
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .background(Color(red: 237/255, green: 239/255, blue: 238/255))
                        .cornerRadius(13)
                        
                    }
                    Divider()
                        .background(Color(red: 51/255, green: 51/255, blue: 51/255))
                        .padding(.top, 10)
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 10)
            }
            Group {
                NavigationView {
                    
                    FetchedObjects(predicate: buildPredicates(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                        ScrollView {
                            ForEach(dishes, id: \.self) { dish in
                                NavigationLink( destination: {
                                    Details(title: dish.title ?? "",
                                            price: dish.price ?? "",
                                            image: dish.image ?? "",
                                            description: dish.dishDescription ?? "")
                                }) {
                                    VStack {
                                        HStack{
                                            VStack(alignment: .leading) {
                                                Text(dish.title ?? "")
                                                    .font(Font.system(size: 16, weight: .bold))
                                                
                                                    .padding(.bottom, 2)
                                                    .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                                                Text(dish.dishDescription ?? "")
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.system(size: 16, weight: .regular))
                                                
                                                
                                                    .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                                                    .frame(width: 280, alignment: .leading )
                                                
                                                Text("$\(dish.price ?? "")")
                                                    .font(Font.system(size: 16, weight: .bold))
                                                
                                                    .padding(.top, 2)
                                                    .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                                            }
                                            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                                                switch phase {
                                                case .empty : Image(systemName: "exclamationmark.icloud")
                                                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                                                    
                                                case .success(let image):
                                                    image.resizable()
                                                        .scaledToFit()
                                                    
                                                case .failure(_):
                                                    Image(systemName: "exclamationmark.icloud")
                                                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                                                @unknown default:
                                                    Image(systemName: "exclamationmark.icloud")
                                                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                                                }
                                                
                                            }
                                            .frame(width: 70, height: 70)
                                            .frame(maxWidth: 150, maxHeight: 150)
                                        }
                                        Divider()
                                            .background(Color(red: 237/255, green: 239/255, blue: 238/255))
                                            .padding(.top, 5)
                                    }
                                    .padding([.leading, .trailing], 20)
                                }
                            }
                            
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
        } .task {
            await getMenuData()
        }
    }
    
    func getMenuData() async {
        PersistenceController.shared.clear()
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let menuList = try decoder.decode(MenuList.self, from: data)
            for menuItem in menuList.menu {
                let dish = Dish(context: viewContext)
                dish.title = menuItem.title
                dish.price = menuItem.price
                dish.image = menuItem.image
                dish.dishDescription = menuItem.description
            }
            try? viewContext.save()
        }
        
        catch { }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicates() -> NSPredicate {
        searchText.isEmpty
        ? NSPredicate(value: true)
        : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}


