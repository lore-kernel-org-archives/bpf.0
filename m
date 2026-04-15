Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D73383C7D
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280851; cv=none; b=ddgTwXbXGtX7EgOk9aXEAONIQBitPCkzMc2ZVw4hPYVCqrF78xkUElk9xuiZqOxcxBSL+HbufMiuvjf49/NTjJoFh/v3y91m+eJ70Mefni2ftZI3qmrtaEYlcM3GojgHcllpd62owJ9jVCf1dP22kB8rhz6EsPujI4Ntij34ESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280851; c=relaxed/simple;
	bh=WJwYv8ZXavBiad+FeuB9SqouuaS+NYpA+z2TJttyYaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E3NcrzqI4amX6+UOdoWenL8hAd88urZQuAuXozB2rHvQArkh9D9+XFAjdZPv6yhjXnYWmW0RQwUVU3VWh6OCDg2/orDb0eypFHNt0nCPnWjZCQyyzqoEYYECbys9NBnXk+pG5XzzH9KgMXjKFgfP6qGueIbASza8Ubl5fhni2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um7heL1I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um7heL1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AC5C19424;
	Wed, 15 Apr 2026 19:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776280850;
	bh=WJwYv8ZXavBiad+FeuB9SqouuaS+NYpA+z2TJttyYaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=um7heL1IBzyEM6GipzgUfk2P/3Fo058fJwHONqnNmJpOqDPbUlPbgY6EZnDrA6AeW
	 dLHvyzDG934kgdJCewuUF9nl0VJt5BFminGfotmex7Y0r5cI4WZGHIngGovGtOXI8R
	 Uy2yuQC9gRJ+1zJFlI1a3i3jyK/t0IyuCzc+c+PTks/dUsZSbRAnPWNDnBiwTFIS1p
	 tCQ0KHqZedhSH8IzAohljAUyCy9vZLkKUr4KTS/0DSC8G4kcQTnGw0X1wYj2lkCwNY
	 K3KUvSZXXKqv00/oeXpHUMdiTqIfsdsEtbXfTbvrz833uJ8sFLI46r4GRQ6gGPxHCA
	 dCFFJYHYn5xyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD83380A963;
	Wed, 15 Apr 2026 19:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/3] Fix garbage data in task local data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177628082028.2402333.10439843576441587011.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 19:20:20 +0000
References: <20260413190259.358442-1-ameryhung@gmail.com>
In-Reply-To: <20260413190259.358442-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 13 Apr 2026 12:02:56 -0700 you wrote:
> Hi,
> 
> The patchset fixes two scenarios where BPF side task local data API may
> see garbage data and adds corresponding selftests.
> 
> 
> Amery Hung (3):
>   selftests/bpf: Prevent allocating data larger than a page
>   selftests/bpf: Fix tld_get_data() returning garbage data
>   selftests/bpf: Test small task local data allocation
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/3] selftests/bpf: Prevent allocating data larger than a page
    https://git.kernel.org/bpf/bpf/c/36bf7beb9d23
  - [bpf-next,v1,2/3] selftests/bpf: Fix tld_get_data() returning garbage data
    https://git.kernel.org/bpf/bpf/c/615e55a24184
  - [bpf-next,v1,3/3] selftests/bpf: Test small task local data allocation
    https://git.kernel.org/bpf/bpf/c/b4b0233730d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


