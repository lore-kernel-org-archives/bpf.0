Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14DB36EAAD
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197324; cv=none; b=imswCLO21ZkBRi00P09Fvp68kVBZO5tGVvB6WxBzpfpLSgPOeGTytWQfqO1zvjuhHAICDgrPi8krUoYebvPev1rJaPrUNOSZ0IcZE+JsRQ7MPwqkYZ0+pX2aiEwLHY62qA9L+hI/RBZ0IYAqyzUkkgNjvHkQVEZ8CLQISpOkIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197324; c=relaxed/simple;
	bh=p7Rx6qNuAwgaIK8zmFad1PXiQo0SfDFYMCJz06kHD8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5plIRglc1u/Jjd6EpvqAOfLgMz91XO8CwnUwcNkuHb7fyqXib0iuE8ThyGoC8ZWICzmotlNoFpcP+ADLyh3Dpw/XrNwGNXcWEyLGuUokulxgm8Rcn8+vcp6k5lEnhqRN/lWRz8tu72fcoQgJlgVGksC0hfcV4TLiyNDqlgytn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVSXDHrp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVSXDHrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B79FC2BCF7
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 23:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778197324;
	bh=p7Rx6qNuAwgaIK8zmFad1PXiQo0SfDFYMCJz06kHD8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XVSXDHrpJKD3xum7FnwZCCrA8iQEYbbX5GpPhqtER+Kb6ORUOY3o6PbYdaH27ErrQ
	 kOT8v1aEKkqxk3pXWvcFlkpl9WqFtXYrCXYyzwY9QlBKenIv8N4ArqaqEbDr34fGlc
	 v6s6uH/QYfdQQkmL6JKXVMxYqW1O2LOnJAsCod7JH6RB4mWoJSrBAIcwEzGXRaVPa6
	 9V2lo8OCSID8OvbS0r0xvh7WvOtEv0WIpowa09YfkGNLYVEfEfbosRNN2LybFa7EfU
	 UsV+GtnDWNlb2e/HbImt4blT9TVNkcaoufYLk3uCSmoQJLcp/3Fwxc2xjxD0jGNocb
	 Tq1eNGpBaQ4ZA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67cd93d8affso1655085a12.2
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 16:42:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8DR9m5fSFBLlnrOL3H/G2JFgDuhkBsAulBquSQzgauZ6LVZHspXXvyzrvNoIH/3N/mYxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw75fg94WTVBihKNlneF5qnAZ3NUu/vGT8B64mIKO1BAKtpRWA
	m8UwZiEokwQab+EgwvtfV6KSJn0+8bvDGkgtGmJ5JRs9uGoka78YQeOqjllQaxZBVX9uNlcwKou
	yfNMI4O5CYJqd3IdRISLnxH2KuoIctQ==
X-Received: by 2002:aa7:da02:0:b0:66e:e024:1a08 with SMTP id
 4fb4d7f45d1cf-67d646b082bmr4114635a12.24.1778197322778; Thu, 07 May 2026
 16:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501155421.3329862-1-elder@riscstar.com> <20260501155421.3329862-9-elder@riscstar.com>
In-Reply-To: <20260501155421.3329862-9-elder@riscstar.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 7 May 2026 18:41:49 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+GY5O-ygTHDOA8pVBDi_aKcmcJ0yt-3Rv4a4=Ygk66uQ@mail.gmail.com>
X-Gm-Features: AVHnY4JOM9jN3mcHfPknCHd75ZrjDOMLe5cKzgxlMhp-0Ek9NIaM4mPgQRK3hWI
Message-ID: <CAL_Jsq+GY5O-ygTHDOA8pVBDi_aKcmcJ0yt-3Rv4a4=Ygk66uQ@mail.gmail.com>
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com, 
	rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, 
	Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com, 
	alexandre.torgue@foss.st.com, ast@kernel.org, boon.khai.ng@altera.com, 
	chenchuangyu@xiaomi.com, chenhuacai@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, hkallweit1@gmail.com, inochiama@gmail.com, 
	john.fastabend@gmail.com, julianbraha@gmail.com, livelycarpet87@gmail.com, 
	matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com, 
	rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn, 
	weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 10:55=E2=80=AFAM Alex Elder <elder@riscstar.com> wro=
te:
>
> From: Daniel Thompson <daniel@riscstar.com>
>
> Add devicetree bindings for the Toshiba TC956x family of Ethernet-AVB/TSN
> bridges.
>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../bindings/net/toshiba,tc956x-dwmac.yaml    | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc956x-=
dwmac.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.y=
aml b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> new file mode 100644
> index 0000000000000..d95d22a3761da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/toshiba,tc956x-dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba TC956x Ethernet-AVB/TSN Controller
> +
> +maintainers:
> +  - Alex Elder <elder@riscstar.com>
> +  - Daniel Thompson <daniel@riscstar.com>
> +
> +description: |
> +  This node provides properties for configuring the Ethernet PCI functio=
ns
> +  that are attached to the internal downstream port of the TC956x's PCIe
> +  switch.
> +
> +  TC956x are a family of Ethernet-AVB/TSN bridge chips that combine a PC=
Ie
> +  switch together with a number of Ethernet controllers. These bindings
> +  cover only the Ethernet functions of these devices.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus-common.yaml#
> +  - $ref: /schemas/pci/pci-device.yaml#
> +
> +unevaluatedProperties: false
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1179,0220 # Toshiba TC9564 (a.k.a. Qualcomm QPS615)
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  # We can't allOf reference Ethernet-controller.yaml because we end up =
with
> +  # contradictory $nodename rules (`ethernet@` versus `pci@`). Happily o=
nly a
> +  # small number of the properties are useful on TC956x so we can just r=
eference
> +  # what we need.

That would be due to the error sashiko pointed out. 'pci' is for PCI
bridges (host or PCI-PCI).

Rob
