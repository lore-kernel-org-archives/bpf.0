Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D04C33D1
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213380; cv=none; b=CspY5FZBH8Rgj+pK2kK+yaHqUfSwlMAeid66G2H9ylhSSnbm2fhXeLB2IFvkPZ0zpFM/O2Ri218kCTijmAOxA0LYQkItBWBq1BoVvpPRmqVG+I0G6hUzfZ5hYj+l0rlv9EUP2wDh5WZmqJRBdLNUz1fl5fISgFJQhyu09rDJQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213380; c=relaxed/simple;
	bh=9iw8ZUv5D4s6rL/UUPqu5ipz2w+MU6JtML40NeGnyKc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=n+4z2QkUCWLXnlivstcLCDgugb8a56oz+s8s7AyLlTZrbfn5HBS+ZhS6FlqIQcAhfEf6YHIigHTlPCL+2Ay3xwa7jJ1qmZdaXl2yGFTfx+mDkU/K/bDZi3583xENCTNJ2YIr3x6E8RUIiwki0mysF+rOegomrrHyQKeDNOScGuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROTj+Tu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROTj+Tu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC3E1F000FF;
	Mon,  5 Oct 2026 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791213379;
	bh=9N65i3XEZEubNXwVa0TWUNU80T4M2msWpjlM3pYv/fE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ROTj+Tu7SUf3EWGOeHuP/TcpdTBlRNhMxVwhdT73lMnIEvziT4pcAFcX4A7s4Po4K
	 oeCySfwbuMy7FniEShrnJR2CAjXkVvPdAkwTsICkamrW1C2/7Rd1RHqBRBjrv5QPhM
	 eVes3OxasoXu9wXXbxshE/zLWGljj64Wt3QGFkIZ3ptiQToJ/6BmHr82OP45OAMzd4
	 5SKL2mLM7cLe+qJ+6KF6AmQJRMoh2oI/F84N1zczDhF3GnV57venCXUFx0+FZktsjD
	 KqXJn6SjnfPZLf9uInBpxX6bRD1SleZ+DpCwqUK8wo/jBLCZOQ1bR0cAFN5n7hcxAs
	 eI+faodQICwWQ==
Content-Type: multipart/mixed; boundary="===============3639536784644879793=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0165f4443454d5f0018f35ff645c3d7581776fe7979e84732c0eb7777ba6b6c0@mail.kernel.org>
In-Reply-To: <20261005142219.33451-8-yunwei356@gmail.com>
References: <20261005142219.33451-8-yunwei356@gmail.com>
Subject: Re: [RFC PATCH bpf-next 7/7] Documentation/bpf: Describe inline kfuncs
From: bot+bpf-ci@kernel.org
To: yunwei356@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,x86@kernel.org,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,hpa@zytor.com,leon.hwang@linux.dev,puranjay@kernel.org,sunhao.th@gmail.com,yunwei356@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  5 Oct 2026 15:16:16 +0000 (UTC)

--===============3639536784644879793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Documentation/bpf: Describe inline kfuncs

TL;DR: Documentation only: the new inline kfuncs section may be incomplete. It
omits the CONFIG_BPF_JIT_KASAN case that blocks native code, and the
32-instruction and 32-bit __k limits that make registration fail.

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 73578a4c3b1f..432e61a82aa9 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst

[ ... ]

> @@ -695,6 +695,59 @@ verified inline, so an unassigned R2 is simply passed back to the caller as
>  uninitialized and only a caller that reads it fails. A stack pointer left in
>  R2 is still rejected there, just as one in R0 is.
>
> +2.10 Inline kfuncs
> +------------------

[ ... ]

> +The verifier replaces each call with the body before it analyzes the program.
> +Only the arguments are readable at the entry of the body, and R1-R5 are not
> +readable after it, as after a call. After the analysis, a call goes back into
> +the program if the JIT has native code for it, with its operands bound to the
> +registers that the moves around the call copied them from or to. The body stays
> +when the verifier rewrites it later, for example with speculation barriers,
> +when it accesses memory other than the stack, map values, memory and packets,
> +and when constant blinding is on.

Is this list of cases complete?  In kfunc_native_ok() in
kernel/bpf/kfunc_inline.c, the case for PTR_TO_MAP_VALUE, PTR_TO_MEM,
PTR_TO_PACKET and PTR_TO_PACKET_META ends with:

    /* the JIT checks these accesses with KASAN, native code does not */
    if (IS_ENABLED(CONFIG_BPF_JIT_KASAN))
            return false;

When CONFIG_BPF_JIT_KASAN=y (HAVE_EBPF_JIT_KASAN is selected on x86-64), a
body that loads or stores through a map value, memory or packet pointer
keeps its body and gets no native code.

Of the in-tree kfuncs that covers bpf_load_be64(), bpf_prefetch() and
bpf_copy16().  The text names movbe for bpf_load_be64() as the x86-64
example, so a reader who finds that kfunc not inlined has nothing here to
explain it.  Only accesses to the stack remain inlined when
CONFIG_BPF_JIT_KASAN is set.

Should CONFIG_BPF_JIT_KASAN be added to the list, for example:

  ... when it accesses memory other than the stack, map values, memory and
  packets (or any memory but the stack with CONFIG_BPF_JIT_KASAN), and when
  constant blinding is on.

[ ... ]

> +Registration checks each body: it may use R0-R5, ALU instructions, loads and
> +stores, and forward jumps that land within it, so that it ends by falling
> +through its last instruction, but not the sign extension, signed division and
> +byte swap of cpu v4, which not every JIT has. Each argument and the result must
> +fit in one register, and the kfunc may have no kfunc flags. ``emit`` writes at
> +most ``BPF_KFUNC_INLINE_MAX`` bytes. Modules give their kfuncs bodies and
> +native code in the same way.

This paragraph reads as the list of what registration checks, but
btf_check_kfunc_body() in kernel/bpf/btf.c rejects a body in two more
cases that are not listed.

First, a body may have at most BPF_KFUNC_BODY_MAX_INSNS instructions (32,
from include/linux/btf.h):

    !len || len > BPF_KFUNC_BODY_MAX_INSNS

Second, a __k argument must be at most 32 bits wide, even though a u64
fits in one register:

    btf_param_match_suffix(btf, &args[i], "__k") &&
    btf_type_skip_modifiers(btf, args[i].type, NULL)->size > sizeof(s32)

A kfunc with a "u64 n__k" argument and a two-instruction body satisfies
every rule in the text, yet register_btf_kfunc_id_set() still fails with
-EINVAL.  A rejected body makes btf_add_kfunc_bodies() fail, so the whole
kfunc set is rejected, with no message pointing at the cause.

The text also doesn't say that atomics, ld_imm64, call, exit, gotol and
may_goto are not allowed in a body, although the positive list implies it.

Could the 32 instruction limit and the 32-bit limit on __k arguments be
stated next to the "Each argument and the result must fit in one register"
rule?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37326585321
--===============3639536784644879793==--
