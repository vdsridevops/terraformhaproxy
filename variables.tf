variable "project" {
  description = " Google Cloud Platform - Project "
  type        = string
  default     = "scenic-alcove-258913"
}

variable "region" {
  description = " Google Cloud Platform - Region "
  type        = string
  default     = "us-west1"
}

variable "machine_type" {
  description = " Machine type "
  type        = string
  default     = "n1-standard-1"
}

variable "zone" {
  description = " Zone "
  type        = string
  default     = "us-west1-a"
}

variable "image" {
  description = " Image "
  type        = string
  default     = "centos-7"
}
