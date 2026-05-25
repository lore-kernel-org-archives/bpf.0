Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007DA3F5BEF;
	Mon, 25 May 2026 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724210; cv=none; b=C7K//k7Cn8gEmbiyq2Nkpcpt8nVlDxuDlk83Ale+C80uhdGVTJMEJ5edyB2pt3iVcQbqSvtOXCb492xRmIKRk4jiBhzxPJWStr5OLUFuMrdg8OIBThlHZhYGicjOK/kVWWS+uvgMfQrO3J7sEYR2dtsmtSNpsdvNk/1pC/eoXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724210; c=relaxed/simple;
	bh=T1yEKu2XrXZ2E5FotMqmGDPZgliYgWQNSJw71ovZlf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wsnbh12SMmxhRWjJZ9YgTqF0tPoem/V7bwhd/K0REFsLgaUuJe155iDELE1xW43X3tbf9QtxpvxwxHcBKKGJY0RxBrOe3VKUMKo7ttB42gBsAXqlO43rIiolGqkc3gqhWBRuC83RcE1onP8LaokL6XwyxT4rYptuceNI5aw8Jd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjYzFiUb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjYzFiUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944691F000E9;
	Mon, 25 May 2026 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724208;
	bh=7DFSewy4HiHsulqVjDY+J795cQvlcQzlXeEXsle8lBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VjYzFiUbbB+KydlfY9Z4MuBygfHZEOhzzF8hqPM3jzuAT12EAGWi4sWZ5Kj7xTBmG
	 /xgXWuskpWqOfF/++ekEIAsipeAeQb3YtnKrQnv1758Mmm97CNXTov68HsnU7ff+cT
	 5WPDO01gr5uSuD8EesHTGnWwfCDqLnLRq9HUAX2SED9u5AdOZxvlTTWIODe+Pntcpi
	 bHQnGL28WCVobvfZpLzPe+XKfGpoDvRcskhXnXu/QJRk1AFBymhjlbuU9uCvSG5UbJ
	 ZqD0nShvHeADxBhybW/GnMY1bwvu6WG8sgtinirBkF0AbNyu6WkTYy1he2ImOo86lK
	 Z8JDU7xInsufQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9389A380AA66;
	Mon, 25 May 2026 15:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/8] mm: Add ptep_try_install() for lockless empty-slot
 installs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177972421514.2623932.18366712575128006806.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 15:50:15 +0000
References: <20260517211232.1670594-2-tj@kernel.org>
In-Reply-To: <20260517211232.1670594-2-tj@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, memxor@gmail.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, akpm@linux-foundation.org, david@kernel.org,
 rppt@kernel.org, emil@etsalapatis.com, sched-ext@lists.linux.dev,
 bpf@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 17 May 2026 11:12:25 -1000 you wrote:
> Add ptep_try_install(ptep, new_pte): atomically set *ptep to new_pte
> iff it is currently pte_none(). Returns true on success, false if the
> slot was already populated or the arch has no implementation.
> 
> The intended caller is the upcoming bpf_arena kernel-side fault
> recovery path. The install runs from a page fault and may have to
> contend with locks already held by the faulting kernel caller, so
> keeping it lock-free via cmpxchg is the safe choice.
> 
> [...]

Here is the summary with links:
  - [1/8] mm: Add ptep_try_install() for lockless empty-slot installs
    (no matching commit)
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


