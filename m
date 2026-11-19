Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118564;
	b=gtyWL0MpBDM3+ubmoRV8FLjg60zbe3R230cqXaHD9fM/UCQ4qwIfi/RBs3rnKBoajU1J
	 ip58SfPlRcVNEmltr9v6fd9+MId1q+0QxZp+m+DJSlXuEg2JrimCz+huAdvuC6rdHDmYw
	 pnmzy9LKCB7P/1qPxapZiiWYVhIKKtKs1W9bhUd5ZT222+jNikFbuWmt3WXgPPLqIflV1
	 fnO/qq854815K3a9pyDEtn4QtAvvCKkmRmGmGL95GQjfludsth5yVmITDqHGh+kGhux5Y
	 ZqJnML026/IaywiDD6bqaRg7FwoNIoorxK/f7BKThmzGQmxcX3aDBCaAm5xcxfuj4JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118564;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dxfb/sPVGMZpxQTV2aEE45mRohpQPeNSpNM2wT9CGIs=;
	b=iALJy3x7AFoLvTKM9mhkHQJZBFw+yFwVECkk88RB9+hA5Pn7CpaQMJslbex4qAS/5om9
	 Rq/xUnHO5Cq31+u/E1ngfw8AKn0DUbA8N/CF0q5t/WKvMLaEjynGWRA/Klgy2aAgZt/cI
	 oaIXqh3jqEdf3QTyO6VKOXGheF282s279rGeUdbXt8C+J6fzuU8xvNw84fzjqEiCnvVqZ
	 xae3v3cmB6+bgkl+3XeA4l30N/7YAq6d/R8026C8y9CvE9o0y6zxSs1ZvHoILy+BGn8LH
	 EriouJZ1EXQGONUqb3H8ORo7vszIJBlJVeoWqgNuxN1yl7c2m2qRM5VBTBf8B3vq6oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wd64eoZp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6B606A325;
	Thu, 19 Nov 2026 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wd64eoZp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37AF1F000C4;
	Thu, 19 Nov 2026 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795118564;
	bh=dxfb/sPVGMZpxQTV2aEE45mRohpQPeNSpNM2wT9CGIs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wd64eoZpcFyspmoEiA3lW8bUq1huqTM++6o1myM267EPbPK6kh9hyyf0OG7osU3VZ
	 1lzyW7zwqkq40xn+0/BzJfiGEj6jvzCTg8OjqrXXmoKEOcAydTqN2gmOVYJqa5S782
	 oVrnrzTOHIKy9ROsbzGOOFs2wK2pODChoPU/czT0uDA/+AiDucsvnvP5yKQtHvZYk0
	 8qgAVKxaYKpbOyJknfT6zHKI1fC2kdOmYM6TNf3kL6u6Y60hIBhqAjlya45KcSqx62
	 UM2Tygk4nagKUVES8RZH4Rfop5u15+Ny4olZ8inURV5biLc0LbzVyL+Kd4I1DGJzjU
	 pd/VDFkg2d5Qw==
Subject: Re: [PATCH net-next v4 2/4] net: dst: keep the LWT metadata of a
 dropped route
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bpf@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com,
 sashiko-bot@kernel.org
Date: Thu, 19 Nov 2026 20:02:42 +0000
Message-ID: <179511856244.3136.14894552339395914339@kernel.org>
In-Reply-To: <CORE-9NOG.v4.r0.20261116135311-2@mojatatu.com>
References: <CORE-9NOG.v4.r0.20261116135311-2@mojatatu.com>
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

- [Low] The commit message says the ip/ip6 copy "starts with an empty
  cache, which costs the tunnel one route lookup".
- [Low] The kernel-doc of skb_dst_drop_keep_metadata() (net/core/dst.c)
  does not match the implementation in two places.

--

net: dst: keep the LWT metadata of a dropped route

This commit adds skb_dst_drop_keep_metadata(). The helper releases an
skb's route dst, but first moves the ip/ip6 tunnel info or the xfrm md
info held in the route's lwtstate onto a newly allocated metadata dst.
Nothing calls it yet; the nft fwd and bpf redirect patches later in the
series will use it.

> diff --git a/net/core/dst.c b/net/core/dst.c
> index 092861133023c..fd63580e6529d 100644
> --- a/net/core/dst.c
> +++ b/net/core/dst.c
> @@ -353,3 +353,82 @@ void metadata_dst_free_percpu(struct metadata_dst __percpu *md_dst)

[ ... ]

> + * A dst that is metadata, or absent, is left in place. Any other dst is
> + * released, and a route with no encapsulation parameters leaves the skb
> + * with no dst at all.
> + *
> + * Return: true when the skb is left free to be sent: its dst was already
> + * metadata or absent, the encapsulation parameters were moved onto a new
> + * dst, or there were none and the route was simply released. False when
> + * the copy could not be allocated or a reference on the route could not
> + * be taken; the caller must drop the skb.
> + */

[Severity: Low]

Does this kernel-doc match what skb_dst_drop_keep_metadata() actually does?

The Return: section says true means the parameters were moved, or "there
were none and the route was simply released". The code only keeps
LWTUNNEL_ENCAP_XFRM, LWTUNNEL_ENCAP_IP and LWTUNNEL_ENCAP_IP6.

Take a route whose lwtstate is MPLS, ILA, SEG6, SEG6_LOCAL, BPF, RPL or
IOAM6. It falls through to skb_dst_drop() with md_dst == NULL, its
encapsulation is thrown away, and the function still returns true, the
same value documented for "there were none".

The code is consistent with the two readers the doc names,
skb_tunnel_info() and skb_xfrm_md_info(). The general wording of the
contract, though, does not say it is limited to those types.

Also, "Any other dst is released" does not hold for the xfrm branch:

    md_dst->u.xfrm_info.dst_orig = old;
    skb_dstref_steal(skb);
    skb_dst_set(skb, &md_dst->dst);

In that branch the route is not released. It keeps a counted reference
inside the metadata dst, which is what the earlier sentence "for xfrm the
route is kept" describes.

The v4 changelog says this Return: section was meant to be corrected.
Could these two points be covered as well?

> +bool skb_dst_drop_keep_metadata(struct sk_buff *skb)
> +{

[ ... ]

> +	if (old->lwtstate &&
> +	    (old->lwtstate->type == LWTUNNEL_ENCAP_IP ||
> +	     old->lwtstate->type == LWTUNNEL_ENCAP_IP6)) {
> +		struct ip_tunnel_info *src = lwt_tun_info(old->lwtstate);
> +		struct ip_tunnel_info *dst;
> +
> +		md_dst = metadata_dst_alloc(src->options_len,
> +					    METADATA_IP_TUNNEL, GFP_ATOMIC);

[Severity: Low]

The commit message says:

    the copy starts with an empty cache, which costs the tunnel one
    route lookup.

Is that accurate? This metadata_dst_alloc() runs with GFP_ATOMIC once per
skb, and dst_cache_init() is never called on md_dst->u.tun_info.dst_cache.
__metadata_dst_init() memsets the payload, so dst_cache.cache stays NULL:

net/core/dst.c:__metadata_dst_init() {
    ...
	memset(dst + 1, 0, sizeof(*md_dst) + optslen - sizeof(*dst));
    ...
}

With a NULL cache, dst_cache_get_ip4() and dst_cache_get_ip6() return NULL,
and dst_cache_set_ip4() and dst_cache_set_ip6() store nothing. So the copy
has no cache at all, not an empty one.

The route's own lwtstate has a shared, persistent cache, set up by
dst_cache_init() in ip_tun_build_state(). Before this series the tunnel
used that cache through skb_tunnel_info().

Later in the series, nft_fwd_neigh_eval() and __bpf_redirect_neigh_v4/v6()
call this helper. At that point, wouldn't every steered packet over an
ip/ip6 encap route cost a GFP_ATOMIC metadata_dst allocation, an
RCU-deferred free, and a full route lookup in the collect_md tunnel?

Could the commit message say that the cost is per packet and that it adds
an allocation?

> +		if (!md_dst)
> +			return false;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/CORE-9NOG.v4.r0.20261116135311%40mojatatu.com
