Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B132ED58
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179832; cv=none; b=hQ2H9bxgzXx5mqxqZrNAHeFReEeddDHBGM+ZOxXxoTyahkkFU0YCwPcMr98rKBVzdaht+rO7T2fdUxes3u+kv9xRobuhDhdj+iaV/K9cLZdB1kvEclVqPkaOHOTi8MxYbGwxLz9i4C99gm1KqV7Y3sJGmV6aObjPg/ns5FiOYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179832; c=relaxed/simple;
	bh=NmDlwWySZFLr0Z8tkCxxI4GpcKyk0ru5CasO8kj93FY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NcjlFBOfK6mg34Ygh5o7tiikraYH0CnZSFOqfpIfIttkUaPK5fEDXxx4hgDoCeonQP2ZRVPV9UH0Td3HJfjBx47c1s1AOL4PeUffCLQi2Fzz/txfrL1RU/bv37iiryUV95+dtE+R+gMQpWE/YRx1kSLePfU1VrC//RsNKOuMQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFQmG8Nj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFQmG8Nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2D5C116C6;
	Fri,  3 Apr 2026 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179831;
	bh=NmDlwWySZFLr0Z8tkCxxI4GpcKyk0ru5CasO8kj93FY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bFQmG8NjLM+/IcWf9q0nNCXktRmURaQfxb7LzoHNseW6poKwadDwDLhxVm3Ll7mCf
	 Un97XT+WlfCsVMUUJsn3TtIjIUubSE/Uy9Js6VYhNuvBxw0mMMrHw2yjyHKXl4bOGF
	 yCTQriIhLsmiJzerTQEvGA62nIF0K5FJ8YvK6S+yq8w003VXoMqMoLb+4ens0Z9wG6
	 2IPUd3kAI0RpaH+2vTtlMBly8wMZubV8flF0C91E5QXsEdTq+ge0bVSHFxYIsabZUr
	 RDSKQdkfQhGF6RpzdPYMlrNoX1E3pqWa1B66/G/Sv7TJ/J9nZ0rajBLQKqaOCFVf/N
	 hyKCqg4niNIUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030063809A09;
	Fri,  3 Apr 2026 01:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/6] Fix invariant violations and improve
 branch
 detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177517981379.692254.1576029739396503335.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 01:30:13 +0000
References: <cover.1775142354.git.paul.chaignon@gmail.com>
In-Reply-To: <cover.1775142354.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, harishankar.vishwanathan@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 shung-hsi.yu@suse.com, srinivas.narayana@rutgers.edu,
 santosh.nagarakatte@rutgers.edu

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 2 Apr 2026 17:07:25 +0200 you wrote:
> This patchset fixes invariant violations on register bounds. These
> invariant violations cause a warning and happen when reg_bounds_sync is
> trying to refine register bounds while walking an impossible branch.
> 
> This patchset takes this situation as an opportunity to improve
> verification performance. That is, the verifier will use the invariant
> violations as a signal that a branch cannot be taken and process it as
> dead code.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/6] bpf: Refactor reg_bounds_sanity_check
    https://git.kernel.org/bpf/bpf-next/c/a1311b94ef85
  - [bpf-next,v3,2/6] bpf: Use bpf_verifier_env buffers for reg_set_min_max
    https://git.kernel.org/bpf/bpf-next/c/ec1d77cb0ee9
  - [bpf-next,v3,3/6] bpf: Exit early if reg_bounds_sync gets invalid inputs
    https://git.kernel.org/bpf/bpf-next/c/a2a14e874b4e
  - [bpf-next,v3,4/6] bpf: Simulate branches to prune based on range violations
    https://git.kernel.org/bpf/bpf-next/c/b254c6d816e5
  - [bpf-next,v3,5/6] selftests/bpf: Cover invariant violation case from syzbot
    https://git.kernel.org/bpf/bpf-next/c/2ba199067b89
  - [bpf-next,v3,6/6] selftests/bpf: Remove invariant violation flags
    https://git.kernel.org/bpf/bpf-next/c/7cbded6ed98f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


