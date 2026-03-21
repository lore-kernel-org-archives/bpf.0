Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91D21CC71
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774125017; cv=none; b=fpIiR83Lb6yIn1CjztAr64Ivnsm41512ciDkTay7/Zr0KKpBYnuSNmN1EY2kWvovQG2HO5GLxj/4VzlUeaOvxu0BtJA5t+CoTBHotmHg5XYf4AArkLfOPVbJNGwo4oBnVFQY/rwdRPZr0ZNHauYV0ZAtX7GIBH8z12H+ClcwgfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774125017; c=relaxed/simple;
	bh=VIbfkwFhzHbLLRW0s1BjsHqa5L2DqU7uBm9HsPOeTso=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XnuweE2LBtJPpudCbgnFTB3ATZSRmP75CuiI2yiGn34/dq3NPGk3u/dXuHu+TuRtwDAo9HODb+mjk80RhbObuYkuHit2KozyQ5/6Ny6JKDJGpHad+fA2HzSw38+egNBteE9+sGMrxGySqZzHTkVK5eUZtAHWAd4G6AQJ2Sz6ZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ3Q1F0C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ3Q1F0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4015C19421;
	Sat, 21 Mar 2026 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774125016;
	bh=VIbfkwFhzHbLLRW0s1BjsHqa5L2DqU7uBm9HsPOeTso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AJ3Q1F0CopfkiUjbBksSjqzosMmyBD5RIFzJ8xyVAxA2wotmGyW2PWfGn2e6kdWAz
	 C9cOv5Euc8rGivgVvCWWt6bOd7/I/t3MyJQet189nF2RxymGUITY6Rdc5AWwG0ya/D
	 VPgpZvmDGlnoWPcPagA3KzHpg9/PAIbh3d6uSmYq6vT+PniLkvxRWJWQEKZfWp4irn
	 6qWKV+OdO4mWEzTiLuEgM1wlII+GuHsoSAsvjPw99wKYPSTedoimkqZy4hnM/rEM1u
	 N05cAyu5MHPwJmS0WrEscokO60f7yvHQZDS8lzsrSdEAAGpsqQXQiZLCRlFZQULunq
	 BVQmbkUyUPpDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDE13808200;
	Sat, 21 Mar 2026 20:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Fix sync_linked_regs regarding
 BPF_ADD_CONST32
 zext propagation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177412500633.2953281.12899889635561854649.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 20:30:06 +0000
References: <20260319211507.213816-1-daniel@iogearbox.net>
In-Reply-To: <20260319211507.213816-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, puranjay12@gmail.com,
 qguanni@gmail.com, ast@kernel.org, puranjay@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 19 Mar 2026 22:15:06 +0100 you wrote:
> Jenny reported that in sync_linked_regs() the BPF_ADD_CONST32 flag is
> checked on known_reg (the register narrowed by a conditional branch)
> instead of reg (the linked target register created by an alu32 operation).
> 
> Example case with reg:
> 
>   1. r6 = bpf_get_prandom_u32()
>   2. r7 = r6 (linked, same id)
>   3. w7 += 5 (alu32 -- r7 gets BPF_ADD_CONST32, zero-extended by CPU)
>   4. if w6 < 0xFFFFFFFC goto safe (narrows r6 to [0xFFFFFFFC, 0xFFFFFFFF])
>   5. sync_linked_regs() propagates to r7 but does NOT call zext_32_to_64()
>   6. Verifier thinks r7 is [0x100000001, 0x100000004] instead of [1, 4]
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Fix sync_linked_regs regarding BPF_ADD_CONST32 zext propagation
    https://git.kernel.org/bpf/bpf/c/bc308be380c1
  - [bpf,2/2] selftests/bpf: Add a test cases for sync_linked_regs regarding zext propagation
    https://git.kernel.org/bpf/bpf/c/4a04d13576fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


