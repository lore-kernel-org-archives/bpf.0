Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849619;
	b=qhsihwCMy3E332FiCQAITR+kz6du3n4+ohqU+J0Zub07BU4xGny7iUcozexx//ZHsCfp
	 oS/gCF9PX1VDmQp9ky3siFo24Cyv2FwQ7JET+7u+XtLNyFgxpWJL3uJE1FaxgeoZ5jtHO
	 Tsqe3VRQPLSGKrvjxxl/qN534Ez0y8s407kHUF2gx+gEc5iF0qhNru+uPe/CM3buOqysv
	 gCi4Vh/NQfaJSxjqijHg/mIcIGhWNK+Tfat6LG+Rc8Su9I6Qonj0kUj6s3bd6+t8/6fro
	 QueaDQ+d4uK761Jpi5VhyW1g444xIUoffUihlfe+nqEUaWDomP87abal6JoXL3arNSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849619;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qo+XNJi3+qAMT97TnlZtT0eegnezla+dXLwHmpOKv2w=;
	b=K7gKXvjdyyFIO0PxRjBh7KQQDgImJZSpdieCoykuZ8EQ5+/kjiE3e3WEtUVuCFkr/ajj
	 x7HW1AV3MvfIFFw74+EDfT1S0k9B+oVwR5bMyPO+NynZRiD2Q4W18krHxNITVTuvKeudV
	 D/8qzKBwfLsqIXfkn1pV1JedPtu5Kfn1jiNjxu0Cl01X1dmPTF/u0WDX+2KDowB2SUp3L
	 PF/ULrbDl0jwjR7Bo3ZHmBwnPmv2dr1kw/mXF7IyExlxQ6AdYRva7gkvvQfbvss8zbuMh
	 ej3oSfR0q+Sz+Gx5VRYBcA1HR+6TPDLwppzPT1sKLpAOUfp7WWpHstBJnpv4TSW5MiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDRAy9Sj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB4606A322;
	Mon, 16 Nov 2026 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDRAy9Sj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2451F000C9;
	Mon, 16 Nov 2026 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849619;
	bh=qo+XNJi3+qAMT97TnlZtT0eegnezla+dXLwHmpOKv2w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QDRAy9SjFh2jGKg+EHev99/5hoZVQikPXRgMoyNqsTyGo2dMmUyUdqzqvn/82ia2d
	 lGiup191uGYqRKv60FZobuw2GEvamHnW0aIJou9Gi3YYtlnAA8ykCXj5BH9HDnvmca
	 FZ7WUBYkpt2mNIU7kwloD86l72adJtDk9lCVTnPwAoY3RlWbKCFE6Ft0MsI4gHqJfn
	 Nw0dmfZ1eHn6IJQGZjV/p3ECgGZWUF4jYADpd7Y06Wm1q4ULD8yxQNRB5DJFRcIeYz
	 nqYCAzG6W4n8lS5MEwoOtzjLuZRnc2ozVgMS2xztuwFx+yoyHO4ATBGJTqvsYDfKgP
	 MSMEpQRNqx6Yw==
Subject:
 Re: [PATCH net-next v10 2/4] net: xdp: add xdp_buff_shrink_tail() helper
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
Date: Mon, 16 Nov 2026 17:20:16 +0000
Message-ID: <179484961693.3136.10654880889378798099@kernel.org>
In-Reply-To: <20261112-stmmac-rx-mb-v10-2-d3d04b65c6bc@oss.qualcomm.com>
References: <20261112-stmmac-rx-mb-v10-2-d3d04b65c6bc@oss.qualcomm.com>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 2 · High: 0 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch removes the lower-bound check `data_end <
  xdp->data + ETH_HLEN` from the linear path of bpf_xdp_adjust_tail()…
- [Critical] The new exported xdp_buff_shrink_tail() (net/core/xdp.c)
  checks a linear shrink only against the lower bound: `data_end =…

--

net: xdp: add xdp_buff_shrink_tail() helper

This moves the XDP tail-shrink logic out of bpf_xdp_adjust_tail() and into
net/core/xdp.c. The frag shrink helpers move with it, and a new exported
xdp_buff_shrink_tail() handles both the linear and frags cases.
bpf_xdp_adjust_tail() now sends every negative offset to the new helper
so stmmac can share it for FCS stripping.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9b8d5191c4ba2..5ea45dfce7a22 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4438,96 +4438,21 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)

[ ... ]

>  BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
>  {
>  	void *data_hard_end = xdp_data_hard_end(xdp); /* use xdp->frame_sz */
>  	void *data_end = xdp->data_end + offset;
>  
> -	if (unlikely(xdp_buff_has_frags(xdp))) { /* non-linear xdp buff */
> -		if (offset < 0)
> -			return bpf_xdp_frags_shrink_tail(xdp, -offset);
> +	if (offset < 0)
> +		return xdp_buff_shrink_tail(xdp, -offset);
>  
> +	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
>  		return bpf_xdp_frags_increase_tail(xdp, offset);
> -	}
>  
>  	/* Notice that xdp_data_hard_end have reserved some tailroom */
>  	if (unlikely(data_end > data_hard_end))
>  		return -EINVAL;
>  
> -	if (unlikely(data_end < xdp->data + ETH_HLEN))
> -		return -EINVAL;
> -
>  	/* Clear memory area on grow, can contain uninit kernel memory */
>  	if (offset > 0)
>  		memset(xdp->data_end, 0, offset);

[Severity: Critical]
With the ETH_HLEN check gone from this path, what stops a grow on a
linear xdp_buff from wrapping the pointer?

The offset argument is ARG_ANYTHING, so a program can pass any positive
int. data_end is computed as xdp->data_end + offset. For the linear grow
case, the only check left is data_end > data_hard_end.

On a 32-bit kernel with the default 3G/1G split, packet buffers sit at
or above 0xC0000000. Take xdp->data_end = 0xC5000100 and
offset = 0x3B000000: data_end wraps to 0x100. That passes the
data_hard_end check, and then this runs:

    memset(xdp->data_end, 0, offset);

It would zero about 1 GiB of kernel memory past the packet buffer. After
that, xdp->data_end is set below xdp->data.

Before this patch, a wrapped value was always below xdp->data + ETH_HLEN,
so the removed check returned -EINVAL for it. That check now exists only
in xdp_buff_shrink_tail(), which runs only when offset < 0.

The return value also changes for short frames. A linear frame already
shorter than ETH_HLEN used to get -EINVAL from
bpf_xdp_adjust_tail(ctx, 0), or from a small grow that left it under 14
bytes. It now gets 0. That seems to contradict this sentence in the
commit message:

    Behavior for valid offsets is unchanged.

Should the lower-bound check stay in bpf_xdp_adjust_tail() for the
offset >= 0 linear path? The later patch "net: stmmac: rework stmmac_rx
to support XDP rx multi-buff" doesn't touch bpf_xdp_adjust_tail(), so
this still looks present at the end of the series.

[ ... ]

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 470bf90d93ef2..7c98dbc2a770c 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -672,6 +672,97 @@ struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp)

[ ... ]

> +int xdp_buff_shrink_tail(struct xdp_buff *xdp, int offset)
> +{
> +	void *data_end = xdp->data_end - offset;
> +
> +	if (unlikely(offset < 0))
> +		return -EINVAL;
> +
> +	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
> +		return xdp_frags_shrink_tail(xdp, offset);
> +
> +	if (unlikely(data_end < xdp->data + ETH_HLEN))
> +		return -EINVAL;
> +
> +	xdp->data_end = data_end;

[Severity: Critical]
Can xdp->data_end - offset wrap here and still pass the lower-bound
check?

bpf_xdp_adjust_tail() passes -offset, so a program can ask for a shrink
of up to INT_MAX bytes. The old inline code also checked
data_end > data_hard_end for shrink requests, and that rejected a
wrapped result. This path no longer has that upper-bound check.

Some 32-bit configurations put lowmem below 0x80000000. Examples are
ARM with VMSPLIT_1G (PAGE_OFFSET is 0x40000000), nommu ARM (PAGE_OFFSET
is PHYS_OFFSET), x86-32 with VMSPLIT_1G or VMSPLIT_2G_OPT, and m68k.

On those, a shrink larger than (u32)xdp->data_end wraps to an address
between data_end + 2^31 and 2^32. That is always above
xdp->data + ETH_HLEN, so the check passes and the wrapped pointer is
written to xdp->data_end.

The packet then appears to span gigabytes of kernel memory. Direct
packet access, bpf_xdp_load_bytes() and bpf_xdp_store_bytes(), XDP_TX,
redirect, and skb construction on XDP_PASS all trust data_end after
that.

Should offset be checked against the linear length before the pointer
subtraction? This code is also unchanged at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc%40oss.qualcomm.com
