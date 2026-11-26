Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726208;
	b=nU1sfEMtWyNzf5bA/BVOxwg8yvtHwMXoSU9vumNzmjI9Sno5k+uUISIAPBsLic+4GAvb
	 oQjWaptrsoKQ5J6FZF4hstAyhOlZjnFToQX//SAewjfCrD+2eGIJiAGBPHdE4owFCt9PQ
	 25zs71Uppes4Gbeh0vP8rBscUJw+AtBKc4/k6kQQYEht6S6DOm67NvS4X1mJDl9/aW2wq
	 TsHTXSH3OdrAXthkuQM0XV61cAM2O6Bneqy0i4+82qJwWVYDY/9W1yCtLwy5eApHxMaTR
	 jYDaU2+dQP/ZPSn2bDyDrPBgBz1px3iAZAWnaQMtkDsSAOKpnMWPoGYit4L8oYU2bRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Pw6THy7edbkIh3HkC08AtqRoELXksy9z3YBPRquFZ7g=;
	b=QxKtCAGPjbZ1i9C4AsFe1tI8xMZIZXXhB1e0il6srPHwZ7eSnTelG+0U1p/Mdh6QBKns
	 PWb0GqsOO1UORoKRHP0yg64/5BoqnroMJCYOlDhRjEtjF8hBJBds2rSAiXweMi9DvFr0N
	 Fu8pixgdbEVl30qyVx/J7rFdPE9hnSI8u/EyJcXbtpdhhBdzTRBTluyOq4UdIfzF8f1AH
	 Xk2m4Jln3WoyLbLtSW78CXXAxcQU0/lBTKzwSRt20isyUU1ojYMSj5nsJrNkJWb1zAPKI
	 mqRsXAf3vaf4M2MFd6gvUF94KfUorcZ2TmoiRcmQC57DJdKUj6SzTWyS8pl1UblPUSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ih9UZ/z8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19830606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ih9UZ/z8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A791F00898;
	Thu, 26 Nov 2026 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795726207;
	bh=Pw6THy7edbkIh3HkC08AtqRoELXksy9z3YBPRquFZ7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ih9UZ/z81Ia7wVpoABMGdBT0Rj9QvcXhKGb4A8lXu8CdVZYprdqa8wc9l1PD0vpiU
	 OyGBck1eLt6H8cEvJhP87OpPhbmvsggm1eYNqQLIxYh6Bj9uAirUNBeMjODIprLqn5
	 UpihoEv2dn2eqdRTmCCMojBYnJ4TLjr1MQzEis0LrFYKfqR0e8D/Pjo1NFCBhZBhHC
	 QgMYizXN7w59ZXQqIEBSaDW61d73aqKYE611FsQ+WKx8g+5q9qoBt1/y13a4AVBMPf
	 eTwj5iyyUS2QQ5QyGrFZIYX/xthzGYkGhqp5KO+X2eTN95bUbJLX6RmtWz+gu5ATM4
	 xUw9fLjO++P/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE75A3803326;
	Thu, 26 Nov 2026 20:50:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf] bpf: Reject kernel threads in
 bpf_task_work_schedule()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179572620625.612301.17016453928319997896.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 20:50:06 +0000
References: <20261126053016.1145482-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20261126053016.1145482-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Nov 2026 05:30:06 +0000 you wrote:
> bpf_task_work_schedule_signal() on a kernel thread sets
> TIF_NOTIFY_SIGNAL, but the thread never returns to user space, so
> nothing clears it and signal_pending() stays true. Interruptible sleeps
> in the thread return immediately.
> 
> For kthreadd this means spinning at 100% CPU. io_ring_exit_work() waits
> on ctx->ref_comp interruptibly, assuming a kworker gets no signals. If a
> prog running in that kworker schedules task work on current, the wait
> returns -ERESTARTSYS and the ctx is freed while ctx->refs is still
> switching to atomic:
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Reject kernel threads in bpf_task_work_schedule()
    https://git.kernel.org/bpf/bpf/c/3c625090b46b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


