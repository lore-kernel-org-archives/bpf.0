Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597B301468;
	Fri,  1 May 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656146; cv=none; b=ABVuQF8uYm3xjYG5D85izC8BxHyjldsK6H/L0LboNXpAWEABeL/GekS5VHeNCo7ujSvjHovT7asSMg5op6QaH9TQ1ffpVF483R/tZhm/tX5bo0CuGKSmYW7R1P+E33DDtALVH1Z9k0Ix4RiRgMsn2dM3X4v8BYnle9gJ+W1zNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656146; c=relaxed/simple;
	bh=pWzpbdLksnPd8kSivlO7WT5uN3nawzP/rQZWXsCGIWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmAGardE4x33lMfFuOOIgs25BukiJiw8t7Quce8x/lMdZhNUS1nFJpefO+1pwb9aFmM6rnINTE0pTOLvzdQQsheSi8OsTy2K9G0V5IJqOzfquCkOhzm0EGNpvqrhtfSG+Ur5XNgVn3PFDzhyjoTvJ+2jV/4K735oV+UKfLhhHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3ooCs7Vk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3ooCs7Vk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SwiATigxaIsNEJNb6TA2aHz+p+NGepW56ALj5gkDRG4=; b=3ooCs7Vkrx4fZwYWsBPIMUBZEs
	EEP0t6lZIJIZaJyPnnt5FPRYpVnMHEXpy7YBIDkRFBeoYWpS8m23bGDsyIQnJGOtkQj16pBU4G9oa
	JCai3Ie1xvAMoitw3cDAslP2FIT3HPzLOtxYimdxOlBS+143TO4PMiJ6Zn42eB3cNlkM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIrYk-000qfk-5n; Fri, 01 May 2026 19:21:50 +0200
Date: Fri, 1 May 2026 19:21:50 +0200
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
Subject: Re: [PATCH net-next 05/12] net: stmmac: dwxgmac2: Add multi MSI
 interrupt mode
Message-ID: <f66c2e6e-2c3c-47d3-bd27-3facaf849190@lunn.ch>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-6-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501155421.3329862-6-elder@riscstar.com>

On Fri, May 01, 2026 at 10:54:13AM -0500, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> Currently there are no XGMAC platforms integrated using the multi MSI
> interrupt mode. In other words no existing driver sets both
> DWMAC_CORE_XGMAC and STMMAC_FLAG_MULTI_MSI_EN.
> 
> In order to support systems that do enable both options (such as the
> Toshiba TC9564 whose driver is currently being developed) we need to
> add logic to the XGMAC DMA callbacks. Happily we can simply
> replicate similar code from GMAC4. Let's do that!

The word replicate made me think it has been cut/paste, rather than
being refactored into a helper. However,

> +#define XGMAC_INTM_MASK			GENMASK(13, 12)

#define DMA_BUS_MODE_INTM_MASK		GENMASK(17, 16)

Different bits in the register, so the code structure is the same, but
the code cannot be shared in a meaningful way. So this is O.K.

    Andrew
