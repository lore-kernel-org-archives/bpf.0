Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B026ED4F;
	Fri, 24 Jul 2026 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926843; cv=none; b=IdJboezcVW3tWni9Hwzpd1Z9Rl8JprOdzp9hH2LmBnJiULx49SGhSA2OjhXz0TLy8sLEUSb2OSpf9Tl6Vyhyk33XVexU8LA6YCJ81Lq9yxGRekXRCuu090o6DlaH5ZC3dqwxHUOiQ/QyueHin5ii9M+LuKJu8WRfKI4qwzJ2Cng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926843; c=relaxed/simple;
	bh=Hax1Ngl625R57hhPxjAylE6C69iWNMqZOb2fL4elq3I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UYUOCh5QyMwYJLzzJpcsQa2lXNFEUFbUr20LzEZsVKEtYIjvCVSZ8aE8MSYjxPyYA8fWM1uyjK3Zm4b7RCZWEy+yg3MxBS1DA6y5YdfA5ow9/ucEcNM+IsPGzBitFcKHIBCpg13GimZ4d7TAQVAbvzmoJuRaMNaez1MOmBX7WJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnMhlCk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnMhlCk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E08A1F000E9;
	Fri, 24 Jul 2026 21:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784926842;
	bh=lhZIQc8o7qJLBKV17UQrM75AAGJOxYWoP/v9OZ+zd8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FnMhlCk2woYEp2fPtQ/Wt0r7btGVWNrhUofYcrLvaRqnMPdb6ozBuAIzbwFqvfK7u
	 x0qwd6p3eAUVd3SziA7xuI5ATOBP51vsjBrAXPPczyN8qNDVQnjAhGfkLARI+sLmtB
	 rcWaXbuR7JImdUpQ+zANWq60nquShTvQpCSR1pPfjynNOLpR1UFmKT9i/Q2yQe9ear
	 qCcdyqDi+AJ1HXatmmjYl6e9AgwNqUcSi946De2P+Vy1C0PgqIgntHCdFtr+dNSDCl
	 Jmvb5FXr0xW2YuSYHJ40qpc0Eu2XPU4SJtNuz2ODBqog8dpXxEbbiqQQ7C+2OA5zP5
	 5+gu8+cmNmY/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A8338111D2;
	Fri, 24 Jul 2026 21:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add get_preempt_count()
 support
 for RISC-V
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178492680940.3305171.3051143436591504393.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 21:00:09 +0000
References: <20260722022906.8778-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260722022906.8778-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 22 Jul 2026 10:29:06 +0800 you wrote:
> Currently, there is no RISC-V support for get_preempt_count() and
> its fallback path always returns 0.
> 
> Add it so that bpf_in_interrupt(), bpf_in_nmi(), bpf_in_hardirq(),
> bpf_in_serving_softirq(), and bpf_in_task() work for RISC-V as well.
> 
> Given that RISC-V has supported CONFIG_THREAD_INFO_IN_TASK since its
> initial commit fbe934d69eb7 ("RISC-V: Build Infrastructure") in 2017,
> directly retrieve preempt_count from the thread_info embedded within
> task_struct via bpf_get_current_task_btf().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: Add get_preempt_count() support for RISC-V
    https://git.kernel.org/bpf/bpf-next/c/9b19237a46e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


