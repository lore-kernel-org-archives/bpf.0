Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF75A39E6FF
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690301; cv=none; b=Ncnmvva1SUwol0h+E3i/KvazjIvwTav2eSItEG87QSPNI3eS5h1U5hEfXsfJWarCL9a7zwqaiJG0BaE9bbqJVt05yI6e2p9W/rRajNZp/o61HXwmqeDI7VhG1I/z6FTj8LGolT5YdQNW3tzVmDL+ACiSZ+eF43ymtzIkFztIrlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690301; c=relaxed/simple;
	bh=fVzxhqZXK6Qwiio7PBsf0pdv4mmkoZ3a6cA74QPhfCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMmACcWGn2oEt5cmRf5zLa2Z0sWzwOwvSZUuJXTp3jx1o60tNkne//dvZNyGYx28qsXWP4u238WNk0cM2BKWs397SpfNXtvGG2GuxRsaM1C/ALmWWzbZmsmRuAz38XVvOkF4gVTDVCFR8zPatevnvceTzAqrNvHFArBPfkgULwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rnMPR1IF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnMPR1IF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso35206825e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776690295; x=1777295095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ7NBcfywwnvJcmvihRMyw1jnkfoOgzM6bLzAxo7IkU=;
        b=rnMPR1IF9vK5oPLN0KOk3F6mca9FlkG3A4z5HzcQT8CTMBENTiFHCZvoYHD3gNNSQ4
         zKSqnWQc/zebYxSFfsWmSxHRwwix3jwuIjrtzvuFUR8qSqFstCmfGb9HZ6bIWe1G9qWH
         OyOjKt2iU95uHym1c5f/P6E0yV1UJDtps4TY6xx9VQAWmxn82CGFVQ5/8xR5l+VFWOxJ
         xdje+fnm3U+O6/ZrFpGHJ1Jh99NLRVE8Dz+WNoPdog6tijS2ItP0p9Xpfk218PbcRPG/
         E7jmhledcZFKP9dOLvkUrvm3CbHs3TgImmCswWr6zi3M2Thdq6ZUoLVDEqT262QwGSha
         k19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776690295; x=1777295095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZ7NBcfywwnvJcmvihRMyw1jnkfoOgzM6bLzAxo7IkU=;
        b=b30om/ujEobeKOonxlvR4JCU768dWFr/58lO4uzIs13LtSw9sfalfWWwl+8vJXllVX
         +8z0iad3V5ScZpWSML1py0xN8g1OZEjrEb3S0pMyFlhwoWKBLKvZJTjHAiseJF/E6Vqn
         OMBrlfE8DqWkVndSKT3TTTAwGPQVjg44Sn5H0p+ra4yzUHXuPC0PwCRZnPHXbrijeTi7
         3sP60atZimBNR6DZKtBdFK0ZtliWAiT20jM8NQs2QeG2Mue1WkvT5V8a1h9JP/rqxgkS
         WHZwYevx5sEJooTGFrxcD39Da9zsSAm5vXFd32cUUVL9uCgMlmmgpP2JP4BQTtGcf9aU
         ahNA==
X-Forwarded-Encrypted: i=1; AFNElJ8schuxBd3HL5zW1SkLsbR4G2BXISw9mNgdm96W/pWudVFH6se2wscoIS/WxBtOpFbEWp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIx0pj8+JKAkYZsWzEydpoK7OS6QeZd7CXZzkXNxL0n7/ZX2va
	UKYFGsw7BfkT4WNe66+vq8QtO6sYoCopfGBeUY7bAENyBE/lFwqROAPH
X-Gm-Gg: AeBDievkt5kqagOdyxxqawirpQsJ/0Y86o6cqZ7DEjTWYhqBzfkqe+RkCi3h9NoM0x6
	2xicwTIzFnW2FLxdP6FC0kRzdL8vwrq/wKa74ZsmiIP0zcnrUIZy5uMspHByxnJZiJN+NbW5MYl
	jyMIioXhSZv0s2ut/xFUI/rveJHBGWNt0SImhBGcAE3zArtRYHunA77H9NgLNNuGsiVMk/wz7tX
	WuzuY62rkUyr6Mbim/vRKsJSwBnuH5ufVxCQwVm2AkutorDAXjki/M+uqPMewk+plapMJq44HC5
	EL3p9tlfv2dNcmKcnK+KKuaTfuwcq3zkORpCk8Ec74Vr74a3wypKANT7GKwI6KOYofMZh25tSP+
	7yXuaGTIF7bsVmogTBQBp88V+GfhG+8SIsOYXb+/E4PCX+eU0Kj+ETNIAlS/Y2cv4tapynBdzBO
	q7tiA+SAn1bkpITKATvM+sPcyB9iVnLUh3n3zPTiusx7ws2DmqHN5qjaHF6KevEP/W2Q==
X-Received: by 2002:a05:600c:b96:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a53390f6cmr9778795e9.9.1776690295193;
        Mon, 20 Apr 2026 06:04:55 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm262361005e9.12.2026.04.20.06.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:04:54 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:04:52 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
	fw@strlen.de, john.fastabend@gmail.com, lkp@intel.com,
	martin.lau@linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v4 1/6] net: move netfilter
 nf_reject_fill_skb_dst to core ipv4
Message-ID: <aeYkdKm7B4NQ3BDo@gmail.com>
References: <20260420105816.72168-2-mahe.tardy@gmail.com>
 <c0aa7f264055f44ac4c93aa4718473e89ed13b8bb11de3179ed40d2f88a99257@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0aa7f264055f44ac4c93aa4718473e89ed13b8bb11de3179ed40d2f88a99257@mail.kernel.org>

On Mon, Apr 20, 2026 at 11:36:12AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/net/route.h b/include/net/route.h
> > index f90106f383c5..ec2466fd0bec 100644
> > --- a/include/net/route.h
> > +++ b/include/net/route.h
> > @@ -173,6 +173,7 @@ struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
> >  				    const struct sock *sk);
> >  struct dst_entry *ipv4_blackhole_route(struct net *net,
> >  				       struct dst_entry *dst_orig);
> > +int ip_route_reply_fetch_dst(struct sk_buff *skb);
> >
> >  static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4 *flp)
> >  {
> 
> [ ... ]
> 
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index bc1296f0ea69..7091ef936073 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -2945,6 +2945,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
> >  }
> >  EXPORT_SYMBOL_GPL(ip_route_output_flow);
> >
> > +int ip_route_reply_fetch_dst(struct sk_buff *skb)
> > +{
> > +	struct rtable *rt;
> > +	struct flowi4 fl4 = {
> > +		.daddr = ip_hdr(skb)->saddr
> > +	};
> > +
> > +	rt = ip_route_output_key(dev_net(skb->dev), &fl4);
> > +	if (IS_ERR(rt))
> > +		return PTR_ERR(rt);
> > +	skb_dst_set(skb, &rt->dst);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(ip_route_reply_fetch_dst);
> 
> Is ip_route_reply_fetch_dst() actually needed before calling icmp_send()?
> 
> Martin KaFai Lau raised this question in v3 of the patch series and
> noted that icmpv6_send() does its own route lookup and doesn't use
> skb_dst() of the original skb. He also pointed out that at
> cgroup/egress, skb->_skb_refdst should already be set.
> 
> Looking at icmpv6_send(), the fl6.{daddr,saddr} are filled and passed
> to icmpv6_route_lookup, which performs the reverse/invert route lookup.
> The function doesn't appear to use skb_dst() of the original skb.
> 
> Since this patch moves ip_route_reply_fetch_dst() from netfilter to
> core specifically for the BPF kfunc, can you clarify why this routing
> step is necessary? Does the kfunc not work without
> ip[6]_route_reply_fetch_dst()?
> 
> Reference: https://lore.kernel.org/bpf/df4b0996-3e88-4ea4-983b-82866455a6fc@linux.dev/

Yes I replied to this in the cover letter, let me quote it:

Initially, this kfunc was added only to cgroup_skb programs, Alexei
suggested not creating its own kfunc set and adding it to the more
global bpf_kfunc_set_skb. Now that recursion is handled and I realized,
thanks to Martin, that fetching the dst route might be only useful in
situation in which the packet was not yet routed, I decided to extend
the kfunc to more program types and route the packet only if needed.

So in short, if we decide to go back to cgroup_skb only, we can remove
this, if we expand to other program types like we do, it still makes
sense to do it.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24663313503

