Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C81B3612F6
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773444939; cv=none; b=Hfjh4ke17zAgkBOWaRme6WFm/ZTTE9gYm5H0JT+cLgiPzBcfWQYK8oCKfPcju3qmIkEcHgDFAEbF+7Y+sj85WOaNPs5mmBeHRVfmYtztQCDAieELQdKZaFkgSQbJDxpdu4fiq9uUpUexxVSt9myWLZFGScgyrBbyND0J4ZHWKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773444939; c=relaxed/simple;
	bh=bMdBJC1K+T/ies3d8L0YBww39kxI8b3QD6ZE+BrxdBI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MmTg/CYtREqLc6r6tAaVYJUt3AJIPz/zJH1MrSNIWnsacGxdtMfjJkSncnnPX0f3d1Gai+gEnMLhfhzB4KhV2soYJd1EGmOMCV2NbW3fIU3EXaxKUd9oEprTL3O4H0fSzSMt9XnRbt2t5YzJ0ZbohlTVGX0ji0DLjO1KBTi9kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5odIBr5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5odIBr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAE0C2BC86;
	Fri, 13 Mar 2026 23:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773444939;
	bh=bMdBJC1K+T/ies3d8L0YBww39kxI8b3QD6ZE+BrxdBI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=k5odIBr5jtIUscBZkSu4XKvNgzIzUVTSMlzqfSAkgHZLiySHlv3CGSEEb9S5FKhgi
	 vS96TGYch3EpS0iIELHyuitS85jWA8EmOeIFpX7S+RM9p6UGsMw1q8ZyJYL6aGdlWg
	 ZJH9HmAlrDF7B0B+9MyCaLq7RLpCGHjMRbFiYDnemW63T+7amopFm+70uIbl+oB4tD
	 zaUeQFL2zA4kK57qoj44en9nQFlBdyjn0+869S9fPYq3tLvAjdf+ub8QN7eeSEzhUu
	 RbrXqMKJYB606uybKleDhk99dgez1S68oeHkNtljw5HSgTAkxFT5723uFtriE31GE0
	 oTshvsZY57uYQ==
Content-Type: multipart/mixed; boundary="===============7771227801683433341=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <755e283996c1d5dc61c29089abe5ee12475d4bb725d9c895231c7776fe0fb88c@mail.kernel.org>
In-Reply-To: <4233309514e3e1d70fc808daf86e28a499163280.1773441432.git.paul.chaignon@gmail.com>
References: <4233309514e3e1d70fc808daf86e28a499163280.1773441432.git.paul.chaignon@gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Cover invariant violation cases from syzbot
From: bot+bpf-ci@kernel.org
To: paul.chaignon@gmail.com,bpf@vger.kernel.org
Cc: harishankar.vishwanathan@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,shung-hsi.yu@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Mar 2026 23:35:38 +0000 (UTC)

--===============7771227801683433341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index ce09379130aa..20c857ba21a8 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c

[ ... ]

> +/* Last jump can be detected as always taken because the union of R5 and R7
> + * 32bit tnums produces a constant that isn't within R7's s32 bounds.
> + */

Should "union" be "intersection" here? The verifier uses
tnum_intersect() in regs_refine_cond_op() to combine the tnums
when two registers are constrained to be equal, and the commit
message itself says "tnums intersection."

> +SEC("socket")
> +__description("dead branch: tnums give impossible constant if equal")
> +__success
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void tnums_equal_impossible_constant(void *ctx)
> +{
> +	asm volatile("										\
> +	call %[bpf_get_prandom_u32];								\

[ ... ]

> +	if w5 != w7 goto +1;		/* on jump var_off32=(0xffffffd4; 0)=-44, not in s32 */	\

The constant 0xffffffd4 is produced by the tnum intersection on the
fall-through (equal) path of this BPF_JNE, not on the jump-taken
path. For the jump-taken (not-equal) path, regs_refine_cond_op()
does not intersect tnums when neither operand is a constant.

Other tests in this file use "on fall-through" to describe the
fall-through path analysis, e.g.:

    if w0 > 0x80000003 goto 1f; /* on fall-through u32 range ... */

Would "on fall-through" be more accurate here as well?

> +	r10 = 0;										\
> +	exit;											\


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23074156227
--===============7771227801683433341==--
