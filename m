Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8829135403
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055299; cv=none; b=WL4XDHrymE5wfa8P12IYSVdSuLWQUKSKYQxpZqObLTL6zCHHT7SP2gR8/j0REINiRr94g1oKEZhRMSD52/rwKLB1I+f7ACqxCbnSjFFh6DD+8cRex9lGfEERmKvoR0T+xpVYfaByHntR4bJEfZBMtrHZuzgraIaPl8H5Nq1sQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055299; c=relaxed/simple;
	bh=6nGZWaxvEQJPTlxbqaoUfoWRa4rMsd8Vgz47m/3sSrU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoOZSgfOTuTVnmioi4P5878VZFpNUjlVYseMbDjrBh+EUgv5YjRv29bdV3D+oTT0ekVSR+5eWSH0eDRyPXRGqAxg7YIcuzASRA258rqtTaBCclAmPpyYI5PaJ+2XN2P/TftO6ioumJTvELctBUlAbH05YVaT46m7uGRYNOlZBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSQnTZqR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSQnTZqR"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso193306166b.2
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711055296; x=1711660096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3BpDx8a84VkeSvlZ7lDoDk8Lr2e0jtFpbdlPUnEU+8=;
        b=jSQnTZqReL3AbFMXe7yi8iyXqC9R1CNOeOanm5V0RJ4YQJQQUgQert5FHQ+o0m74ZB
         zp0w4XzVak2vYKsqJTEo8xB1PXGGmxY/JIWUx6quWpT+moLYIT2bfj5b9f/IUBvKtqHI
         eYDdNbkIzP1AXPFsJ1fBsFatY/uZhOjz5yFZkj2kyw95deVTCFMntJUXsfB2Bjuh3wV0
         2PqiGZbIeiOt+HGi7HNVVNnoKCFCBmj2IlqdR42xn9o9Cp7bTVTx7s8ojpJIqbQqV77i
         a6a96ublC2cyo0Tb18ZcGrjDWHEeGul325Hn31/kQz1B+UKkSalevs7Cex7F8VCW3z4R
         SFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055296; x=1711660096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3BpDx8a84VkeSvlZ7lDoDk8Lr2e0jtFpbdlPUnEU+8=;
        b=gqha7lRq7vgNUm5/iLQQuNerNHQkIyrlv4NBWf+QDXdc0YBkIBV7iy3Tw5OzNRUuU9
         3qujbYudoJuMGyMqH0TKw3YjAMKm/LDyZX/l39KUSS29Q61YoNUseorINd/eK5Eo+AQE
         dH8GgIohX1urWx+d6Q6NARGvzIYS34O1ZLCgoFZxjo2ePtvklBTcRtWutDzwZ4bhm+Rt
         4Fc9qWAXZo09HUXjfha66VZ16fITIxSOQURLdHTO0Li2AHPZqDtxob09S5KuOzHUK8VX
         gbNCWYYNgTujHLT2a9Nj8vwi4VHSxvQmF7+jPwk6hFSau/DHNdXkd3n05E2RqFYcVwtD
         Mfjg==
X-Gm-Message-State: AOJu0YzNPx6ui39a1Xlj8F4A8/49ATNQfZu3cthgSPPsm+WrPQEJ0WxO
	ajlRRD3m13xW7LnAzGZeRKav/Q4vIMJ9uUhD6q4QmXhqK4ri9lI/
X-Google-Smtp-Source: AGHT+IE6OtwLA14g59viuXJnIN7zYC83/JcxjGCs5XqiHapN69FsVZ5TOfAF74tRDSqqkDjgHKaDTA==
X-Received: by 2002:a17:906:78f:b0:a45:f271:38cc with SMTP id l15-20020a170906078f00b00a45f27138ccmr405551ejc.43.1711055295857;
        Thu, 21 Mar 2024 14:08:15 -0700 (PDT)
Received: from krava ([83.240.62.66])
        by smtp.gmail.com with ESMTPSA id va15-20020a17090711cf00b00a46778db9e3sm306768ejb.164.2024.03.21.14.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:08:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Mar 2024 22:08:13 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, peterz@infradead.org, song@kernel.org
Subject: Re: [PATCH bpf-next 3/3] bpf,x86: inline bpf_get_smp_processor_id()
 on x86-64
Message-ID: <ZfyhvaGMPPsvqkp-@krava>
References: <20240321180501.734779-1-andrii@kernel.org>
 <20240321180501.734779-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321180501.734779-4-andrii@kernel.org>

On Thu, Mar 21, 2024 at 11:05:01AM -0700, Andrii Nakryiko wrote:
> Add arch-specific inlining of bpf_get_smp_processor_id() using x86-64's
> gs segment-based addressing.
> 
> Just to be on the safer side both rip-relative addressing is implemented
> (providing a shorter instruction, but limiting offset to signed 32 bits)
> and more universal absolute memory offset addressing is used as
> a fallback in (unlikely) scenario that given offset doesn't fit int s32.
> The latter is 5 bytes longer, and it seems compilers prefer rip-relative
> instructions when compiling kernel code.
> 
> Both instructions were tested and confirmed using gdb. We also already
> have a BPF selftest (raw_tp_test_run) that validates correctness of
> bpf_get_smp_processor_id(), while running target BPF program on each
> online CPU.
> 
> Here's a disassembly of bpf_get_smp_processor_id() helper:
> 
> $ gdb -batch -ex 'file vmlinux' -ex 'set disassembly-flavor intel' -ex 'disassemble/r bpf_get_smp_processor_id'
> Dump of assembler code for function bpf_get_smp_processor_id:
>    0xffffffff810fa890 <+0>:     0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
>    0xffffffff810fa895 <+5>:     65 8b 05 70 62 f3 7e    mov    eax,DWORD PTR gs:[rip+0x7ef36270]        # 0x30b0c <pcpu_hot+12>
>    0xffffffff810fa89c <+12>:    48 98                   cdqe
>    0xffffffff810fa89e <+14>:    c3                      ret
> End of assembler dump.
> 
> And here's a GDB disassembly dump of a piece of BPF program calling
> bpf_get_smp_processor_id().
> 
>   $ sudo cat /proc/kallsyms | rg 'pcpu_hot|bpf_prog_2b455b4f8a8d48c5_kexit'
>   000000000002d840 A pcpu_hot
>   ffffffffa000f8a8 t bpf_prog_2b455b4f8a8d48c5_kexit      [bpf]
> 
> Then attaching GDB to the running kernel in QEMU and breaking inside BPF
> program:
> 
> (gdb) b *0xffffffffa000f8e2
> Breakpoint 1 at 0xffffffffa000f8e2
> 
> When RIP-relative instruction is used:
> 
>   0xffffffffa000f8e2      mov    %gs:0x6001df63(%rip),%eax        # 0x2d84c <pcpu_hot+12>
>   0xffffffffa000f8e9      cltq
> 
> You can see that final address is resolved to <pcpu_hot+12> as expected.
> 
> When absolute addressing is used:
> 
>   0xffffffffa000f8e2      movabs %gs:0x2d84c,%eax
>   0xffffffffa000f8ed      cltq
> 
> And here 0x2d84c matches pcpu_hot address from kallsyms (0x2d840),
> plus 12 (0xc) bytes offset of cpu_number field.
> 
> This inlining eliminates entire function call for this (rather trivial in terms
> of instructions executed) helper, saving a bit of performance, but foremost
> saving LBR records (1 for PERF_SAMPLE_BRANCH_ANY_RETURN mode, and 2 for
> PERF_SAMPLE_BRANCH_ANY), which is what motivated this work in the first
> place.

this should also 'fix' the k[ret]probe-multi-fast benchmark issue right?

https://lore.kernel.org/bpf/20240315051813.1320559-2-andrii@kernel.org/

jirka

> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 4900b1ee019f..5b7fdc24b5b8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -457,6 +457,9 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>  	*pprog = prog;
>  }
>  
> +/* reference to bpf_get_smp_processor_id() helper implementation to detect it for inlining */
> +extern u64 bpf_get_smp_processor_id(u64, u64, u64, u64, u64);
> +
>  static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
>  {
>  	u8 *prog = *pprog;
> @@ -467,7 +470,28 @@ static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
>  		pr_err("Target call %p is out of range\n", func);
>  		return -ERANGE;
>  	}
> -	EMIT1_off32(opcode, offset);
> +
> +	/* inline bpf_get_smp_processor_id() to avoid calls */
> +	if (opcode == 0xE8 && func == &bpf_get_smp_processor_id) {
> +		/* 7 to account for the mov instruction itself,
> +		 * as rip value *after* mov instruction is used
> +		 */
> +		offset = (void *)&pcpu_hot.cpu_number - ip - 7;
> +		if (is_simm32(offset)) {
> +			/* mov eax,DWORD PTR gs:[rip+<offset>] ; <pcpu_hot+12> */
> +			EMIT3_off32(0x65, 0x8b, 0x05, (u32)offset);
> +		} else {
> +			/* mov eax,DWORD PTR gs:<offset> ; <pcpu_hot+12> */
> +			offset = (s64)(void *)&pcpu_hot.cpu_number;
> +			EMIT2(0x65, 0xa1);
> +			EMIT((u32)offset, 4);
> +			EMIT((u64)offset >> 32, 4);
> +		}
> +		EMIT2(0x48, 0x98); /* cdqe, zero-extend eax to rax */
> +	} else {
> +		EMIT1_off32(opcode, offset);
> +	}
> +
>  	*pprog = prog;
>  	return 0;
>  }
> -- 
> 2.43.0
> 
> 
