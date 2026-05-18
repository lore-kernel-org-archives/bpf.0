Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B93FBB4E
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114132; cv=none; b=T5iUH+t1XlTMN1eKEyD78YaDUKrMUNdP8h1c4g+Jqyiv6zHtnrtpyQknp1HsMFugZFqTsVXErHnzW1tg/TllDKSLsLC1ksuH/hRR6dYhfzA1QrOW6Dr0acMiuUUCbp/AE4TGvIJdqh0NANR5AiRdxRyoxgKK11/17WaAZbML9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114132; c=relaxed/simple;
	bh=gSixFFclTUS7ckGyJ6STwjNMBKoWCtWW79rUv1GMZXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZPPoAd4CZpPooK5Y+dGzTJZw3udv2MiN7fXO2hu419ZyNbAenTo7B6d9BpvnUztwIb/Q0Ng0tu4gcwOK6pUV48FWzd2yOwURno9Ofr0OtvXs2hzJeViDC3D3EyWMGeWvy0Ltx6S3ie10zbTJJrorkTmAkza++lKEOQQ772FAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8jIZ2II; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8jIZ2II"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso16379525e9.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114127; x=1779718927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Oumtl4pXAJKEcGCQwup2CrdSSym8HzjHOOsWboStNg=;
        b=j8jIZ2IIsuxpWQ870MzemgZoBPQSu+i0AsYHIMBek6XI8VfiwGpMeweG1s/U8Jeu/w
         bswnS4SxwRZ3/lbWH9xBJjHltNY9EkfI5DralRIibUZnRVZ/4WwV1QIZvzkwXD/kHxMt
         ioVikITIBBqL258ANDW7aVQoeDB66sftmIZafvjqz24jKTK/JYEQ6zZde8o2bRiyDCxT
         rtHsfOuGmP1XEgBVa+Sz5DJRUsgnGltCUSaPvIAludNRAsDpwRPtejaUSTIn15MgacFs
         cxss4wlpunyxk0AeZfM4jJqmc54spg3y3y/hw70xkQA1ZJwHrz5GnqNTVsl1ogcwx5yd
         g2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114127; x=1779718927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Oumtl4pXAJKEcGCQwup2CrdSSym8HzjHOOsWboStNg=;
        b=mY/3m7b4M4186iv+mdQY9gS5zQLiC6wPUTNn1QJYldb2zWi/hzJzYty6bTZFlVRYy/
         4fvH3lr0MAPYZFRfzCJf5VvtelImq2tboe5Y0XBiSp0wxZjx6dOv8rmjz2A5mADZ+Jic
         OXscuKhOTxKjlATLhRWN8hHqeyxK8btN2hGp2BMh0zd8WdEVl/fmTwj4JG0MmATIrFuK
         M8LzjmQudC481kx/8B7rCQzx4SLWXsE9mhvR6dgS9NECwqz7pVAhHYkw5vikkPGqHSqr
         TQFIb9zoWYRVhQdkrfD2jSQ0ZVy9ICoEP3zxBws6gapoYyeueXRb5TvK4VHzi97xnuS5
         qmxQ==
X-Gm-Message-State: AOJu0YwG3I8N53u1W1aBUNvZsRRu1XKKC1Kpabo8imlm68/GEW8ERvMJ
	D5/XClbo9gg6ju/YRtqaKJ01YFkUkgF2CNF0sTyDi+5x1b2HKmRTfvi6
X-Gm-Gg: Acq92OG6X8+cw094o0eJwnyJEIULoqA9DrTk7whPF4qljg3GE5u8eKr9b2kthVdNsg4
	FcDJlD+R/ey4cpsTsr19POwfO3KeXbLfG+OezN5sKMTvz8z0k0z7hAJJXLHu8f0nimNI/Si21j8
	1tLoA27ayDy/fRkrTRJslmqfJzphDZdxvZIcSqbU5BS0imFz9xCSp27r9F+PuI/U6rm57Iy/aue
	7Qakfb/EyzyZHNezSO4UIkogfQ5UqG4bmxkOmAPBA9sjfgqQFhvUHHQiZjNHPNBA0HJZX/FUDsb
	HvduPQ5hGVzvTZY3R/8sqtFqBDZOaqXRvp/B+tkrD4lzMOGS6qREvAxf3XIdZv2i/0Jd1fmwmYM
	JjJZr85yHV+/tQUf6r6W+az+7TSD92Nxoo1ynRvc6yybaZzaORwQr6z3ZcovaFS4r3A+dLV1DTG
	p56pprn3qeF8DRk0PdftO9hil/L+tb3cLK8yETBkOUHu3uiXRlhktyiFWptuYytJIJsA==
X-Received: by 2002:a05:600c:6383:b0:489:1c1f:35f9 with SMTP id 5b1f17b1804b1-48fe60ea4ebmr233939685e9.9.1779114126375;
        Mon, 18 May 2026 07:22:06 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm37137502f8f.5.2026.05.18.07.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:22:05 -0700 (PDT)
Date: Mon, 18 May 2026 16:22:04 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 2/6] net: move netfilter
 nf_reject6_fill_skb_dst to core ipv6
Message-ID: <agsgjAvP3atsziMx@gmail.com>
References: <20260518122842.218522-3-mahe.tardy@gmail.com>
 <1637d7e04ac3c65239ef77709175697bff287250913d1da68e8d4072e0ff34e1@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637d7e04ac3c65239ef77709175697bff287250913d1da68e8d4072e0ff34e1@mail.kernel.org>

On Mon, May 18, 2026 at 01:07:57PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> > index 09ffe0f13ce7..eb5a60d3babe 100644
> > --- a/include/net/ip6_route.h
> > +++ b/include/net/ip6_route.h
> > @@ -100,6 +100,8 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
> >  	return ip6_route_output_flags(net, sk, fl6, 0);
> >  }
> >
> > +int ip6_route_reply_fill_dst(struct sk_buff *skb);
> > +
> 
> [ ... ]
> 
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index e3d355d1fbd6..37a7627a94de 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -2725,6 +2725,24 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
> >  }
> >  EXPORT_SYMBOL_GPL(ip6_route_output_flags);
> >
> > +int ip6_route_reply_fill_dst(struct sk_buff *skb)
> > +{
> > +	struct dst_entry *result;
> > +	struct flowi6 fl = {
> > +		.daddr = ipv6_hdr(skb)->saddr
>                          ^^^^^^^^^^^^^^^^^^^^
> 
> Is it possible for the IPv6 header to span paged fragments here?
> 
> If the packet header isn't guaranteed to be in the linear data area, and
> there are no linearization checks like pskb_may_pull() before accessing
> ipv6_hdr(), could this read out-of-bounds memory or cause a page fault
> when processing undersized or fragmented packets supplied by BPF programs?
> 
> While v6 cover letter mentions "call pskb_network_may_pull on the cloned
> pkt", this linearization check is not present in this function.

Same answer, caller is calling pskb_may_pull, outdated.

> 
> > +	};
> > +	int err;
> > +
> > +	result = ip6_route_output(dev_net(skb->dev), NULL, &fl);
>                                   ^^^^^^^^^^^^
> 
> Could skb->dev be NULL in contexts where this function will be used?
> 
> Since this is being exported for use by BPF kfuncs, it might be called
> from program types where the device reference is not retained, such as
> socket filters.
> 
> If skb->dev is NULL in these contexts, won't dev_net(skb->dev) cause a
> NULL pointer dereference?
> 
> While the netfilter caller (nf_send_unreach6) checks and sets skb->dev to
> loopback_dev if NULL, the exported function itself does not have this
> protection. When called from BPF kfuncs, especially in contexts like socket
> filters or tc ingress before device assignment, skb->dev could be NULL.

Ditto, outdated.

> 
> > +	err = result->error;
> > +	if (err)
> > +		dst_release(result);
> > +	else
> > +		skb_dst_set(skb, result);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(ip6_route_reply_fill_dst);
> > +
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26034287312

