Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3845038;
	Wed, 28 Jan 2026 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769630424; cv=none; b=NBzXZ7wwaOjRARJcfwhTWqjlk0snIIpJv7GigfOt/717lxfZGMB99WQ+3fVKjDgYuFU4ihI78uDORL/WsjTHawk40qy+o8BFvKnLUaN38fPXxo/4WKPF5/BCB766co4Wu6C20EUx2qhLjwoIKTV+a8yqg0VC53oBmGIHvxTzuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769630424; c=relaxed/simple;
	bh=AFqUHU1rA8CNlD68xMlcxHEwkgyEguVM4+WYNpslnL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c86b0l3A71SPwozvTHW9DZyIOvDfi3TOHI5HMprz+qxkkSFOd7bf42CLIAXjsspSnpsjZQAT1ejYKL6K0NP0MY1G9qYyMfDHmRixYPDYlsFHbqNofge+9+tw4DTLy8MPTknCpVoHUkWatSl3KMlMH14SqzDJ1giYo67a+euww8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLrJOdVK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLrJOdVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F4CC4CEF1;
	Wed, 28 Jan 2026 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769630424;
	bh=AFqUHU1rA8CNlD68xMlcxHEwkgyEguVM4+WYNpslnL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eLrJOdVKSNhQQAqknu9fmSA4t/SDXSgyskjpSQ1kgFsE466LlQcCnWqO6b+tM9ByL
	 jbzEr9x/wTQS4L5RTRcVlpURKY/Bu63yGyqvMBO03kYLK5h2gBb+VkdsaYeOa/5HSa
	 tKVHqK0n6M3ng59L+cla/LClZLSFaPlOWaqpbfXc3tETjwlWKh5UY5l0CYpn847816
	 m7V3W1px8rOS/EprUfFNDGkb3GB6iguv2y9ELNFm96lauF4QICcLUdxMlaYocL9O9T
	 5zN2znGEWNlTT4TbV7yeeml8SaOz2iN8/EbIgKV0weS96u5EXgbkagh17slo8IR5DT
	 3WXX7ZI/OnSQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BCB539EF96A;
	Wed, 28 Jan 2026 20:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv6 bpf-next 0/9] ftrace,bpf: Use single direct ops for bpf
 trampolines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176963041735.2209200.7611804745942755088.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 20:00:17 +0000
References: <20251230145010.103439-1-jolsa@kernel.org>
In-Reply-To: <20251230145010.103439-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: rostedt@kernel.org, revest@google.com, mark.rutland@arm.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 menglong8.dong@gmail.com, song@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 30 Dec 2025 15:50:01 +0100 you wrote:
> hi,
> while poking the multi-tracing interface I ended up with just one ftrace_ops
> object to attach all trampolines.
> 
> This change allows to use less direct API calls during the attachment changes
> in the future code, so in effect speeding up the attachment.
> 
> [...]

Here is the summary with links:
  - [PATCHv6,bpf-next,1/9] ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops flag
    https://git.kernel.org/bpf/bpf-next/c/4be42c922201
  - [PATCHv6,bpf-next,2/9] ftrace: Make alloc_and_copy_ftrace_hash direct friendly
    https://git.kernel.org/bpf/bpf-next/c/676bfeae7bd5
  - [PATCHv6,bpf-next,3/9] ftrace: Export some of hash related functions
    https://git.kernel.org/bpf/bpf-next/c/0e860d07c29d
  - [PATCHv6,bpf-next,4/9] ftrace: Add update_ftrace_direct_add function
    https://git.kernel.org/bpf/bpf-next/c/05dc5e9c1fe1
  - [PATCHv6,bpf-next,5/9] ftrace: Add update_ftrace_direct_del function
    https://git.kernel.org/bpf/bpf-next/c/8d2c1233f371
  - [PATCHv6,bpf-next,6/9] ftrace: Add update_ftrace_direct_mod function
    https://git.kernel.org/bpf/bpf-next/c/e93672f770d7
  - [PATCHv6,bpf-next,7/9] bpf: Add trampoline ip hash table
    https://git.kernel.org/bpf/bpf-next/c/7d0452497c29
  - [PATCHv6,bpf-next,8/9] ftrace: Factor ftrace_ops ops_func interface
    https://git.kernel.org/bpf/bpf-next/c/956747efd82a
  - [PATCHv6,bpf-next,9/9] bpf,x86: Use single ftrace_ops for direct calls
    https://git.kernel.org/bpf/bpf-next/c/424f6a361096

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


