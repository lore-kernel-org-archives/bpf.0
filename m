Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F43F58EB;
	Mon, 25 May 2026 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724208; cv=none; b=Z98KG1Z6d0XTSxX9L7XbZjSfXd7c6bWZcdZVkVwLDdNtXdIABtCmlerxe/TtMhTfVwZxNqDdy8gpv9xPp6oQqb+Hh+2XL9s+Z0nniQp5mQySSwiVag0r4BZyyFjrLkL7C/+nzSFWhYvW1xYAheYBWNl1K6pOKnax9Sjd0+R8TMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724208; c=relaxed/simple;
	bh=PXBpqtTgHv/qE9mwwpVU/vHZrhUASvn40z6jqmB8ukg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WjXyCKwJ0tqKgydA72TesgEUurueyMha7Hk9qGMqYuBKacbfO8iK8oIFY/u8Wijt10Ie9VLJWxV2np0t/ZdE6GYrrYY2FXH7R6Wle8zAu8dIA1+d5IUawKkJpNEBirVy4HgL5WgzzUNdgwKPQXeOKFe3XeV4KteaBA+IMx2DBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brMJBmOd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brMJBmOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFEA1F000E9;
	Mon, 25 May 2026 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724207;
	bh=er8UsZouFFhjk3+GJ7baiqXv2Lc2B7dnsZku6inG5sI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=brMJBmOdnKnF0Zzaqx3KMPwRmWhnrFvJ9fsvRMKS1QqqYYinLPIQx3ln4zUHdNlnW
	 WKzpvsQG2U0W8+bUfXh6XXoGubc33vvVXOtwWNXemRLFrdEM7/53r0nI5jkUh7h5Mi
	 ZDS+jJ6GNIsz4SM6W1NWONn8j/SlHm7ZNOI7MENr9ckh9Zdgm/qgqXzkQEzo0XDimU
	 DqS2uD7a0wQrRM2NKrvZ1vE2r0zaORQFFclfsvScJSwuDdUz+wP1pB54UX9QSoROxb
	 nPLGv/Huo1DAoAnXLD8cOypzfXvtLrKkm6/kZ/g0asgTFFDHppJJactOzD1y6ef2NC
	 1Yu5c5ql2/JBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B69380AA66;
	Mon, 25 May 2026 15:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/8] mm: Add ptep_try_set() for lockless empty-slot
 installs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177972421364.2623932.4873892825966322227.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 15:50:13 +0000
References: <20260522172219.1423324-2-tj@kernel.org>
In-Reply-To: <20260522172219.1423324-2-tj@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, memxor@gmail.com, peterz@infradead.org,
 catalin.marinas@arm.com, will@kernel.org, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, akpm@linux-foundation.org,
 david@kernel.org, rppt@kernel.org, emil@etsalapatis.com,
 sched-ext@lists.linux.dev, bpf@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 22 May 2026 07:22:12 -1000 you wrote:
> Add ptep_try_set(ptep, new_pte): atomically set *ptep to new_pte iff it is
> currently pte_none(). Returns true on success, false if the slot was already
> populated or the arch has no implementation.
> 
> The intended caller is the upcoming bpf_arena kernel-side fault recovery
> path. The install runs from a page fault that can be nested under locks
> held by the faulting kernel caller (e.g. a BPF program holding
> raw_res_spin_lock_irqsave on its arena's spinlock), so trylock-and-retry
> would A-A deadlock. Lock-free cmpxchg is the only viable option, which
> constrains this helper to special kernel page tables where concurrent
> writers cooperate via atomic accessors.
> 
> [...]

Here is the summary with links:
  - [1/8] mm: Add ptep_try_set() for lockless empty-slot installs
    https://git.kernel.org/bpf/bpf-next/c/258df8fce42f
  - [2/8] bpf: Recover arena kernel faults with scratch page
    (no matching commit)
  - [3/8] bpf: Add sleepable variant of bpf_arena_alloc_pages for kernel callers
    https://git.kernel.org/bpf/bpf-next/c/f211c81ddc36
  - [4/8] bpf: Add bpf_struct_ops_for_each_prog()
    https://git.kernel.org/bpf/bpf-next/c/7c48a28c1bbe
  - [5/8] bpf/arena: Add bpf_arena_map_kern_vm_start() and bpf_prog_arena()
    https://git.kernel.org/bpf/bpf-next/c/53cc12a2dc88
  - [6/8] sched_ext: Require an arena for cid-form schedulers
    (no matching commit)
  - [7/8] sched_ext: Sub-allocator over kernel-claimed BPF arena pages
    (no matching commit)
  - [8/8] sched_ext: Convert ops.set_cmask() to arena-resident cmask
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


