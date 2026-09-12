Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F332FA30
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789234271; cv=none; b=uEiuIUr+4WS+qzgWGkxb0eTnF3o4Osv/5Y5jFZ2ZNwHhAjeDHCA3a44xDxY8Au6ZQbf9ULXQav/8X5zxEPZrobAOP2B06D3/Hj4zC1/pg+YKBNcOiMvUdRRPcrp70u7F3mrH6DKtE0MdiH8C3iQXoM8b4pYd/CSfsh8mbuyOG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789234271; c=relaxed/simple;
	bh=qNopehDErpRXue36saoJIguVwDL2e6J9uWelcpF+UZk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g6uwZvRbG4wUZinUGB13dmSV1Re+YZA/1zwGCzROxOg2jaISjezjGd4HeXtXJo9COYMn9frRPPUFDYTIEoE5CMcPvRYUuSo78dXC1WpiSmWzKq8yF2VNS9zWqZoWSg//aQyUUYKjHCzhjkvKX9G8iFzPO+gKQgub1eXfzeC/pdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFYZ22Il; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFYZ22Il"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966141F000FF;
	Sat, 12 Sep 2026 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789234268;
	bh=3vB6dDIeTTtq9otgnsWDlEHhTXN9tbCQ9sNQyAk7sXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BFYZ22Il0aYYb5K4cIafFTQKE0trPaj7njaOEHTFdGXG1qMUzWagbMp4qBT/Z3WyV
	 +hcBlZygxni8NFJIqUenJRzCHnQbrnV9hyXwal0DsFFKG3ibZQDkEP22gSYHAFtATP
	 VUidqNchM0nZAhEUOHVBRwES5DRTK3+lWTTiKmzKAEZR/w03jSKX0ASj/G4+gRI+3j
	 Z0dzj5KjHOMXL0s4dp4WTWAEm22Xzx/aQFPJIVhhi6V9mPFHAK8YLiJo9luX3ccUor
	 CPxnVeInBND+5NIYxH98+SW8ShHag2GYLj6IYBk2lVCVrIDv0xV6ldG/9gnPm4AV26
	 3nwJYv7TNt+kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19921380820D;
	Sat, 12 Sep 2026 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Allow terminal gotox instructions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178923420462.3572002.9914127561260623507.git-patchwork-notify@kernel.org>
Date: Sat, 12 Sep 2026 17:30:04 +0000
References: <20260902171414.96165-1-sidchintamaneni@gmail.com>
In-Reply-To: <20260902171414.96165-1-sidchintamaneni@gmail.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, a.s.protopopov@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, puranjay@kernel.org, rlmenge@gmail.com,
 hargar@linux.microsoft.com, apais@microsoft.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  2 Sep 2026 17:14:13 +0000 you wrote:
> check_subprogs() treats gotox as a direct jump and validates its reserved
> zero offset. When gotox is the final instruction, this produces a
> synthetic successor one instruction past the end of the subprogram and
> rejects an otherwise valid program.
> 
> Skip direct-offset validation for gotox and accept it as a
> non-fallthrough terminal instruction. Its actual targets remain validated
> from the instruction-array jump table during CFG construction.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Allow terminal gotox instructions
    https://git.kernel.org/bpf/bpf/c/0d7823cd4cda
  - [bpf-next,v4,2/2] selftests/bpf: Test terminal gotox instructions
    https://git.kernel.org/bpf/bpf/c/ac781acaef49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


