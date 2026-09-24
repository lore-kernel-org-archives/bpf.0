Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792AA253B58
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220486; cv=none; b=P1d55sZVawuE8Uu+B39DB4tHkE5LKz8kiqnMktnNgwnRp8+u+0x/5DOG7WMYUVxJPRn/lXMFtdZAR/nxsCB181zZJs+JoS9wFwbos7uKjgzqt6Sf3p/ijKqR9EwR/sfaq1wzHtQF6Ml3i95er0R7l5AHJK2MKhjy2SavOKb3kQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220486; c=relaxed/simple;
	bh=imXxjJ62CDVD8zMOWMuubjlf1XYnp/oKuohDK1weDtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DGxfJiEyBtQy/GKpzr4R1vZ4++kxhhSnvR91XgNxAKJQm+SKckGw1abYG4fo6Mol0vJGXFtay26gYR2bpJdhcN58/iHvePl6XMOvsqVrxYHroDdWUzvvU5Pg3WPUs02gFQHkXoD925gGfzgZhiTNk6e15Bj1faIkDtx14MBq/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oybxu0gM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oybxu0gM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E679E1F000FF;
	Thu, 24 Sep 2026 03:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790220485;
	bh=9QfJB1xyfPqNQxwtghzcl4V+WFQL8g7G5GgXrgIX25E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oybxu0gMRs+lVR4JW35sQIumru9wNKyZt9/Q5Jn/ptnzZcidV8WmlY1ynQh8IJdKd
	 ExwI+GUT7jsJbC7MdwsQSt3K3jzPTHaLya7gIILanSko+PHI8MyFtgLDA2lWhBq9KW
	 VXqL7G4kVv4yqMu+4L5/nOPH3Gv133Z6C5NAl1wBhDAhWD9p/5cT1lSsIiUmdhdXMi
	 Nt137Ib/g2pm03t8E4Ll/hR0Pl9t2gpFsIIV5zXZ9RZszc7S4RFPS1LdJXP2S5tle2
	 A3UJw6SX/0EjHZ/rAxonw688zKtRJe42BXWmr2pSd1bn4TQfMKIMKXX4NTpRra+Zyj
	 K0OsgDM7svDUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 05/17] bpf: Add callx instruction to call
 bpf subprogs indirectly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924031042.1690890-6-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
 <20260924031042.1690890-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 03:28:04 +0000
Message-Id: <20260924032804.E679E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: Test 'invalid call insn1' fails on archs without =
callx JIT
--

commit ce97408a97c513bf2f81b643bb904a03dbe7cead
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add callx instruction to call bpf subprogs indirectly

Introduce BPF_JMP | BPF_CALL | BPF_X (opcode 0x8d) 'callx dst_reg'
instruction: indirect call of bpf subprog with address in dst_reg.
That's the encoding LLVM emits for calls via function pointer.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 74cf24ce30074..eb014bf6a2e87 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> +/* there is no support for callx in the interpreter */
> +static int require_callx_jit(struct bpf_verifier_env *env)
> +{
> +	if (!env->prog->jit_requested) {
> +		verbose(env, "JIT is required to use callx\n");
> +		return -EOPNOTSUPP;
> +	}
> +	if (!bpf_jit_supports_callx()) {
> +		verbose(env, "JIT doesn't support callx\n");
> +		return -EOPNOTSUPP;
> +	}
> +	env->prog->jit_required =3D true;
> +	return 0;
> +}
[ ... ]
> diff --git a/tools/testing/selftests/bpf/verifier/basic_call.c b/tools/te=
sting/selftests/bpf/verifier/basic_call.c
> index a8c6ab4c1622f..0f93c4551f235 100644
> --- a/tools/testing/selftests/bpf/verifier/basic_call.c
> +++ b/tools/testing/selftests/bpf/verifier/basic_call.c
> @@ -4,7 +4,7 @@
>  	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, 0, 0, 0, 0),
>  	BPF_EXIT_INSN(),
>  	},
> -	.errstr =3D "unknown opcode 8d",
> +	.errstr =3D "R0 !read_ok",

[Severity: Medium]
Will this strict error string expectation cause the selftest to fail on
architectures that lack callx JIT support?

If the architecture's JIT does not support callx (like RISC-V, S390x,
or PowerPC), or if JIT is disabled, the verifier will prematurely reject
the instruction in require_callx_jit() by emitting "JIT doesn't support
callx" or "JIT is required to use callx", and return -EOPNOTSUPP.

Since the test framework expects an exact match for "R0 !read_ok", this
test might break CI environments on those architectures because the verifier
never reaches the R0 check. Does this test need to handle multiple possible
error strings or be skipped when JIT support is missing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924031042.1690=
890-1-alexei.starovoitov@gmail.com?part=3D5
