Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D282F0C7E;
	Mon,  6 Jul 2026 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783313002; cv=none; b=CMXcXn0C28SdXCDIJw/p3xnIiLF5mvyMjYhAnMybPKA1sHf2qYXzJEnBU2OyXG/cod12qzyzANeoo3LIoeuy3noKXCP+jjDGgFHUrewWQb+oGICAuc2VPoede0cb7mlD4Xk+fn9TLIgafUy/txDi8splAUHJJoJ8o1x0XJDcOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783313002; c=relaxed/simple;
	bh=Sas+xr71gb0o14YPdpuin1YXwm16GnjBeoDcfs+ubcE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=G4YA1xGJyA5lhQNpx4oRj5HJ1QbYVwSZYOLvb4hKuZfjtuwR53tD15g6wOw2fmCxj/JlYD1Noz3gW/vsP7CpbnbwJCLcV/NS2ILNlYqzhf9dQTeKdzzgx8FKlWLc8vGZ1LEeUTUdKJFK7Wn0IKaKv9tIIdlptkfHMtccs7FuLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehCCB5YA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehCCB5YA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B541F000E9;
	Mon,  6 Jul 2026 04:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783313000;
	bh=GBRUAnku0eJ+nBGIOMAS40ehCG+qhsYq54zeU9axnJw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ehCCB5YAE4oe8MQYIixOTSAoYbW029lOMH3MZJP7n8D856afk9MMLx/qhdVbXupbA
	 C7mJ2QP+d8OwUz0ejxZN5hI+vHFereheTzMgUauBKTnsKjDn9U3/btoIlJmFW6htKF
	 hqlIjgZUWK9I72sEjTckf0GHtzLOKj7v3wvmyzkarZo18Ez+gL8DEIVxSdO9FQplx6
	 jVft2+SE+qER5ysqdw/RLsH6b7QzJYY2jJ0GobjjUGOaqhtNcfB3yWglzHbcPdCThH
	 ZUdIk1YEVXvTRq5p+y/LUWtpbJ7m4jNf0QpeNTnNpwEXYrAyylvJdTsDjAuU9xVFp1
	 Bi3GYwaHI4wvw==
Content-Type: multipart/mixed; boundary="===============1535575153494113936=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4101e743dcdd3be2ff84acb696e37dfe9c67116e89568cbbf985679c8862d047@mail.kernel.org>
In-Reply-To: <20260706033906.1988-4-yangtiezhu@loongson.cn>
References: <20260706033906.1988-4-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2 3/4] LoongArch: BPF: Refactor jump offset calculation in tail call
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Jul 2026 04:43:20 +0000 (UTC)

--===============1535575153494113936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> In emit_bpf_tail_call(), the macro-based jmp_offset calculation relies
> on a fragile prediction equation: "tc_ninsn - (ctx->idx - idx0)". This
> calculation model utilizes tc_ninsn from the previous pass to estimate
> the remaining stride of the active tail call code block.
>
> Given that the macro relies on stale layout data from a prior pass to
> compute the active relative stride, the conditional branches end up
> encoding wrong immediate offsets under extra JIT passes. Consequently,
> the execution flow leaps into misaligned instruction boundaries,
> triggering soft lockups or early loop collapse.
>
> To fix this issue, drop the pass-dependent macro and the intermediate
> variable entirely. Instead, explicitly calculate "jmp_offset" using an
> absolute target reference anchor: "ctx->offset[insn + 1] - ctx->idx".
>
> However, during the initial size-estimation pass, the target address
> "ctx->offset[insn + 1]" is not yet populated and will evaluate to 0,
> resulting in "jmp_offset = -ctx->idx". For large eBPF programs, this
> inflated negative offset would overflow the 16-bit signed immediate
> limit of LoongArch conditional branch instructions, causing the range
> validation inside emit_tailcall_jmp() to abort the JIT compilation
> prematurely.
>
> To bypass this initialization bottleneck cleanly without changing any
> function signatures, leverage the "ctx->image" pointer to safely detect
> the initial pass. Since conditional branch instructions on LoongArch
> maintain a fixed 4-byte width regardless of the target displacement,
> injecting a safe dummy offset (0) when "ctx->image == NULL" preserves
> accurate size estimation while preventing 16-bit range check failures.
>
> Within this new deterministic arithmetic model:
> 1) "ctx->offset[insn + 1]" maps directly to the absolute instruction
>    index of the immediate next eBPF business instruction, serving as
>    a rock-solid target label.
> 2) "ctx->idx" tracks the real-time instruction index of the conditional
>    branch currently being emitted.
>
> This guarantees the generated immediate offsets always land precisely
> on the next instruction boundary under all multi-pass compilation paths
> and all code size dimensions.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

This looks like a fix for wrong branch offsets in the tail call path.
Should it carry a Fixes: tag?  The tc_ninsn macro and the

  tc_ninsn = insn ? ctx->offset[insn+1] - ctx->offset[insn] : ctx->offset[0];

calculation being removed here were introduced by:

  Fixes: cd39d9e6b7e4 ("LoongArch: BPF: Fix jump offset calculation in tailcall")

This isn't a bug, but could the changelog be tightened?  Phrases such as
"rock-solid target label", "deterministic arithmetic model",
"initialization bottleneck", "eBPF business instruction" and "all code
size dimensions" read as fairly ornate for an offset-formula refactor.

Could it just state that the old macro derived jmp_offset from a stale
prior-pass stride while the new form anchors on ctx->offset[insn + 1],
with the ctx->image == NULL guard avoiding a false 16-bit range abort
during size estimation?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28766636714
--===============1535575153494113936==--
