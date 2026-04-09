Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AD2594B9;
	Thu,  9 Apr 2026 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775697632; cv=none; b=Kq3VIpaXhE4tpxZ79QgSGGUjtgRq6BKRs0YxHGgr6Ivqv62r2tUQ0vRNHZTCU+yt5wWTVaJ7S1ryalMHvfnQN5/j7CQNEq328mdwnYZSre80BCW1qRWY3QB2SZs39/3+XMRMM1HgLUXR3k5VMDAOS9dZ2uUsCvlaI019DGregIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775697632; c=relaxed/simple;
	bh=jffhaj7XtvWEHrEQlXWo93RdtoyPK03UBjowjBvGjP8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CEjqgjEkZAGBVIcnXM1furTiupgOezZDef65lIf5MbNsMxpOElFiTcKXG2BPa9kkbA4ym6e2PjaJCyJ/mFWF5R7z0x6GAG+nENBHgTKX75uzJIdRLQWl2koEyM0jBAwghSHX2qr7NpL76IwHN/Klw6IGnRosdemqa9EUVChwGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gryz7yrq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gryz7yrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E8DC19421;
	Thu,  9 Apr 2026 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775697632;
	bh=jffhaj7XtvWEHrEQlXWo93RdtoyPK03UBjowjBvGjP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gryz7yrqaPJrjCZGSIT8NbDvEiJeYzjfBfvVleJy8s/QH2qqqbaZiIRy0C7g80mUN
	 LBF7D8AjuGm9gunEzOgrl1cP/fUcf8uKyyhRHJN2DZBdh+pOxGndtS/MQ5APle5FtL
	 RpvjV+plg0FySjOcpMJoLDV/RsxeKHsKvRW1E32l+FTEobFZpfMC4vDzTFpZ/+N4Po
	 WRaOES0dehfEtbTX6E6CkuVZ8LLm6hf8a9sxNpqGJMDxXTTZAVMp+L+ZtvprugdK+j
	 XSqBvIhfUsS816pjZm7Mj9rHd5uz8ArOmWWDPNDb+iNQAlRD2z7U3T3sfIQHkptgbC
	 rWBD1R9muTmeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0233930793;
	Thu,  9 Apr 2026 01:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] Reject sleepable kprobe_multi programs at
 attach time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177569760855.941108.1194858936384188273.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 01:20:08 +0000
References: <20260408190137.101418-1-varunrmallya@gmail.com>
In-Reply-To: <20260408190137.101418-1-varunrmallya@gmail.com>
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org, leon.hwang@linux.dev, memxor@gmail.com,
 jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 yonghong.song@linux.dev, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  9 Apr 2026 00:31:35 +0530 you wrote:
> These patches fix an issue where sleepable kprobe_multi programs
> were allowed to attach, leading to "sleeping function called from invalid
> context" splats.
> 
> Because kprobe.multi programs run in atomic/RCU context, they cannot
> sleep. However, `bpf_kprobe_multi_link_attach()` previously lacked
> validation for the `prog->sleepable` flag. This allowed sleepable
> helpers, such as `bpf_copy_from_user()`, to be invoked from an invalid
> non-sleepable context.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: Reject sleepable kprobe_multi programs at attach time
    (no matching commit)
  - [bpf-next,v5,2/2] selftests/bpf: Add test to ensure kprobe_multi is not sleepable
    https://git.kernel.org/bpf/bpf-next/c/c7cab53f9d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


