Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499335;
	b=ZP+M8Jrq3gbakAQ9f5a96AmAE9FEEX2qJClMjl6gP1OdhcliW7a86sRrIRVjEgzo6WEo
	 e2ls0Utxfc21f60ORqdrGtnINFXrsFzP/PeasIsLMDqQzMumoT0p5gXhSz91ZS/hoxh0t
	 fXcsTQZ2PlO1LJgjjdRYY45/u4jnTMgixZzL6UF0KTelL4h42g44qrgLJQuD3/c2+5X4i
	 gkgcKMt5RTp+7LGHpLBVEHkgJF4h1ms6z6INLlLCEuCEJb4fbRSJaRV2J7iyffSiSLQjl
	 pq67NY6HTUviWlnE3wfCS1bAmx8oTslLlO/m5e2x/iZO9szR2dQJZqD/Ec84O8rfIEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499335;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=JNRVR38d3ey44exqQ8HnB3TSKDb0dhwLcVuiN0wut7A=;
	b=i30hlWYVZoUhQZ2V2jfthdQpRJYVjwtZREgqZglDw0b5TvwmGw31GFpHKuUhw0lgHP/S
	 alNlXjMCPmHUKXKhWzDcHrAhNFBW4May/IMsaYLDqIxtgAl8iycEviJ5Uds+cqXQjEn2o
	 YO2EWl1dIc4jfye+c1qxVDO9NYGa+TP+0sK7lb7zigeV1itc5/dgv5b78y/jZTywQghvt
	 oO8+TV07YJMIiFWpgfgMu+29S6PLavJlBA74orkYxILqIIuhy2T11/uPEw0lL4+5kSR0r
	 SlLnr9HW0HpllA0D2BhhF12QALBKi1NmY0V68PwLl0kjiLk0vlbvGChjCZTDXZDKemQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=RsfrEJLC;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661C606A31C;
	Tue, 20 Oct 2026 12:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5661C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=RsfrEJLC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JNRVR38d3ey44exqQ8HnB3TSKDb0dhwLcVuiN0wut7A=; b=RsfrEJLCHO5hSv/GDMbRHFTY/L
	vYL6IYeg0ApurcmouAUx8GR/SVM6grwYlMQEFsKs3n/bE0m8ohLoafSrkCe7G/kPSBL/ldA4JepEk
	MP1rcWc9TnjSZN3OhVpMfZyN5zVJwK38ldDujk0/wrXc4IdiEUPmOV2mdMDwW5XoOWBo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJ8x8-00Bqa9-R1; Tue, 20 Oct 2026 14:28:26 +0200
Date: Tue, 20 Oct 2026 14:28:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
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
Message-ID: <3ca537e7-c9a3-4306-a2f4-9c7d57123bfc@lunn.ch>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
 <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
 <6d1d99b5-1c3c-4e59-a0b2-e4d671e594ce@bootlin.com>
 <ata8k2EVDCDTmeE6@xhacker>
 <atbbRqSJIJ_glwuf@xhacker>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atbbRqSJIJ_glwuf@xhacker>

> > Here I want to query a generic rule from netdev maintainers:
> > can XDP frame enable HW checksum on dwmac IP? Per my understanding, the
> > dwmac can only do HW checksum for normal particular packets layouts, such as
> > TCP, UDP. What about if XDP transmits a non-IP frame?
> 
> or a generic XDP guide from netdev maintainers:
> Since XDP can tranmist arbitrary Eth frames, so how does the eth driver cope
> with HW checksum if the HW checksum is intended for supported IP packet
> layouts rather than arbitrary layer2 frames?
> 
> choices:
> c1. Simply disabled HW checksum by default. Then XDP prog must provide
> checksums themselves, lost the HW offload cap for IP packets.
> 
> c2. detect the frame in eth driver's xdp code path, then enable/disable
> HW checksum accordingly. Then how? Any example in exisiting eth drivers
> is appreciated.

Why is this specific to XDP? Cannot the network stack transmit
arbitrary layer2 frames? Isn't this a generic problem?

	  Andrew
