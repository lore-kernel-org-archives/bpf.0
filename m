Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D9E2D73A6
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781133611; cv=none; b=ZJT/mmJHnAttw9iEKp7Jqvojwx4jJiEKueTxNC2E9l/lqjx/hP8hsAdy19Ba5QQiXqXuusg7ViWgUA7ETXUypWcHiZp6YGmZ7PURq1YCHKrRKtEnOh9fsp/Ct3NOdcnGxp4ydyxwBuMh6gKydLB977bFCTWO2nKKFnsS5gjm950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781133611; c=relaxed/simple;
	bh=syoyVVyGAPxvf/IhYYywNXKDgVxa8/yj+Ejl17+AdWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uZvuoakyS6+F/vcu8jyd74CC40pAWe4n+MqfQEng3kRAXyC+/4jb0u8zqOP5YpYS7QkLikBopvzFQQk/pn8uVieNWIjFSPvkSqlxVlwVCXcU/jAiladnLLq9fPAlBAjmHgm8ysm9RRNlZj6adECuYVLHVO24FkXELpXHAOiw8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrJoehHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrJoehHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DE91F00893;
	Wed, 10 Jun 2026 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781133609;
	bh=11Jlul4j3Vi/tWJgR3GqWzoeKHtdpWM2SAdD87ClgEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BrJoehHuQbU6+04uN6HtOZlTJjLzoUnG/nEk2XwhfiPtlXV29dKYCNb32HBG+Vg3b
	 FQHUkvkzxRG6UfDMdxBSrh5XKzK1rVm4L9mVthQGB/2xMYs1A4uzdx5mOKS5AycQMt
	 V9etb/qPyLmRRbwiXT1r06h7FlOn0p8gE2+7oE0dLsf6+zOXhvXbi54uwVGi5+jnnc
	 NlgBxEBN5t4Q5RfRwEBVsXLsNnSk90QwNCepatJC+biyOQuC0PQ9GQFo3IlDfH17sS
	 fkScn4izp/G0KWlrlAG4o8j/25PIR64vgXn0BFjzEWv7N2kjcry2lvrsD9sExd5UxO
	 eQEr40lo+gOug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08823930E00;
	Wed, 10 Jun 2026 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Tighten cgroup storage cookie checks
 for
 prog arrays
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178113360740.3670402.3459348998786835007.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 23:20:07 +0000
References: <20260610105539.705887-1-daniel@iogearbox.net>
In-Reply-To: <20260610105539.705887-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, yonghong.song@linux.dev, malin89@huawei.com,
 ast@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 Jun 2026 12:55:38 +0200 you wrote:
> The fix in commit abad3d0bad72 ("bpf: Fix oob access in cgroup local
> storage") is still incomplete. The prog-array compatibility check
> treats a program with no cgroup storage as compatible with any stored
> storage cookie. This allows a storage-less program to bridge a tail
> call chain between an entry program and a storage-using callee even
> though cgroup local storage at runtime still follows the caller's
> context, that is, A -> B(no storage) -> C(storage) path.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Tighten cgroup storage cookie checks for prog arrays
    https://git.kernel.org/bpf/bpf-next/c/10627ddc0167
  - [bpf-next,2/2] selftests/bpf: Cover tail-call cgroup storage prog-array checks
    https://git.kernel.org/bpf/bpf-next/c/30dee2c176e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


