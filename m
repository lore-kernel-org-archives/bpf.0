Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795235422;
	b=wn6mKQdUhfIP3pVzD1jDcXfXAxH/RTx/HqJOxwbXBnYJkq4HsRzod0QUljUVbkT9Jr9n
	 6cFhW53j5dkI7GhehFhGNYSSxcIOWIC6Ufvsf8KsoyOKNeQrus/SabMF9hyKWpZE89aCv
	 coRxKX22kaxE1/qakLLpgZ2vIhcGbN3jeZ/0cW+FMrivPbpsb4kVVQSUQZRL+vBbph7GC
	 IwRUuCfQ0rp4T0DGnm1a0kBUJZ4mf7c3mDdIcBNNRSuCvBaCzu88R9tA+UB97NTMfly3U
	 agt/4n7P9JbT9Mas5pTrrWQ3jYLXHdNAVEbuDjf2yO1DMFWRAKUbGKbf9v/sohKAUpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795235422;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=eQUX0DiLS10KC1nae2FQeWET+jEEX1GKneklHJ6xh64=;
	b=SFAfYj1h+8XkoGeT/rjSWdM6uXkjnU264WiFkR2Hww18XScC+cOCE1jxQi1K4xQb65Cs
	 i2Jp06/33zF6WiL5ohaNr2NehiXf/rbQMZ1R7T70dOKRAXJKopwBIvTOSuSDkq3/Lhjmz
	 MeGMFEWK5Yo3q014kYVcTvZZjf4yJR3hzZxR3NrDcd4eMlnSk7mQCI2orsCPOwyvoUk2t
	 umZvCiTf4cIMnxl3sBm1lRCFZSLWPfgABmhGKM4ROGOaX2MS50JnI4PG2qp3jlPUbfZWG
	 624kndxxwS60+IB+qy4y5N+6r7RpopekzlVWXXw+ft5qG528/rUujzSctj3Mj9//AaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2u1aOeB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268FA606A68D
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2u1aOeB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF75A1F000C4;
	Sat, 21 Nov 2026 04:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795235421;
	bh=eQUX0DiLS10KC1nae2FQeWET+jEEX1GKneklHJ6xh64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X2u1aOeB55mfT3SS5D/QrCm0QbUAfGIfQBhTrYoqw9kJOy6jAOW5zD3kNihipW1FN
	 dYqZA/Ihx5VdazKrUw25BCTPzq1OvU+9mhx9ya0yhMjXxOaOdZuP3wU8CNoDpdUgr+
	 49cAQKO2mqp0tEMSkXtMPfxV/7OOlk2eSRx0ADP5OtR12dujhHBgK5mBOmNFXn3lYP
	 z+3Op4mvSmbqRvTHaJjyDxwdOYjuo54c9BE9BpzvJApeufKcc/LRvr02CJsznwzuYJ
	 FFLxxm4Rmi4E5BRQMeRrrzgmCeDqdJGM8BVQnlNM524ngGm988SsXYBxwrDxA58Nq4
	 MnvsM599+bo/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4597380AAFE;
	Sat, 21 Nov 2026 04:30:21 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2 00/49] bpf: Verify in passes,
 with equations in the state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179523542054.926945.7837755051168951494.git-patchwork-notify@kernel.org>
Date: Sat, 21 Nov 2026 04:30:20 +0000
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Nov 2026 20:49:08 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> This series replaces the main analysis of the verifier and scev.c. Against
> bpf-next, the base of the series:
> 
>   - More valid programs load. The verdict depends less on the code pattern.
>   - Numbers keep states apart only if an error, or a bound that the program
>     requires, depends on them.
>   - The work does not grow with the number of iterations of a loop, unless an
>     error needs them one by one.
>   - The log shows a path to the bug, if the verifier finds one.
>   - The proof is separate from the guesses. There is less code.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/49] bpf: Look for bpf_clone_redirect() once in check_recursion()
    https://git.kernel.org/bpf/bpf-next/c/9c8f16ab14d7
  - [bpf-next,v2,02/49] bpf: Make stack liveness faster
    https://git.kernel.org/bpf/bpf-next/c/5aea6a7c1825
  - [bpf-next,v2,03/49] bpf: Delete the old main pass of the verifier
    https://git.kernel.org/bpf/bpf-next/c/867a4a899694
  - [bpf-next,v2,04/49] bpf: Delete scalar evolution
    https://git.kernel.org/bpf/bpf-next/c/0b1c6041e9f1
  - [bpf-next,v2,05/49] bpf: Limit the cost and the memory of a load
    https://git.kernel.org/bpf/bpf-next/c/3c41899af5d0
  - [bpf-next,v2,06/49] bpf: Record what each insn reads and writes
    https://git.kernel.org/bpf/bpf-next/c/37b844f5bc6f
  - [bpf-next,v2,07/49] bpf: Name an id after the xreg that has it
    https://git.kernel.org/bpf/bpf-next/c/cb137b692503
  - [bpf-next,v2,08/49] bpf: Do not fail a check because a state has fewer values
    https://git.kernel.org/bpf/bpf-next/c/d1252e1e9c46
  - [bpf-next,v2,09/49] bpf: Check fixups in the main pass and keep a snapshot of them
    https://git.kernel.org/bpf/bpf-next/c/9f9fc3dc30b2
  - [bpf-next,v2,10/49] bpf: Reject a program with a call that needs two rewrites
    https://git.kernel.org/bpf/bpf-next/c/fa83ca87f431
  - [bpf-next,v2,11/49] bpf: Put a barrier where no mask fits
    https://git.kernel.org/bpf/bpf-next/c/d83c595d9480
  - [bpf-next,v2,12/49] bpf: Keep more of what is known about a number
    https://git.kernel.org/bpf/bpf-next/c/8f58839c9ebb
  - [bpf-next,v2,13/49] bpf: Remember how many bytes of a packet are checked
    https://git.kernel.org/bpf/bpf-next/c/12766488e77a
  - [bpf-next,v2,14/49] bpf: Mark a state that no run of the program has
    https://git.kernel.org/bpf/bpf-next/c/ebb272e84ec8
  - [bpf-next,v2,15/49] bpf: Peel the first trips of a loop and join the other trips
    https://git.kernel.org/bpf/bpf-next/c/623109e0f931
  - [bpf-next,v2,16/49] bpf: Add equations and their arithmetic
    https://git.kernel.org/bpf/bpf-next/c/e9b3a99d48bc
  - [bpf-next,v2,17/49] bpf: Keep a table of equations in each state
    https://git.kernel.org/bpf/bpf-next/c/ab04a7655be5
  - [bpf-next,v2,18/49] bpf: Refine all related numbers after a jump
    https://git.kernel.org/bpf/bpf-next/c/340bb75c4a56
  - [bpf-next,v2,19/49] bpf: Make equations from ALU, spill, fill and call insns
    https://git.kernel.org/bpf/bpf-next/c/92907a9af652
  - [bpf-next,v2,20/49] bpf: Delete the equations that say nothing
    https://git.kernel.org/bpf/bpf-next/c/ecfcecce56ba
  - [bpf-next,v2,21/49] bpf: Compare states by join_key, then by value
    https://git.kernel.org/bpf/bpf-next/c/a03670bf0cf3
  - [bpf-next,v2,22/49] bpf: Continue a pass after an unproven insn
    https://git.kernel.org/bpf/bpf-next/c/0e549bbe75ab
  - [bpf-next,v2,23/49] bpf: Find the xregs that an unproven insn depends on
    https://git.kernel.org/bpf/bpf-next/c/37e13b091537
  - [bpf-next,v2,24/49] bpf: Keep two states apart if data and control deps differ
    https://git.kernel.org/bpf/bpf-next/c/6de365ae6608
  - [bpf-next,v2,25/49] bpf: Join any two states that have the same join_key
    https://git.kernel.org/bpf/bpf-next/c/627ce07df2d9
  - [bpf-next,v2,26/49] bpf: Check the equations when a state is pruned or joined
    https://git.kernel.org/bpf/bpf-next/c/de3bb1ef2ce5
  - [bpf-next,v2,27/49] bpf: Guess the equations of a join
    https://git.kernel.org/bpf/bpf-next/c/473d366fc137
  - [bpf-next,v2,28/49] bpf: Prune or join each state that arrives
    https://git.kernel.org/bpf/bpf-next/c/0e5e78acdf2a
  - [bpf-next,v2,29/49] bpf: Order the pending states and free the states that are done
    https://git.kernel.org/bpf/bpf-next/c/4148dd9a7f45
  - [bpf-next,v2,30/49] bpf: Get the trip count from the trip index
    https://git.kernel.org/bpf/bpf-next/c/b00adefb7a65
  - [bpf-next,v2,31/49] bpf: Give a loop a checked trip count or may_goto
    https://git.kernel.org/bpf/bpf-next/c/2da4d8226c27
  - [bpf-next,v2,32/49] bpf: Use the equations in the join rule
    https://git.kernel.org/bpf/bpf-next/c/fb08fa4a46cd
  - [bpf-next,v2,33/49] bpf: Verify a static function once for each instance
    https://git.kernel.org/bpf/bpf-next/c/762e1478d7c5
  - [bpf-next,v2,34/49] bpf: Partition the states after an error
    https://git.kernel.org/bpf/bpf-next/c/ecb43124db39
  - [bpf-next,v2,35/49] bpf: Reproduce an error on one path, with no joins
    https://git.kernel.org/bpf/bpf-next/c/a46de5d64e18
  - [bpf-next,v2,36/49] bpf: Do not let a join raise what a program requires
    https://git.kernel.org/bpf/bpf-next/c/cd97aa1387d9
  - [bpf-next,v2,37/49] bpf: Verify in passes
    https://git.kernel.org/bpf/bpf-next/c/09c84023b0b4
  - [bpf-next,v2,38/49] bpf: Make a returned pointer to the stack unreadable
    https://git.kernel.org/bpf/bpf-next/c/da543d022de6
  - [bpf-next,v2,39/49] bpf: Keep two states apart if a live xreg has two types
    https://git.kernel.org/bpf/bpf-next/c/afafa4255b17
  - [bpf-next,v2,40/49] bpf: Check the body of a counted loop once
    https://git.kernel.org/bpf/bpf-next/c/97f92b0c1df6
  - [bpf-next,v2,41/49] bpf: Refine the copies of a number that AND or OR splits
    https://git.kernel.org/bpf/bpf-next/c/a2aee95cc318
  - [bpf-next,v2,42/49] bpf: Allow a range of offsets for a constant string
    https://git.kernel.org/bpf/bpf-next/c/5124dee218b2
  - [bpf-next,v2,43/49] bpf: Keep spilled pointers at a range of stack offsets
    https://git.kernel.org/bpf/bpf-next/c/de2cf44a0a34
  - [bpf-next,v2,44/49] selftests/bpf: Adjust tests to the new log text
    https://git.kernel.org/bpf/bpf-next/c/5ecc636cbed7
  - [bpf-next,v2,45/49] selftests/bpf: Adjust tests that get another verdict or may_goto
    https://git.kernel.org/bpf/bpf-next/c/298ff459cc89
  - [bpf-next,v2,46/49] selftests/bpf: Test barriers and far pointers
    https://git.kernel.org/bpf/bpf-next/c/7cdea9de4a69
  - [bpf-next,v2,47/49] selftests/bpf: Test passes, instances, precision and the failing path
    https://git.kernel.org/bpf/bpf-next/c/81c7c630a9a8
  - [bpf-next,v2,48/49] selftests/bpf: Test equations
    https://git.kernel.org/bpf/bpf-next/c/78884791786a
  - [bpf-next,v2,49/49] bpf, docs: Rewrite verifier.rst
    https://git.kernel.org/bpf/bpf-next/c/a45635128d1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


