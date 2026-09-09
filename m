Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E93515E3
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938017; cv=none; b=QgTz8GyRbXMt704Miia/PCn9YYpfcz8XfXdvhhrIDBs5P35o5gYhP95Up6Lme7PMyarG3PLu9pOdT1pjxO2s3GUlCniSUYMzEXzcEpedUHS8vi0D0QVvrpDwqkcKb4Ph5/EJkfp1jUWx0D8HyJ5aNjHeJMa8aVxfmJLdIYEbo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938017; c=relaxed/simple;
	bh=NLgg3qCDBnW0OjDRab78lIQN9uhD4LUftpDPgf3UZPg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WqEHh/vKXU2DxQETAo5AC2lAXbkgGuX+UsAyq7Tavqo2D3fg82XZMxNVuP6Oo5+qOBo9ZwwbkXLpp530gMl/a6wdNIpEjTW0dsiJ6TXYqjfkVUDnR9XRLfobjwl5/Wyx36bXPLeT8w+kZ4OijGlPy3IBZh0EzO/CkTaol2U1O4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJH3XdH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJH3XdH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE9D1F00A3E;
	Wed,  9 Sep 2026 07:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788938016;
	bh=i4WjLRa1yoJUMTt7ZxyaRbHaH+5dYQzIwF/1tz8C2ts=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kJH3XdH4GuW8zAJPkWPyY3H3O/FzQ3FdJwnMhPxBs/dNVr+/8DwFBNyjJ1MYcfKld
	 G/OnIsnKB9oNt89TQB7VR4n42jJYgXVqDPLAhUtkWaLGaCtShOPQPqYOqrrDJk8+2F
	 P1RrCkOTwtZfZPfcHHDfnije8MXkrbVL/s4bO5GIHm/Dn/OJj+rrXJNVtcXayDZvHG
	 WBEZuqkBaWK5D9m2Q1+wJbi4EKF9pmZDSNFZtFCzAHD5WIWoZ0l+L3vAjfNrbuwEp2
	 Vmwg7wK7/sVPIutF7Hz8AThb6I2DEMVNCmqIAHsEHNiXnpDG9qrNDtYjVVyOp+u0pQ
	 xhHOk22WNpw0A==
Content-Type: multipart/mixed; boundary="===============7662192597639782299=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0a9ac5bad4c131e896916f00fe93d4d7c6accef6711d1ee477969a8a7d330ae9@mail.kernel.org>
In-Reply-To: <20260909062538.4003426-1-yonghong.song@linux.dev>
References: <20260909062538.4003426-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 03/12] bpf: Support by-value struct arguments up to 16 bytes
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 07:13:35 +0000 (UTC)

--===============7662192597639782299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 104a91f5ffd5..4502b888b668 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8125,6 +8125,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  	for (i = 0, slots_used = 0; i < nargs; i++) {
>  		u32 tags = 0;
>
> +		if (slots_used >= MAX_BPF_FUNC_ARGS)
> +			goto too_many_slots;
> +
>  		err = btf_scan_decl_tags(env, btf, fn_t, i, is_global, &tags);
>  		if (err)
>  			return err;

[ ... ]

> @@ -8253,6 +8256,33 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  			sub->args[slots_used++].arg_type = ARG_ANYTHING;
>  			continue;
>  		}
> +		if (btf_type_is_struct(t)) {
> +			u32 nslots;
> +
> +			if (!t->size || t->size > 2 * BPF_REG_SIZE) {
> +				if (!is_global)
> +					return -EINVAL;
> +				bpf_log(log,
> +					"Arg#%d type %s in %s() has size %u, only 1 to %d bytes "
> +					"can be passed by value\n",
> +					i, btf_type_str(t), tname, t->size, 2 * BPF_REG_SIZE);
> +				return -EINVAL;
> +			}
> +			if (!btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
> +				if (!is_global)
> +					return -EINVAL;
> +				bpf_log(log, "Arg#%d type %s in %s() is not composed of scalars\n",
> +					i, btf_type_str(t), tname);
> +				return -EINVAL;
> +			}
> +
> +			nslots = (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
> +			if (slots_used + nslots > MAX_BPF_FUNC_ARGS)
> +				goto too_many_slots;
> +			while (nslots--)
> +				sub->args[slots_used++].arg_type = ARG_ANYTHING;
> +			continue;
> +		}
>  		if (!is_global)
>  			return -EINVAL;
>  		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
> @@ -8260,11 +8290,33 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  		return -EINVAL;
>  	}
>
> +	if (slots_used > MAX_BPF_FUNC_REG_ARGS) {
> +		if (is_global) {
> +			bpf_log(log,
> +				"global function %s() needs %d > %d argument slots, "
> +				"stack args not supported\n",
> +				tname, slots_used, MAX_BPF_FUNC_REG_ARGS);
> +			return -EINVAL;
> +		}
> +		if (!bpf_jit_supports_stack_args()) {
> +			bpf_log(log, "JIT does not support function %s() with %d argument slots\n",
> +				tname, slots_used);
> +			return -EFAULT;
> +		}
> +		sub->stack_arg_cnt = slots_used - MAX_BPF_FUNC_REG_ARGS;
> +	}
>  	sub->arg_cnt = slots_used;

This isn't a bug, but now that slots_used is always >= nargs, is the
pre-loop nargs-based block still needed? Looking earlier in the function:

	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
		if (!bpf_jit_supports_stack_args()) {
			bpf_log(log, "JIT does not support function %s() with %d args\n",
				tname, nargs);
			return -EFAULT;
		}
		sub->stack_arg_cnt = nargs - MAX_BPF_FUNC_REG_ARGS;
	}

	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
		bpf_log(log, "global function %s has %d > %d args, stack args not supported\n",
			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
		return -EINVAL;
	}

The new block above recomputes stack_arg_cnt from slots_used. Since every
parameter consumes at least one slot, whenever nargs > MAX_BPF_FUNC_REG_ARGS,
slots_used > MAX_BPF_FUNC_REG_ARGS as well, so the assignment
`sub->stack_arg_cnt = nargs - MAX_BPF_FUNC_REG_ARGS` in the earlier block
is always overwritten by the new `sub->stack_arg_cnt = slots_used -
MAX_BPF_FUNC_REG_ARGS` assignment.

Also, the two blocks order their tests differently. The earlier block tests
bpf_jit_supports_stack_args() before is_global, while the new block tests
is_global first. On an architecture without stack-arg JIT support, a global
function needing stack args therefore fails with -EFAULT and "JIT does not
support function f() with 6 args" when the sixth slot comes from a sixth
parameter, but with -EINVAL and "global function f() needs 6 > 5 argument
slots, stack args not supported" when it comes from a two-slot struct.

Could this new block be the only place that sets stack_arg_cnt and applies
the global/JIT checks, or does the earlier nargs-based block serve a
purpose I'm missing?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441
--===============7662192597639782299==--
