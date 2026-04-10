Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07462E3AF1;
	Fri, 10 Apr 2026 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848833; cv=none; b=mzdTcfjTcAr/IWg8xdSQt1piVtCFiO/Sj3Iwv59haaMyttjVpPAeodk2te2JfOLaqOLkbGE3QSy24IUu/mhhWHqtnM6ubMK9RjtFYBO2VHqbSwdA9+5zVUzH0ZsGgYc491UdPXLxh1kdeOr5TT2XEPoWvYYoXNbXpz7iBRXC30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848833; c=relaxed/simple;
	bh=VfrjedTPC4cqkK+kgh6i0dONjNOgIKt/KJhzsrO/RfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BZyUdWA/M06oUd5oAiRrCMsjCngfnkDutUmfUlqFvHGzui+Mub2+2ETYRjRzYDC6r8HAofF0i3uizcAcJt6XbSO1IW9XfWfraY1MewWweqNZEH2XPf4Y3TyldyWpzmGAbEmiJ1GT+0xwTCHMliXlWnDcY5N/Pxy5p258BVWIuw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhkmDa1N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhkmDa1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F803C19421;
	Fri, 10 Apr 2026 19:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775848832;
	bh=VfrjedTPC4cqkK+kgh6i0dONjNOgIKt/KJhzsrO/RfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RhkmDa1N7p+qYgydr2i92JsWdUsenHidKL0q8PzIzrHFGakK95/PZa9JSN1c8pVDu
	 iJmaktk/NkRYL5/J4WCYfliejP/4iFNWM++3JxybtsJ9QctgTBRHLakPcuHQOrkjvJ
	 fnOazlXJj+aQYCkf6t6YFjsFmyXLKZqzYq8u21LeugqGJvNmqMAI7Yvbk+HQne8s8a
	 DfIhZobALVqVzxXS/Q1gv0CbJyBuVtW0HXreetf47ed+Fvt7JYZ2RMihmW2fSMWQyF
	 wXWJ/3IU8czkODKL3Tcrs6phDzPsXGjJ3kdXUgkb4hosQ2TpCEgEgvL01lviNB0yDi
	 uECGSaHlzhiDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD7A3809A88;
	Fri, 10 Apr 2026 19:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4] bpf: Fix RCU stall in bpf_fd_array_map_clear()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177584880680.2610429.13126828004209763320.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 19:20:06 +0000
References: <20260407103823.3942156-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260407103823.3942156-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 sun.jian.kdev@gmail.com, leon.hwang@linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  7 Apr 2026 10:38:23 +0000 you wrote:
> Add a missing cond_resched() in bpf_fd_array_map_clear() loop.
> 
> For PROG_ARRAY maps with many entries this loop calls
> prog_array_map_poke_run() per entry which can be expensive, and
> without yielding this can cause RCU stalls under load:
> 
>   rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>   rcu: 	(detected by 0, t=6502 jiffies, g=729293, q=305 ncpus=1)
>   rcu: All QSes seen, last rcu_preempt kthread activity 6502 (4295096514-4295090012), jiffies_till_next_fqs=1, root ->qsmask 0x0
>   rcu: rcu_preempt kthread starved for 6502 jiffies! g729293 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
>   rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
>   rcu: RCU grace-period kthread stack dump:
>   task:rcu_preempt     state:R  running task     stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00004000
>   Call Trace:
>    <TASK>
>    context_switch kernel/sched/core.c:5382 [inline]
>    __schedule+0x697/0x1430 kernel/sched/core.c:6767
>    __schedule_loop kernel/sched/core.c:6845 [inline]
>    schedule+0x10a/0x3e0 kernel/sched/core.c:6860
>    schedule_timeout+0x145/0x2c0 kernel/time/sleep_timeout.c:99
>    rcu_gp_fqs_loop+0x255/0x1350 kernel/rcu/tree.c:2046
>    rcu_gp_kthread+0x347/0x680 kernel/rcu/tree.c:2248
>    kthread+0x465/0x880 kernel/kthread.c:464
>    ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:153
>    ret_from_fork_asm+0x19/0x30 arch/x86/entry/entry_64.S:245
>    </TASK>
>   rcu: Stack dump where RCU GP kthread last ran:
>   CPU: 0 UID: 0 PID: 30932 Comm: kworker/0:2 Not tainted 6.14.0-13195-g967e8def1100 #2 PREEMPT(undef)
>   Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>   Workqueue: events prog_array_map_clear_deferred
>   RIP: 0010:write_comp_data+0x38/0x90 kernel/kcov.c:246
>   Call Trace:
>    <TASK>
>    prog_array_map_poke_run+0x77/0x380 kernel/bpf/arraymap.c:1096
>    __fd_array_map_delete_elem+0x197/0x310 kernel/bpf/arraymap.c:925
>    bpf_fd_array_map_clear kernel/bpf/arraymap.c:1000 [inline]
>    prog_array_map_clear_deferred+0x119/0x1b0 kernel/bpf/arraymap.c:1141
>    process_one_work+0x898/0x19d0 kernel/workqueue.c:3238
>    process_scheduled_works kernel/workqueue.c:3319 [inline]
>    worker_thread+0x770/0x10b0 kernel/workqueue.c:3400
>    kthread+0x465/0x880 kernel/kthread.c:464
>    ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:153
>    ret_from_fork_asm+0x19/0x30 arch/x86/entry/entry_64.S:245
>    </TASK>
> 
> [...]

Here is the summary with links:
  - [bpf,v4] bpf: Fix RCU stall in bpf_fd_array_map_clear()
    https://git.kernel.org/bpf/bpf-next/c/4406942e65ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


