Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B13E3D9A
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106316; cv=none; b=SsGxBnAAtTkpALWkez/H8/TE2/OITDt+mtjKeDLPmjvAtl8gN2W3vfYCTKHo26o74CfeUAU4EYlq9YNaRE2CU31DwbqPX2S9Sw+BSLoFaPvKd+llJoyxRe7eptxq6s1a2s06EZqPDmCJx82Cv4nbB+PmGbIY8eiQagUCei0hkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106316; c=relaxed/simple;
	bh=CpDAs4T7K7Cl8E9QS7pZZ9OgoaIoAom4ZHkQ91+R07o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR0TwxKGUGQADiwrrDgDM1W6U17azmtd7a3qYf8QgdJb7UQOSa86q6y9zAcMvln9qgEC5dSPpjQs8m+nnRIbncuCHVX1cw3ERKXNFtelYlwl++MtrKStoY7OUXOHUreZulOud9u+QAlHu8ZLiOu2kgd0y6CFssrWUObJRuXM+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWqXcL9V; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWqXcL9V"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44a74032ff8so1501687f8f.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779106314; x=1779711114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZWPo8KenTZciGOuDsKcmTAV6wQo2SX9JR2xge+PTEcs=;
        b=rWqXcL9V7bFNn+AU21O4IhHp/MWWM6f5yIHnAwMnUCyQ1DU4u8TnQneW8h8yquXw+d
         qnfunhXjjcfC13w9G0I1zY5JSSn8bfnQGDJt0XvdMJQIrIaS0l030IzxqogB/m/OyArG
         jUS6DIn1nFSIhicpSF8T+OkIqk/uZiY+jFrxLb820BDSfHS3D2VOPJoD+m63+QEGiVQZ
         y4tO1ZPXXwpfbNXKUPhpmut2gNNqHfgQi30vYUV1Gyn8+96+q5lUGs1E+1MZtQTSMqnL
         9cIyXXHf9g/rtBVkm0OxSiZfu6+jqSEebAikxtbudoflF/FgUXEyd2EyPs04NNW1IoWg
         ODTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106314; x=1779711114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWPo8KenTZciGOuDsKcmTAV6wQo2SX9JR2xge+PTEcs=;
        b=ffFsmN8Z1iLwFa8Iq4nSWzt+WDnhf+woWyPALuiBQNYcpo+LSybjRIQVJT7Vj4qFiI
         gCBiQ9MD6HAm3qEEZooG4/3czj8hg2lae8DHWgetEqfipqbbW6YH8P+Z526U2AzHI/mz
         jRTah6NwRV1S9NNWk3ptm0BPEyNxH30EqiOBiTthAy2h9IbWMYQL32/+R0GY9bNpUw0F
         RHBTbGhdFHJc8d75ezU1BL8B1I3z3OlIf2P9y62PfN4O6QKs0KO7uzNEZhBj1JdusExD
         uyqymFH7XgC25fzeWpBqZzF5gILWbs8X2a8RvcjtZGLnT2BAzohahCbFWIKXyR7SxTEU
         /4GA==
X-Gm-Message-State: AOJu0YySSzOXFJr5a1vjt/68LOjwRpswpZHj6cKVBwzahJmsEu69mPV5
	y3ls7i4O6duZMKQPy7nlVY02I4jKUlOCeCYwzT61u2Z9jRffc9guSpoK
X-Gm-Gg: Acq92OErCEhzhQsevQePQAPqj+HHZh4tUcX4HMET8OqhCEbpiR8l8+BMnI/nkimMVXt
	MStil1f8XqpT52YsvHzkclh7SMjLA4WnGBY3bQcAQ6o4kto7BUIX7aLkC6kp5cYNA9A6uU/Y8o6
	+yk+JOLEbgzMwwh5/51WdXm0GifEacamUAhXpdnOOcnfZoNgn2bB4RAq6TbO8kzp4aqCHC416NO
	AO1XEYoDWwvjIeUu7ekdupTpwBm++otX8t9bsC2JVIMsBrvx/KhMSoVkESh93BvWgiLFEm4Bm3U
	CFV1JTtdZ5x/0aAwLBxTE1/LPqFIG1srO1OunaytymRgNwRCIDscbVjurYLJ94JJndRgiM8p0y/
	+YSrNqfNd3ZH9yQtP0TZk1KQv0i5Qu+rWsDDrgmyuuH3p8ZkrnZXGjejx4PUJATaLBEdZER1PEL
	GPn66DseGMQ8serQVh2XxREufhgu62kM35n7n4shPF8BaAnNZojQOWfqE=
X-Received: by 2002:a05:6000:2207:b0:45e:73eb:2a75 with SMTP id ffacd0b85a97d-45e73eb2ab3mr10959554f8f.16.1779106310843;
        Mon, 18 May 2026 05:11:50 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19c2dsm38056869f8f.21.2026.05.18.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:11:50 -0700 (PDT)
Date: Mon, 18 May 2026 14:11:48 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_icmp_send kfunc
Message-ID: <agsCBIBtnRdo54dK@gmail.com>
References: <20260515194746.50920-2-mahe.tardy@gmail.com>
 <20260515202358.20252C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515202358.20252C2BCB0@smtp.kernel.org>

On Fri, May 15, 2026 at 08:23:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] Calling pskb_network_may_pull() on the original skb before cloning modifies the SKB layout, causing BPF packet pointer Use-After-Free and panicking on shared SKBs.
> - [High] IPv4 ICMP generation fails silently in TC ingress due to a missing routing table entry.
> - [Medium] Unsafe use of a per-CPU recursion protection flag without disabling preemption or bottom-halves causes spurious failures.
> --
> 
> commit a8e749b3f92e491c40d461bbeec717cff3d92cd2
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> One line subject: bpf: add bpf_icmp_send kfunc
> 
> This commit adds the bpf_icmp_send kfunc, allowing cgroup_skb and tc
> programs to generate ICMP error messages instead of silently dropping
> packets. It clones the skb to preserve the original buffer, checks bounds
> with pskb_network_may_pull, and relies on icmp_send or icmpv6_send to
> transmit the error message.
> 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 9590877b0714f..a1fe20b45f29a 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> 
> [ ... ]
> 
> > @@ -12464,6 +12466,95 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
> >  	return 0;
> >  }
> >  
> > +static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
> > +
> > +/**
> > + * bpf_icmp_send - Send an ICMP control message
> > + * @skb: Packet that triggered the control message
> > + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
> 
> [ ... ]
> 
> > +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *__skb, int type, int code)
> > +{
> > +	struct sk_buff *skb = (struct sk_buff *)__skb;
> > +	struct sk_buff *nskb;
> > +	bool *in_progress;
> > +
> > +	in_progress = this_cpu_ptr(&bpf_icmp_send_in_progress);
> > +	if (*in_progress)
> > +		return -EBUSY;
> 
> Since cgroup_skb egress programs execute in process context, they can be
> interrupted by network RX softirqs on the same CPU.
> 
> If a task sets *in_progress to true and is immediately preempted by a softirq
> that runs a TC ingress program calling bpf_icmp_send(), will it read the same
> per-CPU flag and spuriously fail with -EBUSY?
> 
> Does this critical section need to run with bottom-halves disabled?

So failing close with EBUSY might be okay in the first place, maybe we'd
like to have two PER_CPU in_progress flags, one for softirq and one for
process contexts?

> 
> > +
> > +	switch (skb->protocol) {
> > +#if IS_ENABLED(CONFIG_INET)
> > +	case htons(ETH_P_IP):
> > +		if (type != ICMP_DEST_UNREACH)
> > +			return -EOPNOTSUPP;
> > +		if (code < 0 || code > NR_ICMP_UNREACH)
> > +			return -EINVAL;
> > +
> > +		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
> > +			return -EBADMSG;
> 
> Does calling pskb_network_may_pull() on the original skb before cloning modify
> the packet layout? If the headers span into paged fragments, this could
> trigger reallocation of the linear data buffer via pskb_expand_head().
> 
> Since this kfunc lacks flags like KF_INVALIDATE_PKT_PTRS, could the BPF
> verifier allow programs to retain and dereference stale direct packet
> pointers?
> 
> Additionally, if the original skb is shared (which is common in tc and
> cgroup_skb), would pskb_expand_head() hit a BUG_ON(skb_shared(skb)) and panic
> the kernel? Should the packet be cloned first before pulling headers?

Fixed

> 
> > +
> > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > +		if (!nskb)
> > +			return -ENOMEM;
> > +
> > +		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
> > +
> > +		*in_progress = true;
> > +		icmp_send(nskb, type, code, 0);
> 
> The commit message notes this is "mostly for tc ingress progs". Since TC
> ingress happens before IP routing, skb_rtable(nskb) will be NULL here.
> 
> Looking at __icmp_send(), it checks for a routing entry and aborts early if
> missing:
> 
> net/ipv4/icmp.c:__icmp_send() {
>         ...
>         rt = skb_rtable(skb_in);
>         if (!rt)
>                 goto out;
>         ...
> }
> 
> Will this cause IPv4 ICMP generation to silently fail for TC ingress programs?

Yeah, we need the net patches to route the pkt that I dropped in v5,
let's put them back in v6.

> 
> > +		*in_progress = false;
> > +		kfree_skb(nskb);
> > +		break;
> > +#endif
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260515194746.50920-1-mahe.tardy@gmail.com?part=1
