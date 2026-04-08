Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1741DB54C
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 04:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623150; cv=none; b=Dx8zsa/ecY3hclmvYBLvFHt9pr3o1y04hlpkPa77FjSEQkG6awE2CnOqRRrN+Ol85L9ytRccP+Wy89q5Nl9eE0ngdpNiTGp8VyMffmF6rWOOks31tp0u4YRuvGcc+1POOT2GzlxKa0LawCaoBEdEBMxiU2FfyznU7jv2a/69Vdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623150; c=relaxed/simple;
	bh=hSUfKRCKmUJg28I8kA0n7CXN1Sp5WM9l9liObjb2RFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDC/D56pWGFulGv5RrKaI0f9hTdfpzNW50wNcmWvxxLq0GBLhRit1p4Z5ALkfdiWj8qbKxwQz8aM9oCIr+CVj1qHy1SVkU48EDWoPrgTvG7W5bHQdEyigp/ujdW1RclrEVX8GeGf7IX6g/rB/6y7QdpVDYiIRQ62E2GhaUb4EcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c4Pk6XUs; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c4Pk6XUs"
Message-ID: <cf64e36f-1552-4c3d-bb1c-4b352a248f8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775623146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k28QwGIubIOyvu1qXX+Oyqv2jK2m3XCKxFU5KnPGiU4=;
	b=c4Pk6XUsdjWdrNfN9pPuR2Q3mmI6plS8RIe2UGa9LsjlilQaXeDqVjXoOa8QEsGQkoh+1H
	r7rTlOVawmBt2WIzdJ31Zoi/NHKpT9ochMS01r7To8oqqLXNQfnIAl5LMcZ4v/M3oG55o6
	uIUApFuU+5tSBvWmQyUAxnynCHzCprU=
Date: Tue, 7 Apr 2026 21:38:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 03/11] bpf: Support stack arguments for bpf
 functions
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260405172601.1331846-1-yonghong.song@linux.dev>
 <34107b0f560d5c960a2a55fef331b8bb728735e1e4d1155ed7ed9511c696a296@mail.kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <34107b0f560d5c960a2a55fef331b8bb728735e1e4d1155ed7ed9511c696a296@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/5/26 11:20 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 84699a428077..52a61021613b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> +/* Validate that a stack arg access is 8-byte sized and aligned. */
>> +static int check_stack_arg_access(struct bpf_verifier_env *env,
>> +				  struct bpf_insn *insn, const char *op)
>> +{
>> +	int size = bpf_size_to_bytes(BPF_SIZE(insn->code));
>> +
>> +	if (size != BPF_REG_SIZE) {
>> +		verbose(env, "stack arg %s must be %d bytes, got %d\n",
>> +			op, BPF_REG_SIZE, size);
>> +		return -EINVAL;
>> +	}
>> +	if (insn->off % BPF_REG_SIZE) {
>> +		verbose(env, "stack arg %s offset %d not aligned to %d\n",
>> +			op, insn->off, BPF_REG_SIZE);
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
> Should this also reject non-negative offsets? The commit message and
> check_stack_arg_write() comment both state that off is a negative
> offset from the stack arg frame pointer, and the diagram shows only
> negative offsets (r12-8, r12-16, etc.).

We should. I will add more checking about positive or negative offset
(as applied) in the next revision.

>
> If a crafted BPF program uses a positive offset (e.g., off=+8), this
> function accepts it because +8 is 8-byte aligned. Then in
> check_stack_arg_write():
>
>      int spi = (-off - 1) / BPF_REG_SIZE;
>
> With off=+8, spi becomes (-8 - 1) / 8 = -1. The grow_stack_arg_slots()
> call receives a negative size, which round_up() turns to 0, so no
> allocation happens. The subsequent access to stack_arg_slots[-1] is
> an out-of-bounds write (heap underflow if previously allocated, or a
> crash if stack_arg_slots is NULL).
>
> The same issue applies to the read path in check_stack_arg_read()
> where -off becomes negative, passing the depth check, and spi
> again computes to -1.
>
> resolve_pseudo_ldimm64() explicitly allows BPF_REG_STACK_ARG_BASE
> in both src_reg and dst_reg positions, so a BPF program can encode
> these instructions.
>
> Something like the following may be sufficient:
>
>      if (insn->off >= 0) {
>          verbose(env, "stack arg %s offset must be negative\n", op);
>          return -EINVAL;
>      }
>
>> +
>> +/*
>> + * Write a value to the stack arg area.
>> + * off is the negative offset from the stack arg frame pointer.
>> + * Callers ensures off is 8-byte aligned and size is BPF_REG_SIZE.
>> + */
>> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
>> +				 int off, int value_regno)
>> +{
>> +	int spi = (-off - 1) / BPF_REG_SIZE;
> [ ... ]
>
>> +	} else {
>> +		/* BPF_ST: store immediate, treat as scalar */
>> +		reg = &state->stack_arg_slots[spi].spilled_ptr;
>> +		reg->type = SCALAR_VALUE;
>> +		__mark_reg_known(reg, (u32)env->prog->insnsi[env->insn_idx].imm);
>> +		for (i = 0; i < BPF_REG_SIZE; i++)
>> +			state->stack_arg_slots[spi].slot_type[i] = STACK_MISC;
>> +	}
>> +	return 0;
>> +}
> Is the (u32) cast on the imm field intentional here? The regular
> stack path in check_stack_write_fixed_off() passes insn->imm

Yes, good point. Will remove (u32).

> directly to __mark_reg_known() without a cast:
>
>      __mark_reg_known(tmp_reg, insn->imm);
>
> Since insn->imm is __s32 and __mark_reg_known() takes u64, the
> regular path sign-extends (e.g., imm=-1 becomes 0xffffffffffffffff).
> The (u32) cast here zero-extends instead (imm=-1 becomes
> 0x00000000ffffffff).
>
> BPF_ST with BPF_DW stores the 32-bit immediate sign-extended to
> 64 bits at runtime, so the verifier's tracked value would not match
> the actual runtime value for negative immediates.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24006922024

