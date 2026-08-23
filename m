Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A33ABD8D;
	Sun, 23 Aug 2026 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514059; cv=none; b=facGa6SWg1LQFnmgoawU9myTc//aaOvwkeOZWnZHSpnsJgryzPr9EwRYrj/z9jbfE7qA7jHm0I+RrA1l19Y3ldwJ2Ley0XV22sQ5qS3LiSvPVKEghHr+R7YYr4I6gGgpaEbqlYVABP/dUNPC3zObBzxvkzJMv2N+ALlqfWbvJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514059; c=relaxed/simple;
	bh=iFDyn+FM4JIEzXjxunjq5cLDhsRFcSpC+qjajzy3kaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R+pcJ2ju78vtJ1AH80aSoGb1cEDaXnquOw75YeFFg2NzFq4AxNtxuapjWhG1jFjrtbQG2LNodXM1z8aCNNdgx4cwCYTgkJYp/4GhvSwI3Zo+93DeckiSvk+pOjn/dK3YrOykgbLucJbB+4w3W54exYEQei89KgRqg9fS4LMzexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJO1+jqV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJO1+jqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B228E1F000E9;
	Sun, 23 Aug 2026 19:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787514057;
	bh=5x4PJXLkys/Qas0ZQxbkGUWDproGMBgmXJrA/3FFqbI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HJO1+jqVkGtVSPhX0qSv/zm+gWCaJa4Z0wVG1q3lbmlpCUxlMQgaEPot40mKogXAU
	 HBB00DN58uzRkAg4n20XjTYiL59PrnAGQUTh9RvQSX40N7W53zgSyaITW7qNQVW067
	 7UavEHvqp9JWqFMg9P/o+bXSBbCVG0WUGglNCM082WTHUO1DLZWLIDOhLcTVOHqND1
	 TVqXY6hR8itYwnqC5wCqA6t2N56+zY4J6NyHCrMOgVOJg64t35jHLd0H7GEy3pM0cg
	 Vwc6Fhg1Uz7z9eCV6gpUMtxjwWLTHSO8ce4SN9rh5ZE9F6jVYE4Jz92mShYAP4M+g5
	 wNX7ZExGQ2DWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19833380AA78;
	Sun, 23 Aug 2026 19:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] bpf: Annotate bpf_obj_memcpy with data_race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178751400564.2127284.2628420937760907856.git-patchwork-notify@kernel.org>
Date: Sun, 23 Aug 2026 19:40:05 +0000
References: <20260822-bpf-kcsan-obj-memcpy-v3-1-4227b2edd8b4@proton.me>
In-Reply-To: <20260822-bpf-kcsan-obj-memcpy-v3-1-4227b2edd8b4@proton.me>
To: Quanye Yang <quanyeyang@proton.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+44044637ef892e79ca2b@syzkaller.appspotmail.com,
 ihor.solodrai@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat, 22 Aug 2026 14:55:33 +0800 you wrote:
> From: Quanye Yang <quanyeyang@proton.me>
> 
> syzbot reported KCSAN write-write races when two tasks concurrently
> update the same map value. Both accesses reach the ordinary memcpy()
> paths in bpf_obj_memcpy() through copy_map_value().
> 
> Unlocked in-place updates of published map values are intentionally not
> serialized and may produce torn values. Callers requiring consistency
> must provide synchronization appropriate for the map type.
> bpf_long_memcpy() already annotates the same behavior for long-aligned
> copies.
> 
> [...]

Here is the summary with links:
  - [v3] bpf: Annotate bpf_obj_memcpy with data_race
    https://git.kernel.org/bpf/bpf-next/c/5e289c5a4a52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


