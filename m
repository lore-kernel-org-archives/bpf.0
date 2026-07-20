Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EAC3C98AF
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579490; cv=none; b=gcYU4kiFQqOvEO+WD2C44bHcbcDVJeTRjkF/ASrnE4meljqpGT1U/rSFBx5ySQC3v2FBYoaKuq3aN9vCY0l7nlWHontJz9QT2pJXaILcYV8lrPviShJVMm+54flzFuevcOt2C/h1G6vW4tqw3GyrrAVeLEczEJW7jLNfeMJHAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579490; c=relaxed/simple;
	bh=8ZDYtOOnFAoks1SVZmejw4+GbzWSa3AmCGcAL07HanU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvnrZnr9SoF3SWtfLF9q1+5X6daA537XL3g3MosuMwcqGyQPvISIE28W5NIQurbNf7bYNaGiiGNQlirbBa9NRib4wjXzXyfZPZHOC8TG1zxVuC0As+/CcnvVE9/7XSRk8ELS+Ul507nZQclwkJqcTY3kwmaXUhN+Ru71wAaKUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXRtuXxg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXRtuXxg"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f7027ca11so1311458f8f.3
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579487; x=1785184287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KytO/biTOA9DN06qfkfVxIIcWXZQZ9HNmS50EkPoKB8=;
        b=fXRtuXxgLfcsoivscYdIp7Rv0COmQeav3SiHpkCcoIpWd3UUhou1XyQwjBkvaukEDV
         yicKRZgLxoA/BKKqRRUOLwte3kMQGzsTCgE1nvgCS83YPqoY5rspJeengT6AsFTIzFHZ
         2I4ScZttAqPPRDay+cCd/v4Knhf3kP7H/Md/JaYMOIiQtT0pEjV7eN7+ToBcCP282D5r
         dHoguQ9j5J3a+TKMEMGLFY9b+P3Rtbmbz8OkDZkdcV8ds6SrRrZE0Ai3EQptKfEafPeA
         xRZQoQ5AbYCMfjpF2fTh2r7PpkttZ0FheWRYXix5xipaWbABwFZ2ERUTRQghXJvoDI5+
         d1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579487; x=1785184287;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KytO/biTOA9DN06qfkfVxIIcWXZQZ9HNmS50EkPoKB8=;
        b=l6aavu5OdCP3AeKYrDXfQOcy8CS/suSceCtGQnOeHknJHAZfKIj77cqcbcLKo0mSqs
         ZQdmBsxdn4edhz6Um8J+5joXkd8YVgHY5LvOoXbFI5Kes39+AcIPv2IORdajen8hVb/V
         bHKARf1iqYx/eBN1y7YMf9AdES3MCVDb7HvZ0fNqgc6ihSVcMGEnld3OoX5d1oHzJRVC
         O3H1PL13I8gYFP38iZb4ymgPGiUGkyLGHccOszAIFI0Ikq1kKAhyfTNczYzfhUiSlyGO
         pL1DUmgRLLIYqOuUCAsJCZfS8mWgP725WR4dM/0CC+eJfggbUOSc3a9DHp7obj8C4z6E
         gNLA==
X-Gm-Message-State: AOJu0YxKvvXjvLwxKa2hhk9aRq70lctk+ZeiJw3FgoFJ5Ngoi7uXLDg8
	aGvEhisi0GO0E+79ZMhnISP5y/IaMYWEvdOsBDw5nM6zBp3Ooz3TKV5G
X-Gm-Gg: AR+sD13mmRCFuF+C7SeQC0dWtG3o5TUBIyV5wcOi5b/kjj0bdqUH5p1/859AplYGf/p
	H9RNLjQvKTS1tuFulEzLZo1MlW1UkwsjCL3Tv3P4AWAzkDf/BSlpGQIBbXpj9VhwkN0JooOntxM
	OsNRrRXDFo9lCaUPsvq8pn0NtqtNwFchre9oHaQ4BW0ovRVMLZoojCCZU1nwemDho9vwZFQ7LoU
	kyWtUDooC1Q7dWN4i3cnskf0CSxGirpnK+rqQbLET70Vg40DSzxD9dV9zSXtXrjs+hP2GeKpejD
	SNOiuS+aQu79L5DQfgwOLoLW4xUQTfDf6Y4tpsK2jUpdXwSotSntsSE26i5hrvyz5XhCopL6F9Y
	mNJ3TZ4iz6b3+1mx3IKY+Id6+BvZMnqDIIAzBOBeCJAkc5urlnO+RLE1Lm+p1NRVTCw==
X-Received: by 2002:a05:6000:26d0:b0:47f:77a3:346 with SMTP id ffacd0b85a97d-47f77a30387mr6749454f8f.23.1784579487273;
        Mon, 20 Jul 2026 13:31:27 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd1csm32658329f8f.29.2026.07.20.13.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:31:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Jul 2026 22:31:25 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 5/9] bpf: Disable preemption in bpf_get_stackid
Message-ID: <al6FnX19vBr0Bpyt@krava>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-6-jolsa@kernel.org>
 <20260720090411.61E931F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720090411.61E931F00A3A@smtp.kernel.org>

On Mon, Jul 20, 2026 at 09:04:10AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incomplete fix for preemption vulnerability in stack helpers (__bpf_get_stack)
> --
> 
> --- Patch [5]: [PATCH bpf-next 5/9] bpf: Disable preemption in bpf_get_stackid ---
> commit eb097d7647defa7379264dcdf95711bc573a419a
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Disable preemption in bpf_get_stackid
> 
> This commit adds preempt_disable() and preempt_enable() around the
> get_perf_callchain() call and trace buffer usage in bpf_get_stackid()
> to prevent the per-CPU trace entries buffer from being corrupted if the
> task is preempted.
> 
> Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dylane@linux.dev/
> 
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 83efd5892d907..a64b14ffd1e8e 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -625,30 +625,37 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
> >  	struct perf_callchain_entry *trace;
> >  	struct stackid stackid;
> >  	bool kernel = !user;
> > +	int err = -EFAULT;
> >  	u32 max_depth;
> > -	int err;
> >  
> >  	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
> >  			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
> >  		return -EINVAL;
> >  
> >  	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
> > +
> > +	preempt_disable();
> >  	trace = get_perf_callchain(regs, kernel, user, max_depth,
> >  				   false, false, 0);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does __bpf_get_stack() also
> need this preempt_disable() protection?
> 
> __bpf_get_stack() has a similar pattern where it calls get_perf_callchain()
> or get_callchain_entry_for_task() and dereferences trace->ip via memcpy().
> 
> While it uses rcu_read_lock() when may_fault is true, on CONFIG_PREEMPT_RCU
> kernels this does not prevent preemption.
> 
> Could a preempting task trigger another stack trace on the same CPU before
> the memcpy() finishes, overwriting the per-CPU buffer in __bpf_get_stack()?

__bpf_get_stack is taken care of in the following patches

jirka
