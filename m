Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0FE3F0ABC
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081302; cv=none; b=tguur/a7EUC6DburTWU+f9pHU3WC2ZOjX0ElZticzxWCMwAn9NrLA62WqBGmnhGqBWJM/lmmK6xDYXZB8itFX+JldBhNWeZK5Wh6frEb1tK9aD97/OH7z/qYkTFSTkPoR1MrVSQXRayiFM/GXIOKfAoHRxT4YkOW7J3fkMKxxEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081302; c=relaxed/simple;
	bh=ZjEF3HpGwOZm1XS1TR6kZf0bNGfRZAZycuJei4ErS4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ssm6sZ1n3g/4RHRwwdFb/EIuQtfRK1Y+lAokKRjWQnBjYpogKj/EMc+QHCFZlzJCJn3owky6LIFq/EhbDkpba0TcXk+x0qPGq8KDW8Z+xLCWm6FmztU5vaCT2Fos8bDjKevtSsZqiipxRqWziHMvs/jIVfBG3t42sExg5COZEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=C+XW4o+3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="C+XW4o+3"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44da2de25f3so2454029f8f.1
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778081300; x=1778686100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGs4aXiGfe9FWzGIQNV1c8scbxohD/REqUQGlNaM17Q=;
        b=C+XW4o+3BpfIYq+R7bvkXpReBGJrMLl/LMNXIlRWJaDMCP8l12gnAozRU838922lJO
         RRMdFfzQKpQnWzb6ARXvdQ/RtmoNDrD6n6niAyKgqBRMYhB4EgtCI9TgzaWGrCFvQr69
         fFOwH466Yb5gBEBbxEPPUBIughRl1DS0H5ACmf77Pp1KVqBLSvWKdCqpaMHf8bQrkbrG
         WSEmp1uejt1RRMTrd2KyJVV6XAhyvlzZlZ6XjoIR5zHH8AFIBX7xOryI1vY82/TAmX2r
         QaH5nTkRIC2PshdIC8H4YqtCezuEp5OV4V4OailE6fk5iyxuluRnpcZi1h4qmNgHK/m3
         OkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081300; x=1778686100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGs4aXiGfe9FWzGIQNV1c8scbxohD/REqUQGlNaM17Q=;
        b=Ia3L4f5lXybthdqhieeWvOTlMhsK60GOPMGEu6/iNxxxLn/uklp1XU7iyfRgr77o9D
         J9cfyY5XxOThMJTCM5mzkOoxCJ5XjCUVv2uT63hsalFzl7Fq9tsV+PWNIDgJqAw5Vwpb
         PVkv8IXqEB7OcVfpO8ZCKECIR/XM2n9VthPllRHZUG/BUowMWHYjEG3/LROhpQrg/Hpe
         os6NN0SjXaRymv2mX4tGDErhMNb2DmZX3/t7o/65L4JKT20LYvkAk8XUz4rX1Qhlc/0b
         e63aFAH8rOTUNvlnihEAGwy2ioxQ3Zn2o7FYE25vaI5cyKVEgP4BmP6AiCcKiDd6s83j
         AsyA==
X-Forwarded-Encrypted: i=1; AFNElJ9HMXW9bzvh5BX/NOwMBXyUlZ8BeUBNS5wxWZhm1pVtprxVtgIhn8DCph7rm68eNZn9BFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6z56ApxnBqSdaas9I3wH67jtHKyLtNBEv83Gp2AAwvzRJ9r0j
	OMFLKhI2UlfzNvh+L7VyTkVsRnfiHAvT56A3ZkswFrF667FIt+ML1XJHiWrxzTz9j8o=
X-Gm-Gg: AeBDietXOrXRZne/v/SwceE/UopRSfv+KQMUDWuG0Qo6UXGSLg9cyq/dC2CiLy109Zw
	+M1GCJJJEz4Y1sSVPieAgbTkuaV8/RCxmq1P4Qbn43V1InzuesMpViiiZrDNq2TnpFtP+IC/UmW
	3nuuJN/IalHVrWsLEWc/DEXHQA7lPWp4WnsRRZA5xbEmUs1cJbPgV9Htp96YcRx/n5VuIq60jQi
	x8ryiDhaccaz5S7t5qegrAdxDp/b8KHRdp48CgH3NgQgRSJoVXZwNZPCbZK7RartvHBh2M2wGTR
	+qb/OwL9enYvvACYRqgpP/RQILFDqnm4jt4gWyh2mP83gItqmFckN7A+Z8yuvojm0S6z7ThHngV
	d5w/0CTec+Piwbfk3DyU+j0UoYpaZlH+Of5DW5+iE62t3/cGAMWrOqCefkM1pYOOIvcfbhASd3U
	y99rKrikslFcr0tYfsDuop7QhoAT3PSQhxslPjGgo1RigFZba54dYY9SZDeXnopNH3NHwL6Pytk
	diqSEuFBh7ugvR84bY9c5dkzm7AaOJbkiFPzWZS0XX8XGG+WhS3DxSLWY20qI3mH1kRcWxHpocN
	Szve2XZb86nSd0VqjfQ=
X-Received: by 2002:a05:6000:2405:b0:44e:902f:e341 with SMTP id ffacd0b85a97d-4515cf11ce9mr6889250f8f.20.1778081299271;
        Wed, 06 May 2026 08:28:19 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960902sm14773996f8f.28.2026.05.06.08.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:28:18 -0700 (PDT)
Date: Wed, 6 May 2026 16:28:15 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Xilin Wu <sophon@radxa.com>, Alex Elder <elder@riscstar.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
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
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
Message-ID: <afteD2d8d87Nyvl7@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
 <224E233C593EF171+8c8a43dd-5061-40f8-9eb7-f360eabf2ecc@radxa.com>
 <4015f47a-af62-441d-b1b8-a8598f963970@lunn.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4015f47a-af62-441d-b1b8-a8598f963970@lunn.ch>

On Wed, May 06, 2026 at 04:19:54PM +0200, Andrew Lunn wrote:
> On Wed, May 06, 2026 at 08:59:01PM +0800, Xilin Wu wrote:
> > On 5/1/2026 11:54 PM, Alex Elder wrote:
> > > +	/* AXI Configuration */
> > > +	axi = &td->axi;
> > > +	axi->axi_lpi_en = 1;
> > > +	axi->axi_wr_osr_lmt = 31;
> > > +	axi->axi_rd_osr_lmt = 31;
> > > +	/* All sizes (2^2..2^8) are supported */
> > > +	axi->axi_blen_regval = DMA_AXI_BLEN_MASK;
> > > +	plat->axi = axi;
> > > +
> > > +	plat->mac_port_sel_speed = speed;
> > > +	plat->flags = STMMAC_FLAG_MULTI_MSI_EN | STMMAC_FLAG_TSO_EN;
> >
> > I got WoL working only after adding STMMAC_FLAG_USE_PHY_WOL here. I guess
> > it's required, since the driver clocks down the MAC/PMA/XPCS in its suspend
> > hook?
>
> Nice to see somebody testing WoL.

Absolutely!

We recently stripped out the (obviously broken and partially ported)
WoL support we had in tc956x-pci.c. We planned to bring it back later.
Hadn't realized it could be so easy.


> In your testing, is it the PHY doing the WoL, or the MAC? I assume
> PHY.
>
> If i remember the DT correctly, the PHY interrupt is connected to a
> SoC GPIO, not a GPIO of this chip.

On RB3Gen2 (and I think also the QPS615 reference design) the phy
interrupt is routed twice. It is connected both to the TC9564 GPIO
block and to the host SoC.


> So for your board, it is the SoCs
> GPIO controllers ability to perform the wake which is
> important. However, where the PHY interrupt is connected is a board
> design issue. Could the PHY interrupt be connected to the chip? Would
> the chip be able to wake the system? Should STMMAC_FLAG_USE_PHY_WOL be
> conditional?

I couldn't think of any reason to use the TC9564 GPIO block for the
interrupts on RB3gen2 so I left it unused and the DT describes the SoC
routing only.

However if TC9564 were to be mounted on a real PCIe card then we'd have
to use the TC9564 GPIO instead and would have to leave enough of the
TC9564 enabled to handle the interrupt (and also to load a firmware to
catch the interrupt and drive the PCI wake up signal).

However such systems would need extensions to the current driver. We
have done all we can to make it possible to add those extensions in the
future but we would not be able to test them: not only do would a real
PCIe card need extra driver features to play nice with ACPI but the
card would also need an I2C EEPROM. We don't have that EEPROM on
RB3gen2 (and again, we'd need firmware to read it).

TL;DR - there are conceivable (and sane) hardware designs where the
interrupt goes only to the TC9564 GPIO, but they are too different to
RB3gen2 (and related SBC designs) for them to be supported before
they exist!


Daniel.
