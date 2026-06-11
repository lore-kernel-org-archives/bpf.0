Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2CE1F5821
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162310; cv=none; b=XUkcCDWywJSO4Qs3wYGaXaW04GdjH+JPwJFrKeCNlOdHFZ066cLjU4u6Xg4jlI/u4wDniGfaxH7zUTDhXtydoOWnW3qXZuKmxFsH9k4dCwhPjyFhsvCC21xgp6elv9tBHC2fej0j+fnkszNG4B8zIaCcYBcEw8+3ONvvyQWmM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162310; c=relaxed/simple;
	bh=dR/vVr7aWi0JcLEVyb0dZ8/xblvOj8u1zZGAYlIs/Oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YzXDzYCYvd+EcSvQtWibVZfg/2cZRpYgfJuYqjy4x7H5B032dZPNg6aWENsD5F4gMncjnTwEhfqdCs39htcgmMI79zhBe50ps6HJ3N0Kv/HFdFfI/fqgfQ2CQN4scCRTL0Pmy20Cc5H6KLGLQjhJFxPnN0MBFGAn2q/rbYpAawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnkQRnQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnkQRnQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8DF1F00893;
	Thu, 11 Jun 2026 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781162308;
	bh=hbOikQmyX4LXYCHZKPWdrfBghgJh2rdrFCPajfD5cEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XnkQRnQD+ooQrHfivVMxTDsIGKYz4H6tIkXyWDSQo569+o2ejYi4t34j8dQjyoXtd
	 BKVPLXX/XlAH8tYkiEv3yFLbHog5FRKQr70V+OVhnzNAX+KwUZFgk/jdqANoEm3D9q
	 iPdic4d5sOELN+VrGImWUYIFbeN1F3bJ6zxmohfbqwLkd/u+/ConDKBcyeALHwWg56
	 9Gm2DStcRIjmK7A7M2B6TkrkzPEBj7jjZ8Wyjv3BxDLp1LVUXqiKmL+NT4sQmOtp7g
	 ZWzgPVsZ7P8dCNeNt1dTdluxJEz+KG5sleklTkzEQn9UMgmMRnU/CxYepvP8/QtPK4
	 EX3eqCijmvsZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1] bpf: Fix unaligned interpreter panic on JIT
 fallback path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611070009.26257-1-yangtiezhu@loongson.cn>
References: <20260611070009.26257-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 07:18:28 +0000
Message-Id: <20260611071828.8C8DF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Type confusion between BPF helper enum IDs and address offsets in =
`bpf_fixup_fallback_inline_helpers()` leads to potential silent instruction=
 corruption.
--

commit e06144ee47e54fe6934472bff4024530f26b7737
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

bpf: Fix unaligned interpreter panic on JIT fallback path

This commit introduces a fallback fixup phase to rewrite the call offsets
for inlined helpers when JIT compilation fails or is skipped. This prevents
unaligned memory access panics when falling back to the interpreter.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f3..de0c46b495b40 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -2608,6 +2608,30 @@ static struct bpf_prog *bpf_prog_jit_compile(struc=
t bpf_verifier_env *env, struc
>  	return prog;
>  }
> =20
> +/*
> + * Rewrite the helper call offset for inlined helpers when fallback to
> + * the interpreter happens due to JIT compilation failure or JIT disable=
d.
> + */
> +static void bpf_fixup_fallback_inline_helpers(struct bpf_verifier_env *e=
nv, struct bpf_prog *fp)
> +{
> +	struct bpf_insn *insn =3D fp->insnsi;
> +	const struct bpf_func_proto *fn;
> +	int i;
> +
> +	if (!env || !env->ops->get_func_proto)
> +		return;
> +
> +	for (i =3D 0; i < fp->len; i++, insn++) {
> +		if (insn->code =3D=3D (BPF_JMP | BPF_CALL) && insn->src_reg =3D=3D 0) {
> +			if (bpf_jit_inlines_helper_call(insn->imm)) {

[Severity: High]
Could this cause a type confusion where a patched address offset is
misinterpreted as a helper enum ID?

Since bpf_do_misc_fixups() already patches insn->imm with a 32-bit address
offset (fn->func - __bpf_call_base) for helpers that are NOT expected to be
inlined by the JIT, insn->imm will already be an offset when reaching this
loop for non-inlined helpers.

If the distance between a non-inlined helper and __bpf_call_base happens to
match the enum ID of an inlined helper (for example,
BPF_FUNC_get_smp_processor_id =3D 8), wouldn't bpf_jit_inlines_helper_call()
falsely return true?

> +				fn =3D env->ops->get_func_proto(insn->imm, fp);
> +				if (fn && fn->func)
> +					insn->imm =3D fn->func - __bpf_call_base;

If the type confusion triggers, it seems this line would overwrite the
original, correct offset with the offset of an entirely different helper
function, potentially causing the interpreter to execute the wrong helper.

> +			}
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611070009.2625=
7-1-yangtiezhu@loongson.cn?part=3D1
