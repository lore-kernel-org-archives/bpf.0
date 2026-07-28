Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799234BA20
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785210110; cv=none; b=S9h4S9bZWpaVIUijK5w+EBrAp0OHyOQ69TdGuvBBtzKNpFIdh6n2MDUpKcVciCZI4jk81EC5WmHT0IkggCALJpirKKiiQOzvEQOc1MAzXol1mnI9yAC5yGvxP+zWmEV5JaFJrNMQwHfmLDSh3NbpJcBHvQPhYGE8hQBwUrcD6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785210110; c=relaxed/simple;
	bh=EreQko+biYKYyg5FoNZkKzUVUnu3a6xc5PGF66JdRlE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lwOmOG5fj29xUzr2KCa5QECdvfuUpiZWK9nv4pEzknTBlP3rh+R8yD5jZ7HQ+tw1ZGLQpdnAiBN8wm9a3aoZVSWoNcwZB7gGsDec/uYIwTQFMM0QNYrh3t8EKr160ePx2CcmkH9bwSxyzKZg+46eCgINsUfYYudiw1lDV++L3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqnM6f2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqnM6f2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524171F000E9;
	Tue, 28 Jul 2026 03:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785210109;
	bh=qWbIodwD15Znnh1CMdRz8ydZTssLD81bC78hx9OTkiM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kqnM6f2peac/WvGED99F1U5oQ3BUsVSBrZu0PzDK2CQ/Qjjp8EjclZaOCRBjw8kOq
	 HXk2hhmuqBwKLmij0JW5nCfDOThqxOMCbIf4x5Ss4S7iTrJz/iTv8NdV+sdOmvINwv
	 MoInpPuH9gBT5BIgReUPEMbCLhdJfHblyuwnfOWzoY1CUWAmCdvYJ+DJ+NTYrvwVwG
	 LkmkiFrP2LcePOuMRE1lkPXqWxcQ4/VxR8wDfpviSTx4AJpum8w76Y5mRL1uzH9Iie
	 rO9/FPqJjWM1HFADebUbrMl4lPQ228vH1dhI+SwrSDjR1Gy5tFEZDc6JnWq0waoyko
	 kfb01HcoFdbOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] LoongArch: BPF: Eliminate zero-extension for
 memory load operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260728031615.9389-3-yangtiezhu@loongson.cn>
References: <20260728031615.9389-1-yangtiezhu@loongson.cn>
 <20260728031615.9389-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 03:41:48 +0000
Message-Id: <20260728034149.524171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces redundant double-zero-extension instructions =
for all 32-bit ALU and atomic RMW operations, significantly bloating the JI=
T image size rather than reducing it.
--

--- Patch [2]: [PATCH v1 2/2] LoongArch: BPF: Eliminate zero-extension for =
memory load operations ---
commit 0efa0ea6d44efe5e18fb08bd07d86b901c2332ec
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

LoongArch: BPF: Eliminate zero-extension for memory load operations

This commit overwrites bpf_jit_needs_zext() to return true, causing the
verifier to explicitly insert zero-extension instructions. It then adds
look-ahead logic to skip these verifier-inserted instructions for memory
loads that naturally zero-extend, aiming to reduce the JITted image size.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 4c54e57455ae3..417b69b7ec4a0 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c

[ ... ]

> @@ -2383,6 +2399,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  	return true;
>  }
> =20
> +bool bpf_jit_needs_zext(void)
> +{
> +	return true;
> +}
> +

[Severity: High]
Does returning true here cause the verifier to insert zext instructions for
all 32-bit operations globally, rather than just memory loads?

If the verifier now inserts a zext instruction after every ALU32 operation,
and the JIT still unconditionally calls emit_zext_32() for ALU32 ops:

arch/loongarch/net/bpf_jit.c:build_insn() {
	case BPF_ALU | BPF_ADD | BPF_X:
	case BPF_ALU64 | BPF_ADD | BPF_X:
		emit_insn(ctx, addd, dst, dst, src);
		emit_zext_32(ctx, dst, is32);
		break;
}

Will this cause the JIT to emit double zero-extensions (one internally, and
one when processing the verifier's injected instruction) for all 32-bit ALU
and atomic RMW operations? This seems like it could bloat the JIT image size
rather than reducing it, as the look-ahead skip logic was only added for
memory loads.

>  bool bpf_jit_inlines_helper_call(s32 imm)
>  {
>  	switch (imm) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728031615.9389=
-1-yangtiezhu@loongson.cn?part=3D2
