Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668920;
	b=JcB9EiwcKB4XXv0Q/aEG+gVDCS8XHpuXQolOuG7LU7/7yiBBI/egXY4boUDJv/IUZK2G
	 m+DiH5MCTyrC779OukRldsUM22QJupgykqR/lHjTpUErGt2WFVP2fhg/6Zc5g+XIv5fGl
	 ZZByEZlRpnJzdZJN5rssZZ6i/9RyZvCU2uVZrP5KA5T/b0Bud9Ay2jLppD4vp4b6EzhNI
	 N9OyCZKfHtmGASDqQAAyZRn8N4Uq61GXsIZeUebmn5Zdvq527hWxOhVKozeGDY17KFF5M
	 ugcBaNIZGAr7rx3DQSeh3+0pcnnO0LfndLESC6XzqOiCQjgsUmkpKoeWsrT+7T/OC8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668920;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VhH6+z3kKO1Bl5/znvKizz61KSkOxaasQ1jNB2IaQFU=;
	b=aYtLrOiPAfe/FFicjzzU1bPKHNyHr1lvH+ylZS+IDsds28K8fZP8eQe/4uI4GtvBoiYY
	 1qv6zgs+IDLRdMuF61DKjcHuGNyRVk6TotbNsfDl7TepBZhgSb2H/gNWpWWmRqrJ0wbQZ
	 nKDASEmBYsZMY0kMo0s6MJi5IKzp9srumHyeYU+uj3n8n3PmVJfMYhMNA2RmtY8EmeBoN
	 4LkDlKnuwDsvosXQ0ipy3YoKTnqVbTxHdJlrtwc3tzG2Ws4Y2gp/duOwU9wlkmhE2F02o
	 qN79ZG5JaAnKIIkRlyJ98ySZXAG0Q98q9FobyFEUpoW8RxsV9CqM8NITdQrZJtQ4IyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zbvy/0NS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72A606A31A;
	Thu, 22 Oct 2026 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zbvy/0NS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772231F000C2;
	Thu, 22 Oct 2026 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792668919;
	bh=VhH6+z3kKO1Bl5/znvKizz61KSkOxaasQ1jNB2IaQFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zbvy/0NS5hi8ZwGaL0mHdj6PEHhtbpZcgsb2Xp7eB8vNm91KXm6vAJ7shxoujBAe1
	 dhfj5zW9GQjv2ICnLKITKYEVzIPUmr/T43Jte0mZvaglbKkhuJTD/V6vQcS26uTCFt
	 OXasMXASP+V7SWvLS7aqv6WgFIHv/Z8rVTdNyptNUr0oy2H7iDd5b7kUaf0Cyoam5X
	 uCgKS1SFyrbOMkuvNTg7wMFXssb/Zd5v96NUXlFCeDqopZEQD/tE8951DjZUUkufjP
	 zYi24h+tNP9MH/3GJ/iZijRpORTplyqr7Cmi85uhX3LidPPNuictm20cp7A+p/XIxm
	 nQb5r+beBBOWQ==
Date: Thu, 22 Oct 2026 19:15:12 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: disable TX checksum offload
 for jumbo frames on bugged cores
Message-ID: <atnwQKwf8mfQT-2n@xhacker>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
 <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
 <6d1d99b5-1c3c-4e59-a0b2-e4d671e594ce@bootlin.com>
 <ata8k2EVDCDTmeE6@xhacker>
 <atbbRqSJIJ_glwuf@xhacker>
 <3ca537e7-c9a3-4306-a2f4-9c7d57123bfc@lunn.ch>
 <athAoWfW-xesPhFP@xhacker>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <athAoWfW-xesPhFP@xhacker>

On Wed, Oct 21, 2026 at 12:33:37PM +0800, Jisheng Zhang wrote:
> On Tue, Oct 20, 2026 at 02:28:26PM +0200, Andrew Lunn wrote:
> > > > Here I want to query a generic rule from netdev maintainers:
> > > > can XDP frame enable HW checksum on dwmac IP? Per my understanding, the
> > > > dwmac can only do HW checksum for normal particular packets layouts, such as
> > > > TCP, UDP. What about if XDP transmits a non-IP frame?
> > > 
> > > or a generic XDP guide from netdev maintainers:
> > > Since XDP can tranmist arbitrary Eth frames, so how does the eth driver cope
> > > with HW checksum if the HW checksum is intended for supported IP packet
> > > layouts rather than arbitrary layer2 frames?
> > > 
> > > choices:
> > > c1. Simply disabled HW checksum by default. Then XDP prog must provide
> > > checksums themselves, lost the HW offload cap for IP packets.
> > > 
> > > c2. detect the frame in eth driver's xdp code path, then enable/disable
> > > HW checksum accordingly. Then how? Any example in exisiting eth drivers
> > > is appreciated.
> > 
> > Why is this specific to XDP? Cannot the network stack transmit
> > arbitrary layer2 frames? Isn't this a generic problem?
> > 
> 
> network stack normal tx supplies the skb->ip_summed metadata, and
> dwmac driver specifically can decide to enable/disable HW csum
> by checking the protocol which is extraced from skb, example
> stmmac_has_ip_ethertype()
> But XDP path doesn't have the necessary metadata, and I'm not sure
> whether stmmac_has_ip_ethertype xdb version can be implemented or
> not. That's the reason I request generic XDP guidence from netdev
> maintainers.
> 

Hi,

Given above, I think the dwmac hw csum needs to be disabled by default
to make XDP always behave properly. Since this patch2/2 has been
merged, I will update my patch:
https://lore.kernel.org/netdev/20260929121025.20821-1-jszhang@kernel.org/

1.rebase on the lastest net-next or wait for new rc1

2.update the commit msg of my patch to include above reply.

Kindly let me know if this way can be accepted or not

Thanks
