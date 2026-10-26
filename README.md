# Virtual Public Artboard (VPA)

A stateful, realtime collaborative black & white canvas server built with Node.js, WebSockets, and HTML5 Canvas.

This project is a standalone software port of the Arduino-based [IDC - I2C Display Controller](https://github.com/mwdle/IDC). A live instance is available at [vpa.mwdle.com](https://vpa.mwdle.com).

## Configuration

The application is configured using environment variables:

| Variable          | Description                                                                                                                                                                         |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `APP_TITLE`       | Header and page title displayed to clients.                                                                                                                                         |
| `FILE_NUM_LIMIT`  | Maximum number of canvas files stored on disk (`0` for unlimited). When set to a value greater than `0`, the storage folder (`/var/lib/vpa`) must contain only VPA-generated files. |
| `TRUSTED_PROXIES` | Trusted proxy subnet or CIDR (e.g. `10.89.0.0/16`) for rate limiting and extracting client IPs behind a reverse proxy.                                                              |

## Development

### Subresource Integrity (SRI)

Client-side scripts and stylesheets loaded in `views/template.html` use Subresource Integrity (SRI) hashes. When updating static files in `public/`, regenerate their SHA-384 hashes and update `template.html`:

```bash
openssl dgst -sha384 -binary public/script.js | openssl base64 -A
openssl dgst -sha384 -binary public/styles.css | openssl base64 -A
```

### Canvas File Conversion

Convert stored `.dat` canvas files to PNG without running the server:

```bash
python datToImageConverter.py /path/to/image.dat
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
