Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBDE14EC73
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786941763; cv=none; b=r7f7cUqk3ngV3mJcoW78z4EuNo7qa2zqXvr6+gRNnbi1HsI+RBc4ynElODKpg56u7lKrGIZzhnCqh+u3dgcu2BpF/TJn1z5QfpUVuF5uBkO05JLbLh1aGiPoCwQj6DqELqHWWQsbziq9SlsBb2uwsJ2iFJXGTA2S3TPhxuKWhcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786941763; c=relaxed/simple;
	bh=UlguIxTFqiAjAOUiM9Yw7NClEM7ZDcvOildD7bqYx1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AD2x6ksUpCuJvwFb+hVydojob/UENDXT3dObkicTLdSEVgJJASPkTmpAO4OriGtJVd5+SzcFnaL1qNtNMyz86OD9zm5IgGG3wclXomtj4qV7mFp6U4eTkksumbE8G02GJ7JY6lRejwlTAjCfdVccAfvG4VuZgRhEi0EetFsCM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mThiU7Zq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mThiU7Zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADD71F000E9;
	Mon, 17 Aug 2026 04:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786941761;
	bh=subz6u2a2AtitQnOGKTIgrOHFhoUm07cUIZWZxL7st8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mThiU7ZqdYBi5Z5SAXZbDQh99DJwlIbNs4hsDh6SRLg7beROgl7aSD1rEnANa0q3g
	 78AmvFMLp5+617f68f1n/+LS4al2PmR7BpgzNebkL7Zi6uDTBmBoVyYXyd34hH3dVS
	 ApSO/bBtSuA2jJak8YZkaOcqxpsjBJedGCqyiEE0kVQ7CKB0cp1xTW14wenCmqugJA
	 CxlGfn4DX1WXsV/jDm0dwHu7nlKdc0iVTRvyiu9q1a47Fp10f7e1Pj+xq0O4jhiMlY
	 U7bpq+ZYANqg1UH7LXW6YRBWhMzw4+7bmXQA6EZNPAmdhDC1h+2a6Qz2fO43MIzzLO
	 oy6cbMCkxDcAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 07/10] bpf: Enable aggregate return types up
 to 16 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817042217.2294438-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042217.2294438-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 04:42:41 +0000
Message-Id: <20260817044241.BADD71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Attaching a BPF trampoline to a function returning a 16-byte struc=
t silently corrupts the return value because the trampoline fails to preser=
ve the second return register.

Pre-existing issues:
- [Medium] Kfuncs returning structs with padding or sizes that are not a mu=
ltiple of 8 may leak uninitialized kernel memory to BPF programs.
--

--- Patch [7]: [PATCH bpf-next v6 07/10] bpf: Enable aggregate return types=
 up to 16 bytes ---
commit 5c9b0fdbdfee0f07315dc190bc0c039af9bce8bd
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Enable aggregate return types up to 16 bytes
   =20
This commit relaxes the verifier and BTF distillation to accept by-value
struct or union return types up to 16 bytes. These are returned in the
R0:R2 register pair.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7591,7 +7591,7 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
>  		return -EINVAL;
>  	}
>  	ret =3D __get_type_size(btf, func->type, &t);
> -	if (ret < 0 || btf_type_is_struct(t)) {
> +	if (ret < 0 || ret > 16) {

[Severity: High]
By relaxing this check to allow up to 16-byte returns, does this silently
break fentry and freplace programs attached to such functions?

While bpf_check_attach_target() rejects programs if they explicitly use the
trampoline retval:

bpf_check_attach_target() {
    if (tgt_info->fmodel.ret_size > 8 &&
        attach_uses_trampoline_retval(prog->expected_attach_type)) {
        ...
    }
}

It appears to still allow fentry and freplace programs to attach. When a
BPF program attaches to a kernel function returning a 16-byte struct, the
target function returns its value in RAX and RDX (on x86-64).

The BPF trampoline epilogue calls __bpf_tramp_exit(), which clobbers
caller-saved registers like RDX.

If the trampoline only restores RAX from the stack before returning, won't
RDX be left with garbage, corrupting the upper 8 bytes of the original
function's return value?

>  		bpf_log(log,
>  			"The function %s return type %s is unsupported.\n",
>  			tname, btf_type_str(t));

> [ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

> [ ... ]

> @@ -14008,7 +14008,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  		 * otherwise a pointer field would be laundered into a scalar
>  		 * and escape provenance and reference tracking.
>  		 */
> -		if (!__btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
> +		if (!btf_type_is_scalar_struct(env, desc_btf, t, 0)) {

[Severity: Medium]
This isn't a bug introduced by this patch, but since the scope of by-value
returns is expanded from 8 bytes to 16 bytes, it might be worth verifying.

In check_kfunc_call(), the verifier immediately calls mark_kfunc_ret_regs()
after this check:

check_kfunc_call() {
    if (!btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
        ...
        return -EINVAL;
    }
    mark_kfunc_ret_regs(env, regs, t->size);
}

If a kfunc returns a struct containing padding bytes, the C compiler might
leave those padding bytes uninitialized. Since the verifier marks the entire
return registers as fully initialized scalars, could this allow a BPF
program to read uninitialized kernel memory via the padding bytes?

>  			verbose(env,
>  				"kernel function %s returns %s %s that is not composed of scalars\n",
>  				func_name, btf_type_str(t),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817042141.2286=
086-1-yonghong.song@linux.dev?part=3D7
