Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794075017;
	b=Ez1+En1+GSqIHUkTBZCFRvNoHGN1UNl0aHTawiV7ZoFZrHUlPdxQlX6EeLYAc+1BXOak
	 mIcLQOQhsZl1CKlchA0dGGtaf/8XdZ+VkSmJPuIRXeOt8/s4jnhGrGEo9Z+X5gZJ2GcOo
	 8wPcBSqBNIAYw/aS0z/rqjHsHgn+07ugxeOBYuGzlnxIomkZ2UCfZ+UglGLcgh/FodfFb
	 RzQ5zINWEnYdq2Eo4s6CZo6pDRVKuSMWa3w4z9ZOkJkgFUfX2GOEwhFXzJ0kIMLz2MsHR
	 ivR5Q0ELUc79QTeMX1ub2CthK4cpSONz1UTBFdWNewLXoGET+JU43rCzIXM5YmlEuaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794075017;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9jsv9HnflSYK6/4J9yP8x3RxgcRdAfizh/Us1gIqPQA=;
	b=2sLlPP3Ljhi9u5emYQdWf0QaU7jXKbqkRdN4OwUHc1++478TSMWxkYrW/lkqlH39Czoz
	 RDUlNfVKYuAYrgkntrZ2AhZX9nWr5hG9Bvvn6VtMCrKzQDpsfl9HMLEu1QZFWcSOcXGBf
	 DBVOiqMJ3kb6DmVJzGUiDDQ1lbnYnjrZIeNAZHaF1M8NXPnsn1i/0foykU3icolyg2+YS
	 HuKqh3vUaTwPTX474/YvTs76qq0PcABzWDvpgeXg34SahE28H9KtVRWFsBBOfQ6XJD00Z
	 /ySZTxH8RSXRMxCaaXaM4mFk+l/ZlkiGpM/U0DKfTADj30p9ymuO4+83HYDdwXnuRiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OgoIfzVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42C606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OgoIfzVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F7D1F0089F;
	Sat,  7 Nov 2026 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794075016;
	bh=9jsv9HnflSYK6/4J9yP8x3RxgcRdAfizh/Us1gIqPQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OgoIfzVsQ0CA1/la3sKH4/ZyWvyrvp53tLxot98HIjiPp8ilspV6of9jNlawLPMuE
	 x0RWVcAUGljFhZZkHX9t00VaWM6dbs+5VJScoL8kNUFqrQZ4RV7kdey+iWDQksW/fW
	 e644HLy5Y0WDsOmD1pR6FKFOqQKV41LW5oFH4CcO2035qU5w1YPbDQMW7WdfQ29C45
	 iFDARgIoBhEqCdEHV4PKfAw4gHlaVEgeWlsuReVcQc25R1GxXfWRe6yeQo3EX2nq0l
	 hB3VXN3IbzOM1Vo4ZnszTr3mbC7Y7QnH35SWldlxboGyqyzDPK67aQMN0rqdbu1NRN
	 PXTNV/32pQMuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B2CF380821F;
	Sat,  7 Nov 2026 18:10:16 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/9] bpf: Fixes for the verifier that joins
 states
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179407501534.1275874.8791571297081875215.git-patchwork-notify@kernel.org>
Date: Sat, 07 Nov 2026 18:10:15 +0000
References: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  7 Nov 2026 17:02:57 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Fixes for commit 2d0b457611c0 ("Merge branch
> 'bpf-a-verifier-that-joins-states'"), from review and from BPF CI.
> 
> 1-2  A number that wraps in front of the jump that counts a loop gets
>      a wrong residue behind the jump. The verifier then checks numbers
>      that the register never has.
> 3-4  Two of the new tests fail in BPF CI: one with GCC BPF, one on s390x.
> 5-7  The same kind, no job shows it today: a message with GCC, a target of
>      fentry that is not in BTF, five tests with an arena that run at the
>      same time under KASAN.
> 8-9  Valid progs that throw one of several error codes are rejected.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/9] bpf: Leave a number alone that wraps in front of the jump that counts
    https://git.kernel.org/bpf/bpf-next/c/914dd83543fc
  - [bpf-next,2/9] selftests/bpf: Test a number that wraps in front of the jump that counts
    https://git.kernel.org/bpf/bpf-next/c/589b23cbc6c6
  - [bpf-next,3/9] selftests/bpf: Skip the stack walker of verifier_loop_latch with GCC
    https://git.kernel.org/bpf/bpf-next/c/ce4b64ed8b22
  - [bpf-next,4/9] selftests/bpf: Skip plain_c_test_wakeup_source without the kfuncs
    https://git.kernel.org/bpf/bpf-next/c/f567c4b7af18
  - [bpf-next,5/9] selftests/bpf: Expect GCC's first error in test_alloc_double_release
    https://git.kernel.org/bpf/bpf-next/c/98cc0b224608
  - [bpf-next,6/9] selftests/bpf: Skip plain_c_arena_race without zap_vma_range() in BTF
    https://git.kernel.org/bpf/bpf-next/c/57c57a40807a
  - [bpf-next,7/9] selftests/bpf: Run the plain C tests with an arena serially
    https://git.kernel.org/bpf/bpf-next/c/b992d6ed7531
  - [bpf-next,8/9] bpf: A join must leave the cookie of bpf_throw() alone
    https://git.kernel.org/bpf/bpf-next/c/ed10b8a49c39
  - [bpf-next,9/9] selftests/bpf: Test a flag that goes with the cookie of bpf_throw()
    https://git.kernel.org/bpf/bpf-next/c/d877bd038cc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


