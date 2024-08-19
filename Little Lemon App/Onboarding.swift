import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .padding(.bottom, 5)
                
                ZStack{
                    Rectangle().foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                    VStack(){
                        HStack{
                            Text("Little Lemon")
                                .foregroundColor(Color(red: 244/255, green: 206/255, blue: 20/255))
                                .font(Font.custom("Georgia", size: 40))
                                .bold()
                                .padding([.leading], 20)
                            Spacer()
                        }
                        .frame(height: 45)
                        HStack{
                            VStack(alignment: .leading) {
                                Text("Chicago")
                                    .foregroundColor(Color(red: 237/255, green: 239/255, blue: 238/255))
                                    .font(Font.custom("Georgia", size: 30))
                                    .fontWeight(.medium)
                                    .frame(height: 40)
                                Text("We are family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                    .foregroundColor(Color(red: 237/255, green: 239/255, blue: 238/255))
                                    .font(Font.system(size: 16, weight: .medium))
                                
                                
                                
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
                    }
                    
                }
                .frame(height: 240)
                
                VStack(alignment: .leading) {
                    
                    NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                    TextField("First Name*", text: $firstName)
                        .padding([.leading, .trailing])
                        .padding([.top, .bottom], 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding([.leading, .trailing, .top])
                    TextField("Last Name*", text: $lastName)
                        .padding([.leading, .trailing])
                        .padding([.top, .bottom], 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding([.leading, .trailing])
                    TextField("Email*", text: $email)
                        .padding([.leading, .trailing])
                        .padding([.top, .bottom], 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding([.leading, .trailing])
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                }
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                        print("its ok")
                        
                    } else {
                        showingAlert = true
                    }
                }
                .font(Font.system(size: 18, weight: .medium))
                .frame(width: 150)
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 10)
                .foregroundColor(Color(red: 237/255, green: 239/255, blue: 238/255))
                .background(Color(red: 73/255, green: 94/255, blue: 87/255))
                
                .cornerRadius(10)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Incomplete form"), message: Text("You have to fill all mandatory fields"), dismissButton: .default(Text("Ok")))
                }
                Spacer()
            } .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}


extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
