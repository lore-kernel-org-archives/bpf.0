Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC033A1684
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690451; cv=none; b=UlJiuyRjrIellzIKoWLcpxLupkqSlIjbgBeOiWg4sVb2K9X2HzdlyQs6L4438gwnzDkl9dWu5OTrXjDDry+wsoqBfoAKcbi+QfURXFAhViMfhvlXibZeLFsJKIoxTyUmiYYgGPFb9z+w6z456yU2xzou9cFrHlm5OM6wact2Hw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690451; c=relaxed/simple;
	bh=JLX0QIE+ZaB7zS+4hzCYPPCnUIvUgu+mL5VLldlw4/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzyO6s+M3YE+/Q6mHeqSH2oz/RY7WFor2pfER4zbxw5o4iFFGi0yrBfCOJlOJfWkts9s5rvm4fmGzBs5GVdeAr4c/leb9DRPuc6qoF83hUcPsN5S08x04VBlGnDRz/xz+sTc0KDEnxnzKsUv/CeSi7b33wyXkOqSEfJ13gWX96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmsK9UBN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmsK9UBN"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso1405174f8f.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776690445; x=1777295245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ag56mmJk7Zmpm+f5Y09lyaEBE2YSArv7z93rWOQIdM=;
        b=ZmsK9UBNEhonMgwHlY7RquBbKesfSJLglYPS0BN5a/HFrZzYxe+8PuUh4/t3/GwDeG
         U2qXfV2DGAdQ5k+/6c6Cybp+rK8OKQWgXh5BjCPE2zIJ5JvEaIkXBjnovWB07due+OX6
         NQLsFmQeK3JRKi1Ok6+GqM5H+45fahWB82mdzIEliC2MwqpOzttmvim3XoG7yuzvsc4o
         WKCR28PLeNN0Jwvh/wW/L0/x9jY3C3bOFmhToRREM1MP0hoE0GMO1uGjH2E7RGmLn87T
         H2SbmU7TH30b1nFfPyu/IgVr2MD32U7aycsE8+aMVCUDxgfiIY9FCWyiWIDzAh+XmG3N
         iowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776690445; x=1777295245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ag56mmJk7Zmpm+f5Y09lyaEBE2YSArv7z93rWOQIdM=;
        b=HfUt1KCcpEaP60ptu3Ikec4RdgYvPK7J6s+IJthchyPl41yvsV2lc0u68H/Teo9YOd
         SHWVtROpgKgQlISuqW2CJBCrL79JYoo7nY6uhGbshTf6mXElVkOutAv1KPxif2Pgxf2V
         L8unk0W7uGzSZmmpfXZYH8M4ARhbB0VukPST/LLmCIi14l/CjbYuarANGBk/g5vhJRrs
         zGPtNRcbN3RhA7mptt3EtN0SriVNs+PXR7Zzzdv695jUlrlQZh2J2fBxLBtwTFaVRInJ
         gfERN8GyBhpPHBDIc2Co/0VBuHiUdD9tzhVhZMeiRViba3Zl43+ZeUf0xxi79ComJoUi
         OoDA==
X-Forwarded-Encrypted: i=1; AFNElJ8/CE6Rlt2xnNqs5urObxIkQI9tk8xG/eVN2c3PY1XdI45ix+L3JewjQ9rzQjBDXo5b3cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZ88FvxWUMv1ENy/RdnFZ9sSjtPvMVWpl8m5oGPyTpvHXG+tN
	fokDtMAtSMoeAyIv82BxyG6plk0Yeje9P942hR774oBACNvY+IFACFHM
X-Gm-Gg: AeBDiev1Kk7x05VutKwi0CMjnmeezCrcBhQYyWek30Xfs/wMff3OQRHUEzZnO9S8jTq
	4RIS2Ob8TSqnkNVr4jBWXrtCuZMqlIdzrBSX+MtAF2SJw4g9kjsOFLKO6hIYLDo9bxDgkR0Ocs1
	1qP59CHkhJNOwYBSNn95xjQPFoWq/1eQ/asvHkdvvh2jSWzW90oNIDeR4dB4KVeC903z7+0cOSM
	qvG/Fy1QT4eDcwfEtqmzfRRnrETZ9Hiq7bOQni/P9Oggm8NaJCt7gZ7mc8+6VbcyGD5OiJ5M7RH
	JslFG4+eJYhn08uKEpWMab6QmrOQk4vFoWZ8EFykcL4c44yc2gEA7ECmbBpd5abognBbkEZApZ8
	rdclb/cwOxaEBVPVzGdavmWFPh2YR25l/1OZWJr22vrynGTh25NXPb/c6eCszB/MZn8/7OLgn4E
	Jge1eTZfuRkSf4ZmllquYczP0gFcHMFJ+mHKtHrYLg42xRWmy4uUY2wnxX8Lg+uZvySw==
X-Received: by 2002:a05:6000:4203:b0:43d:242:b9bb with SMTP id ffacd0b85a97d-43fe3dc5c80mr20542019f8f.18.1776690445002;
        Mon, 20 Apr 2026 06:07:25 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm28070324f8f.31.2026.04.20.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:07:24 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:07:22 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
	fw@strlen.de, john.fastabend@gmail.com, lkp@intel.com,
	martin.lau@linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v4 3/6] bpf: add bpf_icmp_send_unreach kfunc
Message-ID: <aeYlCswvGdTHiAFp@gmail.com>
References: <20260420105816.72168-4-mahe.tardy@gmail.com>
 <c706a726c2e82dfc6162f96d7c04313301c24d1a4e36af5c421fda7a1c01b1a1@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c706a726c2e82dfc6162f96d7c04313301c24d1a4e36af5c421fda7a1c01b1a1@mail.kernel.org>

On Mon, Apr 20, 2026 at 11:36:15AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> 
> [ ... ]
> 
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	case htons(ETH_P_IPV6):
> > +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> > +			return -EINVAL;
> > +
> > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > +		if (!nskb)
> > +			return -ENOMEM;
> > +
> > +		if (!skb_dst(nskb) && ip6_route_reply_fetch_dst(nskb) < 0) {
> > +			kfree_skb(nskb);
> > +			return -EHOSTUNREACH;
> > +		}
> 
> Is the route lookup needed here? Looking at icmpv6_send() in
> net/ipv6/icmp.c, it fills fl6.{daddr,saddr} and passes them to
> icmpv6_route_lookup() which performs its own route lookup. The function
> doesn't appear to use skb_dst() from the original skb:
> 
> icmpv6_send() {
>     ...
>     fl6.daddr = hdr->saddr;
>     fl6.saddr = saddr;
>     ...
>     dst = icmpv6_route_lookup(net, skb, sk, &fl6);
>     ...
> }
> 
> The same applies to the IPv4 path with icmp_send(). Additionally, at
> cgroup/egress the skb->_skb_refdst should already be set, and the same
> should be true for cgroup/ingress for inet proto.
> 
> Does the kfunc work without ip_route_reply_fetch_dst() and
> ip6_route_reply_fetch_dst()? If so, can these calls be removed?
> 
> Reference: Martin KaFai Lau's comment in v3 review
> https://lore.kernel.org/bpf/df4b0996-3e88-4ea4-983b-82866455a6fc@linux.dev/

Same reply as https://lore.kernel.org/bpf/aeYkdKm7B4NQ3BDo@gmail.com/,
too bad the LLM can't access the cover letter.

> 
> > +
> > +		*in_progress = true;
> > +		icmpv6_send(nskb, ICMPV6_DEST_UNREACH, code, 0);
> > +		*in_progress = false;
> > +		kfree_skb(nskb);
> > +		break;
> > +#endif
> > +	default:
> > +		return -EPROTONOSUPPORT;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24663313503

