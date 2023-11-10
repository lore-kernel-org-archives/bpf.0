Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10283A27F
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLtslY0k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 371DDC433CA;
	Fri, 10 Nov 2023 19:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699643425;
	bh=JRa0rv6mwzRsdCNVGKW6llGUW+U5Se1kwurCv66Vse8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JLtslY0kZWX92m4k8io+gI6t9WUq1BCSzCJf21VECJiKtV3Od7Br1cV4xl3EFTroe
	 kUbSXPRR+QQsfGecyDSHf9Rb1SyBARM7gUn9JksKqt70P9ZTAyDIxwVngpzGAWAXx5
	 +u+7EzjwWBOlfvVaD+tc6T+KDBC7Whufy9nR9cddr6aNTqV062xaDguMZCT1A/0W+f
	 qbe/PPa1D0oNXxAoZuc/QckhP/wlQwkpSEo4hPE/paB1hUOoEIo3CLGNKFxiS40UNh
	 Osq6BnwXxAMgRdDNKz/y6vJr5cfN+Cav024UPu5KEqPkFLKvmBE212m0nzGKakSzni
	 VwnwIOZIADYmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19C18E00083;
	Fri, 10 Nov 2023 19:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: add crosstask check to __bpf_get_stack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169964342509.26701.16290991235531133661.git-patchwork-notify@kernel.org>
Date: Fri, 10 Nov 2023 19:10:25 +0000
References: <20231108112334.3433136-1-jordalgo@meta.com>
In-Reply-To: <20231108112334.3433136-1-jordalgo@meta.com>
To: Jordan Rome <jordalgo@meta.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 8 Nov 2023 03:23:34 -0800 you wrote:
> Currently get_perf_callchain only supports user stack walking for
> the current task. Passing the correct *crosstask* param will return
> 0 frames if the task passed to __bpf_get_stack isn't the current
> one instead of a single incorrect frame/address. This change
> passes the correct *crosstask* param but also does a preemptive
> check in __bpf_get_stack if the task is current and returns
> -EOPNOTSUPP if it is not.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: add crosstask check to __bpf_get_stack
    https://git.kernel.org/bpf/bpf-next/c/b8e3a87a627b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


