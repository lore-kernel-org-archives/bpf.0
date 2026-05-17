Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEE258CD7
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042220; cv=none; b=C1m45yVEDgCcGzfIDsYUdL2//FJdly1+rArUrLgXosQfldcRAaVXn39zgq+m+StxIXIN18r5XWDZTig+dsjHAzoWGvz3OLtut4YfK1zwlzkXXjYnaEcBKy07P+nNMXlMyyT+i3yrXeWXshqJd4Wbdnx1mntYJquDrLodhLI2fAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042220; c=relaxed/simple;
	bh=Ws8tPZiFODpPsS5+ZLMqe3MYQTcTYuCGrqL4K7kZ0xs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FvD/GEmVC2GsWQoCwH8CdXsUKaTkFSFQl3UNosTxcVoCsFdFjBDKNyUnFIsPeyzt74FCfOEG2jCnXMBMH3otRdAXPz8o+ZbqYXqSz+kCk7iE8LyvGso4UvFlEGOM6GUl/RKe5K9gdt5JYhVK5OD+xkDt9TOAjvjfOw99dcNswHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzXs29wW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzXs29wW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA9BC2BCB0;
	Sun, 17 May 2026 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779042219;
	bh=Ws8tPZiFODpPsS5+ZLMqe3MYQTcTYuCGrqL4K7kZ0xs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YzXs29wWLuNosKPnRwi6YLdL+KkljOaISFxSemDCwlZGKIl6A3hfKsQ7reyVrFjry
	 qjZLVpj5eiOOw14vh1KeZW9zniEcgtoPZ10JbwNFepJCMc/HFw2UDd4w0ZN6ojvjYO
	 ZE1M41jR7POLf4xAcXnzPmONxDrr51kwguZf9X5VB13JCZUyHyn39wMBNMQfhDqTtJ
	 3su2GEh8I5hnA3ZMmUDZDO656Mb1PG7gcVGjFFngDdNyWAwzkHs88UjM/0rwexjAdq
	 CEInQbS1N/aUL+GXExIKXIfOAygvrG463+SDxXJ7Hfb11J2X8M/IN8/7hcwnQ2cL3s
	 4DSHe44zymUlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] powerpc/bpf: Move out dummy_tramp_addr after
 Long branch stub
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260517214043.12975-3-adubey@linux.ibm.com>
References: <20260517214043.12975-3-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 18:23:39 +0000
Message-Id: <20260517182339.AAA9BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The JIT alignment logic for `dummy_tramp_addr` is skipped duri=
ng the sizing pass but executed during code generation, causing buffer over=
flows and BPF trampoline corruption.
- [High] The alignment prediction logic for `dummy_tramp_addr` incorrectly =
adds unscaled bytes instead of instructions, breaking the alignment and cau=
sing `bpf_arch_text_poke()` to fail.
- [Medium] Commit message claims an implementation that does not exist in t=
he code.
--

commit e4939a5c93f678ddd053f906d998b2151b87ea0f
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc/bpf: Move out dummy_tramp_addr after Long branch stub

This commit moves the dummy_tramp_addr field to the bottom of the long
branch stub to allow uninterrupted disassembly. It also updates the offset
calculation for bpf_arch_text_poke() to reflect the new location.

> Move the long branch address space to the bottom of the long
> branch stub. This allows uninterrupted disassembly until the
> last 8 bytes. Exclude these last bytes from the overall
> program length to prevent failure in assembly generation.

The commit message states that the last bytes are excluded from the overall
program length. Is this description accurate?

Looking at the code, ctx->idx is not decremented, and the length calculation
still appears to include the 8 bytes of dummy_tramp_addr.

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index ef7614177cb1f..b73bc9295c31d 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -57,19 +57,21 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fima=
ge, struct codegen_context
[ ... ]
>  #ifdef CONFIG_PPC64
>  	if (fimage && image) {
>  		/*
>  		 * pc points to first instruction of OOL stub,
> -		 * dummy_tramp_addr is past 4/3 instructions depending on
> +		 * dummy_tramp_addr is past 11/10 instructions depending on
>  		 * CONFIG_PPC_FTRACE_OUT_OF_LINE is enabled/not respectively.
>  		 *
>  		 * The decision to emit alignment NOP must depend on the alignment
>  		 * of dummy_tramp_addr field.
>  		 */
>  		unsigned long pc =3D (unsigned long)fimage + CTX_NIA(ctx);
> -		pc +=3D IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;
> +		pc +=3D IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11 : 10;
> =20
>  		if (!IS_ALIGNED(pc, 8))
>  			EMIT(PPC_RAW_NOP());
>  	}
>  #endif

Does this alignment prediction logic incorrectly add unscaled bytes instead
of instructions?

Since pc is a byte address, adding 11 or 10 bytes instead of multiplying by
4 (the instruction size) guarantees pc is no longer a multiple of 8. This
would cause the NOP to be unconditionally emitted, merely shifting the layo=
ut
by 4 bytes instead of dynamically padding it.

If the NOP is unconditionally emitted here, could dummy_tramp_addr remain
8-byte misaligned for many BPF programs, causing patch_ulong() to strictly
reject the address and BPF trampoline attachments to fail with -EINVAL?

Additionally, does this conditional alignment logic cause buffer overflows?

During the sizing pass, fimage is NULL, so the NOP emission is skipped and
the program length is calculated without it. During the code generation
pass, the NOP is emitted, causing the generated code to exceed the allocated
length by 4 bytes. Could this silently overwrite JIT metadata allocated
immediately after the program?

[ ... ]
> @@ -1400,10 +1404,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_po=
ke_type old_t,
>  	 * 1. Update the address in the long branch stub:
>  	 * If new_addr is out of range, we will have to use the long branch stu=
b, so patch new_addr
>  	 * here. Otherwise, revert to dummy_tramp, but only if we had patched o=
ld_addr here.
> +	 *
> +	 * dummy_tramp_addr moved to bottom of long branch stub.
>  	 */
>  	if ((new_addr && !is_offset_in_branch_range(new_addr - ip)) ||
>  	    (old_addr && !is_offset_in_branch_range(old_addr - ip)))
> -		ret =3D patch_ulong((void *)(bpf_func_end - bpf_jit_long_branch_stub -=
 SZL),
> +		ret =3D patch_ulong((void *)(bpf_func_end - SZL), /* SZL: dummy_tramp_=
addr offset */
>  				  (new_addr && !is_offset_in_branch_range(new_addr - ip)) ?
>  				  (unsigned long)new_addr : (unsigned long)dummy_tramp);
>  	if (ret)

If the extra NOP is emitted during generation and the layout shifts by 4
bytes, dummy_tramp_addr would be physically located at bpf_func_end - 4.

Since bpf_arch_text_poke() patches bpf_func_end - SZL (which evaluates to
8 bytes), could patch_ulong() overwrite the bctr instruction with the new
target address instead of dummy_tramp_addr, leading to an illegal instructi=
on
panic when the trampoline executes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517214043.1297=
5-1-adubey@linux.ibm.com?part=3D2
