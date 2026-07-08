Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E642B30C
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507410; cv=none; b=H46rU/9tqk2xZ0Yc4Cj1EBgBYLSL7hbzS3qxZBAniOXJdMbXNLVCx3j8sH+Y5CgzjQ+GOM26hmXPBZ7lBx7eS/hjrw0W1L93ZqzWT8U6jZCneAuT4s+be10COSCQYqjajSezvDoQoyh0IYITfbwvScbMi6RuiJJzAzkK66xtDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507410; c=relaxed/simple;
	bh=eV1pgs1wPo7ZncAjrVqTd2d4hI77bLTH0dUeICLi+lQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fhLo7HPJRfg895uytLIvLXYDRdPXBTY1QpA5XCHT5huMSyRBrESKnVhsHAIQ9npadgthirncmtFP8k7Igdq7GlLOBqcwKeSq6hpP0Jha3lmSK80CvrQo6Pz2syauWkiWkvjApZwY+glyPKyP3chLMSABTbXykBKhzaRyRG0DkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iat5mkzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iat5mkzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE58C1F000E9;
	Wed,  8 Jul 2026 10:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507405;
	bh=ThGvgATIxvZmkTLDYrOu9MOYatLyGkCDmynJ1JuB4/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iat5mkzmL6rro4ulWuwLVHz8pdLsP2d+ovw0jFQUXBA3yv5cXrQBUdD93CbFHUuS7
	 zleihHbZy4WYlTlWsSu5yyUovn3GTcSaFSfJuF2PyGzJMoiMJ4aLJuWoHNUa5MBxAN
	 75pB3uSyeze8334jjNbwgcpeWaK670LV1c/TlF0W2fnRuGm9Slkzsn7EKma79sNYrf
	 jzn+E8r1FQ9x5D1faDXLJmTPdjijER+Jsj3902J5ZJPa99fZyr9jg+P9B/9g5ZjNGf
	 ti1n9CO0BED1cRBLqPRTLcY2gnzfRdy92v0YbeGrHEpQJGTuBgTXE+bs4SKJGkhMkY
	 efkODXBa4+QoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 2/2] bpf: Reject programs with inlined
 helpers if JIT is not available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708101806.18885-3-yangtiezhu@loongson.cn>
References: <20260708101806.18885-1-yangtiezhu@loongson.cn>
 <20260708101806.18885-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:43:24 +0000
Message-Id: <20260708104324.BE58C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch unconditionally sets `prog->jit_required =3D 1` and skip=
s instruction patching for helpers that can be JIT-inlined, which unnecessa=
rily breaks the execution of these BPF helpers under the BPF interpreter wh=
en JIT is globally disabled.
--

--- Patch [2]: [PATCH bpf-next v9 2/2] bpf: Reject programs with inlined he=
lpers if JIT is not available ---
commit 28807bd656d66a091e77d8589e0c48bef3c4c778
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

bpf: Reject programs with inlined helpers if JIT is not available

This commit modifies bpf_do_misc_fixups() to set prog->jit_required =3D 1
when bpf_jit_inlines_helper_call() returns true. This is intended to prevent
a kernel panic when JIT compilation fails or is disabled and the interpreter
tries to execute an unpatched helper call with a raw ID.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 02246df2f6c36..d3be972714b22 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1840,8 +1840,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
>  		}
> =20
>  		/* Skip inlining the helper call if the JIT does it. */
> -		if (bpf_jit_inlines_helper_call(insn->imm))
> +		if (bpf_jit_inlines_helper_call(insn->imm)) {
> +			prog->jit_required =3D 1;
>  			goto next_insn;
> +		}

[Severity: High]
Does this unnecessarily reject valid programs when JIT is globally disabled?

If JIT is disabled (net.core.bpf_jit_enable=3D0), prog->jit_requested will =
be
false. By unconditionally skipping the instruction patching and setting
prog->jit_required =3D 1, valid BPF programs using standard helpers (like
bpf_get_smp_processor_id) will be rejected on architectures supporting this
JIT inlining.

If this code instead checked whether JIT was actually requested:

    if (prog->jit_requested && bpf_jit_inlines_helper_call(insn->imm)) {
        prog->jit_required =3D 1;
        goto next_insn;
    }

Would this allow the code to fall through and rewrite the offset when JIT is
disabled? This would correctly resolve the helper's C function address,
safely allowing the BPF interpreter to execute these standard helpers witho=
ut
crashing, while still preventing the runtime panic if dynamic JIT compilati=
on
fails.

> =20
>  		if (insn->imm =3D=3D BPF_FUNC_get_route_realm)
>  			prog->dst_needed =3D 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708101806.1888=
5-1-yangtiezhu@loongson.cn?part=3D2
