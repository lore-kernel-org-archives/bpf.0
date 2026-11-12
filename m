Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501560;
	b=rvp7DfsSqSkCoIx5jl3BFWv/guCdsB9gn/6Ew6W9MOkhnOWmiSR3zoRQyFCzJlQitVaE
	 sYkldOk+dRk+TzIN6jBArzoCaWxIEYvlks6P9yGX/jtOug/Ld8a8lHJmxjleaUkKt9x3i
	 S2FZJaO2M+8uuik7F/9M/E2OwsZrTYgH+k1eGNWdyVDCfuhAg831ZeOmpFJa7uESrKVhC
	 74OSavmdxxdntepSNBW2uvMw2Lo0tUoHneUF9t2/qxn+542uvNesh4ZuPxPhEUgO7aeY/
	 TeAZDJL4Q5X9SOqK0vt/n2DXI16N4By3LEpdpBXyr3faaye4DG0+2N6okZcWYPpMITg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501560;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=s5KVY0ttJPwM44AedaEeBMvPANq5jjCioUBbmEBCb0c=;
	b=iHycl998jwslJURCRC7TEdZbTGuNC977snTGFSqLWii6tDBWQoNfD1wwRshCjSHuGYoU
	 oaax2vaXk4icXVxRsUhGKMqwTsRDJfnb3wlfRPcXuZIsaCPta9mU8PgItzdkoGIFNDUkc
	 d+kuq7nmo3bw2bcjj4g/yQekRmVL+Nzg+i0NGseImYkfcw1N4ebQilJY5IYO/CCMGvHqH
	 FMubJ1MtjM0vc1n4DA90N6EtTiKbOwNMaJzABZGw5J7njW24zR8auBc9yjjsoQV+b8Vdb
	 Aisrzb3p0YYmRDli3xa3SwIFHNxSlVcNppSn+3MwbnFDWl0XFO7+jI6DZSVzDf4HjxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuKg8obU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659C606A885
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuKg8obU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C731F000C4;
	Thu, 12 Nov 2026 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501560;
	bh=s5KVY0ttJPwM44AedaEeBMvPANq5jjCioUBbmEBCb0c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BuKg8obUUbcUAQHtSKQ0tChZRMgEqm0/W34MiRvwqxkRyp/VEnO7ZE8dZaOlhMOut
	 WAqfv8Gyj2RYTQzF7e9BXlDIxbZKxowGfZBxMe+fB1Nxuzjye7Z//Y2GAIF6Dg5GIf
	 Z/qEY9a2MnLZRF87zuLFaoEYMl8Pe+LJcBhYmafOTN0tFRSJVWzQ4S/bjFa1Lb5BMA
	 o+I/0oQpvE+vjeC7yYYDXCe65kqWIrs4vIe3ST2kCeyz0s8TjYG7V1uHXcR0NVBKxn
	 Sce/+yuUaZqaStVbjiu7Q4/HkMkmI4Y3slz5GPhCiGV69KdFJpWlmd8d4rhtjBjdJb
	 8p4p/gXOTentw==
Content-Type: multipart/mixed; boundary="===============2718250168366836207=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d76ecfc94a833a84c390b5a2ca009d49fc4d8ad52e34ffca85722d5a8055e9d6@mail.kernel.org>
In-Reply-To: <20261112155337.1040699-8-alexei.starovoitov@gmail.com>
References: <20261112155337.1040699-8-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 07/12] bpf: Take the outermost common base of two linked expressions
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 12 Nov 2026 16:39:18 +0000 (UTC)

--===============2718250168366836207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Take the outermost common base of two linked expressions

TL;DR: innermost_base() may differ for two linked registers when extension
widths differ, so find_linked_regs() may skip a linked register; lost verifier
precision (a valid program may be rejected), not unsoundness.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -529,6 +518,38 @@ static bool is_low_bits(struct scev *scev, int id, u32 bits, u32 *left)
>  	return true;
>  }
>  
> +/*
> + * A value is *@base + *@off (mod 2^*@bits). An extension and a partial spill are values of their
> + * own, and they have the low N bits of their operand: go on to the base of the operand, modulo 2^N.
> + * Only to fewer bits: three steps at most. N is 32 or less: it does not matter if an add on the way
> + * becomes ALU32, see split_const_offset().
> + */
> +static bool next_base(struct scev *scev, u32 *base, s64 *off, u32 *bits)
> +{
> +	struct expr *x, *e = &scev->exprs[*base];
> +	u32 low = op_low_bits(e->op);
> +
> +	/* nothing looks through a phi, see struct expr_def */
> +	if (!low || low >= *bits || e->def.set)
> +		return false;
> +	x = &scev->exprs[e->params[0]];
> +	*base = x->base;
> +	*off = (u64)*off + x->off;
> +	*bits = low;
> +	return true;
> +}
> +
> +/* Two expressions that have a constant difference in some bits have the same one, or two REGs */
> +static u32 innermost_base(struct scev *scev, u32 id)
> +{
> +	u32 base = scev->exprs[id].base, bits = 64;
> +	s64 off = 0;
> +
> +	while (next_base(scev, &base, &off, &bits))
> +		;
> +	return base;
> +}

Does the invariant stated above innermost_base() (and in the commit
message, "Two expressions that have a constant difference in some bits have
the same innermost base, or they are two header phis") actually hold?

const_diff() takes the first base X that both chains share, but the two
sides can reach X with different widths.  next_base() only steps to fewer
bits:

	if (!low || low >= *bits || e->def.set)
		return false;

So if X is an extension whose width is at least the width on one side and
less than the width on the other, one chain stops at X while the other steps
past it.  The innermost bases then differ even though const_diff() returns
true.

This looks reachable in a program with an arena, where alu64_with_def()
gives every ALU64 add a def and simplify() does not fold (+ (+ x imm) imm)
through a def:

	w2 = w8        r2 = X = (zext32 r8)
	r3 = r2
	r3 += -1       (+ X -1)[def]
	r3 += -1       (+ (+ X -1)[def] -1)[def]   (not folded)
	w4 = w3        r4 = (zext32 <that>)
	if r4 > 61 goto out
	r1 = r6; r1 += r2; r0 = *(u8 *)(r1 + 0)

const_diff(r4, r2) matches at X with bits 32, and refine_linked_regs()
would make r2 [2, 63].  However innermost_base(r4) is X, since from 32 bits
it does not step through (zext32 r8), while innermost_base(r2) is r8.

The filter in find_linked_regs() then skips r2 before const_diff_reg() runs:

	base = innermost_base(scev, id);
	if (base != base_dst && base != base_src && !is_op(scev, base, BPF_ADD) &&
	    (h < 0 || !is_op(scev, base, REG)) && !is_big_endian_slot(r))
		continue;

so r2 stays unbounded and the access is rejected, where the parent commit
linked all three registers through the base r8.  forget_dead_mem_regs() uses
the same comparison and can evict a memory location that a live register is
still linked to.

This is lost precision rather than unsoundness, since both users are
filters.  The same reliance remains at the end of the series in
add_linked_expr()/tested_base (f3e884229534), so no later commit fixes it.

Since innermost_base() is only compared for equality, could it follow every
extension and partial spill regardless of width, as the old base did?  The
chain that const_diff() walks is a prefix of that full chain, so two linked
expressions would always end at the same innermost base.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43255831689
--===============2718250168366836207==--
