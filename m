Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596E1A0BD0
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775413237; cv=none; b=ueCV6xtqigMYWLFwOl7s/ROUx87NDb8v1HjxS29j9UsEoRp5lW+EeFW0JxA4CQ8CAIXx2YwWJPRW9t+na/WvsfWtQOabBxddMENUsbCUer2uHEEl6lna1MUP1j6ghi4goJEw2UOnuOu9Km6ow+xWTenxotAs4QJT6CRhv4GGBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775413237; c=relaxed/simple;
	bh=FxTI/3jdoSLXYLABIMF1knD79Vi0zm7HHGkp+c/nymo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Sfu7cDs7dSVCIfqDbPQQHIg5D0nAbn4PrKwXFqHQtTs/23zwfQIuGRr53ncF79QmazynrLgy8ieP3QfLoRj780HiiIU3OmvkAgirq6pYktE4YtZ8YWJ+GvtCc+KyofI2iYQYqTMKtLxWNmL2ZKHyhxI5VMyvcia5x26OVD1qgJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4u2JZ0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4u2JZ0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8E8C116C6;
	Sun,  5 Apr 2026 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775413237;
	bh=FxTI/3jdoSLXYLABIMF1knD79Vi0zm7HHGkp+c/nymo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=s4u2JZ0vf7FM4v+r1ogxqVDT/jJ1didEV5EjVTrmb4W8nDEr/5NrbYxSiITKYFed+
	 rJsweOMNPYczbt1FMnaJQRTDKqorcmYyj3b/uT150SY5JCkVWxqjEQt2y7+NgiGagC
	 pD53KmTeJK0qY9WKZHCBYR7WOzGYyMi2z9vC1tr8z25W3JpSdIIeMvhGp5dqqAz/bq
	 l5vdXrwyD0YVSdBpH6skybBPo5Kupvaj8Ls0e7VoOljMVXCB6niShrsBT27+kIVF7d
	 ECddaCofO9ws3yKpSIUdJ07qyLuXOX54/kMkAcY2A8wu69JQpjUqW4pQ3keGwKMwVf
	 mJXxJO+kDZqrw==
Content-Type: multipart/mixed; boundary="===============2356889937471946968=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <34107b0f560d5c960a2a55fef331b8bb728735e1e4d1155ed7ed9511c696a296@mail.kernel.org>
In-Reply-To: <20260405172601.1331846-1-yonghong.song@linux.dev>
References: <20260405172601.1331846-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 03/11] bpf: Support stack arguments for bpf functions
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  5 Apr 2026 18:20:36 +0000 (UTC)

--===============2356889937471946968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 84699a428077..52a61021613b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +/* Validate that a stack arg access is 8-byte sized and aligned. */
> +static int check_stack_arg_access(struct bpf_verifier_env *env,
> +				  struct bpf_insn *insn, const char *op)
> +{
> +	int size = bpf_size_to_bytes(BPF_SIZE(insn->code));
> +
> +	if (size != BPF_REG_SIZE) {
> +		verbose(env, "stack arg %s must be %d bytes, got %d\n",
> +			op, BPF_REG_SIZE, size);
> +		return -EINVAL;
> +	}
> +	if (insn->off % BPF_REG_SIZE) {
> +		verbose(env, "stack arg %s offset %d not aligned to %d\n",
> +			op, insn->off, BPF_REG_SIZE);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

Should this also reject non-negative offsets? The commit message and
check_stack_arg_write() comment both state that off is a negative
offset from the stack arg frame pointer, and the diagram shows only
negative offsets (r12-8, r12-16, etc.).

If a crafted BPF program uses a positive offset (e.g., off=+8), this
function accepts it because +8 is 8-byte aligned. Then in
check_stack_arg_write():

    int spi = (-off - 1) / BPF_REG_SIZE;

With off=+8, spi becomes (-8 - 1) / 8 = -1. The grow_stack_arg_slots()
call receives a negative size, which round_up() turns to 0, so no
allocation happens. The subsequent access to stack_arg_slots[-1] is
an out-of-bounds write (heap underflow if previously allocated, or a
crash if stack_arg_slots is NULL).

The same issue applies to the read path in check_stack_arg_read()
where -off becomes negative, passing the depth check, and spi
again computes to -1.

resolve_pseudo_ldimm64() explicitly allows BPF_REG_STACK_ARG_BASE
in both src_reg and dst_reg positions, so a BPF program can encode
these instructions.

Something like the following may be sufficient:

    if (insn->off >= 0) {
        verbose(env, "stack arg %s offset must be negative\n", op);
        return -EINVAL;
    }

> +
> +/*
> + * Write a value to the stack arg area.
> + * off is the negative offset from the stack arg frame pointer.
> + * Callers ensures off is 8-byte aligned and size is BPF_REG_SIZE.
> + */
> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
> +				 int off, int value_regno)
> +{
> +	int spi = (-off - 1) / BPF_REG_SIZE;

[ ... ]

> +	} else {
> +		/* BPF_ST: store immediate, treat as scalar */
> +		reg = &state->stack_arg_slots[spi].spilled_ptr;
> +		reg->type = SCALAR_VALUE;
> +		__mark_reg_known(reg, (u32)env->prog->insnsi[env->insn_idx].imm);
> +		for (i = 0; i < BPF_REG_SIZE; i++)
> +			state->stack_arg_slots[spi].slot_type[i] = STACK_MISC;
> +	}
> +	return 0;
> +}

Is the (u32) cast on the imm field intentional here? The regular
stack path in check_stack_write_fixed_off() passes insn->imm
directly to __mark_reg_known() without a cast:

    __mark_reg_known(tmp_reg, insn->imm);

Since insn->imm is __s32 and __mark_reg_known() takes u64, the
regular path sign-extends (e.g., imm=-1 becomes 0xffffffffffffffff).
The (u32) cast here zero-extends instead (imm=-1 becomes
0x00000000ffffffff).

BPF_ST with BPF_DW stores the 32-bit immediate sign-extended to
64 bits at runtime, so the verifier's tracked value would not match
the actual runtime value for negative immediates.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24006922024
--===============2356889937471946968==--
