Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4732BF5D
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782729322; cv=none; b=DzCLFoJrnyjAC2V8MPQgKSeomSPGthzj0Dkj4NdsiY+cr/Smly5ZmzXAnNfOkeA1r6fr2x2RdFKkXT2gZvju7IMdHpQjRvu+dx3FtT9ViaICVR2yj/eADAuuzOITF37I8MGfJaMnlmcYW1cz6HMOebhvm65AAY1llWF1y+5kr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782729322; c=relaxed/simple;
	bh=OxfItVu+Dy/erU0SRYLqXuxmaniB33A1bNceKG8hwyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyNfMuh8GNyhuYs91v52Yu5ey6VrgcKh24LlzUWyZ2mWlxVK/kDMoPJ0LXBh0TvwjxN/zT0d3a92xYfeDlPLK7HYMa4UT58AxHAwJ0GFNeJQpM+gHRq4ZC2DM2TKYVXGb953giqWhVmEYZaZlie+BO/PTdCwCq89o0WbiITpU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFBFbFxe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFBFbFxe"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493a5d32e8cso15112675e9.1
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782729319; x=1783334119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V21dV6eJxZuScQe+ruVRNU/bsGpSFqGgqu4eb+ZmYgs=;
        b=pFBFbFxeDlG0szu/ha+5+/NxN209suSAO762lZ3FC13BFulZMbZ5ycVqL8HH7lRQYW
         QE5L7JtdQtFICK7cB7OqNaIExcH2f9Dw+lDire/KdZCmJxcyuTiRCI5VVy3DUWM17vL9
         Kec7mG/b/a5Sw3UdwAVfS9t6L7vX+F0PI7tx8fP+7ZIGNyGO2xPQ5uOa+v9cb6ZqjmmN
         2BChrncN9Iys5yv64NyWYXDcNko3FbHfJNCniggLfXwnNR5uFnSXzoxeUrj56cBiSavx
         eF7FlrF06FKcDcc9q4vNS6LDV5Vy1/UrkAz1HVxv/3H+hrWbNY4x/d0lmIYWM12FqTYB
         zl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782729319; x=1783334119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V21dV6eJxZuScQe+ruVRNU/bsGpSFqGgqu4eb+ZmYgs=;
        b=VtX0Fy+NtzC/Ik0zXereG5Tz0Fu6QQm8RuHu7MDyBDRj1frQng5pDxYAXAAk054qSb
         3nD0UmoQY/uwfGwJhPmoUdGn0vdgcDB72qtVn3eJSIREyt2RDexmscl774rcgYxk/c0N
         cbpjj6S8koyOHQYjY1uQr3XuPmYrJrLE8hCV+KCgw2fy6tMewy4CzxDf/TxNDqnwcF04
         IHRHoAkAFCs1RrgMphiTC7yR3IbTbS/L6O6OPINGlZM5QgJDbkyO2alLnUHeM1JTBUmN
         HoyxHuvYyeroRkdabaHwQC1kL79ot7u32k8XTVdqs5Hy0xhTC/JXs+KeCIcPUQo9cMaG
         4hFw==
X-Gm-Message-State: AOJu0YzOy7xz1/jANENGGFHAVVlFOw8glS9Rgm7k3WBlXX0jbhpPYDsU
	Y5sNb0NreceAccnz5TXsE/JizYW7JdmLY4FxZzCPwI8Y7uXNoAnqI8kXxNq3NihP
X-Gm-Gg: AfdE7cl1ym3hsixpWKA/BzBGH2hhcwkjMHMHYFgE1z91p3it02lEwgZW/AGHPX4rvS/
	lMhWBjdShXytJJuFieRyjlUdjhV4z5j7GO12zSgvzEZaZSI9BX/MLmWjk7CIZ9LSxGJqt/qp2U6
	D47EbA0qnPsmWchyUWHF70V3ZzguCmbfLZly+BaZteuHaMAqlwnnQKXwPSw/TgoaS+HtYjfaKeu
	8JLU7WYE64I6dzRnwH0WUwmq7jT1nvAtCF0vMkoM5DqutQPD1wljLF2SU0JsqxDU4j6V9L7Oz5A
	Zv5+5iNrubYPvxrZ+92VjNBHOWtMICrfdKIO3BjjJ6PdK1fDyc3m51/a/cbVxILrnmfJAJXeyJn
	B6uCmLxJ+M8Vz5dJHZa25vprJ89WbJP/842qtgxViMv49NAp+4tgrJLnhyL6FUYPImtSwZZe8Qm
	AfBwOxNpGfuBXsinEtTdYDQZNaRirGqSzH+g==
X-Received: by 2002:a05:600c:37cf:b0:493:a8eb:5145 with SMTP id 5b1f17b1804b1-493a8eb518amr65726205e9.4.1782729318747;
        Mon, 29 Jun 2026 03:35:18 -0700 (PDT)
Received: from gmail.com ([2a01:e0a:488:3510:9c63:70fa:f7ea:28fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-473dddcb295sm8150916f8f.35.2026.06.29.03.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:35:18 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:35:15 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io,
	martin.lau@linux.dev, yonghong.song@linux.dev, emil@etsalapatis.com,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, horms@kernel.org
Subject: Re: [PATCH bpf-next v10 1/5] bpf: add bpf_icmp_send kfunc
Message-ID: <akJKY_x1GdO3MZJS@gmail.com>
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
 <20260625110321.28236-2-mahe.tardy@gmail.com>
 <aj1V2ZdzY1EGtsma@devvm7509.cco0.facebook.com>
 <aj1b_z6h5xn42Hxe@gmail.com>
 <aj6kdnfAB0LJKDcR@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj6kdnfAB0LJKDcR@devvm7509.cco0.facebook.com>

On Fri, Jun 26, 2026 at 09:18:39AM -0700, Stanislav Fomichev wrote:
> On 06/25, Mahe Tardy wrote:
> > On Thu, Jun 25, 2026 at 09:24:59AM -0700, Stanislav Fomichev wrote:
> > > On 06/25, Mahe Tardy wrote:
> > 
> > [...]
> > 
> > > > +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> > > > +{
> > > > +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> > > > +	struct sk_buff *nskb;
> > > > +	struct sock *sk;
> > > > +
> > > > +	sk = skb_to_full_sk(skb);
> > > > +	if (sk && sk->sk_kern_sock &&
> > > > +	    (sk->sk_protocol == IPPROTO_ICMP || sk->sk_protocol == IPPROTO_ICMPV6))
> > > > +		return -EBUSY;
> > > > +
> > > > +	switch (skb->protocol) {
> > > > +#if IS_ENABLED(CONFIG_INET)
> > > > +	case htons(ETH_P_IP): {
> > > > +		if (type != ICMP_DEST_UNREACH)
> > > > +			return -EOPNOTSUPP;
> > > > +		if (code < 0 || code > NR_ICMP_UNREACH ||
> > > > +		    code == ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
> > > > +			return -EINVAL;
> > > > +
> > > > +		/* icmp_send expects skb_dst to be a real rtable. */
> > > > +		if (!skb_valid_dst(skb))
> > > > +			return -ENETUNREACH;
> > > > +
> > > > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > > > +		if (!nskb)
> > > > +			return -ENOMEM;
> > > > +
> > > > +		memset(IPCB(nskb), 0, sizeof(*IPCB(nskb)));
> > > > +		icmp_send(nskb, type, code, 0);
> > > > +		consume_skb(nskb);
> > > > +		break;
> > > > +	}
> > > > +#endif
> > > > +#if IS_ENABLED(CONFIG_IPV6)
> > > > +	case htons(ETH_P_IPV6):
> > > > +		if (type != ICMPV6_DEST_UNREACH)
> > > > +			return -EOPNOTSUPP;
> > > > +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> > > > +			return -EINVAL;
> > > 
> > > [..]
> > > 
> > > > +		/* icmpv6_send may treat skb_dst as rt6_info. */
> > > > +		if (skb_metadata_dst(skb))
> > > > +			return -ENETUNREACH;
> > > 
> > > A bit confused about this. Which part of icmpv6_send treats skb_dst as rt6_info?
> > > (I see the original sashiko report about dst, but icmp6 seems to be not
> > > requiring it)
> > 
> > Yeah I was also a bit confused because this came out of nowhere as soon
> > as I put the skb_valid_dst only on the IPv4 path (for different
> > reasons), but there is actually a potential trace in which we have type
> > confusion indeed:
> > 
> > - icmp6_send() checks scoped source addresses and calls icmp6_iif() at net/ipv6/icmp.c:702
> > - icmp6_iif() calls icmp6_dev() at net/ipv6/icmp.c:441
> > - icmp6_dev() does skb_rt6_info(skb) for loopback/L3 master devices at net/ipv6/icmp.c:428
> > - skb_rt6_info() casts any non-NULL dst to struct rt6_info at include/net/ip6_route.h:233
> > - rt6->rt6i_idev is then dereferenced at net/ipv6/icmp.c:434
> > 
> > When checking with pahole, we can find this on my local kernel:
> > 
> > struct rt6_info {
> > 	struct dst_entry           dst;                  /*     0   136 */
> > 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> > 	struct fib6_info *         from;                 /*   136     8 */
> > 	int                        sernum;               /*   144     4 */
> > 	struct rt6key              rt6i_dst;             /*   148    20 */
> > 	struct rt6key              rt6i_src;             /*   168    20 */
> > 	struct in6_addr            rt6i_gateway;         /*   188    16 */
> > 
> > 	/* XXX 4 bytes hole, try to pack */
> > 
> > 	/* --- cacheline 3 boundary (192 bytes) was 16 bytes ago --- */
> > 	struct inet6_dev *         rt6i_idev;            /*   208     8 */  <--- we dereference this
> > 	u32                        rt6i_flags;           /*   216     4 */
> > 	short unsigned int         rt6i_nfheader_len;    /*   220     2 */
> > 
> > 	/* size: 224, cachelines: 4, members: 9 */
> > 	/* sum members: 218, holes: 1, sum holes: 4 */
> > 	/* padding: 2 */
> > 	/* last cacheline: 32 bytes */
> > };
> > 
> > And the metadata_dst would look like this:
> > 
> > struct metadata_dst {
> > 	struct dst_entry           dst;                  /*     0   136 */
> > 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> > 	enum metadata_type         type;                 /*   136     4 */
> > 
> > 	/* XXX 4 bytes hole, try to pack */
> > 
> > 	union {
> > 		struct ip_tunnel_info tun_info;          /*   144    96 */
> > 		struct hw_port_info port_info;           /*   144    16 */
> > 		struct macsec_info macsec_info;          /*   144     8 */
> > 		struct xfrm_md_info xfrm_info;           /*   144    16 */
> > 	} u;                                             /*   144    96 */  <--- we land on this union
> > 
> > 	/* size: 240, cachelines: 4, members: 3 */
> > 	/* sum members: 236, holes: 1, sum holes: 4 */
> > 	/* last cacheline: 48 bytes */
> > };
> > 
> > Let's say it's a struct ip_tunnel_info:
> > 
> > struct ip_tunnel_info {
> > 	struct ip_tunnel_key       key;                  /*     0    64 */
> > 
> > 	/* XXX last struct has 7 bytes of padding */
> > 
> > 	/* --- cacheline 1 boundary (64 bytes) --- */
> > 	struct ip_tunnel_encap     encap;                /*    64     8 */  <--- 144 + 64 = 208 we land here
> > 	struct dst_cache           dst_cache;            /*    72    16 */
> > 	u8                         options_len;          /*    88     1 */
> > 	u8                         mode;                 /*    89     1 */
> > 
> > 	/* size: 96, cachelines: 2, members: 5 */
> > 	/* padding: 6 */
> > 	/* paddings: 1, sum paddings: 7 */
> > 	/* last cacheline: 32 bytes */
> > };
> > 
> > So I imagine this is fairly tricky to trigger but still a case of type
> > confusion. I have actually no idea how likely this can happen from my
> > call but the trace makes sense at least.
> 
> That logic seems to exist for the icmp6_send to find the input device
> (since the expected use-case for calling icmp6_send is to the incoming
> skb). And since you're mainly doing egress, I don't think this path will
> ever trigger (iow the check is not needed)?
> 
> Maybe you can add cgroup_ingress test case? Looks like this rt6_info
> path might trigger for ipv6 lo? I don't see any ingress test in your
> series, so might be good to have one regardless?

The initial reason I added only egress is because the use case of this
makes more sense if that's your local kernel giving you feedback about a
connection you are trying to establish, as a process, but is prevented.

But indeed, I could extend the test to ingress as well, I'd just like
ideally getting an ack from networking maintainers since this is already
v10 of this, before making some new changes.

