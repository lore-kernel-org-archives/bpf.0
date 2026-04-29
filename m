Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95E3F54C9
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466976; cv=none; b=JhTgJkiRDVsxcGcp4/xMgsYXVQLozHEHeo1g3KATv879cptMl6ua/bPwSY/KJ+A3McV5Z9+RDbroIHwEuHt35isASbYbWfYKHr6m052ouI0qdKokMc4QxNrEadr8sKmd4kcfsCDRj3TzwWPzDn5RxX9LKrp5p1m7Y2ajQ1hCZZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466976; c=relaxed/simple;
	bh=rGYDOYJDBbB14dTjf39nAEa/vn4bBpsGjeKh838opSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I8wSvfJhE867Wpli3bIFNmpFFtOt6QK+U0780pMc78eUdJliT2MnFmMOhhdzAgpr7ODYmcYwZzWOSTvCJWbqnDWtaw542lqwvu+/EboKC2sqeJC2kJT4A41LifuR4b6tzxImK+Xkz8G2/gw+AJ+N2T/2RgQZ46tsyTYyzZWi2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgCrYjwS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgCrYjwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BA6C19425;
	Wed, 29 Apr 2026 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777466976;
	bh=rGYDOYJDBbB14dTjf39nAEa/vn4bBpsGjeKh838opSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AgCrYjwSzUSpq3V+mu7plofnsz7V116SxqRMLC1uBdNwi4pl/4fInb3pNJwBLikhX
	 Oc+3VHsSFPURNN3l173UbKxzPQlvl8JU9MS6NKb3ZsVuMNrcuMmpZ7MIx6s0MQOoL0
	 oNd6/wap3rfT8F1WBdsVEFjlhzQ67DBmy3eh/x9fWfokO0m7kizSr2HxBneOAcNvwU
	 m1ZAqoiyejrqzMrsJ6hxnE8BKwWNtwtATognfSeTQD2eE1+OQRbthV2RC+MJGqOOEQ
	 87W2BptJjigvRvlVyB5FGqNYySMboqDClDcUvOTalx8kVdKPTzdxqlNzbZFuwhvDAa
	 16tF1hUSlRlMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 3/3] selftests/bpf: Add test for large
 offset bpf-to-bpf call
Reply-To: sashiko@lists.linux.dev
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429105608.92741-4-tangyazhou@zju.edu.cn>
References: <20260429105608.92741-4-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 12:49:35 +0000
Message-Id: <20260429124936.69BA6C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing compiler barrier in the inline assembly landing pad allows=
 LLVM to hoist the 'call_happened' load, leading to an infinite recursion l=
oop and kernel panic.
--

commit 7a012e4a738e7d37b40994fe21bcf400bb1dd252
Author: Yazhou Tang <tangyazhou518@outlook.com>

selftests/bpf: Add test for large offset bpf-to-bpf call

This commit adds a selftest to verify verifier and JIT behavior when handli=
ng
bpf-to-bpf calls with relative jump offsets exceeding the s16 boundary. It =
uses
an inline assembly block with a .rept directive to generate a large dummy
subprogram, forcing the verifier to process a jump exceeding the s16 range.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c =
b/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c
> new file mode 100644
> index 000000000000..da52a1c16d05
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c

[ ... ]

> +SEC("syscall")
> +__success __retval(3)
> +int call_large_imm_test(void *ctx)
> +{
> +	/*
> +	 * Landing pad to handle call error on kernel without the fix,
> +	 * preventing kernel panic.
> +	 */
> +	asm volatile (
> +	"r0 =3D 0;"
> +	".rept 32768;"
> +	"r0 +=3D 0;"
> +	".endr;"
> +	::: "r0");
> +
> +	/*
> +	 * The call_happened variable is 1 only when the call insn wrongly
> +	 * go back to the landing pad above.
> +	 */
> +	if (call_happened =3D=3D 1) {

Could this lack of a memory clobber in the inline assembly allow the compil=
er
to hoist the load of call_happened to before the inline assembly block?

Because call_happened is a plain global variable and the asm volatile block
does not include a "memory" clobber, LLVM is structurally permitted to opti=
mize
the code by hoisting the load.

If the load is hoisted and a truncated backwards jump lands inside the
assembly block on an unpatched kernel, the if condition would evaluate a st=
ale
register value (0) instead of re-reading memory.

Will this bypass the termination check, re-execute the target_subprog call,
and create an infinite recursion loop that overflows the kernel stack?

> +		/* A volatile variable is used here to prevent optimization. */
> +		volatile int flag =3D -1;
> +		return flag;
> +	}
> +
> +	call_happened =3D 1;
> +
> +	padding_subprog();
> +
> +	return target_subprog();
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429105608.9274=
1-1-tangyazhou@zju.edu.cn?part=3D3
