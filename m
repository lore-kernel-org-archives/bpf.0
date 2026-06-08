Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB18372B3C;
	Mon,  8 Jun 2026 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920013; cv=none; b=M74cEnRBXHCObyF0RMqb0WpNZxYpq4k5m5aDFsRFOEr+mT1GKDqnrM/K5ZtmTlGyj+2LRr61o2ENPBNf0WkE9ls5bXAJrsK+VIVCgJ+/kgjnZs1lsGG0hguydJOt1sCuiFAZbWSexsMpzJS71neslFK82Ywv3m9rAaFl8aOXcsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920013; c=relaxed/simple;
	bh=L2C9QD3DF8do3y3X/B0AE4+i+sC6WQ8gCE3dUxGWgJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hbvzpsAdfERoNKnQmwc9YFe4BvyDIgcU9nG+NiqbTErgFbibU25Kj0Q0eRVbuQXWkeKcuONsJy6grpuYrM1iXmNwcGrUSfzKx0SQsK8ow535WP7kvBFzGufKX6MMobZrLlbJnMgO5VgPF71eOGm25Mmou8WuyG36EAa8+R4Tuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbshWzMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbshWzMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5A11F00893;
	Mon,  8 Jun 2026 12:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920012;
	bh=AQAir/XhNgzln0FRrf8cgFa/spk0WCi7bswkv8ztqtM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VbshWzMbj8MuZE3fQBjIspMvk6Z4L2Uwp7JKBQDi7zG7PNGbjZK3FOiOyMtngTPId
	 CkklEcZg91CINj0HiWVC9Gfc80+yDZibAE9nBvMPSJTfxTDEKqHrb0lb9w8/An9BC3
	 9Xl+UnrxOrfGTQCSmcitJ3pVQ+6LKwQMJfY9ZcsX0XNPtKpQEkuSgjGS1npPm8Yabj
	 zZCHUyW7t0Cx/M5eZPzlXgSExpuE5ueuuJ4zMNjja8Xlq35MjDAuiHyJtDoilmbwy8
	 gC7j2SZOAcubRcT42zNoLs8sKFkCNY8v/D8sxnqGqf1kS1gPjGB+j6ydvtKLiE/0tK
	 p8dcPzmqCGdgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938DC3930D69;
	Mon,  8 Jun 2026 12:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] arm64: mm: Complete the PTE store in
 ptep_try_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178092001114.1007295.14338085080112012433.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jun 2026 12:00:11 +0000
References: <7f5f7c94601312c1a401fb18998291cc@kernel.org>
In-Reply-To: <7f5f7c94601312c1a401fb18998291cc@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, ast@kernel.org,
 david@kernel.org, arighi@nvidia.com, memxor@gmail.com,
 akpm@linux-foundation.org, rppt@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, emil@etsalapatis.com, void@manifault.com,
 changwoo@igalia.com, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sun, 07 Jun 2026 21:25:47 -1000 you wrote:
> ptep_try_set() installs a kernel PTE with try_cmpxchg() but, unlike
> __set_pte(), skips the barriers that arm64 requires after writing a valid
> kernel PTE. Without them a subsequent access can fault instead of seeing
> the new mapping.
> 
> Issue them with emit_pte_barriers() rather than __set_pte_complete().
> ptep_try_set() must finish the store before it returns, but
> __set_pte_complete() would defer the barriers when the calling context is in
> lazy MMU mode.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] arm64: mm: Complete the PTE store in ptep_try_set()
    https://git.kernel.org/bpf/bpf-next/c/71385b78dbc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


