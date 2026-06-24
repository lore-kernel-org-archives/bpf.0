Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE225785D
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295145; cv=none; b=R/MSUY76OUrOecNSdq55AZYfu7c0sW0KqOzmiStbZdYzajYKsDRxm/J3pG4y30WWbqx2fhDcppQMKufgZQiJ6/CI322q2ntd4MKuBnpksJZNRU/LVprPt0B/13GxkJ+Q5aSKAJU3d/0tqnM5INVlQy8q3GUzh16tOZU5ZnXATIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295145; c=relaxed/simple;
	bh=kbnDf0a5NvzGlSFhlTe2TF6vhRNL2dO82YCQFBLak2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdHJVH+qwELMPietREUnXCtaVd/YHFCJiM5kUJEtHzNxwMzAT7ivsCbUc9oh2Gs7CvGOUf2FjFeROV8O8eGFTlw6In3TY6xbgliMAh5uhS7MUaIJTZ136Uhry82CM6QLsgzhLv30Q0C9ID0XU1pVwRrTRkroERQmdc4jYiHrL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSjZT/rK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSjZT/rK"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so702911f8f.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782295143; x=1782899943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYdLcwX5ZcT0Nvx80SMQN+5Ha2iiINESIZiPkUN1J0U=;
        b=CSjZT/rKNiMgw7bxKMZvNLdhz2qMv1f1flpPbdoBK5B4fv+Tp94kGQkZMh+CXGrDra
         9c5/pDqCjoGSokgOzwHHjGBL+wW5/QEwu5VY0pW9dq6rdu6dmPF3yi7CcAFjISpMs6dV
         v444WkurGk6Zg08bwKsmvfa5BxNhEH5szmw8B1nkSraQ19SFaYgO5pruwOdkb3EFZIB+
         YBVGgk79tzB2wmg8hwdzfx7oUJ7CG4ciPwVxrP90sPDfZtXoAeYv04U2+cA7n5azMU8N
         qo0IaruO0wmf8JQuYAgvHTOdpaCHphmb2Mxlvk5Xdw398WNsS5o05/JWLqMu/fggdsoV
         nAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782295143; x=1782899943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYdLcwX5ZcT0Nvx80SMQN+5Ha2iiINESIZiPkUN1J0U=;
        b=IWoNgwkxiAobM7Uk8gM1i9pN97S3m97QlPIJoU9Z/jqYgaRLNQPxXyoM7t6Z/hZFpj
         s2WqmJs38n2nvFg01V6Sr/m4nM+h8FsikUxh9u7Tams8m3yvTfWx9CmwHaj9AS3Uahqn
         olCJObplKhaZNSTmX5KrBKUKa8ekO7qWZcKykgaEEwfP3JG5JnpRiMTl4ycm5lZXz1sN
         TlKIDGTIiIJiY9AIJ4ZLvcOWT69xKergS32VhiAAeh/t2gnOvk4C7EkDu2Vi4/urspVX
         FvTcTNYzF2MDPOR1TYPn9lGiptxKALIRuaA3yff0Szp+32/3XGyQHAFtwbHMxYU37jEi
         /rqQ==
X-Gm-Message-State: AOJu0YxRc8gHKPPrEcNcFWHUDVWU0UatAqAJmrnhNKsMKwDYTzE7/XGn
	+up5bz5GSGqusnYpJLVf22hOlG7mRdNGlSXMd0iyGvhVhMpie+nCd+Nh
X-Gm-Gg: AfdE7cmWd+46yr+cdZfckA5hi7kpoIXCAL5x5Fz82YTs97ZD0sIwiDzOZ7rohFz2eSF
	1L4X/cpO19OmKLsk44jrGqFPrvC9q15X9TgpTegPIHmToNCwwsAr2tDauma8CCYLgED6yF7TKaE
	g9GqFUlBPfElaNXktbrmDSznIjMIlUyTZJ+fFwl3/AJCuSsW6XoBOY5FYNnmaYLtpr+YoNE+2nZ
	h1tmokPhfQ/ZQ9735zW9dP8BD4bNwOfRagscdRcOURH8Xhlm81734yHXiF8rXO626N3bS1C2eS9
	mDcshN5KUq4xk9VDxBvK8oKNdL2PWE6kVH0F2wZUxsUt3nnzlYx32pf3gRxGUwyxhsKFHHq7C5X
	GrsIoatQvzwNXKBMBMXFfdEP8mnuABS9nJH9tQD0aga/RsQNdXm+Exxd4zZ3lY5WUouCpQ0Crks
	JS6omYUYbP7mtI0OS4vC6HyPQUri4x8aiI6WRIEk3MhFbxVaxWxQ==
X-Received: by 2002:a05:600c:870f:b0:492:3445:ecf8 with SMTP id 5b1f17b1804b1-4925b34a38amr94308615e9.3.1782295142647;
        Wed, 24 Jun 2026 02:59:02 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923914fsm370236405e9.6.2026.06.24.02.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:59:02 -0700 (PDT)
Date: Wed, 24 Jun 2026 11:59:00 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, edumazet@google.com, john.fastabend@gmail.com,
	jordan@jrife.io, kuba@kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	pabeni@redhat.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v8 3/7] bpf: add bpf_icmp_send kfunc
Message-ID: <ajuqZMzqACLOijoC@gmail.com>
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-4-mahe.tardy@gmail.com>
 <DJGWWQQD3B0P.2O1D9MO17YRK4@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJGWWQQD3B0P.2O1D9MO17YRK4@etsalapatis.com>

On Tue, Jun 23, 2026 at 10:09:20PM -0400, Emil Tsalapatis wrote:
> On Mon Jun 22, 2026 at 8:05 AM EDT, Mahe Tardy wrote:

[...]

> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	case htons(ETH_P_IPV6):
> > +		if (type != ICMPV6_DEST_UNREACH)
> > +			return -EOPNOTSUPP;
> > +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> > +			return -EINVAL;
> > +
> > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > +		if (!nskb)
> > +			return -ENOMEM;
> > +
> > +		if (!pskb_network_may_pull(nskb, sizeof(struct ipv6hdr))) {
> 
> Minor nit, but this may also fail with SKB_DROP_REASON_NOMEM. Now this is only
> possible if the IP header is not in the linear space which may well be
> impossible (?), but do we want to differentiate with
> pskb_network_may_pull_reason()?

Indeed, I think for the IP header is should be fine, but I replaced it
with the reason variant. Thanks!
 
> > +			kfree_skb(nskb);
> > +			return -EBADMSG;
> > +		}
> > +

[...]

> >  static int __init bpf_kfunc_init(void)
> >  {
> >  	int ret;
> > @@ -12639,6 +12745,9 @@ static int __init bpf_kfunc_init(void)
> >  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> >  					       &bpf_kfunc_set_sock_addr);
> >  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
> > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_icmp_send);
> > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_icmp_send);
> 
> Based on Sashiko's feedback, since we mostly care about cgroup_skb
> should we just make it exclusive to them and drop CLS_ACT?

This would indeed simplify this patchset, I could drop most of the
complication induced by tc ingress routing. But I think having both
cgroup_skb and tc support would be nice as a first implem. I'll try
again in a new version as I added a test for ingress tc and could
actually fix the routing based on sashiko's feedback (this also drop the
first two patches that were partially wrong).

> >  	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
> >  }
> >  late_initcall(bpf_kfunc_init);
> > --
> > 2.34.1
> 
