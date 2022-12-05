variable "api_key" {
  type        = string
  description = "API Key"
}

variable "crn" {
  type        = string
  description = "Workspace for Power Systems CRN"
  default     = "crn:v1:bluemix:public:power-iaas:us-south:a/035c4a9a8dfd4a969cd9409ae37d139c:d77de044-efa7-4083-b728-9105dafc50fc::"
}
