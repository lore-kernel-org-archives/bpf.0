Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C1262FF8;
	Fri,  5 Jun 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673408; cv=none; b=jGnDch5B/kJrIDJIdsVic0jZfZddUT5k4/7z+VbWdnbkAchWMQwTGZh+hYW0NH4o3DJ6KBIuCpDL0L+7fMfL4km+Fy9djVB+U/UwVNEfFFi4g2iT5Vo8ywgYiZ7aiwQVZQAC7oezb7iwCU9VKdk2WI5/YH4RBuJA/V4Cu56l5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673408; c=relaxed/simple;
	bh=zMgRSnvJOko7Z8pAG1TnHG0nOb6lLyPQqMzGvtSoFzA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PON3Wuo8wShsdTHcIMjMJ0PRdLgm5UJRTslLu5FPgR0SB9y2I2iiBS+bkT3saAVzCBVrbCKQp+ZFdHuOLTcDXTVmSbkit+Wy6RFReUUa38x/4JmgBaCGjjtbQHAFgmNFj+6TYG0J3J5fAFR6qtrepyQh1A+LolyZ3Tsu0SytJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RayKJ7nc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RayKJ7nc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C001F00893;
	Fri,  5 Jun 2026 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780673407;
	bh=1BFFFgB57ZAob11PrIhvgonvaYPbDjOxXtuYXVUomG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RayKJ7ncq0sZEb9vdqzRVX7YDpHvVxSzRbkdFFpFXx+JmNyRvyody6M/TZBC+J1mC
	 aijEDSFOVz044vXnDL+FBwplQJdbIFbUpu/BmIKdN10yjwCnxeqA3tttPoUnDrCfXj
	 jJ77iJAoRNuPuAW5vKVhA6bptbyqojfT4V6HHh7zbnAH5oeRGBECqR9A8H+BWuiNEy
	 xndf4zIX/VXugdxNVUP/9oD1IQfp6KuVrUa/LGQ+/TVcncmYM63Jcd3akd8jng6r8x
	 16RFTi1oRG6rL/FWWoe+DWiKMkGU1UMQ8HFvlAKpM2e4qVOhrcaGRY+GkrU8dwNl9q
	 jRADb53t0lpNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AF53930BA5;
	Fri,  5 Jun 2026 15:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Replace scratch PTE atomically when
 allocating
 arena pages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178067340741.3804693.1794735582974531631.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 15:30:07 +0000
References: <20260601183728.1800490-1-tj@kernel.org>
In-Reply-To: <20260601183728.1800490-1-tj@kernel.org>
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

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  1 Jun 2026 08:37:28 -1000 you wrote:
> apply_range_set_cb() maps the pages for a new arena allocation and returned
> -EBUSY when the target PTE was already populated. Kernel-fault recovery
> leaves the per-arena scratch page in unallocated arena PTEs, so a later
> bpf_arena_alloc_pages() over such a page hits that -EBUSY, and every
> subsequent allocation of it fails the same way. Allocation must install the
> real page over scratch instead.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Replace scratch PTE atomically when allocating arena pages
    https://git.kernel.org/bpf/bpf-next/c/f64c723741c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


