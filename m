Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939D3B38A4
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169833; cv=none; b=YDACI0LvxsMkzAaPqswPjxXKw1wxlYjuDKecywVbouwh2aSBXIzIiiUakWLDVeuuJZSWdZz9FBKhHaUMZQFt0mQhmjSTcHXYwJUc54rR1DRSCa5Pdu09JdQiQXKnBmmf3jPMTeUUNyjUr1jaol5m5k44dAvCVJ0ea2dsVTdOf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169833; c=relaxed/simple;
	bh=nyA8o2NvivXKk37nVK14Jn6/jPyU2MxLgg1j2S3M6kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jcn2Wy7D8GrYh4Gy1ndh5ZqcXc04HOEX984eqBfRbkrgVeXAPNgnI+rkadcHzppjk1Wkb5RQVgRx3ehVugYgdbRX9uLpYLTSO2MC38vByxPDHB9MYhydXoL1d8pBOdiV78krmle2EeVa1XPGtUDfWENRlR61+pJLrZCdVgPl5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=hFgK90QU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="hFgK90QU"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso10416375e9.2
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778169830; x=1778774630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6okPXnC/tZolkk3p3FjZk+KFTlmCOhId/0Ru10JUIvc=;
        b=hFgK90QU4XWmKPmS4CWDYrSGByvZLoscsIY0nW0tBy+BlO4DjblFwX4HF9Bhuh4yrz
         6mn7QxC+9WocUW/FdrDGKSeYDZm5kjv3YqsZN3S13sP7+TPTbS53eCXXJmruLW7r61xL
         4MPPktTzvFe+ZNzpCpHLWszfcCPcpxV9+JTKydNY9m0SJhZ5qwa0Ij2S/giithN9imy1
         sQJ0rrYawyX4nV8ed8Ub3tH5Ztw2D/lFfYhyEkPqGeE6c0veVE89ZIbkHGW+nI8lz3AS
         3XO5Om+heBk0f8feSYf7sAUkVxX2qNEOOTwWJ+UtbdCyZmEkD749Pm0+iDD5r9xavaMe
         WENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169830; x=1778774630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6okPXnC/tZolkk3p3FjZk+KFTlmCOhId/0Ru10JUIvc=;
        b=jtnO7lfDYYezzrGHJsOicHmD1vOjL+KRBf5prN9tV0chSKoytmzZyznOMN1KjzRkcg
         V+OA3XCb6JNSzWaiGebFdPa8eLUpfzlQ/I9vgM9N2S8aimWiOp9J4z4Nal58HXVB56xz
         fTA20hPFelRqjVzXlj0DPI0TixEGA7M3MWeO6JAXZhvCAm31FZ2iqnODEsXrDCksqqWU
         W2gipu/4/ynDV2Yd4NOaISgOL7AuOQODEprXNZjmM7XvPg0JABX8P9WjLivcbVmY5s4G
         CVVaFCTuQshVG6S/Nwv0X1ZXhwv/DyCydJ/trMA8BOwo9YK2VqnGEXNWUBlFry5BxVjc
         eInA==
X-Forwarded-Encrypted: i=1; AFNElJ/QTQs2ahXJGDUeOG3x3itK2JIw7dSyHVbz0jHXLUwdoigWIYAGsWVOe223N/ACFsDd4vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCPYCcwiwUZ9Qb3ATWQU3+pHE62V/ANBm/0yfH17XSYbnyWlM
	NbMkIMmsdSfBLj5EONLspUHzgplELAa8lL/CD4uObeDfkmUXWVp+cF/M5hXy5Y/YKvA=
X-Gm-Gg: AeBDiet0PX0UTTgH2M0T2iuO0gEdCrP/bJA0xf9jHWUAsOGA2a72pmY+ckTYplY5U0+
	41ojZSEFlX5u4TnY44H+BNLh4r8PMEteEIBYItSGsYdPBsjnnDFAnB/oQ2SNKZuGxIXtb8bB1Xw
	WR9IYQK9HiI9MLu9rSvo82bI48sjJKbnthyWkDeFFwqFLXo+bg0p4txlFHBWHzwuEck1heueJQY
	yCMXjEEjGfTt6VWCbAQDJY2nWuFQNtzTpuYY4pwYX+O5GKuY3EPgdse/h2gMZuYyW8CSqP/Rt8H
	U46BRmkmRqYmk4bnAVa4gU/siUOpXKvJP/+CvewoSjZfj7pCHekUeUtCyVAcA6kqaR1xqPaHSOD
	kl1EwREA/JpoLDk/WJwVMKSZ+MktEizL20T45KVC3PTSczJNbm7YAuHWwxT41UR0aeUOgXHtJ8e
	EtYU7GDtEbp6o+4RdZy1qfr4XIPGDerD2fONhnl0d20YgFe6aykn6LAPpeC2hPKpdPw816gFDBr
	1d90I+WXRnE8n7LfdKCk84AInT4yZnLunBZR9GbT1+214zQ+auDscNF4P4UhJbEibCAIPEjS21q
	aEXxN6v7
X-Received: by 2002:a05:600c:a404:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-48e51f3e0f8mr128948435e9.22.1778169830360;
        Thu, 07 May 2026 09:03:50 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53907e8asm130198325e9.13.2026.05.07.09.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:03:49 -0700 (PDT)
Date: Thu, 7 May 2026 17:03:46 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
Message-ID: <afy34kj2hPxIlArO@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
 <2ce5897d-5bbb-486a-b0f0-0e30e54b451a@lunn.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce5897d-5bbb-486a-b0f0-0e30e54b451a@lunn.ch>

On Fri, May 01, 2026 at 09:04:58PM +0200, Andrew Lunn wrote:
> > +static struct tc956x_mac_speed mac_speed[] = {
> > +	{ PHY_INTERFACE_MODE_2500BASEX,	SPEED_2500,  SP_SEL_SGMII_2500M, },
> > +	{ PHY_INTERFACE_MODE_SGMII,	SPEED_2500,  SP_SEL_SGMII_2500M, },
> > +	{ PHY_INTERFACE_MODE_SGMII,	SPEED_1000,  SP_SEL_SGMII_1000M, },
>
> That looks odd. Some vendors implemented 2500BaseX using SGMII
> overclocked. But that is not strictly 2500BaseX. Having the 2500BASEX
> entry suggests you have real 2500BASEX, so why have an SGMII entry
> with SPEED_2500?

This is a consequence of the code that uses this lookup table being
called both during initialization and from the fix_mac_speed() callback.

During initialization we only have the value in plat->phy_interface to
go on so we run the lookup table using plat->phy_interface (which is
typically PHY_INTERFACE_MODE_SGMII) and with the maximum permitted
speed.

I haven't got detailed enough notes to allow me to double check but I
think there were problems completing the initial MAC reset if we didn't
write something sensible to the hardware during initialization.

During fix_max_speed() we get told to adopt 2500base-x. Reviewing the
code I can see we don't propagate that and just use
plat->phy_interface for fix_mac_speed(). I will fix the code to that
the requested interface propagates properly to the lookup table but I
think we would still rely on the SGMII entry to get sane initial values
to write to the hardware.


> > +/* We have one IRQ chip instance with 25 IRQs in its domain */
>
> One per MAC, or one overall?

One per MAC.


> > +static struct irq_domain *
> > +tc956x_msigen_irq_domain_instantiate(struct tc956x_data *td)
> > +{
> > +	struct irq_domain_chip_generic_info dgc_info;
> > +	struct irq_domain_info info;
> > +
> > +	dgc_info.name = "tc956x-msigen";
>
> If it is one per MAC, maybe this name should indicate which instance
> of the MAC this is.

Will do.


> > +static int tc956x_mac_setup(void *apriv, struct mac_device_info *mac)
> > +{
> > +	struct stmmac_priv *priv = apriv;
> > +	struct stmmac_desc_ops *desc;
> > +	struct stmmac_dma_ops *dma;
> > +	struct tc956x_data *td;
> > +
> > +	td = priv->plat->bsp_priv;
> > +
> > +	/* dwxgmac301_dma_ops needs extending to provide DMA address translation */
> > +	dma = &td->dma;
> > +	*dma = dwxgmac301_dma_ops;
> > +	dma->init_rx_chan = tc956x_dma_init_rx_chan;
> > +	dma->init_tx_chan = tc956x_dma_init_tx_chan;
> > +	mac->dma = dma;
>
> I could be reading this wrong....
>
> dma points to the global dwxgmac301_dma_ops, which you added a few
> patches back.
>
> You then modify it, changing two values in it.
>
> Doesn't that break any other dwxgmac301 in the system? Shouldn't you
> be making a copy of the global structure, and then making
> modifications to your copy? mac->dma then points to your copy?

That's exactly what this code does.

`*dma = dwxgmac301_dma_ops` is a structure copy, we never take a pointer
to dwxgmac301_dma_ops (and if we did, dwxgmac301_dma_ops is const so I
think we'd get a kernel oops if we tried to write to rodata).

Would to code be easier to read if we dropped the local `dma` variable
since that would make it clearer that td->dma is not a pointer? More
like:

+       /* dwxgmac301_dma_ops needs extending to provide DMA address translation */
+       td->dma = dwxgmac301_dma_ops;
+       td->dma.init_rx_chan = tc956x_dma_init_rx_chan;
+       td->dma.init_tx_chan = tc956x_dma_init_tx_chan;
+       mac->dma = &dma;


>
> > +	/* dwxgmac210_desc_ops also needs extending for the same reason */
> > +	desc = &td->desc;
> > +	*desc = dwxgmac210_desc_ops;
> > +	desc->set_addr = tc956x_desc_set_addr;
> > +	desc->set_sec_addr = tc956x_desc_set_sec_addr;
> > +	mac->desc = desc;
>
> And the same problem here?
>
> > +/* Called by tc956x_dwmac_probe(); return errors with dev_err_probe() */
> > +static int tc956x_dwmac_parse_dt(struct tc956x_data *td)
> > +{
> > +	struct device_node *mdio_node;
> > +	struct device *dev = td->dev;
> > +	struct device_node *np;
> > +
> > +	np = dev_of_node(dev);
> > +	if (!np)
> > +		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
> > +
> > +	/* Find the MDIO bus */
> > +	for_each_child_of_node(np, mdio_node) {
> > +		if (of_device_is_compatible(mdio_node,
> > +					    "snps,dwmac-mdio"))
> > +			break;
> > +	}
>
> It looks like if you put the ethernet properties into an ethernet node
> in DT, this might go away? Or at least allow you to use
> stmmac_of_get_mdio().

Alex has started looking into adding an ethernet node.


Daniel.
