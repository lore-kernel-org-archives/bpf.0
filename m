Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C7207DF7
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292924; cv=none; b=ckZLuVILoEgS1lljNMfwPzRm3XQbon7pb7SFeUPA5mLl09eVketILzzvfVGPi9A15SE7/8wiZWHkgFUwrnI9U2HJnIKkXy9jXNgbOqoznh/rcbNDdvSLMPbKLLueO+8XO7fyTEYfXCNkkhtaNX0lFkkM3j9xSvYb73rDbdznqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292924; c=relaxed/simple;
	bh=LhT5SYKpHjhrAAl9NfwEtPED0brOO9Rj6SolAHcYFT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fI0VePG9CdJoJQzqBduKPTqeTh+0fC1ICjCHxhyR8zFjWR1PMr3Q07BRAi5IuLQtKONZHKR7ONDDIijFP4FXptclYpLM0yG2m4Bjq3n2dHcMGi9x3FlptR4iLhc0HhyBfeYmTmIwYx8Mm2Ss9iGCAJU613kiB7q9qRWBhWLQ6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez3jDaE2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez3jDaE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4469C2BCB0;
	Sat,  9 May 2026 02:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778292924;
	bh=LhT5SYKpHjhrAAl9NfwEtPED0brOO9Rj6SolAHcYFT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ez3jDaE2yZlj/VfRuadOi70p+Qbvu7vobRXbR02/RJxWft0O890P0h9WtWI3Y/xeY
	 lt5HniZ5O/xPziROMnE1Jm2rHfxMuM0IKhP38eFdpMGbTtmVQaUH3bbrOL+smmn18v
	 +dyCkeBQdqUJIhc1wmIVYC+bk4eUSzxxFn+SmKsXkCVZUfNmjhgZFkgNWAf180OvoA
	 MFgCsZPrskjnrNIz1u0qFVcxchsPwE+BlDM+Nxbp7tgWUmQDMGHcMTcBzHWZpzyD27
	 LPsIhWweGHZ9o69Dm2V++WoJM1krCZu8lJV+oGavJtcVrIpL93k8XuzvQshESEgsQZ
	 80uwcTyQCucmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 22/23] bpf, arm64: Add JIT support for stack
 arguments
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213201.1140284-1-yonghong.song@linux.dev>
References: <20260507213201.1140284-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 02:15:23 +0000
Message-Id: <20260509021523.D4469C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In `emit_stack_arg_load()`, `bpf_off` is not negated, causing a ne=
gative index that fails array bounds checks and results in the JIT embeddin=
g an invalid instruction (BRK), leading to a kernel panic.
--

commit 6ccf042549a3902757c6335313c905e99fb41292
Author: Puranjay Mohan <puranjay@kernel.org>

bpf, arm64: Add JIT support for stack arguments

This commit implements stack argument passing for BPF-to-BPF and kfunc
calls with more than 5 parameters on arm64, following the AAPCS64 calling
convention.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 085e650662e3d..9b9d2501d2d36 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -1191,6 +1207,41 @@ static int add_exception_handler(const struct bpf_=
insn *insn,
>  	return 0;
>  }
> =20
> +static const u8 stack_arg_reg[] =3D { A64_R(5), A64_R(6), A64_R(7) };
> +
> +#define NR_STACK_ARG_REGS	ARRAY_SIZE(stack_arg_reg)
> +
> +static void emit_stack_arg_load(u8 dst, s16 bpf_off, struct jit_ctx *ctx)
> +{
> +	int idx =3D bpf_off / sizeof(u64) - 1;

Does this missing negation for bpf_off lead to an invalid instruction being
emitted?

Since BPF stack arguments use negative offsets from BPF_REG_PARAMS (such as
-8 for arg 6), the calculation bpf_off / sizeof(u64) - 1 will result in a
negative idx.

Because NR_STACK_ARG_REGS uses ARRAY_SIZE, it evaluates to an unsigned
size_t. Comparing a negative idx to it will result in a false condition,
falling through to the else block.

In the else block, the negative idx generates a negative offset for
A64_LDR64I. Since A64_LDR64I expects an unsigned 12-bit scaled immediate,
could this cause the instruction encoder to fail and embed an
AARCH64_BREAK_FAULT into the JIT image?

> +
> +	if (idx < NR_STACK_ARG_REGS)
> +		emit(A64_MOV(1, dst, stack_arg_reg[idx]), ctx);
> +	else
> +		emit(A64_LDR64I(dst, A64_FP, (idx - NR_STACK_ARG_REGS) * sizeof(u64) +=
 16), ctx);
> +}
> +
> +static void emit_stack_arg_store(u8 src_a64, s16 bpf_off, struct jit_ctx=
 *ctx)
> +{
> +	int idx =3D -bpf_off / sizeof(u64) - 1;

For comparison, emit_stack_arg_store() correctly negates bpf_off here.

> +
> +	if (idx < NR_STACK_ARG_REGS)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D22
