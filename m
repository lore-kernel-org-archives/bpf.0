Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396B3B6BFF
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520520; cv=none; b=dVP5qiiVQsYYXOR8Posg2ltCLrge6Rs+4nlLgHKz2s8ZXPmdCofSgolONt26MnbELkp4yx+289oTMNgFpO/5YK58fddlLr6MT+9fWq5rXMLeAxXamRpba5vedAM1wlGYupqbvS1R+KmQFsF6Yu2/mU80Zl/voAL+jRhdEYBdOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520520; c=relaxed/simple;
	bh=IM7p2SI1d83IveyLeoi8Fu1NPLwW3CPiiD5dsBzWQhY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BiZm0KBo59WJw/jJC3j2aZzRGjPET3I/zBVmLp+M3WxYD8wk2XPOLaNY4PiId6LkMIrss0SjgtLwxhVVpV19mPpvcJ2YxVte9ejq7DgK++XPAGIy3BypxDZqcfMvfNVpq6bQXD5qcnANXmU3vn9AcrGJRAoBGdQZggV6d2vD1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfbgHEuu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfbgHEuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63031F000FF;
	Fri,  9 Oct 2026 04:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791520518;
	bh=t7Dua8GMldMwxyIbssZy6xzC8pyupPnoYiSpoI782G0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SfbgHEuu6GFm4Ttbv9Uh5Kdus5BMSFq5FPf6hrXVe/Bf2nKCFaM+mVQO3Bjezv4IG
	 qjRs95XZ0CXvXqh0J08GkSqFuni0Ix+m6qvwg07gqWHdmlKk1Aq29IKr6uGpDoEwxY
	 i5fFHZzZPWnzkF1I5Cq3YAayabh9fSZJcZ+i+RiaSYALykyPorFyJ3gk2W7UJSIFFo
	 OpK501ptXUeg/MNIVB1pOUKJGMviuCrvhBROwmWTSPM7B1TgGk5+LTCqx8lFxuzCQ6
	 xXI95AOCoSg7NhbNpg628K7nvJQOD9T6DINigZhp8feiJWX6mfbvloyi+1EYmm2GF5
	 KQQ76cGYxEZ9Q==
Message-ID: <sashiko-outbox-164846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 11/24] bpf: Prepare JITed programs for
 dispatching cleanup pads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009041544.29907-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041544.29907-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 04:35:17 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: backward jump offsets in bpf_exc_patch_unwind_calls are corru=
pted by bpf_adj_branches
--

commit b2a75ebf7c80cc3231a5eb34881ba1928dafcd3b
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Prepare JITed programs for dispatching cleanup pads

This patch prepares JITed programs to dispatch exception cleanup pads.
It updates the verifier to patch bpf_unwind() calls with a sequence that
clears r0 and jumps to the exception pad or exits.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 64baee1a37e60..1cc025c45ecda 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -1733,6 +1805,48 @@ static int may_goto_expand(struct bpf_insn *insn_b=
uf, int off, int stack_off,
[ ... ]
> +/*
> + * Follow each bpf_unwind() call with 'r0 =3D 0; exit', or with
> + * 'r0 =3D 0; goto pad' where a record covers the call.
> + */
> +int bpf_exc_patch_unwind_calls(struct bpf_verifier_env *env)
> +{
> +	int insn_cnt =3D env->prog->len;
> +	struct bpf_insn insn_buf[3];
> +	struct bpf_prog *new_prog;
> +	int i, off, delta =3D 0;
> +
> +	if (!bpf_prog_may_unwind(env))
> +		return 0;
> +
> +	for (i =3D 0; i < insn_cnt; i++) {
> +		int call =3D i + delta, pad;
> +		struct bpf_insn *insn =3D env->prog->insnsi + call;
> +
> +		if (!bpf_is_unwind_kfunc(insn))
> +			continue;
> +
> +		insn_buf[0] =3D *insn;
> +		insn_buf[1] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> +		insn_buf[2] =3D BPF_EXIT_INSN();
> +		pad =3D bpf_exc_pad_of_call(env, call);
> +		if (pad >=3D 0) {
> +			/* The goto is at call + 2; a pad after the call moves down by 2. */
> +			if (pad > call)
> +				pad +=3D 2;
> +			off =3D pad - (call + 3);
> +			insn_buf[2] =3D off =3D=3D (s16)off ? BPF_JMP_A(off) : BPF_JMP32_A(of=
f);

[Severity: High]
Does this manually calculated offset get corrupted if the landing pad is lo=
cated
before the unwind call (pad < call)?

bpf_patch_insn_data() is called immediately after this, which delegates to
bpf_adj_branches() to adjust all relative offsets in the program.

When bpf_adj_branches() processes the newly inserted goto instruction, it
evaluates it as if it were a shifted original instruction (because
curr >=3D end_new evaluates to true). If the jump is backwards,
bpf_adj_branches() might erroneously subtract the insertion delta (2) from =
the
already-correct offset.

Could this result in the jump target being shifted 2 instructions before the
actual landing pad, potentially leading to the execution of unintended or
unverified bytecode during exception unwinding?

> +		}
> +
> +		new_prog =3D bpf_patch_insn_data(env, call, insn_buf, 3);
> +		if (!new_prog)
> +			return -ENOMEM;
> +		delta +=3D 2;
> +		env->prog =3D new_prog;
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009041447.1709=
2-1-yonghong.song@linux.dev?part=3D11
