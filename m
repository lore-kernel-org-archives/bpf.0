Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C1185E4A;
	Sun, 25 Jan 2026 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769359213; cv=none; b=hgRRHm1Dqk3ToPKLjMkIY89jsyz8s5Vx3tekKYaZQ2mgIgbcOWNh/+Wc5n/k1cuxskGXqrX2GgOX7Fseu0h8GbvZyWAUAMwd/u/oy3gpls6gyoAw8gKwYvDyOVcYa5mb0wKWXSky0jzPL6KSz9rR36ZYp/DYdj/R1LJv4HounTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769359213; c=relaxed/simple;
	bh=ztkJkvxbbBlJoVNZzef1/Cknb9VB0P+lMZABO+II6BU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ijF0Id40ygGlc0tFo6fbJZjd17cdLu5ru/7SO6a5oTT/PeXqNXZ8kWT2yo5fOcIz3EV37KEcPttLzsrxlz6c+mG/f5HWnES/0bLLPsqGW/8OWRO3whTBLmzfs+yyl6ts+Lq8gbijWAr9PSZtiKJyLm773zSU523gfYMOE3u+MXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNzULG8F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNzULG8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5222C4CEF1;
	Sun, 25 Jan 2026 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769359212;
	bh=ztkJkvxbbBlJoVNZzef1/Cknb9VB0P+lMZABO+II6BU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HNzULG8Ftdbp6g+y6RjYe0s4FJHsr/9fXa28rSvZv0BNn7MuH0jGze7PAA4yOOgcw
	 7EV+k4DwVFzECf0qM1A5ty16zApXf5cF74AuBOZtZn0lbm4SaTGF9PjTPP8HnElH5V
	 yG7qPIC24Fte5NbT09ChXO/qp9DEkAGNGLu20lvv5wtB9R6PCqu9+3A/+sCXTLsiRT
	 YMZRKCWh5pIlpddp+vRTq1S9Ko+yEqoa4MxbA0DuzPvx6XIBJJtmmW876Jr4LcS1Q5
	 wekzTmVv32cXpYMezq4VtCyQkMLTokXq7e5xnaK8Xl/Z2r8BhyBIu42sD9cYPlDknd
	 nmNy7+Mxg/HFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8BE83809A0D;
	Sun, 25 Jan 2026 16:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] selftests/bpf: Introduce execution
 context
 detection helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176935920760.3538157.15856817944846369498.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 16:40:07 +0000
References: <20260125115413.117502-1-changwoo@igalia.com>
In-Reply-To: <20260125115413.117502-1-changwoo@igalia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 kernel-dev@igalia.com, bpf@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 25 Jan 2026 20:54:11 +0900 you wrote:
> This series introduces four new BPF-native inline helpers -- bpf_in_nmi(),
> bpf_in_hardirq(), bpf_in_serving_softirq(), and bpf_in_task() -- to allow
> BPF programs to query the current execution context.
> 
> Following the feedback on v1, these are implemented in bpf_experimental.h
> as inline helpers wrapping get_preempt_count(). This approach allows the
> logic to be JIT-inlined for better performance compared to a kfunc call,
> while providing the granular context detection (e.g., hardirq vs. softirq)
> required by subsystems like sched_ext.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] selftests/bpf: Introduce execution context detection helpers
    https://git.kernel.org/bpf/bpf-next/c/c31df36bd26a
  - [bpf-next,v3,2/2] selftests/bpf: Add tests for execution context helpers
    https://git.kernel.org/bpf/bpf-next/c/221b5e76c1c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


