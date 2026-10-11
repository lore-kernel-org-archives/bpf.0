Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9754705E
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791701755; cv=none; b=ZxJNHgoWuCAO3FpuEAGxYKGvb1VdtnC92seDNRbnEU0cAxvTW1xtSLu4azmpd83Bp64u1GxVmzq8DcscstwUQoCrih9sYtZWBYGsOVsKODJ9fSG/r6Xdc7bvfJT21RcVM2yXk177uTdHYlgg2sKLPYWXrqCCPGoEBFOLmhNUJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791701755; c=relaxed/simple;
	bh=gkDesfd2d+ONuhSV3Dd6jv8rV3ZJQlbaCQHxx67pysQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mxvehFvRm2YgpwdhumyURAw6LjBSljeKZ77K3YT2vBQ/7vX3in9kQhfdiGOIrfuf091Ny903bCPTjlfqcJAYB+AkXGS5cARKiN88qPltyq/UI0ey8oJBxqDoIk7oV7VfWzmHA5TyHSZT901KMz6JK7jEY0H4ox5blyOraoJdeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvZ+FWIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvZ+FWIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4AC1F0089B;
	Sun, 11 Oct 2026 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791701754;
	bh=hyOyUty0j25Hx7bUoLgxPI2uEh0EDiqH1ziEuVE1soc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cvZ+FWIRySnV3i5MCSr7Dg1+QNonI40kqFauPmo7Q55mRLGW2sHJ5y3me7R0hvLVQ
	 UIhUA1cInNZm5YKch9aQnlo6VC6wACZCbJGA+lIgChyFchiDAXAsUv6jCSbKuQYUrp
	 mdaitQkzIfFX/ajV0aDPaWjSa7z4f/XktZQ/7NUbeRvEKWidfqWvq79hbho2IDMiu7
	 SB5wQsV3IKXH/S/jkH+y64NQ+rjgQyr0xdXDbBxAiRQFBJMr17IDPLAtblvKQ9TeyB
	 aWz/W2ldYw4FDh3wLNaappA65pveiNETzbn25tLks8v8yaCvQJBf2ScIZ3BJ4X25Uc
	 23qHlowV9VpkA==
Content-Type: multipart/mixed; boundary="===============4249346491230009379=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c2116bd1e90f86167890068e43ea3b30412c7ecae7378dde48e83f1399e79fdc@mail.kernel.org>
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-3-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-3-6000e95ef993@gmail.com>
Subject: Re: [PATCH bpf-next 3/9] bpf: avoid duplicate declaration for BPF_SCEV_REGS_NUM
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 11 Oct 2026 06:55:52 +0000 (UTC)

--===============4249346491230009379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: avoid duplicate declaration for BPF_SCEV_REGS_NUM

TL;DR: Commit message only: the body may blame the wrong commit for the
duplicate BPF_SCEV_REGS_NUM define (it disagrees with the Fixes: tag), and the
subject says "declaration" instead of "definition". No code issues.

>     bpf: avoid duplicate declaration for BPF_SCEV_REGS_NUM
>
>     The "bpf: Use SCEV to widen bounded loops" commit introduced a
>     second (identical and unnecessary) definition for the
>     BPF_SCEV_REGS_NUM macro.
>     Fixes: 088a5477a9bd ("bpf: Avoid widening registers that hinder exact stack-slot tracking")
>     Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Is the commit message body attributing the duplicate to the wrong commit?

The body says 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
introduced the second definition, but the Fixes: tag names 088a5477a9bd
("bpf: Avoid widening registers that hinder exact stack-slot tracking").

Looking at the history of the macro:

  git log -S'define BPF_SCEV_REGS_NUM' -- include/linux/bpf_verifier.h

6ccf49f79327 added the first definition, just before struct bpf_loop_iters,
and that is the one this patch keeps.  The definition this patch removes,
just before struct bpf_loop, was added by 088a5477a9bd, which matches the
Fixes: tag but not the prose.

Could the body be reworded along these lines?

  The "bpf: Avoid widening registers that hinder exact stack-slot
  tracking" commit re-defined BPF_SCEV_REGS_NUM, which was already
  defined by "bpf: Use SCEV to widen bounded loops".

This isn't a bug, but the subject says "declaration" while the patch
removes a macro definition.  Would "definition" be more accurate there?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38118645453
--===============4249346491230009379==--
