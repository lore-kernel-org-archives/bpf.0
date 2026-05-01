Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4993CF032;
	Fri,  1 May 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654314; cv=none; b=JLPfdrYyDJft1ItJo42cSEU7ZihTVywr2kPmk0EPFZIJ2z5rs/FOXW552Kup4FHh8LykYlVRswPbW+lI1xs/ikkGOmFGOSMiJQqXj8Bc22b1KHPaMLtRxE/XCfWWHrRqdzOMDhpgStSbstn9ZdHJ8isLSxUs+fGgcsvBD3PXd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654314; c=relaxed/simple;
	bh=CTFis4He3t1/LFd4De7rN9wAVKxGHHY19eqLUCarLt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0tpjknyads3DfZm2ECcsgmi0NG56E+DI/5QMvT7rz+BLrxu0oXvofEkZpChmkqISdUPaP0foX5QI9qJJlU1XFNbo8UvF5g4EFJRE5TOMiHVR7IO44OBZo0HnvFjUEyeR8kNFya0TtQaGS21tc2iDYIO+TaxmdBSJyo5rlbNu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xrgHg38W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xrgHg38W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RgEmX7QWgKuD1xhClx3Y+N85BnaTDGrIn2lScP6LvKU=; b=xrgHg38WznelxoazLMABuUpg3K
	Cuv2JUXhNPm0pIm2H8VrqhbDIwFNhL+Op32WUoSqymwLL4xc1QLW10L0q1pY1ovTnR3HdNiWmiDUQ
	mMLyATdYrjaQ+gda2tIzVaJojM4cFRHvE+0vPm78KYHsVVzS/JMS1eXRNefXhrEu3k7k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIr4f-000qVa-3e; Fri, 01 May 2026 18:50:45 +0200
Date: Fri, 1 May 2026 18:50:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
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
Subject: Re: [PATCH net-next 02/12] net: pcs: pcs-xpcs: select operating mode
 for 10G-baseR capable PCS
Message-ID: <f9a581a2-02ea-4948-8c97-835cb7638b1d@lunn.ch>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501155421.3329862-3-elder@riscstar.com>

> +static int xpcs_config_operating_mode(struct dw_xpcs *xpcs, int an_mode)
> +{
> +	int mdio_stat2, ret;
> +
> +	switch (an_mode) {
> +	case DW_AN_C37_SGMII:
> +	case DW_AN_C37_1000BASEX:
> +	case DW_2500BASEX:
> +		mdio_stat2 = xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_STAT2);
> +		if (mdio_stat2 < 0)
> +			return mdio_stat2;
> +
> +		/*
> +		 * If this XPCS supports 10Gbase-R then it will be the default
> +		 * which prevents 1000base-X and slower from working correctly.

It would be interesting to know if Toshiba messed up the integration
of the PCS, or there is an errata for the licensed IP.

Anybody got access to the databook and erratas?

	Andrew
