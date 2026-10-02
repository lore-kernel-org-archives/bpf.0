Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D049363E
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946616; cv=none; b=AnMjRhro5pFR4xEu/ziUYXm8Z8ELeilfOZON/0ZbHb571jixMbHzbm+KgBC7KlgkcfJHbS5rzYmm7FexDvrarVsZ3cIOI+iGJPlv02qBzD2J9ruLRHpDXQGk2KOcs8yGSgMICatfsFyelgRFznaR1DyuaH8NLPxyR149Uz9t0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946616; c=relaxed/simple;
	bh=UGiUqLR9n1ZWetD69qIYfypoV+UBRs+Y/VYTmvomggo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e2HAjVWzUnsoKV9p8W8dSCxuVdkDcNNtDXBViAJEM5fEz+7vsz7L8RIMSLRO93id7xJ5Y5UffJcKKSXUHoZ/cehqgzG5g6ct/Dgd8ydLCq//OuSdazgnJNCr9f7kTomkBhct65NfG4N6kiAB/TbVA6WR7KdSEg1bJpQZ4Kp20Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJLcHIig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJLcHIig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059041F000FF;
	Fri,  2 Oct 2026 13:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790946610;
	bh=74/G1KlfUc6G7KfmxtJ9uI4z50ER8Ubnw8wvYc96gYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FJLcHIigN+BprT2aLD4hxLJRn/JEUs7y82XcyeDko71R1cyv9HSIwY1rL3pGk6kGq
	 HLTm2pOqUQ633iT8hsaY/dmJRxTAxhShsQgyGIM0XGEOTTlYe1zVJawb2i4zKWcOdv
	 2Jp+S4BAnedbEKmD+ff5xi/GBJvDwcH9/+OK6qknWKZThbIuV/GtNRkYiYN4Su/uwg
	 zagHI5ZovIR4HZ44OIXAv0KiB2Z8u8R8EhLoLfNwl4dQltFVQHzfvuOOaPSFba/OBI
	 bIVZ5u0Udo+WuOF5dSju4qWFGKBb3ZjQedlZxad3p/S9HpY99YhnVfg42iB2nK1QpR
	 txF51yhHPOcmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15FE38119FF;
	Fri,  2 Oct 2026 13:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH bpf-next v6 0/7] Make sleepable arena paths use
 sleepable alloc_pages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179094660853.3409201.15855834832486252230.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 13:10:08 +0000
References: <20261002105218.6171-1-emil@etsalapatis.com>
In-Reply-To: <20261002105218.6171-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, daniel@iogearbox.net

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  2 Oct 2026 10:52:11 +0000 you wrote:
> The arena_alloc_pages() call takes a sleepable argument based on whether
> its caller is a sleepable BPF function. This flag, along with the context
> the kfunc is called in, decides whether the call will try to fulfill the
> allocation using the regular or the _nolock variant of the alloc_pages
> API, by means of bpf_map_alloc_pages().
> 
> However, the arena_alloc_pages() call currently only makes allocations
> inside an IRQ-disabled critical section. This forces all allocations to
> use the _nolock() API, which may eagerly fail where the regular variant
> would eventually succeed. There have been reports of this happening for
> sched-ext schedulers.
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,v6,1/7] bpf: Use an llist for page allocations
    https://git.kernel.org/bpf/bpf-next/c/11de29f38a34
  - [RESEND,bpf-next,v6,2/7] bpf: Add sleepable argument to bpf_alloc_pages()
    https://git.kernel.org/bpf/bpf-next/c/cbe7d2bf7355
  - [RESEND,bpf-next,v6,3/7] bpf: Add sleepable arena page allocation path
    https://git.kernel.org/bpf/bpf-next/c/5316ede1f5d0
  - [RESEND,bpf-next,v6,4/7] selftests/bpf: Test large allocations for both sleepable/nonsleepable arena users
    https://git.kernel.org/bpf/bpf-next/c/0f6512272538
  - [RESEND,bpf-next,v6,5/7] bpf: Directly store kfunc desc index in instruction off field
    https://git.kernel.org/bpf/bpf-next/c/baf4e66f038f
  - [RESEND,bpf-next,v6,6/7] bpf: Support per-call-site kfunc specialization
    https://git.kernel.org/bpf/bpf-next/c/23290213e1ab
  - [RESEND,bpf-next,v6,7/7] selftests/bpf: Test per-call site function specialization
    https://git.kernel.org/bpf/bpf-next/c/fc38f07781ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


