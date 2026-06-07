Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E92E7F3A;
	Sun,  7 Jun 2026 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780790415; cv=none; b=kXnE8/R6Ju5g/xYkLeC24QmImGS9dp1zPgRePC0mwwrMjyylQXdEqEMbrWzpUKPWWCOjZ+jSySJ8QG8HtI8ILKxTdJQHEZDVewt569NrKts/QVd3KVifL8m41LmRxvObNFbda1+95jbaGar5PK6PgpshPDic44sNkA6bKYqHkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780790415; c=relaxed/simple;
	bh=wB5Lfz0DcZQloWXovr94MIM0mscWqAhIbqZ602m4diw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZUsvSS59clDlNVPRZLuhHmXa22A8cdYVDspW4sMnnrrGmtTm46OAActWFwCVpS2YAvB6eSLmfO5sJ/Cbobq6Begfvm3O6HFl37vkMZGNopCIEVmhd+RKUDOMUbkqFER37V6wISO1HQud4oUmcNJN6n+J37fd4ZOF/o5yc0nwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoaF8pQn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoaF8pQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3201B1F00893;
	Sun,  7 Jun 2026 00:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780790414;
	bh=KVlHH/qBWSP661/FbGRChdezxrO5s+6cQmHq1q63ip8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MoaF8pQnF7hoQ0beXCrewbueqKMbIAY7fL/QcNWV0SoL87Gf5Q3+gvFzqhs0IHi/P
	 6HV6jxJyqng6h9HEVUDz6eXEsUq89Nw23NPodwfw58pqcfNytr7IjdRTTMRKfcz5YY
	 GjqrASbt3PBsOW7gO3odeAqGfKEfGQd4Id7Trr6bKu9zbX1Ni1Id1cpZJooQ6i7CL0
	 Bj0y2TsPLWzdj0I1fBDbgrIBbfS4UNMx4JPXH0oVpAMCxLXNMUHhJrlJ0IvCV/yXXf
	 JARTsEz1RkGreVg9t2ueEJZIzoslWrmUcE97G3DXQJErtbG0uc9NphF6EcyX7rUHV0
	 iuW3WgIEY83bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D63930C38;
	Sun,  7 Jun 2026 00:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf, verifier: fix PTR_TO_FLOW_KEYS
 constant-offset OOB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178079041390.62966.12677084501154180265.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jun 2026 00:00:13 +0000
References: <20260606-c3-01-v3-v3-0-97c51f592f15@mails.tsinghua.edu.cn>
In-Reply-To: <20260606-c3-01-v3-v3-0-97c51f592f15@mails.tsinghua.edu.cn>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, john.fastabend@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 06 Jun 2026 18:50:36 +0800 you wrote:
> A constant offset added to a PTR_TO_FLOW_KEYS register lands in
> reg->var_off, but check_flow_keys_access() bounds-checks only insn->off
> and never folds reg->var_off.value.  A BPF_PROG_TYPE_FLOW_DISSECTOR
> program can therefore do "flow_keys += 0x1000; *(flow_keys + 0)" and have
> it accepted, then read/write kernel stack past struct bpf_flow_keys at
> runtime.  Patch 1 folds reg->var_off.value into the offset (and rejects
> non-constant offsets), mirroring check_ctx_access(); patch 2 adds verifier
> selftests.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf, verifier: fold reg->var_off into PTR_TO_FLOW_KEYS bounds check
    https://git.kernel.org/bpf/bpf-next/c/37363191cbe8
  - [bpf-next,v3,2/2] selftests/bpf: add tests for PTR_TO_FLOW_KEYS offset bounds
    https://git.kernel.org/bpf/bpf-next/c/3ce6b42458f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


