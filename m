Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAB91427A
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848325; cv=none; b=mBiBwTWNEpgI8W9GFeVa/BRX1pYbkUSmaSHKxbz3+DAbowGV9ejuImtwi+i1N5FoD1uMg8cmwuMdB9En5Wnt5qGH6M+LRAsyYoXeQTe7pFc1Mi9rN/vZ5pJmpqMWvYQVZDSf+wuHh1vJurheTkkWkP7s0kzI/hWih51Uk1VmxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848325; c=relaxed/simple;
	bh=45q0AEN1NbecCD+iBBbFlmo9GV+ePz5tpmPXhyvkVYg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pyv333zm94P10PaOkpOekqZJK/4wJKMoaMbl46PXNA5EUMXN6KYTynIJDCWrmg7N0uzaLddnkl6u40ws7Qi4J1DszanHmLo8LOIzGPnouBfs88h5S+Qio/HZA9pY3dzynvqbdU4r64oMLfAQwj7Xs1iSNliEycijXzgV1iuMPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeYSxBFU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeYSxBFU"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso61545565e9.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848323; x=1779453123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GaEoCty7GhaeD1H3UefvPhtIWVVayr8sbWw+KFknDs=;
        b=EeYSxBFUZVkOzavmBJCicE2vl7pXhZFu/5ZVN6l+0i/w+ZTzkcFZKOMhRVIFlzAQcF
         Zu66waLRE2oqNsOLVrcABM7ZI/eqjKWrBgB7c09XpQSdQNbljhWCjQFZ6ffIjVKBudza
         DxfxqaTC6Br4CZbN3LpV5292olq5I1xQnA9WxY/Q8MD+miWcfYesszE6pQzjvDipdT21
         btQTzCwKVS01Lbn+LvMIIH90ioyQ2uuAS6S44UTUbJvYlU2LozRqlxMIsu6PUXuvplhf
         z8fK9tNvxw96Xr05Kt8lEQ7i1W+xoT0f0pbBpwzM4pfmSPyJ/gZexXL/V6qKVLndnWD8
         5qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848323; x=1779453123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GaEoCty7GhaeD1H3UefvPhtIWVVayr8sbWw+KFknDs=;
        b=cR4ZxTO9/wHk+ZsoQ8LJFcdRoPuoUixv4mCQLznNKnQ76dd55AGC4fQibsyD+0MwKz
         13xb1Qbzeyh+ZhzAQ6/RBnisPwacz+m1WDPNNHl2EMMIp5lPONwZlcWVeCfmA2+30e1T
         lFfp7UsOJLMwA3SFRZ1yhwtk1X5tdp6v1I/6zEUfzKRoAqxVkxoaVKjaP7rI59XClo1M
         HE/5gKjn5+qY8tN+XsufeFVl3hTeht6wAVt2A97gmQFEGUsDFKE6oRfw/3PvFPyQ1n7p
         IyIHFAGjGTq5n/Rw8UIY/N7M1ECKYppguCrdxTOF8klf16a29wiO4sado6y5GsbVcdkC
         +Gfg==
X-Gm-Message-State: AOJu0YyZgPwjpPEVzYAEASeVl0yPMm3YuWS+HLRli6OMygPM0AJUWSf1
	T4P60C+Xf5C4Am/I8YL0NM6v3DpIsI/16HT79PYHP4hC2zOBD4d8NpN1
X-Gm-Gg: Acq92OFwbRfJUTuNYDVGlD3FwiZja30/SLjd9ecrBjsWZYn/Hayd38RnGuDHVxeZL43
	kpKU3hYLaJs6ak4k/9u/sK5g7HhQCrqgficEvPgjoj+3uJvqdzGgcqzwmWapOFJhNkwivUf1Os4
	xiBIC+BNvFt3Beyj9726nRFaFyffs2a/Ceg9KttNoTXi7tRsq6xnFAoyUSSduySgRZQtqgM0bpp
	Y72IWhwF7+lo7JBh9aXXVlWh7UKSj6JdWEMR/aDsD2ld7LnaKjwAUri4FwyktOsQzfK4VzDY5H0
	NOYskqm9rRR7JHNMZa/pGIsq4PSVr7+NTXKilRlHVWsOXhFNAH/FuGmV1HPHWPoipGMhuEEfw+c
	Pqn5hxfxA1iS7eM4XUf2xznTlUitSDJ6c0zIxFdPeK8b3gOKBaSas4HyO6xeDx2rTb7MCKuLDU2
	mXEQXzYfvbOvYDVKs=
X-Received: by 2002:a05:600c:3104:b0:48e:89b8:7c6d with SMTP id 5b1f17b1804b1-48fe63074edmr50216045e9.25.1778848321855;
        Fri, 15 May 2026 05:32:01 -0700 (PDT)
Received: from krava ([2a00:102a:4039:3341:dfc:8dc0:b9c5:81b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694fbfsm105573425e9.6.2026.05.15.05.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:32:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 May 2026 14:31:59 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
Message-ID: <agcSP6LxxpRA4ICO@krava>
References: <20260514135342.22130-2-jolsa@kernel.org>
 <20260514200545.C672EC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514200545.C672EC2BCB3@smtp.kernel.org>

On Thu, May 14, 2026 at 08:05:45PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] set_orig_insn fails to unoptimize uprobes in foreign processes because __is_optimized relies on __in_uprobe_trampoline, which hardcodes current->mm for VMA lookups, resulting in silent stack pointer corruption.
> - [High] set_orig_insn fails to unoptimize a forked child's uprobe due to breakpoint overwriting the lea instruction, leaving a corrupted instruction that truncates the stack pointer.
> --
> 
> commit ecbc682eb0a0b0a7df1fd339bbdb6beeb8e1fc0a
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> uprobes/x86: Move optimized uprobe from nop5 to nop10
> 
> This commit fixes a redzone clobbering issue with optimized uprobes by
> moving them to use a 10-byte nop instruction, allowing space for a stack
> adjustment before the call.
> 
> Link: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> 
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> 
> [ ... ]
> 
> > @@ -1049,19 +1077,21 @@ static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
> >  	struct __packed __arch_relative_insn {
> >  		u8 op;
> >  		s32 raddr;
> > -	} *call = (struct __arch_relative_insn *) insn;
> > +	} *call = (struct __arch_relative_insn *)(insn + LEA_INSN_SIZE);
> >  
> > -	if (!is_call_insn(insn))
> > +	if (!is_lea_insn(insn))
> > +		return false;
> > +	if (!is_call_insn(insn + LEA_INSN_SIZE))
> >  		return false;
> > -	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
> > +	return __in_uprobe_trampoline(vaddr + OPT_INSN_SIZE + call->raddr);
> >  }
> 
> Does this sequence risk silent stack pointer corruption during uprobe
> unregistration?
> 
> When a tracer unregisters a uprobe from another process, it runs in the
> tracer's context. However, __is_optimized() calls __in_uprobe_trampoline(),
> which hardcodes current->mm for the VMA lookup:
> 
> arch/x86/kernel/uprobes.c:__in_uprobe_trampoline() {
>         struct vm_area_struct *vma = vma_lookup(current->mm, ip);
>         return vma && vma_is_special_mapping(vma, &tramp_mapping);
> }
> 
> Since current is the tracer, the lookup fails, causing __is_optimized()
> to return false.
> 
> If __is_optimized() returns false, set_orig_insn() bypasses
> swbp_unoptimize() and writes only the first byte of the original
> instruction (e.g., 0x66 for nop10) over the 0x48 (lea) byte.
> 
> This leaves the instruction 66 8d 64 24 80 e8 ... in the tracee's memory,
> which decodes as lea -0x80(%rsp), %sp. Could this truncate the stack
> pointer to 16 bits and cause stack corruption when the tracee subsequently
> pushes or pops?

yes, we need to pass vma->vm_mm to __is_optimized and not use current->mm

> 
> [ ... ]
> 
> > @@ -1095,14 +1125,25 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  		  unsigned long vaddr)
> >  {
> >  	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
> > -		int ret = is_optimized(vma->vm_mm, vaddr);
> > -		if (ret < 0)
> > +		uprobe_opcode_t insn[OPT_INSN_SIZE];
> > +		int ret;
> > +
> > +		ret = copy_from_vaddr(vma->vm_mm, vaddr, &insn, OPT_INSN_SIZE);
> > +		if (ret)
> >  			return ret;
> > -		if (ret) {
> > +		if (__is_optimized((uprobe_opcode_t *)&insn, vaddr)) {
> >  			ret = swbp_unoptimize(auprobe, vma, vaddr);
> >  			WARN_ON_ONCE(ret);
> >  			return ret;
> >  		}
> > +		/*
> > +		 * We can have re-attached probe on top of jmp8 instruction,
> > +		 * which did not get optimized. We need to restore the jmp8
> > +		 * instruction, instead of the original instruction (nop10).
> > +		 */
> > +		if (is_swbp_insn(&insn[0]) && insn[1] == OPT_JMP8_OFFSET)
> > +			return uprobe_write_opcode(auprobe, vma, vaddr, JMP8_INSN_OPCODE,
> > +						   false /* is_register */);
> >  	}
> >  	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,
> >  				   false /* is_register */);
> 
> Is there a similar issue for forked children that inherit the optimized
> 10-byte sequence?
> 
> During fork, uprobe_mmap() installs a breakpoint in the child by writing
> 0xCC to the first byte, changing the instruction from 48 8d... to cc 8d...
> 
> If the uprobe is unregistered before the child hits and re-optimizes it,
> __is_optimized() will return false because is_lea_insn() strictly expects
> the first byte to be 0x48:
> 
> arch/x86/kernel/uprobes.c:is_lea_insn() {
>         return !memcmp(insn, lea_rsp, LEA_INSN_SIZE);
> }
> 
> The fallback check for the re-attached probe on top of jmp8 also fails
> because insn[1] is 0x8d, not OPT_JMP8_OFFSET.
> 
> Could set_orig_insn() then fall back to writing just the first byte of
> the original instruction over the 0xcc, again leaving 66 8d 64 24 80 e8 ...
> and silently truncating the child's stack pointer?

nice.. maybe we can skip the install_breakpoint call in uprobe_mmap
for optimized probes.. will check

jirka
