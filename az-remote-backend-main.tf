# Generate a random storage name
resource "random_string" "tf-name" {
    length = 8
    upper = false
    number = true
    lower = true
    special = false  
}