resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  ...
}

resource "aws_subnet" "public" {
  count             = 2
  cidr_block        = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
  ...
}

resource "aws_subnet" "private" {
  count             = 2
  cidr_block        = "10.0.${count.index + 2}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  ...
}


# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "2Tier-IGW"
  }
}

