Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2A3D3D1D
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122202; cv=none; b=dUNZUOwQKTQXZ3IGbuNlBrE3YXpsrwWqY5IecSwRd4n/waSHn1u/PW4aBgVBOyDKoV+lfv/1RoUiaAkL5Td8K40HZy3i4MaStd3X7lgWsldC+0wlCeBrMHoz7ugOJ1LxDqSpHxVcib0YgVJA9DLQChbRay7LV/bU23QoT9veoaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122202; c=relaxed/simple;
	bh=NrFbnjL3f2+USKzsZrl51MdvDfYivpHbjSGA3Pr2dX0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IjszmH6YrUl7oLgHDb0LqlZbR2BejVldVD2+OMCe1cCqUOZ8/sM0zBAE6uMNDbOfHFy11eZ1+Ngq2m5gGS1QWxVsfS7cwNdTNQRlbQNPWPlO/GdcbycUm0tpfNIC72uRutd8SxpaGu7oDqmGrXd4mYO5LPiStgGNTnkSOprOfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K00ptj0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K00ptj0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2981A1F000E9;
	Wed, 19 Aug 2026 06:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787122201;
	bh=8jNyVv4lz+/pUBbwTEcM38+UCDMlqN6NRN8ccuG/XmY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K00ptj0+IcIEZyZT8DxyM5gV5ElNKZz/4/uHd2kLV4fOj4o1ZM8BAY+P1cv5f6KuQ
	 fP6YomaL+vZT2hOB1RyVa5W2QvntLbGcvlIUmixh23lP8FXKP4jxggoDvD2e7LMm/o
	 H9fNCpkw/70xo+xwNA7tfGc/AWsTvMGsLipb4v/G9jICHiAhGYSHngY68UrvlVsuie
	 jf5OzAMhiRPu5ZL3eHtoyQMMnmCpnfvXnWZY2hiXTCTVh1OaHT761KCaTGsfj6rJCs
	 Ew1l36sWeTkILZ2BtKTGiMYTKNQbWqFL2lS5T8uZQcq32HuRI38tJOtqmpmzGhwMBe
	 j0ROzPG/7Flww==
Content-Type: multipart/mixed; boundary="===============6948105419309461492=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96066402806a298adc4f6c068695e3d79b3157cf141fd243a54413de855f1d16@mail.kernel.org>
In-Reply-To: <20260819055314.3298664-1-yonghong.song@linux.dev>
References: <20260819055314.3298664-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v7 07/10] bpf: Enable aggregate return types up to 16 bytes
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Aug 2026 06:50:01 +0000 (UTC)

--===============6948105419309461492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 953d8191563a..004b06785521 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1488,6 +1488,8 @@ int bpf_jmp_offset(struct bpf_insn *insn);
>  struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
>  void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
>  bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
> +bool btf_type_is_scalar_struct(struct bpf_verifier_env *env, const struct btf *btf,
> +			       const struct btf_type *t, int rec);
>
>  int bpf_find_subprog(struct bpf_verifier_env *env, int off);
>  bool bpf_is_throw_kfunc(struct bpf_insn *insn);

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 5e9f6a487524..58b81c6f5288 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -7970,7 +7970,7 @@ static int btf_scan_type_tags(struct bpf_verifier_env *env,
>
>  /* Check whether the type is a valid return type. */
>  static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *btf,
> -		const struct btf_type *t, int subprog)
> +		const struct btf_type *t, int subprog, bool is_global)
>  {
>  	u32 tags = 0;
>  	int err;
> @@ -7993,6 +7993,19 @@ static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *bt
>  	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
>  		return 0;
>
> +	if (btf_type_is_struct(t) && t->size <= 16) {
> +		/*
> +		 * A global function's caller models the return as an opaque
> +		 * scalar pair, so it may only return scalars by value. A local
> +		 * function is verified inline, so a pointer field stays tracked
> +		 * and needs no such restriction.
> +		 */
> +		bool local_func = subprog && !is_global;
> +
> +		if (local_func || btf_type_is_scalar_struct(env, btf, t, 0))
> +			return 0;
> +	}
> +
>  	return -EOPNOTSUPP;
>  }

Does this code reject enum64-valued fields in scalar structs?

Nine lines above, btf_is_any_enum(t) accepts a bare BTF_KIND_ENUM64
return value as a scalar. However, btf_type_is_scalar_struct() calls
btf_type_is_scalar() (include/linux/btf.h:361), which only matches
btf_type_is_int() or btf_type_is_enum(). The latter
(include/linux/btf.h:286) covers BTF_KIND_ENUM only, while
BTF_KIND_ENUM64 requires btf_is_any_enum() (include/linux/btf.h:291).

This means a bare 'return enum64_t' passes the bare-scalar branch above,
but 'return struct { enum64_t e; }' - a struct of one scalar - fails the
scalar-struct test and gets rejected with -EOPNOTSUPP.

The commit message describes 'a struct or union up to 8 bytes, returned
in R0 alone', and the series documentation (7ba16e29a69f) says the
aggregate 'must be composed only of scalars (recursively), where a scalar
is an integer or an enum', so enum64 members appear to be intended.

The same gap affects kfuncs: check_kfunc_call() gates struct returns
on btf_type_is_scalar_struct() as well and logs 'returns %s %s that
is not composed of scalars'.

Could btf_type_is_scalar() be updated to include btf_is_any_enum(), or
should these two call sites use a different helper?

>
> @@ -8080,12 +8093,12 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  		return -EINVAL;
>  	}
>
> -	err = btf_validate_return_type(env, btf, t, subprog);
> +	err = btf_validate_return_type(env, btf, t, subprog, is_global);
>  	if (err) {
>  		if (is_global) {
>  			bpf_log(log,
> -				"Global function %s() return value not void or scalar. "
> -				"Only those are supported.\n",
> +				"Global function %s() has unsupported return type. "
> +				"Only void, scalar, or a scalar-only struct/union up to 16 bytes is supported.\n",
>  				tname);
>  		}
>  		return err;

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d79f0c069795..7a939dfa3797 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
> index ac44d60e5066..9708efb93683 100644
> --- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
> +++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
> @@ -60,7 +60,7 @@ __noinline int exception_cb_ok_arg_small(int a)
>
>  SEC("?tc")
>  __exception_cb(exception_cb_bad_ret_type1)
> -__failure __msg("Global function exception_cb_bad_ret_type1() return value not void or scalar.")
> +__failure __msg("Only void, scalar, or a scalar-only struct/union up to 16 bytes is supported.")
>  int reject_exception_cb_type_1(struct __sk_buff *ctx)
>  {
>  	bpf_throw(0);

Does this updated expectation still pin the function being tested?

The old assertion string included both the function name and the specific
reason: 'Global function exception_cb_bad_ret_type1() return value not
void or scalar.' The replacement now matches only the generic second
sentence of the message, which contains no function name.

This means the test now passes if the verifier logs an unsupported return
type error for any global function in the object, not specifically
exception_cb_bad_ret_type1().

The new bpf_log() message at btf.c:8099-8102 still interpolates the name
('Global function %s() has unsupported return type'), so a more specific
assertion form was available:

  __msg("Global function exception_cb_bad_ret_type1() has unsupported return type")

The later selftest commit in this series (8b8a84ddcc3e, selftests/bpf: Add
tests for aggregate return values) does keep the function name in its
equivalent expectations.

Could this test retain the function name in the assertion to avoid
matching unrelated failures?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32221968339
--===============6948105419309461492==--
