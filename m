Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA23932EE
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541599; cv=none; b=N/SfW0rMMTAcwJfQzHIu4s3Q2KZfC3qv17HL9qCwV6IEHJqHvDr3osDJpiOXm5pgZXd9zoRZekhCYbXza9B4sE55tFeRfmY//o2DBdTohJkxjl/M0b0NEhTTowc4e0WcE0kr+PfE5aIxylCTv5V7XVVKF6a+MTicvjwd7ctM4Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541599; c=relaxed/simple;
	bh=W2gdFHu48C1yh2FQxysDtDIH1SyuMRcTpeTbBMRZJxY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=skoG0yEp1zC4eGDCIwFodNr2udabWGVUFHvy+3ZyCITv0Yj4TFDiLUICX0uqhns21Gs1gAskOBRxLmqo4OGORn8vLqFjvMd9Q2BJ809av7Wtjbkv3XmUMDzduXETbxOaJh+arpzkX5HOsCVTRabcDHdHFx+fpDSBZq2r7YiB02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDBJs2Fe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDBJs2Fe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588481F00893;
	Sun, 27 Sep 2026 20:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541597;
	bh=xpmI1FGM1e7qJSkSqUbQ+8NCxCA3rc1DOHr5A8K1Kh4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RDBJs2FePujSluQLuhnaOJMqtwIY5CpJUN+xbTUZJRjsvE83KX+4+T/oNazh1UM1G
	 te27F8qA3EjffSofRPmA5mMKv2xBNFFzURY8r6sUl8YGeQntLokIjfPDbIin0sWi6C
	 xBM2mCJVPGlgFAFl76YkZyQYCHhcGA4123IxscnkuDHeCy7mxKWa/52JnT+7ZoIBd3
	 SbxNfxI4tz0Is7Plh0wH3qO82B5BUiX9G25oGC7AE5LdaYjAn8pSFxpQak1wFXlQ2E
	 7NWrZsCRQM5+hOdcI3hMr0UEPEBeEuBJBK6gDrDHAMcXrGpPCBwlTryMo70+rcbdAx
	 BF03439iP4zMw==
Content-Type: multipart/mixed; boundary="===============6263364641702082129=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02f30a5337e07a9178f7211368e1a23e44ee278ea6b1073f68a42601c56ef48e@mail.kernel.org>
In-Reply-To: <20260926050032.2215748-1-yonghong.song@linux.dev>
References: <20260926050032.2215748-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v6 05/21] bpf: Prepare for an exception cleanup table before the CFG walk
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:39:57 +0000 (UTC)

--===============6263364641702082129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index e42eccb0990e..972b3ed2a51d 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1248,6 +1248,7 @@ bool bpf_jit_supports_stack_args(void);
>  bool bpf_jit_supports_arena_args(void);
>  bool bpf_jit_supports_far_kfunc_call(void);
>  bool bpf_jit_supports_exceptions(void);
> +bool bpf_jit_supports_cleanup_pads(void);
>  bool bpf_jit_supports_ptr_xchg(void);
>  bool bpf_jit_supports_arena(void);
>  bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);

[ ... ]

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index b19fcbf49b7e..1ed0370a171b 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c
> @@ -7,9 +7,56 @@
>  #include <linux/filter.h>
>  #include "exception.h"
>
> +#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
> +
>  BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
>  BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
>
> +static void mark_call_sites(struct bpf_verifier_env *env)
> +{
> +	u32 i, j;
> +
> +	for (i = 0; i < env->cleanup_info_cnt; i++) {
> +		struct bpf_cleanup_info *rec = &env->cleanup_info[i];
> +
> +		for (j = rec->begin_off; j < rec->end_off; j++) {
> +			struct bpf_insn *insn = &env->prog->insnsi[j];
> +
> +			if (!bpf_pseudo_call(insn) && !bpf_is_unwind_kfunc(insn))
> +				continue;
> +			env->insn_aux_data[j].cleanup_pad = rec->landing_pad_off + 1;
> +		}
> +	}
> +}

Does mark_call_sites() handle indirect BPF-to-BPF calls? The function
marks only direct calls (bpf_pseudo_call) and bpf_unwind(), but skips
callx instructions (BPF_JMP|BPF_CALL|BPF_X).

check_func_callx() in the verifier takes a PTR_TO_FUNC to a static
subprog and verifies it through check_static_func_call(), the same path
as direct calls. Nothing prevents that callee from calling bpf_unwind()
since bpf_exc_check_callback() only runs for helper/kfunc callbacks, not
static subprogs.

The commit message states cleanup_pad is recorded "for every call that
can unwind -- a BPF-to-BPF call or bpf_unwind()" but a callx inside the
[begin_off, end_off) range keeps cleanup_pad == 0.

The infrastructure that consumes cleanup_pad already handles callx:

kernel/bpf/verifier.c:
visit_func_call_insn() and push_cleanup_pad_branch() run for every
BPF_CALL instruction, including callx. If cleanup_pad is not set, they
treat the call as unable to unwind.

This means:
- visit_cleanup_pad_edge() -> bpf_exc_pad_of_call() returns -1, so no
  CFG edge is created to the landing pad
- push_cleanup_pad_branch() returns 0 before check_func_callx() runs, so
  the verifier never explores the landing pad state
- bpf_unwind_rewrite() finds no cleanup range for the frame and sets
  *ra = prog->aux->epilogue_ip

Concrete scenario: a C++ or Rust program makes a virtual or trait call
(lowered to callx) inside a scope whose drop glue sits in a landing pad.
If the callee unwinds, the caller frame goes to its epilogue and the
drop glue never runs. If that drop glue releases a kernel reference or
kptr, the release is skipped. Meanwhile the verifier modeled the
callee's resume as a normal return to callx+1.

Should the test be widened to include bpf_is_callx(), or should cleanup
tables that cover a callx be rejected?

> +
> +int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env)
> +{
> +	if (!env->cleanup_info_cnt)
> +		return 0;
> +
> +	if (bpf_prog_is_offloaded(env->prog->aux)) {
> +		verbose(env,
> +			"exception cleanup is not supported for offloaded programs\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!bpf_jit_supports_cleanup_pads() || !env->prog->jit_requested) {
> +		verbose(env,
> +			"exception cleanup needs a JIT that can dispatch landing pads\n");
> +		return -EOPNOTSUPP;
> +	}
> +	env->prog->jit_required = 1;
> +
> +	if (env->exception_callback_subprog) {
> +		verbose(env,
> +			"exception cleanup table cannot be combined with an exception callback\n");
> +		return -EINVAL;
> +	}
> +
> +	mark_call_sites(env);
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430
--===============6263364641702082129==--
