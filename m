Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849617;
	b=pPuGC9Bciphe/cHQMC7sTQzcB4eSooGrIH878THXYjYeWRNSQTHGqsZ/uJItt8hh6+HB
	 xfhMa7+IHxVWqlAxG7C0uI+QXI6BYHv8Aorcs/Whh+dZxIh6XqmQfrImHT+Cwr46CZulH
	 firwOIztlYrzUDvqBucZ5gvan5GoY22nGnnxwnDdVB9QrNLZsEdAfYYgk3MbNd8HSxCrO
	 /Ds1ZV8rX0VH3mlx6YMudiWcwHtvBbKH1C0KwlvPRRww+vSmhDDBzqb+QCLasOu8wYNNm
	 W6RJcEhb0omVQj1DVNZsaM6akyZuxhwl/tkI+kCSR3/PdX2FzQbouaWUjIdOIGJsJEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849617;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qS3GSR2+QS9Ez6HTQ9xfSuXLdo51J3kjDvzV704q/jg=;
	b=CZ/filvBewfA1s1r8F7DYxrtaLFlCe7Q4y5f29P/pyB/oaNtz9ycSbs99ZPgmdvQyPn2
	 oo1mIB2WhEBoBlqGf6TLQGlhw8+P2x1ycb6wGvh6v5zJ5RpSwAQ0VA5our1PKPo3/zpBm
	 WRi9dLulz0mbIUUxuCIbW5WyqPFmBJNKzY6y7BDY7o2uTVb502ZZyZ+7z7ITNnJnRd64R
	 VML6H8wnLXDBCPJFjvZIBKHar82RgoAfGxxaZH4j4/H61qQSc5p7nNaty8GgZF0J90/fV
	 uexxunI3FW6ef/sWQqgV7jUIklOU8mnK/tudEIVvSc76RfcL/U9VIpqmB8TN3AVlevg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikXWlGbM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8041606A31C;
	Mon, 16 Nov 2026 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikXWlGbM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F291F000C4;
	Mon, 16 Nov 2026 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849616;
	bh=qS3GSR2+QS9Ez6HTQ9xfSuXLdo51J3kjDvzV704q/jg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ikXWlGbM72hknRLH2E8gsiFqH7M45EzDruusdoLVfAZCK+14c0pDfDv3AqgdBq9fr
	 5LySDJULzTdhP3K4zS6WbVpJ8TH3d983TLjLOjewSBtiKJ12JowGnpmdTpBP1F71HA
	 rGOhTfGpP8FCnOmU4ENJGuX+kLJ+TZPK3vUL/5j9HGuOhA1gRdxqDXGoWEPAl9HOVk
	 xDjFA7ZFSmMGPPyYIAYEeDeu8IvWRSLtgS6Kj3h+aGfTtZezhBYT+pTth3Z4YKZMXe
	 6OEZnMJM/tG/qklHcNqPiFhXpq57IFPAq3g3rLCI4cQl3MSZDOe9dzioM+IilKOQtt
	 ChL2VvR/X5DTA==
Subject:
 Re: [PATCH net-next v10 1/4] net: xdp: add __xdp_build_skb_from_buff() helper
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org, nb@tipi-net.de
Date: Mon, 16 Nov 2026 17:20:14 +0000
Message-ID: <179484961485.3136.18371294575845722948@kernel.org>
In-Reply-To: <20261112-stmmac-rx-mb-v10-1-d3d04b65c6bc@oss.qualcomm.com>
References: <20261112-stmmac-rx-mb-v10-1-d3d04b65c6bc@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The kerneldoc for the newly exported __xdp_build_skb_from_buff()
  (net/core/xdp.c:622-633) says only "Protocol parsing is left to the…

--

net: xdp: add __xdp_build_skb_from_buff() helper

This patch splits xdp_build_skb_from_buff() in two. The new exported
__xdp_build_skb_from_buff() builds the skb without calling
eth_type_trans(). A static inline wrapper in include/net/xdp.h keeps the
old behaviour and still calls eth_type_trans(). The goal is to let stmmac
process the L2 header (software VLAN) before protocol parsing.

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 1d679e8fd6493..470bf90d93ef2 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -620,17 +620,18 @@ void xdp_warn(const char *msg, const char *func, const int line)
>  EXPORT_SYMBOL_GPL(xdp_warn);
>  
>  /**
> - * xdp_build_skb_from_buff - create an skb from &xdp_buff
> + * __xdp_build_skb_from_buff - create an skb from &xdp_buff
>   * @xdp: &xdp_buff to convert to an skb
>   *
>   * Perform common operations to create a new skb to pass up the stack from
>   * &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
>   * skb data pointers and offsets, set the recycle bit if the buff is
> - * PP-backed, Rx queue index, protocol and update frags info.
> + * PP-backed, record the Rx queue index and update frags info. Protocol
> + * parsing is left to the caller.

[Severity: Low]
Does "Protocol parsing is left to the caller" fully describe what the
caller now has to do?

Moving eth_type_trans() out of __xdp_build_skb_from_buff() also moves out
the other work it does:

net/ethernet/eth.c:eth_type_trans() {
	skb->dev = dev;
	skb_reset_mac_header(skb);

	eth = eth_skb_pull_mac(skb);
	eth_skb_pkt_type(skb, dev);
    ...
}

So the skb returned by __xdp_build_skb_from_buff() has skb->dev == NULL
and no mac header, and protocol and pkt_type are not set. This is true
even though rxq->dev is available inside the helper.

The peer helper __xdp_build_skb_from_frame() still sets these:

	/* Essential SKB info: protocol and skb->dev */
	skb->protocol = eth_type_trans(skb, dev);

As a result, the two __xdp_build_skb_* helpers now return different
minimal skb state.

Nothing breaks today. The only in-tree user of the underscore variant
later in the series is stmmac_rx(), and it calls
eth_type_trans(skb, priv->dev) before napi_gro_receive(). A future caller
that does its own L2 handling and reads "protocol parsing" as just
skb->protocol could pass an skb with no dev to napi_gro_receive() or
netif_receive_skb().

Could the kerneldoc say that the caller must also set skb->dev and reset
the mac header, for example by calling eth_type_trans()?

A smaller point: the public xdp_build_skb_from_buff() wrapper in
include/net/xdp.h no longer has any kerneldoc. The kerneldoc for
xdp_build_skb_from_zc() still refers readers to it:

 * Similar to xdp_build_skb_from_buff(), but for XSk frames. Allocate an skb

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc%40oss.qualcomm.com
