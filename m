Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62F13A48E2;
	Tue,  2 Jun 2026 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427404; cv=none; b=NKl5CORAA9kY7NGHqUTNJXVA1fL0XPIMUjEvLUGr8YFPaqcj3z4bjhoE1Z2mbNV4i0dZetCtmOZV4sy8zsMDHj03V6OMo/hrXgv2s+/EXt8p2O3MaA26xsJDNU/YO+MgVZ0mEhOcfjTlGB/a7ldPM8uou3XhROBrWmh7stHI2jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427404; c=relaxed/simple;
	bh=be5AKohs9VfuCdFtEEcL5+RpBBDiAxbaXM4gzXF0PaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EXYGA8ggbeOtyIBEsXl26rGhyiNK7HnJw8NeMHTzKFBZ5eqXUgoi1oK9j1laLfeI6eD3lPg96G/xREbofpAZkil6bNmF2fwA0U1qQe3AXPQktQj8HOPPof8tmIpXjSctC4fW6J5mv7d7x1A7t4YzZNOwAJHgABfBGj0AGyLsnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVvU3Vky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVvU3Vky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842161F00893;
	Tue,  2 Jun 2026 19:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780427403;
	bh=yXVsAin2aMEpAJMaB8RYDCVaVZtL4AZzPKvQvGUBlew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HVvU3VkyfQa7XeXwPTfgHZOK1CGHPsp4xEp/twYg2A+QiVLKnCt81T2W3VM93cNhH
	 2wpAyzstkMRz4WTGuFZ2JoT7stisKj6OGZg2O7gpeKhP1rj8de7JHw9Q1ZeEOGDNNN
	 bMtdsbX48zBgJ+JWqA85+aBihlP7sqMPFTNY11Yw5DTpeHFkxFy0tmCGNBIf2E5ARS
	 zCN5b9bRsb0qpm+Gj2RUp4AITRD3pWnIF8l4GkqzHKxn89dXCAqe8NPccmYJnczGK5
	 TqqHZOaBDQpa3oA7CK7cz73OURxUvgLT5f90fLumLjEum8dxuRtKSuFTwY9anzCYRU
	 +ViW2OyA+M7yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 997453811A6C;
	Tue,  2 Jun 2026 19:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/1] bpf: Silence unused-but-set-variable warning
 in
 bpf_for_each_reg_in_vstate_mask
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042740541.1010994.11013299870656363791.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:10:05 +0000
References: <20260602175204.624401-1-ameryhung@gmail.com>
In-Reply-To: <20260602175204.624401-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  2 Jun 2026 10:52:04 -0700 you wrote:
> The macro requires callers to pass a stack variable, but not all
> callbacks use it. Add (void)__stack to suppress the clang W=1 warning.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf_verifier.h | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [bpf-next,1/1] bpf: Silence unused-but-set-variable warning in bpf_for_each_reg_in_vstate_mask
    https://git.kernel.org/bpf/bpf-next/c/c169a2a5fd9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


