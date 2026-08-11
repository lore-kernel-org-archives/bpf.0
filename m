Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DAE3815E6
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411494; cv=none; b=hWT73LXgzIl79J5oaxtDfpYMPapDVRrpGApv7/H2GIaDEBoQxcx1zOn1jjwYgCbIijyg9mDmrI6CDq3K0MW5GafSgQqs4/3niH91QIWdIS6MYT1mW9Puvtmf7iAdD0wUAQYEs09qhHkHClZ4QRWS48zEl+C2z0jVMEMAx49fqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411494; c=relaxed/simple;
	bh=1f5ftdSj8FA+bLjM+VG8qBqCm9pKFYN2qrKV+7qhlyM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Dn8cv+hQ7YkPoAWsT+3fwSQWdkcW6j4dayXDEFWhW6XCjZ65UJmDSxsdz712upY6xufkip3OIEmmLy/qFBe4SCiyntaRCuS/0AI7YYBNHdEcf6uyQqjJAFFDQlTsXsAEvWC8/1rU2ljZD3Q8SBEgegaUY+1H0tigLt4Kek0SVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgHFZ3L3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgHFZ3L3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF621F00A3A;
	Tue, 11 Aug 2026 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411492;
	bh=7yZGXTC9XcHCrV+8YLJlk78Jb4KIF/Sh9XhVawmIh4o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MgHFZ3L3iZHikjCOpc8BgYTWPdh1lzUe99Co4Zl7Xj8gM4+ff5xaTsx/x8gpgHozf
	 cvx8TjwuWP78RiBsE70o/h2odyb2Gf80Hh2DUGBdjicsb7bTehcSVRUsX0KFXq1KCH
	 m/csOOsdh8pnULdQKKfZf2Cf6j+zoXaFm3ydaOEhGvlinRFJ3461mcaK271GzDbmGG
	 AvmOpse69jm5FKV4VSPEfOYuvSKLFrLmPFtvA4BX4Rx8lxkxaWYX7zMqjsepsInfoa
	 Ml/+kOV5y2afd6HIaYJodz5NI88xVDpFoInNll+kYTFMPy/jSUOyrDUEOcJ05u5jxo
	 G5GNKpSs4DUdw==
Content-Type: multipart/mixed; boundary="===============3004884587713306637=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e9d300a2448796c238e4f3b84d45e7abdbb5fcda4f4912fd3361437836bcd27d@mail.kernel.org>
In-Reply-To: <20260811000957.2382783-1-yonghong.song@linux.dev>
References: <20260811000957.2382783-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 09/13] bpf: Enable aggregate return types up to 16 bytes
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 01:24:51 +0000 (UTC)

--===============3004884587713306637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>8 bytes, R0 alone for <=8 bytes), enabling the R0:R2 register-pair return
convention end-to-end.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6606187ed4f43..5551abcea1d39 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -7965,7 +7970,7 @@ static int btf_scan_type_tags(struct bpf_verifier_env *env,
>
>  /* Check whether the type is a valid return type. */
>  static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *btf,
> -		const struct btf_type *t, int subprog)
> +		const struct btf_type *t, int subprog, bool is_global)
>  {
>  	u32 tags = 0;
>  	int err;
> @@ -7988,6 +7993,35 @@ static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *bt
>  	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
>  		return 0;
>
> +	if (btf_type_is_struct(t) && t->size <= 16) {
> +		/*
> +		 * A >8 byte struct/union is returned in the R0:R2 register pair.
> +		 * A global function is verified in isolation, so its caller models
> +		 * the return as an opaque R0:R2 scalar pair; it must therefore
> +		 * contain only scalars, otherwise a pointer field would be
> +		 * laundered into a scalar and escape provenance and reference
> +		 * tracking. That requirement is enforced here: do_check_common()
> +		 * propagates the error for global functions and for the main
> +		 * program.
> +		 *
> +		 * A local (static) function is verified inline and its R0:R2 are
> +		 * copied as precise register state (with the JIT forced on when
> +		 * the pair is consumed), so a pointer field stays tracked and needs
> +		 * no such restriction. Accepting it here is not by itself what
> +		 * makes it legal: btf_check_subprog_call() drops any error other
> +		 * than -EFAULT. What it avoids is needlessly marking the
> +		 * subprogram's BTF unreliable.
> +		 *
> +		 * The main program (subprog 0) takes the scalar-only path as well,
> +		 * but its return value is the program's exit code, so a >8 byte
> +		 * return is rejected separately at BPF_EXIT.
> +		 */
> +		bool local_func = subprog && !is_global;
> +
> +		if (local_func || __btf_type_is_scalar_struct(env, btf, t, 0))
> +			return 0;
> +	}
> +
>  	return -EOPNOTSUPP;
>  }

Does the comment accurately describe the enforcement mechanism?

The comment states "do_check_common() propagates the error for global
functions and for the main program." That's true for global functions but
appears incorrect for the main program. Looking at do_check_common() in
kernel/bpf/verifier.c:18624:

  if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
          ...
          ret = btf_prepare_func_args(env, subprog);
          if (ret)
                  goto out;            /* <- error propagated */
  } else {
          if (env->prog->aux->func_info_aux) {
                  ret = btf_prepare_func_args(env, 0);
                  if (ret || sub->arg_cnt != 1 || ...) {
                          env->prog->aux->func_info_aux[0].unreliable = true;
                          ...
                  }
          }
          ...
  }
  ret = do_check(env);

The main-program arm (subprog 0 of a non-EXT program) uses the return
value only to set func_info_aux[0].unreliable, then unconditionally
overwrites ret with do_check(env). The -EOPNOTSUPP from
btf_validate_return_type() is therefore discarded.

Concretely: a program whose entry function returns a pointer-containing
struct like 'struct { void *p; }' (size 8) now takes the new struct
branch, fails __btf_type_is_scalar_struct(), but the resulting error is
silently dropped. The program continues to be verified.

No memory-safety hole results: check_return_code() still refuses a pointer
in R0 at exit ('R0 leaks addr as return value'), so the pointer-laundering
scenario the comment worries about does not actually occur for the main
program. The issue is that the comment states an enforcement mechanism that
does not exist.

Should the comment drop "and for the main program" and point at the
BPF_EXIT check instead?

Also: "btf_check_subprog_call() drops any error other than -EFAULT" is
slightly inaccurate. btf_check_subprog_call() actually returns the error
and marks the BTF unreliable; its callers, check_func_call() and
push_callback_call(), do 'if (err == -EFAULT) return err;' and otherwise
continue.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762
--===============3004884587713306637==--
