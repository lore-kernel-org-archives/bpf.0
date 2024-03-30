Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B3181
	for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758028; cv=none; b=PUPRHevoQq3z9tCIfhauojR7/izbqTXnJTooMJcg5i62I5tjhDW0+VfdfOa7vjgvJRv529aKvl67eP9PRXmGuV/8ZCEOPE4DJEkhWkSdhy3RAmCP2or8WlzauNGiFiD/3uB39dxIAQyMuizbV9uoi8WP1qmZkmlioMI2cnSf3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758028; c=relaxed/simple;
	bh=XyNdXwJNWhxa4ejeK0bnlBRL257wcKH/QVsJbP88jFg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WnynCPF6rb27Oaz5pIy47O8IxlfMbFJOKSjFxk0rKRtI2N+sNzgonIZTbZL/solb3pXpqlgPUgS7tVyg9yM1KTcgHq6kLG7lCE96aLvknY/ucZQvj/ApfIjqXMXY4CSQUcMrlaEBM1nodDgNHWmMAAjnZ8ByaN5DQvQzCmGljp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaWB8G/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaWB8G/O"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDE07C43390;
	Sat, 30 Mar 2024 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758027;
	bh=XyNdXwJNWhxa4ejeK0bnlBRL257wcKH/QVsJbP88jFg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MaWB8G/Oz6vVUpyaYM1VgWiTdTG7XUAGxgJr4UnsUxb+RPadeBj7VzEoaM6R9Dwqq
	 2GBxRUcTbzh+JkK9lUkQIx++lYeHBhLnVtP0WqwTXoCL7Fy9OO99rVhb2oIy066s/U
	 fglZoVGA+yZbgJEPACyzG44lslSG6sCAA0Stc6oq1zKSm841t8dV3MYFuSQeg0f9n0
	 0LUfxOAP0lQia3LOc7Uj0lhlV0Lu7M2rl1ZUIOztt3+KEiI+fO26/jzF54JaSUwn5T
	 Npj7bD4gpJu6C6lRWX1QDeGKoxPGpALvJXCpJkc/vp2KVo+5dCEBjoMehTzEQ9sS/7
	 RTHBEDciEWToA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE454D84BAA;
	Sat, 30 Mar 2024 00:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: make multi-uprobe tests work in
 RELEASE=1 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171175802777.19288.5072476734261398942.git-patchwork-notify@kernel.org>
Date: Sat, 30 Mar 2024 00:20:27 +0000
References: <20240329190410.4191353-1-andrii@kernel.org>
In-Reply-To: <20240329190410.4191353-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 29 Mar 2024 12:04:10 -0700 you wrote:
> When BPF selftests are built in RELEASE=1 mode with -O2 optimization
> level, uprobe_multi binary, called from multi-uprobe tests is optimized
> to the point that all the thousands of target uprobe_multi_func_XXX
> functions are eliminated, breaking tests.
> 
> So ensure they are preserved by using weak attribute.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: make multi-uprobe tests work in RELEASE=1 mode
    https://git.kernel.org/bpf/bpf-next/c/623bdd58be37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


