Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F673BBFC4;
	Wed,  1 Jul 2026 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937224; cv=none; b=ASakmSymfUNNI4GSHUvOHSVEiCxdF28kgcp11TIUHFDg88jTPcIsAE6n3cQ9ohPa/wCYfyPrPZC55uitsUm8DUgSg3bt2kd9CZmkpMsIy7Epr/aVCfh01aTfPMqF6xlMkZbkaZrB9ZYsR+Cvi4tpGpxrzArhAN4tVGF42HsD7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937224; c=relaxed/simple;
	bh=ddBMy76Bb5YvQtNS8kj0A+nhJ0zXKOrxP+Gufypir9E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HhTizDPhLfJuDtK9qNxqA9Et9c8PZVo7zACCYWS/KiXNyDfJOmYTQDwV6xOWFSK+GRVKtamKSU2JuYcmNn/djwGcjRv8EwxG0zMF7XMifDfZKA0sVounfqtdSZB8j9MzpZOK2tS6xfTSgax03jT5ouZhfzz+gbT7AMyow20qd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUSJm1xk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUSJm1xk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489ED1F000E9;
	Wed,  1 Jul 2026 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782937222;
	bh=2hTzQRbPisWhuaCC8jhjqKOvt0MI3YxkNFDOHP+DnJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SUSJm1xklwHxEyq8q8AQfgdnVfbStM9YegmcroXeeO0dAp/n9eUCEIrnjZBR/Qpsb
	 bIiycudtEh53gSYO4i0zXAjPK/Ujc1eAx9eGF0UEzDN2+TeVdFRstitXNPhKC9EWM7
	 M8FMXPAYlljfEaUtBxIM86uIHbIP7WOmouKyiHTCfvef0uShhPP1DMkpMLBUt1sHKB
	 o7uv9lmenlntJhNZjH0gThK2AFfsCQFggEGvOROxRUV5/sUN9fqpuKizbf/4X5KlNr
	 y7t8dhEqnXt/E4qyXT2PC6N1GegoEO3THH1mcUnVwGXTOIXmc5ic1Tnn/QZpJEzC5g
	 ic4242w1WNYVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A32383BA30;
	Wed,  1 Jul 2026 20:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf,lsm: drop bpf_prog_free from
 sleepable_lsm_hooks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178293720565.1283177.10375180205775376810.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 20:20:05 +0000
References: <20260701080757.1394144-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260701080757.1394144-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, paul@paul-moore.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  1 Jul 2026 08:07:51 +0000 you wrote:
> __bpf_prog_put_rcu() is the call_rcu() callback for non-sleepable programs.
> security_bpf_prog_free() called from there fires bpf_prog_free in softirq;
> if a sleepable LSM prog is attached to that hook, might_fault() BUGs:
> 
>   BUG: sleeping function called from invalid context
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5038
>   preempt_count: 101, expected: 0
>   Call Trace:
>    <IRQ>
>    __bpf_prog_enter_sleepable+0x1cd/0x320 kernel/bpf/trampoline.c:1255
>    bpf_trampoline_6442549705+0x53/0xd7
>    security_bpf_prog_free+0xde/0x130 security/security.c:5465
>    __bpf_prog_put_rcu+0xab/0xd0 kernel/bpf/syscall.c:2365
>    rcu_do_batch kernel/rcu/tree.c:2617 [inline]
>    handle_softirqs+0x236/0x800 kernel/softirq.c:622
>    </IRQ>
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf,lsm: drop bpf_prog_free from sleepable_lsm_hooks
    https://git.kernel.org/bpf/bpf-next/c/2ce3f548cfc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


