Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCF3C1F3A
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579515; cv=none; b=cgTadvmkmrFDd2QXFbGqycARhiAmwb9MbPfK/GuW3OkMHDvU/cQeVWJI4iM0j1XdUWldKxlUnyOWBBUkUb0nh/6wbu4XhJr1f+0yNkNb9KOmyBrtvXri5KRlZEtuwaEtMpLnHZ+olZXQ6fM7E4xhh4aMXm1Be0/z1P8taxgcHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579515; c=relaxed/simple;
	bh=f4K2JHkH7YesiWyruH0a3wB46th1Cd4Vvj3ogNzw8Xc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZOFgPuCVDPBI3AUr4YxsABukmDe4u3AXHG9uIJl4+CJWhGcEcBQSZnHXGy/ebrVTzx4G384goSRfwf+FH4Ir082b0QinC9i1KbwhJz92CZmOx5oqp1ZfaVE6Oi38MwE6QuMnzLh5U8Cy5JpxNI5VgVfznBTRqF1p98jxQS+Lr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY4rdutU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY4rdutU"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4798bea72f9so5527649f8f.1
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579512; x=1785184312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1hckvG9d2gbl7dZ+d7litWhzw8X9kuM0+KwuQKju8Q=;
        b=LY4rdutUu6e2xGwGNAmhbGFshYVkNcV02f9QiLpY3oUzBvyE/P0fOddJ7y3HO/y4up
         iQRGvTRrGRgJvkE0xZygqwRWelWhm/n7lcwvsoZDmu/Eou+dGNJIy477BetsliQ/YetM
         XVuaA7Tx1X54E+BTxhxka2+UjS7CVGMu3yJU7CJWLS/yQaOJEskYovcSlLNKX8IiB15Y
         ZoZUM4DYAWmVon0t4VvOFKh1RKuu2LvwksQsooLTY9Au0OoR7F8stnM5JTco3LJgYT89
         KxoRu6dJqlsgyy1K2Pc4CaHjkuHWM9wu24BL4xnsKU1AOtvAWgxgpWALHcrqL0q9ar/M
         5xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579512; x=1785184312;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1hckvG9d2gbl7dZ+d7litWhzw8X9kuM0+KwuQKju8Q=;
        b=kWdz7RTo9IjzuQ5kU5qeqa1x3/S36TpqM6PgovplneKzupfBSFhUlDfF/qu3wihQlx
         txJQhZ86u5vpLmPaBNcoINxI5DMnWLvPbPtBCwVbIGx2jXFuR6WU/cId9tTFFwi4Yd93
         o2GoDg2LSUweyo2yk8ZuZ97pZa7v9Hs4BexucLC3xQJBsQejV3wDZFYpZwnYgGMNsbJp
         KOO5roP47+/9/nQOZIrTnwKj2RIF5RrWKAh/ZvH253B99D0SXOvkHOlKs+QwKiNZsay5
         QWkuKLtMZZIdXdFVEAWP8zX2+D+1wHXeqlnmA7HzwhC9gwI2n7Oqs2hokcAlXbdhYV2w
         Ptgg==
X-Gm-Message-State: AOJu0YzyRGQsNrcbPZ+Efr2dsnGB3kUkTbLoeA/7aV9Pc38tk519dGv4
	TyEbbzlNA5MiQC4+ZlgPvAV8d4KmlAXKnL0VwtrXiBaOKjT2/EcvzP/7lfbzUs+D
X-Gm-Gg: AR+sD13ULSKvs51je7is0JcJjdtbPlmhS9M1paIBUNm2MMuTEPE+mPxJzD/3GvZTvG6
	JL3K2+FuCIm5QjzlO2blxjm4eVSxqantKtFGyv/5+t0bvBu0Cf1w+AzNWcd3GlEwFUwZB4AFk00
	FAOaTYCAgvh0ifNRS+hQyLTMSPN7+Q3ieVcLmzwngwCtcFIluwfGShijwHG6C9Vzzx2FuQ+fhsy
	/8aPzbM+yahNgzfdGveYNoVi77+gjvcWO5u/Uh86NX0N4pLFBfWAuOaHaioFj6CgcDNPdmNrnLc
	sqBRAnhipM4q6UmkroOd0H5nZr6DRrpJ31t53lCU2mo/AJ3z9fHga+9ID58/FBpK7pO3/4WLG2i
	rg0k5HwWr1YBjl+y7eKyEojG7GWbouyvoChLe3LI1ZEET0ldCwSix3+1MyU/v554E1g==
X-Received: by 2002:a5d:5d03:0:b0:47f:72b9:77fa with SMTP id ffacd0b85a97d-47f72b97ae4mr9747923f8f.7.1784579511907;
        Mon, 20 Jul 2026 13:31:51 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ec7f55sm29329407f8f.18.2026.07.20.13.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:31:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Jul 2026 22:31:49 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 7/9] bpf: Factor callchain_finalize function
 from __bpf_get_stack
Message-ID: <al6FtZ69J-129Ytz@krava>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-8-jolsa@kernel.org>
 <20260720090811.1651B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720090811.1651B1F000E9@smtp.kernel.org>

On Mon, Jul 20, 2026 at 09:08:10AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Sleepable BPF programs calling bpf_get_stack() or bpf_get_task_stack() can corrupt per-CPU perf callchain buffers and trigger preemption warnings.
> --
> 
> --- Patch [7]: [PATCH bpf-next 7/9] bpf: Factor callchain_finalize function from __bpf_get_stack ---
> commit a181c39a42a0e8c840b9a2a09b02e1efa512170b
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Factor callchain_finalize function from __bpf_get_stack
>     
> The new callchain_finalize function calls the build-id retrieval
> (if needed) and zeroes the buffer.
> 
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index b990643f25cd8..eea7b781300ca 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> [ ... ]
> > @@ -827,18 +840,12 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
> >  	}
> >  
> >  	trace_nr = callchain_store(trace, buf, size, elem_size, flags);
> > -	copy_len = trace_nr * elem_size;
> >  
> >  	/* trace should not be dereferenced after this point */
> >  	if (may_fault)
> >  		rcu_read_unlock();
> 
> [Severity: High]
> This is a pre-existing issue, but can sleepable BPF programs calling this
> function corrupt per-CPU perf callchain buffers and trigger preemption
> warnings?
> 
> When may_fault is true (such as from bpf_get_stack_sleepable or
> bpf_get_task_stack_sleepable), this code relies on rcu_read_lock() earlier
> in the function. However, on PREEMPT_RCU kernels, rcu_read_lock() does not
> disable preemption.
> 
> The earlier call to get_perf_callchain() eventually reaches
> get_callchain_entry(), which relies on smp_processor_id() and requires
> preemption to be explicitly disabled:
> 
> kernel/events/callchain.c:get_callchain_entry() {
>     ...
>     cpu = smp_processor_id();
>     return (((void *)entries->cpu_entries[cpu]) +
>             (*rctx * perf_callchain_entry__sizeof()));
> }
> 
> Since preemption is not disabled during this sequence, can the task be
> preempted during or after fetching the per-CPU buffer, allowing another BPF
> program on the same CPU to overwrite the buffer before it is copied by
> callchain_store()?

we disable the preemption in patxh # 9

jirka
