Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795142407;
	b=T7mIwe5gdpT6AEchrFFQ1QKNI082jxzOXFj6u492+2f1jNPkcMhyih3nD0iadNwNnc2Q
	 ZRVTQOaFiWXqKd89LH9oV9PFA0FjNanc0Cv0VEdbC5X0lVkY9Pw9LDsyty9MWGRH1c7rh
	 LgtQ95NDWgNn88K809Z0jqAZXhgo825++DGJ5mQEkdHMZR3GC2IE/RbQEnH2E3YrA/Xyc
	 QmLSTHZ/QJ2nfHGoulXqo/yefLFR7UnXcRFlFYuoFkCDMh7DVR+7qBF8sloG40nna1X9+
	 YJVfb5HXGV9zSasg9n2eMhSl81wmGpfGUZnL+ttvmusxrIo8X1cBwVCmtinfd6tW+sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795142407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gttAyrJ+wMHr+Glcgouy7cx0rJKje8ChJMiYhq7/fZ0=;
	b=2SYPwwgohRHnNwxffCX0uUiTmdGmpNNJsA38NvbjBbaUqiBnx+RjZHtWaycLufoTaNBU
	 XNPeihp9CwPAvta0d6zIpa+uPpSDKIoI+S7lANa9PZY0lnpjHbfv1wfXAociVYqypflvN
	 sgwx55BsaATMMahm8nw8s9/FEkDrL/kpodsx1y/xm3TH3pjOQOH/MyZx0nz1f+T7DnAqp
	 hfKUUJQFugVDyV1gLeTRSxcV3og4mFLGw5r9Gt90jOpCOlQ4X44IOm3LvaJJkRMIOKrew
	 JIZEI1Sa0qH46pCxWnkubvpCKAsXH1vazDbXrIlgWYEn86pp1MPXjDnvIu5aoHqRJ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyOZ1Gg9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5B606A320;
	Fri, 20 Nov 2026 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyOZ1Gg9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4572C1F000C4;
	Fri, 20 Nov 2026 02:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795142407;
	bh=gttAyrJ+wMHr+Glcgouy7cx0rJKje8ChJMiYhq7/fZ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SyOZ1Gg9Bi5B0hlXjHgtJKD3pipKypaafZJWRX6z9RPhhaLrNC3K0s5CtSW5SI5GJ
	 QjXEXKdoQdXsroB1Y4DhGd3w93GCMQ9/rK8yJ3gK5mCktNhS7CusorMDYhqAc6AJaC
	 2Vy459uH56iFQsVVZp0sbFe6PeLubLRBLBrhC3xpRURbZJ9QZ83V2pHV77UyTpsbkt
	 53xPetogCbdr5PiCgD9HV+cAu76r1HtptgIxXszPEIqzO/2G3joApUxTcJl+uZ52nh
	 1Yt2LAcjMPQGWdT/pxQuU3oKRTaR6HhRWlZHsZG8qo3Z9iE6UKh8U1emQC9kr5ZNt3
	 74RLVDq+gmrfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A5B53808209;
	Fri, 20 Nov 2026 02:40:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf 0/2] bpf: Limit writable registers in uprobe context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179514240603.3989712.15825286425363086604.git-patchwork-notify@kernel.org>
Date: Fri, 20 Nov 2026 02:40:06 +0000
References: <20261118084451.12590-1-jolsa@kernel.org>
In-Reply-To: <20261118084451.12590-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 mhiramat@kernel.org, oleg@redhat.com, bpf@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, will@kernel.org,
 palmer@dabbelt.com, peterz@infradead.org, rtm@csail.mit.edu

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Nov 2026 09:44:48 +0100 you wrote:
> Hi,
> a uprobe BPF program can currently write fields in struct pt_regs that
> are loaded directly by the architecture’s return-to-user path. Some of
> these fields are restricted by ptrace, but the BPF verifier does not
> apply the same restrictions.
> 
> This series limits uprobe context writes to registers that ptrace can
> set to arbitrary values. It adds architecture-specific writable-register
> checks for arm64, riscv, and x86-64; other architectures default to
> allowing no writes. Reads are unchanged.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Restrict uprobe ctx writes to the registers ptrace can set
    https://git.kernel.org/bpf/bpf/c/ca44731a7009
  - [bpf,2/2] selftests/bpf: Test which ctx registers a uprobe prog can write
    https://git.kernel.org/bpf/bpf/c/c21b0f82ca96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


