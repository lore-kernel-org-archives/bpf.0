Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544806;
	b=x9MUgtoOqtRFbg3EulerH6NyJ6MQL+Mib9tRlro7DaF9S2vAkbW3q8KeEJAy1Jk01OKY
	 j433iVndiGNLk92UCGvADrNsuITxcHnxwtL/mEJSPDiLhZJlrJ+kA1GnBei8jbPUy5E5q
	 lkyRojoALtfHKgP2+kaZtsQRBgbszl69qufcdftr/IrhZ8aekG6rhxqVrzTieoKQsG+FN
	 x7l5MA5pyZc85v4c3bcRSSIbwOoTnBTCMPwbNxKJ3tmbd3iTUNrbdXdVEK020aaRMgFnO
	 XBkCbbMkbq4iCFjDNj2uGE6XL3obbkPGLA3WoVNf0AfKGiaU5rjP6SMUcV3uV1OoMCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=qV1kmvem6IC73sZN0FEl20QggbxcQVRAZqpQxZm5/u8=;
	b=M5sEonL1MCc+8ZZ2XGejBNmhwInysRS0ZTRfk8gmmsfJML+Cj8/nCLvlm3pAdp1m5tFk
	 Du3vS+ZY6Nq1TlRI+Pki2ubLxqFUzg9cr6+RO/GKmkdHHQXJHbw/r0IuD7F3uRScrmjos
	 9/JpfwiLT9CshUT4edMS4OHodYyZkGCQVinU4IPecvS2KN/ZtCxC+a4JN6XMbVeXy8mA1
	 3OZRvtV9IC8JtmMduagJLM70d3NAaVsshiiqVQwBoyo+g3T/jjLkyHeLHde2c68GKF39F
	 VpSM9aNEa62d7iuFkwG0ylq4P53n9MVQDPxWI5GtHRNrkW5YFgkkPv31r8RWcbT4SzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkUtjPaC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6E606A31C;
	Fri, 13 Nov 2026 04:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkUtjPaC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079811F000C4;
	Fri, 13 Nov 2026 04:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794544806;
	bh=qV1kmvem6IC73sZN0FEl20QggbxcQVRAZqpQxZm5/u8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SkUtjPaCxEZW4evb7KGVPjaPmMyB6TP34/VHjoi4JeC+86xb5gFB1ZNA4SUZ2RMQi
	 Y1uZPHpZBkETz31zJ9fZVaIJSnAqJAIFCwh41zwdUS2ptwthjfh5BTedioPmntDnqM
	 ZCUdWcjBqcPgIqqIcTMgRYpTKdYQMxmAJPE0Ypfw3+cTwDFovDvaaqflFxTwXJX1Js
	 aAlNBrEgFEDNnnazdHYHiYscW3/w9ckp9Ixeb2piXA26spfHyGI+NdsswvWgynBPeM
	 vn+pYJefDnli/gRuuTgdfhLJWRURZm24yuJkkT6epXWbuOhy9VwVnX43B8LHBApX+c
	 2UBM19aXD/Gtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14E139263A1;
	Fri, 13 Nov 2026 04:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Report RCU-tasks quiescent states in do_check()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179454480468.802512.11142215912522075935.git-patchwork-notify@kernel.org>
Date: Fri, 13 Nov 2026 04:40:04 +0000
References: <20261110-bpf-verifier-rcu-tasks-qs-v1-1-99e8f798a6dc@debian.org>
In-Reply-To: <20261110-bpf-verifier-rcu-tasks-qs-v1-1-99e8f798a6dc@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, davem@davemloft.net,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 paulmck@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 10 Nov 2026 04:18:32 -0800 you wrote:
> I am seeing rcu_tasks stalls in the Meta fleet on debug kernels (KASAN,
> kmemleak, lockdep), where a task loading a BPF program stays in the
> verifier for over 20 minutes:
> 
>   INFO: rcu_tasks detected stalls on tasks:
>   000000000cc1a43d: .. nvcsw: 4/4 holdout: 1 idle_cpu: -1/91 task:GlobalCPUThread state:R  running task  pid:175256 tgid:169948 ppid:1
>   Call Trace:
>    __create_object
>    __kmalloc_node_track_caller_noprof
>    krealloc_node_align_noprof
>    copy_array
>    bpf_copy_verifier_state
>    bpf_split_cur_state
>    do_check_common
>    do_check_main
>    bpf_check
>    bpf_prog_load
>    __sys_bpf
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Report RCU-tasks quiescent states in do_check()
    https://git.kernel.org/bpf/bpf/c/7f1e33230b7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


