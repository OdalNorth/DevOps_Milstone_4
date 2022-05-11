output "public_ip" {
  value       = aws_instance.App_Geocitizen.public_ip
  //value       = aws_instance.DB.public_ip
 }