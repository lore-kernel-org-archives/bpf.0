Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D0492539
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114089; cv=none; b=jydeg11DnUglNn29J3U0DXd/WOmHWIWDk/Pwnu7OAtOSiGn8oulPRtv1FsQRkZzY1VDdVmHvqtUReDRWTfM8GXtrVsvGvWnbS9jhBt7J4zRWPZEba+qh9mP9EH6TVsz0ecJKBDytB7z9RPThCjHTQlc76epfwNJykmg+QLMl3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114089; c=relaxed/simple;
	bh=ViOooZ5q6HLjbn4PmRfwA6YbFDqGs3bxZJ7jJDAirp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cx4OE8cfpPN8BYXzG+8WDsFevQqPnhALncfl1GPl0pU6GDMD82jXa+PreXiFOwI97jpuwiErmKKrBOnSLY0oYUXmv1IpOOGBduqXuZ35BF8LaeIhEu3HnZQT4BJR8mO0JCrbURaZeyo7llVKE4NWBd5brgXul83WFhvh8o1f+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpNf0cNi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpNf0cNi"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44e5624c053so1357986f8f.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114083; x=1779718883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EYFr7XXcKEsZj+Bv1UNXpfsZHaxqcET1cNdw3E5KQ6o=;
        b=hpNf0cNigPpXw9DykFa6IzN5idA/nkAFGlX77z4gmiktlupdS+NvYA293YJl/UyhX9
         QVJh0DLrqKNAxMZ1YqiW92drtZZcx8zCwaS4BIysSLKp0R2IshQAbpcLiVhNm6SSRB80
         tHjgNex6fZKg2y2caMDnNx5xlQqEOJLltG+/VHBUf8tHF5WVom4Qp5ORpdguND6ywqCS
         +DiPpp5DVDNRgP6iz+SFa4fwAduZDZKRSKMiOI7TYMYCRFd0xM3k8THTJBSem9u0Hau8
         1ZddxKq98msBx9Gf2+jXNHcxihO+uSH7vyUuKpauUBPl9Z9RosFCkWFuYbqbUfwco+dR
         BCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114083; x=1779718883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYFr7XXcKEsZj+Bv1UNXpfsZHaxqcET1cNdw3E5KQ6o=;
        b=oPevvcTm8AgUnTGhAKnEDM9vY6BzLpoSPy+fSObtz4jmPbephrNh4Ql6TXwDOoSGWE
         83nvPOmyvikz4/6hIVXHxZCqmrbSZbTP8lOC12/tJWzZo9sPuWyJ4Cf5Kr0LZdNceMln
         I5lO7w8lCBB3+zxsI/am/VoHq/onMMX2O4dOhjfTYHnK4AKwtuB2Qs5t+nN+fxxNELdg
         EroOmcGKnUM8k2AcYHzxg83RmhwM6f8PCi3svbziRyJxlB6EFuLwFNYFD90yn9WYE9D7
         +Am1ScEayg/K4O1BtAneMXWB9kRCk5WEHpjzpfhgMZEN+WhGxufPtQAvXjkO+/YFFRJ0
         8wUQ==
X-Gm-Message-State: AOJu0YySpEJQAqINN0RpHZpBdfiYp5O7bzczstVsu4JCKTY09J1Pz0YY
	FyEd3+/E+T0ZENZsTuOxf9bc87HmezmxcegQaLl0z187o31JEGgmkall
X-Gm-Gg: Acq92OGpqcwTanoDFb4DIt8EPMQ0wr9zHu2ZNlpuk/d92pPV1BjMixMNW/XMl2ka6t6
	1q9z6fIOdbF1KvPzSBVTS0DJ67KLCau6hl4UTc42befVpzVCCCRl3NeMLREXPu0lDNrfyPHIsZU
	Vm9Wm32deDl0H5c5rTjAgjNwcYT9TO9CTBXBObrGbPxE9fEv4b7BHo33Y3Ql07sOREdvx7v7hQu
	wADJo7Kw2Ym1GZzSK1SEgQarVCaSRjWKklnzz0vAmtEsjCpaBg46OggqBO0NRLZTLoWFKK4iZkC
	wcB6X8q6eelHfGLczs/2OYlj+gkRPTBv7Jwz7jrug8QlO3rMeB7VDmLXVWm0aXTf4y4AcQE3gSY
	CacIz0kaYhLzNXxiErLA8DQCU+raRpoqzokIUk/jvqQQuXbigULpsPQzISmpHJ7JZKARk4MFhR7
	SyaInNH6bMlZecfXceLiaEwyXBP7/8r17ufx7kyU9h2m3vn+RNLyWGoIOnsQpqQRhRwg==
X-Received: by 2002:a05:6000:2083:b0:43e:a9ba:b194 with SMTP id ffacd0b85a97d-45e5c5dd921mr25324601f8f.34.1779114082921;
        Mon, 18 May 2026 07:21:22 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1a22csm36715510f8f.19.2026.05.18.07.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:21:22 -0700 (PDT)
Date: Mon, 18 May 2026 16:21:20 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 1/6] net: move netfilter
 nf_reject_fill_skb_dst to core ipv4
Message-ID: <agsgYJsHZzA_0L97@gmail.com>
References: <20260518122842.218522-2-mahe.tardy@gmail.com>
 <af01ada15e1b76da2dfb6cfa749727e0337787f117ddf5724a3cb702513e81dc@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af01ada15e1b76da2dfb6cfa749727e0337787f117ddf5724a3cb702513e81dc@mail.kernel.org>

On Mon, May 18, 2026 at 01:07:54PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index bc1296f0ea69..1f031c5ef554 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -2945,6 +2945,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
> >  }
> >  EXPORT_SYMBOL_GPL(ip_route_output_flow);
> >
> > +int ip_route_reply_fill_dst(struct sk_buff *skb)
> > +{
> > +	struct rtable *rt;
> > +	struct flowi4 fl4 = {
> > +		.daddr = ip_hdr(skb)->saddr
> > +	};
> 
> Can this lead to an out-of-bounds read?
> 
> Now that this is exported for BPF kfuncs, it can be reached from early
> hooks like TC ingress where the IPv4 header might not be linearized yet.
> 
> If a malformed packet contains less than sizeof(struct iphdr) bytes of
> linear data, does accessing ->saddr require validation via pskb_may_pull()
> or similar?
> 
> This concern was raised by sashiko-bot@kernel.org in v4 review:
> https://lore.kernel.org/bpf/20260421111320.D97D9C2BCB0@smtp.kernel.org/

Yes but it should be fine since it's the caller responsability to make
sure the header has been linearized, and we are calling
pskb_network_may_pull.

> > +
> > +	rt = ip_route_output_key(dev_net(skb->dev), &fl4);
> 
> Can skb->dev be NULL here?
> 
> While safe in its original netfilter context, a BPF_PROG_TYPE_NETFILTER
> program attached to the NF_INET_LOCAL_OUT hook will receive locally
> generated SKBs before skb->dev is assigned (e.g., in __ip_local_out before
> ip_output).
> 
> Does dev_net(skb->dev) need a check to prevent a kernel panic when called
> from such contexts?
> 
> This concern was raised by sashiko-bot@kernel.org in v4 review:
> https://lore.kernel.org/bpf/20260421111320.D97D9C2BCB0@smtp.kernel.org/

We can't attach such program as now it's only cgroup_skb and tc,
outdated.

> > +	if (IS_ERR(rt))
> > +		return PTR_ERR(rt);
> > +	skb_dst_set(skb, &rt->dst);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(ip_route_reply_fill_dst);
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26034287312

