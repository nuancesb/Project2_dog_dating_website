User.delete_all
Dog.delete_all

# user1 = User.create!(email: "bruno@date-my-dog.co.uk", password: "password",  nickname: "Bruno", first_name: "Bruno", last_name: "Vinel", name: "Bruno", image: nil, urls: nil, location: nil, verified: nil, gender: "male", postcode: "N4 2HW", home_lat: nil, home_long: nil, description: "I am Bruno", provider: nil, uid: nil)
user2 = User.create!(email: "sophie@date-my-dog.co.uk", password: "password",  nickname: "Sophie", first_name: "Sophie", last_name: "Cottin", name: "Sophie", image: nil, urls: nil, location: nil, verified: nil, gender: "female", postcode: "W6 7RG", home_lat: nil, home_long: nil, description: "I am Sophie", provider: nil, uid: nil)
# dog1 = Dog.create!(name: "Fluffy", user_id: 1, sex: "male", breed: "labrador", dob: nil, picture: nil, sound: nil, description: "I am a lovely labrador dog")
# dog2 = Dog.create!(name: "Star", user_id: 1, sex: "female", breed: "golden retriever", dob: nil, picture: nil, sound: nil, description: "I am a beautiful golden retriever dog")
dog3 = Dog.create!(name: "Cachoux", user_id: 2, sex: "female", breed: "beagle", dob: nil, picture: nil, sound: nil, description: "I am a lovely beagle puppy")