Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F63F33B6FC
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912700; cv=none; b=WBeo2wYClN8kIFuW4ObRZ9nWrTc0vHrbqo1RnJ0sd8DCXMmIXvbfz7WoM8A62HzYmAoGq39G4pyUEFwg2Bb/1Vcfw3a2HngYMjStu/HnQjYDlHrdiMPJfyl078O4LqvAK1ZTHiBTZRxjH1PfVveoHeQIwvkK8y9P7718MonRqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912700; c=relaxed/simple;
	bh=fQFPotV5MSgUPJ0mmBXHXpip8FgRjWyi8XSd+DhN4yU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=S1pcR/xcFw5lqTEJqiHeZnkNx0Jr/MS272kKYWTbk79d1wuiYkrhvNRXebJDM0hr6bzvnRTh10aDkx889yy59/SzkI0rv3VVFvRdWWxZl/bnRS+PJvmd0n6/KhlPGyHnTW5zID/g7g2rx9XNdREHCmxnbrVGSdtTdkiqIUXvJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGjb92rp; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGjb92rp"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4865b9e16d4so1029589b6e.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 16:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781912698; x=1782517498; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q/4zH1hxGZNlvMMjLHIxgqSqQKSIx9wT1PcxTGLAro=;
        b=eGjb92rpqwU+ulFNG5yiWX4l+DznkHKetv5EL1AqTQA0Fz3nmKvIG2mve3i8J4SpNH
         afAhhpShEYK5VZ3Cmc8yAjZEA9ZLT9ddLp6LRFkSV4wLrybaUakx0l0ykTrK1htclf6+
         HdnaMlWDP23gkYysCThZDtSO0q6YUu2CGM7m+DUoDRM81wG7OrorJQKcgFUbHnL4V1gR
         JD6vasEofPoPwzhx/4Pfv+GOjUp3GFuomQAmxHSMOlirPrJMTIazsSpJjbMdkWimI5p9
         0t66WKtBbNa2Qwax0bPfR7U8yZ9KHIWdEZUdY0y5DUXxmFW9Xjybb39Sa7iDyuoWSq3W
         6bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781912698; x=1782517498;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2q/4zH1hxGZNlvMMjLHIxgqSqQKSIx9wT1PcxTGLAro=;
        b=XIg8QNEsFLLQlV97ZAUDW2DK/uuH9BqpvXQb1rBxknD3c34SOGXbepMNZgk9cUkTfu
         4CGAmp9nPB3EiHBwTFa/cs4YCXXWCEUiiTodn33aFltbf1wElIDDIMfE9YRI1X6d7y+1
         LlWBxMbJghgNEgQYtqQU3QpP1bgoxqljrYAfkDLzO4DYCuuY/MyK/Y5OvAF17jnnOFup
         7o4QL33mGlGVT5Hm/DnR7x2jxV8ln9xihljHKIhRAdRK7I/MAZ+3R7g7zOEXhRWSVeOC
         8dQjQci+YGaVOODhEqK0reccSnq6CSWtFu7ys/p4cPQUeBW7eqDmLmVWwgdFsPpVJtTS
         Kr+g==
X-Forwarded-Encrypted: i=1; AFNElJ/JzQdNt36LBA1rmb9VKRKt8zcxk2ouEPlm9MgVD8faFt43uW39D4j5HtCDMXbm5ZkaNXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBr3Gl8mxWVFsfa71t5N80k2SO8s0XD5kIFxYzqrKgpRdSlcW9
	X4AWtyfC5l0cq1NOv49hmb5vBsaY3iUNIxwZQqOOkbgcH1nKOHJefxjf
X-Gm-Gg: AfdE7clCLpIEHp01Q9NECrPqlM1pEcx4OywE9oG3fpeHXsimOXlznIVnH2PL4Np1FmX
	cqinLn57txgBSoCDrFNvTiZRZfdAT870knybzMBa9RD4rSc1dWKnY0GQ10lmVkdsOvA+TNgvvXI
	AV2Ipi17ZXki4Zoi2fZ7gpjQGfzTZqHNojnu27Rv13afrwn3XQZ4D9Y6avTd46hS7csiqWHz8KJ
	ShMRfkUKg616K22xTsj9oDCSIpx9IkVHuZRmi6fcAS799wyGIIOOfIXBUx/rhqlKsCuQdI4sBCP
	0jWdd+etqE4dp8C9sCH3SB4oBrOadNxpgJ4tjZy+Ekuf7adEO8iYGSNCwhfrfqYKfLSIR94IMv9
	Bfb6iH1uzw3h+GY+/dgyNHs5gvuJPsOC3PfNWJbU9opveEAEbP19Rc/lsK0xzR5M5pZtplnXQTh
	nZ2xKfcNmF6tlTv2HSPnAjMTthZpuSBZKwKtUEesdumyBQJs4wTjo24tezQh/6UKSFNeBIswDb7
	fvT55JFrKLSMNDIzg==
X-Received: by 2002:a05:6808:6a87:b0:489:4412:50a8 with SMTP id 5614622812f47-4896abdc690mr4830145b6e.25.1781912698063;
        Fri, 19 Jun 2026 16:44:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4c::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0dd2bbsm356187b6e.6.2026.06.19.16.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 16:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 16:44:56 -0700
Message-Id: <DJDFBZS7ZEYD.YWY8TUQ7ULJS@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 12/17] bpf: Report Execution Context Safety
 errors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260619205934.1312876-1-memxor@gmail.com>
 <20260619205934.1312876-13-memxor@gmail.com>
In-Reply-To: <20260619205934.1312876-13-memxor@gmail.com>

On Fri Jun 19, 2026 at 1:59 PM PDT, Kumar Kartikeya Dwivedi wrote:
> Augment selected sleepability and critical-section failures with Executio=
n
> Context Safety reports. Keep the existing verifier messages and add sourc=
e
> context, path history, and suggestions tied to the active context.
>
> Use the context history recorded earlier to anchor causal paths to lock, =
IRQ,
> RCU, and preempt regions instead of unrelated register updates.
>
> Cover global calls while holding a lock, sleepable global function calls,
> sleepable helpers, sleepable kfunc calls from disallowed contexts, operat=
ions
> that exit while a context is still active, and unmatched context exits.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/diagnostics.c | 165 +++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/diagnostics.h |  14 ++++
>  kernel/bpf/verifier.c    | 114 +++++++++++++++++++++++++++
>  3 files changed, 293 insertions(+)
>
> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 19e72b07afc1..7c903e502973 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -844,6 +844,7 @@ static u32 bpf_diag_current_frameno(const struct bpf_=
verifier_env *env)
>  }
> =20
>  static int bpf_diag_stack_argno(u8 slot);
> +static const char *bpf_diag_context_name(enum bpf_diag_context_kind kind=
);
> =20
>  void bpf_diag_report_register_type(struct bpf_verifier_env *env,
>  				   u32 insn_idx, int regno,
> @@ -953,6 +954,170 @@ void bpf_diag_report_call_type(struct bpf_verifier_=
env *env, u32 insn_idx,
>  	bpf_diag_report_suggestion(env, "%s", suggestion);
>  }
> =20
> +static const char *bpf_diag_context_constraint(enum bpf_diag_context_kin=
d kind)
> +{
> +	switch (kind) {
> +	case BPF_DIAG_CONTEXT_RCU:
> +		return "RCU read-side critical sections cannot call operations that ma=
y sleep";
> +	case BPF_DIAG_CONTEXT_PREEMPT:
> +		return "preemption-disabled code cannot call operations that may sleep=
";
> +	case BPF_DIAG_CONTEXT_IRQ:
> +		return "IRQ-disabled code cannot call operations that may sleep";
> +	case BPF_DIAG_CONTEXT_LOCK:
> +		return "code holding a BPF spin lock cannot call operations that may s=
leep";
> +	case BPF_DIAG_CONTEXT_NONE:
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static void bpf_diag_format_active_context(char *buf, size_t size, u32 d=
epth,
> +					   const char *context)
> +{
> +	if (depth =3D=3D 1)
> +		scnprintf(buf, size, "an active %s (depth 1)", context);
> +	else
> +		scnprintf(buf, size, "%u active %ss (depth %u)", depth,
> +			  context, depth);
> +}
> +
> +static u32 bpf_diag_context_depth(struct bpf_verifier_env *env,
> +				  enum bpf_diag_context_kind kind)
> +{
> +	switch (kind) {
> +	case BPF_DIAG_CONTEXT_RCU:
> +		return env->cur_state->active_rcu_locks;
> +	case BPF_DIAG_CONTEXT_PREEMPT:
> +		return env->cur_state->active_preempt_locks;
> +	case BPF_DIAG_CONTEXT_IRQ:
> +		return env->cur_state->active_irq_id ? 1 : 0;
> +	case BPF_DIAG_CONTEXT_LOCK:
> +		return env->cur_state->active_locks;
> +	case BPF_DIAG_CONTEXT_NONE:
> +	default:
> +		return 0;
> +	}
> +}
> +
> +void bpf_diag_report_execution_context(struct bpf_verifier_env *env,
> +				       u32 insn_idx, const char *operation,
> +				       enum bpf_diag_context_kind ctx_kind,
> +				       const char *context,
> +				       const char *suggestion)
> +{
> +	u32 depth =3D bpf_diag_context_depth(env, ctx_kind);
> +	struct bpf_diag_history_opts opts =3D {
> +		.scope =3D BPF_DIAG_HISTORY_SCOPE_CONTEXT,
> +		.ctx_kind =3D ctx_kind,
> +		.ctx_depth =3D depth,
> +	};
> +	const char *depth_buf;
> +
> +	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY,
> +			       "operation is not allowed in this context");
> +	if (bpf_diag_context_constraint(ctx_kind)) {
> +		if (depth) {
> +			depth_buf =3D bpf_diag_scratch_buf(env,
> +							 2,
> +							 NULL);
> +			if (depth_buf)
> +				bpf_diag_format_active_context((char *)depth_buf,
> +							       BPF_DIAG_SCRATCH_STR_LEN,
> +							       depth, context);
> +			else
> +				depth_buf =3D "";
> +			bpf_diag_report_reason(env,
> +					       "The operation %s cannot be used in %s because %s. This path=
 is still inside %s.",
> +					       operation, context,
> +					       bpf_diag_context_constraint(ctx_kind),
> +					       depth_buf);
> +		} else {
> +			bpf_diag_report_reason(env,
> +					       "The operation %s cannot be used in %s because %s.",
> +					       operation, context,
> +					       bpf_diag_context_constraint(ctx_kind));
> +		}
> +	} else {
> +		bpf_diag_report_reason(env,
> +				       "The operation %s cannot be used in %s.",
> +				       operation, context);
> +	}
> +
> +	bpf_diag_report_section(env, "At");
> +	bpf_diag_report_source(env, insn_idx, "error",
> +			       "%s is not allowed in %s", operation, context);
> +
> +	if (ctx_kind !=3D BPF_DIAG_CONTEXT_NONE)
> +		bpf_diag_print_history(env, &opts);
> +
> +	bpf_diag_report_suggestion(env, "%s", suggestion);
> +}
> +
> +void bpf_diag_report_context_still_active(struct bpf_verifier_env *env,
> +					  u32 insn_idx, const char *operation,
> +					  enum bpf_diag_context_kind ctx_kind,
> +					  const char *context,
> +					  const char *suggestion)
> +{
> +	u32 depth =3D bpf_diag_context_depth(env, ctx_kind);
> +	struct bpf_diag_history_opts opts =3D {
> +		.scope =3D BPF_DIAG_HISTORY_SCOPE_CONTEXT,
> +		.ctx_kind =3D ctx_kind,
> +		.ctx_depth =3D depth,
> +	};
> +	const char *depth_buf;
> +
> +	depth_buf =3D bpf_diag_scratch_buf(env, 2, NULL);
> +	if (depth_buf)
> +		bpf_diag_format_active_context((char *)depth_buf,
> +					       BPF_DIAG_SCRATCH_STR_LEN, depth,
> +					       context);
> +	else
> +		depth_buf =3D "";
> +
> +	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY,
> +			       "operation is not allowed in this context");
> +	bpf_diag_report_reason(env,
> +			       "The operation %s cannot be used while this path is still insi=
de %s. Leave the region before this operation.",
> +			       operation, depth_buf);
> +
> +	bpf_diag_report_section(env, "At");
> +	bpf_diag_report_source(env, insn_idx, "error",
> +			       "%s is not allowed before leaving %s",
> +			       operation, context);
> +
> +	bpf_diag_print_history(env, &opts);
> +
> +	bpf_diag_report_suggestion(env, "%s", suggestion);
> +}
> +
> +void bpf_diag_report_context_underflow(struct bpf_verifier_env *env,
> +				       u32 insn_idx, const char *operation,
> +				       enum bpf_diag_context_kind ctx_kind,
> +				       const char *suggestion)
> +{
> +	struct bpf_diag_history_opts opts =3D {
> +		.scope =3D BPF_DIAG_HISTORY_SCOPE_CONTEXT,
> +		.ctx_kind =3D ctx_kind,
> +	};
> +	const char *context =3D bpf_diag_context_name(ctx_kind);
> +
> +	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY,
> +			       "unmatched context exit");
> +	bpf_diag_report_reason(env,
> +			       "The operation %s tries to leave %s, but this path has no acti=
ve %s to leave. The current depth is 0.",
> +			       operation, context, context);
> +
> +	bpf_diag_report_section(env, "At");
> +	bpf_diag_report_source(env, insn_idx, "error",
> +			       "%s has no matching enter on this path",
> +			       operation);
> +
> +	bpf_diag_print_history(env, &opts);
> +
> +	bpf_diag_report_suggestion(env, "%s", suggestion);
> +}
> +
>  void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 ins=
n_idx,
>  				   int regno, const char *reg_name,
>  				   const char *type_name,
> diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
> index 07d06d366f22..4611d94e7a18 100644
> --- a/kernel/bpf/diagnostics.h
> +++ b/kernel/bpf/diagnostics.h
> @@ -202,6 +202,20 @@ void bpf_diag_report_call_type(struct bpf_verifier_e=
nv *env, u32 insn_idx,
>  			       int argno, int regno, int stack_arg_slot,
>  			       const char *call_name, const char *arg_name,
>  			       const char *reason, const char *suggestion);
> +void bpf_diag_report_execution_context(struct bpf_verifier_env *env,
> +				       u32 insn_idx, const char *operation,
> +				       enum bpf_diag_context_kind ctx_kind,
> +				       const char *context,
> +				       const char *suggestion);
> +void bpf_diag_report_context_still_active(struct bpf_verifier_env *env,
> +					  u32 insn_idx, const char *operation,
> +					  enum bpf_diag_context_kind ctx_kind,
> +					  const char *context,
> +					  const char *suggestion);
> +void bpf_diag_report_context_underflow(struct bpf_verifier_env *env,
> +				       u32 insn_idx, const char *operation,
> +				       enum bpf_diag_context_kind ctx_kind,
> +				       const char *suggestion);

The names are overly long which pushes indent way to far to the right.
Maybe one bpf_diag() helper with enum that multiplexes
"execution context" vs "context still active" vs ...

