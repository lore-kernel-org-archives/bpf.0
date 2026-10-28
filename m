Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793160612;
	b=Dq0U5uuRdWqZcLRVOGrPUGJMdBbHjr7lMZK/5ny/5yang4F0EtlkvI2uVUiincBnHdiB
	 66OJE+QtASEtcoK64NsopWzzuZ+zO0qA94uBzXPALm3G5RN8MtQA/PHMJ29eVXTFlckEY
	 4tN0q88M35X24nGzLAyoOW3IlOT1SU00wQF/OJ6P8QE5+yyUvJCQoItyHRaZ8wAvAAhtB
	 CvqVnoSID1hRAVhWrKg/F0NrjUnKlex5ufW7SFwPRT0cmAcuNz/4FClzyPZWLM5Uqi1H2
	 FFAgh+N3qLrVz86+WbuJ0gGKHXFNnl5+LkM4EpuqeVc3xp7umvsh4dQEj41xHFUx/CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793160612;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QLaMyIUM8U6DmKbazC3gHZJkgBa6+MoBBOJXmXbsBYY=;
	b=QzgS6llD6cC6zxCkKoA968+mtEkIBYmoB9DrNdRP40E3rvv4G4Icbr0M4XjA+cy3IhiN
	 IFDBdHK71fGbl5EF4EYYO0G/OfWE0s9ziRfKKNcC7ei9kYyNEmUeX1ba3fUstvoNJ5Mjo
	 zJPDtSrQXNdC76sjakD434zpkrvyUggYkbtt8clkzCPEIPK53a9/f5IKSfFgpasajQNzx
	 WvKf7BYs2ICzLIyA0O4rXmQPaUcv6avfP5xUbRGsGWn+MTNEi3ZinY7KLsmqwWJu58sZT
	 Ig2GfZFzIsrIQH7ShXRmvb9Wudx/GJAUsOXDx0DE+cbE3J3zNTgr6GRjtvuaZmH3Jgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LK1ZOLnK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6749B606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 04:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LK1ZOLnK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104E21F01825;
	Wed, 28 Oct 2026 04:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793160612;
	bh=QLaMyIUM8U6DmKbazC3gHZJkgBa6+MoBBOJXmXbsBYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LK1ZOLnKUzmFdcTF66JlMrwYHxRgBrxjTtZFzE7yn3RTBnrzi64BLbG0B0W9LV4Cc
	 ahutgZNnmTHUt2do3xNJNsI+lU6P9itIg2uA8DGmyHn2C1+LyAC2Puik18uISZ8X7t
	 DyrQ3hnnFmGG0T0bgYnvaQeAHvfB5o33AdLOBn9TIvyGZ6p0ObsU0fMv4jIFZKDbFW
	 m/tehWgTmiNqvbxryBkd1VCNN6jBXbs3NufAkT8DJhlJo45pYNsY/dkBSALRju2TeH
	 Rr1XbCR2hu3AP+CmonxVIAgATQnifyRpARDDmr5n5xEDBg5cU+PhDEct2XDi7niOgg
	 AYR5FWn8SPwCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073A73AA9F68;
	Wed, 28 Oct 2026 04:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf 00/19] bpf: Remove BPF_F_ARENA_SCALAR,
 fix scalar evolution and scalar forks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179316061083.488951.15898671743709955177.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 04:10:10 +0000
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 27 Oct 2026 19:02:55 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> This series removes BPF_F_ARENA_SCALAR and fixes bugs in scalar evolution,
> in maybe_fork_scalars() and in the trampoline of may_goto. The groups of
> patches do not depend on each other.
> 
> v1 was Part 1 of "bpf: Stack in arena and a verifier that joins states"
> [1]. Parts 2 and 3 of that series are not here.
> 
> [...]

Here is the summary with links:
  - [v2,bpf,01/19] selftests/bpf: Remove tests for global data in arena
    https://git.kernel.org/bpf/bpf/c/3c13b2e5a40e
  - [v2,bpf,02/19] libbpf: Remove .arena.data
    https://git.kernel.org/bpf/bpf/c/5b0678b2f9b9
  - [v2,bpf,03/19] libbpf: Keep format strings of bpf_printk() in .rodata
    https://git.kernel.org/bpf/bpf/c/58cbd31c399b
  - [v2,bpf,04/19] selftests/bpf: Remove tests for arena access through numbers
    https://git.kernel.org/bpf/bpf/c/fe8e06aa0575
  - [v2,bpf,05/19] bpf: Remove BPF_F_ARENA_SCALAR
    https://git.kernel.org/bpf/bpf/c/b62dee3a8bb5
  - [v2,bpf,06/19] bpf, x86: Remove r0_on_stack from fetching atomics in arena
    https://git.kernel.org/bpf/bpf/c/701edc66772b
  - [v2,bpf,07/19] bpf: Clear delta of a register that scalar evolution widens
    https://git.kernel.org/bpf/bpf/c/3f9924747c44
  - [v2,bpf,08/19] selftests/bpf: Test that a widened register is not linked
    https://git.kernel.org/bpf/bpf/c/165115760433
  - [v2,bpf,09/19] selftests/bpf: Wait for the last maps of map_kptr to be freed
    https://git.kernel.org/bpf/bpf/c/2ad395a38471
  - [v2,bpf,10/19] selftests/bpf: Avoid a page fault in rcu_reentry while the handler is armed
    https://git.kernel.org/bpf/bpf/c/3c0ca9f9a98e
  - [v2,bpf,11/19] bpf: Don't widen a pointer to a buffer in scalar evolution
    https://git.kernel.org/bpf/bpf/c/41750e5d682a
  - [v2,bpf,12/19] selftests/bpf: Test a loop that moves a pointer to a buffer
    https://git.kernel.org/bpf/bpf/c/1b4ed112beb8
  - [v2,bpf,13/19] bpf: Don't clamp a register whose type changed in the loop
    https://git.kernel.org/bpf/bpf/c/1536e9b4375f
  - [v2,bpf,14/19] bpf: Reset the range of a packet pointer that scalar evolution clamps
    https://git.kernel.org/bpf/bpf/c/41b06cfd1cea
  - [v2,bpf,15/19] selftests/bpf: Test the clamp of pointers in scalar evolution
    https://git.kernel.org/bpf/bpf/c/ed5036531482
  - [v2,bpf,16/19] bpf: Finish the insn in the state that maybe_fork_scalars() splits off
    https://git.kernel.org/bpf/bpf/c/19caa38daf9d
  - [v2,bpf,17/19] selftests/bpf: Test maybe_fork_scalars() at the head of a counted loop
    https://git.kernel.org/bpf/bpf/c/df9e4a87a8d3
  - [v2,bpf,18/19] bpf: Keep stack arguments in arch_bpf_timed_may_goto()
    https://git.kernel.org/bpf/bpf/c/4d0f560f4926
  - [v2,bpf,19/19] selftests/bpf: Test stack arguments across may_goto
    https://git.kernel.org/bpf/bpf/c/b433cdb1cc4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


