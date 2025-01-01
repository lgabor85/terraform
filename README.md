# terraform
Terraform templates

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- [AZURE CLI](https://learn.microsoft.com/en-us/cli/azure/) configured

## Usage

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/terraform.git
    cd terraform
    ```

2. Initialize the Terraform configuration:
    ```sh
    terraform init
    ```

3. Plan the Terraform deployment:
    ```sh
    terraform plan
    ```

4. Apply the Terraform deployment:
    ```sh
    terraform apply
    ```

## Directory Structure

```
.
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## Contributing

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.