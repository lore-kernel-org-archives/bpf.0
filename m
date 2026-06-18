Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CCE2E7369
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754797; cv=none; b=JhL5JliD9L+q18h5i67pfYnIoMgIVyjA0WXPbvqME0pz6H3u+MVejRLoxBdYVGg7WCcV6Mm5gUJmrxAafkwMsSXVvucRnKsDsVMw+EV3lWaMvbBTRjMEU1I2Rj9Suk0or1BfQGfWsw/tSJfSioVyXdfCsE5Bw1LYz4NUqHzpM64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754797; c=relaxed/simple;
	bh=aIuPKQPWJPu2tHGsi8YTIEbrmhPwSS3VtDVEXa9k2BU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qDYrIdffTEGN3DG4nsb7WcJX6KkZT/nxE8HdbPtVYRxcWUXabYgv+nlQoHknmEskikkyHP/4qb8h5hvp9YzkDiYQmnsEBxPjbtaKPW6mqaM/bCrl03UNRYJ+Oc1jCM77ETEZWaMZ7lvbg2XzLe4dkk5X9WNnt8tqTA9ojQen0Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INyI6ayf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INyI6ayf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D748C1F000E9;
	Thu, 18 Jun 2026 03:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781754796;
	bh=iyIhaQz6sj2SckjdnKlkNITGfHsuV2ZVgiwfbus/Kk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=INyI6ayfKK49c0N3SUiyDJ4b7sUGSXs8jC0oqcOZx2Nn/K2zxd4mQi6l8yIiEeC/5
	 TYQkafdkFBhihIgvG8zcQf6ra47P7+cOwWhr32kJ8GleWTd4O75S+NzFXngEjoUpOb
	 mq3Jx14/RitlGvCvRHZo3zWCWMKE9YeHhy3a+WtmesMOXNNA71h1i9A/NNHEjU4NUZ
	 X6Eo9yMX4D+dLsYg/guDkpSXsW60jkemRTcDBlWD7e2396XpuFDREjNK/O14sdGPO+
	 ob2ZXyNfpWsgcIaTDeoyox8yoqb8yCglrKUiQ9uiIzrDMG2UYKy0Pa8TgddG9O0dPQ
	 cq+sUIMHfZWbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] LoongArch: BPF: Gate unsupported arena instructions
 via bpf_jit_supports_insn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618033809.98253-2-dongtai.guo@linux.dev>
References: <20260618033809.98253-1-dongtai.guo@linux.dev>
 <20260618033809.98253-2-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 03:53:15 +0000
Message-Id: <20260618035315.D748C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf_jit_supports_insn() fails to reject 1-byte and 2-byte atomic=
 instructions on arena pointers, leaving the verifier/JIT mismatch bug open=
 for these instruction sizes.
--

commit 862ea469523044315d6f8a9fd4faf30c77844856
Author: George Guo <guodongtai@kylinos.cn>

LoongArch: BPF: Gate unsupported arena instructions via bpf_jit_supports_in=
sn()

This commit implements bpf_jit_supports_insn() for LoongArch to reject
unsupported BPF arena instructions during verification. This prevents
confusing failures later in the JIT compiler.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -2357,6 +2357,26 @@ bool bpf_jit_supports_arena(void)

[ ... ]

> +bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
> +{
> +	if (!in_arena)
> +		return true;
> +
> +	switch (insn->code) {
> +	case BPF_STX | BPF_ATOMIC | BPF_W:
> +	case BPF_STX | BPF_ATOMIC | BPF_DW:

[Severity: Medium]
Are 8-bit and 16-bit atomics supported on arena pointers?

This switch handles the 32-bit and 64-bit atomic instructions, but it omits=
 the
BPF_B and BPF_H sizes. If 1-byte and 2-byte atomics are used on an arena
pointer, will this return true and cause the verifier to accept them, leadi=
ng
to the same JIT failure this patch is trying to fix?

> +		/* Atomics on arena pointers are not implemented yet. */
> +		return false;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618033809.9825=
3-1-dongtai.guo@linux.dev?part=3D1
