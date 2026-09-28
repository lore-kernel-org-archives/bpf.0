Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB049332EBD;
	Mon, 28 Sep 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598182; cv=none; b=oPKNPMVSnp9e0JhSvEw16XMeYfIsfMUZe76Mswy9blLWTvcnlaMrg5XYndT1JiYn4ESQSS6odjK3z+mqUEiegGJi5GDdyAnbN+C1ty99PhOaE2DQCkMAb6JydGX3/mDtpdGrArGUAoN7m0KEG7+iap9ozjdWpV4qlWNSUyu3jb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598182; c=relaxed/simple;
	bh=6fwJ4i3NDqYT8BexAHF55cqi10Og3PkaSv4LXWi0VG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lTjladIp/1iu1hbozwh9kIGI60vE1VMvbaUfvo9R0gqNaTrSyW3OiXJNtNJjWSTLfU0XZhNU01rUtWO1L2WCFYGVjRuFjxkk+lvBshFy2gcU8ZPlAtL9+xAnOwRX50k+g6F/1K+idRvl/UG6JS7wag0bZsGavxUvWNHp52jKJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCMTonux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCMTonux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB151F000FF;
	Mon, 28 Sep 2026 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790598181;
	bh=6fwJ4i3NDqYT8BexAHF55cqi10Og3PkaSv4LXWi0VG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GCMTonuxt0X9cGbbLXwM9v+dUY4s/DLM/5HBoABlAfRf7Pc3beikMJzuZ7VzFTmpx
	 SQxjixgjnxTMt/ASnUuBaTnVlPHllDXh1hoP4RI+wV3mKC6qvnzGuuDPSmt4KDx1NJ
	 X68eCaCRPbLqNaDvn+OztXSnQoR56kaZXJUFzcHhuJt9mJ5HYFVY82OSQriRV5TnVF
	 iQcAS6+scw/YOl/P+5qecNySMY8IdBLNRNUJq/hecldhkYQVkh6b8oHhXdjjVQDYYT
	 FU9rqL4wlUzR8GrVSZ29UjS7u/hhl/K5FhR2oLsq6GoCCYwz1HcDoyPt+GdUgfsTWl
	 6zIVhvIrgAsLA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, Suraj Jaiswal
 <quic_jsuraj@quicinc.com>, Richard Cochran <richardcochran@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Ong Boon Leong <boon.leong.ong@intel.com>, Voon
 Weifeng <weifeng.voon@intel.com>, "Song, Yoong Siang"
 <yoong.siang.song@intel.com>, Linus Walleij <linusw@kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Simon Horman <horms@kernel.org>, Thierry
 Reding <thierry.reding@kernel.org>, Jonathan Hunter
 <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Jose
 Abreu <Jose.Abreu@synopsys.com>, Yao Zi <me@ziyao.cc>, Philipp Zabel
 <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, Alastair D'Silva
 <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, ZhaoJinming
 <zhaojinming@uniontech.com>, Lorenzo Bianconi
 <lorenzo.bianconi@oss.qualcomm.com>, Ding Hui <dinghui1111@163.com>,
 Linkui Xiao <xiaolinkui@kylinos.cn>, Linkui Xiao <xiaolinkui@126.com>,
 linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev, James Hilliard
 <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v5 16/19] xsk: allow drivers to retain DMA
 mappings independently of pools
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-16-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
 <20260927-submit-stmmac-reset-fixes-v1-v5-16-feec6c14dd06@gmail.com>
Date: Mon, 28 Sep 2026 14:22:58 +0200
Message-ID: <875wzp4lb1.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Hilliard <james.hilliard1@gmail.com> writes:

> An unsuccessful device shutdown does not make its DMA memory safe to
> unmap.

Why does this need an AF_XDP API? Can stmmac fence DMA before releasing
the pool? Please show a case where stop and reset fail, DMA remains
active, and the driver cannot isolate it.


Bj=C3=B6rn
