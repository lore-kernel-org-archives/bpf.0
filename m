Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC17E;
	Tue, 14 Nov 2023 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJmf7mz0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AC1DC433C9;
	Tue, 14 Nov 2023 02:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699930223;
	bh=w3Apu2XJOx2zAc+8tmbGkJc2kkCZpUh0wDDxjphVo88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sJmf7mz0+p8Ocah7mFtGYsNKovrLBnAS6ajLo9XKfyXwhh7+KJcuuQ3IVg0ymTnFd
	 2UU2D/hctITcoxJbQk7VBzkklkst3njwmXxS+2Zco/ckvYO32qF900uDXEbi0dFN/5
	 kG5D5rcvwr3G2cMEFCnlXWo/0/bsnPg0CE9qG3S/n1LLY1lUx/OQbsbhxksNZqvaUl
	 n/tY8KziDC8X4ZYjgb6sO1q7WXEj6cs26/yd3JTpqm69C/sQW9DME27y3oNY8naJRq
	 no/l9kJY3qgKI5rcYWJJb/roo108L7pqT6hgM70cEvK2jJMdNnpIO0CFi0j0DnCYFA
	 hEpdrjRQTVRrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0327C4166E;
	Tue, 14 Nov 2023 02:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: add assert for user stacks in
 test_task_stack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169993022297.16978.12109016347252575594.git-patchwork-notify@kernel.org>
Date: Tue, 14 Nov 2023 02:50:22 +0000
References: <20231112023010.144675-1-linux@jordanrome.com>
In-Reply-To: <20231112023010.144675-1-linux@jordanrome.com>
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 11 Nov 2023 18:30:10 -0800 you wrote:
> This is a follow up to:
> commit b8e3a87a627b ("bpf: Add crosstask check to __bpf_get_stack").
> 
> This test ensures that the task iterator only gets a single
> user stack (for the current task).
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: add assert for user stacks in test_task_stack
    https://git.kernel.org/bpf/bpf-next/c/727a92d62fd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


