Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38153F822F
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932082; cv=none; b=O+8WT3UapXuq6rYcEv7ZbqSYcKHPEaLQVjTjCEIQaTUmccytIb2aeISjx1eLuRvnrnzUpjTf1etQdR0ZMrHc73EB7mafKrS3FkrL+/BhQHw7FXOVFDhl06cK8qgy8ooCuPnaOqn+guhxkdw8rav0W1tkFVxhIandh0tc58jwe9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932082; c=relaxed/simple;
	bh=MAIegue6BM0sipLUF1W0Yevh7/GoFTBDMvhgRMS4JnQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hd6kzESIifm3APwO/AQHijFnE8cncM7IWKX6NY0n1MTwL+IsUrycZHHOBTWqkHLkYAKDn66RS1QpH99tLabmu5hwvy7zwtaqyS4I41apRALp4F6qDHDdA8PPO70TmQCXVBnnER4V69pa35jJjwEWE1MVc14+95Q9oICJadNhT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNyVGXfa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNyVGXfa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9181F00893;
	Mon,  8 Jun 2026 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780932080;
	bh=7j+8ckKdMlars7Y2keiMkROeOw2TgWgs10BRNGBllgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PNyVGXfaevh7ULCwsqZCEIeJbZaGrcXPCv4VXqZuWKK8tAM2fuVGrrlxqHBKxiFx3
	 MIHhtBY9BAvt/xGcHicXxpTCJVj8y37I8AoMAVceCVHm9w4YnjlF6k1AM/ra/S5XIK
	 Z/qYDqb5C+bUjBBi6d9YDP4fxAU7/PbbQhhsO0S8IEvBeZPz2nZMb8IVjzL31XBgaN
	 fSTl+hobU/ZsRkKpfBWaQZmc0AQ22BFVPTzwfa8R6VWfQ6RMI+bwTbyJUwOoX3wVr1
	 PX4tN3cXm5oCSGLedbh1PQ/hBPsrYixuLByr+8inL8Cl/0TKu0VDJ4gcc1ZH4GdcnA
	 w6V1cGkheor3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 8/9] selftests/bpf: Add test to verify
 xlated insns for global percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608145113.65857-9-leon.hwang@linux.dev>
References: <20260608145113.65857-9-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:21:19 +0000
Message-Id: <20260608152120.8B9181F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Validation logic for the `insns` array uses the wrong `idx` variabl=
e, rendering the bounds check logically ineffective.
- [Low] The `ld_imm64_to_u64()` helper incorrectly casts a signed 32-bit in=
teger to `__u64`, causing unintended sign extension.
--

commit 7b07fe4e4f25a49af6769218dfb2293981c5c2b2
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add test to verify xlated insns for global percpu data
   =20
This patch adds a test to verify global percpu data related translated
instructions in BPF. It compares the translated ld_imm64 instruction with
the one in the ELF object file, and verifies the addition of the
mov64_percpu_reg instruction.

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 729878d5d3b31..c3b9423246b55 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
[ ... ]
> +static __u64 ld_imm64_to_u64(const struct bpf_insn *insn)
> +{
> +	return ((__u64) insn[1].imm << 32) | (__u64) insn[0].imm;

[Severity: Low]
Does this code inadvertently sign-extend the lower 32 bits?

The imm field in struct bpf_insn is a signed 32-bit integer (__s32). Casting
it directly to __u64 performs sign extension. If insn[0].imm were to contain
a value with its most significant bit set, it would be sign-extended,
corrupting the resulting 64-bit value.

Should this cast to __u32 first before casting to __u64, like
(__u64)(__u32)insn[0].imm?

> +}
> +
> +static void test_global_percpu_data_xlated(void)
> +{
> +	struct bpf_insn ld_imm64_raw[2], ld_imm64_xlated[2], mov64_percpu_reg, =
*insns =3D NULL;
[ ... ]
> +	prog =3D skel->progs.verifier_percpu_read;
> +	idx =3D find_ld_imm64(bpf_program__insns(prog), bpf_program__insn_cnt(p=
rog), ld_imm64_raw);
> +	if (!ASSERT_GE(idx, 0, "find_ld_imm64 raw"))
> +		goto out;
> +
> +	err =3D test_global_percpu_data__load(skel);
> +	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
> +		goto out;
> +
> +	err =3D get_xlated_program(bpf_program__fd(prog), &insns, &cnt);
> +	if (!ASSERT_OK(err, "get_xlated_program"))
> +		goto out;
> +	if (!ASSERT_GT(cnt, idx + 2, "xlated insn count"))
> +		goto out;

[Severity: Low]
Is this bounds check using the correct index variable?

At this point, idx holds the index from the raw BPF program. Because the
BPF verifier can insert instructions, the index in the translated program
might differ from the raw index.

Could this bounds check be moved after idx is updated below, since
&insns[idx + 2] is accessed later using the translated index?

> +
> +	idx =3D find_ld_imm64(insns, cnt, ld_imm64_xlated);
> +	if (!ASSERT_GE(idx, 0, "find_ld_imm64 xlated"))
> +		goto out;
> +
> +	ASSERT_EQ(ld_imm64_xlated[0].code, ld_imm64_raw[0].code, "ld_imm64 opco=
de");
> +	ASSERT_TRUE(ld_imm64_xlated[0].dst_reg =3D=3D ld_imm64_raw[0].dst_reg, =
"ld_imm64 dst_reg");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145113.6585=
7-1-leon.hwang@linux.dev?part=3D8
