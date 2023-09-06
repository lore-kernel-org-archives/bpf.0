Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F4EC2
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 09:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E86FC433CA;
	Wed,  6 Sep 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693990824;
	bh=QNPFgd+yyTT9DYfng7Or+6TvK1s+JkRv0rgyGDZdH7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LsLPfnkEZccRAyxC1TJTJa8qcgFKUiQ+Qd0aJL1OTfyL8l7XNf1jJ2QAN4tWp5Fyh
	 FTlpsiZGH/DSFsrLwYvznSNy5UhPKrSxnO44M2Ys6FEd27XjBiuau/IuE9dF9RUnKf
	 S/J6yxDxXuLOaXEBwWrrGa4EFtUaDl140Dmc/ZLliAXa67rc1jaLAOa9ZfI+cYL8rC
	 /jMcOrjLOIBJ9KR7oeW1muIRhPEe3d5IF6p3lq93iSnlWJqbmtbCNb36vJDWfOBj5k
	 KuOa3t1lg5lFGrsAbRGG34aWkmvXYNUfSa7LNCnfYwRbPigluv7378ZmNzpRwcZX/x
	 aGNOxodqkr/Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17996E22B00;
	Wed,  6 Sep 2023 09:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] bpf: Recursion detection related fixes.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169399082408.6662.13042138757218427473.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 09:00:24 +0000
References: <20230830080405.251926-1-bigeasy@linutronix.de>
In-Reply-To: <20230830080405.251926-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, kuifeng@fb.com, tglx@linutronix.de

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 30 Aug 2023 10:04:03 +0200 you wrote:
> Hi,
> 
> the two things popped up during review. Compile tested only.
> 
> Sebastian

Here is the summary with links:
  - [1/2] bpf: Invoke __bpf_prog_exit_sleepable_recur() on recursion in kern_sys_bpf().
    https://git.kernel.org/bpf/bpf/c/7645629f7dc8
  - [2/2] bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before recursion check.
    https://git.kernel.org/bpf/bpf/c/6764e767f4af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


