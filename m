Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1CC36F429
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790438449; cv=none; b=GhjTH9ujlcQ04zth/zBhXcqd5SOqFWOPruRHp4XccfA5IDxmwH1FhYlelRs6zMSGYc0atL4MkbivL8G4rFVYXNBCOgcW1P90yqjtkr+b2GQ2lwywd5Tb+TmE4J1xmVCOV5aWRuzIF8bV41iK9TNaUUdcfivlhSFz7F0l8zUWJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790438449; c=relaxed/simple;
	bh=bVUzZjxHMO8CHtvlSqa0+RggUMRBNcvulOYT5UeurPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqfrO31LWq/FdTCQXdUWL4WJneRGctpsuo5fR0p7pig+j9kpijud+Wp+jXSfe1IBE8kBtY/9kDYFplQ8FF/eMUZejT5k8DLZro/D8QnB64Q1jD8EvxA9w68Pqe3Rm7xjq5QWdx3C0leuy1jum/X2qBUsVUnqHm/CXgzFjkx1cFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1JjUSgZf; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1JjUSgZf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D08F14E4106B;
	Sat, 26 Sep 2026 16:00:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E54260749;
	Sat, 26 Sep 2026 16:00:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E4BD102F1E54;
	Sat, 26 Sep 2026 18:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790438441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mF1te5gqabP+5Yeutw1bTB4Li95rX1u1z21hvfD/sjY=;
	b=1JjUSgZf+1Qlrz9yaHy7YnGvulxuyne9Db1Z3hoIbBILjgLKvagOMrh6zXm+LtmeoyVAxt
	rE2m1OPP15bj1XPYkOEbcoxbID+IuvnZ84GmGO5sTu+2BTNuOzrefdZT1a6zOKZD55mwf2
	wdFfbgIYyvhqLsOmXhC6cKKHohYQ4QtfL8G9bjg4Zcf2j2AsxPLgx7xrUS6x8oOBUJ5AX4
	AESgI0lGEsivAPNmPxiednYXeSn+xeykI5WfkPM7O6P8suAq59Ijm5QUHSXRSRR79gad81
	SGTzRMyA2VZSktD6UMrxwbPibAFENNDjhx/wV/ZNquwjh7V8LZRcoJP+eRQf7Q==
Message-ID: <8ed1298a-4c29-4db3-b76e-c8d34f91b4c9@bootlin.com>
Date: Sat, 26 Sep 2026 18:00:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 00/15] net: stmmac: preserve datapath state across
 MTU and resume failures
To: James Hilliard <james.hilliard1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Joakim Zhang <qiangqing.zhang@nxp.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>,
 Voon Weifeng <weifeng.voon@intel.com>,
 "Song, Yoong Siang" <yoong.siang.song@intel.com>,
 Linus Walleij <linusw@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Simon Horman <horms@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>,
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 ZhaoJinming <zhaojinming@uniontech.com>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Ding Hui <dinghui1111@163.com>, linux-tegra@vger.kernel.org,
 linux-sunxi@lists.linux.dev
References: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello James,

On 9/26/26 17:48, James Hilliard wrote:
> Keep the stmmac datapath coherent after failed MTU changes or hardware
> resume without changing the interface's administrative state. Retain the
> working MTU configuration for rollback, and allow ordinary down/up recovery
> when hardware cannot be restored.
> 
> The fifteen patches put independent fixes and lifetime prerequisites ahead
> of the retained-ring MTU transaction:
> 
>   1. Correct the WoL/safety IRQ unwind order.
>   2. Reuse the MDIO reset GPIO across repeated resets.
>   3. Allow phylink_stop() to finish a suspended instance.
>   4. Freeze deferred AF_XDP pool teardown before device system suspend.
>   5. Serialize PHC changes and cache reset-sensitive timestamp settings.
>   6. Keep normal-size MTU changes running, including supported AF_XDP MTUs.
>   7. Unwind partial DMA allocations and fix saved RX skb ownership.
>   8. Keep DMA configurations and IRQ contexts at stable addresses, and
>      drain timer producers before cancelling their timers.
>   9. Track datapath and power ownership across MTU, XDP and ethtool reopen
>      failures, including noirq clock handling and unpowered-access guards.
>  10. Use the tracked restart for XSK pool changes.
>  11. Restore TC filters, steering, preemption mapping and EST before DMA.
>  12. Allow independent references to AF_XDP DMA mappings and UMEM pages.
>  13. Retain DMA memory until hardware confirms shutdown or reset.
>  14. Prepare device-local interrupt masking and DMA-handler quiescence.
>  15. Retain rings and IRQ registrations across jumbo MTU replacement.

Please look at the mailing list, several of these patches are already being
worked on and have gone through multiple iterations and reviews.

Thanks :)

Maxime
