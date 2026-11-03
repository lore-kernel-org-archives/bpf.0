Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713676;
	b=sKfCh2Gvx1V/ipd0Gmi81veNhX5TvMu/DOmIkgEdIfR8n5XrT+Vx7aRzS5ObmVj1Z/EW
	 3EeDfEXWQu1pyE6ulenj4BldT8jJlcwj8nD12r7ESSnu1Xv0/cykmbKu8L+AZKn4ZoVkC
	 nv8j3MpBeg8kn09UngL+E1TVkVP005zjFEpoU9QdrXNJOCMKq26menIpTRIij3VDYFt1j
	 5bshmKeHYVWHPtkoJdlBJ9gAAqHmBhkLLMs80D6jxuI3i544VEpPdVBA/RxopZ+6aou6B
	 Bn+72CnreYlYy/ko9wuCIWz5HBJN7L+6EH8/p/2Ti5C5xOtNnQgpqjOc4BptBB6B8lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713676;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=bUoP3KIGCAm0xwt3Z15aBvbUhr08siqGySkpr9jx0II=;
	b=nx3Nxl3QmHMQf7UR1xpB5OkeuRc64LTUJii58Rsv2gDj/X4CSJ011xCdz4Zbn/shwrI5
	 VfKwxsHp7SNONITj+NWhA5koSmBsipL1f0CZJAcWrpFV2sRzCE5U64X1uYvcwQyAUdI3k
	 u6zOqg2ZoHcAYdfSsWC7dP88r8qkrHGCDRCvVGSNhpmBYD4SN8AdQc9qe+l8nJ5ePWcTt
	 2uu2ioauKEqvC56s88DiOu98vVRNxBdD0IDHnqBaTl0DkMeiZS5r7KGw81/YV0BGErpeh
	 uEoB9aqECXgvmOkVaN033t372ZZePkjJRnvjCNWlqILUCAOAuGJopYHFLCKot54aMUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="ESvA4/Jp";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D44606A328;
	Tue,  3 Nov 2026 13:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D44606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ESvA4/Jp
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBAC4A1608;
	Tue, 03 Nov 2026 14:47:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793713672; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bUoP3KIGCAm0xwt3Z15aBvbUhr08siqGySkpr9jx0II=;
	b=ESvA4/JpvRFHG1JdoykgCugdbYm2RqvacQyesF9UtwALRjJK9UsmqSJKKPng/fXpkA5tt5
	dwyd6hA4Lr2O2uL17PlQChGLg8ORfppfVQubGTSxEUJt8FxTzB6zZbpJwuxKCeaim/nSk4
	KkD+G5+2vtL+mhOhH3f3/20sqPQCfn4iy6wbrSSgwpP8sDFwxlYe6c2akd15/EYmEOmWLC
	gBBtbzU/HOGOq2rSx/agRyjI8t+TKK2nU3jCujchVpckU/coQibIQhQYA9kaivyj2jDPT7
	9TEAWipqDjxvl9PzfR1D2TsIzuBf3sD9Exu05zWlsyiz8HVZ5H9E7JKwODBuwA==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 14:47:49 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Song Yoong Siang <yoong.siang.song@intel.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: set XDP metadata length on the page_pool
 RX path
In-Reply-To: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
References: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
Message-ID: <3ab1926864137534eac81371ccadf3e9@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo

On 2.11.2026 12:46, Lorenzo Bianconi wrote:
> stmmac_rx() initializes the XDP buffer with the metadata area valid, so
> an XDP program can reserve metadata with bpf_xdp_adjust_meta() and 
> write
> it in [xdp->data_meta, xdp->data), for example to export the RX 
> hardware
> timestamp obtained from the metadata kfunc. When such a frame is passed
> to the stack, the skb is built in place around the same page with
> napi_build_skb(), but skb_metadata_set() is never called.
> 
> napi_build_skb() clears skb_shared_info up to dataref, which includes
> meta_len, so skb_metadata_len() stays zero. The stack and TC BPF then 
> see
> an empty metadata range even though the bytes are present in the skb
> headroom. The AF_XDP zero-copy path already records the length in
> stmmac_construct_skb_zc().
> 
> Record the metadata length after reserving the headroom and adding the
> frame data. No copy is needed because the skb is built over the buffer 
> the
> XDP program wrote to. With the length recorded, the software VLAN
> stripping path can move the metadata together with the MAC header, as 
> it
> already does for zero-copy frames.
> 
> Fixes: e3f9c3e34840 ("net: stmmac: add Rx HWTS metadata to XDP receive 
> pkt")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
