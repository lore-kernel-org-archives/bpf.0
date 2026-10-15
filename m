Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B30A1E260C;
	Thu, 15 Oct 2026 02:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792033145; cv=none; b=GYLqqVuTiVzlTM2KaDDmQiBgBTyBDdMwyZuRmvI8H6evdShNxJJjADVURyVuJzR4TXCVOpW9wh9a2M/FbKakwKsPCzZtAIdhKeCdKqgjJ5HClZzsjW7dIF65t1ZAESyg9RjezPvirAPIbXHYRVwR5LcJQ1cVfKIya34NBXno2h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792033145; c=relaxed/simple;
	bh=lT3HKAgCH+dfk9YzW+XsB5qzW/WYD1G8gebHwgzPJEo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DsgovtV8hHoaWqVUkOuPxAcduURiRgYk4kr2k9z4A+cMD5qj9TV42v/jfjzpaPVhL17ymE0gwOfH6zg3ZwMX/LjWkHkSdMXTDU9yYWH1wp+SBxG+vIMA7kV2HL/EDYqXM9xdoG7CQXs/3fB1FR9PbtZt31EgNcTH5H/2ain2n0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlA+k60O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlA+k60O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EF51F000C4;
	Thu, 15 Oct 2026 02:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792033138;
	bh=bpYRRTqwLo2HWeFqcCqbpPVh6DLjUFtMcKybkXV94SI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IlA+k60Oq0HnoXlVurZ79XrtX0WclPoBWWRgWMU4d0FzDe3KQGy7nbCPpm09Rp0f1
	 NBJX7JJBz+pzLr9/QP/4iL+D7KGD9iyhkRP3iPngXQ+7PpmIOkhJbOOYxfjIb/377s
	 NUQQ2PAj99rde/FOcELCmo7ATdG4wTiSAEXNhV6pAu4B77k8HiVx7sjttOCLrfyq5x
	 nT39Fx19ZGoGxZFCbF/Of2YGLivBRvB5OkhWqGrnq77hZs2Yqn/8qYyvrS8GjxzPyc
	 wcrlpOnT9tkRQD2qk7swi0F2XZ9V8/YjCq740BPh2nVA8qo9OjbLo2vXS7WdmdM1cP
	 qDL7AHVXCN6Ow==
Content-Type: multipart/mixed; boundary="===============4514555578709208116=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b96ee2ab6347e86e3da161bcdea1d17fde1acb1c619d3519b7c980daf03b20d5@mail.kernel.org>
In-Reply-To: <20261015021238.5657-2-cp0613@linux.alibaba.com>
References: <20261015021238.5657-2-cp0613@linux.alibaba.com>
Subject: Re: [PATCH bpf-next 1/3] riscv: bpf: Add BPF private stack support
From: bot+bpf-ci@kernel.org
To: cp0613@linux.alibaba.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,memxor@gmail.com,bjorn@kernel.org,puranjay@kernel.org
Cc: eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,pulehui@huawei.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,luke.r.nels@gmail.com,xi.wang@gmail.com,shuah@kernel.org,rgbi3307@gmail.com,guoren@kernel.org,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 15 Oct 2026 02:58:55 +0000 (UTC)

--===============4514555578709208116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> riscv: bpf: Add BPF private stack support

TL;DR: Commit message only: it says the guard layout follows x86-64, but
x86-64 uses an 8 byte single-copy guard, and it may overstate why
__per_cpu_offset needs absolute moves.

> riscv: bpf: Add BPF private stack support

[ ... ]

> The base is materialized with absolute moves, as on arm64, x86-64 and
> powerpc64: the dynamic per-CPU area is vmalloc'd, beyond a PC-relative
> auipc pair from the JIT region, and riscv64 has no segment or register
> holding the per-CPU offset, so __per_cpu_offset needs materializing the
> same way. Both constants are fixed before the offset convergence loop,
> so the prologue length is stable across passes.
>
> The guard layout and value follow arm64, x86-64 and powerpc64: a 16
> byte region at each end holding two copies of the pattern. A jited
> program has them checked when it is freed, reporting the first
> corrupted CPU only; failure paths release the area unchecked since the
> image never ran, which also clears priv_stack_ptr for the later
> bpf_jit_free().

Is the statement that the guard layout follows x86-64 accurate?

arm64 and powerpc64 use a 16 byte guard with two copies of the pattern at
each end, but x86-64 differs:

arch/x86/net/bpf_jit_comp.c:
    #define PRIV_STACK_GUARD_SZ    8
    ...
    stack_ptr[0] = PRIV_STACK_GUARD_VAL;
    stack_ptr[underflow_idx] = PRIV_STACK_GUARD_VAL;

It uses an 8 byte guard with a single copy at each end, and it rounds the
stack depth to 8 rather than 16.  Only the guard value (0xEB9F12345678eb9f)
is shared by all three.  Could the changelog say that the 16 byte, two-copy
layout follows arm64 and powerpc64, and that only the guard value follows
x86-64?

Separately, the changelog says __per_cpu_offset "needs materializing the
same way", meaning with absolute moves.  The existing BPF_MOV64_PERCPU_REG
handler in bpf_jit_emit_insn() already loads the same symbol PC-relatively:

    /* Load address of __per_cpu_offset array in T2 */
    emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extra_pass, ctx);

Is emit_imm() for __per_cpu_offset in emit_priv_stack_frame() required, or a
choice made so that the prologue length stays fixed across passes?  The
changelog could say which.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38671177164
--===============4514555578709208116==--
