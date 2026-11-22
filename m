Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375319;
	b=VXvKB6DBgplTNECWSWMJSgU5qz4j0aPB3xh7OHAMBZB+F0GTHV5mcWhMtUlnxKe7GpuL
	 O1Am3ZXcHXHDbr7dzZiOQTlyQ+GGPh4BnJ2qZajrSEfLNzucHWaDxPSacMUqM/uAi1gEm
	 +PzaGz3q40EZqKqFeIEoSwNXKeeUuYjOt/TR6wBwgGQblhP4+3bffs+jeUn7eRYkT0n54
	 oQmwBHR9uT6yvctQNaImGR/lCvvX46pXNMhT3B2FDq9SYd5nu3N6hTwOorWcBv//u1msD
	 o+igPpeuRpi5kMY5x7rdqqnE85+4dC4b0U3BexYCWSrBwA1FbBb/frg/ooyxb5DV/xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375319;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=h5MusH8IV9Na7fO3T7L7n/MZBiLsXQrVcpOP8ORgtoc=;
	b=i57i4+fYlXR7GsPDAyMqf3J73QquVfKOUW/n8wt4S78rPOGA7qO/vzsjAGHAhBn0K+cU
	 zRxyINqZALw3cBDku6dG0ollhyrqc4lerrgngp1zaVFRRvMwgmSyaS2oXom1h+N8lldPZ
	 0aEKqwE1JFCp+4m4hmXwf6yFv5UcAcidrco9VfS19MkLLXsapfIA5j3c8+9yv81wQAW/y
	 +Y56f2CqIgT2fSJoxbB5FgqL8fULZt/7X8ZZBA4dtsza3tME9VxFDjwgVRxcUCLC6du32
	 aENCvmnH8bjcBFbz72Svz9r+naxaXmuKZammDMyU9QyR3/n/7Mnbn9xfnB/HzVZOU9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=rEM2Jbmk;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB8606A320;
	Sun, 22 Nov 2026 19:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBBB8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=rEM2Jbmk
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A7CC2A157F;
	Sun, 22 Nov 2026 20:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1795375314; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=h5MusH8IV9Na7fO3T7L7n/MZBiLsXQrVcpOP8ORgtoc=;
	b=rEM2JbmkBa5fn4Vr1bG3w+4KkTPOAyz4FjLeNzEe61DQJc+Etd7NYYpXSy2cZPxq62ikrp
	0htLJW1yFWzYssVcDR8hRqht9XJdgfvfhU1+W5bXxbGuAUgirDLsELaS0hHJiU+Od3mxlk
	RFyL3goVG+an5Y6mklDhT4zVnsftanFz3bNj9Roc5HTGF4c5E3uumqmfxsWGLrklI0Fdci
	Xe2NPEkIZv4MM2IXFaYcY8xm6h7zloBkAxWdfCtt/ciFwfqjeVDmKlas2yf6JaQpzaP+b3
	5OC8zYeZqPYllx+O5TMe9S4sfqUXzzdxsvCzf9hQmlWKT1OKiw6WdSBayo0J9A==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 22 Nov 2026 20:21:49 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>, Ong Boon
 Leong <boon.leong.ong@intel.com>, Simon Horman <horms@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v12 1/4] net: xdp: add
 __xdp_build_skb_from_buff() helper
In-Reply-To: <20261121-stmmac-rx-mb-v12-1-3ae2f3bce174@oss.qualcomm.com>
References: <20261121-stmmac-rx-mb-v12-0-3ae2f3bce174@oss.qualcomm.com>
 <20261121-stmmac-rx-mb-v12-1-3ae2f3bce174@oss.qualcomm.com>
Message-ID: <c25a973e6efd6f626bb65d4f2500559b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 21.11.2026 18:28, Lorenzo Bianconi wrote:
> xdp_build_skb_from_buff() always calls eth_type_trans() on the skb it
> builds, which pulls the Ethernet header and advances skb->data. Drivers
> that still need to process the L2 header before protocol parsing
> therefore cannot use the helper.
> 
> stmmac is such a driver: its software VLAN path (stmmac_rx_vlan()) 
> reads
> the VLAN tag at skb->data and shifts the MAC addresses over it, so it 
> has
> to run before eth_type_trans().
> 
> Split the implementation into __xdp_build_skb_from_buff(), which builds
> the skb (including the recycle mark, the Rx queue index and the frags
> info) but leaves skb->dev, skb->protocol, skb->pkt_type and the mac
> header unset, so the caller must initialize them, usually by calling
> eth_type_trans(). Make xdp_build_skb_from_buff() a static inline 
> wrapper
> that still calls eth_type_trans() as before, preserving the behavior of
> existing in-tree users. A follow-up patch will let stmmac use it.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
