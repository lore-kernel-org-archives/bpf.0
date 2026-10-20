Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530531;
	b=PKuvUbQQt/Uw8CLEJqZRmsWADtAlv2kW9O5vsizOt9UoDrya4hjc2wc8aKOA6/MUNYFn
	 cC4XnwrBh6TVLL0iOpG9d2O7XxWa1RpnFE4mrl+EVv/GhP2Le7J32smjVPSxDEyyGVL71
	 nBRFLQ6o2E7ewazVixM106S2zSLlFQKH4l+AVwL3Yz/ZRmbrjJel0jCV9Ad/nBdhBu8eK
	 DZXsY2QVba6T82ihhv42Au0apLUamp8gKBJqomUTHQx6945MP67oPiWJmuikaes2J6GYt
	 t853TA0Yi/B+9RDmHfdZRv6YYRZhhxUYNdll8RIAXiKU9feiyIM6FfIDrUxp5CnWI5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530531;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LHNZsy1AhmzsrhwZyxEBJo+bnbpDcTwMAklGp3PSgbg=;
	b=jqZRAZSB5Ze6MIgRRcpP9L0FtznhBZk0Q9mrhcBIGz6G6TY6TejBUISItByeCYBbhTjP
	 D2b15mtGn98POO1+aPtlpeWsvnz+IA8QRFldgYHqXbLnjLwiQ57k8FalfH6srH/cQmOYp
	 AB7U5Ro5up7JhLFsRfLFseph1qlro7k1SCTvVne7bcdk+D3yjnoNtas9wGYLT5A/3KWa6
	 U+SsafW6KpN+03u/fY6ALv7tTpmkqyxMeF7hjGw2TGONao8Ocsvgf2Yup4GUZVLDvhlr5
	 PdaRvM1kzazYil42t6ZUZOu6YBwgb8838CpIFSFf04ARr55iVYiVKcs6TFPLph7yHjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjHSLj6i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A82606A322;
	Tue, 20 Oct 2026 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjHSLj6i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90921F000CE;
	Tue, 20 Oct 2026 21:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530530;
	bh=LHNZsy1AhmzsrhwZyxEBJo+bnbpDcTwMAklGp3PSgbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MjHSLj6imdArMWL3vvkO7ju8c//mQbQeY5QXTMPxyT+Z6ghZHyG0SXQr41amV76SZ
	 aGCChnRkuifPNl87J4jDXC+XEhfpf4EXdAdS1LuAVo3yIkPjMwPZdz8UmUX8cAsXXH
	 XCtNspvjoUlRVJ0EaZpzvYr8sZuIoUpH1oLOiwtnRjusbuCb6vIzdtBEmpnAvsuZDk
	 rZ8koiGsJSFWBS5XxRVd9BmDlst3URLlogwzPx0q1besV0QenMGaGRyc3L16dc4Etc
	 hFJOIu3FVDB7xc58fmDLRr1AD9+TgQUzZuYalQ9ozgNlMW0av4O5qpmTbI3DPg58S2
	 hx0G+jRLJ5JAA==
Date: Tue, 20 Oct 2026 14:08:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Song Yoong Siang <yoong.siang.song@intel.com>, Mohd
 Faizal Abdul Rahim <faizal.abdul.rahim@intel.com>, Ong Boon Leong
 <boon.leong.ong@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] net: stmmac: Fix XSK crashes on stm32mp2
Message-ID: <20261020140849.12fc79ef@kernel.org>
In-Reply-To: <20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de>
References: <20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 10:57:20 +0200 Kurt Kanzenbach wrote:
> while looking at the TBS thingy [1], I've noticed kernel crashes. That
> happens when opening or closing an AF_XDP/ZC socket while parallel Tx
> traffic is going on.

Let's respin this against net-next. The merge window has started,
applying this to net would give us an immediate conflict and pain.
-- 
pw-bot: cr
