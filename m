Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A937CD3A
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197191; cv=none; b=obb5toQJjCzw+lr6+muBHZVtfq50A9Kn807I7HcxsWh86loGnqiB8Bvir5ZNP6M72Qn6aEjJsb/SQUR/sAVGs6EOgJeaED4YCku2C54WQVkvNUphSly+tXe/8BFgdDClOIkjJPSgtepLmGg7xwvtw++6tTtm2YQbnmTwR9Bksmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197191; c=relaxed/simple;
	bh=vFH+WCKmJFo+oFxj5WEkyqvJ7Aj4l64pwYaHYcrT4og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVhCNpwPjkAr1BEJMDavA72sL5fkVFZP1wUxSH85SCpeScWhUSUWk3Huxg+n3iY72frH4bKUyxgiqNAek9JDq9YoqAnAYTLqPBeL0n5dCjIa9EJibLLNvmc5eJnqd1mPZFrA5wTY8fLkpJlz1D3e4Ztv88fqS1Dbx8tq5aetncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBjtjc2L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBjtjc2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31332C2BCB8
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 23:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778197191;
	bh=vFH+WCKmJFo+oFxj5WEkyqvJ7Aj4l64pwYaHYcrT4og=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LBjtjc2Lm5qrd6al15nb0i0uSedoamuYwFmr6YVsd0RymJLjxbkPxwXGXFi1Hr78B
	 u5LAekc0WgzfpeNY/6vP6MNLiJJAaxdJyq+4Dv5MtLT2lFa5BHLIxUIWIfqUktRLXX
	 sXnjcfV4xB5p2zAcUwIR9/KYReIhmlzhaptb+rDOZaExOdmufCw4TLcjwu6191C2h1
	 M/ULslZeP6DMCWkIan0Fm+yxpBtcS3zRA7KuA7Upcy5bkwJEYHCRwUx16zKBfFlgCl
	 FXiEUSzBcsPPxVqA6lfmG7xbduOdcway7BhViJh6BZK1aJr/ZNo+qNSS4O8AumvmKt
	 JKOmgTB75OZ+g==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso2590634a12.1
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 16:39:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8QfspPGL8u5EsgCEtjGXWSL9Df36kCiQt1Wp4j7THyDRloyUQYNSV5gaUtkUdhtGv7WYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwryUBmC0kHx09e9QQLN7Bv9n1U0fl2plBHWSs631ZgD3YpRuTZ
	GQcI0w1b+8pyuYNHXXD0mlK2He++t6zSaah4tPqgyRq1lDvL9xtOwDs4RtOWokXT06Q+AsnEZls
	k7gFIhsr/iotkExaT6lI+3HnnGYVU9g==
X-Received: by 2002:a05:6402:2113:b0:67c:1ed6:2793 with SMTP id
 4fb4d7f45d1cf-67d648a74e5mr5797376a12.22.1778197188726; Thu, 07 May 2026
 16:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501155421.3329862-1-elder@riscstar.com> <20260501155421.3329862-9-elder@riscstar.com>
 <1f34cbce-e2dd-4e80-b136-55d0efa50002@lunn.ch> <967c1d96-9a48-48de-b7d9-58b63e782aee@riscstar.com>
In-Reply-To: <967c1d96-9a48-48de-b7d9-58b63e782aee@riscstar.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 7 May 2026 18:39:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKayEDa2-FDoxM_JU3Yvevd-Gs_eFKCQ8NY8A8oBsD13w@mail.gmail.com>
X-Gm-Features: AVHnY4K23N33ivg6cLD9mNxL7odw3uUNL3DiEAJ7jfws_C2Zwld0dAM-keay8pI
Message-ID: <CAL_JsqKayEDa2-FDoxM_JU3Yvevd-Gs_eFKCQ8NY8A8oBsD13w@mail.gmail.com>
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
To: Alex Elder <elder@riscstar.com>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk, 
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Daniel Thompson <daniel@riscstar.com>, 
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com, 
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

On Thu, May 7, 2026 at 5:17=E2=80=AFPM Alex Elder <elder@riscstar.com> wrot=
e:
>
> On 5/1/26 12:38 PM, Andrew Lunn wrote:
> > Why not add an subnodes for the ethernet interfaces?
>
> We will define "ethernet" devicetree subnodes of the PCIe functions
> in the next version of the series.  Something like what's below.

Are they PCIe functions? As in bus, dev, function addresses. How to do
functions is already defined by the PCI binding.

>                                         -Alex
>
> pci@0,1 {

The 0 here is devnum and the 1 is function.

>          compatible =3D "pci1179,0220";
>          reg =3D <0x50100 0x0 0x0 0x0 0x0>;
>          #address-cells =3D <3>;
>          #size-cells =3D <2>;
>          device_type =3D "pci";
>          ranges;
>
>          ethernet {
>                  phy-mode =3D "sgmii";
>                  phy-handle =3D <&tc956x_emac1_phy>;
>
>                  mdio {
>                          compatible =3D "snps,dwmac-mdio";
>                          #address-cells =3D <1>;
>                          #size-cells =3D <0>;
>
>                          tc956x_emac1_phy: ethernet-phy@1c {
>                                  compatible =3D "ethernet-phy-id004d.d101=
";
>                                 ...
>                         };
>                 };
>         };
> };
