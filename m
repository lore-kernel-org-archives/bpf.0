Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91DA4B99AC
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177208; cv=none; b=OBVE2NBcZuGYWi4Fv6CkOsP6Nwbxy+RmUzsqlCTydcqw9RWTzLnlEgHwExbIfCBob9FiYg44d10rbDCkReQJVnrdVzYy9Hv1gnqgNuokTjYw8jpodspQFRyWUIR/ziV2HB8hGUlmM5E3SDgUL8MQOlJNwQhxrkEmv+eND+Ht8rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177208; c=relaxed/simple;
	bh=4LcGGiLogWwNVDadJ9b1YoAHzLFgMDRu5kJs8DXhk50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i+jp7+eSfymISRQY0oAiFiI5Gzvzw4sbti+jYREIAYvF9EuWdCq3FhBoWf+JIch+CT/ippjqA4E/uiQFGFSFQGInlnJvE3vVuH3NxJGzBBBy309vU84okOw+pxwlDxvhFGiWwKuNcqQtz/GyV2XNxZdMrMp9ym92wMrffTceGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvj2SQrp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvj2SQrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8326E1F000C4;
	Fri, 16 Oct 2026 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792177206;
	bh=KeUYqPyIIWa7MSzRV/q/XhtqBkhGqTjndKtZAy4HOvM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cvj2SQrpbb/IQdncNS3eK+vAfmt59c55Vbif6LIPe5Gsw4kasc2voIG00gyru06dy
	 DVQSss3e6x5D5OqV1Mv2+hCseidxw8LwvOa+Dz10LLeMQ/LZa3AOoYF2q7u3ktJ2F7
	 OmWNTapsiiBrHGA988nDzfrkgWPlVifQoyc04eZPISSRIdsurQYu2b9y6mOTa74NIP
	 Xk0LkfNz374jsggj3iZ7u/TspMCIrmPAD7s7yBl9IwuG/5IQXBRZH7Q8GlAfCudKRM
	 uhTCrmqzB05JXqCYnY6kY9esMX7CY17bSmzFLBm9mEWusiKdRsgdLXPkFTCrs0Q748
	 oBvngPqGSTthw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77534380AA66;
	Fri, 16 Oct 2026 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] bpf,
 x86: Support fetching AND/OR/XOR atomics in arena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179217720501.923903.6746374630856915617.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 19:00:05 +0000
References: <20261016171319.1623447-1-puranjay@kernel.org>
In-Reply-To: <20261016171319.1623447-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, tj@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 16 Oct 2026 10:13:11 -0700 you wrote:
> Changelog:
> v1: https://lore.kernel.org/all/20260923165301.3463007-1-puranjay@kernel.org/
> v2: https://lore.kernel.org/all/20260924160354.531101-1-puranjay@kernel.org/
> v3: https://lore.kernel.org/all/20260925134828.2012199-2-puranjay@kernel.org/
> v4: https://lore.kernel.org/all/20261014125017.1426212-1-puranjay@kernel.org/
> 
> Changes in v5:
> - Patch 1: support these ops for accesses through a number too, instead of
>   refusing them, per Alexei. BPF_F_ARENA_SCALAR accesses keep their
>   address in BPF_REG_AX, where the loop saves R0, so for those R0 is
>   saved on the stack with push and pop, as the div and mod lowering does.
>   An R0 operand stays in that stack slot: the new value is built from it,
>   RAX ends up holding the old value that R0 is to return, and the slot is
>   dropped instead of popped. Both exception table entries resume before
>   the pop, so a fault leaves the stack balanced. Accesses through an
>   arena pointer are emitted exactly as in v4. The refusal in v4 also hid
>   the reason: programs passed the verifier and then failed to load with
>   ENOTSUPP and an empty log, where the verifier used to say the atomic is
>   not allowed.
> - Patch 2: the fetching and/or/xor tests in verifier_arena_scalar now
>   have to load and pass on x86-64 as well as arm64, at both widths and
>   with the operand in a register and in R0. Two more run a fetching or
>   against a freed page, with the operand in a register and in R0, so that
>   the access faults, and check that the fetched register comes back 0 and
>   that R0 is left alone. The page holds a nonzero value first, so that an
>   access which did not fault would show, and R0 is compared with a value
>   derived from the page address, as a constant comparison would be decided
>   by the verifier and dropped. The 32-bit operands have bits set above 32.
> - Patch 2: read the address back after the faulting access, in both the
>   freed-page tests and uaf. A fault that missed the JIT's exception table
>   entry would be recovered by the arena mapping its zeroed scratch page and
>   the access would succeed, which the checks on the registers alone could
>   not tell apart. uaf now faults on the page after the freed one, as the
>   freed page's 32-bit address is 0 and the address check was empty.
> - Patch 2: skip the uaf register checks on powerpc64, whose JIT does not
>   clear the fetched register of a faulting atomic yet.
> - Rebased.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] bpf, x86: Support fetching AND/OR/XOR atomics in arena
    https://git.kernel.org/bpf/bpf-next/c/d9efbaed7e61
  - [bpf-next,v5,2/3] selftests/bpf: Test fetching AND/OR/XOR atomics in arena
    https://git.kernel.org/bpf/bpf-next/c/9e35f216e5c5
  - [bpf-next,v5,3/3] sched_ext: Use fetching atomics for cmask instead of a cmpxchg loop
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


