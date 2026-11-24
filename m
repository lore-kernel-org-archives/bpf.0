Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491608;
	b=3JRXmP/gfBOrqvthFOu1QuSzh2/9L4c0TIkYZOxLM395KatebdBXej3OQ9JIWukYAL2H
	 vYcqA/WOiwmFOhKYHd+sjb9WkAw7ErdnrQav+RomFld4U9XUTLlI8UogHuxOrFqz9XPZt
	 21JCduSfuSFJvRc/1hyBmPFLA6wZrWyzFaU18Tufz6RY7jCh6vqbl7lQfi10b2Lqr3m8j
	 AttQFbiIO50iKeZehsGmFF5nAkPF7SmIC6qG6mHVKI1nsL6wy+OZoyA6FPyrWeG9IWOeZ
	 GWXq7QVXFmyRZchMC18vGpdnuq/nBNbAqmEMlfGbxwPMrAma2TpwUDDSQHdEz+N97Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=80VJVRJBJqxbGSPQ1nkPWhTQF+vX/ubKZUQ1ZjcOP/k=;
	b=jvcFEQ97GYmVlomzlns+f+N4XDKTg7Z4oSzmMqY+KG5zgF3nT8fB+MSHqX22XCvOZExX
	 UOWbfw8IuIybo+zPZY4P45yu8W68DWZGNAws7ZBuf2xA771UeXj29lrNPihSaLCcc/u4V
	 wvJI+uzTXAq/2NqEAce+YYZHhGJL2kdXMORLYnwD1j9b5D0/agoh1OH3ee6TjPgburnb+
	 ntu6vS+1LEpgUT0GzUu2hBvNvVRToSR4ilw8A+/P0Titi8zxRGvJmou8dGmMSJ3H6UI+m
	 2MI27EqNG/8rtxSyfayj+5HXr0Kf3UfbAies/eo1hDeteUUipApWmgInzfBP8GdauAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gjs92gUg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6DD606A322;
	Tue, 24 Nov 2026 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gjs92gUg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF441F000C0;
	Tue, 24 Nov 2026 03:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795491607;
	bh=80VJVRJBJqxbGSPQ1nkPWhTQF+vX/ubKZUQ1ZjcOP/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Gjs92gUgNNp5Bqc3Hinf5LjAh7GKB/StMeBUHrhUOvfiHBQJzNnk1aIMurdtTo3E3
	 pTIL0iMD1medrr73Ot4/3ztIDoVxnhV11skOfDxnHnz6NhargzBFVO6B+xhBdz20Y9
	 vxGU8HgjhBe+ZxRk3/9klP73vKyNBUUoWLZfgxB3hDig22vJ1OoDdX1MMXAYo0szNT
	 J8URdTVsqKeylOBOHyr+u3Vrn+gEcrCiTeYDGmSIq4Bib7k11s9dRclh1Nx4QhLgOo
	 qfS7TKwclbOsqJ3i+KVZ2ibscJS6oX39TYwYWvs+teMII+uYFzBALpTf65hqpeKzuy
	 YxeWVxW7cqZ3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3439439302D7;
	Tue, 24 Nov 2026 03:40:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Use an on-stack pt_regs in the raw
 tracepoint helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179549160602.3263417.12646666318418449263.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 03:40:06 +0000
References: <20261120-bpf-raw-tp-regs-preempt-v3-0-ec109009a5d2@gmail.com>
In-Reply-To: <20261120-bpf-raw-tp-regs-preempt-v3-0-ec109009a5d2@gmail.com>
To: Mike Bazov <mike.bazov@gmail.com>
Cc: song@kernel.org, jolsa@kernel.org, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, yonghong.song@linux.dev,
 emil@etsalapatis.com, kpsingh@kernel.org, matt@bobrowski.net,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Nov 2026 12:59:10 +0200 you wrote:
> bpf_perf_event_output(), bpf_get_stackid() and bpf_get_stack() of raw
> tracepoint and tracing programs share three per-CPU pt_regs slots,
> picked by a nest counter. These programs can be preempted, and tasks
> then leave the slots out of order, so a sample or stack trace of one
> task gets the registers of another. Patch 3 fills in a pt_regs on the
> stack of each helper instead and removes the slots.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Don't WARN when bpf_perf_event_output() nests too deep
    https://git.kernel.org/bpf/bpf-next/c/53a0f597cf4d
  - [bpf-next,v3,2/3] bpf: Limit nesting of mmap_read_trylock() in BPF helpers
    https://git.kernel.org/bpf/bpf-next/c/c38e4eb110a1
  - [bpf-next,v3,3/3] bpf: Use an on-stack pt_regs in the raw tracepoint helpers
    https://git.kernel.org/bpf/bpf-next/c/3dda220338a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


