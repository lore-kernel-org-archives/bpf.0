Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAB3FE37D
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165234; cv=none; b=qbJHPFHlN6eRoR7M87HRPjZ2KSw9uASiQnngVRCZn2vjK2HZNCprKh5ShzML2x2z7YL2KDHeeMDCu9L3sExVDodSQ0uk4s82haTkhrJTNyj8B0XL8sEwZy/prk5hFFnwory97+hrNcAv/m6WlkUqf0XDcBtyujsfsSMnDFyO0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165234; c=relaxed/simple;
	bh=/OysdnbnOtECLkkSa00qUIDUT8c+z8rBTm0QaKE643Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyTTxOGJ20zd+WLN86YdZJcs3YTJPBpmYKxZNa7SZqE0UJI+2/Ue5OriGW8tWznZ9NgVGXQz1bbd/0KyqJl6YDF6bkQO5u6Dr2bq3frDQwisPyKmxRbRqWn57G/4oxduNdrl7Os6M4xty7AFnRldViWczcVt0xR77EVidjTdbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=y6sHvENc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="y6sHvENc"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ba840146so8821675e9.1
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778165230; x=1778770030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZB38wJGIZd42iBI3srRP0pjjAxDTyyGTqCWJp8RgtQ=;
        b=y6sHvENcFjVQHrSBavIoyq7oFwxMGglGYH82YKxB3rYUBU2WXPRYsxMkRmjaL8UJtJ
         8qCHl9DPDYrsxc98WoBL2OVnRxquMXDR7DJkEJ9EsIq4AZGGHrWcAHRBS18gya1ZxKtR
         EnlmuxisPmWVI/FCv2UT17Z2tvp0mlc86/WG39g8c3YrEIGrOiRRn5f3rGEvIAe9NK4M
         G3PU4X1W2bs7CtqpYJU4OLJ9+/f8MTwSAHunB19JS2FigfTQbWc1FjXIgGDLFSsZnLYJ
         srSccQtsHw2YSHp5ap4GUnDf1aUWOpktSnhkWm07DoTgrs60aRygAE7qvb6LOWLgEOL6
         oFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778165230; x=1778770030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZB38wJGIZd42iBI3srRP0pjjAxDTyyGTqCWJp8RgtQ=;
        b=OUjQGbgywaGzQIAzPxHmGU1T56rMkmgZ17+n1xThrCuq26mj5bOPVqprfvrw4XMCZs
         PIEHT/PlEjzbA7LRIabog7fmffIJZre4YUSTwwevzL/KwprxImGe71k8EWxhNfEQz5gg
         R6djlbk6/cAVe4dGuNqZQjAB7dfG32WqYUwY2QgXEQdrvWa88bWAfCM8KNhL05CDRipu
         7w8ujDwYBq9gPrGlUWJuT8MEzMYjxXDkuifshzi+5C++neFLn0kH0WjTVzOLR55SbQPf
         8QnLddSQqFxXLxJBFDuszKBI8A18dSj/xjADwlnJZTho3yPHRFp8HgmnklVhMcaiL944
         6QgA==
X-Forwarded-Encrypted: i=1; AFNElJ8InQFHa79kNRFelQk/1M57/GrzpBYtVDXzXhg6cVUdQkO7qwuBNyICNWgtat7xi41evM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEiIGF7TmoWpnwzMzCUkzmKQsCiq3KHsybsLsqwBA9bdFEd6l
	5B/KN5R1jtLEw1A2318wIpeyAYc6rCTmdvULHGh9U+YlAsKb1A7Up/Niw/yhySOwTuQ=
X-Gm-Gg: AeBDiet8pSxc9ZGH8FKR9OQT8Q+aU+dVeWev9Xvj32FSvLFJM21s27RjgIZJy7lo2bu
	SUfB8uDMveTcijsunN2+m41vuTGDDjPXjsp0UDYwDl/zEt84UNrdIVlI/W5LDeWJP9u83QfSLqK
	5ESab1Qi9xQrKgEMkKBZ0WHqcxbdZsEp8luQ33a7ymDNZTetlZKo+vZxJc7T8fUwVaDW6SOFKCE
	Y/Kp/26EIFdG5aUsN3/BMjGicP7WN4M+F2G4RBZWHEw0dXztIDOaX8aeZ8tCg9rxUOJILnRew+I
	aUaJ2rAA7NelXfxY9fJ5y0s4Mf7hzPXUAM/++C7O8F4tIa5MSQNpk6h/7anAVf/f7GHlc4Uc6gQ
	8Uj2dd6nlCvu1ULyFDHu6hy+y6Tj9Bi1Mf0H9l8AgGfcPVXBYl7BYlEMFgOG+v6rxuGk6y+HLoy
	tiWwDWcdYcjDl37ZRuchMvTDAcTuWJsOvJePSf4S/lv2LU3YZr0WMeEclCv7K4FkXHB5ByQ4VNh
	gThNV5yxf8+13zbDzCjw4Oi1/OTc+NazhAz+dmGbii110VCfk+XEgGtz55AFk63sErq/PSGe/VR
	RxlMnxr0bxTn9onek4g=
X-Received: by 2002:a05:600c:a317:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-48e52bd4f32mr100824405e9.19.1778165230150;
        Thu, 07 May 2026 07:47:10 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a5486sm134813275e9.6.2026.05.07.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:47:09 -0700 (PDT)
Date: Thu, 7 May 2026 15:47:06 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
	alexandre.torgue@foss.st.com, ast@kernel.org,
	boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
	julianbraha@gmail.com, livelycarpet87@gmail.com,
	matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
Message-ID: <afyl6gpHLlAnxir7@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-9-elder@riscstar.com>
 <20260504-fascinating-teal-tarsier-b116c8@quoll>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-fascinating-teal-tarsier-b116c8@quoll>

On Mon, May 04, 2026 at 01:00:07PM +0200, Krzysztof Kozlowski wrote:
> On Fri, May 01, 2026 at 10:54:16AM -0500, Alex Elder wrote:
> > From: Daniel Thompson <daniel@riscstar.com>
> >
> > Add devicetree bindings for the Toshiba TC956x family of Ethernet-AVB/TSN
> > bridges.
> >
> > Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> > Signed-off-by: Alex Elder <elder@riscstar.com>

Alex already replied to most of your comments but on this one
specifically...


> > ---
> >  .../bindings/net/toshiba,tc956x-dwmac.yaml    | 111 ++++++++++++++++++
> >  1 file changed, 111 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> > new file mode 100644
> > index 0000000000000..d95d22a3761da
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> > @@ -0,0 +1,111 @@
> > <snip>
> > +examples:
> > +  - |
> > +    pcie {
> > +      #address-cells = <3>;
> > +      #size-cells = <2>;
> > +
> > +      tc956x_emac0: pci@0,0 {
> > +        compatible = "pci1179,0220";
> > +        reg = <0x50000 0x0 0x0 0x0 0x0>;
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +        device_type = "pci";
> > +        ranges;
> > +
> > +        gpio-controller;
> > +        #gpio-cells = <2>;
> > +
> > +        phy-mode = "10gbase-r";
> > +        phy-handle = <&tc956x_emac0_phy>;
> > +
> > +        mdio {
> > +          compatible = "snps,dwmac-mdio";
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          tc956x_emac0_phy: ethernet-phy@1c {
> > +            compatible = "ethernet-phy-id311c.1c12";
> > +            reg = <0x1c>;
> > +          };
> > +        };
> > +      };
>
> Keep only one example, unless you have different properties (not their
> values, but their presence),

At some point I simplified the example by stripping out excess
properties from each ethernet-phy. In the process it looks like I
removed too much and eliminated reason I thought it important to
include both PCI functions in the example!

Each ethernet-phy will typically describe a reset gpio but we expect
only eMAC0 to act as a gpio-controller. For that reason I wanted to
show that. You can see part of that that in the current example because
tc956x_emac1 is not a gpio-controller.

In other words tc956x_emac**1**_phy will, in the real world, include a
reset-gpios property that references tc956x_emac**0**. For example:

    reset-gpios = <&tc956x_emac0 1 GPIO_ACTIVE_LOW>


So... is it better to strip it back the example to describe only a
single PCI function or should I add back the reset-gpios that I
accidentally removed?


Daniel.
