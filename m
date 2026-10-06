Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633E49EC43
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304819; cv=none; b=pUO1DcWjDy6wheNBxbMptsYgu1pCPOd9AHYV7mQCBNcJL05yGv74+Fom094zI1j5b1vXq9v1lPYaVi69a85D9oI/+PLhL7RlaxJutxcr3+w5R2J1Kmw8SYwO6ksHMPEB1JydxVb1qtXoPjuMWIZcVO91mZtS3b0ai5VYFaOwojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304819; c=relaxed/simple;
	bh=x5zbI32P9Vx68EdMlyyIwNjzukpTzCRAmbOU70px68E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cs7YUyNQBj2JM5m+SHVcZrvut+zWFqnBSswvnb5ACOsVKJBkADBmbkg3U+4nKJ2baA9PD/9oB/aBdOUVTbRGjMOSRjnKDwotdyuV4E+ihhOPwQv0tdiYJWTh3ON8YrR1okdNhNFYrcH8rnIQ/gLNuY07SZDdMxXPlaBcgdREYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnAoF7x1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnAoF7x1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440B11F0089C;
	Tue,  6 Oct 2026 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791304817;
	bh=xpCibwACVdgbhj8InqgtKrRWIJvHqYqhBNMEArbKf58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VnAoF7x1UNP2TkAAceAVFR3Vza9qp6CioZhS4Viq8eUv+rTXDvHluozRXy1irrSLj
	 FnJJ4OsA+ZLath1IqQRjPjhcW959ttPd7usIU21wWOJMYc3BGqhLf2BM0lRtgQsqjy
	 HHsw/OD9uq1Q/9Jx/mE60Pxr9Ryfi+9ZmShdwpOOFnEWgLWHdWimhWIpW4Mf8sJhgH
	 G8/lpnN6vyX4HOp2CJBajd5SNXMp2E1+7AhgNpkjjhURV6i5flsiEqDvmUwNvtsaxv
	 rdf3nvDb8IPi06SED5ktAwT7LCTq4BFDrF4xM1Jn2nXFmPr/8UP8HoPKzIaB4p/54z
	 oJzB4rd5WLH7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A29C39D60A1;
	Tue,  6 Oct 2026 16:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/43] bpf: use scalar evolution to widen
 bounded
 loops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179130481603.2708704.11559670764976269822.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 16:40:16 +0000
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  4 Oct 2026 06:37:42 -0700 you wrote:
> This series implements the scalar evolution (SCEV) technique for
> verification of loops.
> 
> Scalar evolution is a static analysis technique that infers algebraic
> expressions describing how variables change within a loop body.
> These expressions can then be used to estimate the number of loop body
> executions. This estimate can be used to represent induction variables
> as ranges instead of enumerating each possible value.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/43] bpf: represent stack access effects with arg_access_info
    https://git.kernel.org/bpf/bpf-next/c/0672c5556244
  - [bpf-next,v2,02/43] bpf: describe helper stack accesses with arg_access_info
    https://git.kernel.org/bpf/bpf-next/c/32aa356d6703
  - [bpf-next,v2,03/43] bpf: describe kfunc stack accesses with arg_access_info
    https://git.kernel.org/bpf/bpf-next/c/9aa0211998a7
  - [bpf-next,v2,04/43] bpf: track may_write flags in liveness
    https://git.kernel.org/bpf/bpf-next/c/8de0510cdb1c
  - [bpf-next,v2,05/43] bpf: summarize may write stack slots in insn_aux_data
    https://git.kernel.org/bpf/bpf-next/c/ccd41f1e7257
  - [bpf-next,v2,06/43] bpf: summarize live stack slots in insn_aux_data
    https://git.kernel.org/bpf/bpf-next/c/2ff0e602d931
  - [bpf-next,v2,07/43] bpf: summarize regs that may hold a frame pointer in insn_aux_data
    https://git.kernel.org/bpf/bpf-next/c/440ad035bbda
  - [bpf-next,v2,08/43] bpf: record write effects for atomic operations in liveness.c
    https://git.kernel.org/bpf/bpf-next/c/c695981052dc
  - [bpf-next,v2,09/43] bpf: add tnum_alignment()
    https://git.kernel.org/bpf/bpf-next/c/61f39d3292ca
  - [bpf-next,v2,10/43] bpf: add cnum{32,64}_union()
    https://git.kernel.org/bpf/bpf-next/c/7372e0fd2035
  - [bpf-next,v2,11/43] bpf: add cnum64_intersect_linear()
    https://git.kernel.org/bpf/bpf-next/c/575fbdd131db
  - [bpf-next,v2,12/43] bpf: expose comparison opcode transformations
    https://git.kernel.org/bpf/bpf-next/c/f244cbfba3ea
  - [bpf-next,v2,13/43] bpf: allow subrange relations for PTR_TO_STACK in regsafe()
    https://git.kernel.org/bpf/bpf-next/c/7ddae43ac5e7
  - [bpf-next,v2,14/43] bpf: representation for intervals with steps
    https://git.kernel.org/bpf/bpf-next/c/6499523b1636
  - [bpf-next,v2,15/43] bpf: varying offset access support for PTR_TO_BTF_ID pointers
    https://git.kernel.org/bpf/bpf-next/c/17cd31244f50
  - [bpf-next,v2,16/43] bpf: save DFS postorder numbers for program instructions
    https://git.kernel.org/bpf/bpf-next/c/6bab25c91a66
  - [bpf-next,v2,17/43] bpf: move the live-register and SCC printout to a standalone function
    https://git.kernel.org/bpf/bpf-next/c/ba536c460daa
  - [bpf-next,v2,18/43] bpf: compute immediate dominators
    https://git.kernel.org/bpf/bpf-next/c/695c19b3d36e
  - [bpf-next,v2,19/43] bpf: compute loop hierarchy
    https://git.kernel.org/bpf/bpf-next/c/62083ae4dd10
  - [bpf-next,v2,20/43] bpf: add bpf_set_reg_range()
    https://git.kernel.org/bpf/bpf-next/c/651f832d9b06
  - [bpf-next,v2,21/43] bpf: add bpf_mark_reg_known_scalar()
    https://git.kernel.org/bpf/bpf-next/c/8767ffd4e718
  - [bpf-next,v2,22/43] bpf: add bpf_reg_union()
    https://git.kernel.org/bpf/bpf-next/c/297788154c13
  - [bpf-next,v2,23/43] bpf: add a min-heap for ordered analysis worklists
    https://git.kernel.org/bpf/bpf-next/c/5048674597c7
  - [bpf-next,v2,24/43] bpf: record basic-block ends in insn_aux_data
    https://git.kernel.org/bpf/bpf-next/c/141bd53be1c8
  - [bpf-next,v2,25/43] bpf: add bpf_split_cur_state()
    https://git.kernel.org/bpf/bpf-next/c/0547bc753c30
  - [bpf-next,v2,26/43] bpf: add bpf_same_memory_origin()
    https://git.kernel.org/bpf/bpf-next/c/29a555f49246
  - [bpf-next,v2,27/43] bpf: allow precision backtracking between overlapping checkpoints
    https://git.kernel.org/bpf/bpf-next/c/57eb802c24bf
  - [bpf-next,v2,28/43] bpf: compute scalar evolution expressions for loops
    https://git.kernel.org/bpf/bpf-next/c/82bcc4f665cb
  - [bpf-next,v2,29/43] bpf: use SCEV to widen bounded loops
    https://git.kernel.org/bpf/bpf-next/c/408aff9a0159
  - [bpf-next,v2,30/43] bpf: avoid widening registers that hinder exact stack-slot tracking
    https://git.kernel.org/bpf/bpf-next/c/a6474f5f8464
  - [bpf-next,v2,31/43] bpf: bpf_func_state size optimization
    https://git.kernel.org/bpf/bpf-next/c/422ffa508a7b
  - [bpf-next,v2,32/43] selftests/bpf: __msg_next tag for matching messages on consecutive lines
    https://git.kernel.org/bpf/bpf-next/c/2db7911e0e7f
  - [bpf-next,v2,33/43] selftests/bpf: bound UNIX socket path loops by sun_path size
    https://git.kernel.org/bpf/bpf-next/c/6a697681f8ab
  - [bpf-next,v2,34/43] selftests/bpf: test for stack-pointer subrange pruning
    https://git.kernel.org/bpf/bpf-next/c/a8606df987d1
  - [bpf-next,v2,35/43] selftests/bpf: tests for may_write stack-liveness tracking
    https://git.kernel.org/bpf/bpf-next/c/95cf9a876448
  - [bpf-next,v2,36/43] selftests/bpf: tests for may_def marks of atomic RMW operations
    https://git.kernel.org/bpf/bpf-next/c/64a98c9510a0
  - [bpf-next,v2,37/43] selftests/bpf: tests for map special cases in bpf_helper_stack_access_bytes()
    https://git.kernel.org/bpf/bpf-next/c/22a9679beb90
  - [bpf-next,v2,38/43] selftests/bpf: tests for register base/step arithmetic
    https://git.kernel.org/bpf/bpf-next/c/a7d81f0f457d
  - [bpf-next,v2,39/43] selftests/bpf: tests for register base/step state pruning
    https://git.kernel.org/bpf/bpf-next/c/ff12031da64f
  - [bpf-next,v2,40/43] selftests/bpf: tests for varying offset access to PTR_TO_BTF_ID
    https://git.kernel.org/bpf/bpf-next/c/295ac48d3de6
  - [bpf-next,v2,41/43] selftests/bpf: tests for loop hierarchy computation
    https://git.kernel.org/bpf/bpf-next/c/09b89711604a
  - [bpf-next,v2,42/43] selftests/bpf: tests for immediate dominator computation
    https://git.kernel.org/bpf/bpf-next/c/6f7651bd3f68
  - [bpf-next,v2,43/43] selftests/bpf: tests for SCEV analysis and loop widening
    https://git.kernel.org/bpf/bpf-next/c/ca78d19fd106

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


