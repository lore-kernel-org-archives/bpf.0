Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B03F39D0
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284280; cv=none; b=HK6T/a5ka/H3qfjQDngE3278l0p4WNKPgvcsgcDo1Mxd5M6qNLOF8ZSAjaeldQrsMV4HodwzD7jYCzWryP3XvKoE3crsAdi3GWCnrQMCXBMGuedWESl2Tuvl2wk16v6GY3I4cAN7jUs0vJXnsjl8Jq14MjQw0DFHLMn3fnnWbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284280; c=relaxed/simple;
	bh=UWMx24jNhyMN10He2G6GYq3hLESdwPmlbKmsfJI6kO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=foMiBSrCRv2X6g6aDe+K8Ta4rkP8eu8o1YDHu3afBb0eAGziUCC0BjTevBwFGguIGYuyr8aid/e/8ukfsm0KVxIz7A9AX/Jol9B0AYB+ds7QiXZ60eqyCkgwM8oXaS1VWapIpca7l+yYGDEgCbTn+J7GFbZokNkhTdEeYKK1RlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBUsgaXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBUsgaXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DB71F000FF;
	Thu, 24 Sep 2026 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790284278;
	bh=8TjiWzJ59MxY8A6f7qitBBDe6dAA42BKo8W7DQWI+0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iBUsgaXEo5w2flFPh7y+qAOJc6wLH8sH+IM7+Up2hdRfZGnp6tVhVVe4Ttmunj+qF
	 u6gPGxE7kBuGITEx5xiR3LcHoQMsGPkjkjW2WjQlpb7XPvbudoKkMWAzncnPk3uWLo
	 X1R+PAt9/qu/ehgH/xWqbA2TZtmM5KBXdcalDqEOpWsMNEcA7j1Qa24IPe92pEqjks
	 Qno3sCKviFmBU3dcUyRhMuzMl0A1b0MoVjlgvvCrPlZP1c/CHfuNZPUbGp7ajBQO+a
	 43sQmltva+2cxOh3uIWfZIhHlJq1KN2E0FdrguHNV+yGigbDPh1cDrnY32zmiB+b07
	 km+4FiXGcn5xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93DEC3A566E5;
	Thu, 24 Sep 2026 21:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/7] Follow ups for verifier errors set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179028420740.2201630.9968715215127891056.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 21:10:07 +0000
References: <20260924170646.2366016-1-memxor@gmail.com>
In-Reply-To: <20260924170646.2366016-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Sep 2026 19:06:34 +0200 you wrote:
> Some follow up changes based on comments from Eduard, Sashiko, and BPF
> CI Bot. See commits for details.
> 
> Changelog:
> ----------
> v2 -> v3
> v2: https://lore.kernel.org/bpf/20260924092941.3174809-1-memxor@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/7] bpf: Correct verifier diagnostic attribution for stack reads
    https://git.kernel.org/bpf/bpf-next/c/9774ae5951c2
  - [bpf-next,v3,2/7] selftests/bpf: Test verifier stack-read diagnostic attribution
    https://git.kernel.org/bpf/bpf-next/c/e4b20ef33f93
  - [bpf-next,v3,3/7] bpf: Drop dead spill diagnostic condition
    https://git.kernel.org/bpf/bpf-next/c/e9ac05b98278
  - [bpf-next,v3,4/7] bpf: Report non-sleepable kfunc programs accurately
    https://git.kernel.org/bpf/bpf-next/c/dac3b7a30d7e
  - [bpf-next,v3,5/7] selftests/bpf: Test non-sleepable kfunc context
    (no matching commit)
  - [bpf-next,v3,6/7] bpf: Correct Program Structure diagnostic context
    (no matching commit)
  - [bpf-next,v3,7/7] selftests/bpf: Test Program Structure diagnostic context
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


