Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D82345EB5;
	Thu, 13 Aug 2026 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626080; cv=none; b=RmT/iXx7uizNhWVmYPrMVA6fisz5adHJi4Hqr7+rvwdFiK/szXRr4D+tkkVfdLCbsA999n3lyXG0zBhsu0ws+9pL1B1EngHe28zQxPUjuipa4WiCvGB5Dnw4ThDHzfJLLz4G5yFv/4MtZqc1DpS7/UVZ3H7uE/rAnEmhEKILbYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626080; c=relaxed/simple;
	bh=cKew3KlUvcfVL85R5ZnuFzttOKWtkLMbIczwdQ/Mlmg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nsTLxeWYFe3QLV16/yLagWP0FDLWXnpnEvlKCUWyABl+io9nCwrkb0QKFM88fs54yT9sC3em6rwTZFQwo568S47ytOX5slO3R+kDMUz9ffHal5EF+N6lbJqGL032G7ezRkNE9S/wClnqVTJfLCjfe7oZdSycAOqBcwYvDJtRM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlrXeZw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlrXeZw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81981F000E9;
	Thu, 13 Aug 2026 13:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786626079;
	bh=BWUDOEa3rQLAZjNY2vadFOSw+8DhFWgsIfJsgxNB8yU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PlrXeZw8pEJ41ktyEKPjhvq/siZ1bydE9zCkv2Y+g6ZNnAS/+trXXkOZsHgWok9xk
	 dttV70ZkbeRdaYmy9IUT0t/Wdc/oR0HHs/OhMd8AZRB3MgEyWL1WMJp2UonVtaXISk
	 aaKinchC8eX/beKSpbmnjoA1wPfbvJNHIV8PjnK2zCV9mq+gE1Ve0Xqi4b2qAIw4Ol
	 ObbLyx8yCer96zZG2z4dhrTrN8BIe2cq5MGhStIFFIK10ipLrQEzdQoS7o0sXxa3o5
	 /BCBCjrjqYE0shXELKJZTeKayCRGT0HJDNRnA3xX+ztKdZ7fmObgwZgiIH78s2bhUA
	 shl4sbe8qWCxA==
Content-Type: multipart/mixed; boundary="===============6666041604024526426=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4ed920eb3ae305b6b4a323af841064d5486d00531e11c7c5c7cc381e22df9551@mail.kernel.org>
In-Reply-To: <20260813-bpf-next-039-ia32-kfunc-return-v1-v1-1-37495ec632b5@mails.tsinghua.edu.cn>
References: <20260813-bpf-next-039-ia32-kfunc-return-v1-v1-1-37495ec632b5@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: Normalize narrow kfunc returns on IA32
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,udknight@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 13:01:17 +0000 (UTC)

--===============6666041604024526426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
> index 852baf2e4db4d..017cc9e7e4e2b 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c

[ ... ]

> @@ -1620,13 +1620,25 @@ static int emit_kfunc_call(const struct bpf_prog *bpf_prog, u8 *end_addr,
>  		/* add esp,"bytes_in_stack" */
>  		end_addr -= 3;
>
> -	/* mov dword ptr [ebp+off],edx */
> -	if (fm->ret_size > sizeof(u32))
> -		end_addr -= 3;
> -
> -	/* mov dword ptr [ebp+off],eax */
> -	if (fm->ret_size)
> +	switch (fm->ret_size) {
> +	case 0:
> +		break;
> +	case sizeof(u8):
> +	case sizeof(u16):
> +		/* mov[s|z]x eax,[a]x */
>  		end_addr -= 3;
> +		fallthrough;
> +	case sizeof(u32):
> +		/* cdq or xor edx,edx */
> +		end_addr -= fm->ret_flags & BTF_FMODEL_SIGNED_ARG ? 1 : 2;
> +		fallthrough;
> +	case sizeof(u64):
> +		/* Store EDX:EAX in R0. */
> +		end_addr -= 6;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

The comment above this diff hunk reads:

 * address by figuring out how many jit-insn is generated between
 * the call (0xE8) and the end_addr:
 *      - 0-1 jit-insn (3 bytes each) to restore the esp pointer if there
 *        is arg pushed to the stack.
 *      - 0-2 jit-insns (3 bytes each) to handle the return value.

Should this comment be updated? The new code can emit 0-4 instructions
with varying lengths (1, 2, 3 or 6 bytes) to extend and store the
return value, not just "0-2 jit-insns (3 bytes each)".

>
>  	jmp_offset = (u8 *)__bpf_call_base + insn->imm - end_addr;
>  	if (!is_simm32(jmp_offset)) {
> @@ -1637,15 +1649,38 @@ static int emit_kfunc_call(const struct bpf_prog *bpf_prog, u8 *end_addr,
>
>  	EMIT1_off32(0xE8, jmp_offset);
>
> -	if (fm->ret_size)
> +	switch (fm->ret_size) {
> +	case sizeof(u8):
> +		/* mov[s|z]x eax,al */
> +		EMIT3(0x0F, fm->ret_flags & BTF_FMODEL_SIGNED_ARG ? 0xBE : 0xB6,
> +		      add_2reg(0xC0, IA32_EAX, IA32_EAX));
> +		break;
> +	case sizeof(u16):
> +		/* mov[s|z]x eax,ax */
> +		EMIT3(0x0F, fm->ret_flags & BTF_FMODEL_SIGNED_ARG ? 0xBF : 0xB7,
> +		      add_2reg(0xC0, IA32_EAX, IA32_EAX));
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (fm->ret_size && fm->ret_size <= sizeof(u32)) {
> +		if (fm->ret_flags & BTF_FMODEL_SIGNED_ARG)
> +			/* cdq */
> +			EMIT1(0x99);
> +		else
> +			/* xor edx,edx */
> +			EMIT2(0x31, add_2reg(0xC0, IA32_EDX, IA32_EDX));
> +	}

Does sign-extending narrow signed returns match the documented kfunc
return contract? In kernel/bpf/fixups.c the comment says:

    /* Zero-extension is done by the caller. */
    if (bpf_pseudo_kfunc_call(&insn))
            continue;

This exempts kfunc calls from the usual zero-extension path because
the JIT is responsible for R0's high half. The verifier's
__mark_btf_func_reg_size() marks narrow returns as subregs
specifically to invoke the zero-extension machinery.

For a concrete example with bpf_strcmp() which returns signed int,
if it returns -1:
  - x86-64 leaves R0 = 0x00000000ffffffff (32-bit write zeros upper half)
  - This patch makes x86-32 produce R0 = 0xffffffffffffffff via cdq

The same BPF program would see different R0 values depending on the
architecture. Is this the intended behavior, or should narrow kfunc
returns be zero-extended unconditionally to match the x86-64 path and
the fixups.c contract?

> +
> +	if (fm->ret_size) {
>  		/* mov dword ptr [ebp+off],eax */
>  		EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EAX),
>  		      STACK_VAR(bpf2ia32[BPF_REG_0][0]));
> -
> -	if (fm->ret_size > sizeof(u32))
>  		/* mov dword ptr [ebp+off],edx */
>  		EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EDX),
>  		      STACK_VAR(bpf2ia32[BPF_REG_0][1]));
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31699378511
--===============6666041604024526426==--
