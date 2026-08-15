Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B752361DC1
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786779275; cv=none; b=aNM+GgIZ9xzCrrKqRfWgIEEDOUFUdiXM91teeKzZWgJKuYGXKYNBqfCntDujFLMqNIMVfq8nimlhpwVv6izsdMVyZ2nj5cLppYJeDOzzbfg6wj9vXfpmSm43UoEvQQKQrgGfDI6scVeTlsGHT1qmJi1wr248oOuFR31i+NWNE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786779275; c=relaxed/simple;
	bh=plIhnBfU8tq8FVVT8fgxxLXzYOHtJ64ebYSsjmg6XGk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H034aOPva18TPh/mysC/5lSyCHgsml6OvWR7Yo3yMT1A25ygU9r+IFCYh579xz8UdMjyTkrUW6/ZFFlLw0lcJegKh58LRuQRadyp+78g/oV9q7qwPL6PZ4c8IPfg7ZWo/Aer1TQKo+2ltObd1i5ZTO1/djSOcj7q3xAeA9E6kj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM4DWkNA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM4DWkNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE551F00A3A;
	Sat, 15 Aug 2026 07:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786779274;
	bh=iIPtQaFAsHaCW7lDBgV6mkMxMURV0a0oy8KvoHpVa5w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UM4DWkNAkkJiG9c+OU0N19iYxsPL0otI7++/a7AOD7+1mhTlChcraVb4JrLZrVxvA
	 n+qmBZz1Yj6GkCDcmfYtFhnBRQ53wHvQHOL9blDSf3U7KnAAEDXuNMobigCTzq5upG
	 6dh3kJE3s/hNf3I+k2gplz3sTMKaWQbfXI0HU+IDHTBbcWGRvTL2VLExHDX4YIzJC1
	 0ATNPiV3KexjxXWHvYs0WFw8VdVYVUIwW/wkW2IZQQmtrIuxMGfPFPh4Y5hml66cbK
	 7J4b9So2dwqHi/PtKh+EpGSvypYsJrBYeDV4OjelNduQkXQKcFwaR2eaMznvhgp705
	 mLv9QRQBDMJeA==
Content-Type: multipart/mixed; boundary="===============1872452928126267919=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <103421997bcac1a00bd535d19f7ebeee0ad03875015d8ac5333fc979810d475f@mail.kernel.org>
In-Reply-To: <20260815064612.378577-10-memxor@gmail.com>
References: <20260815064612.378577-10-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 09/14] bpf: Report Memory Safety bounds errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 07:34:33 +0000 (UTC)

--===============1872452928126267919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 962eb7b37e6b..cfc14167cad1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3762,6 +3771,21 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
>  	return 0;
>  }
>
> +static void bpf_diag_stack_read_uninit(struct bpf_verifier_env *env, int off, int i,
> +				       int size)
> +{
> +	const char *reason;
> +
> +	reason = bpf_diag_fmt(env,
> +			      "This rejected read uses %d bytes at stack offset %d, but byte %d in that range is uninitialized on this path. "
> +		"Programs loaded with CAP_PERFMON can be allowed to read uninitialized stack bytes, but this program is being rejected without that allowance.",
> +		size, off, i);
> +	bpf_diag_memory(
> +		env, env->insn_idx, "uninitialized stack read", reason,
> +		"Initialize every byte in the stack range before reading it, adjust the offset and size so the read covers only initialized bytes, "
> +		"or load with CAP_PERFMON if uninitialized stack reads are intended.");
> +}
> +

[ ... ]

> @@ -3909,6 +3935,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>  			} else {
>  				verbose(env, "invalid read from stack off %d+%d size %d\n",
>  					off, i, size);
> +				bpf_diag_stack_read_uninit(env, off, i, size);
>  			}
>  			return -EACCES;
>  		}

Does this diagnostic function produce misleading guidance for special stack
slot types? The new bpf_diag_stack_read_uninit() is defined with hard-coded
wording that says "byte %d in that range is uninitialized on this path" and
suggests using CAP_PERFMON to allow uninitialized stack reads.

The second call site above sits inside check_stack_read_fixed_off()'s
non-spill byte loop:

    for (i = 0; i < size; i++) {
        type = stype[(slot - i) % BPF_REG_SIZE];
        if (type == STACK_MISC) continue;
        if (type == STACK_ZERO) continue;
        if (type == STACK_INVALID && env->allow_uninit_stack) continue;
        if (type == STACK_POISON) {
            verbose(env, "..., slot poisoned by dead code elimination\n", ...);
        } else {
            verbose(env, "invalid read from stack off %d+%d size %d\n", ...);
            bpf_diag_stack_read_uninit(env, off, i, size);  // <--- here
        }
        return -EACCES;
    }

This else branch is entered for every slot type that is NOT STACK_MISC,
STACK_ZERO, STACK_INVALID, or STACK_POISON - which includes STACK_DYNPTR,
STACK_ITER, and STACK_IRQ_FLAG (enum bpf_stack_slot_type in
include/linux/bpf_verifier.h).

For these special slot types, the diagnostic message appears to be incorrect:

(1) The reason text says "byte %d in that range is uninitialized" but
dynptr, iterator, and irq-flag stack slots are fully initialized. They are
rejected not because they are uninitialized but because they contain opaque
internal state that cannot be directly read.

(2) The suggestion says "load with CAP_PERFMON if uninitialized stack reads
are intended." However, env->allow_uninit_stack is only checked for
STACK_INVALID (see the if statement just above in the loop), so loading with
CAP_PERFMON would not change the rejection outcome for these special slot
types.

This can be confirmed with the existing selftest at
tools/testing/selftests/bpf/progs/iters_state_safety.c:333,
read_from_iter_slot_fail, which does r7 = *(u64 *)(r6 + 0) on a bpf_iter_num
slot and is annotated to expect "invalid read from stack". The call path is
do_check (BPF_LDX) -> check_mem_access (PTR_TO_STACK branch at line 6414)
-> check_stack_read -> check_stack_read_fixed_off -> this loop. The slot
has type STACK_ITER so bpf_is_spilled_reg() returns false and the non-spill
loop is taken, which lands on this else branch and emits the diagnostic.

Should the report be restricted to STACK_INVALID, or could the reason text
and suggested remedy be keyed off the actual slot type so that special slots
get different wording?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31870608176
--===============1872452928126267919==--
