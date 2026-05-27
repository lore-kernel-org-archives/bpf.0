Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118E3C09F1
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867380; cv=none; b=izuldIQGAf65b2jDpsUdg/Cs+wP3I4dZmYT1g54frAg4lpzFajRRaPccYIw8y5tLQz1+vm+QNjFnz7nRVSczbyA5JA2MEuV/f5oBCHQe8Ml3xacVBNE0p3W22cY/WICQOWzmeFPViFRKX/MUXr67pUlGm5grBqF76mHu8nGCUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867380; c=relaxed/simple;
	bh=/E6yxZN1iL1sEOvhzLQbCR2BoEGv7qUOen6dJLFQWqE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnQ6HSfxka5oLnPlYhNY7eASLM7tGhSgu79RncSRKvS4tSGeTJzbSPO4hP276M/wyoL38pTWkFsMdEOn2l+0hyhLmK0DlTTALflVG7KPuOPIxH+ew5LvZjslSRq0GvIkGscK5i9FEtQpsHMnrS5Vf0eA3lHfPrJPS7fX5/Fcn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqEpCbQr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqEpCbQr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49048e043e5so37712165e9.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779867377; x=1780472177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UIF0+8LpPnndTQYvbVkGYrOCYND9z39MVrZ8YaX2YH8=;
        b=sqEpCbQrVhifXuv2KslEqh/TFK/9wmy9SNu7q0tx3AWfuQD40BM01QwB2OPv9HaFTb
         rooLMvBS0mjgSRCY5QAILom095FhIaEzESat2y+ekSOmsA0y4CAsF8egSo6KLmH8Haog
         404bcoMo4u9Urrzat1IX6tEuza/uWfXLmq0qvH71UAaQIELT+cfcZmdlz2PK03+aDYh4
         iOZj4LDJ7cNhA9xXwQGS2IymAgw+ZFXchQ2tx1tD70OBFkI5NLwPuz9VonvYA0SQbqrY
         XVpbtI+DnW+lLJcRhpfhUUXwIxNTMrn1UEX8D2mK75UAdrzguWJeqGeTUKjBLMV6/yqw
         ruNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779867377; x=1780472177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIF0+8LpPnndTQYvbVkGYrOCYND9z39MVrZ8YaX2YH8=;
        b=lkOhbjF0D2lRZfU2M4WOa3NSy5tEtp1/B2R1TbbHVG/I/1ItHWkJxmaXUccygc1+OO
         tOohxVaJX+IYVdiWewGbO3rfied+uTQgobOCTiUqSy132a06Cq0iaokwIS3jHuAUcB+5
         hPAUV62/53p0O4+dF1W/WRfK7RlnBm79zfBO+x24V8ydLV/0IJbo5GUciO1jREaCFbJW
         ec2vun+w8XV+lKwycleoCR52Evq6fn2ZPCkyomWO/ol0aw3+doGkJoahDkMZPzDyH7Jj
         QcV9jM4cGerpLhYn+u+TCfqDInZHRuT98SkUQpQbxrzdILcHoXtaWxRtpWebVFN23phf
         Jegg==
X-Forwarded-Encrypted: i=1; AFNElJ9l84GGgh9tvZK07Ih+BL2VyEfjgxPi9sFG8fPFpXCUYfQxO6shVcNmW9pQ/8TAzw+IPuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwexmxIEm+obNdYf8eOYGfuHSvPjIt7XwwImPLKDl8t/Yp1znW
	BzNfPsJleD9n9q9ElYcCZ+EZkyvN18NwfIJOuLk4t+G0IzXwL0I5OeQnvviFJA==
X-Gm-Gg: Acq92OH9Cm4m7cLemZx6+d19t2RjLGzjfrMWgXoPiwc2WqTZ9A3+KTgMI34nN4kGF7/
	wR/Sbtd+8xuh43vhtbWtfj8/YctlbZ7oyV/Kmj4x4wuZsFAfPsu7yxwv9wVR2bnM8TOd805xfwh
	qnYWl5zzlglV3XV+4iTAldWsoodtrhe+wmHkquRWa62exh92owGSrHq3tE7XQ/DBDqCJNpiVtAt
	rlsBeHLi8MQhB5TyOeVghXemv2RCAtyRowaMldLTZFmU4y2bBriqRcHUr9xZYjO+vcJ08MI/IN9
	0KXiz7XvkAR+3YXnXwBHSzQ7BjTNouqJhNcdAxRfLzlQzT0Y7yIbNJN1Uxk0VYjL2RmdUNKEYu5
	GbZr/5BB0s11z+HqL6LApcFteeqlmlxxv3qgjZO95zP1gX6Hsc5pwMAcR0zIogIrwMMVLAGw5Oj
	k90tKcZ4X4dQDIFTs=
X-Received: by 2002:a05:600c:8b84:b0:490:5466:8576 with SMTP id 5b1f17b1804b1-490546689a7mr333011325e9.1.1779867376895;
        Wed, 27 May 2026 00:36:16 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526ca21sm369643295e9.3.2026.05.27.00.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:36:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 May 2026 09:36:14 +0200
To: sashiko-reviews@lists.linux.dev
Cc: Gyokhan Kochmarla <gyokhan@amazon.de>, bpf@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCH 6.12] x86/fgraph: Fix return_to_handler regs.rsp value
Message-ID: <ahae7nkLYjXinDRZ@krava>
References: <20260526192324.79459-1-gyokhan@amazon.de>
 <20260526195008.897721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526195008.897721F000E9@smtp.kernel.org>

On Tue, May 26, 2026 at 07:50:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `return_to_handler` assembly routine creates a `pt_regs` (or `ftrace_regs`) structure on the kernel stack but only initializes four registers (`rax`, `rdx`, `rbp`, `rsp`), leaving the rest of the structure uninitialized. This partially initialized structure is passed to BPF kretprobe programs, leading to an information leak of kernel stack memory.
> --
> 
> commit ff6f1024b92860971d84c833c6dac53501145715
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> x86/fgraph: Fix return_to_handler regs.rsp value
> 
> This commit fixes the unwinding rsp register value in return_to_handler. It 
> saves the original rsp before the FRAME_SIZE adjustment, replacing the 
> previous incorrect value. This ensures fprobe and direct unwinders see the 
> right stack pointer.
> 
> Link: https://lore.kernel.org/bpf/20260126211837.472802-2-jolsa@kernel.org
> 
> > diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -364,6 +364,9 @@ SYM_CODE_START(return_to_handler)
> >  	UNWIND_HINT_UNDEFINED
> >  	ANNOTATE_NOENDBR
> >  
> > +	/* Store original rsp for pt_regs.sp value. */
> > +	movq %rsp, %rdi
> > +
> >  	/* Restore return_to_handler value that got eaten by previous ret instruction. */
> >  	subq $8, %rsp
> >  	UNWIND_HINT_FUNC
> > @@ -374,7 +377,7 @@ SYM_CODE_START(return_to_handler)
> >  	movq %rax, RAX(%rsp)
> >  	movq %rdx, RDX(%rsp)
> >  	movq %rbp, RBP(%rsp)
> > -	movq %rsp, RSP(%rsp)
> > +	movq %rdi, RSP(%rsp)
> 
> [Severity: High]
> This is a pre-existing issue, but could this code leak kernel stack memory
> to BPF programs?
> 
> This assembly creates a pt_regs structure on the stack by allocating
> FRAME_SIZE bytes, but only explicitly saves rax, rdx, rbp, and rsp. Later in
> ftrace_return_to_handler and arch_ftrace_partial_regs, only a few additional
> fields are populated.
> 
> The remaining fields (like rdi, rsi, rbx, and r12-r15) remain uninitialized.
> 
> Because this partially initialized pt_regs structure is passed to BPF
> kprobe_multi return programs via kprobe_multi_link_exit_handler(), and the
> BPF verifier allows reading any field of the pt_regs context, does this
> allow BPF programs to extract residual kernel stack data?

I think because kprobe/bpf is root only, it's not really an issue,
cc-ing Steven and Masami

jirka
