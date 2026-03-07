Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082F17A30A
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772863210; cv=none; b=Oj5JnoCScUrdTFNdjI+C6iEd0lOyhkTw/JPdJPQ3M+OJkstV/pdQeHli1Yga1SPWp/y8iEmoAPAsIuyMiHZx1uJWwiaLt1+3aXVsycHeHdGPQaJ0EVzW5g1PUvRuVhA8ylcV6Q9Z50g5cIMTJzcBPqul5rp5rNfrDopUXK1kngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772863210; c=relaxed/simple;
	bh=0rAhzIyx5jUYs8/xVwZCnFjU48v1fFPCZCg9c4c3jTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ubsusI9nddayQU+hXJjyTfmF3I3VgSlMl0y2g8rywkUl/+krvF6YQAOkHgns86lxCKcsOHeELAAd2+APc5ENmOsOJJf02CJfzbB51aRhyEBzXhNygBIEF1gTTXOCKt2lfqfIHK7EAVsH15wkSoUUaXkbetAp8ihJBVa3JtFY4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qtt9ssWU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qtt9ssWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0E6C19422;
	Sat,  7 Mar 2026 06:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772863210;
	bh=0rAhzIyx5jUYs8/xVwZCnFjU48v1fFPCZCg9c4c3jTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qtt9ssWU7kEFBK5jZFZKKvfqopdDcTA8cz1PdFAhbihYlzt2EueFmrLd/xXRLk433
	 og3pXIn9omli0ChK6SxExsT1Gq5oNSVylL1DozksXdH8ME8cpKx+mzbfVF8odz64of
	 6oYz4qgrEKq7OvonmkYP/u6xmdap9fpK/VA5R7JRqurZVxiWyMf93w8dvFxevRCvi3
	 I5mFwM4ZbyLLx9idFbBS4Vvyu3ZyJ7l7Cq/t1vh/nXoXUFJVgcaIJ17nZVOahDWgpD
	 vQjl4k7gcUaxyDJ4xrYkniCasV/EuzsWeohSZIE7S+EbF4LGr1m5tpd6qLBxShyiHt
	 dUuJ/v2nGZzcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDEF3808200;
	Sat,  7 Mar 2026 06:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/2] bpf: Fix precision backtracking bug with linked
 registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177286320905.180161.4061629196034081133.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 06:00:09 +0000
References: 
 <20260306-linked-regs-and-propagate-precision-v1-0-18e859be570d@gmail.com>
In-Reply-To: 
 <20260306-linked-regs-and-propagate-precision-v1-0-18e859be570d@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, emil@etsalapatis.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  6 Mar 2026 16:02:46 -0800 you wrote:
> Emil Tsalapatis reported a verifier bug hit by the scx_lavd sched_ext
> scheduler. The essential part of the verifier log looks as follows:
> 
>   436: ...
>   // checkpoint hit for 438: (1d) if r7 == r8 goto ...
>   frame 3: propagating r2,r7,r8
>   frame 2: propagating r6
>   mark_precise: frame3: last_idx ...
>   mark_precise: frame3: regs=r2,r7,r8 stack= before 436: ...
>   mark_precise: frame3: regs=r2,r7 stack= before 435: ...
>   mark_precise: frame3: regs=r2,r7 stack= before 434: (85) call bpf_trace_vprintk#177
>   verifier bug: backtracking call unexpected regs 84
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: collect only live registers in linked regs
    https://git.kernel.org/bpf/bpf/c/2658a1720a19
  - [bpf,2/2] selftests/bpf: add reproducer for spurious precision propagation through calls
    https://git.kernel.org/bpf/bpf/c/223ffb6a3d05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


