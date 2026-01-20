Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E434E743
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937456; cv=none; b=Fts9P3pZeujLbW4Oos3bPZOdsTjpjkydCgy7dKDI2gax/e5QDVVlk0OazMKO0rXdKQ1iRYh60i1lfxhLB9b9WBdAQYJyfNBlYDolbD6Wjo2GIFWO0uOPKPPy9ZhTSl56i3HBmCDZPxGGGgZzZASp5qObEdavyy6pJYw8kMkhRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937456; c=relaxed/simple;
	bh=ja3Cz1zjSptd1WJz7hwPuGpan/69uNFgw0fH9JkZCsw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DukHJel0critcs1loXzcRwtHGlT/iVE8wkpSuJTknzDSgOQxpPgQGUmB0B8dWL7/Ie1xPMj4Cqp0ELZfGZdqVdaTXA+k4exYwUgvSMR17TeJMhgiUesXUKgpAA6d1CsnhvDX21KvCfU7PZCFtmyy/ljd0LImQSgPnG/wWVJLwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeDXlwSB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeDXlwSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62343C16AAE;
	Tue, 20 Jan 2026 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768937455;
	bh=ja3Cz1zjSptd1WJz7hwPuGpan/69uNFgw0fH9JkZCsw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LeDXlwSBov1qcbGirclVGrgxcfpkzj7tKrCOYQZeUMgdEejmYYDqK1b23ubIi9Klu
	 woW2/YC4Zk0sCgDeqFIAPyfAAmyNQmNoEw34rekoUGxVBLN/rUDuKoVJBOrImt0ixa
	 rK14TxPVqZQA+L06S+qyDq9eRVZRZ7UW3jhYqgAH2bXAUDDBiCJlAL8mFmyUi7e1B3
	 L+dDY6JqTp5x0st7owMgXYFu2ilsUjmHo2nBHIuIQGr9mJBRStV0E6qN7SMfqU6Kv0
	 hz0HMOp60IIk1XDDtpq3+YhXrzTdYB/9EIAyAlUyoQDRBHv8VRqcmhAe7zHkrAWukI
	 IVfYHw31fvvbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11F8D380820D;
	Tue, 20 Jan 2026 19:30:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove leftover accounting in
 htab_map_mem_usage after rqspinlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176893745274.579155.12677622612997154068.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 19:30:52 +0000
References: 
 <09703eb6bb249f12b1d5253b5a50a0c4fa239d27.1768913513.git.daniel@iogearbox.net>
In-Reply-To: 
 <09703eb6bb249f12b1d5253b5a50a0c4fa239d27.1768913513.git.daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 20 Jan 2026 13:55:01 +0100 you wrote:
> After commit 4fa8d68aa53e ("bpf: Convert hashtab.c to rqspinlock")
> we no longer use HASHTAB_MAP_LOCK_{COUNT,MASK} as the per-CPU
> map_locked[HASHTAB_MAP_LOCK_COUNT] array got removed from struct
> bpf_htab. Right now it is still accounted for in htab_map_mem_usage.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Remove leftover accounting in htab_map_mem_usage after rqspinlock
    https://git.kernel.org/bpf/bpf-next/c/713edc71449f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


