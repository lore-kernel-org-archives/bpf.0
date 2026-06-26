Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36661C862F
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490727; cv=none; b=etvioG9qvIxTiEpa9u1hFswurJGQC/ftg2JOUt5n907EZr2IAqeQM6XSOZ7azYC8kL3Mxjpe0HrJSH5pfna8qC/ZUuyAX9WIDjk15gFWzPU84ZXgtlA1W2dWLEQ4IQAKE6SU2cRzU9bC3ndOSTch1mif0MjHSXlzHQ1ELquSJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490727; c=relaxed/simple;
	bh=fFg+8QAhehBGfwcotjGy/9/HapJEhN/qgHia4fVzKic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8CskSUG1T1pFBpUN098YsH45TZvTLeASW0ouxbNf0JyQ7X40f5Ov5/LBqpQsjTHqlChX0pj5bd4EKHOTVEHTk2mipwoXN910sJdQiLRFrlFFo3xstovN+Awl7fG/mc4fzdBtz8LhaiNwSgGxJMwPWgVqUZggzJ/FbcZe30YleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhjnBP+q; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhjnBP+q"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-845c92bc464so567176b3a.2
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782490725; x=1783095525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKCVjoWD6IpAlzeapawfUKp0sYnjjZLcFMxZGGVIBz4=;
        b=MhjnBP+qk8r0hqjFmmUN2En2sj1qFGXrqixsaLeN2Idm8VFiYTGBaKmjQQ+kyRwmko
         jnp1hNgj+DUre2xLIta/2h1lC83YZws/IKjai5BqQHBP9h/GN9LYsDDFBiXsWIashaxY
         BA3XTBMyWFqcKfpKHf27GSj0G1u2iAr2d9PTNonFvQIrbT5WKY1DRGiADXubkc7iRCpC
         QIGvqueu+ICFXvvI9DSkxAiW7CxLEVcmptj4e9A9+/qc7D2Y7Bf6etWnP5YXf9JlvfWa
         nA8F2p1TzM2H2R+jBL0H8I+CKdBv7umbmEXFnfHv5bjJedOrxiWSoQ/ufGL1wJ8vyTTT
         JPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782490725; x=1783095525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKCVjoWD6IpAlzeapawfUKp0sYnjjZLcFMxZGGVIBz4=;
        b=K4ARdF0Y4PeXlbaVS1BYpkxN0drmT7XQn/LrRQYSDxz8w/jF70n66moIHGeLOULmmS
         DNde16HnHnPPHxPoRFQzjja6gdX2NnVbCVmw7aoY3gfBDcc4y5O1KQHNA1RJx8APVy15
         Rs6mnkTkbX2q2f7xVRXzELI0fQ1w2Rl7tYR67zWbIS/m04A7Pyt8gkotNz3mkL+vEqvg
         09fsROOMDvd/TGaYx6UUFTlaxduK0+G+5eiGI9OSY2JIt977ELDJtkcK24lMg3txKayR
         jOZ7HXZh3SYFsK5xcQf1r7s2yM7ivEXF8Ek0XtI9ua0ToaFxlm9QTXflhitQZmES/A7H
         /bqw==
X-Gm-Message-State: AOJu0Yxrz7x/c7NzVDGFR0jX8/IIu6WM8UEtN1B4GfngvIwDkxZsxR9v
	lV3Gom2Z+Bh3eAersIP5XgxKuGKlwxjyKth/9tiagPJAbcRX3GyuMQndjfJ8UDUJ
X-Gm-Gg: AfdE7cmGuCkYoe4qrx5p4F9QaOKxq5Ey4bHDfCXz3xKiDhGsqiKJd6nqpVH6Gn/HTSc
	1TXWQxNi7YPGzdhNyyxDIibwO+ZDqR+9DE3lGhU0dn4/5ev/Rjir0AdVNscY18mK04I16MU0Ltn
	UW9bKbHoq8QMYmMIiWRyuKZo9yhfaV6iXrDzCJ1waQHqjLOCXcx8cvaMWvh95ZKUV1LatY4heEM
	s53MC08klEkBRHokBcnpIGePyA6tdph19qjItJOfdZV6GQ4zUOSMKFQcYb39DMOFJMBMlZWC2lV
	Vklf6iFqsXcNnJOm3E7RHE8KO0q+cU7gDQBBqdN0gwT3lirF/XJvmBA5gDflKtyGE/nrvAFq8jF
	xgsmejWm6NOo0QS01pRi7l6AnqrvZhtBvcHA/jMO75dnYHihImlZwKPYPRNAmzF7ZvNQFabsUuz
	GLQfDB9g==
X-Received: by 2002:a05:6a00:1990:b0:845:286d:4675 with SMTP id d2e1a72fcca58-845b3aeed29mr7925753b3a.10.1782490725139;
        Fri, 26 Jun 2026 09:18:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a4127bd0sm6851623b3a.53.2026.06.26.09.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:18:44 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:18:39 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v10 1/5] bpf: add bpf_icmp_send kfunc
Message-ID: <aj6kdnfAB0LJKDcR@devvm7509.cco0.facebook.com>
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
 <20260625110321.28236-2-mahe.tardy@gmail.com>
 <aj1V2ZdzY1EGtsma@devvm7509.cco0.facebook.com>
 <aj1b_z6h5xn42Hxe@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aj1b_z6h5xn42Hxe@gmail.com>

On 06/25, Mahe Tardy wrote:
> On Thu, Jun 25, 2026 at 09:24:59AM -0700, Stanislav Fomichev wrote:
> > On 06/25, Mahe Tardy wrote:
> 
> [...]
> 
> > > +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> > > +{
> > > +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> > > +	struct sk_buff *nskb;
> > > +	struct sock *sk;
> > > +
> > > +	sk = skb_to_full_sk(skb);
> > > +	if (sk && sk->sk_kern_sock &&
> > > +	    (sk->sk_protocol == IPPROTO_ICMP || sk->sk_protocol == IPPROTO_ICMPV6))
> > > +		return -EBUSY;
> > > +
> > > +	switch (skb->protocol) {
> > > +#if IS_ENABLED(CONFIG_INET)
> > > +	case htons(ETH_P_IP): {
> > > +		if (type != ICMP_DEST_UNREACH)
> > > +			return -EOPNOTSUPP;
> > > +		if (code < 0 || code > NR_ICMP_UNREACH ||
> > > +		    code == ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
> > > +			return -EINVAL;
> > > +
> > > +		/* icmp_send expects skb_dst to be a real rtable. */
> > > +		if (!skb_valid_dst(skb))
> > > +			return -ENETUNREACH;
> > > +
> > > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > > +		if (!nskb)
> > > +			return -ENOMEM;
> > > +
> > > +		memset(IPCB(nskb), 0, sizeof(*IPCB(nskb)));
> > > +		icmp_send(nskb, type, code, 0);
> > > +		consume_skb(nskb);
> > > +		break;
> > > +	}
> > > +#endif
> > > +#if IS_ENABLED(CONFIG_IPV6)
> > > +	case htons(ETH_P_IPV6):
> > > +		if (type != ICMPV6_DEST_UNREACH)
> > > +			return -EOPNOTSUPP;
> > > +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> > > +			return -EINVAL;
> > 
> > [..]
> > 
> > > +		/* icmpv6_send may treat skb_dst as rt6_info. */
> > > +		if (skb_metadata_dst(skb))
> > > +			return -ENETUNREACH;
> > 
> > A bit confused about this. Which part of icmpv6_send treats skb_dst as rt6_info?
> > (I see the original sashiko report about dst, but icmp6 seems to be not
> > requiring it)
> 
> Yeah I was also a bit confused because this came out of nowhere as soon
> as I put the skb_valid_dst only on the IPv4 path (for different
> reasons), but there is actually a potential trace in which we have type
> confusion indeed:
> 
> - icmp6_send() checks scoped source addresses and calls icmp6_iif() at net/ipv6/icmp.c:702
> - icmp6_iif() calls icmp6_dev() at net/ipv6/icmp.c:441
> - icmp6_dev() does skb_rt6_info(skb) for loopback/L3 master devices at net/ipv6/icmp.c:428
> - skb_rt6_info() casts any non-NULL dst to struct rt6_info at include/net/ip6_route.h:233
> - rt6->rt6i_idev is then dereferenced at net/ipv6/icmp.c:434
> 
> When checking with pahole, we can find this on my local kernel:
> 
> struct rt6_info {
> 	struct dst_entry           dst;                  /*     0   136 */
> 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> 	struct fib6_info *         from;                 /*   136     8 */
> 	int                        sernum;               /*   144     4 */
> 	struct rt6key              rt6i_dst;             /*   148    20 */
> 	struct rt6key              rt6i_src;             /*   168    20 */
> 	struct in6_addr            rt6i_gateway;         /*   188    16 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	/* --- cacheline 3 boundary (192 bytes) was 16 bytes ago --- */
> 	struct inet6_dev *         rt6i_idev;            /*   208     8 */  <--- we dereference this
> 	u32                        rt6i_flags;           /*   216     4 */
> 	short unsigned int         rt6i_nfheader_len;    /*   220     2 */
> 
> 	/* size: 224, cachelines: 4, members: 9 */
> 	/* sum members: 218, holes: 1, sum holes: 4 */
> 	/* padding: 2 */
> 	/* last cacheline: 32 bytes */
> };
> 
> And the metadata_dst would look like this:
> 
> struct metadata_dst {
> 	struct dst_entry           dst;                  /*     0   136 */
> 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> 	enum metadata_type         type;                 /*   136     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	union {
> 		struct ip_tunnel_info tun_info;          /*   144    96 */
> 		struct hw_port_info port_info;           /*   144    16 */
> 		struct macsec_info macsec_info;          /*   144     8 */
> 		struct xfrm_md_info xfrm_info;           /*   144    16 */
> 	} u;                                             /*   144    96 */  <--- we land on this union
> 
> 	/* size: 240, cachelines: 4, members: 3 */
> 	/* sum members: 236, holes: 1, sum holes: 4 */
> 	/* last cacheline: 48 bytes */
> };
> 
> Let's say it's a struct ip_tunnel_info:
> 
> struct ip_tunnel_info {
> 	struct ip_tunnel_key       key;                  /*     0    64 */
> 
> 	/* XXX last struct has 7 bytes of padding */
> 
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	struct ip_tunnel_encap     encap;                /*    64     8 */  <--- 144 + 64 = 208 we land here
> 	struct dst_cache           dst_cache;            /*    72    16 */
> 	u8                         options_len;          /*    88     1 */
> 	u8                         mode;                 /*    89     1 */
> 
> 	/* size: 96, cachelines: 2, members: 5 */
> 	/* padding: 6 */
> 	/* paddings: 1, sum paddings: 7 */
> 	/* last cacheline: 32 bytes */
> };
> 
> So I imagine this is fairly tricky to trigger but still a case of type
> confusion. I have actually no idea how likely this can happen from my
> call but the trace makes sense at least.

That logic seems to exist for the icmp6_send to find the input device
(since the expected use-case for calling icmp6_send is to the incoming
skb). And since you're mainly doing egress, I don't think this path will
ever trigger (iow the check is not needed)?

Maybe you can add cgroup_ingress test case? Looks like this rt6_info
path might trigger for ipv6 lo? I don't see any ingress test in your
series, so might be good to have one regardless?
