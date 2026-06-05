Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDD93B8111;
	Fri,  5 Jun 2026 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694419; cv=none; b=APE4/bjYDV2HiDnmFLNj+p/bl8mbcPRW0iVhGpEG7FDZwChWartQTr8M/6E25UNA1q3PAy/j+oy5++j5KHaq5twT6MZ39donQgAan3Z9UzjpCE70holsqshlG/eyZD892gChJDE8YFmnmShVO88slssrWSjmTzpBWmVPFZvr18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694419; c=relaxed/simple;
	bh=GLisNNr79RilsBf83hmqjpl1c33lV0qvVh+swN81Mxc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FuNN+2QSCzgQr7fj8nOu3dy3Z4ddn6Fzm58furiHAa4kd6aPVOq5G9ZEmqm1m6kuVGNeZTGFPhtQ0D7lO48mNR71RwCeOFJ0kQ/eWpMOMMLPWhL4w3TbyrmjCP44FozkCH0pb/LwE60pqH8xLqQoscDb1NIZgagEbP2hd6Gj8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWMarKt6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWMarKt6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0661F00893;
	Fri,  5 Jun 2026 21:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780694418;
	bh=LaPwKrlXZUR6VA1X6x4Ot2nGJuPPhBY6ZgGkaCpAzgc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TWMarKt6aZJ29efpKNao4+8PiHbcfFySHxG8Lkkm5tUo8tBirUxiRxJgnQVztn3F4
	 6F5nc3MJwI63/5RFP7o4Vj9IAfj5LU+506weuxIOhSCyVX26TxAy5DedSnwgrhWJT0
	 htCAlMmgm6TILoROn2z8SvPtIX1eHvLtqc9cJQKXy1FMOhu/BKYz+W66klIhA2QGyJ
	 f09qjw11EkP1NPFFxfp/meZYXRcEUMFChrx8v0MZdSbS02Su49nNw7DqCEE+zILwR+
	 NYHas9DVJFJc/bs+7/0yJWAKkzkb91sTvdEUIIFuklkXWqGPPuTZ8LXl1+lbIo7lMt
	 Qjy4FQrsCZ2Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B173930BB9;
	Fri,  5 Jun 2026 21:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/3] Object relationship refactor followup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178069441839.3922226.2143630279404764521.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 21:20:18 +0000
References: <20260604220904.1032145-1-ameryhung@gmail.com>
In-Reply-To: <20260604220904.1032145-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  4 Jun 2026 15:09:01 -0700 you wrote:
> Hi,
> 
> The main patchset refactoring object relationship tracking in the
> verifier has landed and this is a followup that addresses the remaining
> feedback in v6 [0].
> 
> [0] https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmail.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/3] bpf: Fix dead error check on acquire_reference() in check_kfunc_call
    https://git.kernel.org/bpf/bpf-next/c/a3863aa4f55e
  - [bpf-next,v1,2/3] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
    https://git.kernel.org/bpf/bpf-next/c/41025f441fe6
  - [bpf-next,v1,3/3] selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test
    https://git.kernel.org/bpf/bpf-next/c/d83d4f63cb8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


