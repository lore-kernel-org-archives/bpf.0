Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466E1632E7
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496435; cv=none; b=Lx6a737KTK+pM1xl4xu9DP6JFPZxvev8eQ2sujz58e9yaTfihx6pXq1SuWD+q7fejaF9Og6ScDUlcCnYeMkUtY68Yc6MQVUrM/77aJ33BlAAgCyLMJoZSBZ/WlgsA9vVsd2TVu1GwLNOJqq/9qhrOf4LuMvyqbEInnRGJ89NnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496435; c=relaxed/simple;
	bh=xYb2jHQPQiUs3GmvWTIx5BYqgK2WreRFhEFjqODv+Es=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PbpaiEr85pmwxFH0ZMcUaR7+Msvoz3emHA0tAOMlXkD8plGnTcSdXuHSwPvP6HBqj172jEoMovIgReQ+bo467t+vko4TbnZY4H2wVY5FTTCpAdjAtogcJ8VZ9tGqzuKhWqMNSJQJJ2BZ2joVpyleUAshi3XPljADclaQhKueiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF0a0NcE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF0a0NcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C161F000E9;
	Wed,  8 Jul 2026 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783496429;
	bh=5o5R9No+ryXaDg0eP/qIRyHUUawmL/4tl2FcioyzBUs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iF0a0NcEURG6Y9VGkMJG4ex+bD3tehgcpbmGLkSb/EsX7vk5DGDVQR6RXNuBmbaht
	 556d5CsaT5q9jbWBvhMJIsQjHyGrxM6ehPl3IMHWwsukVUNGcMyd6wzXMeNRHTe1od
	 u35I6JbNE2gQ3vGNTGZL1wjonAd0ufw9/wLNK/XHvODo4vTbwII/BMWOwI7mV5qg0W
	 6P0MAqQlaPNXtppANpasjMKZioQzs7ejVknstzbcuYE89GKTcfuhfqdSPYsW8DQljt
	 wifJqbpRq5GhazYic+7l1DoNSOMpuwBn+4tA65G0azsGEtnd/SRg6rAIhaZOzEtDx8
	 V4bttXCrGDsww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AFA3926266;
	Wed,  8 Jul 2026 07:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Fix for untrusted BTF pointer writes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178349640889.2347541.7352741986692664220.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 07:40:08 +0000
References: <20260708030752.2503467-1-memxor@gmail.com>
In-Reply-To: <20260708030752.2503467-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Wed,  8 Jul 2026 05:07:49 +0200 you wrote:
> When using custom btf_struct_access() callbacks, we miss rejecting
> unstrusted BTF pointer writes. Fix and add a selftest for coverage.
> 
> Changelog:
> ----------
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20260707190214.1997705-1-memxor@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Reject writes through untrusted BTF pointers
    https://git.kernel.org/bpf/bpf-next/c/ac65c710cc64
  - [bpf-next,v2,2/2] selftests/bpf: Add untrusted BTF write regression
    https://git.kernel.org/bpf/bpf-next/c/9eab4790f11f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


