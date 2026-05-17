Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571F2C3271
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779051595; cv=none; b=DoEAWtYv3WCYw9fGED85E94/Z+eK0a/qyMgBHt3exPZ4e0D8tCcccX+tkorI/fkYZ0j8wA5JBPCTpTP+4JVP38Q1k2tL63u2nSUDeh8SvxgrVIaNM70qbzhPl8XgJ+XA829cosExhPra+3oc2mIoGrEc8jeGip6hXIY3XII+iBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779051595; c=relaxed/simple;
	bh=PSXJ2LUj7O3X73wgmaZUZfHbn1lo7+H+R2qD8JIDbmg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S6j5S5vYwLrAmX9ojLuxbgFPA3Jcn/lzQgT9xKOKRtQn3i+2gqSfaeurabwGvdXx2LfvpFSL7rDg/+HRT16QI1EZyDxWLRB0HVE+00YVKOROI9s0DN68RwVeixcbQvsDFa/fBMv+hcz3srKNVIQ8dxVY+lqJTa6GWBRH24zTKl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwZDXQ4e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwZDXQ4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4736DC2BCB0;
	Sun, 17 May 2026 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779051595;
	bh=PSXJ2LUj7O3X73wgmaZUZfHbn1lo7+H+R2qD8JIDbmg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NwZDXQ4ePiIeRqzKxodKRRLa2POMo2iYKaDpCcv+RIhkTsJtd1GZBOMdjakt8GcrJ
	 rF/8o5vh0OosKAW3J3jOmbNNL1L7yfo2ZQspIw0Eh6WwAw7sDn15r9skoIIciSbzol
	 Hv29JnMEkymenKn0avYPBcaO59btsaQnlna6CaZRHZBRRVvT9k21YX+gERalIgT2P8
	 lprE5zsmAWC6tEjT7YnT4nJCG74utWY6YbJZf0gNRJCTup1PBf2uVuixNWbfTqBqps
	 qiu9YDRIUCQjjPWiv/ilb0l2Ggt7j5Rh+Tf7KKAgcyrve37PrA7j/ThdN8FoIF/iHy
	 P7ZKxrsjfflrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938E93930B8B;
	Sun, 17 May 2026 21:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf,x86: Fix exception unwinding with
 outgoing
 stack arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177905160715.690668.11374766658828009905.git-patchwork-notify@kernel.org>
Date: Sun, 17 May 2026 21:00:07 +0000
References: <20260517150702.288031-1-yonghong.song@linux.dev>
In-Reply-To: <20260517150702.288031-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 17 May 2026 08:07:02 -0700 you wrote:
> When a main program with exception_boundary has outgoing stack
> arguments (e.g. from calling subprogs with >5 args), bpf_throw() fails
> to correctly restore callee-saved registers, causing a kernel crash.
> 
> The x86 JIT allocates the outgoing stack arg area below the
> callee-saved registers via 'sub rsp, outgoing_rsp' in the prologue.
> When bpf_throw() unwinds, it captures the main program's sp (which
> includes this outgoing area) and passes it to the exception callback.
> The callback gets rsp and rbp, followed by pop_callee_regs, but rsp
> points into the outgoing arg area rather than the callee-saved
> registers, so the pops restore garbage values. Returning to the
> kernel with corrupted callee-saved registers causes a crash.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf,x86: Fix exception unwinding with outgoing stack arguments
    https://git.kernel.org/bpf/bpf-next/c/18a37465b0ab
  - [bpf-next,2/2] selftests/bpf: Add exception tests with stack arguments
    https://git.kernel.org/bpf/bpf-next/c/576482b55c19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


