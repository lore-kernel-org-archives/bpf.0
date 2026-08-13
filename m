Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9404A3B9D84
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651976; cv=none; b=g6nMPRIL2gd6VRsBwzUdNeJYO53L8RyRrhIEw7WEhKE8acNo+LnnLm1ib1xTl0wJDSbiVZzSQ9IvilZ/1NOdUf4Jqfy3RU+nclC/JVMdoebKc5NTl/Z9nDB7o8x+0McMQxHCe3kcVhfv5aBRnOkGnDrULeEIFZdzYF8O0QQUTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651976; c=relaxed/simple;
	bh=Tzo0/k0WkV47M6YjkgSuvw/3N5e5j57t1VF8EzhgTvc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=krD7NbPoUpHwrVT5KrBiwyi11ygqBhVfLUoJNXnG5Qx3Z/N51HmBjcS5ucuUjIHY0X1vckzYb63vXF3WYN3+LNErRsuEGIHxlcAFo+dt466J+4WOGV+4KMJnMaUJFy0T2DFBrvy8s3t7DupNL/CR38d/UYoWew4pEfsWVs7Jbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAbBEcUM; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAbBEcUM"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbf0dc8c871so5976a12.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651974; x=1787256774; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QftxtEWJ91qdgUOtKz6xGR/ogD3RRKOkcAYhSfKw7o4=;
        b=HAbBEcUMJnSC0pj5ftAl2aekM6QwXsxOSse16FgzxnIF22rKtWMuGxCahiDVq6BiNO
         IZru+vkxKygA4q7/+95M8MRTv9OizaJnk/pP04C7CYLCsV1PEOf/zasyICoCGTNhgQAD
         CSpuW74ayskSiXpqxkVY+P5vnKAMVqOlS0GxrauARlHCJCtS8UOBBy/e7ao0ksucLCJG
         4gtwT++a29SB7T1RU+8CBfmGe9W+QLqY7EIAP/hS8pa+EYovNAdHGKwbd1tBCheAn/RN
         7t2O3LeuIRmVgQBJUW7AMPGHW2Wk3YzRO/ssSzxOOY7CRkZoTVfGyjbBoyiDBr4txHLN
         dNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651974; x=1787256774;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QftxtEWJ91qdgUOtKz6xGR/ogD3RRKOkcAYhSfKw7o4=;
        b=PXsMpD/KPVFpfDF5VZQHvPmMLF5iNL+cdRXyE5kzBNKQzJJKSBF9y/bALrCzyR3TXi
         Zx06iV0og1rE0BqC3bxO0V+LDaIA0tyvnqAOh9HAPKFKpRoOFkWCcdHM1HW1sxImQnjM
         C/T8/kcLrNtM5N5orwCIhg6Ke+KR2mCz6mVGapfJyGmwBwRaA+WTVy+SmabUb6YbtjN4
         JNPEkDYQzJQGGuFkL6nqI3TpJwBOBqY0pRzmQ40LvSzkDMTgvTpo8uozA8hXX/zrOHAJ
         q2ulYlXuMODic56ZJ2fJvG8xIV08hlAC0sLYlhJm5EvGtrn5yZgyjBDFPegkdynW92WR
         doHA==
X-Forwarded-Encrypted: i=1; AHgh+Rqg9mgS6L8JR9eQ/lctLMxwYIHlHB4MRW2bA38g1ziL8fMJV4BUU8oVLbxXE3oqXYdILBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5zlVg8iqeYI4mgZftYnexGexhrGpa/Ft7d3oZYEAhEW8sDwRm
	O9xUAN2AWY0K6hRJFZULysStf8htftBD8AckNoSgmIglaCsW8nwhMsdtUi8xfeNl
X-Gm-Gg: AR+sD116uGIhEXT7yH35AKhatcHzUomoI5LIVutFr0VDnpwYMyNswZaqk6RO7JaP/+z
	laRHaPbIkM/Sf6U7ZBDNvVE40jIK8oinbM6YXVdIlsrua7Iu3Dn7mgEqaH9DN9pprrqGqXcPYVs
	hzsfpuvSVNVrggcA+eM/ReZKeNrnsSt8PUaGFYCxN+joLJv/EJtb3mTZ1k4hhDdDk/s8hbQU+jU
	e88f9HtYPpre8TP3Tp9ZbUhpUIyM/trQL9BtPIDWNI7QmuUteXQdBJtzSCD3gAB8EojTfZBX46d
	0j+pIxFRMBoxd14795HLgLMkZyV76tofBTaWNV8I8fovLhBvYFFEHU6lOQsurEipyHpl6yNRUGl
	p+dkikudYwBP6yxhKAXP9oTkcbKh5FCOeuoo6uaWB92W/a8oT5SALR3ZSH/pZWWwckrHZ1dlzFi
	6xQAeEVx5MxaxmnJIr1pGOu6Vdk5IJZPTzu6kx1YlaY/aGCk9ReLau/86FuXsTwiKCLVuInVLkG
	bsT8RerYVELIS/G18/Kwbqag94lEfhvp/cs8mU0joJSOg==
X-Received: by 2002:a05:6a20:7346:b0:3bf:6ac8:8d29 with SMTP id adf61e73a8af0-3cc71c95248mr331709637.21.1786651973743;
        Thu, 13 Aug 2026 13:12:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141388b2554sm1495782c88.14.2026.08.13.13.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 13:12:53 -0700 (PDT)
Message-ID: <c00f047ad3ac99f0e09516da24b39cd4e6a8c771.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 12/16] bpf: Report Execution Context Safety
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 13 Aug 2026 13:12:51 -0700
In-Reply-To: <20260812233326.3575958-13-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
	 <20260812233326.3575958-13-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:

...

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c

...

+void bpf_diag_ctx(struct bpf_verifier_env *env, enum bpf_diag_ctx_report r=
eport, u32 insn_idx,
+		  const char *operation, enum bpf_diag_context_kind ctx_kind, const char=
 *context,
+		  const char *suggestion)

Nit: expose diag_ctx_{forbidden,active,underflow} and drop this function an=
d enum?

+{
+	switch (report) {
+	case BPF_DIAG_CTX_FORBIDDEN:
+		diag_ctx_forbidden(env, insn_idx, operation, ctx_kind, context,
+				   diag_context_constraint(ctx_kind), suggestion);
+		return;
+	case BPF_DIAG_CTX_ACTIVE:
+		diag_ctx_active(env, insn_idx, operation, ctx_kind, context, suggestion)=
;
+		return;
+	case BPF_DIAG_CTX_UNDERFLOW:
+		diag_ctx_underflow(env, insn_idx, operation, ctx_kind, suggestion);
+		return;
+	}
+}

...

> @@ -2005,23 +2174,6 @@ static void diag_print_ref_event(struct bpf_verifi=
er_env *env,
>  			       event->ref.ref_id);
>  }
> =20
> -static const char *diag_context_name(enum bpf_diag_context_kind kind)
> -{
> -	switch (kind) {
> -	case BPF_DIAG_CONTEXT_RCU:
> -		return "RCU read lock region";
> -	case BPF_DIAG_CONTEXT_PREEMPT:
> -		return "non-preemptible region";
> -	case BPF_DIAG_CONTEXT_IRQ:
> -		return "IRQ-disabled region";
> -	case BPF_DIAG_CONTEXT_LOCK:
> -		return "lock region";
> -	case BPF_DIAG_CONTEXT_NONE:
> -	default:
> -		return "context";
> -	}
> -}

Nit: the move is churn.

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7e28f4d9f5c4..71893c36ecce 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

...

> @@ -1104,9 +1106,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_ve=
rifier_env *env, struct bpf_r
>  	st =3D &slot->spilled_ptr;
> =20
>  	if (st->irq.kfunc_class !=3D kfunc_class) {
> -		const char *fmt =3D "This IRQ flag was saved by %s IRQ kfuncs, but the=
 restore call "
> -				  "belongs to the %s IRQ kfunc family. Save and restore operations "
> -				  "must use the same family.";
> +		const char *fmt =3D "This IRQ flag was saved by %s IRQ kfuncs, but the=
 restore call belongs to the %s IRQ kfunc family. Save and restore operatio=
ns must use the same family.";

Churn.

>  		const char *flag_kfunc =3D st->irq.kfunc_class =3D=3D IRQ_NATIVE_KFUNC=
 ? "native" :
>  										   "lock";
>  		const char *used_kfunc =3D kfunc_class =3D=3D IRQ_NATIVE_KFUNC ? "nati=
ve" : "lock";
> @@ -1115,10 +1115,10 @@ static int unmark_stack_slot_irq_flag(struct bpf_=
verifier_env *env, struct bpf_r
>  		verbose(env, "irq flag acquired by %s kfuncs cannot be restored with %=
s kfuncs\n",
>  			flag_kfunc, used_kfunc);
>  		reason =3D bpf_diag_fmt(env, fmt, flag_kfunc, used_kfunc);
> -		bpf_diag_irq(env, env->insn_idx, "IRQ flag restore mismatch", reason,
> -			     "Restore the flag with the matching IRQ restore kfunc for the sa=
ve "
> -			     "operation that created it.",
> -			     bpf_diag_irq_depth(env->cur_state));
> +		bpf_diag_irq(
> +			env, env->insn_idx, "IRQ flag restore mismatch", reason,
> +			"Restore the flag with the matching IRQ restore kfunc for the save op=
eration that created it.",
> +			bpf_diag_irq_depth(env->cur_state));

Churn.

>  		return -EINVAL;
>  	}
> =20
> @@ -1136,11 +1136,11 @@ static int unmark_stack_slot_irq_flag(struct bpf_=
verifier_env *env, struct bpf_r
> =20
>  		verbose(env, "cannot restore irq state out of order, expected id=3D%d =
acquired at insn_idx=3D%d\n",
>  			env->cur_state->active_irq_id, insn_idx);
> -		bpf_diag_irq(env, env->insn_idx, "IRQ flag restore out of order",
> -			     "IRQ-disabled regions must be restored in last-in, first-out ord=
er, "
> -			     "but this restore does not match the currently active IRQ flag."=
,
> -			     "Restore nested IRQ flags in the reverse order they were saved."=
,
> -			     bpf_diag_irq_depth(env->cur_state));
> +		bpf_diag_irq(
> +			env, env->insn_idx, "IRQ flag restore out of order",
> +			"IRQ-disabled regions must be restored in last-in, first-out order, b=
ut this restore does not match the currently active IRQ flag.",
> +			"Restore nested IRQ flags in the reverse order they were saved.",
> +			bpf_diag_irq_depth(env->cur_state));
>  		return err;

Churn.

>  	}
> =20

...

> @@ -10551,6 +10578,36 @@ static const char *non_sleepable_context_descrip=
tion(struct bpf_verifier_env *en
>  	return "non-sleepable prog";
>  }
> =20
> +static enum bpf_diag_context_kind non_sleepable_context_kind(struct bpf_=
verifier_env *env)
> +{
> +	if (env->cur_state->active_rcu_locks)
> +		return BPF_DIAG_CONTEXT_RCU;
> +	if (env->cur_state->active_preempt_locks)
> +		return BPF_DIAG_CONTEXT_PREEMPT;
> +	if (env->cur_state->active_irq_id)
> +		return BPF_DIAG_CONTEXT_IRQ;
> +	if (env->cur_state->active_locks)
> +		return BPF_DIAG_CONTEXT_LOCK;
> +	return BPF_DIAG_CONTEXT_NONE;
> +}
> +
> +static const char *non_sleepable_context_diag_description(struct bpf_ver=
ifier_env *env)

Drop the BPF_DIAG_CONTEXT_RCU & Co and use `const char *`?

> +{
> +	switch (non_sleepable_context_kind(env)) {
> +	case BPF_DIAG_CONTEXT_RCU:
> +		return "RCU read lock region";
> +	case BPF_DIAG_CONTEXT_PREEMPT:
> +		return "non-preemptible region";
> +	case BPF_DIAG_CONTEXT_IRQ:
> +		return "IRQ-disabled region";
> +	case BPF_DIAG_CONTEXT_LOCK:
> +		return "lock region";
> +	case BPF_DIAG_CONTEXT_NONE:
> +	default:
> +		return "non-sleepable program";
> +	}
> +}
> +
>  static int release_reg(struct bpf_verifier_env *env, struct bpf_reg_stat=
e *reg,
>  		       bool convert_rcu, bool release_dynptr)
>  {

...

> @@ -11919,12 +11983,10 @@ static int process_irq_flag(struct bpf_verifier=
_env *env, struct bpf_reg_state *
>  		if (!is_irq_flag_reg_valid_uninit(env, reg)) {
>  			verbose(env, "expected uninitialized irq flag as %s\n",
>  				reg_arg_name(env, argno));
> -			bpf_diag_res(env, env->insn_idx, "IRQ flag is already initialized",
> -				     "Saving IRQ state requires an uninitialized stack slot for "
> -				     "the IRQ flag, but this slot already contains tracked IRQ "
> -				     "flag state.",
> -				     "Use a fresh stack slot for this save operation, or restore "
> -				     "the existing IRQ flag before reusing the slot.");
> +			bpf_diag_res(
> +				env, env->insn_idx, "IRQ flag is already initialized",
> +				"Saving IRQ state requires an uninitialized stack slot for the IRQ f=
lag, but this slot already contains tracked IRQ flag state.",
> +				"Use a fresh stack slot for this save operation, or restore the exis=
ting IRQ flag before reusing the slot.");

Churn.

>  			return -EINVAL;
>  		}
> =20
> @@ -11941,11 +12003,10 @@ static int process_irq_flag(struct bpf_verifier=
_env *env, struct bpf_reg_state *
>  		if (err) {
>  			verbose(env, "expected an initialized irq flag as %s\n",
>  				reg_arg_name(env, argno));
> -			bpf_diag_res(env, env->insn_idx, "uninitialized IRQ flag restore",
> -				     "Restoring IRQ state requires a stack slot that was "
> -				     "initialized by a matching IRQ save operation on this path.",
> -				     "Pass the same stack slot that was previously initialized by "
> -				     "the matching IRQ save kfunc.");
> +			bpf_diag_res(
> +				env, env->insn_idx, "uninitialized IRQ flag restore",
> +				"Restoring IRQ state requires a stack slot that was initialized by a=
 matching IRQ save operation on this path.",
> +				"Pass the same stack slot that was previously initialized by the mat=
ching IRQ save kfunc.");
>  			return err;

Churn.

...
