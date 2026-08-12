require "cgi"
require "rqrcode"

module Jekyll
  # Renders a URL as an inline SVG QR code at build time, so a QR can never
  # drift out of sync with the link it is printed next to.
  module QrCodeFilter
    # Error correction level :m tolerates ~15% damage, which is plenty for a
    # code shown on screen and keeps the SVG small.
    LEVEL = :m

    def qr_svg(url, label = nil)
      url = url.to_s
      return "" if url.empty?

      svg = RQRCode::QRCode.new(url, level: LEVEL).as_svg(
        module_size: 4,
        standalone: true,
        use_path: true,
        viewbox: true,
        color: "000"
      )

      # as_svg emits an XML declaration, which has no place inline in HTML.
      svg = svg.sub(/\A<\?xml.*?\?>/, "")

      # No width/height attributes are emitted, only a viewBox, so the size is
      # left to CSS.
      alt = label.to_s.empty? ? "QR code for #{url}" : "QR code for #{label}"
      svg.sub(
        "<svg ",
        %(<svg class="qr-code" role="img" aria-label="#{CGI.escapeHTML(alt)}" )
      )
    end
  end
end

Liquid::Template.register_filter(Jekyll::QrCodeFilter)
