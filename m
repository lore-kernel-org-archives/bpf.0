Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515D40BCA1
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901210; cv=none; b=V55gknWf1ZV7U5MUheJgvKE+ENuHCtFobeedd1sB1dsKa5xoSZU6sGA1ADNe+UNDhDmyH9i4tHbwHOZ17PKKzlkXLQ0UXs2ZFqxFq/YDk9e7lTHOLy7yCAK0JsAt7quUUmdJb8+Zvk+63m1kUsilZ2f4rb/8ZTcUNFYixpdPus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901210; c=relaxed/simple;
	bh=O/pU8/B7XCJTYFEYQL3jLROU8mFFVH9L+RpbdSWLDvA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UpEywKUX4j++zAHNiQd3v+BEN164CZicH3sNuQHZYbL47dSx1g4GdtWiLmS34CmzYOKsIk8ICjOeogBbRMhFRIsxdtW9VX9snv/9CVc1QLEovQHezX0ZAlPWY0XtELw4xs2SgFac9gHnn9ZwRUZI7TL+JmdrW7TC/se43akT5/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLlTbkQg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLlTbkQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1D21F00A3A
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782901209;
	bh=YlSP39+460V6oGje4G2SWyo0XCipMYtT1OwDaFNMMHY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QLlTbkQgGyFiybwzSLkGVOIS8rWLOQwxHxlNzSZBlxEvO1F4KMvZ534ATggulC0cQ
	 Z0MGx7Z4jvM70f5I6q0v5W/TozyC+8FlupCj99MYq0cADcmv8oojBxT7YDpTP4rsZf
	 b7xdWlGbBE1i6fy/iWAddsgskUd4zx8Uubc3cqF0e2Aro3i11uaXvYuQNTnX28IGu0
	 go6O0JzS6NQiQAbBXN5Sy/UVWG7AA1VwcQQrx4O0tCa09CuxpMEaLTEDhwSl0LIpV1
	 BXNKeK9sB+1IRthI+30an67fek+NkmEwq/Zh3JWnr5nxbvxbP3YejOp1g1kYFsMO8a
	 bSnXsX4iLW9Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 01/10] bpf: propagate original instruction
 offset when patching program
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701-kasan-v3-1-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
 <20260701-kasan-v3-1-bd09bb942d86@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:20:08 +0000
Message-Id: <20260701102008.CD1D21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] State leakage of `insn_off_in_patch` across loop iterations in `=
bpf_convert_ctx_accesses`
--

commit 37bd4077be7be826caa9dd6664d363fc86f4d0e5
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf: propagate original instruction offset when patching program

This commit adds a new parameter to bpf_patch_insn_data and
adjust_insn_aux_data to convey the location of the original instruction
within the newly generated patch. This metadata maps the original
instruction to the patch for future KASAN instrumentation.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 3cf2cc6e3ab66..1f340211b65c2 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -695,6 +697,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env =
*env)
>  	struct bpf_insn *insn_buf =3D env->insn_buf;
>  	struct bpf_insn *insn;
>  	u32 target_size, size_default, off;
> +	s32 insn_off_in_patch =3D -1;
>  	struct bpf_prog *new_prog;
>  	enum bpf_access_type type;
>  	bool is_narrower_load;

[ ... ]

> @@ -856,16 +862,20 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_en=
v *env)
>  			if (!ops->convert_ctx_access)
>  				continue;
>  			convert_ctx_access =3D ops->convert_ctx_access;
> +			insn_off_in_patch =3D 0;
>  			break;

[ ... ]

> @@ -971,7 +981,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env =
*env)
>  						       size * 8, 0);
> =20
>  patch_insn_buf:
> -		new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +		new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt,
> +					       insn_off_in_patch);

[Severity: Medium]
Does this leak the insn_off_in_patch state across loop iterations?

Because insn_off_in_patch is initialized outside the main instruction
processing loop, if a context access like PTR_TO_CTX sets it to 0, it
is not reset back to -1 for subsequent iterations.

If an epilogue-generating instruction like BPF_EXIT follows later and takes
the goto patch_insn_buf path:

bpf_convert_ctx_accesses() {
    ...
    } else if (insn->code =3D=3D (BPF_JMP | BPF_EXIT) &&
               epilogue_cnt &&
               i + delta < subprogs[1].start) {
        ...
        goto patch_insn_buf;

Won't this erroneously reuse the stale 0 value instead of -1? This could
cause adjust_insn_aux_data() to incorrectly map metadata for the epilogue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-kasan-v3-0=
-bd09bb942d86@bootlin.com?part=3D1
