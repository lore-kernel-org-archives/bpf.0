Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC6181
	for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758412; cv=none; b=qvrVVysXt8mD+K+ui5m9ChqJxruBO6lEsFokI7WH8J41g6QP3g8xzknFRsnGpv1gjB3t3iX8w7mzJgvFg4Lu4zT5jmJYq3VBQ3RNjfExOX+PNsBHRh982/+7Hrbrv1+Ues1INbSR/d+dF1YHTnGJY06OvlcUYtc1uhnIoCZF8hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758412; c=relaxed/simple;
	bh=9LSPSaqMWATKRG0uHgs2HfJtRewonMRFTwmHZPJ+zvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=be70cNKuXSl8cC7UnDApdRDOizeK0fTw26dZU9zqdLcYoQM7llxVsJ8vU+lqn5cNC0Si71KxJnGv8NQQ61vGGS71ngqmqEO5KXQIMVX5CaiVsc1lElHIkJPaiqQrALfh6VE029GxBberGvPTYQvQrYQJTc5kyjRD/v/bsGcFpl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1GGP2Ke7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1GGP2Ke7"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29f9bffaa42so2076847a91.0
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 17:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711758411; x=1712363211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwwOeLoyofdYkgjkGGmAljNfAqcp5X8BGDNJK/pH85g=;
        b=1GGP2Ke7JQP9tZ8SF3AWUofzVIhFPCRQXmsMP1n9cN1wOKYt4XbaqjwK7kAUHl+FCx
         0G7T/fJcvSzqXn2D/yIDUlIgAGkf0rTQtvIJn6JNvLCp2eXoLMtE3GrTQYd+LLqftgNT
         fGfIiKvA/k8R25BFkyBw6D4Q0ivFHeYk79T4vDE9mtutgO0JW1BN9+Dna0vCvaNerKY9
         c2uh15iD49yHb/uu3TfFAOrtAbBchLaQYIy3oLSg4a5b3yqxXjNd9Bs23l+v9ZpSeyKn
         4jKaZpEmN05E84PJ0/HVR/t/l0se2cGzRy6JzR44gXaYpqBU39PF5BVB5KGlYEhjvlEO
         //zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711758411; x=1712363211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwwOeLoyofdYkgjkGGmAljNfAqcp5X8BGDNJK/pH85g=;
        b=EAfhO7BHHuUACQcIlRMYp6B9wDRmddY+K9zJDDckE1ArXO5beIcJtsJLZpRdh5ncZ/
         s1Zd4VACvwNQfVh3p7hagB9D6iMMAgQSu1hLEFv2mDT/BizJTJAN6Pkzz8GC/TBFL6tN
         LY2p+m6BKO8XXclDYeGx0Oobxbm60tipr+oEchnu7PdzUxYdvfSpiFOgG18Q0ZkcRZzp
         UR0nrjjyE5eUl9ZTmC+uvfl/3UQefDWwJl4ZNaGZGWB1/E/BS+4Fz82GJw5j9vJ0YFpX
         i502nmkabP3lJQ7OA0HDGiK5EZkAGkjs8HcXTVKaUUjgZIKgWxu7e7ueHLCtdPUx4MP9
         iaMA==
X-Gm-Message-State: AOJu0YwsCSsQ9GUPMeTNTnpExHhl/pmM6PqjUqgtSwnxUoNSKtKeA3zm
	TJk618uyEbutFa64mlm6j5HE76Ey6Rj0P1fVCxXDmMFAddwi+Y4sKuBzpxr2hxPKXg==
X-Google-Smtp-Source: AGHT+IHmseoQvfgqiv4C4KchpF/3GqPkySvWAdADGWHSzSH1U6Vlyva3krKnluQfc8cLixr+OAJzkVs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:cec3:b0:1e0:f478:993a with SMTP id
 d3-20020a170902cec300b001e0f478993amr300091plg.3.1711758410628; Fri, 29 Mar
 2024 17:26:50 -0700 (PDT)
Date: Fri, 29 Mar 2024 17:26:48 -0700
In-Reply-To: <20240329184740.4084786-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329184740.4084786-1-andrii@kernel.org> <20240329184740.4084786-2-andrii@kernel.org>
Message-ID: <ZgdcSDuyJ05z7sci@google.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: add internal-only per-CPU LDX instructions
From: Stanislav Fomichev <sdf@google.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="utf-8"

On 03/29, Andrii Nakryiko wrote:
> Add BPF instructions for working with per-CPU data. These instructions
> are internal-only and users are not allowed to use them directly. They
> will only be used for internal inlining optimizations for now.
> 
> Two different instructions are added. One, with BPF_MEM_PERCPU opcode,
> performs memory dereferencing of a per-CPU "address" (which is actually
> an offset). This one is useful when inlined logic needs to load data
> stored in per-CPU storage (bpf_get_smp_processor_id() is one such
> example).
> 
> Another, with BPF_ADDR_PERCPU opcode, performs a resolution of a per-CPU
> address (offset) stored in a register. This one is useful anywhere where
> per-CPU data is not read, but rather is returned to user as just
> absolute raw memory pointer (useful in bpf_map_lookup_elem() helper
> inlinings, for example).
> 
> BPF disassembler is also taught to recognize them to support dumping
> final BPF assembly code (non-JIT'ed version).
> 
> Add arch-specific way for BPF JITs to mark support for this instructions.
> 
> This patch also adds support for these instructions in x86-64 BPF JIT.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 29 +++++++++++++++++++++++++++++
>  include/linux/filter.h      | 27 +++++++++++++++++++++++++++
>  kernel/bpf/core.c           |  5 +++++
>  kernel/bpf/disasm.c         | 33 ++++++++++++++++++++++++++-------
>  4 files changed, 87 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 3b639d6f2f54..610bbedaae70 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1910,6 +1910,30 @@ st:			if (is_imm8(insn->off))
>  			}
>  			break;
>  
> +		/* internal-only per-cpu zero-extending memory load */
> +		case BPF_LDX | BPF_MEM_PERCPU | BPF_B:
> +		case BPF_LDX | BPF_MEM_PERCPU | BPF_H:
> +		case BPF_LDX | BPF_MEM_PERCPU | BPF_W:
> +		case BPF_LDX | BPF_MEM_PERCPU | BPF_DW:
> +			insn_off = insn->off;
> +			EMIT1(0x65); /* gs segment modifier */
> +			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
> +			break;
> +
> +		/* internal-only load-effective-address-of per-cpu offset */
> +		case BPF_LDX | BPF_ADDR_PERCPU | BPF_DW: {
> +			u32 off = (u32)(void *)&this_cpu_off;
> +
> +			/* mov <dst>, <src> (if necessary) */
> +			EMIT_mov(dst_reg, src_reg);
> +
> +			/* add <dst>, gs:[<off>] */
> +			EMIT2(0x65, add_1mod(0x48, dst_reg));
> +			EMIT3(0x03, add_1reg(0x04, dst_reg), 0x25);
> +			EMIT(off, 4);
> +
> +			break;
> +		}
>  		case BPF_STX | BPF_ATOMIC | BPF_W:
>  		case BPF_STX | BPF_ATOMIC | BPF_DW:
>  			if (insn->imm == (BPF_AND | BPF_FETCH) ||
> @@ -3365,6 +3389,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  	return true;
>  }
>  
> +bool bpf_jit_supports_percpu_insns(void)
> +{
> +	return true;
> +}
> +
>  void bpf_jit_free(struct bpf_prog *prog)
>  {
>  	if (prog->jited) {
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 44934b968b57..85ffaa238bc1 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -75,6 +75,14 @@ struct ctl_table_header;
>  /* unused opcode to mark special load instruction. Same as BPF_MSH */
>  #define BPF_PROBE_MEM32	0xa0
>  
> +/* unused opcode to mark special zero-extending per-cpu load instruction. */
> +#define BPF_MEM_PERCPU	0xc0
> +
> +/* unused opcode to mark special load-effective-address-of instruction for
> + * a given per-CPU offset
> + */
> +#define BPF_ADDR_PERCPU	0xe0
> +
>  /* unused opcode to mark call to interpreter with arguments */
>  #define BPF_CALL_ARGS	0xe0
>  
> @@ -318,6 +326,24 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
>  		.off   = OFF,					\
>  		.imm   = 0 })
>  
> +/* Per-CPU zero-extending memory load (internal-only) */
> +#define BPF_LDX_MEM_PERCPU(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_LDX | BPF_SIZE(SIZE) | BPF_MEM_PERCPU,\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = 0 })
> +

[..]

> +/* Load effective address of a given per-CPU offset */

nit: mark this one as internal only as well in the comment?

(the change overall looks awesome, looking forward to trying it out)
