Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E996FD0
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712020368; cv=none; b=CXdvxRDsGywonljVFtq06SklNILF5H87ZJ7626FIiW9zsnuwsNfzY4uiEyVatKNcZJmJ557exqpj3+iZLlx/Ue+rvWDwRJ6qUMP0ZnxKhmszyhd4vWu9k3thwU9+9P5EUcPwObYsqjLEs069dXE9ZCcD6kflu/IF7qAklH2QP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712020368; c=relaxed/simple;
	bh=XNBAb+pGZSp/8Ro3wkoJN1m/XKCjSOXCWuKWiwZsjkE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I5v14OgTguJh1XhSyip8jSYfjEWGOAobFUCIG3fQdHXPZtelab50gDLqqxVNPYMcG01dO+XFvg8EzN4pIZY2IByfYLWUOUK25ko6UXYSlI51Tnxq7NgZI21i/tgaGOOTWdCF4yi0rtOpmDubfM/zDSaRS3F1qxmpNzAuavYy5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF2tJEvt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF2tJEvt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0411c0a52so38339445ad.0
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712020366; x=1712625166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDwY3gk/nE+3/ILrXRW9p5JbNxi94KwSkUTEZPcbfx4=;
        b=FF2tJEvtbU6QxjxZRaW4/lUJ598uUMwQxpYUNxaa/ncmOIL9VZKLMsMm5FnjgRk6+c
         1k5qgca3RXKseO2qLS8+C8BjA6RhRpFPZn1Ts/FHDvI3uXgr5IfU8PiEBx5ubSvIRFgl
         QDECmeQ1USx2cnOsoQMcjtgvqdY1pKsUFHCpI90xPXWbfPrcN3OrXEffMgcdanBvb8cR
         W9vrWmZLqWNnHQ1V9sZTNDFaRjJMxWjYTUW3ziID3g7kYCglKJGtPEoSxOWOeSWUsuA+
         5brkIkKq51x1T7aI1+ChwmAku760FD0crdaEGM6zuPbVPlbtdXTfvMb0Z/wpm8zbJImg
         GqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712020366; x=1712625166;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GDwY3gk/nE+3/ILrXRW9p5JbNxi94KwSkUTEZPcbfx4=;
        b=ReRciimDgUXz6YFJD3HDNOBmvNnq5YCB1eAcYqXx7FrTclR+z5NWOKMd6T8xakRhCX
         FKppTYgLcuorXicpjC91QtjnLgg5KuQi9L7Hd4EWH68TtRT06dvZ2+M35bQeu4skcmy1
         xZimVAIczZJxfdOug+26GifP9MncYrEu+FFeZSDKd5c+kIUxhrFfUlG5GhsEQOyA8Jqz
         AqK8bKJFEzIqz08ycnKxbDbsXEC6AxNMVFGDLzfejF67mY2JHEvESPzhjm1lqSiaUvF6
         X5Eq9DLKImfg62qmKgG2ARDmRyws1J0s1e5x6j/t+Sq420IsUt/ODkMeV+vSq6r4hX3X
         tCeg==
X-Forwarded-Encrypted: i=1; AJvYcCUJMIOz/tug0YFuDlf1y4NR1SKvXD8RfydkNqd/QkyH8v8h/57YrRXNwwgvDqu6uPt7w7F6Ui6ERdtz8g1feISsEzor
X-Gm-Message-State: AOJu0YwtQbbjPBwnTaQvL2/KjRSQyZOqRlATLLxX7bLLhykWswVZIec8
	087KU8fJmUTpNUDas2SyOiZO3DhsV5bTuJnZd/NOwbKUc0ZF8bCO
X-Google-Smtp-Source: AGHT+IGW/TxmS47KeivfkTJ70rQ0yMdM8Io1Hw9oqLcsw6lue2CSkfbBozpso7uXL7I75AUtNxEETQ==
X-Received: by 2002:a17:903:110d:b0:1e0:e89f:fe26 with SMTP id n13-20020a170903110d00b001e0e89ffe26mr10869574plh.10.1712020366212;
        Mon, 01 Apr 2024 18:12:46 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902704400b001e26e1e62f9sm219211plt.176.2024.04.01.18.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 18:12:45 -0700 (PDT)
Date: Mon, 01 Apr 2024 18:12:44 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <660b5b8cc7162_801520889@john.notmuch>
In-Reply-To: <20240329184740.4084786-2-andrii@kernel.org>
References: <20240329184740.4084786-1-andrii@kernel.org>
 <20240329184740.4084786-2-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 1/4] bpf: add internal-only per-CPU LDX
 instructions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
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

[..]

> +/* Per-CPU zero-extending memory load (internal-only) */
> +#define BPF_LDX_MEM_PERCPU(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_LDX | BPF_SIZE(SIZE) | BPF_MEM_PERCPU,\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = 0 })
> +
> +/* Load effective address of a given per-CPU offset */
> +#define BPF_LDX_ADDR_PERCPU(DST, SRC, OFF)			\

Do you need OFF here? It seems the above is using &this_cpu_off.

> +	((struct bpf_insn) {					\
> +		.code  = BPF_LDX | BPF_DW | BPF_ADDR_PERCPU,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = 0 })
> +
