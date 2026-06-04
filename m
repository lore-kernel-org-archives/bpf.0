Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C3318EDC
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560021; cv=none; b=V0ss+E8Spxrb9U9+FwNAhQNke2d6y7YbnvbyyrzlTA0W8/UiLX9h9wge9ZhzCyNCbDoNTsXP0864lird4OOeP+CG6xOzsOzD9AhDmhMTs9uMqy4gt46va+VFkz73nQ81R5Epep7yLGYsmdT1XV/BhaYQNZnB+8HMk5OJWrucvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560021; c=relaxed/simple;
	bh=/kK0EiqbtRxcXCneLjLSqWB+1SFHKACpn5JrEZdEokU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYPFOkIKKaD1jwGb91P4PPsANKvoHAb6ci6AcYSZR+sl7A3Raxf6oYE1Kt/0e3/BbcRk4NTFJREDDwuznFhfgGSfra5iZPfqFF4LsFA3aQC51EVnyj+OVkYXNR8K0jKjVxJtNAydEEfaGfXamGKvgJl0ihyW5G3Ki/12RqlK9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th/gx5It; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th/gx5It"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so192553f8f.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560018; x=1781164818; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KR2sxU8/RVafv8i+YN/YPRdPY2nC6pIwxn29KCvs/x4=;
        b=Th/gx5ItOow5CXrBEEFTvNBgjZ+ccxIDqYqSBG1KH0P3t9GMHUfPR3kXvZSM5t/G4y
         ixUBT09yL3Hon0NjgfUuxUeQcEdFjwIEVGzTuvXDXA9BMwHd4PjNZAbVxWVsNc19Cwgc
         mw3oCyyq7e9SmW5vUoWKrqJWzolfCMNdF1tFWQxUpcBG7jZyNNfkJJbjUfMcsgO5Ok4m
         6ig+KGI0RtjtqJsEAZNaPhmGnuKrejqdOm6Zd0LoPP2OD0YwqQp8AdFfGSuS7VnDpkIu
         asdfEiL2D761wlKv23Ut0uVgU2MQpYOslNT6MPu8WCC9+bfo1RftRo0e1HBG2fOlqrms
         zqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560018; x=1781164818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KR2sxU8/RVafv8i+YN/YPRdPY2nC6pIwxn29KCvs/x4=;
        b=AC9aa3OIJ0LCRZ5Tmudep/S+liVaEVeL3TimsC9sYxARHkEQHAj+UuoXNDQtfZbnNj
         KE3JdTy2rZBLi4i1bjX7uXbv+z9VY5EfH5KUqBTRobvUneQ1zl3PJIAkYJts7iOOVoW9
         HROfbitG169dBSJSpvnwttGTGyumKSRaMWZVgz3nUvQbbC8jKG/79i7Ejp7dhd75r3P5
         0zakhXnreiCag+i/9Ah1ezlwOrBzstgbEt0Xn5yinbzYBxVvI3euoqd0yQTj/fHaRQXz
         DxiQeQnZz/MSmrUoqnR0yCyYMbdlSzKcdii3x8cW7uWxQu/2pqW9mdHqpUGsHFO12Eg3
         VTTg==
X-Gm-Message-State: AOJu0YxnQ6boag049COnO6vIKmFbc5Ylnmm7AHCdFNY+8Age3gITPeN7
	7MEYfXRZCvhyS/BcDLWW32KoIkHwP29sm2KcmnjcQDYMX9QIbGKA5r8XZe/XtQ==
X-Gm-Gg: Acq92OG8Cr6//YEyn2gTir8UvlSgHw6889C859DxDanlHT1TN6HRJg4CD0SXBIUakZl
	QxL9ni4pqtlFjb8TikiPH6kXSN5cV1iaiGCTFDY6W7zqv30VLvCIfXBiqbWhHXlro5JPoC8tueT
	PrrygQou5bUWK9tsIr5lUVbx6USlzdhGK5TobwOy9GlXrROqCv+a2IyGTjfnmcZ8dyZC/uDIwVW
	ZHTaoPyq22+RI8IMDUMPoEsxDWvWFIWhqlsMODTzsWIXGgXdv7PPUSoB0wP+TVcH1ifZo0Nz0fN
	xtIpit0Lv5YKaz9MiAqfy3rrVvpWTtWNOU68Xk7nXzmijRr5nc2AEI3G32qZWxFMPrM0xXYUsPb
	sxWMOPVIto3R/r2Yr9E+dL+j7YFVCaPtDDJhsKHly2UXeal5cyYwjIwlulDxg2gQ7/mAMI8L2Cc
	1LdQ2Ptg2ixNaIQqcZHNP1Xgamxw==
X-Received: by 2002:adf:f484:0:b0:460:efd:c682 with SMTP id ffacd0b85a97d-460218271b6mr8956673f8f.24.1780560017687;
        Thu, 04 Jun 2026 01:00:17 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm14961528f8f.6.2026.06.04.01.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:00:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jun 2026 10:00:15 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv7 bpf-next 13/29] bpf: Add support for tracing multi link
Message-ID: <aiEwj71lWsgZEbv9@krava>
References: <20260603110554.29590-14-jolsa@kernel.org>
 <20260603114150.AB61C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603114150.AB61C1F00898@smtp.kernel.org>

On Wed, Jun 03, 2026 at 11:41:50AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch references multiple undefined symbols (`struct bpf_tracing_multi_link`, `bpf_trampoline_multi_attach`, `bpf_trampoline_multi_detach`, and `is_tracing_multi`), which results in compilation failures.
> --

this commit compiles fine, specific answers below

jirka

> 
> commit 4e3377b79034e4eafa802e1a2382a4ca893a956f
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Add support for tracing multi link
> 
> This commit adds a new link type to allow attaching a BPF program to
> multiple function BTF IDs. It introduces the tracing_multi configuration
> fields in bpf_attr::link_create and implements the attachment logic.
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 625a4366fe6d7..6f72ede0c8f04 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -5842,6 +5842,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
> >  			ret = bpf_iter_link_attach(attr, uattr, prog);
> >  		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
> >  			ret = cgroup_bpf_link_attach(attr, prog);
> > +		else if (is_tracing_multi(prog->expected_attach_type))
> 
> [Severity: Low]
> Is is_tracing_multi() defined anywhere in this series? It appears this might
> cause an implicit declaration error during the build, as the function or macro
> seems to be missing.

yes, in: bpf: Add multi tracing attach types

> 
> > +			ret = bpf_tracing_multi_attach(prog, attr);
> >  		else
> >  			ret = bpf_tracing_prog_attach(prog,
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index d853f97bd154f..9e3cb547651e5 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3641,3 +3642,132 @@ __bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dynptr *dptr
> >  }
> >  
> >  __bpf_kfunc_end_defs();
> > +
> > +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
> > +    defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)
> > +
> > +static void bpf_tracing_multi_link_release(struct bpf_link *link)
> > +{
> > +	struct bpf_tracing_multi_link *tr_link =
> > +		container_of(link, struct bpf_tracing_multi_link, link);
> > +
> > +	WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
> 
> [Severity: Low]
> Where is bpf_trampoline_multi_detach() declared? It looks like the declaration
> and definition for this function are missing, which will break the build.

yes, in: bpf: Add bpf_trampoline_multi_attach/detach functions

> 
> > +}
> 
> [ ... ]
> 
> > +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> > +{
> > +	struct bpf_tracing_multi_link *link = NULL;
> > +	struct bpf_link_primer link_primer;
> > +	u32 cnt, *ids = NULL;
> 
> [ ... ]
> 
> > +	err = check_dup_ids(ids, cnt);
> > +	if (err)
> > +		goto error;
> > +
> > +	link = kvzalloc_flex(*link, nodes, cnt);
> 
> [Severity: Low]
> Is struct bpf_tracing_multi_link defined anywhere? Evaluating the size of an
> incomplete type in this allocation macro will lead to a compiler error.

yes, in: bpf: Add bpf_trampoline_multi_attach/detach functions

> 
> > +	if (!link) {
> > +		err = -ENOMEM;
> > +		goto error;
> > +	}
> 
> [ ... ]
> 
> > +	link->nodes_cnt = cnt;
> > +
> > +	err = bpf_trampoline_multi_attach(prog, ids, link);
> 
> [Severity: Low]
> Does bpf_trampoline_multi_attach() exist yet? Like the detach function, this
> seems to be undeclared and undefined, leading to a build failure.

yes, in: bpf: Add bpf_trampoline_multi_attach/detach functions

> 
> > +	kvfree(ids);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260603110554.29590-14-jolsa@kernel.org?part=1
