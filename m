Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3A42A79C;
	Wed,  8 Jul 2026 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508376; cv=none; b=tgBHJu4kOmEae8gp6s1WSEVI/58eihGgl6eBfgAE5nAJRF6dLlRycvj8pcXuGGMKzM4HzLbI8P/uOMvJEwDGiAumxxXBnybm0/qrSC72z6hH+TjJQlDkMg+BuZZ9P3V/WvYGhm9zGjxwKIkbAjhPjGxspYK/aW9dRAT9ISiviZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508376; c=relaxed/simple;
	bh=nOuiTWF+u7cjBICpPN8FjJkpQpO1UYr/qs6FkLG+ESM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AqSgkVzTUc6i7L1g9r6iJc4p7vJyYCFkdQoaxFTWpj5VMJbZGYodmemQqgZ2+dQS6z/DaXAO75486SSuKsrsFkztH4PhG8K4ivFCxQq7FQIfMU+1Lh49YRLCWIFkHLB5UHpYtc2nKJmoSuu/HNgcYEQwl7Jm1MlxLjYAPP7ayS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEWao67x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEWao67x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AE31F000E9;
	Wed,  8 Jul 2026 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783508373;
	bh=aljPv/nGMk0dXhlKbw1VKD54791iL2H3MScepmYg0zE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dEWao67x5vSVA8kUWB5mqxUrVFXcACgnKR2311tJnnjX3Xksodi7/tlf6WmAXpHdG
	 +H6Ubrs22Tivchtjf+4rz8FS9DRkshhI6X1CnV9zNX41zyKp7BWGhjJ9eFZtd1BpUd
	 e607a/T/2RBEZSXir2HDkXTdxxIIJIHQ40WzvJB2On6lhdSPtH052QbKHn0wGqi1wA
	 JSocmVsCej/L9jvCp3HpjhaAQy16RLO8/UEhEDATr049rG7Kf7DOxvPJl/1zPs0BMX
	 wBG6G94fsauY0rhhaLqZPggVbZLhw40rW3zeMj9sC7b+xvSXuS84h0iHS99xq19oGy
	 tNeZsLg88te2w==
Content-Type: multipart/mixed; boundary="===============8829270343334854318=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ec55680c84f90a8fdd97e0788926d322ea765e18df1604bf71fbd00b45b52f73@mail.kernel.org>
In-Reply-To: <20260708101806.18885-3-yangtiezhu@loongson.cn>
References: <20260708101806.18885-3-yangtiezhu@loongson.cn>
Subject: Re: [PATCH bpf-next v9 2/2] bpf: Reject programs with inlined helpers if JIT is not available
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,kafai.wan@linux.dev
Cc: bpf@vger.kernel.org,loongarch@lists.linux.dev,leon.hwang@linux.dev,puranjay@kernel.org,bjorn@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 10:59:33 +0000 (UTC)

--===============8829270343334854318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> When an architecture (such as LoongArch, ARM64, and RISC-V) implements
> bpf_jit_inlines_helper_call(), the verifier skips rewriting the helper
> call offset (insn->imm) in bpf_do_misc_fixups(). This is because the
> helper is expected to be inlined by the JIT compiler later. Therefore,
> insn->imm remains as the raw helper enum ID.
>
> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0) or
> if JIT compilation fails dynamically (e.g., due to OOM), the program
> falls back to the BPF interpreter.
>
> When the interpreter executes (__bpf_call_base + insn->imm) with the
> unpatched raw ID, it jumps into an invalid address space, triggering
> an instruction alignment fault or a kernel panic.
>
> Although these helpers have valid C implementations in the kernel, the
> omission of offset rewriting makes runtime interpreter fallback fatal.
>
> Fix this by setting 'prog->jit_required = 1' when helper call rewriting
> is skipped for JIT inlining. This ensures that such programs are safely
> rejected if JIT is not available, preventing the runtime kernel panic.

The commit message gives two reasons for the interpreter fallback:

> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0) or
> if JIT compilation fails dynamically (e.g., due to OOM), the program
> falls back to the BPF interpreter.

Is the "fails dynamically (e.g., due to OOM)" part accurate?

The JIT decision looks like it is settled before verification runs:
bpf_prog_alloc_no_stats() sets fp->jit_requested ahead of the bpf_check()
call in bpf_prog_load(), so the choice between JIT and interpreter appears
to be made at load time rather than changing after a dynamic JIT failure.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 02246df2f6c3..d3be972714b2 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1840,8 +1840,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  		}
>
>  		/* Skip inlining the helper call if the JIT does it. */
> -		if (bpf_jit_inlines_helper_call(insn->imm))
> +		if (bpf_jit_inlines_helper_call(insn->imm)) {
> +			prog->jit_required = 1;
>  			goto next_insn;
> +		}

If the JIT decision is final at load time, would gating on
bpf_jit_inlines_helper_call() together with the jit-enabled state be
enough here, without depending on the dynamic-failure rationale?

This point was raised during review of an earlier version of the series
and does not appear to have been answered before this version, and the
disputed wording is still present in the commit message.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28935824036
--===============8829270343334854318==--
