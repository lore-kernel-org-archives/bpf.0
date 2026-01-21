Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371B3563CF
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017816; cv=none; b=Xnz2ATmm/e9d/IDWcefB6Dx6V3xmaNO2PPtnKo3yodd1n8xZ+JaRyxd7RfM/qfPX1Wh4c2TwAnYV6N2jSKaZiRgapDYCqtVfNqBzTCpG92UDY6Pp8mj5raeyezkCpzAOlqLBzY5WrAj5cFiRvPo0sfkBma7+cV4++xzRPseF8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017816; c=relaxed/simple;
	bh=DClSetSFWrMFXaz+lXLtRwEaHKF2FB/oH7iXcEASFGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OrJ6tpSnkeZy7G+p+QY5l9dyhiGsJRv3AXvMjPOQwqA2jFEuLCF9VHTIuHHBDopAiMdO1kS/ra7/KNU31+FrQ3dqLa/uJhngRoeSnVT5dyoMUJH3HK0L891s+Gj5x3VblHz8JoU6Mi/vhVsXuLy5QqGQ5rdNmjEfuDWvJMny8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILyqu41F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILyqu41F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11795C4CEF1;
	Wed, 21 Jan 2026 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769017816;
	bh=DClSetSFWrMFXaz+lXLtRwEaHKF2FB/oH7iXcEASFGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ILyqu41FdqeBfrzXiXIOthEJ0Ykx+nK+vEodm7h9rrvlt6TqgiP8sjugRSiABa710
	 2O/fD37XmGu03cmR3gv5EDk/esVQvl8ZtZromAWEOB5W/VhaaWLQOMQwECeXdliCMx
	 Ft+WutivM1mBvd2114D/tEXXtWA2QRxKRBLFAXl/VuQZQo9Kvp8CmebdcoUejmMZmF
	 lZ5pJS9Oe1uKSdtFU0+nh/DzzCdkDnnbOzLoum8PPDQ66rVdxi/gVlkU8H3/KYWNws
	 gSv0bI5+QzMXBSc79DCc7AR23OXAvbHSJBkKpHfDkI+KFR+tM4sJ91IfGsQKAivlGV
	 /h/po3h/XAwNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB993808200;
	Wed, 21 Jan 2026 17:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Revert "bpf: drop KF_ACQUIRE flag on BPF
 kfunc
 bpf_get_root_mem_cgroup()"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176901781285.1390629.13354862137498673865.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 17:50:12 +0000
References: <20260121090001.240166-1-mattbobrowski@google.com>
In-Reply-To: <20260121090001.240166-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, roman.gushchin@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 21 Jan 2026 09:00:01 +0000 you wrote:
> This reverts commit e463b6de9da1 ("bpf: drop KF_ACQUIRE flag on BPF
> kfunc bpf_get_root_mem_cgroup()").
> 
> The original commit removed the KF_ACQUIRE flag from
> bpf_get_root_mem_cgroup() under the assumption that it resulted in
> simplified usage. This stemmed from the fact that
> bpf_get_root_mem_cgroup() inherently returns a reference to an object
> which technically isn't reference counted, therefore there is no
> strong requirement to call a matching bpf_put_mem_cgroup() on the
> returned reference.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Revert "bpf: drop KF_ACQUIRE flag on BPF kfunc bpf_get_root_mem_cgroup()"
    https://git.kernel.org/bpf/bpf-next/c/d0f5d4f8f328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


