Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EAA47F2EE
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591811; cv=none; b=rt/G1FYRWFCyGfO38CV3VOxjOe1F3984EGVW5WtXco0SchlBrY1s+Rd+y9/CU/3wNSy+eXPXXaEl5vYxMXl8nSCgxn8HXZCaGuRVoIK+bA6sWzRrpHNgP3xXEhkXwLO3r1WYqH8NOlhMxiVABX56d8NoHkHRjCOOFO/a4vcHUws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591811; c=relaxed/simple;
	bh=8nfhJTY4uU1NcSgX+E21+nmtl36TKcw1FUY8LDlfOQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EIIEAJqn//Bh4tvyi8YyhLlbzJtq7Igo6tOVQ0kmAZxskhASmnWY4t6OMkz0IwgtO/LTmahcHpxSg4LjwOy2hiaT/TVpiCLN0NvVxgft4bgOKs9668mbjLQvZ3pDdGnq4mv2j5xi6VdZNQUs8ZovU4igrJYqWeJmF2uNEHwC4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipw7fexx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipw7fexx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2151F00893;
	Thu,  4 Jun 2026 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780591810;
	bh=wrwD8HQ7FggmrKBY9aVGcyIDD847Q/W7tScKISuX8SQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ipw7fexx4PKQefjqAuqMzv7U05uH0ajuww++OpVQ8UUj0Exg7h2Jeqqe7vvvQ5OCP
	 naQbZ6c+wu9K9Z+yVNyyvOWdG/fo7htzlTt7b91YmUQoJVfO8t4TKHeFf2oNQCu0xg
	 uvZTips/2LAvc166RFxAjEEpXA3rQBpRKqnrTqdqcjBqP7XGDzsNCq4HPCIjuX56gi
	 fPxzEvhIXlek4sglqDRpqEV6z5ijLRHrnazSRugNM0XNY1Lo7oeMs80HQfCWEtvJ7Z
	 Jul1bVfM6nXt7uMA0URjenLCVARFtifQRMB+VYXn/P5Wrz4GnEmTU6b9kONYK5ceAC
	 l4n+rsLPRK3rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568A43930A0F;
	Thu,  4 Jun 2026 16:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Cover exclusive map
 create-time validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178059181090.2942053.6498513168329398956.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:50:10 +0000
References: <20260603211658.471212-1-daniel@iogearbox.net>
In-Reply-To: <20260603211658.471212-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, ast@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  3 Jun 2026 23:16:57 +0200 you wrote:
> map_excl exercises exclusive-map binding (allowed/denied), map-in-map
> and map iterator rejection. It does not cover the create-time validation
> of excl_prog_hash: the kernel only accepts a SHA-256-sized hash and
> requires the pointer and size to be consistent.
> 
> Add map_excl_create_validation to check the rejected combinations:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: Cover exclusive map create-time validation
    https://git.kernel.org/bpf/bpf-next/c/e87d898bc766
  - [bpf-next,v2,2/2] selftests/bpf: Test signed loader error paths
    https://git.kernel.org/bpf/bpf-next/c/5b88319e4775

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


