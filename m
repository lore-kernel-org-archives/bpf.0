Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC13C9ED0
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579524; cv=none; b=qlMEj6UdNgXwfITM7OoaAhXHcjQi6Wp5CMQOfdnlzdLfKd2iJfeXAtoep2W+A4buHR+nnmEGTMGTa1QKtTbIIGAFXLRRQg9oB5gfE9Vc/NjSet9T96aA7GEeo5zAO0zUEhMbUMk6duIOSZyUg0LTmeHCGjVQC4P7LWwBKBbHe70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579524; c=relaxed/simple;
	bh=+K99nVC+DTtOEY18kwlCzZK2l1ko95eezwSaGr6g4YM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be44zXW0/smxqLrBKUa9wkSCsbRhCMQMATC3U6On/GMmp7qxzher+8oBV2Uta9oSDANjdrHUMQevir2E3WXYDltbNYEW89RIxyp/D565NsQoZVOqTXiskQkmo/6OiKu/pxQ7uhNNOWn6sbf7EdEt3dHiXkwPyyrdeWk4DZgFEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBAje2pJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBAje2pJ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f633e6058so3141155f8f.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579521; x=1785184321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XsZYL70lc2QNJ9h65aBXRYUJv3y6rfN3clJ0NI3vBeY=;
        b=NBAje2pJ0lUCLC18eJ9mAvxb59nijCftdqMnkShoolpFG2LIwfq9jGGp5eD4UirARY
         Gbgy5RMEZI/HJUjIkf8QeQ9yIR47c88Tl8zuZYYOmsN/kqNLXcxbHon/vSeJHaS/snjA
         yC5IGhRz4NE+i5/18vcydL9QJ3POyGObrPskMlGIdkhyL7mwz9/al5HHw0JGPijHBXzT
         EbHtlLZWCbC/pdkKnaW1oW4wf2gmuqJngRd2powS+/QEBN6IDbIJ8/S2tp2Hx1niwNWI
         NOeHKXURFb3vU+442OpUQorNKG+H0s+oV+lAD699t5ruzNkm61+6zGozgvYNuW25BCI8
         T/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579521; x=1785184321;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XsZYL70lc2QNJ9h65aBXRYUJv3y6rfN3clJ0NI3vBeY=;
        b=gu0FlXDkLnRzzf72HnIC/dKzOGNPjwhhDDRM6RmRdcv9XsG8Hcb/ugmvdsCdhcvD5F
         xh3GfjGOf4BfvJggefJQL7x+9/a3CMgfaFKPaMYDCvfG+Er7tWXKP+ZceHfwoJJOq78d
         OWEryINktf7XkRJrDl9uqkGuY0UgKBKGvTxVk6zYFUnV6x2BQ/OFvJspgE4uLJpAaeoU
         d68y8H+XqmhlXmIftTKinVsg1qcCIJm1BMkRc2Es6h20TGR39go4oGJPxePk6yeP7CP9
         RsRZJG0+Ml5a7hBKEU5A1f/Nvry+KiOr4zHzqbuqdmcITitQ/LLejb1Piv5bem8loF4z
         7ugw==
X-Gm-Message-State: AOJu0YyxhIgIPn2+/CBrNtFjGKrEiJbUztrUuFc5pvsARpDpqDdGyVkH
	pooClxYYf2vFPeDSgiMHHozePsBb0+vPLS1d6mD73K5HMT+Sv53GPtox
X-Gm-Gg: AR+sD12EdJLv4iA1ES5bTKGGkglk3pyJhx5coTitxTJoZJZwuoJhOKvZe8BK4uaHGI3
	DDowQZy2XOfaLMyhF0+oK3jKerMQ6m54Wdg3ADS1iHWdBVq2PoAnRZI6wvwYAEYqkXyINRtDSil
	0klxreRzpuo4nvlt/W4jNNFYADUN5tzUjoAMeugAaGoEYSFYRzU8zpL4mZPSYJjtSzTW5RnrztW
	xJAj9fLwj5ljQU+5t4nZOzcPH0fH0HAXPqJJJkPI5/wZnawDKTJVrzw8T62YefjUFcuOq2n5o6l
	r/cGPvypULXrn2PPhdMjewMr4t2mZIH8MMhRBCn6J1nirSQSjowsBFYXdmLk8lIy/sI9+MUz8FM
	+BPnOEg9jZaIr8BtXdUyvc2xdWuDz2Yw5d3gX/T0guv+tmoSkDXdHfnBWxzSMuGVVZg==
X-Received: by 2002:a05:6000:26cd:b0:47f:5d51:6201 with SMTP id ffacd0b85a97d-47f62325709mr18360133f8f.33.1784579520939;
        Mon, 20 Jul 2026 13:32:00 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm32802701f8f.28.2026.07.20.13.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:32:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Jul 2026 22:31:58 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 8/9] bpf: Remove trace_in argument from
 __bpf_get_stack
Message-ID: <al6Fvrxd19Qip2o9@krava>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-9-jolsa@kernel.org>
 <20260720090945.C778F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720090945.C778F1F000E9@smtp.kernel.org>

On Mon, Jul 20, 2026 at 09:09:45AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] bpf_get_stack_pe permanently truncates the shared perf event callchain for user stacks.
> --
> 
> --- Patch [8]: [PATCH bpf-next 8/9] bpf: Remove trace_in argument from __bpf_get_stack ---
> commit 42ed70b803080e71468d115e2948bdba98a800f5
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Remove trace_in argument from __bpf_get_stack
> 
> This commit removes the trace_in argument from __bpf_get_stack and
> handles the trace_in case directly in a new __bpf_get_stack_pe function.
> This simplifies __bpf_get_stack for upcoming preemption fixes.
> 
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index eea7b781300ca..57cd4c33403bd 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> [ ... ]
> > @@ -978,14 +1001,13 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> >  		skip += nr_kernel;
> >  		if (skip > BPF_F_SKIP_FIELD_MASK)
> >  			goto clear;
> > -
> >  		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> > -		err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
> > +		err = __bpf_get_stack_pe(trace, buf, size, flags);
> 
> [Severity: High]
> This is a pre-existing issue, but does this permanently truncate the shared
> perf event callchain for user stacks?
> 
> In bpf_get_stack_pe(), the kernel stack branch explicitly saves and restores
> trace->nr around the call to __bpf_get_stack_pe().
> 
> However, the user stack branch directly calls __bpf_get_stack_pe() without
> saving the original trace->nr value. Inside __bpf_get_stack_pe(), the trace
> size is modified in place:
> 
> static int __bpf_get_stack_pe(...)
> {
>         ...
>         max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
>         trace->nr = min_t(u32, trace->nr, max_depth);
>         ...
> }
> 
> If a BPF program attached to a perf event requests a user stack trace and
> provides a buffer smaller than the actual callchain length, trace->nr is
> truncated.
> 
> When the perf subsystem later processes this event and outputs it to the
> perf ring buffer, could this result in incomplete or corrupted profiling
> data due to the truncated user space callchain length?

right, will fix that in next version

jirka
