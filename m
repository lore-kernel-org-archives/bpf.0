Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342EB4FD78C
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578417; cv=none; b=exl2BK9YKRv588BdXb6/+BqqTUGlmaFM44lKTkKj7ZwMiMcuxIm/dSA2WPD/MAnEAe1sfqGPk7Axt59ySid3zyib/+0ECyT8zvVZ4J41hN87E/2ugWtFD/lp68vIFLz1z7kfz4uC+veh3QCHlP0VqYR83uPKA/npZALH9YuUkKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578417; c=relaxed/simple;
	bh=B5LZEhOtWfrC498twzekQRBzTjuEhPsW9t1IIwVRk48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WYY9/sVUvuNGaX4f2+OzBtCAMfhbR5UGISX5UBFGzNIh7wePgRDcfLLqlbNs0GCFflLjUc5Ve2tzZY1n+Wv8quS1EcAz1cK5UtkXqPgkxRb2aV2wZff7EP4a3McKYsJOEEENj1RskqQLqnAwjEUbNdHNJwrjEvtFmnfI1rqGT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkBgxOfc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkBgxOfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E991F000FF;
	Fri,  9 Oct 2026 20:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791578416;
	bh=8OzV0YjDB1XwAbEmOFqnIOMK7mFLG1n2o9ABe71Gnfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GkBgxOfczllQ7Q6FgTZZjpIlNpGk2mnkutvcC48nGjfQtMTVy6opM6gSpdUjvKd3c
	 UMLSb9R5eM7xZcKCo1xNi+tVAp6Q3jMJhC5bBjcBn+bgfRWFG790wmIM5gSe72Ccjw
	 s5SCHZNyB7Rfz+Nc77ERQAR5s+J2JgRRGanFIzguRzOoML/M/iKbQ/Gs2ekYIgp+HD
	 DskCcFH2UwURpuaMbB1F8P8qbLGRn0nX9V4RgqHg/wNZhPW8xfTo8KjH/gnu7LGy9g
	 XVIOP27z12oJ0HvYHCegw++g6iuWn8jBmvVdMZrCZerWXhk4ZYDO+GQNuXx0uq4M9R
	 rHcSMcPsfaYfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16B7392627A;
	Fri,  9 Oct 2026 20:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/51] bpf: use scalar evolution to widen
 bounded
 loops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179157841478.994426.4444472944074100023.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 20:40:14 +0000
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  9 Oct 2026 03:47:18 -0700 you wrote:
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
  - [bpf-next,v3,01/51] bpf: represent stack access effects with arg_access_info
    https://git.kernel.org/bpf/bpf-next/c/5b6beb95f7b4
  - [bpf-next,v3,02/51] bpf: describe helper stack accesses with arg_access_info
    https://git.kernel.org/bpf/bpf-next/c/830e4372de5c
  - [bpf-next,v3,03/51] bpf: describe kfunc stack accesses with arg_access_info
    https://git.kernel.org/bpf/bpf-next/c/8f3bd4537faa
  - [bpf-next,v3,04/51] bpf: track may_write flags in liveness
    https://git.kernel.org/bpf/bpf-next/c/ac43e0393f44
  - [bpf-next,v3,05/51] bpf: summarize may write stack slots in insn_aux_data
    https://git.kernel.org/bpf/bpf-next/c/0360ed8655cf
  - [bpf-next,v3,06/51] bpf: summarize live stack slots in insn_aux_data
    https://git.kernel.org/bpf/bpf-next/c/30175f5d9b1a
  - [bpf-next,v3,07/51] bpf: summarize regs that may hold a frame pointer in insn_aux_data
    https://git.kernel.org/bpf/bpf-next/c/c6477be15804
  - [bpf-next,v3,08/51] bpf: record write effects for atomic operations in liveness.c
    https://git.kernel.org/bpf/bpf-next/c/2d903f95721a
  - [bpf-next,v3,09/51] bpf: fix arg_track_xfer() for atomic stack spills and fills
    https://git.kernel.org/bpf/bpf-next/c/13cffb883180
  - [bpf-next,v3,10/51] bpf: derive global subprog stack liveness from BTF signatures
    https://git.kernel.org/bpf/bpf-next/c/8212c1c2986d
  - [bpf-next,v3,11/51] bpf: compute parameters liveness in bpf_compute_live_registers()
    https://git.kernel.org/bpf/bpf-next/c/147400e9c27c
  - [bpf-next,v3,12/51] bpf: add tnum_alignment()
    https://git.kernel.org/bpf/bpf-next/c/4072d7f56b44
  - [bpf-next,v3,13/51] bpf: add cnum{32,64}_union()
    https://git.kernel.org/bpf/bpf-next/c/a8e9a53f6df6
  - [bpf-next,v3,14/51] bpf: add cnum64_intersect_linear()
    https://git.kernel.org/bpf/bpf-next/c/78e61c01a760
  - [bpf-next,v3,15/51] bpf: expose bpf_rev_opcode() and bpf_flip_opcode()
    https://git.kernel.org/bpf/bpf-next/c/685ac494443e
  - [bpf-next,v3,16/51] bpf: expose bpf_grow_stack_state()
    https://git.kernel.org/bpf/bpf-next/c/041d7c85c45d
  - [bpf-next,v3,17/51] bpf: expose bpf_verbose_snum()
    https://git.kernel.org/bpf/bpf-next/c/f21dcf26986c
  - [bpf-next,v3,18/51] bpf: allow subrange relations for PTR_TO_STACK in regsafe()
    https://git.kernel.org/bpf/bpf-next/c/366b4c68d830
  - [bpf-next,v3,19/51] bpf: representation for intervals with steps
    https://git.kernel.org/bpf/bpf-next/c/0892ef2a7ef3
  - [bpf-next,v3,20/51] bpf: varying offset access support for PTR_TO_BTF_ID pointers
    https://git.kernel.org/bpf/bpf-next/c/89e72f81a455
  - [bpf-next,v3,21/51] bpf: save DFS postorder numbers for program instructions
    https://git.kernel.org/bpf/bpf-next/c/f414d20879ae
  - [bpf-next,v3,22/51] bpf: move the live-register and SCC printout to a standalone function
    https://git.kernel.org/bpf/bpf-next/c/ceea9085f2d1
  - [bpf-next,v3,23/51] bpf: compute immediate dominators
    https://git.kernel.org/bpf/bpf-next/c/6254fb693289
  - [bpf-next,v3,24/51] bpf: compute loop hierarchy
    https://git.kernel.org/bpf/bpf-next/c/9ae7f5e8bf1d
  - [bpf-next,v3,25/51] bpf: add bpf_set_reg_range()
    https://git.kernel.org/bpf/bpf-next/c/f849c3a145eb
  - [bpf-next,v3,26/51] bpf: add bpf_mark_reg_known_scalar()
    https://git.kernel.org/bpf/bpf-next/c/bc2afa09c07e
  - [bpf-next,v3,27/51] bpf: add bpf_reg_union() and bpf_reg_union_compatible()
    https://git.kernel.org/bpf/bpf-next/c/6360b15f86ed
  - [bpf-next,v3,28/51] bpf: add bpf_split_cur_state()
    https://git.kernel.org/bpf/bpf-next/c/97d592e69d09
  - [bpf-next,v3,29/51] bpf: add bpf_same_memory_origin()
    https://git.kernel.org/bpf/bpf-next/c/4c3a56544b65
  - [bpf-next,v3,30/51] bpf: add bpf_spill_size()
    https://git.kernel.org/bpf/bpf-next/c/1291ad590693
  - [bpf-next,v3,31/51] bpf: record basic-block ends in insn_aux_data
    https://git.kernel.org/bpf/bpf-next/c/2fa579694ddf
  - [bpf-next,v3,32/51] bpf: allow precision backtracking between overlapping checkpoints
    https://git.kernel.org/bpf/bpf-next/c/60b0109ad195
  - [bpf-next,v3,33/51] bpf: compute scalar evolution expressions for loops
    https://git.kernel.org/bpf/bpf-next/c/1501b536818b
  - [bpf-next,v3,34/51] bpf: use SCEV to widen bounded loops
    https://git.kernel.org/bpf/bpf-next/c/6ccf49f79327
  - [bpf-next,v3,35/51] bpf: avoid widening registers that hinder exact stack-slot tracking
    https://git.kernel.org/bpf/bpf-next/c/088a5477a9bd
  - [bpf-next,v3,36/51] bpf: bpf_func_state size optimization
    https://git.kernel.org/bpf/bpf-next/c/a2052333e6f9
  - [bpf-next,v3,37/51] selftests/bpf: __msg_next tag for matching messages on consecutive lines
    https://git.kernel.org/bpf/bpf-next/c/9fb8927b956b
  - [bpf-next,v3,38/51] selftests/bpf: bound UNIX socket path loops by sun_path size
    https://git.kernel.org/bpf/bpf-next/c/0c7530110d27
  - [bpf-next,v3,39/51] selftests/bpf: test for stack-pointer subrange pruning
    https://git.kernel.org/bpf/bpf-next/c/73e7927bdafa
  - [bpf-next,v3,40/51] selftests/bpf: tests for may_write stack-liveness tracking
    https://git.kernel.org/bpf/bpf-next/c/c4db12b80c09
  - [bpf-next,v3,41/51] selftests/bpf: tests for may_def marks of atomic RMW operations
    https://git.kernel.org/bpf/bpf-next/c/2c719872958c
  - [bpf-next,v3,42/51] selftests/bpf: tests for stack pointer spills/fills through atomics
    https://git.kernel.org/bpf/bpf-next/c/75a46f59e098
  - [bpf-next,v3,43/51] selftests/bpf: tests for map special cases in bpf_helper_stack_access_bytes()
    https://git.kernel.org/bpf/bpf-next/c/e60fb9b6b5be
  - [bpf-next,v3,44/51] selftests/bpf: tests for BTF-based global subprog stack liveness
    https://git.kernel.org/bpf/bpf-next/c/063c85f5d8c7
  - [bpf-next,v3,45/51] selftests/bpf: test for register liveness of subprogram arguments
    https://git.kernel.org/bpf/bpf-next/c/a88078acc2e4
  - [bpf-next,v3,46/51] selftests/bpf: tests for register base/step arithmetic
    https://git.kernel.org/bpf/bpf-next/c/2db5837f9ada
  - [bpf-next,v3,47/51] selftests/bpf: tests for register base/step state pruning
    https://git.kernel.org/bpf/bpf-next/c/8c5f6dfefdf1
  - [bpf-next,v3,48/51] selftests/bpf: tests for varying offset access to PTR_TO_BTF_ID
    https://git.kernel.org/bpf/bpf-next/c/e187fac8ac6b
  - [bpf-next,v3,49/51] selftests/bpf: tests for loop hierarchy computation
    https://git.kernel.org/bpf/bpf-next/c/951538da0fa9
  - [bpf-next,v3,50/51] selftests/bpf: tests for immediate dominator computation
    https://git.kernel.org/bpf/bpf-next/c/aa8964a8e5f1
  - [bpf-next,v3,51/51] selftests/bpf: tests for SCEV analysis and loop widening
    https://git.kernel.org/bpf/bpf-next/c/8b93e9f92c16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


