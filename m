Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA42931C7
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056663; cv=none; b=EgD+LOXPJFeOIrZjpnuwJcN895pwuO8UHWwnYtsXRgvswT8jxcXh2R/hPxiitNe2EK0We9YSk27CUaB7KiDi31RMgt1DI5MRWbwf+sKvhgMa3obEIFsoVoxFogR4kC+XlYCj4Fbm2RbqYbARTs8+1iY45w1RItPGi/bjA8VoKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056663; c=relaxed/simple;
	bh=m3PDCgERRzNJX3HzUg988ijwQifKMGI0V0uMgi6yOzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TMIiN3zvlSiKh2A1UMwxstwDdZvUgilf8oXlVK5TYtWYudG5hng24u0HH9b8b4Ry1pD7qBKCAnxLU4L9oiyG38tSXxsUhig5hU1nj9IgWcakC1zJ9D+91AcxXXsyAvVAA0WtIAVwYva9ltnBngZswcYomaxuxjEobqg8eojhGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfOmb8dt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfOmb8dt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283AD1F000E9;
	Tue, 14 Jul 2026 19:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784056662;
	bh=QKVAoefZ2E8ePaHgHMEnFo3UCN1cXY1O730SneDGln8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kfOmb8dt+fRlHSo6+17T0fAhL+Y95xxLcqsYy3/bw1OLIgL10kZNtFQAHLB4vdzgB
	 JiZM3aIwcfjGNhO0ywnvfmrrcf7VgVOVW4xuU/+Sgn1FTmsTXtVpj8M5d9sIle6Qte
	 ggcScUhXJUdtcarocTMhrJs5rOcit3lH51J89GFG9k8jh4L9s6EONMYY0fhmdFyFCt
	 HSPKFNLU8wE/+ZxbOkg/aA7r3GOCAciZybzCuqEfSZlBTErs5U+hZjpTxNiFGiCTxC
	 Pn0SRZU5Y6cGtLHSoCrYwo0hTqpAliPYSl6z5q3QYVw1qnQE8aBq4PCiObI7PkXrj3
	 quATbRO51dlYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.16.y 1/6] bpf: Support for hardening against JIT
 spraying
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-1-2fc3e16263ac@linux.intel.com>
References: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>
 <20260714-cbpf-jit-spray-hardening-6-16-y-v1-1-2fc3e16263ac@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:17:41 +0000
Message-Id: <20260714191742.283AD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The branch predictor flush is bypassed for BPF allocations larger =
than BPF_PROG_PACK_SIZE, leaving privileged BPF programs vulnerable to Bran=
ch Target Injection (BTI) / Spectre v2 attacks. The author's rationale for =
skipping the flush assumes attackers cannot allocate large programs. Howeve=
r, an attacker can train the BTB using small programs and free them; a vict=
im's subsequent large allocation can reuse the same virtual memory and will=
 skip the flush, inheriting the poisoned BTB entries. Additionally, on conf=
igurations where PMD_SIZE is undefined, BPF_PROG_PACK_SIZE defaults to PAGE=
_SIZE (typically 4KB), which unprivileged cBPF programs (up to 32KB) can ex=
ceed, directly bypassing the flush.
--

--- Patch [1]: [PATCH 6.16.y 1/6] bpf: Support for hardening against JIT sp=
raying ---
commit 86ef6d6286895019e1dbe8a1db211825e4c28b04
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Support for hardening against JIT spraying

This commit introduces a branch predictor flush before reusing BPF JIT memo=
ry.
It aims to prevent indirect jumps in a newly written program from reusing
predictions left behind by an old program that occupied the same space.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 17e5cf18da1ef..48208c3f58143 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -951,6 +961,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hol=
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
>  		if (ptr) {

[Severity: High]
Does skipping the flush for large allocations leave them vulnerable to BTB
poisoning if the virtual memory is reused?

If an attacker trains the BTB using small programs and frees them, and then=
 a
victim loads a large program that reuses the same virtual memory, wouldn't =
the
large allocation skip the flush and inherit the poisoned BTB entries?

Additionally, on configurations where PMD_SIZE is undefined,
BPF_PROG_PACK_SIZE defaults to PAGE_SIZE (typically 4KB). Could unprivileged
cBPF programs (which can be up to 32KB) exceed this and bypass the flush
directly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-cbpf-jit-s=
pray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com?part=3D1
