Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B928C840
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710272; cv=none; b=aUR5KJgtIUpEVgLDKrkvicLro7Dnr5IK2VMgjN9jmLfW76NSbvKbpa56YCwhQefvd6p+jNz9bZLEZmSQDQthe+OvNd4zXfpN7kl+jho4sYIzJ041+jqMsDxeZgwE0+Mat2qWuyUM+gdtt2cWUZ5OSVf1BgHyOZqCwa42hfhjDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710272; c=relaxed/simple;
	bh=wnnKFJcCraSLdRTqdSMS5++hwp1tCiqDk6l8c5iv6k8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aDi4rZKzojVbwHpOvPvdcvM4AbogHGBXpslXLwx1qL/Q1JGHmRbQBB+XcKThHMWWPKhaac7IqTq0E2/e83cRuoeUIGysbm1fEUbB/XOXt3FsQRcUdmqyfUQwtrIbyaKwXPS1hKmyG+F/AKI6InREJTuuniCblhSifkwjlgeXm/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tun85uBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tun85uBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C396E1F00893;
	Fri, 18 Sep 2026 05:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789710270;
	bh=9ELzDtH0CwyLOPRWO7cQkwu5T8RPnfsje4rrN1RaYuo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Tun85uBpKOZ3sVoOXIUKYA0hAXjxdeNwDYcCPlJr2m3zUr/mfAeyGJl/jpEsEiqvA
	 l1OyN1ZAE8GaoaJLZhuLoDphxnhSNshKgnkYynB4Af7Qdk/cVxSJVasSqqR5O5P/xY
	 BVhroJVT9XT5Mh24MUDj/vq1SWkDn+FQ4So+YMno7zD9wWwemGp/TrzvitvYfclc3d
	 2L1OLx5FvNSILBQva59snZfTI7+5bqQBo9s2/BQZr41hwdtA8c3AyEBnY2F3orI1uX
	 gXKskjnU4omtSzrxX+PWRDp5gbTC0H2/oIkKovOWTlfK+rzwiLMBihzuHYQP1gO0s2
	 xvpN7Y5jw3QQA==
Content-Type: multipart/mixed; boundary="===============7192484442512092886=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d68bdd97e85a2c8b74ab62769fd7846a3f9c83f825697eb9fd35a6723842a73@mail.kernel.org>
In-Reply-To: <20260918044243.3288865-1-yonghong.song@linux.dev>
References: <20260918044243.3288865-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 09/20] bpf: Refuse a private stack for a program with an exception cleanup table
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 05:44:29 +0000 (UTC)

--===============7192484442512092886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> A landing pad is about to start running outside its own frame, on the
> bpf_throw() walker's stack, with that frame's registers put back from a
> spill area whose contents arch_bpf_run_cleanup_pad() knows how to read. The
> x86-64 JIT addresses a private-stack program's frame through a scratch
> register that it recomputes after each call rather than through rbp, and no
> spill area holds that register, so a pad there would address its frame
> through whatever the kernel left behind.

The description says the x86-64 JIT 'recomputes after each call'. Does the
JIT actually recompute it?

Looking at the x86 JIT, emit_priv_frame_ptr() (arch/x86/net/bpf_jit_comp.c)
is emitted once in the prologue, and the value in X86_REG_R9 is carried
across calls by push_r9()/pop_r9() around each call site; BPF_REG_FP
accesses are rewritten to X86_REG_R9.

The load-bearing half of the argument is still correct -
arch_bpf_run_cleanup_pad() (added later in the series,
arch/x86/net/bpf_cleanup_pad.S) restores only r15/r14/r13/rbx/r12 and rbp
from the spill area and never restores r9, so a pad in a private-stack
program would address its frame through a stale register.

Only the described mechanism (recompute vs save/restore around calls) is
wrong, which makes the justification harder to check against the JIT.

> Everywhere rather than arch-conditionally: arm64 keeps its private
> stack pointer in x27, which is in the prologue spill and so survives, but a
> rule that holds on one arch and not the other is not worth the second code
> path when nothing is lost but an optimization.

Does 'nothing is lost but an optimization' understate the effect?

The private-stack mode also changes the verifier's stack-depth accounting,
not just JIT codegen. In check_max_stack_depth_subprog() a
PRIV_STACK_ADAPTIVE subprog is checked against MAX_BPF_STACK on its own ('if
(subprog_depth > MAX_BPF_STACK)'), while a NO_PRIV_STACK subprog accumulates
into 'depth' and the whole bpf2bpf chain must fit in MAX_BPF_STACK
('combined stack size of %d calls is %d. Too large').

So for the prog types bpf_enable_priv_stack() would have returned
PRIV_STACK_ADAPTIVE for (kprobe/tracepoint/perf_event/raw_tp, and
tracing/lsm/struct_ops with a recursion or an explicit request), a program
carrying a cleanup table whose nested subprog depths sum above 512 bytes now
fails to load rather than losing performance.

Worth stating in the changelog, since it is a load-time visible restriction
on the new feature rather than an optimization.

Related: kernel/sched/ext/ext.c sets prog->aux->priv_stack_requested for
sched_ext dispatch/sub_caps_updated, and verifier.c rejects such a request
when the JIT cannot honour it; here the request is silently ignored instead.

This looks like a bug fix for private stack support. Should this include:

  Fixes: a76ab5731e32d ("bpf: Find eligible subprogs for private stack support")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711
--===============7192484442512092886==--
