Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711352F87B
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848236; cv=none; b=efvCkWwgJHxT1dF+YK0PjTXt2ZskOKFkCiU/aBBhMVyPOiusDaARK9Bz3gAXgueDNDwrYTjnSzzWDywJmPniYVuLu7+cSWW4DY0/GWKZimh8MxP+8DiX8kVUOB66YboqPR9KEuGjRBEKDD7zH9gaOulQtgQHe6nWT15MWsGZ8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848236; c=relaxed/simple;
	bh=7bBmHh+iq6+9Zog+PRLL4WxYsZIOH+YzcecgQ1uZBWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qy2W6ezOeAcwZbnDN+OGOOKsfKz197A9w6uwCJ13vpRnYoNN7g9wwDIuTd3R6YqrQl9znVVIe8+9ma+i+h0SYNThxEPuE5bqFo2qrs02HAddMtz+wGqBQNT5V1TMTh3DtMQjl57Rl5hcFR3HVMn3jTfRdSHuzvF7rczJKtzzrLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7DMc8Iq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7DMc8Iq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1315CC19421;
	Fri, 10 Apr 2026 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775848236;
	bh=7bBmHh+iq6+9Zog+PRLL4WxYsZIOH+YzcecgQ1uZBWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a7DMc8IqWsRdya4Zt7Lpobw35xWcvdhNuZT1Nv7V4DyccqqfeBeJTI6fBquZUTG10
	 /Bb7mSvxnsVDtYBSdfyo2azabfMsByf0QxKF97XMmDUnGjrn7TECUWIAdDKF2+XzDv
	 pozfd/8jKGn8hMJ5ezF82Evnj5IW7kYu14Q8o2BIPXMoXoOba5y6VlTl4TB0ZwHsaO
	 hFGWjA5dHqnvvBH+Sysp8NLAEbl9KRyqScJyrah3LMJFA5AftjmZ30412rr568MR0B
	 yQdycc4h3fqj2UwVQb3y8wS/ePEkUuQ9JgKOD/+tr1OW0dhFw/RjNIglg6yukxDAOf
	 aZdxn8RqkycRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F593809A88;
	Fri, 10 Apr 2026 19:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v6 0/3] bpf: fix and improve open-coded task_vma
 iterator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177584821030.2607283.14843018768644433891.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 19:10:10 +0000
References: <20260408154539.3832150-1-puranjay@kernel.org>
In-Reply-To: <20260408154539.3832150-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 Apr 2026 08:45:34 -0700 you wrote:
> Changelog:
> v5: https://lore.kernel.org/all/20260326151111.4002475-1-puranjay@kernel.org/
> Changes in v6:
> - Replace local_irq_disable() + get_task_mm() with spin_trylock() on
>   alloc_lock to avoid a softirq deadlock: if the target task holds its
>   alloc_lock and gets interrupted, a softirq BPF program iterating
>   that task would deadlock on task_lock() (Gemini)
> - Gate on CONFIG_MMU in patch 1 so that the mmput() fallback in
>   bpf_iter_mmput_async() cannot sleep in non-sleepable BPF context
>   on NOMMU; patch 2 tightens this to CONFIG_PER_VMA_LOCK (Gemini)
> - Merge the split if (irq_work_busy) / if (!mmap_read_trylock())
>   back into a single if statement in patch 1 (Andrii)
> - Flip comparison direction in bpf_iter_task_vma_find_next() so both
>   the locked and unlocked VMA failure cases read consistently:
>   end <= next_addr → PAGE_SIZE, else - use end (Andrii)
> - Add Acked-by from Andrii on patch 3
> 
> [...]

Here is the summary with links:
  - [bpf,v6,1/3] bpf: fix mm lifecycle in open-coded task_vma iterator
    https://git.kernel.org/bpf/bpf-next/c/d8e27d2d22b6
  - [bpf,v6,2/3] bpf: switch task_vma iterator from mmap_lock to per-VMA locks
    https://git.kernel.org/bpf/bpf-next/c/bee9ef4a40a2
  - [bpf,v6,3/3] bpf: return VMA snapshot from task_vma iterator
    https://git.kernel.org/bpf/bpf-next/c/4cbee026db54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


