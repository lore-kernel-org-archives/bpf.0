Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7717C46EC8B;
	Tue, 21 Jul 2026 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660865; cv=none; b=EC2FRygejJ2fthwwJwuRYhXohPLs38AOyR82QA1B1qKG4JiLt7HE3UorYJJJfgQsGE3goPO9ya38/CPuAuKk05LCEa0spnFzPOTZMKu6iV79exYnCwbqjOnwyqLcvATgSqDTI5t0ciwqtBvK06YDuIuDqZgEHcHFOPugirgciOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660865; c=relaxed/simple;
	bh=g3UESF0jmKsVW/YZYPXlBH+vU3LS5vvNH2SAXn2BWWo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=enttkSXGBrNhlGk2hiUbESNJE7eduDrcMg4ZPXNvrzhUdv37FGgbYBUe8hO/kZ0/Y5vH66pyFNAvk8RID16DiYScvPcH8GDf6FMP1I/TACh95pr96WDShDs3jv18Rvy69C41uzqs698ObCSD1cMav0GGAuLGMkRVqGO9t8LxOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoW4YXVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoW4YXVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF631F00A3D;
	Tue, 21 Jul 2026 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660864;
	bh=jO0/2cUFSfJfUInWRqnTQm+AnMMMe2mlsvbtLOiV2H8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AoW4YXVJ02vy+5ip6lVnZK+SxEM4rmbC7U/LNlCfV/Ru4FqkriBu4ADmsVeftBIFQ
	 7HYaBpI60RG6mVsCls8XTlQTyI/PVHT/j6+oStbYKm53tB6W7EPWJthJ+1HYyu0Rzj
	 FAppWci30c3pA7p76RpgrmzGmzG7FNvxwwfC8AcFl+8BjZsN0scUDjK3uz6NEI8NwE
	 j9E2Jdntv89xqNrkoKWeTF0iM/RHRbl+Bn6K0wPbKJlqLxCNW3hfN63yKnZi4gdvn5
	 hGy2KFwugwKn4hUX8x/8tDuB3uIC/LFos5y7gbLVGX51Pc5hromZyTxxPD9rSRVo5Q
	 4JAqmlg2noq2Q==
Content-Type: multipart/mixed; boundary="===============6575185754722284764=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1873dbb2968fcd362a2704fbd8ddda4c2240c8f6ab061cb6f1d352b7e657b74a@mail.kernel.org>
In-Reply-To: <20260715-riscv-bpf-timed-may-goto-v3-1-cf2a9c3d843f@kylinos.cn>
References: <20260715-riscv-bpf-timed-may-goto-v3-1-cf2a9c3d843f@kylinos.cn>
Subject: Re: [PATCH v3 1/2] bpf, riscv: add support for timed may_goto
From: bot+bpf-ci@kernel.org
To: jiangfeng@kylinos.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,jiangfeng@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Jul 2026 19:07:43 +0000 (UTC)

--===============6575185754722284764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/Makefile b/arch/riscv/net/Makefile
> index 9a1e5f0a94e5..6458d4d51990 100644
> --- a/arch/riscv/net/Makefile
> +++ b/arch/riscv/net/Makefile

[ ... ]

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 2f1109dbf105..ca9d0e811aea 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1834,7 +1834,13 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  		if (ret)
>  			return ret;
>
> -		if (insn->src_reg != BPF_PSEUDO_CALL)
> +		/*
> +		 * arch_bpf_timed_may_goto() is emitted by the verifier and
> +		 * returns its result in BPF_REG_AX instead of BPF_REG_0, so
> +		 * skip the normal "move return register into R0".
> +		 */
> +		if (insn->src_reg != BPF_PSEUDO_CALL &&
> +		    addr != (u64)arch_bpf_timed_may_goto)
                    ^^^^

This isn't a bug, but could this fit on one line? The 100-character line
limit would allow the full condition without the break.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29858413299
--===============6575185754722284764==--
