Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85572F0673
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122200; cv=none; b=sUBKgj7p6olljflF6XFEk2cAIzT0pf7izZmmT7vkHUZmUXH47yYj4z5r0y8BNyYXWI8NGAarSqJ1PU1wW0Uqx5GU/yaOVGYV590e4aB/NXnTV0kRBpvASN/6BOLc55Jn8YiQd3R4YM7DOdvqk0iRaq1d0WgZCigR8ai9Y7XhBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122200; c=relaxed/simple;
	bh=H360z6FtScJxvw6sUwKknJM0VU0pi2M6gFLP4d2gycM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JgN0T5v/LLI1cCbPwNS1c4tJYFtfA+oImCMYJG7CoFmF0KPsEo8xSsEvP2Q2yS76hqNgXwxGdSnj3rUbEfzeS0jkl14p8VHakFFYzc/gh/MLOomOSfS9ZuGeqTC3cO5Duzvh0IuB20QxUdBJOp4Gz3Wox0f8qj25duNf6UlQt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3d+gIRY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3d+gIRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7FD1F000E9;
	Wed, 19 Aug 2026 06:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787122198;
	bh=H360z6FtScJxvw6sUwKknJM0VU0pi2M6gFLP4d2gycM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e3d+gIRY8P03PVuMYCj//WfWlllmI5rEJFEfPKv33zDo5Qfg3k/4ezQJNy/MuJmx+
	 j4Xpioj/grsCUa0SmpBVpy8y6TkyHm3ucGPBVay9X+7DZbfCPI0XcYvdykg1oabn4g
	 IX5Y77fc7pbwSFj1lRYdWyuJUx0OGHBFhrDT9QO5gSeDfnu/48G6ik28EstfIlEcb9
	 PrN8wMvWptkqUraTBuA7uSdCF4fXViDKSoqWgGjAO/+MyGwD9ooP191NXeeR9W3Zs2
	 rw6Rww4kbsWNr0yPyB9qd2v/y/wNISKK61ZabcdTBLWqliwDyHf/F+bKo+Iu9wovcI
	 CyVyIobVOcyog==
Content-Type: multipart/mixed; boundary="===============0308866479930513609=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4533383af7562516a24ecadf8e2242d17e50ab4e8835bb8c9baf573b37944b0a@mail.kernel.org>
In-Reply-To: <20260819055254.3295610-1-yonghong.song@linux.dev>
References: <20260819055254.3295610-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v7 03/10] bpf: Wire up JIT support for 16-byte kfunc returns
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Aug 2026 06:49:58 +0000 (UTC)

--===============0308866479930513609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Wire up JIT support for 16-byte kfunc returns
>
> LLVM 23 returns an __int128, or a struct/union larger than 8 bytes and no
> larger than 16 bytes, in the BPF R0:R2 register pair. The previous patch
> added the shared helpers describing that convention; wire up the JIT side
> so that the second half of the return value actually lands in R2.
>
> Placing the second return half into R2 is possible on any JIT, but it needs
> architecture-specific JIT work. Rather than requiring every JIT to
> implement it at once, add a bpf_jit_supports_kfunc_ret_reg_pair()
> capability, defaulting to false in the generic core; an architecture opts
> in once its JIT handles the R0:R2 pair, and the remaining ones are left for
> future work. Only the x86-64, arm64 and riscv64 JITs opt in so far.
>
> On arm64 and riscv64 the native second return register is already BPF R2
> (x1 in bpf2a64[] and a1 in regmap[] respectively), so the upper half needs
> no move at all, unlike x86-64's RDX->RSI. The lower half is covered by the
> move into BPF R0 that those JITs already emit after every call, from x0
> into x8 and from a0 into a5. This has been tested on x86-64 and arm64. The
> riscv64 path is expected to work by the same register-mapping reasoning as
> arm64 but has not been tested.
>
> bpf_add_kfunc_call() also rejects a kfunc that is marked KF_FASTCALL and
> returns more than 8 bytes. The bpf_fastcall contract implemented by
> mark_fastcall_pattern_for_call() assumes a call clobbers R0 plus the
> registers holding its arguments, so a return in the R0:R2 pair would
> clobber an R2 the caller expects the fastcall pattern to preserve. Such
> a kfunc is rejected with -EOPNOTSUPP as well.

This isn't a bug, but could the closing sentence be folded into the opening
one? The paragraph opens by saying bpf_add_kfunc_call() rejects a
KF_FASTCALL kfunc that returns more than 8 bytes, and closes with "Such a
kfunc is rejected with -EOPNOTSUPP as well", which restates the same fact.
The middle sentence carries the rationale (the fastcall clobber mask covers
only R0 plus the argument registers, so R2 is assumed preserved), while the
closing sentence adds only the errno. Something like "... is rejected with
-EOPNOTSUPP" in the opening sentence would let the paragraph state the
rejection once and spend its length on the fastcall rationale.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32221968339
--===============0308866479930513609==--
