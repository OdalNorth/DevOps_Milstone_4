package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformWebserverExample(t *testing.T) {
	t.Parallel()

	// The value to pass into the Terraform CLI
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../terraform",
	})

	// Run a Terraform destroy at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Run a Terraform init and apply with the Terraform options
	terraform.InitAndApply(t, terraformOptions)

	// Get servers public ip for test
	publicIp := terraform.Output(t, terraformOptions, "public_ip")

	// Get url for test with server public ip
	url := fmt.Sprintf("http://%s", publicIp)

	// HTTP GET call to url with "terratest" string
	// 15 attempts 15 Second - this is enough for the server to deploy the web server and receive the request
	http_helper.HttpGetWithRetry(t, url, nil, 200, "Terratest", 15, 15*time.Second)
}
