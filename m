Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163242048D
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413083; cv=none; b=Ne0wQgEH87QeXYj92DdFK+6FxEdh6qiS+wO0yim0LeVX3ZQL7Sy0zno3RzIX1Yo+vJSEGqHFf4yFEr/V5UOdDQPiHkLNF0ysw1cqpgT6e+0u7zGoOkWDVlBuDGJ53rRmG9X0qtdbQWeumUuucprEbw07jaseNT6DgGcyX3msZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413083; c=relaxed/simple;
	bh=swNwDuiSlUIFh0rZIuggEAW2FHZ3l+1i3bs6O3kepFc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TITGdVTyOFaQJ7Mh9PlHM56fTwYPSLcPap745A880QUz4/hxkoQOt/YrxfTOr8/oiowta2MZe46vItLFlW7bydRkVkiwoE562e7mAOT+zaUR5auNbw609j/5plYxKIWMYm1Dm8WxsxoZfmdhFsIkbGJLlyyXZlMrSzWfDCT7zWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W12xfxJe; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W12xfxJe"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1600d040e4so99305866b.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 05:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785413079; x=1786017879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CNZCm+GVCrWjZ/ClkG+Tb1xe1AofW8D8PhoCoqHKjH8=;
        b=W12xfxJejuF7ysi740JJuFLrNu17H5e+OAKLbcTVuOvgzmd7LRxtYTcSHHXBQAEzzr
         UYGsNi5Ws7s17vwFPPhSvJNi7vpqpjlj3cTzqweT9KBMFnd43c3EoRbww24hE7rhoJNe
         OH1sn9BSBq1amVJTnG6D1XJwIH+lE2lTz/aTIV/LxxaL4YlOPgIxOwUFSPmvnY8Tu2T6
         0Dz+XYa0BGzPb+GiqQOdCvQ9bvhNyJXOhEfbuqhpxHSla7fA87P2QEWboINL7F0a64AB
         3JTp+R246NluJt1USotvHvvIGQXesNNNWcLEEtmL/OzbWCGFxzE7fjdo6esWGEArgVWi
         7+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785413079; x=1786017879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNZCm+GVCrWjZ/ClkG+Tb1xe1AofW8D8PhoCoqHKjH8=;
        b=YVyqGK4d5xMtBVhxaylByapIvCTo3MFfQc1Z3P/slvvkDkHVz1BAnQSMzfwHBTGks3
         GrbewJnbnTav/z3X6uwNL5TW1J21ntYWEmMIyQ2qI7by4/1AChcGE5UkNVC2/8wv9/L3
         RlB0J+9Ynh8lst079rT3HK76J2w3JrGuCldJG4mNsaiEVnxJukiRLe4fsluBlXNq2EkS
         2XuuwHGQu6B70dV3JX9hQ2r07u9p/m5gDKdDDAyS5ByIrCElI+qRsq20lVQxYMpOq69s
         G3eKqenLyUZBVb7ccJ3dXeiTJYt/YotgirkD+95qT7WnkTw3GCe9DBUZ1kdzzmzmbeY0
         r0wQ==
X-Gm-Message-State: AOJu0YwhHjeUpBHkpMr2sInUjP1VgoDASaVyceu/SM9I3FTciUdHGnxc
	LWkgkaOoDuDfmm7VDG5fZnlmS8S4Lypnj7PlnqBj+/wKQtqaAEZuhCqt
X-Gm-Gg: AR+sD13sv6JfQSj44M6KFgTGXTTLMQC0I9sKelgLf96wZxvNn0msL9pQRlQCW7MLLPx
	yKr8dSERblvCvBz2O4em/ffS0f4pWT1fcDNcwJZE2TYPVqO+LqFeSwa38toBV7prnCih9pP/AAl
	4GDQd8y6CApyoN+2W2wtpPnftNqfmwvyEEL8YkOaMVJZnsh3nWcF3x8DXu6R2fT25vlrh5sWRu/
	g1edQJo2ibkjtNluYvkrJzm1x2zrxEaujnSLEuPYpFZdDKLHR6NV5hVl/1pxAUUqBIwL/iJ1G/T
	iUpabHd96qw+ZYv5bcGhsKJk3GEtGqtv5YchyzmEgkB7duW1iuWKCBuahFNa0WUUvu/SmEB8F6d
	EYy5AT2OTtvAwzQbvCD35Z+X3Mqklo5GbtUpfl7zj+QnZxZEP4xtvfYhpUvmCwLwM0vVMKAr9g9
	K6EKnOl1S77fGV2aeATM8qcOUrplKEH8QEhiXMLfWaTwT63GM=
X-Received: by 2002:a17:906:478c:b0:c1f:ba1d:805c with SMTP id a640c23a62f3a-c1fbd30ae5fmr5937666b.19.1785413079317;
        Thu, 30 Jul 2026 05:04:39 -0700 (PDT)
Received: from krava ([173.38.220.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa857800asm61245466b.16.2026.07.30.05.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:04:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Jul 2026 14:04:37 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 06/11] bpf: Factor callchain_store function
 from __bpf_get_stack
Message-ID: <ams91eMxUuXsJd7P@krava>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-7-jolsa@kernel.org>
 <20260729085751.96C341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729085751.96C341F000E9@smtp.kernel.org>

On Wed, Jul 29, 2026 at 08:57:51AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Preemption can cause `trace->nr` to be modified concurrently, leading to an integer underflow in `trace_nr = trace->nr - skip` and a massive out-of-bounds `memcpy`.
> --
> 
> --- Patch [1]: [PATCHv2 bpf-next 06/11] bpf: Factor callchain_store function from __bpf_get_stack ---
> commit 41f5133836d848295ac407c006940d4f0641b50f
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Factor callchain_store function from __bpf_get_stack
> 
> This commit factors out the callchain storage logic from __bpf_get_stack
> into a new callchain_store function. The new function handles both IP and
> build ID data copying.
> 
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 41fe87d7302f2..18d1a10bf76e5 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -680,6 +680,29 @@ const struct bpf_func_proto bpf_get_stackid_proto_pe = {
> >  	.arg3_type	= ARG_ANYTHING,
> >  };
> >  
> > +static u32 callchain_store(struct perf_callchain_entry *trace, void *buf,
> > +			   u32 elem_size, u64 flags)
> > +{
> > +	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
> > +	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> > +	u32 trace_nr, copy_len;
> > +	u64 *ips;
> > +
> > +	trace_nr = trace->nr - skip;
> 
> [Severity: Critical]
> This is a pre-existing issue, but could this calculation underflow if
> trace->nr is modified concurrently?
> 
> Looking at __bpf_get_stack(), when called from a sleepable BPF program via
> bpf_get_stack_sleepable(), it calls get_perf_callchain(). This allocates
> a per-CPU recursion buffer but unpins it by calling put_callchain_entry()
> before returning.
> 
> __bpf_get_stack() then checks if trace->nr is less than skip:
> 
> 	if (unlikely(!trace) || trace->nr < skip) {
> 		if (may_fault)
> 			rcu_read_unlock();
> 		goto err_fault;
> 	}
> 
> If the task is preempted immediately after this check (which is possible for
> sleepable BPF programs under CONFIG_PREEMPT_RCU, as rcu_read_lock() does not
> prevent preemption), could a new task on the same CPU trigger a BPF program
> that reacquires the same level-0 recursion buffer and overwrites trace->nr
> to 0?
> 
> When the original task resumes and calls callchain_store(), it re-reads
> trace->nr. If it is now 0, wouldn't 0 - skip underflow to a massive unsigned
> value?
> 
> > +	copy_len = trace_nr * elem_size;
> > +
> > +	ips = trace->ip + skip;
> > +	if (user_build_id) {
> > +		struct bpf_stack_build_id *id_offs = buf;
> > +
> > +		for (u32 i = 0; i < trace_nr; i++)
> > +			id_offs[i].ip = ips[i];
> > +	} else {
> > +		memcpy(buf, ips, copy_len);
> 
> If the underflow occurs, would this result in a massive out-of-bounds memcpy
> that could overwrite the BPF stack buffer or map value and cause memory
> corruption?

the preemption fix comes later in the patchset

jirka
