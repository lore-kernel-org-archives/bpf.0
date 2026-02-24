Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8E2BDC13
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974001; cv=none; b=AMTP/Uw7qwLQa/rPdRx7VKr8adPchPUy8XF0AGQ0V0bVgs/SjZV8gZ16+BUiqqpjz+Bt2hd9oJuJjwmOHh/taL5/kFTzFkyPSIR77vyVOuST1rCOJ/DHIQnoIib0zQNVXUcvLm5+33S35MhdeQxhN5W4QfcEWVQaXFbiNyRwzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974001; c=relaxed/simple;
	bh=MC/CDCxPKT69uvCoABR1nR2imH5jKVcGp7xup5L/Tt4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NFC3cL/dvnyTanJ+8v+yDR67rqwibjGiPN8KButaYKaQtIWYZ1aV7LTDjOJWxe7lhdoe9pAUp1PhQMBkmz1vEi9YzOi4zX9YNkAyaWEouuNzJYmSHlCXbkHdfKxctxcGPYSD2zrtvjAzEQ6QM/HlN9N1aGVH5jxqcmdilogVSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkihbM52; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkihbM52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2348C19423;
	Tue, 24 Feb 2026 23:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771974000;
	bh=MC/CDCxPKT69uvCoABR1nR2imH5jKVcGp7xup5L/Tt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qkihbM52v3STasS9v1Ho2OE6LQ8CFVdfmfKH0CVrdA74TxT4KvHRbKn1ga4mVfbww
	 3951XQ70m+ovdU3fjGrQG7v4g9c8HJV/Kw0FFM6vzgdf9cefn/ivxbl9yFmQCdeMM0
	 L8/pTduVRGfOneWRMt9AIYry4vE1a7LvR/9nPK1BJiEwt78WL/7rZRKGEWnYXGmpCx
	 K4BlaxJMgLS51RkGCEp9GuzCkLhCHKWfAYfz+QYlmUlGfJwvPbl7SwyzEjAV/cyiJy
	 yrvjxcC2knl99xH34gBNrTxJQiZl5MmhANDzOlFzCKVduq+S0zS+gfLtb0iuwW8ggJ
	 OLLvjkWq8VY4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CF23808201;
	Tue, 24 Feb 2026 23:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix flakiness of
 task_local_storage/sys_enter_exit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177197400555.4184691.14239797576415217065.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 23:00:05 +0000
References: <20260224211202.214325-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260224211202.214325-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, ameryhung@gmail.com, yatsenko@meta.com,
 bpf@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Feb 2026 13:12:02 -0800 you wrote:
> The test_sys_enter_exit test was setting target_pid before attaching
> the BPF programs, which causes syscalls made during the attach phase
> to be counted. This is flaky because, apparently, there is no
> guarantee that both on_enter and on_exit will trigger during the
> attachment.
> 
> Move the target_pid assignment to after task_local_storage__attach()
> so that only explicit sys_gettid() calls are counted.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix flakiness of task_local_storage/sys_enter_exit
    https://git.kernel.org/bpf/bpf-next/c/c89b50cc6b9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


