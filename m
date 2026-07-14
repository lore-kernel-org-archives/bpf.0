Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD8191F94
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992190; cv=none; b=DZ3o6cneai+xa/aGEL+GkttTFkKYp5eIOCPjSCH3/sB15bzOUUIoeJ0kK5d1vRcvtP2IMs0O7hNTff48JrKHIJ6FzGFaLMsrvq2wf2k+77ia1ldQ8JKeo1cVQnJaO8JsomqnSDPkVEku9JuqmKtQmvIR/iK1T35EB+PvTntKT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992190; c=relaxed/simple;
	bh=iK7rsi1hSS6VrhN8/EvP9TL2EuVy98UB/64XC9YGSbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XcmORKcg7fWKtcVseJGpbZreCzRBkrhgWyfPlZ8wjHV+P5ybpDRFi5QKTEeCrf2fibVuUJHaMdjDLA10XRq6T4jQKpiDGvynADrzwf68NfBXP01BmqQOlvI97Zjfei91S0oazMK2CnSi1H2azsnXyrGjzQ1+AsGm8DVarpon8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNDamRCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNDamRCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CAF1F000E9;
	Tue, 14 Jul 2026 01:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783992188;
	bh=I6PHE4RRAo1XLMttEUDaUm69Ih2DsrzyTTDl4UvbwUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZNDamRCIdMSw5+7MsUp3DMBB+WoUOzEv/YJEdSIGhLLOKMQwHh08LLbSIyAVzm6GL
	 aFDgLaVt/yJ6Kw5ttx6+XBLTa/y2KkoN0sWasZkOsOIa2i7QE1Zm6gt3WRQ2QU7lZj
	 SVjW/Ufpw+X4GLCmgxT9SKUllIvfQR+evm/JX1tuXmhkdbWIqp/Esb9QQjdE78CLMt
	 ODO9Cvym9+MgBAzDvCnhv3OW3OZATcFn43DhGRLM4dZFAU/3JzTIBCUI6zK11nKXsx
	 fU72GySI8GtAfz93GHGl3OcXyks64ZyutsJLVgY2Erc9rgLUi113BAEDiYSsSaS/I7
	 8wZBBu7qYDHPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 1/6] bpf: Support for hardening against JIT
 spraying
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-1-755f60c55705@linux.intel.com>
References: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
 <20260713-cbpf-jit-spray-hardening-6-18-y-v1-1-755f60c55705@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 01:23:08 +0000
Message-Id: <20260714012308.94CAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] BPF programs larger than BPF_PROG_PACK_SIZE bypass the new predict=
or flush during allocation, leaving large privileged programs vulnerable to=
 Spectre v2 JIT spraying.
--

--- Patch [1]: [PATCH 6.18.y 1/6] bpf: Support for hardening against JIT sp=
raying ---
commit cb1a8f614dfc8fdb1bb7a2e56154f4f8e2cb7a53
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Support for hardening against JIT spraying

This commit introduces a mechanism to flush indirect branch predictors befo=
re
reusing JIT memory. The goal is to ensure indirect jumps in a newly written
program don't reuse branch predictions left behind by an old program that
previously occupied the same space.

> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -923,6 +933,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hol=
e_t bpf_fill_ill_insns)
> =20
>  	mutex_lock(&pack_mutex);
>  	if (size > BPF_PROG_PACK_SIZE) {
> +		/*
> +		 * Allocations larger than a pack get their own pages, and
> +		 * predictors are not flushed for such allocation. This is only
> +		 * safe because cBPF programs (the unprivileged attack surface)
> +		 * are bounded well below a pack size.
> +		 */
> +		if (static_branch_unlikely(&bpf_pred_flush_enabled))
> +			pr_warn_once("BPF: Predictors not flushed for allocations greater tha=
n BPF_PROG_PACK_SIZE\n");
>  		size =3D round_up(size, PAGE_SIZE);
>  		ptr =3D bpf_jit_alloc_exec(size);

[Severity: High]
This isn't a bug introduced by this patch, but does this logic leave large
privileged eBPF programs vulnerable to Spectre v2 attacks?

The comment here justifies skipping the flush by stating that cBPF programs
(the unprivileged attack surface) are bounded well below a pack size. Howev=
er,
in a Spectre v2 attack, the newly allocated program is actually the victim,
not the attacker.

If an unprivileged attacker loads and frees a small cBPF program to mistrain
the CPU branch predictors, and a privileged user subsequently loads a large
eBPF program (> BPF_PROG_PACK_SIZE), bpf_prog_pack_alloc() allocates it via
bpf_jit_alloc_exec().

If it reuses the same virtual memory, it explicitly bypasses the new
bpf_arch_pred_flush() call, forcing the privileged eBPF program to execute
using the attacker's leftover mistrained branch predictions.

Could large allocations also receive a predictor flush to ensure privileged
programs are protected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-cbpf-jit-s=
pray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com?part=3D1
