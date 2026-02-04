Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA77221577
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167422; cv=none; b=tvBdGxzjPmj6abjRERBlK8yrmz3hLtQ8ellsoR4/alIA1RpXkOcNHHW+o+15023UaPbayPaQ80v8MO8UKgnewbT4aMTnyR9tOUwmfSUV9wQSl1hNy8QSnTMCMpYYSE57ilXYayCqzlR1bn0G15qTJEtXsIZrlM5w+DWqEnhhax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167422; c=relaxed/simple;
	bh=z3HNELjlkf4wnbOg3JsFB95j/vD1RfcW5CKUoyDA9/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KbjVv90SRLOL1G/nH8nvljOPXqsJ/7wVKFX+6SHfQghYhPykZB0sl2A/Ao6c7E5jmVjDJr53VXv5F1yDtnOwXzk79STuTFUJoN6hSFdwlck5dRGzBYmoEarURTL/DRoWwhLnsmYAeBy7gnYB8ZP1OMQijnNBJQxLFCiLj3Qf7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5tVl7zn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5tVl7zn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55A5C116D0;
	Wed,  4 Feb 2026 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770167421;
	bh=z3HNELjlkf4wnbOg3JsFB95j/vD1RfcW5CKUoyDA9/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m5tVl7znOUEESlZ7rbLE+zV8KCcctnukGilJ8rE9ULkXyBwhZejNnBnm/qrUMMSA6
	 eM/JoJ1HFQreGx2kaUZn+bBYsDRhpVkY/tcgQNRKceMvRZlC5RLc9lWDq7cZwWgRvC
	 r5Dpq/YSjoJRY2UNj48vqJKAmV/BjUDjcygKJXajyAvMimD0ioXTpGlCIv4La0eR/a
	 K3TsSJT++XW3v6YUZ43eLyO8s7NGI8cZkcROz6suCxUnNdQhyOsj3VStLdOGGfNJeN
	 3Yyzeph+9MUoGFa4YlCpfjeCM4INtLOZAXF2wl6KIajxfSP/8xuobB5i7yll4M5UuU
	 hiFAFSyHEVfSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 53F6B3808200;
	Wed,  4 Feb 2026 01:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 bpf-next 0/9] bpf: Avoid locks in bpf_timer and bpf_wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177016741813.2125760.7860406569007550057.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 01:10:18 +0000
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 31 Jan 2026 18:53:54 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> This series reworks implementation of BPF timer and workqueue APIs to
> make them usable from any context.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
> [...]

Here is the summary with links:
  - [v9,bpf-next,1/9] bpf: Enable bpf_timer and bpf_wq in any context
    https://git.kernel.org/bpf/bpf-next/c/1bfbc267ec91
  - [v9,bpf-next,2/9] bpf: Add verifier support for bpf_timer argument in kfuncs
    https://git.kernel.org/bpf/bpf-next/c/19bd300e22c2
  - [v9,bpf-next,3/9] bpf: Introduce bpf_timer_cancel_async() kfunc
    https://git.kernel.org/bpf/bpf-next/c/a7e172aa4ca2
  - [v9,bpf-next,4/9] selftests/bpf: Refactor timer selftests
    https://git.kernel.org/bpf/bpf-next/c/10653c0dd868
  - [v9,bpf-next,5/9] selftests/bpf: Add stress test for timer async cancel
    https://git.kernel.org/bpf/bpf-next/c/d02fdd7195ca
  - [v9,bpf-next,6/9] selftests/bpf: Verify bpf_timer_cancel_async works
    https://git.kernel.org/bpf/bpf-next/c/fe9d205cec8c
  - [v9,bpf-next,7/9] selftests/bpf: Add timer stress test in NMI context
    https://git.kernel.org/bpf/bpf-next/c/083c5a4babad
  - [v9,bpf-next,8/9] selftests/bpf: Removed obsolete tests
    https://git.kernel.org/bpf/bpf-next/c/3f7a8415209e
  - [v9,bpf-next,9/9] selftests/bpf: Add a test to stress bpf_timer_start and map_delete race
    https://git.kernel.org/bpf/bpf-next/c/b135beb07758

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


