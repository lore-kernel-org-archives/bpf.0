Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8884AB1CD
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266490; cv=none; b=QZvt+b79b8oZNk1jOWipsu30YKtrfEczouJSaoxrKca9fpGNtT51tBEiYdFgAsSjmz0R4XPL/Oo5LvuTPIGT7GquctboDvYLSbu6rsYOvpN8qYjklZq6/mBrZXVYfg8ht5GL82Ja3nBDQHWIdJ27o3cOl6q2GiSBKKjLqHDghf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266490; c=relaxed/simple;
	bh=FFNTKYiR2ILpzSQkTIbGQM5H1LwFFUt3jm2L4sJtPX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N1iN2G1rbFjNMuwSm/HzXQwioH/yTgYhWimZipDc3lXITeo65uct0lIGFw0uYGCEAGC10Qa1sbDaGgvJocYxNBoCR7oDZJWaybS1KmfNADNuXHt2yUNos44SHsGx48TmAN9PVvHSPOaWKxHqP8w7eJXlQef19MxP72GhuHCWNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuGFL1mk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuGFL1mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CD11F000FF;
	Thu, 24 Sep 2026 16:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266489;
	bh=dReut35Uh6BkNgLvRWbDIh+0X/KmJownKPhIpxgGDJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EuGFL1mkASYOQbpRHCn0spe8UV8msPJ0ATiQa37yZ5j7Cx5wAm+whXCvRjJ1gMHXU
	 2aIiNlTVXt76GwT5+lZQfEZNHifyBd/dGIcWVIqMOr1ZtKc1EI5P5MfOf8KhLun3cu
	 ACgvjEpqzTOUYnLKmTYh56Vi1lAIyTHFZ0glTyf3FY9Ir7rx/UcrRae7Z1vGq4vwrM
	 fyPgeGLwgwdTWJTdXmvgPSX+jW8HvK2D/ZShne5jiMb8tU4Hvr8oPv9PvuEfypGcaP
	 +V6BHuCkg4Gscq/cSkaDzoHqMmFGdzCjJH3sULE+RG0zaOyyXl1wE+OH8Az2subfeP
	 aq3xmaNeOhLmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf, x86: use 32-bit zero idiom for shorter encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Hu" <integral@archlinux.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924160154.12807-1-integral@archlinux.org>
References: <20260924160154.12807-1-integral@archlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:14:48 +0000
Message-Id: <20260924161449.04CD11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: prologue size reduction truncates stack pointer in tail c=
alls
--

commit b074cc264a81306406896f5f166974e4a1d9467f
Author: George Hu <integral@archlinux.org>

bpf, x86: use 32-bit zero idiom for shorter encoding

This commit reduces the BPF prologue size by changing "xor rax, rax"
to "xor eax, eax", saving one byte in the generated instructions.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index de7515ea1beae..a62317b78df1e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -551,8 +551,11 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 st=
ack_depth, bool ebpf_from_cb
>  		if (tail_call_reachable && !is_subprog)
>  			/* When it's the entry of the whole tailcall context,
>  			 * zeroing rax means initialising tail_call_cnt.
> +			 *
> +			 * xor eax, eax
> +			 * equivalent to 'xor rax, rax', but one byte less
>  			 */
> -			EMIT3(0x48, 0x31, 0xC0); /* xor rax, rax */
> +			EMIT2(0x31, 0xC0);

[Severity: Critical]
Does this 1-byte reduction break the hardcoded tail call offset assumption?

X86_TAIL_CALL_OFFSET is defined as (12 + ENDBR_INSN_SIZE) elsewhere in this
file. By reducing the prologue instruction size from 3 bytes to 2 bytes,
the 12-byte layout expected by the tail call jump logic appears to be broke=
n.

During a tail call jump, this 1-byte mismatch will cause the jump to land p=
ast
the intended destination, skipping the 0x48 REX.W prefix of the subsequent
instruction:

    EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));

The CPU would then decode the remainder as a 32-bit sub esp instruction,
which zeroes the upper 32 bits of the stack pointer (rsp). This points the
stack into unprivileged user-space memory, potentially allowing local
privilege escalation.

>  		else
>  			/* Keep the same instruction layout. */
>  			emit_nops(&prog, 3);     /* nop3 */

[Severity: Critical]
Should this fallback branch also be updated to 2 bytes?

Since the tail-call reachable path above was changed to emit 2 bytes, leavi=
ng
this as a 3-byte NOP destroys the consistent instruction layout between
tail-call-reachable and non-tail-call-reachable programs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924160154.1280=
7-1-integral@archlinux.org?part=3D1
