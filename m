Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345B42048D
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413074; cv=none; b=bYx/NrYwS1ehrrXgR4OReHEyfHJLkkcrenHB6R7Qt55eZTNoWXgjQ9BlLY04zXoTXRdVmtO13Y60EEUZcsBK4weyeimGQHqxOl7UHvuGztuS+cJPEBvMGBv/KjXhghLnV27i8y0/OVXtl0Xp4vFr8AMYp12WRzBzMcdSaiI7iaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413074; c=relaxed/simple;
	bh=cKmqzTqs0Jyzrl34OxYOUJ90MaOo1NVFVkpakKU9u1M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzEtSLwWbQEA9gbxLXtHdMJb5Bw8PA/ltX7zajd0wNKryVfs8Lklr3MauhjRUUafdCwiVcv2rkGuN+zjjXJVtgYCHjTkJJReVLydFRWg2hDyW2uqoWGQ3BBJqPPYdxyaGPC8haCLCpSMxofZQtG5O6m5K4gxa0PMobp19l7+0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7NYAIJw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7NYAIJw"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c12614b81c9so364610166b.3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785413071; x=1786017871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gWFPRxQmEK90wNUczUJI1RL1AES35AvdzEJnsivbX3M=;
        b=Z7NYAIJwrVWHFoRXzNasBed7xpdb0288RHxUNpM+JYS88ffQhsKCJ6x5raPAoYCMpG
         MYZA2e5yN2DXF9IThgB3bOurzeBMK+7jc2x+J7bAi42ppttuiSeuMEG4TKApTQRy84DL
         CrNrJqZXPqlq2T6jj9qBrUTG70RcCcg7af01Xn0JeYkrwc9la5P+aCzibBN2NYiWJ+IQ
         BCbDksJrahINNvxxyQf6NIS0VkQyMkcjjy1gk6dVsWEHqa4jD1r7N5fblFGtG8EIR9aR
         95FYlqCcgyjeufLgfO05HRh0ehNE4wFQofOPmud7hka0Mxzi/8QqGURWIzEoTebVxPtZ
         3xEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785413071; x=1786017871;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gWFPRxQmEK90wNUczUJI1RL1AES35AvdzEJnsivbX3M=;
        b=rzVuWlMaLsVn5kDYe1Vhzyyy7DIKCiyp97CeYHES3AqjF5zc2BqTI38R08lRplr17u
         Z1tjohorAiMRTuWHXQviLNl0wEovgP2QlVB+RCxol787PfhZ9CMBYwZL2x+4ZKZz1olV
         XOal0KgitW1zlb9HCx2LEJKaAaWrMPRUJLx5TRMO9+hFZBnfzkvHsF+ybGBxFzYVSy1M
         /9MZgHzEtsgAj0SyxdJiItGlAbnDCCg5kwGrT9sfPDoxG5pnpEdNHwPxyMDq5Wf8kxk4
         XxpDktZpkBaVlXKmkT1NtTlQk13nydaeBctEtWHIWdWWnvikohNv/NZL9saxQg2Kj5Bs
         NUMQ==
X-Gm-Message-State: AOJu0YzLupCfS7c2EEZWMupJeNBCy/cV0IM0Dae6wmyFUlxCjEtDW2Xx
	3n9ndU6aBBGExydikVNd+hYdO9b2+iebPVI6xD1EiVVuMWNsF6TvTSTDYHPoN7ux
X-Gm-Gg: AR+sD12Ia6sXnLYWphGbGh9iMwmp1o0w5MlVmrEv9O6hcEA3Mf2WeT+XKCOiSie66eb
	qdC3fOK25pdy2i8Y5FpScq1sEoIdfOk5dTCQEwEI1Lsa6CXd5ec9SBJBO/napb/+o5RR33Zic2F
	naAQB30qBBwD0/oC66ayTXk0HrbiHS8WMW+Uu7QhSBtFGJfsLnCV5+pJQfCoNGZVszAWzWEY4n4
	opj1KqpMPejFr6J9PkDvZDGSsErSNzyFO53DYcHaEd4vpcxM6dip4ll7TSHR1y5uhLdH3i660ah
	htPutojbyq7Sxe6YpFNopgp3BPDqdMGqYK/KfI/602k2jS49O8Il2xwefu7f5OG6oY6O3L4jIqf
	lmQBpK1JGJqwcAqnO943WN2vMPaOhay2te7huV2MYjyvA0QQOloUJRaZz86Z3Kxd9RVVv7NVAxX
	+6mdNugl1wswN3kII5jhvkq2dMUZptk8/spoxaGcpoSVc73ZQ=
X-Received: by 2002:a17:906:7955:b0:c1c:6e35:aca6 with SMTP id a640c23a62f3a-c1fa5789eabmr130923566b.51.1785413070647;
        Thu, 30 Jul 2026 05:04:30 -0700 (PDT)
Received: from krava ([173.38.220.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bf211fsm60035866b.57.2026.07.30.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:04:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Jul 2026 14:04:28 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 01/11] bpf: Factor stackid_init function from
 __bpf_get_stackid
Message-ID: <ams9zOlhHI72-Kfs@krava>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-2-jolsa@kernel.org>
 <20260729085136.9E9B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729085136.9E9B71F000E9@smtp.kernel.org>

On Wed, Jul 29, 2026 at 08:51:36AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] A TOCTOU race with `sysctl_perf_event_max_stack` causes an integer underflow in the `max_depth - skip` calculation, leading to a massive heap buffer overflow when copying stack traces.
> --
> 
> --- Patch [1]: [PATCHv2 bpf-next 01/11] bpf: Factor stackid_init function from __bpf_get_stackid ---
> commit 94626e7c900d701c2d2326e06f48ebc28e1f6e93
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Factor stackid_init function from __bpf_get_stackid
> 
> The new stackid_init function stores all the necessary bits for stackid
> trace and it will be used by other functions in following changes.
> 
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 41fe87d7302f2..0eafe55b18289 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -504,33 +504,54 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
> [ ... ]
> > +static int stackid_init(struct stackid *stackid, struct bpf_map *map,
> > +			struct perf_callchain_entry *trace, u64 flags)
> >  {
> >  	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
> > -	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> > -	u32 hash, id, trace_nr, trace_len, i, max_depth;
> >  	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> > -	bool user = flags & BPF_F_USER_STACK;
> > -	u64 *ips;
> > -	bool hash_matches;
> > +	u32 max_depth;
> >  
> >  	if (trace->nr <= skip)
> >  		/* skipping more than usable stack trace */
> >  		return -EFAULT;
> >  
> >  	max_depth = stack_map_calculate_max_depth(map->value_size, stack_map_data_size(map), flags);
> > -	trace_nr = min_t(u32, trace->nr - skip, max_depth - skip);
> > -	trace_len = trace_nr * sizeof(u64);
> > -	ips = trace->ip + skip;
> > -	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
> > -	id = hash & (smap->n_buckets - 1);
> > -	bucket = READ_ONCE(smap->buckets[id]);
> > +	stackid->nr = min_t(u32, trace->nr - skip, max_depth - skip);
> 
> [Severity: High]
> This is a pre-existing issue, but can this max_depth - skip calculation
> underflow?
> 
> If a BPF program is attached to a perf event using bpf_get_stackid_pe(),
> the callchain is generated using the current sysctl_perf_event_max_stack
> limit. If an administrator concurrently reduces sysctl_perf_event_max_stack to
> a value smaller than the skip parameter, stack_map_calculate_max_depth()
> clamps max_depth to this new smaller sysctl value:
> 
> kernel/bpf/stackmap.c:stack_map_calculate_max_depth() {
>     ...
>     u32 curr_sysctl_max_stack = READ_ONCE(sysctl_perf_event_max_stack);
>     ...
>     if (max_depth > curr_sysctl_max_stack)
>         return curr_sysctl_max_stack;
>     return max_depth;
> }
> 
> This would cause max_depth - skip to underflow into a huge u32 value. Since
> min_t() is used with u32, a large trace->nr - skip could be selected, which
> might exceed the stackmap bucket capacity and lead to a heap buffer overflow
> when copying the stack trace later in __bpf_get_stackid():
> 
>     memcpy(new_bucket->data, stackid->ips, stackid->len);
> 
> Does this sequence need to be protected against sysctl changes between trace
> gathering and max_depth calculation?

not possible, replied in previous version

jirka
