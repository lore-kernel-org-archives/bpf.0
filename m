Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603664;
	b=Xj3WNUaQrB1tglUq67hxy5ay5JhIK4qBG35SQBqoEtcTQxDo60oRHGbNH6eay4HiQiSN
	 ZShQ0vYbul4ajCMsx+E9fMeDzouYvc3bAIv+KJRh3SAnoFjjxnUEjOmaQW3UZJQ6YBidz
	 yY1BnhpzGMxd+iB1Aw+7adehRsU0Z1IuwxOYxOn5e05BOGlIPfVynE125jEx7gtkNO4Lu
	 1ab+yaRRcgkxugTlbpvMCcGM2B5nK13B/QBd1p+eB+7tLb2dtDf7hkKCrvnjaO7PeMVWN
	 ti7j+8O225HhauiPR8z2j3AG4VQLr/5SNLOgifVOhHT9ECu/xQBGBUzbuV+BaFj0kBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603664;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=LoZ8PKxsS5Cuca6CVzfLJyL/G7C5lkxMc2Q/nFNVrZI=;
	b=iDwJforxYRWVj+Gc39TnchXP6D2JcAiPpsz3TIRsaAe/Dn7GwgtZSenR4emgCH1kZLR9
	 oDK5r9pSOr1Jp8bwPz6kaCwMuAuDwO/+DzI63nXPg1+7uCT1pVXq04RGyb00SIWeo69HF
	 vhuFQiUFTbv0Kt5pKKWdnrLSDopBdGwZEUtAlJ+S/Gy9llhC83Ck29Mc4zN5aCcNwQHos
	 WuPxvs3SpATA6jTO5q16ewG76UTABN2+8cy+r0oXdu0dz1lnpRPafTzz/NRVKPpQZvEdW
	 sjIjuBZmLerbiuAZXar2MK/T6e1n2B7pmQLTe0gNg/rsahofrkEU8VLTqfNbGai2YTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADe+fDQt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C57606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADe+fDQt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAFF1F000C4;
	Wed, 25 Nov 2026 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795603664;
	bh=LoZ8PKxsS5Cuca6CVzfLJyL/G7C5lkxMc2Q/nFNVrZI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ADe+fDQtjNgcVzd0gPszvAZVVN7Gfa0zTPydNKmb0p0pr65QOQLeM/uWM5+lVkSH2
	 QFIlVu+wy/inv+bUsVSl8jwm70jFNLEL8frWv+3/UAVkwd97B6o8Ww4LTG04OP48bD
	 SoMH2xWWrNVh8AR3KVFK4O9N5KQ6cuVwqc36l2DUQcJrJ32A9QemxIJm99wXyW5ewZ
	 /L0tkpLQV8+wWf6nqHCLvlvM+cgQxhakNeA1ru8ppS0o54ZW+is/P3iPj4KVcMTgbL
	 URbLdzVim1mOU4C6M2iMFBMpXrSDCGPKxbDcO1Sjt1jptBUQPz0zWpmWp8sA7EWF0V
	 q5wVpHxYTgMUQ==
Content-Type: multipart/mixed; boundary="===============2353306263452715233=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9c0a23fb1309d4e2843bcbc1bca80b4c553880ac4e73f19dc63e461829d611fa@mail.kernel.org>
In-Reply-To: <20261125102810.699464-4-a.s.protopopov@gmail.com>
References: <20261125102810.699464-4-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/7] bpf: Allow only NULL or ERR_PTR() from fmod_ret on pointer functions
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,bpf@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 10:47:42 +0000 (UTC)

--===============2353306263452715233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow only NULL or ERR_PTR() from fmod_ret on pointer functions

TL;DR: The new fmod_ret pointer-return check may be bypassed by an freplace
extension of the fmod_ret program's main function, so a non-error pointer like
1 could reach the caller and be dereferenced. Not covered by the selftest.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19762,8 +19764,19 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
>  			*range = retval_range(0, 0);
>  			break;
>  		case BPF_TRACE_RAW_TP:
> -		case BPF_MODIFY_RETURN:
>  			return false;
> +		case BPF_MODIFY_RETURN:
> +			/* An extension replaces a global function of the program */
> +			if (!aux->attach_btf)
> +				return false;
> +
> +			/* Allow only NULL or an error pointer for functions returning pointers */
> +			t = btf_type_skip_modifiers(aux->attach_btf,
> +						    aux->attach_func_proto->type, NULL);
> +			if (!btf_type_is_ptr(t))
> +				return false;
> +			*range = retval_range(-MAX_ERRNO, 0);
> +			break;

Can this restriction be bypassed by an freplace program that replaces the
main function of an fmod_ret program?

An extension verified against an fmod_ret program P gets
resolve_prog_type() == BPF_PROG_TYPE_TRACING and, in
check_attach_btf_id(), expected_attach_type == BPF_MODIFY_RETURN.  Its
aux->attach_btf is NULL because bpf_prog_load() sets dst_prog instead, so
it takes this branch:

    if (!aux->attach_btf)
        return false;

and check_return_code() accepts any R0.  env->fmodret_retvals is also NULL
for an extension, so check_fmodret_retval() does not run either.

The comment assumes the extension replaces a global function whose result
goes back to P, and P's own exit is then checked.  But
bpf_check_attach_target() also lets an extension replace subprog 0 of a
tracing program.  That needs linkage BTF_FUNC_GLOBAL and reliable BTF, for
example:

    long p(unsigned long long *ctx __arg_ctx)

which btf_validate_prog_ctx_type() accepts for BPF_MODIFY_RETURN.  Only
fentry/fexit/fsession targets are refused ("Cannot extend
fentry/fexit/fsession"); BPF_MODIFY_RETURN is not on that list.  At the
end of bpf_check() the extension's expected_attach_type is reset to 0:

    if (env->prog->type == BPF_PROG_TYPE_EXT)
        env->prog->expected_attach_type = 0;

so bpf_tracing_prog_attach() accepts it, and __bpf_trampoline_link_prog()
then pokes a jump at P's bpf_func entry.

For example, P is:

    SEC("fmod_ret/xe_device_create")
    long p(unsigned long long *ctx __arg_ctx) { return 0; }

which passes the new [-4095, 0] check.  E is an freplace of p that does
"return 1;".  With both attached, the xe_device_create() trampoline calls
P's entry, which jumps to E.  E's 1 is non-zero, so the trampoline skips
the function and returns (struct xe_device *)1 to xe_pci_probe().
IS_ERR() does not catch that, and the caller dereferences it.  That is the
case the commit message says it prevents ("The caller of such a function
dereferences what an fmod_ret program returns").

The selftest added later in the series (c210c64e053c "selftests/bpf: Test
fmod_ret on a declared function that returns a pointer") only loads an
extension of the non-main global_func(), so this path is not covered, and
no later commit in the series changes this branch.

Could the range from the target program's attach_btf/attach_func_proto be
applied when an extension replaces subprog 0 of a BPF_MODIFY_RETURN
target, or could replacing the main function of an fmod_ret program be
refused?  The existing fmodret_retvals check has the same extension gap
for int-returning targets.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45595181490
--===============2353306263452715233==--
