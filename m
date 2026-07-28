Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B01C701F;
	Tue, 28 Jul 2026 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200442; cv=none; b=OoaAUXLQzngP6kAx9RRn2mYAj00f+sIMc/Bu+2IZ3g2FUGqvrwwqWP1ta3nEbN/zEJoK/NvgWdXEwpNjTt6WCuJKDgdy+2Y9We84YzkkO0/uqxfH0NDlmAP6423lyvlAEaS2tjdxPLoll9WjohcHvfuZdjF72IWqAPhsxTRwfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200442; c=relaxed/simple;
	bh=tx/15BhW91icXihPUCw83KIu6vmOLG0kY1gHn1Q0uAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ebZA91mwMg+Ed7MaYVTQEIZBdajvCQMgH3PS0fQ/ztAkBV5f9yfoa4vf7Roc8efGE3wBjFiJ6b5P+4HPrNYSpkotYqf65hFu6hqT8jTJdH56f/Acy/Djmo2gHQOS3kB/Pw6eh1z2PIkGyht9/DXc9MQ9F/fqylUhQM8eBhRt8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYdcRWqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYdcRWqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EEB1F000E9;
	Tue, 28 Jul 2026 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785200441;
	bh=OyPpoyF0ksOelkHLFtgBU2UGOfnJ+e4tj53QqJ1oG3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AYdcRWqUfBMW5n/Eu2OftxhfJL2opB0bhICBbvW9JvuZiDoNuceix5676aHJtspV6
	 rI0aQjJFcKAzt3UEKdIftFOMCquKGDsfF+vjY65lEF+pr5ipkvyPa6kOvn1ldDBAZT
	 I2KY3GZUASWFDyloetyeKBb54JK0rtxOO/UapwY/eKCiQfKymwMwg9kC1nPmhz1M0X
	 7r0JnHHoa7stzXNRgLZkfG1YhQtj01EulIkY9R/wbgDkP9/qUpRxAjk2FsBw6IxdC1
	 v3MWwWgY5VshsKrS7/lCJOaq2IZPfTz5Urgdwms1g06zZDQqupLons2MXJkoWdOU8j
	 7I1dhNEh76L+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56898380CED8;
	Tue, 28 Jul 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Report the real error from
 libarena parallel workers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178520040591.1482784.935506705989795125.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 01:00:05 +0000
References: <20260723061347.398591-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260723061347.398591-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 23 Jul 2026 14:13:37 +0800 you wrote:
> Several CI runs failed in the libarena parallel tests with -4 (-EINTR) [1],
> which says nothing about what actually went wrong.
> 
> Two workers can fail like this:
> 
>   worker 1: gives up, e.g. the rendezvous times out, sets test_abort and
>             returns its own error (-ETIMEDOUT)
>   worker 2: sees test_abort and returns -EINTR
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Report the real error from libarena parallel workers
    https://git.kernel.org/bpf/bpf-next/c/fdec474c65fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


