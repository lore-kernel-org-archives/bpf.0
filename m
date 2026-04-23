Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699226738D
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957058; cv=none; b=bkgM9HPvwuFuinfMnwWd4onjN4HLidVEPSYe6IHvHONr0Pl7fS2ydMBmwNJX6/b2OdPMwFZvD0IzqsAGEVKEFX/pmmy9Az4tlvvDFg8NLtgI0JQX75OF/prjy7N4Nky1LzPK/BbhvOB+CW3ZYUZQMKzM7QirK0xxrSXOpvSVwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957058; c=relaxed/simple;
	bh=nFh/CuxpKCJgYokDKfETbLTEMK6ymR4AFqNSBPeYgvs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DceBTTJDGJ5dWaV/s4MbdSJWkR5V5Qub18ySicr8GW9q5wHOWH2ihLYed+wk/LfCNtFddih58LqV3zvBQxsBhmPCq8I3omTwqGec6OpQSJnrX0PA7aFz0hRaamy2R6afGBDm5GOdlSmGkof3JrRFH9Y0tiQjuwDMXwZzZKwcI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GENfYL59; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GENfYL59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809C7C2BCAF;
	Thu, 23 Apr 2026 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776957057;
	bh=nFh/CuxpKCJgYokDKfETbLTEMK6ymR4AFqNSBPeYgvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GENfYL59z4tQhzH6ThUo7d431jLA6UNTHfkiHsQlvl1d/UY+Ok6frx9bIE+GZoZA/
	 P9Q9LqNlx7PG5PAXvB7/NFjMFKu3kzGmqbQx6B8qXhv8Bd9HQFtyoC2NGqBEtzfy3V
	 s0PCyLBYoqRXT9DClGmdUdkfQfQ1JUwjgkOggI3mZHdMS8JwOVdTkrEunhihnu/kng
	 HYAI5UMrYtxNZ1l7LwzQmtsvFzXV66UTlZUwv396ZS/i6Tvmsm9fly74ykp2MJq1mM
	 F/Mt/I//yU/+KZYjIxTTpdG5v9YmRHR991kCi5WiRRwsy1BdBn68guHVCj3WUmGT76
	 j078ZVEbsg3ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF3A3810904;
	Thu, 23 Apr 2026 15:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/9] bpf: Prepare to support stack arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177695701880.627354.70386758654770405.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 15:10:18 +0000
References: <20260423033425.2536883-1-yonghong.song@linux.dev>
In-Reply-To: <20260423033425.2536883-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, jose.marchesi@oracle.com, kernel-team@fb.com,
 martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 22 Apr 2026 20:34:25 -0700 you wrote:
> The patch set prepares to support stack arguments for bpf functions
> and kfuncs. The major changes include:
>   - Avoid redundant calculation of bpf_reg_state. For stack
>     arguments, there exists no corresponding register number.
>   - Refactor check_kfunc_mem_size_reg() to have bpf_reg_state's
>     for both mem_reg and size_reg.
>   - Allow verifier logs to print stack arguments if there is no
>     corresponding register.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/9] bpf: Remove unused parameter from check_map_kptr_access()
    https://git.kernel.org/bpf/bpf-next/c/a7088176d829
  - [bpf-next,v3,2/9] bpf: Fix tail_call_reachable leak
    https://git.kernel.org/bpf/bpf-next/c/54c27ea6dadb
  - [bpf-next,v3,3/9] bpf: Remove WARN_ON_ONCE in check_kfunc_mem_size_reg()
    https://git.kernel.org/bpf/bpf-next/c/8a16c5b2b22f
  - [bpf-next,v3,4/9] bpf: Refactor to avoid redundant calculation of bpf_reg_state
    https://git.kernel.org/bpf/bpf-next/c/6a581b856c9e
  - [bpf-next,v3,5/9] bpf: Refactor to handle memory and size together
    https://git.kernel.org/bpf/bpf-next/c/024c0ab5db94
  - [bpf-next,v3,6/9] bpf: Rename existing argno to arg
    https://git.kernel.org/bpf/bpf-next/c/053a48cb2a54
  - [bpf-next,v3,7/9] bpf: Prepare verifier logs for upcoming kfunc stack arguments
    https://git.kernel.org/bpf/bpf-next/c/9b9f0b42703c
  - [bpf-next,v3,8/9] bpf: Introduce bpf register BPF_REG_PARAMS
    https://git.kernel.org/bpf/bpf-next/c/246ad6e5ee25
  - [bpf-next,v3,9/9] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
    https://git.kernel.org/bpf/bpf-next/c/4439328d3878

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


