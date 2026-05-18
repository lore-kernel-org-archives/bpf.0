Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986ED449ECF
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108646; cv=none; b=dnN76aj8TLl7yqZZySl1fT75W3GOyKBRk/xwWv8s1xYTHczVSM1Rn6bsP8y9GZp9csDnTUNyu50tDWiiTYHovaSQbKI9+dsXN0vnkE5pkR3zIDIvHdGKPkrkYx5GWdPvCv5l8lxylj39y/D12fvmlp5qPPLaYRHLA/wsiGE2t8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108646; c=relaxed/simple;
	bh=kG0zBGxl5DlcXlb7z+bicLfvzmtEd5Qp2YiqQMBvAwA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGF+yNDYNtQ43+El3gjkhMQE2tLUzzZEikd4Rnf6IltbVbBAAXpZ3tzfxdF5xfmLC/EuW6eegsOZyUWUHmKZUhdT1RhXaGNZYPmCqFCy5cdZCP5QKI/8qK1+F/4CXQ9gnEaG4ieoydUJydNngwyUmnAzwr6uwvZrpIs7dhfXGgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7qYqmTi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7qYqmTi"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso11234075e9.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 05:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779108643; x=1779713443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ql/8UlldJOKpd6Udzj2qJIyg292oHzAM/rjPKsghj1Y=;
        b=o7qYqmTipw8tOuUatmfeqti+3WoC7PwuntoGrB2xPsG1rZvqQ6DmQjAKA81TavWTP4
         DO73hNZ8TtQaMjPnX6M/WdcOM+Qi327RQGMupu4Mq8oKSN/+hdnsdfHblTNMoF6GLMUT
         o66khy150297C/hvul9oePpXcrzyYHAHoPEwnJAXpRrhawvWlOtTTD3TbIKEstHVy0Nr
         txaAbrfZnQnFbp8f0uNf7YqJRnGWiflZ1zW0f3f8zsiCow4qNoRKQdB9fcWdU04Ia9Xz
         FxXq8JX/HARbEOrAjLP902qZRxRdGm7fP7dq8TWDb6m2Bm8iOLZUJ/41y5cjvesSwXUC
         w8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108643; x=1779713443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ql/8UlldJOKpd6Udzj2qJIyg292oHzAM/rjPKsghj1Y=;
        b=srUIzB/xeVKAHs2rUhYRkkgQGxCJ+aRYFYmBcjwH9WdXaQEKekCrbUuFZKLPXPyYoH
         WsaHNDw94D65AuvnvDtsU/x0QJUGX6ZpuiKax1wS8oXGht3s7fQJe/2/c6qoZY3aUYsP
         dwJ7XNMD0S5CCQDcLS3S6SY8zl0SXZSGNsVPCJ+NjSPXMUEJZP4fPPeG6fX4xG1Ee8jJ
         Smc+MXl3jQspaxsSQX6mix+v2v8goFa5fhEJE/+wIQADj2nW+UQizS9yCFB0TbtcZASN
         nNsTSbSKiRLe/AxKyY8Sd7CTS4RC4ETcElibwHRQK7GdW8mAHDJGZqspi5ByN1fT7TT/
         o5Jw==
X-Gm-Message-State: AOJu0YwSNuYvvIjDWKSmSIrPv+XRJmqv3CmhseEd5ZT6bkSjCQHgQHe6
	gn2V0DD6HHo5ZaUFqPb7Fs/weOPXWda6v+2SUPk7PB7bj7psAWovmOdYDi8hsRqQ
X-Gm-Gg: Acq92OFoUEI/N/m45/Le7M+X3dfLQMKa2D8TpEuTmaTHMePeTXCeiiGDWVXxA42Wqif
	hBD2qefvgqboNskQIGzbi0XrN9oXrob+ES2Cgm0tw5Pyp41WzBDWq9ftE5jXhVXGNJm5CHXpU/1
	bYxwvMjswbEMA6pOrFX/2BsVA6LyJP+7os2YrXkdYRr1J4Tfk73h6rzD89kiHLuRJb1L96qBRS8
	YZ8zLjflDQXAwVSHHYsE9kwveq/VIUAipwpIxr+tPd2aYcUz+idbjEIXEH9Dt+Zr577ExpJjofm
	AVin3kF05rBUOfsXWRcjh+Cu0Y7XZEbdxi+UdWjPCZjz/UZgFG6xwRPu9ITu6hKGSfrm5YnZmhm
	SeMCPrMiOmdz4UlBaHuWxZt7wbS/9tnirz3aJ6B2rw6vgCzBzmbnz6NgLuQXV4LqMBscWQw0Dmv
	zthMca7l6sKnyKXryuoqpnGbZ8dQ==
X-Received: by 2002:a05:600c:35c5:b0:48f:f64c:c314 with SMTP id 5b1f17b1804b1-48ff64cc4d1mr171305945e9.30.1779108642524;
        Mon, 18 May 2026 05:50:42 -0700 (PDT)
Received: from krava ([2a00:102a:403c:11b1:accc:2af:f875:4e0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab6aasm271285035e9.2.2026.05.18.05.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:50:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 May 2026 14:50:39 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv2 02/11] uprobes/x86: Allow to copy uprobe trampolines on
 fork
Message-ID: <agsLH2G2DPxD3g12@krava>
References: <20260518105957.123445-3-jolsa@kernel.org>
 <20260518114208.CE128C2BCF6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518114208.CE128C2BCF6@smtp.kernel.org>

On Mon, May 18, 2026 at 11:42:08AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] __in_uprobe_trampoline uses current->mm instead of the target mm_struct, causing kernel crashes and instruction stream corruption during uprobe_unregister.
> - [High] Removing VM_DONTCOPY without synchronizing the uprobes state causes a linear VMA leak across fork chains.
> --
> 
> commit be0e6254bd9df4f56adce23d7a5e24a78c286291
> Author: Jiri Olsa <jolsa@kernel.org>
> uprobes/x86: Allow to copy uprobe trampolines on fork
> 
> This commit allows vma uprobe trampoline objects to be copied on fork to
> the new process by removing the VM_DONTCOPY flag.
> 
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -702,7 +702,7 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> >  
> >  	tramp->vaddr = vaddr;
> >  	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
> > -				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> > +				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
> 
> Does removing VM_DONTCOPY without synchronizing the uprobes state cause a
> linear VMA leak across fork chains?
> 
> When dup_mmap() copies the uprobe trampoline VMA to the child process during
> fork(), the child's tracking list (mm->uprobes_state.head_tramps) is
> initialized as completely empty via mm_init_uprobes_state(), meaning the
> parent's state is not duplicated.
> 
> When the child process executes a uprobe, arch_uprobe_optimize() calls
> get_uprobe_trampoline(). Because head_tramps is empty, it fails to find the
> VMA it already inherited. It then falls back to create_uprobe_trampoline(),
> which calls find_nearest_trampoline(). Since the inherited VMA is already
> mapped, find_nearest_trampoline() finds a new unmapped area and installs a
> second duplicate trampoline VMA.
> 
> In a deep fork chain, each generation inherits all previous VMAs, has an
> empty head_tramps list, and creates a new VMA. Can this cause a linear
> accumulation of redundant VMAs, eventually exhausting vm.max_map_count and
> virtual memory?

I don't think it's big problem, because it's unlikely you'll insert extra uprobes
to child process.. but perhaps we could go away with struct uprobe_trampoline
object and operate directly on top of vma objects, it could event make code
easier, will try

> 
> As a related question about the uprobe trampolines introduced in the preceding
> commit ba2bfc97b462, does __in_uprobe_trampoline() safely handle unregistered
> uprobes?
> 
> When a uprobe is unregistered (e.g., via bpf_uprobe_unregister in a workqueue
> or by a different process like perf), set_orig_insn() calls is_optimized() to
> check if the uprobe is optimized. If is_optimized() internally calls
> __in_uprobe_trampoline() which hardcodes current->mm for the VMA lookup, does
> it completely ignore the passed mm parameter?

__in_uprobe_trampoline has no longer hardcoded current->mm, check
previous patch:

      uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline

jirka

> 
> If unregistered asynchronously from a kernel thread, current->mm is NULL. Can
> this cause a deterministic NULL pointer dereference in vma_lookup() and crash
> the kernel?
> 
> Additionally, if unregistered by a different process, would vma_lookup()
> search the wrong mm, return false, and cause set_orig_insn() to incorrectly
> assume the instruction is not optimized? Could this lead to replacing only
> the first byte of the 5-byte CALL instruction with the original opcode,
> leaving the 4-byte relative offset as garbage and crashing the traced process
> when it executes the corrupted instruction?
> 
> >  				&tramp_mapping);
> >  	if (IS_ERR(vma)) {
> >  		kfree(tramp);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260518105957.123445-3-jolsa@kernel.org?part=1
