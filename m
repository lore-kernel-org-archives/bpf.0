Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865502;
	b=MG95Bj3s45eqpX3sxi33VDUwLi7fkXr80z/pexyo2AWLlIGeT9TWckg8HrQqioxwVvl0
	 SlJAedJNNj0xrWZxGooGfyCn/9B3XiqbQY/W2ACfOkOvOLVkBnYoDu3Aj5kCekfUQPUAk
	 3o7kUcth8d3O6Xti1EXmnZrlUix7DdhkDAtNuMB/xnRFR//Ilfow38djLxeMEm+GeoQva
	 fRGSsWCJ/BiuwMJhNaakTUVwgqbBp1d0DRXsAmphOc5X1I13vArpq8Vt6mQp1OFWYfGFe
	 ad6WISNATpKli2s3P3rPdsqiFkVC5YBgyeytR5icaa26wVfBUT143gdoIaqJ6WDgPDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KYy2ZgWJhsndoAf8eiR4LBCvqETtDaSKCpeg4Q4xdkM=;
	b=bEfxwRep7BCAY/483+r2x5qX57bOuPCbt5CEaJ9z5M5138pLTcDvzQp2nB4Fsc+KqnG3
	 zyPwWtDwzHtcAzmxa1Sw3CB9fKJ3nTXAoA80HrP7uQctaQ4f1uPF2DjgZueVGHrTVLOai
	 emMgsj+g4VhSKecmlvCDnpCu9RVolBjxbXQTC3i/C3dAcvC9AGxBE7WjaTmPSzQtu2UcA
	 AaeqHV6dl8RVt26+fys4R3FxxKdGciVSAlDdBU+c2HhYnUsX8P6btGZo9c5RsTfXHbOh6
	 K6hCD9/vkDaLK088YnV5m6sHmsK307V/GpIGc9B5Ti8o6sAMk+adOq/WZ5ezhNiaokg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="B/vmmxu+";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7227606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 21:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7227606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B/vmmxu+
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso2413065e9.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 13:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794865500; x=1795470300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KYy2ZgWJhsndoAf8eiR4LBCvqETtDaSKCpeg4Q4xdkM=;
        b=B/vmmxu+MW2e3JWd00CegcTbHhcbMcQXHc+bhVf3nM1lcLNnwxbhrjo/lCCZQ6a36K
         2xPCJ9Uij2sy4Bm4x5yx/YJAtmdk+XIUhPimII26pQ/ldNEd8UiB34jVveNX3Uf8mJg+
         89MbK2C6evgE+8CaDkzqXddbY5OjFjPnS6qLWDzaeYcadUM9RhRJa+b01lYFtk3n9bvl
         oi09moKDD+zbIM5eqiSbkzmzKeOo+v/sLF2D2tdQBqLe4NCCykCGyjdyzZO0bOn4g+Gv
         z0vSwnmexHa9K68MdOsi6w8apR8PVwwvn8CGWJBLmrxhXY4IWxZut32NV16wl2dMcHRG
         DEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794865500; x=1795470300;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYy2ZgWJhsndoAf8eiR4LBCvqETtDaSKCpeg4Q4xdkM=;
        b=mlXbTpNu4i6qXGsnM0NVu8ASwTSt2YperDAkse9DX/ydKMITQioWMDAsU0eubPTYvj
         WX+qg/4UVhz1T0Ksr5D9zO4hCyAuzDR4Y1tcSpXz7qkS8E6z6z16z+ZnxqMAR3xalKbO
         7aNdU4c9bCHRvc8IXVratySWYIxxuIB/wL7ncMcnfCmMR4EkeYqRDrw9XqMi1ii7Yoiy
         v5iMMJSdMPsE4XIKr/OLnRKTR2fayOOskSuUzL4LGORSp0b9SUQWWMLJ4ea1Kh/bH15t
         +V9tZLMEadqz8insQ330FszjN91pf787PLq5W16UjJUwTOrd338MYa0x2qChkC2pfVyu
         dy5w==
X-Forwarded-Encrypted: i=1; AL+hErHay0VFI1aZEERPK7kZ87o2w3cCIeAVPWDhfkHex0U25lI0Hk63AA8oLox2lthmamnLjkA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hs9czYlYAf8Id9kkJIMsg6ahxpFFhuQdzIhgIDtqI+CyDVMmQ
	fRfgqxM2vxFN8VBccU60xF22pAgCtj/XbsumdYvxMHrrvXjfgzepVAB/
X-Gm-Gg: AYBFou2ow7wG7X4DhygGPNf/dCQKVENx6PYhkg2BCseWmdMepSMNVo96jcLf4tn7adL
	krZmcP4QYF2ZpeHwlvn3SoltnVjLF6DiA9PABebzq9qOE6JreF/F7w4GJEe5Q5J0hNBLxzG/8Ni
	dofjD52VCe0FKJHcbKVegNfzJjWyOCh/80iyqKkG5q4vzkLzPWjvBc8b1DQVGVWWDtgeIbSSpE/
	Hh5MYK8QAYMCUk+wMlbF1SuEsByK/L613Y7NV8TNYJ4plE77B0SXMpprEobhTb9oWuT8pnZ4sdT
	0dmxND9B9Vx4H5n0o5SWWqcMfd/IVdCMT++4Q1LwaCeIxRNBFnPlRU05Aj4aQ6lpq3Ddfb8sPGK
	H5GjXAUWVYQ6sxNOLgYg77PRYK7M/1QG8F1S21NB6FHX11IKqSOnzKHOkNC3sSQJeIaM309jlPn
	aF63cG8b2xwoliWnMm9SDAxce2nslm/bqfcY/XOolHjWDzAbHoYwSrSXZptgVwQh7DoiVNBjZbz
	UXC5SBlP0lHWyjROawzixPtlxCOCB74obzkU+KTptj/W8zWMSVx8YxkAAdqKkzbmBXTn/ML0NP2
	B388sla1dW9q7i6w
X-Received: by 2002:a05:600c:a54:b0:4bb:5fd1:92aa with SMTP id 5b1f17b1804b1-4bb78a1b3f1mr11151135e9.15.1794865499787;
        Mon, 16 Nov 2026 13:44:59 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78344ddbsm20249415e9.0.2026.11.16.13.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:44:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Nov 2026 22:44:58 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: rtm@csail.mit.edu, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: a riscv ebpf uprobe can wedge the machine by writing
 pt_regs.status
Message-ID: <avt5WnmsPkYkeZrz@krava>
References: <30318.1794850523@30-11-166.wireless.csail.mit.edu>
 <DMWUY4M0QXMH.33XAPR76ZXKRT@gmail.com>
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
In-Reply-To: <DMWUY4M0QXMH.33XAPR76ZXKRT@gmail.com>

On Mon, Nov 16, 2026 at 06:47:41PM +0000, Alexei Starovoitov wrote:
> On Mon, Nov 16, 2026 at 09:35 AM rtm@csail.mit.edu <rtm@csail.mit.edu> wrote:
> > On riscv, kprobe_prog_is_valid_access() allows a "uprobe" ebpf program
> > to write ctx at offset 256, which is pt_regs.status. When returning to
> > user space, ret_from_exception copies whatever value the ebpf program
> > provided to the CPU's sstatus. One way this can cause trouble is if
> > the ebpf program sets sstatus.SPP to 1, indicating that the trap
> > should return to user space in supervisor mode rather than user mode.
> 
> Yes. It's a real bug, and it's not only riscv.
> The exit path trusts some of the fields. ptrace guards the same fields:
> 
>   arch    field   exit path                       ptrace
>   ------  ------  ------------------------------  -------------------
>   riscv   status  csrw CSR_STATUS, a0             not in the regset
>   arm64   pstate  msr spsr_el1, x22               valid_user_regs()
>   x86-64  cs, ss  (cs & 3) == 0: iretq to ring 0  set_segment_reg()
>   x86-64  flags   iretq loads IF and IOPL         set_flags()

yes, we need to block it

> 
> A uprobe prog should write only the registers that ptrace sets to any
> value. The verifier can reject the other offsets at load time.
> Each arch lists its registers. An arch without a list gets no writes.
> flags and pstate become read-only, the condition bits too.

I was wondering about the condition bits, but it'd be cumbersome to
block specific values and we can always make jump anyway

will send the change

thanks,
jirka


> 
> Jiri,
> pls commandeer the following:
> 
> diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
> index 2a9b0bc..1e6ac47 100644
> --- a/arch/arm64/kernel/probes/uprobes.c
> +++ b/arch/arm64/kernel/probes/uprobes.c
> @@ -152,6 +152,12 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
>  		return regs->sp < ret->stack;
>  }
>  
> +bool arch_uprobe_regs_writable(int off, int size)
> +{
> +	/* From x0 to x30, sp, pc. */
> +	return off + size <= offsetof(struct pt_regs, pstate);
> +}
> +
>  unsigned long
>  arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
>  				  struct pt_regs *regs)
> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
> index eb177d0..dbb1534 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -126,6 +126,12 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
>  		return regs->sp < ret->stack;
>  }
>  
> +bool arch_uprobe_regs_writable(int off, int size)
> +{
> +	/* epc, from ra to t6. */
> +	return off + size <= offsetof(struct pt_regs, status);
> +}
> +
>  unsigned long
>  arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
>  				  struct pt_regs *regs)
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 0f60c0d..fc07bcd 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1888,6 +1888,21 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
>  		return regs->sp <= ret->stack;
>  }
>  
> +bool arch_uprobe_regs_writable(int off, int size)
> +{
> +	int end = off + size;
> +
> +	/* The 32-bit pt_regs has segments in front of orig_ax. */
> +	if (!IS_ENABLED(CONFIG_X86_64))
> +		return false;
> +	/* From r15 to di. Not orig_ax, cs, flags, ss. */
> +	if (end <= offsetof(struct pt_regs, orig_ax))
> +		return true;
> +	if (off >= offsetof(struct pt_regs, ip) && end <= offsetofend(struct pt_regs, ip))
> +		return true;
> +	return off >= offsetof(struct pt_regs, sp) && end <= offsetofend(struct pt_regs, sp);
> +}
> +
>  /*
>   * Heuristic-based check if uprobe is installed at the function entry.
>   *
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index d34dbc0..43b250b 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -239,6 +239,7 @@ extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *
>  extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
>  extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
>  extern unsigned long arch_uprobe_get_xol_area(void);
> +extern bool arch_uprobe_regs_writable(int off, int size);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> @@ -300,5 +301,9 @@ static inline void uprobe_copy_process(struct task_struct *t, u64 flags)
>  static inline void uprobe_clear_state(struct mm_struct *mm)
>  {
>  }
> +static inline bool arch_uprobe_regs_writable(int off, int size)
> +{
> +	return false;
> +}
>  #endif /* !CONFIG_UPROBES */
>  #endif	/* _LINUX_UPROBES_H */
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index caf4447..c47b1ee 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2703,6 +2703,15 @@ void __weak arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vadd
>  {
>  }
>  
> +/*
> + * Can a bpf prog write these bytes of pt_regs? An arch opts in and lists the
> + * registers that ptrace can set to any value.
> + */
> +bool __weak arch_uprobe_regs_writable(int off, int size)
> +{
> +	return false;
> +}
> +
>  /*
>   * Run handler and ask thread to singlestep.
>   * Ensure all non-fatal signals cannot interrupt thread while it singlesteps.
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index b4ff9d4..4f1be6c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1398,8 +1398,16 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
>  	if (off + size > sizeof(struct pt_regs))
>  		return false;
>  
> -	if (type == BPF_WRITE)
> +	if (type == BPF_WRITE) {
> +		/*
> +		 * pt_regs also holds what the kernel restores on the way to
> +		 * user space: cs and flags on x86, pstate on arm64, status on
> +		 * riscv. A prog can write the registers of the task only.
> +		 */
> +		if (!arch_uprobe_regs_writable(off, size))
> +			return false;
>  		prog->aux->kprobe_write_ctx = true;
> +	}
>  
>  	return true;
>  }
> 
