Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794027634;
	b=MKPBhhrDPKz39KYcsaPp894BhUoMy7MNfUnuxSYQcAYulAmPG4M+Pla1+ozw6fzFtzfa
	 ukBoSuUEbJ0Ir+1aQvgpuR2g8dL/Zv2t+ZhLyzkf5h3oSUh85+GhuTibmLWW9oLOC0Xuj
	 drvYnpT0tOjT+rIwlmJbNCtcQ5g9fSkNROADzNEHTooRD+bRRK46GXQhU5k1CgFV7riZ3
	 Bv4XQc4XFdeKLL06iCehXE5xVB5yXYEvvHD7lfBTYCLxSnqhoXZiwVvG2GJGkh2AHzUp5
	 +5IYWCFgtXJxMLqSuVBVR4Y/sB96Wp2GHuGLLdGglMnx+eM1e9VgdrgfUOF72PE1q/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027634;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=q6U7599bsuWhJ3gdFlNkn0fcYJxv+BUtLIaMjwO/VLw=;
	b=i9bx2AnvsuvyF4rxKVwOfxclN+4kGxQxw3ya10YB33Prb0B50RdmY2fnGI8fVPG5cC6n
	 QRj8mX67U+eicmJICHxQrnz4LbX3GGZ06GYY/koDLVLQw82XzFeN9rq20TuJS2y4P4/+v
	 afjKKScEQOvjLdYVoIqsxa9FWHftRRrDq6zh7SAPxFSGbwuyKwlLhbQq11hTQHtT8Z9sd
	 tnbc43FddSgmSpj+gYHvPJkOMXvgiaIJUDFYms8NnOqjra24zpdD48bxqDOI0z5YVxiS0
	 W6UA82GBqKtVeZ7jsOKyGAnhFXBGSAvDNvbUg1Koy1SM4i/Ccp9Z9YQgZ+JBKsW9BzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GauvcQIY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13340606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 05:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GauvcQIY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24101F0089F;
	Sat,  7 Nov 2026 05:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794027633;
	bh=q6U7599bsuWhJ3gdFlNkn0fcYJxv+BUtLIaMjwO/VLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GauvcQIYIG9n0dYbBLapXQtmRW9YWs2ZVTgZE6I5s/ZJ+4C7e11bSekfISUEjL3SI
	 gyJRJ3d9/JUppiUaeDqyFLV6peayi53FY76nxoe6FZb2swxIgiFBuafvjIJ/BX0XX2
	 Gi7Y83hTb6Pl5JTW+rVQWTH0YYyyB0EDr1IpQoJUm5tjYFul2/FOH+P3yXfVBkbo/a
	 jbV9hMFTlYQ3jT2dBvcFuoTUGyDevKZd5gnjovMZIiniiHUQM+mdwIcySvqckv5q78
	 guZt+UTOpM2DRicwNpqR0K3a/y4cVjXFZjq6L8vcajEMeshl0fFHVmH7iErXk3AJ0+
	 RHMqOcdQiS3mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D84A33A566CB;
	Sat,  7 Nov 2026 05:00:33 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v4 00/46] bpf: A verifier that joins states
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179402763268.1038843.17775791110324291537.git-patchwork-notify@kernel.org>
Date: Sat, 07 Nov 2026 05:00:32 +0000
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  7 Nov 2026 03:37:08 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The verifier follows each path of a prog, and each branch can double the
> number of paths. The work grows with the paths, not with the prog:
>   insns processed                                    today    this series
>   rust-bpf  scx_beerland/beerland_init_task        1000001 *        16430
>   rust-bpf  scx_qmap/qmap_init_cids                 131088 *          196
>   scx       scx_eevdf/eevdf_dispatch                350041          15322
>   Cilium    bpf_host/cil_to_netdev, Oct 2026         64658           7538
>   * "BPF program is too large", "The sequence of 8193 jumps is too complex"
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/46] bpf: Add may_goto to the loops that the verifier marks
    https://git.kernel.org/bpf/bpf-next/c/8ed7285ee075
  - [bpf-next,v4,02/46] bpf: Limit depth and time of recursive subprogs at run time
    https://git.kernel.org/bpf/bpf-next/c/7b7dc9c6e8e9
  - [bpf-next,v4,03/46] bpf: Add union and widening of the range of a register
    https://git.kernel.org/bpf/bpf-next/c/ff3712ef1106
  - [bpf-next,v4,04/46] bpf: Add join of registers and stack slots
    https://git.kernel.org/bpf/bpf-next/c/47388a4c175e
  - [bpf-next,v4,05/46] bpf: Add join of verifier states
    https://git.kernel.org/bpf/bpf-next/c/ff30ca620432
  - [bpf-next,v4,06/46] bpf: Tell which arguments of a call a join must leave alone
    https://git.kernel.org/bpf/bpf-next/c/af6bda3802af
  - [bpf-next,v4,07/46] bpf: Add the data structures of the main pass over the control flow graph
    https://git.kernel.org/bpf/bpf-next/c/0c30e60b214c
  - [bpf-next,v4,08/46] bpf: Order the insns, find what stops a loop and where may_goto can go
    https://git.kernel.org/bpf/bpf-next/c/9075b1169d6b
  - [bpf-next,v4,09/46] bpf: Find the registers that hold a number or a pointer to arena
    https://git.kernel.org/bpf/bpf-next/c/0c5ce2587057
  - [bpf-next,v4,10/46] bpf: Find the registers and stack slots that later checks depend on
    https://git.kernel.org/bpf/bpf-next/c/a8bfc00bacb4
  - [bpf-next,v4,11/46] bpf: Add the sets of states at an insn and the entries of functions
    https://git.kernel.org/bpf/bpf-next/c/8468842a8950
  - [bpf-next,v4,12/46] bpf: Compare states of different iterations of a loop
    https://git.kernel.org/bpf/bpf-next/c/6a3204708703
  - [bpf-next,v4,13/46] bpf: Decide which states are not joined
    https://git.kernel.org/bpf/bpf-next/c/773b03804ab1
  - [bpf-next,v4,14/46] bpf: Merge the state that arrives into the set at an insn
    https://git.kernel.org/bpf/bpf-next/c/9b56d2e47f3a
  - [bpf-next,v4,15/46] bpf: Move states along edges, into loops and subprogs and out of them
    https://git.kernel.org/bpf/bpf-next/c/19d27a501a52
  - [bpf-next,v4,16/46] bpf: Make the state after a call from the caller's state and an exit state
    https://git.kernel.org/bpf/bpf-next/c/8875170bb1d2
  - [bpf-next,v4,17/46] bpf: Enter and leave loops in the main pass, build flow.c
    https://git.kernel.org/bpf/bpf-next/c/a784eb58f12b
  - [bpf-next,v4,18/46] bpf: Tell the passes over the graph where an added may_goto goes
    https://git.kernel.org/bpf/bpf-next/c/51bfd6314dcc
  - [bpf-next,v4,19/46] bpf: Verify programs as a fixpoint over the control flow graph
    https://git.kernel.org/bpf/bpf-next/c/5395aa9bbeb5
  - [bpf-next,v4,20/46] bpf: Keep the count of a loop when a register has no closed form
    https://git.kernel.org/bpf/bpf-next/c/9b202a8c7722
  - [bpf-next,v4,21/46] bpf: Verify static subprogs on their own
    https://git.kernel.org/bpf/bpf-next/c/8fd58560b71e
  - [bpf-next,v4,22/46] bpf: Allow recursive subprogs
    https://git.kernel.org/bpf/bpf-next/c/eaea73907052
  - [bpf-next,v4,23/46] bpf: Remove is_state_visited(), bpf_compute_scc() and iter.depth
    https://git.kernel.org/bpf/bpf-next/c/6771f70a4733
  - [bpf-next,v4,24/46] bpf: Remove precision tracking
    https://git.kernel.org/bpf/bpf-next/c/9f644d937dcf
  - [bpf-next,v4,25/46] bpf: Remove prune points, levels of state comparison and pop_stack()
    https://git.kernel.org/bpf/bpf-next/c/8ecf70baad8b
  - [bpf-next,v4,26/46] bpf: Update comments about paths, pruning and explored states
    https://git.kernel.org/bpf/bpf-next/c/b7bf79dd6f1e
  - [bpf-next,v4,27/46] bpf: Track a pointer to one of a set of functions
    https://git.kernel.org/bpf/bpf-next/c/edcafaec6256
  - [bpf-next,v4,28/46] bpf: callx reads what the subprogs whose address is taken read
    https://git.kernel.org/bpf/bpf-next/c/6d4131627eae
  - [bpf-next,v4,29/46] bpf: Keep the first iteration of a counted loop apart
    https://git.kernel.org/bpf/bpf-next/c/df9b13a441c9
  - [bpf-next,v4,30/46] bpf: What a call returns in each iteration is like what the loop loads
    https://git.kernel.org/bpf/bpf-next/c/89557ca1fc86
  - [bpf-next,v4,31/46] bpf: Find where the jumps of a loop stop a number
    https://git.kernel.org/bpf/bpf-next/c/e2b83f4db687
  - [bpf-next,v4,32/46] bpf: A loop is one iteration shorter behind the jump that counts it
    https://git.kernel.org/bpf/bpf-next/c/a00c8eafb381
  - [bpf-next,v4,33/46] bpf: Give the places of a back edge to the jumps that count
    https://git.kernel.org/bpf/bpf-next/c/95ff2abedf64
  - [bpf-next,v4,34/46] bpf: Count a loop whose exit tests a copy of the counter
    https://git.kernel.org/bpf/bpf-next/c/ab5fa7281144
  - [bpf-next,v4,35/46] bpf: Allow tail calls and LD_ABS in subprogs that return void
    https://git.kernel.org/bpf/bpf-next/c/1dcc217fefba
  - [bpf-next,v4,36/46] bpf: A part of a pointer that is spilled is a number
    https://git.kernel.org/bpf/bpf-next/c/50ea1f0797de
  - [bpf-next,v4,37/46] bpf: 32-bit add to a pointer and pointer op pointer make a number
    https://git.kernel.org/bpf/bpf-next/c/4a3a9c2d6896
  - [bpf-next,v4,38/46] selftests/bpf: Adjust tests to log lines that are gone
    https://git.kernel.org/bpf/bpf-next/c/7e363442447f
  - [bpf-next,v4,39/46] selftests/bpf: Adjust tests to new verdicts, messages and order
    https://git.kernel.org/bpf/bpf-next/c/dd43eeaf99eb
  - [bpf-next,v4,40/46] selftests/bpf: Test states that are not joined
    https://git.kernel.org/bpf/bpf-next/c/8292b648ae99
  - [bpf-next,v4,41/46] selftests/bpf: Test static subprogs that are verified on their own
    https://git.kernel.org/bpf/bpf-next/c/489b946f5f6a
  - [bpf-next,v4,42/46] selftests/bpf: Test loops that are counted, walked or widened
    https://git.kernel.org/bpf/bpf-next/c/d0a8c63bfc66
  - [bpf-next,v4,43/46] selftests/bpf: Test progs that run out of budget
    https://git.kernel.org/bpf/bpf-next/c/bab5cb94006e
  - [bpf-next,v4,44/46] selftests/bpf: Test callx of one of a set of functions
    https://git.kernel.org/bpf/bpf-next/c/d14f973f1559
  - [bpf-next,v4,45/46] selftests/bpf: Test pointers that become numbers and subprogs that return void
    https://git.kernel.org/bpf/bpf-next/c/d13baed274e6
  - [bpf-next,v4,46/46] selftests/bpf: Test progs without bpf_for(), zero, can_loop and such
    https://git.kernel.org/bpf/bpf-next/c/b5ae07f77d27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


