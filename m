Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9B78C9C
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844940; cv=none; b=ILGCtoeLP5HMrmSA0ke+Qh/IsW4bWa8udoLEez77JSgKPe/wKg9dkgNO4OsPH2xhJ1jH8wwLV0aPSmmK+AuvyZ3bGt1XA3s96cNZYiDjQG0Pk/6DSbfne8idu6FGVNaD+x1J9b1foCgZRPXM4JysC/5kIm5v7Y3cNJFrtvdzDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844940; c=relaxed/simple;
	bh=lSLc/k70UPCCdOzCh8NUIoUpWf75XpOu624nl05a5Wc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBVAdpH/RRgQ4uqj0y3r7TkaVo0rfX4BvWOdrqrthejeVpj7nxv2KfyQTL/txCSnKGKBnNwfeH1gQMtRPAqxvSmUt6hDkQUIyg8t7J+zxRwoBUeVLk57lbgBrHuD7hUH+CEdGA054r8/PsmL0NvsfAVJiCkgR91/z/KbQqWxwZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TW1mOtPu; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW1mOtPu"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c160420289bso665429166b.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 05:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785844938; x=1786449738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SR8sWBi7icKINEBquF/kdhx+8pyyU169Pg6sxLELmQs=;
        b=TW1mOtPumtFZDdJ9XvB2oQF9hunzQ0s1kjWjqlRJuuTGXDOAcUA1ipP+gOY/oTAn0C
         oRQzgMNH9qEn8BjzE9CpcOxljx9ij5g3yXpAOV2+0GIVat4iUs5pno3lAGEIUuWVsv8X
         umqcp0t3iN3EU2K1DmBH2bqMPvYUFmdP4fi4F9legKwY3ziIolHBFytCxgJFQiZrZSX8
         k93ppRpYS/WgZs5qxYTxdj/9I1ViXiOGvIvnn56TYt1zIEbJ21TEVjr1xTx8n99pNyZG
         wc0AFisgtQHo10FKELLTcdT8QUeVtzzngw51YPJSW9JwvreysfAa3QAwQT/QCY/t7NT3
         2Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785844938; x=1786449738;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SR8sWBi7icKINEBquF/kdhx+8pyyU169Pg6sxLELmQs=;
        b=Br/dilK/xxoTscl03BqZOKKs7pmedIOoP+SIKsYKl9HlGZP+jEiDq/wDrItfZOZcAn
         b/Vsmb3hrd6aiFKaSC/sCStMwe9L77UE3n8XY8NN9umB3/GMmeTOa009LEmoyxBYySJE
         qyetjZFWPeBbz/awGGtKnaxkyEYEVNhPc6A9U5CTkWm7YZUn81r6C0N575gvdnuPoHuA
         je7irnIA0Vxc5HBUWvSsKghOLjCRXjTt7yfhHvSIcPtQ+Pv7nnTbxgRt8L1QPpAK4JyR
         XOTvhBgvRs6PMp3kgc+wChY3sjp28tufO8gxI2v0eOWZFqoNEOq3ey9VMLORfCqtORLS
         /02Q==
X-Gm-Message-State: AOJu0YwLFjcyuyLNY3l68qxuYG5QY5a1nAiClfdI4MHmYzgwmukPwj3N
	LVdbnI7L1Lz7eOBxYgd0MEfkROdP2z6a8ARKSfQtd3kJltpkhV4OoTTa
X-Gm-Gg: AR+sD13CAdUrqT7lodMfpqZ1+0ofdfHBD5rv85AAw0HxaLb4kRNk88w+CqGkLWntBhZ
	r0QsHFyPQVxUNiaHScy2SJjq2Q3+yqVYmJ9qU2IRwQNc7KosRoDp649KnP+ADyQTld8X4R92UbC
	iIK9WmWm+RRTEFskMx7D8bxViM9hqvTY8VHOrdBffdeIV9xbL9yU070OAUubu5h78kaWme58hd4
	x0je/BlGCdQp8ho6d1oqW/u56wsI7NWBgj3Uu4l7KIILuNVRfKzze/ja2EO4kHkpmDEXdSX0Ohy
	GisXKSySY4+mkOaDAXZURmYHsURdMRxq29+CXwMXBzd5LgOoUBoTxv5I+fg0AZQKwrhVPYCiBkT
	E62zd+sXafwUJ+UWR1ZzR5dRnxPHq4KeySwTxx6fmpQot9ceVk7BuFU8maGH4tHp8C4nRfeHTlm
	+yu6sXmc6ZnYpiFtwxCZuqFtbayFgnLU7BwORWU7c2FLNYauk=
X-Received: by 2002:a17:907:9615:b0:c12:b225:bd0e with SMTP id a640c23a62f3a-c202d90adbamr165621966b.9.1785844936918;
        Tue, 04 Aug 2026 05:02:16 -0700 (PDT)
Received: from krava ([173.38.220.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd450d71bsm639710966b.46.2026.08.04.05.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:02:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Aug 2026 14:02:14 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv3 bpf-next 06/12] bpf: Factor callchain_store function
 from __bpf_get_stack
Message-ID: <anHUxiuMInjr6Zuj@krava>
References: <20260803210149.296496-1-jolsa@kernel.org>
 <20260803210149.296496-7-jolsa@kernel.org>
 <20260803213050.8EF301F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803213050.8EF301F00A3A@smtp.kernel.org>

On Mon, Aug 03, 2026 at 09:30:50PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] A Time-of-Check to Time-of-Use (TOCTOU) data race exists in `__bpf_get_stack` when used from a sleepable BPF program, allowing concurrent modification of `trace->nr` that leads to a massive Out-of-Bounds (OOB) memory read and write.
> --
> 
> --- Patch [1]: [PATCHv3 bpf-next 06/12] bpf: Factor callchain_store function from __bpf_get_stack ---
> commit 1569be7d337e247b4d7eb8620dff965cc57a3fc6
> Author: Jiri Olsa <jolsa@kernel.org>
> bpf: Factor callchain_store function from __bpf_get_stack
> 
> This commit factors out the callchain storage logic into a new
> callchain_store() function. It handles extracting both just-ip and buildid
> data into a user-supplied buffer.
> 
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 463f94ba1cc47..e51e03c4b60ed 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> [ ... ]
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
> This is a pre-existing issue, but could this unprotected re-read of
> trace->nr lead to an integer underflow and out-of-bounds memory access?
> 
> If __bpf_get_stack() is called from a sleepable BPF program, preemption
> is enabled. Between the bounds check in __bpf_get_stack() and this read,
> the task could be preempted. If a preempting task running on the same CPU
> executes a BPF program and reallocates the identical per-CPU buffer, it
> might overwrite trace->nr with a smaller value.
> 
> When the sleepable task resumes, this re-read of trace->nr could result in
> a value smaller than skip, causing trace_nr to underflow and resulting in
> a massive copy_len during the memcpy() below.
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
> > +	}
> > +	return trace_nr;
> > +}
> > +
> >  static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
> [ ... ]
> > @@ -737,21 +759,10 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
> >  		goto err_fault;
> >  	}
> >  
> > -	trace_nr = trace->nr - skip;
> > +	trace_nr = callchain_store(trace, buf, elem_size, flags);
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but this is the preemption
> window mentioned above.
> 
> The check if (unlikely(!trace) || trace->nr < skip) happens right before
> this call. For sleepable BPF programs, preemption can occur between the
> bounds check and the re-reading of trace->nr inside callchain_store().
> 
> Could we cache the validated trace->nr value (e.g., using READ_ONCE())
> and pass it to callchain_store() to avoid this Time-of-Check to
> Time-of-Use race?

there's preemption fix for this later in the patchset

jirka
