Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D74433E89
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004336; cv=none; b=Zkfe9JXnvPfhHuh9IeJ+M0CkDY/C6xkmb+eEan8YD+JsF4jpy1Wx+dP5GVJ2ADbOsmOR0CzHpEmtccszQEgsQbz4iWgJkCJoU7JeGp3AFq/7VDrnfQGTIbn8htRXnViAsp57xtYY9Um/BQNPXwB9Q0UGH1rZOMdgrinbICTdWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004336; c=relaxed/simple;
	bh=iSs6kNg8VDsQnH2FyvusdPc5k1q8JKwQHXOCbXnlL7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZsDpDJyJ9KZnPMnrnyGWBzCOYrRQD8wMBRND4DbdIjgMlJJ/Xz8/Si++eIBkktNE5aQAM9q8zhAEcXBdRF2hv+jrk0QopiLnKj0F5UM3EBtRF7Q6vS8Bv/QjXUnB+2lha5aeQ38zPdASUMcJEPd5DN4muHzATF22C7xJJjCobSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAf14v5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAf14v5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C6B1F000E9;
	Thu,  2 Jul 2026 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783004335;
	bh=wNGM2Y7Gml3aGkcT8H8xlrBeVoFcgH8xuG4PSSo93uw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UAf14v5cEa6j0cRIXNuB+Xy9r4NsGNbphvhbqqoSLLE5Piqhpy5/FH5yoQnny/OMs
	 LwQIfZD5RHnAjaGNFIGSaRbzs/BdZJVNiP+tXlnJVneX5tVLTWzYP5y4zmxzrNfW9H
	 TaHqvYAUZFrQ9jUl+CZ9PKLjs/9gqvy4i6Slia0ZvdUPwHhuPLbPWZb/A1T9eFZSqE
	 b8Dd3RtAI6QNFTLsc9NCaQEpbkXZp8xzn8kq8/BrjCl8f3rwDtOCtzMZH/ifClxjOR
	 ZA3dd3fDX/M/a6ijy20ptTVpKJJAcaAKhfgHagMM6jh7iT9pCQnn7XLTcNjrapYhqU
	 upUKyLYH0xG0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702143656.28845-2-yangtiezhu@loongson.cn>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
 <20260702143656.28845-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 14:58:54 +0000
Message-Id: <20260702145855.07C6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `bpf_fixup_call_args()` function and `bpf_prog_has_kfunc_cal=
l()` macro were not updated to use the new `jit_required` flag, leading to =
inconsistent interpreter fallback behavior for pruned kfuncs.
--

commit 5a3f8861c2b6916fe194f97a407cb7265f545fd0
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

bpf: Introduce jit_required flag and refactor kfunc path

Introduce a 'jit_required' bitfield flag at the end of the
flags group in struct bpf_prog. This bit tracks whether a
program strictly requires the JIT compiler.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f3..5fcd19ccb41a9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2619,8 +2619,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env, struct
>  	if (fp->bpf_func)
>  		goto finalize;
> =20
> -	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -	    bpf_prog_has_kfunc_call(fp))
> +	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) || fp->jit_required)
>  		jit_needed =3D true;
> =20
>  	if (!bpf_prog_select_interpreter(fp))

[Severity: Medium]
Since bpf_prog_has_kfunc_call() was replaced here with fp->jit_required,
should bpf_fixup_call_args() in kernel/bpf/fixups.c also be updated to use
the new flag?

Currently, bpf_fixup_call_args() still calls bpf_prog_has_kfunc_call(). If
a program has a pruned kfunc (allocating kfunc_tab but leaving
jit_required=3D0) and JIT falls back to the interpreter, wouldn't
bpf_fixup_call_args() incorrectly reject the program with -EINVAL?

kernel/bpf/fixups.c:bpf_fixup_call_args() {
    ...
	bool has_kfunc_call =3D bpf_prog_has_kfunc_call(prog);
    ...
	if (has_kfunc_call) {
		verbose(env, "calling kernel functions are not allowed in non-JITed progr=
ams\n");
		return -EINVAL;
	}
    ...
}

Should bpf_prog_has_kfunc_call() in kernel/bpf/verifier.c be updated to
check prog->jit_required, or removed entirely in favor of checking the flag
directly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702143656.2884=
5-1-yangtiezhu@loongson.cn?part=3D1
