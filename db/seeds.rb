require "open-uri"

puts "Cleaning database ...."

Photo.destroy_all
User.destroy_all


puts "Generating Users ..."

user1 = User.create(email: "coco@gmail.com", first_name: "Corentin",  username: "corentinv", password: "123456")
user2 = User.create(email: "zach@gmail.com", first_name: "Zach",  username: "1zach", password: "123456")
user3 = User.create(email: "steph@gmail.com", first_name: "Stephane", username: "stephasme", password: "123456")
user4 = User.create(email: "tenzayn@gmail.com", first_name: "Tenzayn", username: "tenzayn", password: "123456")
User.create(email: "ambroise@gmail.com", first_name: "Ambroise", username: "ambbuck", password: "123456")

puts "#{User.all.count} users"

puts "Generating photos..."

focal_array = [24, 35, 50, 70, 80, 90, 100, 200, 300, 400, 500, 600]
camera_array = ["Sony A7 IV", "Fujifilm X-T4", "Canon EOS R6", "OM System OM-1", "Canon EOS R7", "Nikon Z6 II",
                "Fujifilm X-S10", "Nikon Z5", "Olympus OM-D E-M10 Mark IV", "Nikon Z fc", "Fujifilm X100V",
                "Nikon D3500", "Fujifilm Instax Mini 11", "Sony A6100", "Canon EOS R5", "Sony A7R IV"]
camera_lens = ["Canon EF 70-200mm", "Sigma 24-70mm", "Canon EF 24-70mm", "Sigma 18-35mm", "Canon EF 50mm",
              "Canon EF 75-300mm", "Sigma 150-600mm", "Nikon AF-S NIKKOR 200-500mm", "Canon EF 50mm"]

# Photos of the first user
Photo.create(url: "https://images.unsplash.com/photo-1567031538095-8a6fd8771fa2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=640&q=80",creator: user1.first_name,
            focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
            camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
            lens: camera_lens.sample, location: [50.846760,4.352780], user_id: user1.id)
Photo.create(url: "https://images.unsplash.com/photo-1567456100912-99f3038bd8e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YnJ1c3NlbHMlMjBncmFuZCUyMHBsYWNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",creator: user1.first_name,
            focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
            camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
            lens: camera_lens.sample, location: [50.846760,4.352780], user_id: user1.id)
Photo.create(url: "https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZWlmZmVsJTIwdG93ZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",creator: user1.first_name,
            focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
            camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
            lens: camera_lens.sample, location: [48.858372,2.294481], user_id: user1.id)
Photo.create(url: "https://images.unsplash.com/photo-1565881606991-789a8dff9dbb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8ZWlmZmVsJTIwdG93ZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",creator: user1.first_name,
            focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
            camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
            lens: camera_lens.sample, location: [48.858372,2.294481], user_id: user1.id)


# Photos of the second user
Photo.create(url: "https://images.unsplash.com/photo-1647613011546-093885baa316?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8YnJ1c3NlbHMlMjBncmFuZCUyMHBsYWNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",creator: user2.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [50.846760,4.352780], user_id: user2.id)
Photo.create(url: "https://images.unsplash.com/photo-1607179780236-b5d5eed4f6d6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGJydXNzZWxzJTIwZ3JhbmQlMjBwbGFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",creator: user2.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [50.846760,4.352780], user_id: user2.id)
Photo.create(url: "https://images.unsplash.com/photo-1581010864468-c972b8705439?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZWlmZmVsJTIwdG93ZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",creator: user2.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [48.858372,2.294481], user_id: user2.id)
Photo.create(url: "https://images.unsplash.com/photo-1568668392383-58c369615742?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8ZWlmZmVsJTIwdG93ZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",creator: user2.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [48.858372,2.294481], user_id: user2.id)

# Photos of the third user
Photo.create(url: "https://images.unsplash.com/photo-1583356304674-1eb8b98466d7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGJydXNzZWxzJTIwZ3JhbmQlMjBwbGFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",creator: user3.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [50.846760,4.352780], user_id: user3.id)
Photo.create(url: "https://images.unsplash.com/photo-1647613011502-74a429fcd4ea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGJydXNzZWxzJTIwZ3JhbmQlMjBwbGFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",creator: user3.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [50.846760,4.352780], user_id: user3.id)
Photo.create(url: "https://images.unsplash.com/photo-1431274172761-fca41d930114?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZWlmZmVsJTIwdG93ZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",creator: user3.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [48.858372,2.294481], user_id: user3.id)
Photo.create(url: "https://images.unsplash.com/photo-1570939274717-7eda259b50ed?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGVpZmZlbCUyMHRvd2VyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",creator: user3.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [48.858372,2.294481], user_id: user3.id)
# Steph seeds
Photo.create(url: "https://images.unsplash.com/photo-1568707950056-647f0c2fd17b",creator: user1.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [43.278740,3.514390], user_id: user1.id)

Photo.create(url: "https://images.unsplash.com/photo-1513415564515-763d91423bdd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",creator: user2.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [22.396780,114.199410], user_id: user2.id)

Photo.create(url: "https://images.unsplash.com/photo-1516590126735-bab76ef5967e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=776&q=80",creator: user4.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [51.178883,-1.826215], user_id: user4.id)

Photo.create(url: "https://images.unsplash.com/photo-1561036114-78189ef9a613?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1548&q=80",creator: user3.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [38.052860,-84.730331], user_id: user3.id)

# Photos of the fourth user
Photo.create(url: "https://images.unsplash.com/photo-1461838239441-4475121c0b7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGJydXNzZWxzJTIwZ3JhbmQlMjBwbGFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",creator: user4.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [50.846760,4.352780], user_id: user4.id)
Photo.create(url: "https://images.unsplash.com/photo-1550481010-dfad748ad5c8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGJydXNzZWxzJTIwZ3JhbmQlMjBwbGFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",creator: user4.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [50.846760,4.352780], user_id: user4.id)
Photo.create(url: "https://images.unsplash.com/photo-1539336034244-d7b04bd0e935?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGVpZmZlbCUyMHRvd2VyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",creator: user4.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [48.858372,2.294481], user_id: user4.id)
Photo.create(url: "https://images.unsplash.com/photo-1619794578892-cbdd3ff81c95?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fGVpZmZlbCUyMHRvd2VyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",creator: user4.first_name,
  focal_length: "#{focal_array.sample}mm", creation_date_time: Date.today-rand(10000),
  camera: camera_array.sample, aperture: "f/#{rand(1..22)}",
  lens: camera_lens.sample, location: [48.858372,2.294481], user_id: user4.id)

  Photo.all.each do |photo|
    puts "Photo de #{photo.creator} avec un #{photo.camera} à #{photo.creation_date_time}"
  end
puts "#{Photo.all.count} photos"
