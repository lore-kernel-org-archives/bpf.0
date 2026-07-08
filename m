Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559B3B7742;
	Wed,  8 Jul 2026 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496128; cv=none; b=Nzec+goAxeF0zcobweK/LrQIiHb/1n/I+MbG7goBzccZ2Pk96pQSdI8iSlA1U8LMFp9mAO6WA+SzD3bK3G60BUPKZDr4lFrtP1i3scssIIkVYibBZ8UmglYs2R5LfmRhvxEcPVS+exuk657njrOXaBlBflgc6D0LqfEFougSHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496128; c=relaxed/simple;
	bh=rdBir2cu1lR0h2rEv1eHWLuddtntODNO9SD57dBZrr4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=e6b2L5NCS1Kr1KOWEdEt85tRgHQ3ILw8tuYqZSbTzovBpK8OWNiBUnodCdBJnWLtTX/9fl9oqF9KWAVpRfaHgIMrYn+Db0ssCjZbRIsvYljU384xxyUc6s6GmpXJBVA185aRKo2guDunHi3b5o6H54q/BSCCsT1GdeKR+A6ZE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvieW4vl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvieW4vl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA9B1F000E9;
	Wed,  8 Jul 2026 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783496118;
	bh=P57j/DWZB4+uEQI3XzfbJrp9QFW+ToKKA6MqRAvGAcw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LvieW4vl02wqy6B0cNtWpTJMX9qyAs4jd13SEp/glDJvlxkVdfqf6aW7qT4bPmjI2
	 zARSqr+w/s1UhtZJ1MM8BoqipYjbZue0KwLZrFlw2KZP508hjXac4NC5L+4WKdduZo
	 OdqrTKcbDT1RsxYw7+gNYLmuOatMjGSJfEQT9i5WBa6p0YN8386Hb2yfNTBY3WlR0E
	 zpwZRFRIfa7/VTjrCWiUr8X2tsHGXoOADGDoyqJbC72Ou015x3CwDI7c9ak7ci8Q0G
	 LxfY8M5ZY5paEJein5LsBQjUTLGQ23qkwISXV8NlKPfaarcV8GeQ9Onf1SnkC+qBTL
	 K00aL8d2TWYEw==
Content-Type: multipart/mixed; boundary="===============3837806813243507359=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a721df30ec2f824295000183c8e91f2c19d0bd56ae115b835b402be9eacc1c71@mail.kernel.org>
In-Reply-To: <20260708064436.2971933-7-pulehui@huaweicloud.com>
References: <20260708064436.2971933-7-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and tailcalls
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org
Cc: bjorn@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,alex@ghiti.fr,pulehui@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 07:35:17 +0000 (UTC)

--===============3837806813243507359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 64161f8a9f1c78ecd88b27109e6ed8b53282f94b
> Author: Pu Lehui <pulehui@huawei.com>
> Date:   Wed Jul 8 06:44:35 2026 +0000
>
>     riscv, bpf: Mixing bpf2bpf and tailcalls
>
>     In the current RV64 JIT, if we just don't initialize the TCC in subprog,
>     the TCC can be propagated from the parent process to the subprocess, but
>     the updated TCC of the parent process cannot be restored when the
>     subprocess exits. Since the RV64 TCC is initialized before saving the
>     callee saved registers into the stack, we cannot use the callee saved
>     register to pass the TCC, otherwise the original value of the callee
>     saved register will be destroyed. So we implemented mixing bpf2bpf and
>     tailcalls similar to x86_64, i.e. using a non-callee saved register to
>     transfer the TCC between functions, and saving that register to the
>     stack to protect the TCC value. As for the tailcall hierarchy issue,
>     inspired by the s390's low-overhead approach, we store TCC from
>     RV_REG_TCC back to stack after calling bpf2bpf call or calling orig bpf
>     func in bpf trampoline.
>
>     Tests test_bpf.ko and test_verifier have passed, as well as the relative
>     testcases of test_progs*.
>
>     Signed-off-by: Pu Lehui <pulehui@huawei.com>

This looks like a bug fix for TCC handling across bpf2bpf calls and
tailcalls. Should this include:

  Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")

> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index da02717902442..419b9d795f2a7 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -81,6 +81,7 @@ struct rv_jit_context {
>  	int ex_jmp_off;
>  	unsigned long flags;
>  	int stack_size;
> +	int tcc_offset;
>  	u64 arena_vm_start;
>  	u64 user_vm_start;
>  };
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 7c6304e0b846a..823262ca47ebf 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c

[ ... ]

> @@ -2038,11 +2038,10 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>  	for (i = 0; i < RV_FENTRY_NINSNS; i++)
>  		emit(rv_nop(), ctx);
>
> -	/* First instruction is always setting the tail-call-counter
> -	 * (TCC) register. This instruction is skipped for tail calls.
> -	 * Force using a 4-byte (non-compressed) instruction.
> -	 */
> -	emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
> +	if (!is_subprog)
> +		emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
> +
> +	/* tailcall starts here, emit insn before it must be fixed */
>
>  	emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);

The TCC initialization is now conditionally emitted based on is_subprog.
Does this affect the RV_TAILCALL_OFFSET calculation?

Looking at the RV_TAILCALL_OFFSET macro definition:

  #define RV_TAILCALL_OFFSET ((RV_FENTRY_NINSNS + 1) * 4)

This assumes a fixed number of instructions before the tailcall entry
point. When is_subprog is true, the rv_addi() instruction is not emitted,
which means the tailcall entry point moves forward by 4 bytes relative to
where RV_TAILCALL_OFFSET expects it to be.

The tailcall entry is used in emit_bpf_tail_call() when calculating the
jump target for the tail call. If RV_TAILCALL_OFFSET doesn't account for
the conditional emission, could this cause the wrong entry point to be
used when tail calling into subprograms?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28923410500
--===============3837806813243507359==--
