Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6922D8391;
	Sun,  7 Jun 2026 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780854491; cv=none; b=Ig83NwOu6mgPn/10lFNncc2NtUNpECAa+zr5waVtXRLNOgO0vhMrU/4mmMBqpahCXJqKxLyPV0YkTp7pMHitLdgQLSOT4daf4zjsmEr+p9IJl9OfT2koF/rAtd1kIsaIiOTJTPkxaxgDEnU+3gnVzTov+RdH6MrRMeG39lTOzTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780854491; c=relaxed/simple;
	bh=vhAEZTC8qFssdX7V7evYRjIDzbHRXZRsjneOPqdZQl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3uUtcDq+CmCaGLI7dB72fTGX5yLWClt/La1hnwTxi89DjnMFQ8+TuzFH7ZDtW/2Th/Q6GEYnEK3T9L+8xdEPl1pEjD03xsYvuKsdskEneDHHj25O35tMLBcMHw4MyX1psSg3fYBzN77CENu1OE/X+u6+vIJzGVaK2hEVJLE2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PiWeJiep; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PiWeJiep"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2xtDkA21NeZRaX1G4a6jGRcwZXTTpKAlx691TaVn4bs=; b=PiWeJiep9JIlVFLuSrzn+fzmqk
	NctgIppNAiVpisjN2sQqaFgTZDzMFgGFvXPx3TMJWJtDhr20QqM4hIG4k7mmv81noHJ8T3KG03Z7v
	S4GAQiJ+shhLynijk3+hRPi0yuJ6jRi1kKcwBqFRng9db2ilr1XkZZWxRUbS2bokyHAg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWHan-006UUN-T8; Sun, 07 Jun 2026 19:47:25 +0200
Date: Sun, 7 Jun 2026 19:47:25 +0200
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
	mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 03/14] net: pcs: pcs-xpcs-regmap: support
 XPCS memory-mapped MDIO bus via regmap
Message-ID: <1ef2c525-e58e-4b1b-8150-4ff7d8b9a730@lunn.ch>
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605010022.968612-4-elder@riscstar.com>

> +struct dw_xpcs *devm_xpcs_regmap_register(struct device *dev,
> +					  const struct xpcs_regmap_config *config)
> +{
> +	static atomic_t id = ATOMIC_INIT(-1);

...

> +	snprintf(pxpcs->bus->id, MII_BUS_ID_SIZE,
> +		 "dwxpcs-%x", atomic_inc_return(&id));

dev_name(dev) should be unique, and it also makes it easier to
associate the PCS to the MAC when looking in /sys.

	Andrew
