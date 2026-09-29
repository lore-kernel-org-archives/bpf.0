Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B518FC97;
	Tue, 29 Sep 2026 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641881; cv=none; b=sQaql1d9+XKRzYcSik2wiuuooeBat4slWg/FgHK+lxt8IGQMYd+qJQOrkEv+FyX4ITbnDgipGqPHkcNIkGFwdLltt49ZN4vMUMP7YSG2rUSn4kDBGJm6y/eozX/Ny3p3p/7F/6/Cy10xWCN2ueYBK90BBXg/SANHdIF9yl73K/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641881; c=relaxed/simple;
	bh=tgapBw0CifW13PMaFWelEGJNx1gEmvR0ZnQf846HvX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=llZHI+SfizoWu8in5NSrNDGajObZZpQE61dIoQAjVi5qTg34V/k0kvDd8iRw7d7bchGq1PHVT1Y80gBy3PlzcT7NTowcbHErjTVjOHMYSdI7XV7K1rodD5c0x0cbkjJ5z+fF2TUXYhi1zmLKNriTtD+Ikn5Gg73aW1tD/ltl8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/tQhQSc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/tQhQSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE991F000FF;
	Tue, 29 Sep 2026 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790641880;
	bh=3oql9lElSkZT/4nRtOjsCxreVRAfauJkvJfeyc0WDzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d/tQhQScliL/KztO32M18o3poCVmf1GCyAE3JNhBFKFHWJSAnC1NIHCiZgWipbSHv
	 /2oB7Y5Bl9qXZ7+WUjwOQ4/HvSKZ8QteuWM3sndXJubDnD1O6dTLjCygzNRQYXJ1if
	 J6JqvF+QXVcqok+x8Dr/m9wK8jd4Uszt6TZNtuOsvAwp6xLWFRcwsRu4AxHHGq8Xuf
	 V0z3lPZnGifKEeW4x3IBYWQg2/ZLsGi9rZ/f6nJEzsincluw1221fgf7/xoBUUhG7u
	 by0PImLmMNxEUNp2TGQEYXufO4AbhDPxICIOCRaT4zO62lFuXC3Kb+QS8otVju1dks
	 t5P2LTcPMPO/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AEC3924FE4;
	Tue, 29 Sep 2026 00:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix linked_externs with
 bpf-gcc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064180465.191583.15471520718506070506.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 00:30:04 +0000
References: <20260928231441.4037097-1-vineet.gupta@linux.dev>
In-Reply-To: <20260928231441.4037097-1-vineet.gupta@linux.dev>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 28 Sep 2026 16:14:41 -0700 you wrote:
> test_progs-bpf_gcc fails to build:
> 
>   prog_tests/linked_externs.c:17:23: error: 'struct linked_arena' has no
>       member named 'arena'
> 
> Several problems, all from bpf-gcc not supporting address_space(1).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Fix linked_externs with bpf-gcc
    https://git.kernel.org/bpf/bpf-next/c/61c1e63c9b65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


