Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80064175A70;
	Fri, 24 Apr 2026 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057245; cv=none; b=QDUobgq6T4r1Ni78IRmJ2O8aMcPP1a417WU+QVn6UmOXUh+L96kll03ZWJIBmiABqDriI9BpVNvBqRlpWqUTyU+EKt3cX7tQR1b2nGt0RGHIWdMyie6yVJMTgEgSuMQ9agnTLKnesjbFtRw9D80tkd6ILL/zI3CgA9LSd8zxm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057245; c=relaxed/simple;
	bh=e5THWgQ2qvTqUS6mnHcKfxncvFqBGVEvpaQh+echsvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M0D8hD5/5t5hc5QPSdQNZpIoPYQ4SGuaQvpwIvFNCtNmpi/OHS/nH4F9DLzT81KxHpEsK7FRqu2LRpu0jNHu731DTitU+rs6tWyLx90CGVf19PuWLXFrEV7lo11lwd+G/q2MePmGNlMosD2eDNQRB/IHoiete8cntzqk0E5CtYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2pGAO03; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2pGAO03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CE1C2BCB0;
	Fri, 24 Apr 2026 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777057245;
	bh=e5THWgQ2qvTqUS6mnHcKfxncvFqBGVEvpaQh+echsvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N2pGAO03dVgDIw7lNCjzRk+WTf0KbtYfyzgR0tSvtYm/lJUyPDnViTZNEkRpAIoJT
	 daSbdIO/hjtkDERLHNdptLbAJ8oA2mqsCwQx3KtMtuukjW40lRaK+pvfExH5LuE0Ti
	 49i7iSSPDtaKQro/uj2Wq3CtCQJeClojHllA3g+HZQ/yvt13jDtcaEQ/ISiSyn9Ow3
	 LV3wZ1oGI9eB8JV46jRsR2VacRQjeAtVebaNGCSdD62KMPmhfxD75uy+8YX57eyGeF
	 iKI65CoZg7S4RUotbLCn2aCVYvdd60OusNPf5wDhb56QXrMzrkR42Y8eUsAr9xE+mr
	 SqQzW9LIIClRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EB638119C3;
	Fri, 24 Apr 2026 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 1/1] bpf: Fix sk_local_storage diag dumping
 uninitialized special fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177705720556.1666834.14763637651249845423.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 19:00:05 +0000
References: <20260423222356.155387-1-ameryhung@gmail.com>
In-Reply-To: <20260423222356.155387-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 23 Apr 2026 15:23:55 -0700 you wrote:
> Call check_and_init_map_value() after the copy_map_value() to zero out
> special field regions. diag_get() copies sk_local_storage map values
> into a netlink message using copy_map_value{_locked}(), which
> intentionally skip special fields. However, the destination buffer from
> nla_reserve_64bit() is not zeroed and the skipped regions contain
> uninitialized skb data can be sent to userspace.
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/1] bpf: Fix sk_local_storage diag dumping uninitialized special fields
    https://git.kernel.org/bpf/bpf/c/b5c111f4967b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


