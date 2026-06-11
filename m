Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB11D6BB;
	Thu, 11 Jun 2026 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781145416; cv=none; b=V57u+5PYkxo/cSkZtBLysYy6HRXKaedOs2BEs6TnEzvHjrshtIgE96ptajWaNb/RcmmpwgWV+I7XuBNlCoQzmt4xGCraiyp4r78Y0uqo37QZhIzymUFkUneUYGBxuRYAlSwjXUu6NZhov77FDUgok5xyEOozzMie7sQzWgg3VjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781145416; c=relaxed/simple;
	bh=jzn8yOwuS8f2Lr55eqFMTLaPXrFGP0xswUSN6RStLCw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=edzL8MMTAuvuXgXM1hdfVeRrXjLuDJ5Q8ZBfm2+Pm2m+wEO5/bufwq6wFg89TEIycA1ymf2I4ErK8mBg+Aag8gw6qDGvyG1UvhogVPkaBm+ZjdR6oJi5gRAWMcsjKqnm5Q1HBAzCE0BTC3CcW8XywlNkVG1kGZwNI+97U0R53Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dawE6b+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dawE6b+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2921F00893;
	Thu, 11 Jun 2026 02:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781145415;
	bh=X9OYz5t8xJLcL+vYKujbjghdAWjsD0DVmEpwDLtPADw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dawE6b+WEDVkro/csMWQ/e7sIgRtbUPa0L6r5yBoRkFYa7TTnkDz5bimP9j7K8/9o
	 mVywXqnoWHUdsLz3rnHXJd7sC9SRmgFX8XMvkI2u4IpLrj+U8YAlBLzjiGdAc//DaJ
	 PZsB/BjIRq3DMDCu1TG1RrYqLSJS4+zzOFaPcNyXSbH1KeSLVSHls5T+kuuQ8Ixqxf
	 LaJUQI3I6zOkCgFDwLDzapgjS+L/FT+xC+J6az35tsGz+Tbk2wNbgaqx/Cp24jYACN
	 OepYOoaS1elElJnp2yCa8GNsG5q2BZHZSEWhfy3fCfngRKnTFvdnR/rt3UyJEmbfXK
	 7Uv+wSxyldQJQ==
Content-Type: multipart/mixed; boundary="===============7064045760643706982=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b88f6055e63f7f4084159c428dc427047d4074517c929f0ce4d6e7bb2b0d57f9@mail.kernel.org>
In-Reply-To: <20260611015327.12108-3-yangtiezhu@loongson.cn>
References: <20260611015327.12108-3-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2 2/3] LoongArch: BPF: Inline bpf_get_current_task{_btf}() helpers
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 11 Jun 2026 02:36:55 +0000 (UTC)

--===============7064045760643706982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The pointer to task_struct is always available in the $tp register,
> the calls to bpf_get_current_task() and bpf_get_current_task_btf()
> can be inlined into a single move instruction.
>
> [ ... ]
>
> This is similar with commit 2bb138cb20a6 ("bpf, arm64: Inline
> bpf_get_current_task/_btf() helpers").
>
> Additionally, a safety check for bpf_jit_enable is introduced in
> bpf_jit_inlines_helper_call(). If CONFIG_BPF_JIT_ALWAYS_ON is not
> set and JIT is disabled at runtime, the function returns false to
> safely accommodate the fallback path to the BPF interpreter.
>
> Without this check, bpf_jit_inlines_helper_call() unconditionally
> returns true. As a result, the verifier would skip fixing up the
> call offset, leaving insn->imm as the raw helper ID rather than
> the expected "insn->imm = fn->func - __bpf_call_base".
>
> When the fallback interpreter executes (__bpf_call_base + insn->imm)
> with this raw ID, it jumps into an unaligned invalid address space,
> triggering a fatal instruction alignment fault (ADEF) kernel panic.
>
> [ ... ]
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

The commit message describes a kernel panic on the interpreter fallback
path, where bpf_jit_inlines_helper_call() returning true caused the
verifier to skip rewriting insn->imm to (fn->func - __bpf_call_base),
so the interpreter ran (__bpf_call_base + raw_helper_id) and jumped to
an invalid address.

The bpf_jit_inlines_helper_call() contract, and the verifier logic that
skips the call-offset fixup when it returns true, were introduced
together with the unconditional return-true pattern that is now being
guarded with the !bpf_jit_enable check.

Should this carry a Fixes: tag pointing at that commit, for example:

  Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27319300857
--===============7064045760643706982==--
