Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5157E2BE657;
	Fri,  6 Feb 2026 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382297; cv=none; b=t+SgqirZNKC4WpPAGyxTMR+73fDa9e/FauSBhf6PFX8u9j1YVbTbYxc6Tt5FgrJLZlIrLFticI+UvnM4iVMcR6Q4ARd33aCHImrSuSdn7Bki3P85ySRurv6I2LKN7RPAjHZ6QWXy8SzN2dZLN/mt6GvKZs2a2vO/6xgl2RV8pSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382297; c=relaxed/simple;
	bh=PJCZdzpr3NavBlBPuv0+ES9dELxv1rsduvAcfJuPO08=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K47SpA7EotfUUfMpc4/yTgz0rsuYkGBnxFDKQDDuZCTBHm9wvApmqmtz09drOk1mLqtXwviRLf7ah3r62Iu3q0oXMS9RVKc8xm8jnQPZKsiPkMnPUJeVdPMEGrvTGNWdVEAtu/B71SjE52ER7zd0wiOndsNj3XRrKjVXw8xnzf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMWdBh+u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMWdBh+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02F4C116C6;
	Fri,  6 Feb 2026 12:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770382297;
	bh=PJCZdzpr3NavBlBPuv0+ES9dELxv1rsduvAcfJuPO08=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VMWdBh+ud1PH6yem4zpvSyp2ung1EZrZRF8HbgGB10yBKHiYer42VtpTSJifMMVAK
	 QDut8rfkRmk5o5/2Pr8W0rWku9z3t6qolfgIgM0Pz0wy8mEY8jfjw4CCz/GHRyZcB+
	 /v7i/T6SSAvnwtQTWDlGgv6PVwF7u6oiVzenWF2xR4nrdzEmLUnzFFiRlYLj9NKOjw
	 EuW8n1rVbTmmjEsxX2FySRGaOMedwtIep9Vn1EiHCS0d7OQwwao+tIMqyeVg6KwpcN
	 XW6GmwJzRIBhk0RZ1dCjD0advqmY9ZfH4uJUzlDUDfRO12kyLM/jhJxe7m3zn5twsL
	 wFdBzH2mAdh3Q==
Content-Type: multipart/mixed; boundary="===============3134334814036554971=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <444267200b59241e9da104eab8af2d7189aa401005887a2cd0128cd6aeda98e2@mail.kernel.org>
In-Reply-To: <20260206122002.1494125-3-dongml2@chinatelecom.cn>
References: <20260206122002.1494125-3-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v3 2/3] bpf, riscv: add fsession support for trampolines
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org,bjorn@kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,pulehui@huawei.com,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,jiang.biao@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  6 Feb 2026 12:51:36 +0000 (UTC)

--===============3134334814036554971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c

[ ... ]

> +static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
> +		      int run_ctx_off, int func_meta_off, bool save_ret, u64 func_meta,
> +		      int cookie_off, struct rv_jit_context *ctx)
> +{
> +	int i, cur_cookie = (cookie_off - args_off) / 8;
> +
> +	for (i = 0; i < tl->nr_links; i++) {
> +		int err;
> +
> +		if (bpf_prog_calls_session_cookie(&tl->links[i])) {
                                                ^^^^^^^^^^^^^^

Should this be tl->links[i] instead of &tl->links[i]?

The function bpf_prog_calls_session_cookie() expects a struct bpf_tramp_link
pointer, but tl->links is an array of pointers, so tl->links[i] is already
a struct bpf_tramp_link pointer. The extra & passes a pointer-to-pointer.

For comparison, arm64 uses:

    if (bpf_prog_calls_session_cookie(fentry->links[i]))

And include/linux/bpf.h uses:

    if (bpf_prog_calls_session_cookie(fentries.links[i]))

Both without the &.

> +			u64 meta = func_meta | ((u64)cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT);
> +
> +			emit_store_stack_imm64(RV_REG_T1, -func_meta_off, meta, ctx);
> +			cur_cookie--;
> +		}
> +		err = invoke_bpf_prog(tl->links[i], args_off, retval_off, run_ctx_off,
> +				      save_ret, ctx);

Note that invoke_bpf_prog() correctly uses tl->links[i] without the &.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21750727924

AI-authorship-score: low
AI-authorship-explanation: The code follows kernel conventions and has been reviewed by maintainers with acked-by tags, indicating human authorship.
issues-found: 1
issue-severity-score: high
issue-severity-explanation: Wrong pointer type passed to bpf_prog_calls_session_cookie() will cause undefined behavior when accessing session cookie state, breaking fsession functionality on RISC-V.

--===============3134334814036554971==--
