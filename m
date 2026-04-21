Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB93A0B28
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761799; cv=none; b=pSdZ5G+Ese5dduhbOVPfDLjEqyxQ668MWRWDIctoUOvwu1Wly8Ra1dOzBGxKDe67Nd5Zvjd6c89YIiStVgLBvL1Jn+yi187/vyNgFkfq5b7bAN+ZGN/e6+j2Eqyozsd9i/iao1iECTkZe7/zFZ3UyhAmLm8ndG7ZzGMkN11yEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761799; c=relaxed/simple;
	bh=xFe6GTxk5OpjI0bwR0p4DbCifJm1OGLBMKQ/rkuKQB4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBYmmNIu/qaW5avGoAmG4Y1TzjLE3QXGZL4qWJHWRNAZ7gfEUsIxEpyxZrpjxxDppmV5ewNxcItigYsyOBwb4fuojEjx1ZxzqWClmdTX/zDnSZ+befKyQ7R2duK2Tze3tknlPCK9M+w3UBjlOpB1o1KPOqsK0nZRfHJXEcCxhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVZwOUPq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVZwOUPq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ba840146so37419225e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761797; x=1777366597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJGTnZ/i4iiKDQkhhblybqqq0JPrJTq68F+X2OSciiY=;
        b=oVZwOUPq1du/UnvZ3bQFHDjfWGpaz5P9jTtetfKNryDtk6GibQ19QtnDWnPXVPWzjT
         vLs/U27fF/fxSsk5/GKxLbcgwtNYYavfZ8bThMNYUFu5PLoUUzEgMdUJAkg/Apwxq1uU
         pbLh/Hoyv78U96JlfUJa87pWdBi0QLmK+r0LyKwpxfkAQ0/zf3IPKxzadMhX1F/IQCvf
         U4RJqsHAzFJD2jheulKRPnN1plF5hL94kTT9eElXoluia5bCvnfHbpm62XfdkrooEFDO
         tL0WARL7B8xTX9i7FOK4blar3J4l/zvh9iP9Vpc/kjvosqauBgryAcRPrOvNitSLWrZI
         KmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761797; x=1777366597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJGTnZ/i4iiKDQkhhblybqqq0JPrJTq68F+X2OSciiY=;
        b=nfIOvXHyYZdDaG20cID+e8hctaV2WFHOUQpcjENdr0BPiFgbdFyzq/lNnbaE/qEDdl
         y9b02mHpYe4XgUMipmLhJHPFCwJWWqto0GwUmr5SrxqfIWErg1PhLXa6Ot/Tmich5YsB
         mJTV4zKgJffq4xCrQjESnAAcbsJyywJbakpiz7zv9fQ4a/nDPUsVU/SsEHIvyD4XenWE
         ZbeX4jPuWmd8X7mzNpA3vONGcjj3GthLi/u+lAEhYjnwe5zouEuwfCH50XzqSVY+Vi5C
         m+auq5AKR9KYPUbH7Bj7odcU8JCHXnSvzt7t+RTqqMdQid37lVTXeiK3hEeohoF1u2nF
         seGA==
X-Gm-Message-State: AOJu0YyjrN/KWqKvtGa/i6KDyeY+XOVWjeNVaf7LAaitzzgnNwta7fwK
	qAL4VQB9/0NhoLoZ5Ggk6PdbOpJk7ARtFCmPeCVnwN+i4jyhUjIQNxaLEW/0b5UT
X-Gm-Gg: AeBDietjND4RRxkY5S9dnEfBivL7PGx/4BSs/kkj3y0ZUm0J2XLh73bryLVEKaqdMec
	GdaTkyGd1MJKegqpnaZJKMuKWp6WR+DwAF8DdDmU5FXO/iWHOJ/6/4AsstjyHpYwfQ38djrp1wg
	4eyu91+prvjAyDPiCbucymcpC7oiB2B+aYSoVT0jk/PUPa0TK79ofexhk7XYp9rdgJ4OYDIVWib
	LUEBGRt94TDV9qSW9BWerEaZzM2/LT6Go1+YQ9Nl7Lcgii5uqQKKwwEnP2UswNsTSjBuWFeA6Dc
	2dZ0jMEzg05PNtPgtdQni7DeotGrAXQBwtSJDyiL30u0PgUrTTrdce5Yys/v4UhrtgWxzs8ECfC
	r0J4/HHIgTnxBMM9SbM+MtTmqZa5bdcgR+Kfp67IfMkC2dY3NWlHCL38BSn4D/YUMpZiLbBnYir
	Nr0eo4ZR33oRiBBqTfQA==
X-Received: by 2002:a05:600c:1da1:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-488fb7863femr258215435e9.27.1776761796740;
        Tue, 21 Apr 2026 01:56:36 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb77b001sm160916955e9.3.2026.04.21.01.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:56:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:56:34 +0200
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 13/28] bpf: Add support for tracing multi link
Message-ID: <aec7woEWsDxnDvqv@krava>
References: <20260417192502.194548-14-jolsa@kernel.org>
 <20260418085839.ADC19C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418085839.ADC19C19424@smtp.kernel.org>

On Sat, Apr 18, 2026 at 08:58:39AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Low] The patch references several undeclared identifiers and incomplete types, causing compilation failures.
> --
> 
> commit fc7697083b71bebef41d2da3a91ca2a0741ad6f0
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Add support for tracing multi link
> 
> Adding a new link to allow attaching a BPF program to multiple function
> BTF IDs, represented by struct bpf_tracing_multi_link.
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index a3c0214ca9341..da3e01dd7ee9a 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> [ ... ]
> > @@ -5748,6 +5748,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
> >  			ret = bpf_iter_link_attach(attr, uattr, prog);
> >  		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
> >  			ret = cgroup_bpf_link_attach(attr, prog);
> > +		else if (is_tracing_multi(prog->expected_attach_type))
> > +			ret = bpf_tracing_multi_attach(prog, attr);
> 
> Is is_tracing_multi() defined anywhere? It doesn't appear to be declared
> in this patch or the existing kernel tree, which could lead to a build
> failure.

it's added in "bpf: Add multi tracing attach types"

> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index af7079aa0f36d..df06a733a2e71 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> [ ... ]
> > +static void bpf_tracing_multi_link_release(struct bpf_link *link)
> > +{
> > +	struct bpf_tracing_multi_link *tr_link =
> > +		container_of(link, struct bpf_tracing_multi_link, link);
> > +
> > +	WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
> > +}
> 
> Where is struct bpf_tracing_multi_link defined? It seems to be an
> incomplete type here. 
> 
> Similarly, bpf_trampoline_multi_detach() doesn't appear to be declared in
> this patch. Will this cause compilation errors when dereferencing or
> calling these?

defined in previous patch "bpf: Add bpf_trampoline_multi_attach/detach functions"

> 
> [ ... ]
> > +	err = bpf_link_prime(&link->link, &link_primer);
> > +	if (err)
> > +		goto error;
> > +
> > +	link->nodes_cnt = cnt;
> > +
> > +	err = bpf_trampoline_multi_attach(prog, ids, link);
> 
> Does bpf_trampoline_multi_attach() also miss a declaration?

defined in previous patch "bpf: Add bpf_trampoline_multi_attach/detach functions"

what do I miss? ;-)

jirka
