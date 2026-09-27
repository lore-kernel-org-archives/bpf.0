Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F3284880;
	Sun, 27 Sep 2026 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790547047; cv=none; b=qw2yyRd5KZjiaqBZeBz05OazaSCLCto6+4HR+o0T+oxkjlUlVy4qIdQ7sMWAsYUavAPcUW44tjEsTxjd3ahc5O8AarTco2rgb1G+GU54fh6o65oSnua0lrus4cKrKSGmHRtn0Y6dxbdF4XRQthSlj8JWkaeYHlqw4vqroLebshk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790547047; c=relaxed/simple;
	bh=jIdgRBOsRW1TtgaCNmjXamxDDZtw9OZfuArBIc9mxNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAxVIlVvdqc9YRi/qmBwIVwSJFOAReQOlJz50o2OGHyKRl51BS3PPx04BCqEpPbgxdXSZtRXc0hQGsb+3MDkusnwEelVf65I2Oh+hhunLcdys6ltygPxs6cx/0zLAKp6gpE/d1kw4gRsXKzR5CdWoZBh6x8+eoj2+l9j7yAwZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIVjtsTE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIVjtsTE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B2D1F000FF;
	Sun, 27 Sep 2026 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790547046;
	bh=jIdgRBOsRW1TtgaCNmjXamxDDZtw9OZfuArBIc9mxNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kIVjtsTETDjHyHlIzLfqL1PnL67SD8BwIlDBR5xowGDIzi357TG+ZybNlKMVV2sSP
	 QpivesH3HOkN5Ux1ZT16H8WUVs+oPnEFRMQNkL52/byLyli9GDKt6qWEMaUcppkhoT
	 16VKPIOoPlX40iE6GeikJgqyyrGzZqwhYauG4gDnf1SL0EHieyj9cGE3A8pvkmJE6W
	 oBKVDgWFl2PsrfDHpjcY/8fXTZ1KyqKIusvfmeLKbMRTNzC2czmsNUY/n/3PpbhTOF
	 Tnie5Hudsa6qHvBMIr9MgRfdzRY6pJpOz5o3sPkbOfzy1bIQv7/OIPFLqspQkd2auL
	 KaORu8Ubyr0XQ==
Date: Sun, 27 Sep 2026 15:10:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, Suraj Jaiswal
 <quic_jsuraj@quicinc.com>, Richard Cochran <richardcochran@gmail.com>, Joao
 Pinto <Joao.Pinto@synopsys.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>, Voon Weifeng
 <weifeng.voon@intel.com>, "Song, Yoong Siang" <yoong.siang.song@intel.com>,
 Linus Walleij <linusw@kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Simon Horman <horms@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Thierry Reding
 <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>, Richard
 Genoud <richard.genoud@bootlin.com>, Alastair D'Silva
 <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, ZhaoJinming
 <zhaojinming@uniontech.com>, Lorenzo Bianconi
 <lorenzo.bianconi@oss.qualcomm.com>, Ding Hui <dinghui1111@163.com>, Linkui
 Xiao <xiaolinkui@kylinos.cn>, Linkui Xiao <xiaolinkui@126.com>,
 linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev, Rayagond
 Kokatanur <rayagond@vayavyalabs.com>, Ding Hui <dinghui@lixiang.com>
Subject: Re: [PATCH net-next v5 00/19] net: stmmac: preserve datapath state
 across MTU and resume failures
Message-ID: <20260927151043.7c8dfb36@kernel.org>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 15:59:35 -0600 James Hilliard wrote:
> Keep the stmmac datapath coherent after failed MTU changes or hardware
> resume without changing the interface's administrative state. Retain the
> working MTU configuration for rollback, and allow ordinary down/up
> recovery when hardware cannot be restored.

Please read:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The limit is 15 patches per tree, you have 22 outstanding to
net-next right now.

Violating the limit again will result in a temporary ban.
