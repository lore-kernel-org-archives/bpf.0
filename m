Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC438F95B
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 03:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183291; cv=none; b=M8kf0oMuW+XnN4M2ljIL+6kieu+hrvOa/IxrTnd4emEiDqKwJCY2IK3UYNy64UYedB4FyshGhYHJZCjmzmq3h4dB1aM6Zv7kGRkJQvdzcrhsRcchUoDibxEFAuyW9Tr+nr4uNuBF/OoqssPO23quzJJDiBc2nqHeGBiFm3N/DhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183291; c=relaxed/simple;
	bh=vbEP4XvkUHDZU2Z/U7R3ZivOpDkkAazgDGyLw3jn+H4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MpwP/J9Qhdr4FxXLfO9uJQ7PgRKv+Qc2WOm//Z6to84Uo4CWvb2wrU3nZwTe6PtgJaLeiXJjFu7FzzDxTlPGzNB2iVYRZvET95YvPrrp0tiqgtQzRC6IvWKYQ0YgdIoal7+8f2yPeMPsg9pf1hABVogFssNo/AZfLIRkYCvXUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChsAnkss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChsAnkss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3891F00893;
	Sat, 12 Sep 2026 03:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183286;
	bh=mxZtiPz9X6/M+cgVO45WD42H5/CJ0o81h5NOIUv1T/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ChsAnksstTyCZypRLHNXKhIYW/DGdN1tFxMtfetQJcXGAdmVI7At7ykyM+27beK7m
	 5OAzpZpbeEWHVXDErQSvPfedjkDMMcPxeScdRm0icjoO5mC731TjonzGr+6tvKb9kD
	 wlw6cYvGX7RKE+XtDPNQZhE1WT9SGiUQUqFrI19dbwf6ET9UhB9L5Bqqs1RlmgLe1Q
	 oh4ediZTn/hc+dCMGM2UPcd9VT5i/Rhnr6PGCv8gTrqb0s15yfA3NJ31799r3IXAlz
	 ulAYEMZA5HxCYOE3Ek79S7IRguz8ng6I4zV7wfTeRJbhqbPzazQW2ACt8TfZo22y/y
	 FS4VkTOsT0n0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08FA392445E;
	Sat, 12 Sep 2026 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/23] Unify helper and kfunc argument checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178918322237.3208623.2482210545600015868.git-patchwork-notify@kernel.org>
Date: Sat, 12 Sep 2026 03:20:22 +0000
References: <20260911220415.1396439-1-ameryhung@gmail.com>
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 11 Sep 2026 15:03:52 -0700 you wrote:
> Hi,
> 
> This is the third and final patchset unifying helper and kfunc checks.
> 
> Helper and kfunc calls currently validate arguments through separate
> loops despite enforcing many of the same contracts. This duplicates
> type admission, nullability, memory, BTF, packet-access, and resource
> ownership handling.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/23] bpf: Pass call metadata through shared argument checks
    https://git.kernel.org/bpf/bpf-next/c/6523af719a21
  - [bpf-next,v2,02/23] bpf: Address check_func_arg() arguments by argno
    https://git.kernel.org/bpf/bpf-next/c/47f4215b8b54
  - [bpf-next,v2,03/23] bpf: Only compare func_id against BPF_FUNC_* for helper calls
    https://git.kernel.org/bpf/bpf-next/c/d18bcf4537e0
  - [bpf-next,v2,04/23] bpf: Only compare func_id against kfunc BTF IDs for kfunc calls
    https://git.kernel.org/bpf/bpf-next/c/0bddc59e33a4
  - [bpf-next,v2,05/23] bpf: Clarify unused and scalar function argument types
    https://git.kernel.org/bpf/bpf-next/c/6db166056c25
  - [bpf-next,v2,06/23] bpf: Unify kfunc argument kinds with enum bpf_arg_type
    https://git.kernel.org/bpf/bpf-next/c/5e7edfe68654
  - [bpf-next,v2,07/23] bpf: Classify kfunc arguments the verifier ignores
    https://git.kernel.org/bpf/bpf-next/c/5fa6e69e2e66
  - [bpf-next,v2,08/23] bpf: Align helper and kfunc ARG_PTR_TO_PROG_AUX handling
    https://git.kernel.org/bpf/bpf-next/c/0cc91f0e7241
  - [bpf-next,v2,09/23] bpf: Set OBJ_RELEASE when generating kfunc argument types
    https://git.kernel.org/bpf/bpf-next/c/57e181cde7e6
  - [bpf-next,v2,10/23] bpf: Set MEM_UNINIT and dynptr subtypes when generating kfunc arg types
    https://git.kernel.org/bpf/bpf-next/c/78811eac7ae6
  - [bpf-next,v2,11/23] bpf: Set MEM_RCU when generating kfunc argument types
    https://git.kernel.org/bpf/bpf-next/c/2b2b08c277cb
  - [bpf-next,v2,12/23] bpf: Resolve BTF ID of ARG_PTR_TO_BTF_ID in kfunc bpf_func_proto
    https://git.kernel.org/bpf/bpf-next/c/fb8d353bb58f
  - [bpf-next,v2,13/23] bpf: Resolve ARG_PTR_TO_MEM | MEM_FIXED_SIZE size in kfunc bpf_func_proto
    https://git.kernel.org/bpf/bpf-next/c/6ca151e7cc32
  - [bpf-next,v2,14/23] bpf: Consolidate runtime argument type resolution
    https://git.kernel.org/bpf/bpf-next/c/2e418779a00e
  - [bpf-next,v2,15/23] bpf: Consolidate nullable argument validation
    https://git.kernel.org/bpf/bpf-next/c/750f3770809a
  - [bpf-next,v2,16/23] bpf: Drop redundant BTF pointer helper write rejection
    https://git.kernel.org/bpf/bpf-next/c/a583d56e8de3
  - [bpf-next,v2,17/23] bpf: Consolidate helper and kfunc PTR_TO_BTF_ID argument matching
    https://git.kernel.org/bpf/bpf-next/c/b472f03e3141
  - [bpf-next,v2,18/23] bpf: Admit kfunc argument registers through check_reg_type()
    https://git.kernel.org/bpf/bpf-next/c/2bd4a975ea5d
  - [bpf-next,v2,19/23] bpf: Consolidate function call pkt_access validation
    https://git.kernel.org/bpf/bpf-next/c/8fe994c80af2
  - [bpf-next,v2,20/23] selftests/bpf: Test kfunc packet memory direct writes
    https://git.kernel.org/bpf/bpf-next/c/5647b77587ce
  - [bpf-next,v2,21/23] bpf: Consolidate release argument validation
    https://git.kernel.org/bpf/bpf-next/c/5dc1549afac9
  - [bpf-next,v2,22/23] selftests/bpf: Test nullable per-CPU kptr identity after exchange
    https://git.kernel.org/bpf/bpf-next/c/4f18de58a44c
  - [bpf-next,v2,23/23] bpf: Check helper and kfunc arguments in one path
    https://git.kernel.org/bpf/bpf-next/c/ab7fff217fd1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


