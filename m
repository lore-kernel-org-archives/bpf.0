Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAB2628D
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775440233; cv=none; b=FqS1cZhFDkXPRS4tx5HLEx9VxfDlMJjmRoZHiNpzQiNcGcF3SCrHNC2RzrbSsK+4jpBu+jW/BWsGl9rzzAEA90T2bMLgIsBIazO+4d8iENPeGYawSPb/1rnkAcFdSqn0nBZsouwwo4B+HKUM1E2dVqKdkRIe9RrMXrm+ZAr/0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775440233; c=relaxed/simple;
	bh=BDtSZS6Fr1JWuNt8/rilo3ZNdMI5++XEmysHMTDGjXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eDC/gqJlo1xbHvEQ+MN1JoW4G1Ck74X7NaBcptPG+2kyMQGq8fisUimXIXy8s7R/Czasswiqb0F25Wrb09X9QTKcIqrFIM0OnhRsBmWxpdb6WtZIuG1Lu8YukW2t1Fea2R2AeOets2eLTaLCOZJpX/2jAQtuzyrbTwCmy9zeMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKHbxJj3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKHbxJj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23187C116C6;
	Mon,  6 Apr 2026 01:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775440233;
	bh=BDtSZS6Fr1JWuNt8/rilo3ZNdMI5++XEmysHMTDGjXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cKHbxJj3+tuOtF+F29KO77bFAOhMd7UW4knnx0dNN9jezB/jcZimMJvMJ1hAAf58L
	 Ga7qna9iMOMGMF8q9RxfCXIDMeBmz1W9yc/tRCuDT2zd3CA4xejVmQfIWcK0xCJWPL
	 IT+haVGBHkgkXVyaoWnTGCDvEGWepKhF++u9SApNy+JuC1QcYwOXcpOvUrswJZUNUx
	 1Pm+ubLpGEI4T8I5djdpEHg1RE6I13MKA091sISlrz00ADOrhMEm4LOuFgG34Bu0xS
	 ycNvbajF52reKOr2IGsoPygKAgDkvA7Jfsytk/VjL9EXICalGvrHq0gvilXncFghW3
	 Yq6Er6HG+9TDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E113809A22;
	Mon,  6 Apr 2026 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] bpf: fix end-of-list detection in
 cgroup_storage_get_next_key()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177544021254.2520976.8277446547678258108.git-patchwork-notify@kernel.org>
Date: Mon, 06 Apr 2026 01:50:12 +0000
References: <20260403132951.43533-1-bestswngs@gmail.com>
In-Reply-To: <20260403132951.43533-1-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, roman.gushchin@linux.dev,
 bpf@vger.kernel.org, xmei5@asu.edu

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  3 Apr 2026 21:29:49 +0800 you wrote:
> list_next_entry() never returns NULL, so the NULL check in
> cgroup_storage_get_next_key() is dead code. When iterating past the last
> element, the function reads storage->key from a bogus pointer that aliases
> internal map fields and copies the result to userspace.
> 
> Patch 1 replaces the NULL check with list_entry_is_head() so the function
> correctly returns -ENOENT when there are no more entries.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: fix end-of-list detection in cgroup_storage_get_next_key()
    https://git.kernel.org/bpf/bpf-next/c/5828b9e5b272
  - [bpf,v2,2/2] selftests/bpf: add get_next_key boundary test for cgroup_storage
    https://git.kernel.org/bpf/bpf-next/c/262b857da6be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


