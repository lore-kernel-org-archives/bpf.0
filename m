Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263083;
	b=BJY2r2xaBkladCfvOlKD94bfpEpnWYAgebsNSTU6cgnhzeRf4WbjOwAiwc4/bDYmXypK
	 q6+LN4JYazW5DfBtwOzXZpAdG/vxPc0fZywPOXgGxDf7Eic0XJyrX+1fX2wB0DkjrPg4z
	 4LcTO6xWNrIDAxNPaqgHDYsyKzr8PDAeh6q4wj0K5ROIN5+Q9bUvFfSpAvs0jqy6nR904
	 4vaEs9/H4B5JX6xohjA5jPDRl/4lVM7n49PqPBaFH45gTpFPpOt/8cIXRFENLNOWm85Zi
	 IRDv9KCT3+YcSNeSgRsvgHE/eAJYoNJVBtB4xAPJGScJQJwXPuI8NFqvb6xHO9kC6Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pWhEHip6XAQPF2r1m1/HoBje9LchqQC7s1m/oduWxbo=;
	b=pC+euapEO2irhFXVghtgMnRn2GAPw59zoLuglLvwDhM8gWi+UqJJ6tT6HkLbVRNkZXT5
	 xHkKJk2WePrdqwPwRaEKHDzbCZKexZTvSVithaWDCAb6L4ofXRZt4mofrJQVpRKRkJ2Gd
	 inocNrY5nWcYU++0X+A4KOh6RTFkwZyyFpXB4hetO4/LGfGL4ERQIAHoE1o0kL6aCAwzz
	 Z9WDDWL0BtBOylj7dr9JZ7Xhl+Pb71nd1fVeASLzloMMV+88zoKch3XviElswEqEKKjFU
	 n02XA8gp6ZEZoJGzDdW5QMcBnJDi+7zZM5L9OsTs6XaoPkVdpJ//jMGiNd4PhN4u1fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wJPd/YJ9";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CC606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 08:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B5CC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wJPd/YJ9
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1619023f8f.3
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263081; x=1793867881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pWhEHip6XAQPF2r1m1/HoBje9LchqQC7s1m/oduWxbo=;
        b=wJPd/YJ9qvFqddA8ZjUTeR3aH8D1Ho6Lh6PX3Y2D3v6PcQenzPEHZ+6sy689vtqNL+
         42QKmTAiLaKSRfNOot6EmCtR0pF5iIJ0ioPUw2cf5EV1bDWFMbVe2SQqKF+7Y8pWrLC1
         dTohUOXCursCcBOw9G9Sp1YeOu0tx0AJZ1iGMroykbHY89YaQvotDVhrq60/x7fjWio9
         Yy95e2i+e9xGuO1z3iXRk/qBLxdxGDCo2xghx1Zzha8lh7I122mfFT3IrSNDaD3uvZrz
         aLBsBQa73teYfUlZ4MebO658cj9OULlKeiRqMUaNOVeuEF22OzofyGiGnKxHamWcH6o0
         IGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263081; x=1793867881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWhEHip6XAQPF2r1m1/HoBje9LchqQC7s1m/oduWxbo=;
        b=FgyMFhCzFkbqZ9Pc5Lk9aECWT8M2ohBMYnD/puZYq+nZfn+/U8iuc95Jn5bCSdDTeE
         n/xhcO3hRi93iCEM3tuHwtT21J73H3WQguMKLAhB8acJ+5/3QP8c52vrw/Yp6wVsXhqA
         qFgtuWNCPapz//49MkpUeMYlVcc7oru7qaPXv8lzCIy3xVFdqwKJdTNJzmzd4SdnfbFm
         qHE+09HTjfAhXRTvCB96ba8km0IBmOMKJvIHRn64wT9lVSOOtdTNxtWFJsTzrti2RH+c
         ODkzdQFlKF3Kmpr6owDhHF1LDByRx0LiiKUE+ZAKRgKOOJXPiOCM+v9f5dWQUHHHrVZZ
         FBow==
X-Gm-Message-State: AFq9FYJ85stFiPkmyI9ieTo4m4FhQuTh0J/zdv6BjExmoUd3jwN6yg4H
	G9axkfDGtYb/ynFUzo3K+unR2D8v1C41aZtmxAkEWNFuXZg5z+OpCgPv
X-Gm-Gg: AYBFou1sFuvWi3/rMZ8tv8pCp49s/fS52py92OhCvTuQ4k3TcpC9mRhjb385msk9+BY
	UXNbpBH+WNpvD4e/3SYRBNvbM4CFpcYXsF9MN/5tR1toU/Cit/YrelxeyYEmYEijpBC/2CYuTg0
	Zgoc7IUOmBM30eB/G5gp5xdQNxk5r+etoY9Xszro5wHj6EcGMEdsyPWwRg21zRuOdHtVEMxAsxL
	J+EJTUHGgY8iOQUTcSqft4cBeBiF7UdJj7RYr3YiToEG4R35KVz1qFTvjwTXXBOIh6uuoh6MacK
	2xvPOK62wxQ5yNL+hqC7OKm5nffR7RcmuGWvMS0Uj/38U16GLLPxnnFlg9DxCTmYO7HG4+tazG6
	7VZPU40UyeS8iJfBQk73e+9RSol/86Iz+Lacq51rF/czMG4PIC0qVxHR759UK36KDKJLsG+LgiD
	Qdk8VtJ/HIldbam+itlvjNDeDTmUNpfzeDPxS7FWDK8jmq9dGAwxUs3yJr/vqyP14mUADbwyKmZ
	U9LE1J/IbWq97b4MZZSjeo+i+/OuRUvCoHT1FMMdPtI+6cJgcqwLehRyqERhFgyaM/JlLkmfP0j
	3woThHHYZ/sOqcLsZGwcZXaE
X-Received: by 2002:a5d:5e8d:0:b0:48d:f464:6989 with SMTP id ffacd0b85a97d-48e5d45a4edmr11394968f8f.27.1793263081252;
        Thu, 29 Oct 2026 01:38:01 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm31248264f8f.7.2026.10.29.01.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:38:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 29 Oct 2026 09:37:59 +0100
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, rostedt@goodmis.org, ast@kernel.org,
	andrii@kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf v3 1/2] x86/ftrace: Mark jmp mode by clearing bit 63
 of trampoline address
Message-ID: <auMF5x0FSons6pK6@krava>
References: <20261028202345.1215859-1-daniel@iogearbox.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028202345.1215859-1-daniel@iogearbox.net>

On Wed, Oct 28, 2026 at 09:23:44PM +0100, Daniel Borkmann wrote:
> Since commit 0c3772a8db1f ("x86/ftrace: Implement DYNAMIC_FTRACE_WITH_JMP")
> ftrace_call_replace() emits a jmp instead of a call when bit 0 of the
> target is set, the mark of a direct trampoline that is entered by a jmp.
> ftrace_update_ftrace_func() and arch_ftrace_update_trampoline() use it
> too, for the call of the ftrace callback in ftrace_caller, ftrace_regs_caller
> and the ftrace trampolines, but a callback is a C function and can start
> at an odd address. It does with gcc13 and CONFIG_CC_OPTIMIZE_FOR_SIZE=y:
> gcc13 has no -fmin-function-alignment, so CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
> is not set, and the -falign-functions=16 used in its place does not apply
> to functions optimized for size. Here ftrace_ops_list_func() starts at:
> 
>   ffffffff810e0147 T ftrace_ops_list_func
> 
> ftrace_regs_call then becomes a jmp to the byte before it:
> 
>   ftrace_regs_call ffffffff810374f3: e9 4e 8c 0a 00
> 
> That byte is the last one of the preceding function's tail jump, and with
> the first two of ftrace_ops_list_func() it decodes as an inc DWORD PTR
> [rcx+0x57], which swallows the push %r15 of the prologue. Entered without
> a return address and one push short, the list function returns through
> the pt_regs that ftrace_regs_caller saved, here to the saved R14:
> 
>   BUG: unable to handle page fault for address: ffff888116c29f40
>   #PF: supervisor instruction fetch in kernel mode
>   RIP: 0010:0xffff888116c29f40
>   R13: 0000000000000000 R14: ffff888116c29f40 R15: 0000000000000000
>   Call Trace:
>    ? bpf_trampoline_6442499918+0x1/0x149
>    ? bpf_lsm_file_open+0x5/0x8
>    ? bpf_lsm_file_open+0x5/0x8
>    ? security_file_open+0x19/0x46
>    ? do_dentry_open+0x16c/0x32a
> 
> The list function is installed whenever two ftrace_ops are registered,
> and a function that two of them trace calls it. A kprobe next to a BPF
> trampoline is one such case, and with the single ftrace_ops of the BPF
> trampolines every update_ftrace_direct_mod() is another, as it registers
> a stub ops for the sites it modifies. Here, detaching one of several BPF
> LSM programs from a busy hook crashed the tasks that ran the hook during
> the update.
> 
> Bit 0 is free only in the direct trampolines that a dyn_ftrace record can
> point to, but bit 63 is set in every kernel text address on x86_64. Thus,
> mark jmp mode by clearing bit 63 instead, so that ftrace_is_jmp() is false
> for any callback, whatever its alignment, and ftrace_regs_caller sets the
> bit again where it cleared bit 0 before. A marked address is not canonical,
> so a return or indirect branch to one that missed ftrace_jmp_get() faults
> instead of running from a byte before its target.
> 
> Fixes: 0c3772a8db1f ("x86/ftrace: Implement DYNAMIC_FTRACE_WITH_JMP")
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka


> ---
>  v2 -> v3:
>    - Removed Kconfig text, rest as-is
>  v1 -> v2:
>    - Steven suggested as an alternative/more generic fix to go
>      the route via bit 63
>    - BPF selftest kept as-is
> 
>  arch/x86/kernel/ftrace_64.S | 6 +++---
>  include/linux/ftrace.h      | 8 +++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 62c1c93aa1c6..4b20673a3395 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -286,9 +286,9 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
>  	RET
>  
>  1:
> -	testb	$1, %al
> -	jz	2f
> -	andq $0xfffffffffffffffe, %rax
> +	/* See ftrace_jmp_set(), jmp to the trampoline */
> +	btsq	$63, %rax
> +	jc	2f
>  	movq %rax, MCOUNT_REG_SIZE+8(%rsp)
>  	restore_mcount_regs
>  	/* Restore flags */
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index b041d9142d2b..1c2056a1a68b 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -618,19 +618,21 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
> +#define FTRACE_JMP_BIT	BIT(BITS_PER_LONG - 1)
> +
>  static inline bool ftrace_is_jmp(unsigned long addr)
>  {
> -	return addr & 1;
> +	return !(addr & FTRACE_JMP_BIT);
>  }
>  
>  static inline unsigned long ftrace_jmp_set(unsigned long addr)
>  {
> -	return addr | 1UL;
> +	return addr & ~FTRACE_JMP_BIT;
>  }
>  
>  static inline unsigned long ftrace_jmp_get(unsigned long addr)
>  {
> -	return addr & ~1UL;
> +	return addr | FTRACE_JMP_BIT;
>  }
>  #else
>  static inline bool ftrace_is_jmp(unsigned long addr)
> -- 
> 2.43.0
> 
