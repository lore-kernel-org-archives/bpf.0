Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0F3C8C71
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786183871; cv=none; b=DATSBU69JcBcAatMwf3xNnBszlYF6DMtdkh9EOVaQgi6EsRVJYMbI8V/VK59m2dC49D2XPRdaESH2ar8yLRtjSqnH56KdSr+hZITHju9gnVeAsEL/PIe+N8dw5pwu/8bhtGsyyarTkO1bjl3l/0P/CzoJ4fUIX0boxXY2CSiMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786183871; c=relaxed/simple;
	bh=rSJIEJZUp/7qlI55LRmVKmRDaOnh6BNYpCkUQ2O6T+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZHpQhO0K1C+/sA9/0ZrAeWDZwX909VrsUdLIqqRfEDKDDfFZ8ZgMaugLtoBzuzQ69R+6dIdcGP7mmjoFf86QRKxSJw0JIGwN/0oye+lUGGn2vzRZdi1IYJbOMDGY2gQnpGn5NGRBCkQJnJ4Uq2RW1Nag0lx4AJJWEt2/4l44JGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beZXXWsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beZXXWsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1041F000E9;
	Sat,  8 Aug 2026 10:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786183867;
	bh=Q3Zz3kkosCTOT8meqs9eWyiuXvHtifThxAUmRI92wEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=beZXXWsy5Ip3vhwwmWr+jyrwHtV+RfCk3EKuKL3rsEliT9d3C5x1aYCSqglfN02aJ
	 EnKvsTOiPQ2O3g94FFFrwceHRX5A222XRi7qQYAlOR/c9U74DJ41yqZqovNBlf1Mc9
	 XiQ3QgAY5reA3K71g4LQE5d4nXLCR7X1SYXM8fAQBm6HhAfg8ydAlwRw+pKSDx0NGm
	 XxS1VnO2vmvNJlOwr0KZe8hNXAYfPaxmBx74J5gsOZcRwjSaWL6m/uu4mK6jWwDg+9
	 XEoR+6TAce90VgxYI05yesGSlNgxkuG2fH4kc1VkTd5vD+8YvJu5RkEQn7yciasgtv
	 ZbQhAOLRnLEMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198CF380CFDB;
	Sat,  8 Aug 2026 10:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 00/14] Add arena argument support to kfuncs
 and
 struct_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178618382564.2611241.3179867674703496337.git-patchwork-notify@kernel.org>
Date: Sat, 08 Aug 2026 10:10:25 +0000
References: <20260808003938.3486067-1-memxor@gmail.com>
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, tj@kernel.org,
 kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Sat,  8 Aug 2026 02:39:20 +0200 you wrote:
> This is a continuation of patches in [0], with mostly minor changes and
> reordering. The motivation is covered in that link. A major change is
> moving to two tags (__arena and __arena__nullable) and moving the changes
> to JIT to emit more optimized sequences.
> 
> Please see commit logs for details.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,01/14] bpf: Rename 'early' BTF checking as a preparation phase
    https://git.kernel.org/bpf/bpf-next/c/04962afb3cd6
  - [bpf-next,v5,02/14] bpf: Split subprogram and kfunc collection
    https://git.kernel.org/bpf/bpf-next/c/41f36ffa3a87
  - [bpf-next,v5,03/14] bpf: Collect kfuncs after resolving program resources
    https://git.kernel.org/bpf/bpf-next/c/d98b2d445fc5
  - [bpf-next,v5,04/14] bpf: Support __arena and __arena__nullable kfunc argument suffixes
    https://git.kernel.org/bpf/bpf-next/c/252d36716326
  - [bpf-next,v5,05/14] bpf: Support __arena and __arena__nullable on struct_ops arguments
    https://git.kernel.org/bpf/bpf-next/c/f6c33c4479a7
  - [bpf-next,v5,06/14] bpf, x86: JIT __arena kfunc argument rebasing
    https://git.kernel.org/bpf/bpf-next/c/41b75522304c
  - [bpf-next,v5,07/14] bpf, x86: Convert struct_ops arena arguments in the trampoline
    https://git.kernel.org/bpf/bpf-next/c/5129e9be2111
  - [bpf-next,v5,08/14] selftests/bpf: Add kfunc __arena and __arena__nullable argument tests
    https://git.kernel.org/bpf/bpf-next/c/0996e93691f1
  - [bpf-next,v5,09/14] selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments
    https://git.kernel.org/bpf/bpf-next/c/25818556edcf
  - [bpf-next,v5,10/14] selftests/bpf: Add struct_ops __arena and __arena__nullable argument tests
    https://git.kernel.org/bpf/bpf-next/c/ba0484197163
  - [bpf-next,v5,11/14] bpf, x86: Fix stack-passed arguments for indirect trampolines
    https://git.kernel.org/bpf/bpf-next/c/596824de8c10
  - [bpf-next,v5,12/14] selftests/bpf: Test stack-passed struct_ops arena arguments
    https://git.kernel.org/bpf/bpf-next/c/2d4de9a493a0
  - [bpf-next,v5,13/14] bpf: Reject tracing/freplace progs for struct_ops with arena args
    https://git.kernel.org/bpf/bpf-next/c/fd6094ac877c
  - [bpf-next,v5,14/14] selftests/bpf: Test attach rejection for struct_ops arena programs
    https://git.kernel.org/bpf/bpf-next/c/4976cce08baa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


