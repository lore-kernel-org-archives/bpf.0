Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683DB47D94F
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177556; cv=none; b=Z0LAsSeUrJ4qPT0CLx2lSLSHFUrX5zBYZPcxu7AxcfwdK891fdbeG0Ky2h7Mkdy56HyEoB0cvRfQCqAcLPfUxsefccmklqQcsC8BMI0ewNbKJloHSCYzVSuNs9Pdl/cx1dNzLgJ8GcIV/PzQrb1rDzazEtWCHe7q2WHjDOMmKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177556; c=relaxed/simple;
	bh=Q2kodTU5vBpw6j+/Rjf9PtrGvFKhBbtnyw1FFs6X2CE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rnMThSl56uCMiXfteInz6jwgjVno7HDq8xk1IHpKvq86tmT2Zb3ewuePyku+0VLSs5skHUgJFbkAVW0D9ZJ2Lv0NT4x4liuUAZp59QCMVznkhDYJszSBCpyr0fBGQ65oZTkBB0vjeHs6sZHJU6suaHx99WemzfR1B2MRFnDk4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJai5jIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJai5jIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EC31F000C4;
	Fri, 16 Oct 2026 19:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792177554;
	bh=sYm3pZcMhO/0sgaLbmAO4197rh44QwcgxYTJfkQvYXI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PJai5jIMzbVqUjtp7PHpEeKeGqWY5YGClXauCu5FxSkiSg/0H3ArBxi4mZfZW4MxG
	 tXtIElLUvlQCEabsHUIjaAgm6kawHgzU4STzOgHZxajDN6OaqwQC0dZP7LG9gDY0TO
	 d/LAGHO8clCiBtlUxgezshmcPZt/SqWmZSPOw01quVM+p2Y4l9R0E8ZlZwGubwxSIq
	 2o5JrVm0Fd9+0Lwt5KK+hxNTKr6NNNlT2YgqVlG53XagYJu8ydDFiyarq8ucaM7gNs
	 OjbHVSVUM8nlWnzcrBXqFa4IJWKe/jii+DXwtecjxDAe5KzPkQQ3Akf/JNkvh7Vj1d
	 hdVda4vcST0Dg==
Content-Type: multipart/mixed; boundary="===============0774537610665445960=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d13fcbebacd694eee5162af39074858a9b94572b01d0ee8bbb4e86c5f83dc29f@mail.kernel.org>
In-Reply-To: <20261016183120.1136008-1-yonghong.song@linux.dev>
References: <20261016183120.1136008-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 8/9] bpf: Refuse a trampoline on an unreliable static function with stack args
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 19:05:52 +0000 (UTC)

--===============0774537610665445960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Refuse a trampoline on an unreliable static function with stack args

TL;DR: check_unreliable_func_args() may wrongly allow a trampoline on a static
function with stack args when btf_distill_func_proto() fails on a void-typedef
return type; the stack arg is then not saved, so the function may read
garbage.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -22032,6 +22032,33 @@ static int flatten_bpf_func_model(struct bpf_verifier_log *log, const char *tnam
>  	return 0;
>  }
>
> +/*
> + * The verifier lets a static function use stack arguments counted from its
> + * BTF, even if that BTF turns out unreliable. A trampoline on the function is
> + * then given only MAX_BPF_FUNC_REG_ARGS u64 arguments and would lose the
> + * stack arguments, so such a function cannot be attached to.
> + */
> +static int check_unreliable_func_args(struct bpf_verifier_log *log, struct btf *btf,
> +				      const struct btf_type *func_proto, const char *tname)
> +{
> +	struct btf_func_model m;
> +	u32 i, nslots = 0;
> +
> +	if (btf_distill_func_proto(NULL, btf, func_proto, tname, &m)) {
> +		/* at least a slot for each argument */
> +		nslots = btf_type_vlen(func_proto);
> +	} else {
> +		for (i = 0; i < m.nr_args; i++)
> +			nslots += btf_func_model_arg_slots(&m, i);
> +	}
> +	if (nslots <= MAX_BPF_FUNC_REG_ARGS)
> +		return 0;

When btf_distill_func_proto() fails, nslots is set to
btf_type_vlen(func_proto), one slot per BTF parameter.  That is only a lower
bound.  Can it come out at or below MAX_BPF_FUNC_REG_ARGS while the verifier
has already let the function read stack arguments, so that this check passes
in the case it is meant to refuse?

The fallback is exact only if btf_prepare_func_args() also failed.  In that
case sub->arg_slot_cnt keeps the early assignment "sub->arg_slot_cnt = nargs"
and bpf_in_stack_arg_cnt() is nargs - 5.

But btf_distill_func_proto() can fail on the return type while
btf_prepare_func_args() succeeds:

btf_validate_return_type() calls btf_type_skip_modifiers() and accepts the
result when btf_type_is_void() is true, so "typedef void VOID;" or a "const
void" return is accepted.  BTF allows these, see the "typedef void new_void"
and "const void" comment in btf_modifier_resolve().

__get_type_size() follows the modifier to &btf_void.  That is not a ptr, int,
enum or struct, so it returns -EINVAL and btf_distill_func_proto() fails with
"return type ... is unsupported".

For example, take:

    static VOID f(u64 a, u64 b, u64 c, __int128 d, void *ctx)

It has 5 BTF params and 6 slots.  btf_prepare_func_args() succeeds with
arg_slot_cnt = 6 and stack_arg_cnt = 1, and ctx is passed in stack slot 6 (r9
on x86-64, x5 on arm64).  Its BTF can still become unreliable at a call site,
when btf_check_func_arg_match() sees a NOT_INIT register or check_func_args()
fails, and btf_check_subprog_call() then sets unreliable.  Then:

    check_unreliable_func_args()
      btf_distill_func_proto() fails on the return type
      nslots = btf_type_vlen() = 5 -> return 0
    bpf_check_attach_target()
      t = NULL -> five u64 args

The trampoline saves and restores only five registers.  After an fentry
program, r9 (x86-64) or x5 (arm64) holds whatever __bpf_prog_exit() left
there, and the function goes on to use a verifier-checked PTR_TO_CTX read from
r11+8.  This is the failure the commit message describes.

The reachable case is narrow: a modifier-to-void return, a 16-byte by-value
argument that pushes the slot count past 5 with no more than 5 BTF params, and
BTF made unreliable at a call site rather than by btf_prepare_func_args().
Still, the commit message says "Refuse the attach when such a function has
more argument slots in its BTF than fit in registers", and this function has
6 slots in its BTF.

Could the parameter slots be counted without depending on the return-type
check, for example by resolving each parameter's size directly?
Alternatively, could the fallback be made conservative?

No later commit in the series (c37eb84cc571..f0acfc8c0bf7) changes this
function.  f0acfc8c0bf7 ("selftests/bpf: Test trampolines on more BPF
functions with stack args") only covers the plain-pointer case, where
btf_prepare_func_args() fails.

> +
> +	bpf_log(log, "Cannot attach to static function %s: unreliable BTF and stack arguments\n",
> +		tname);
> +	return -EINVAL;
> +}
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38949342365
--===============0774537610665445960==--
