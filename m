Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F884F30C2
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454281; cv=none; b=OsZSmPdN57rz7Z+vRwT1G5X2KVZn/zz2UhyP+qdyAq6RT/ogi2qZyx9DNAL8/AWU22QC6PPj53eB95URZleYIKtkH+H1pzAAkuB/aT7CLmmFu/rcZNQptItAJuEu9n7CKJbjjTM8t7lnlTav3Izqg8DCGGnZUVhKngT8jk0CZdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454281; c=relaxed/simple;
	bh=mdRvaKFS90DcCYbF8nMAc3LvXSODydWfrY3n2DAfoj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AUu/yvRsUyOjukNH4eyYBYaTc3C0gsnkiNo4lX3ClKG3HZBHO1qwflG3ZGG9LOn1oEUDHLRWgVH6Ar7hFhceuGdskuU9BN/yIkYZ4T98TFxhasDZw+dIr+xZRXSVf7zLlIH8wTSLMDzPbGoCcvGkHLqxF7FWv7wPTWDSgGj5LlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwqhxU77; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwqhxU77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981911F000E9;
	Thu,  3 Sep 2026 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788454279;
	bh=vfsFuWLL8/YhDRYmiz6Z9QWGoufOz6t1D+86vNjT/Bk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TwqhxU77lHRbQ5dFt+pdJn+y8G24ZWv4LVYG1nschD4neG2u+rbI6oa2wh9Wwb7uG
	 5mZ5ntIT3Z6oVp4cblkq11fUqTXZeHubwVwvwek7JikaL7IhyE4/+l7w98hRVTKbap
	 QEENA35rbEyVJcaUOQ1nCbIGxkpjHsbiPu9rkXjXRDA5yN6eZSrfst1hN1PKfIaVqh
	 JxgwDiOYcmAFrvXxGwsBCB74dt4Vt7pzEZz9HzxF+tjfgl70+kA76oT8adiDPioSXj
	 Bt54hYd9cBAmIZnPxg3ens65UG3H3DlUQCqPznhm5i1lfN7yP3Kgt7VYmMKaZY6w4a
	 pdCUvfjqZP5VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 25DAE38119D1;
	Thu,  3 Sep 2026 16:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 00/10] Misc bug fixes - part 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178845422088.3882727.10787208358798363768.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 16:50:20 +0000
References: <20260903144433.1716731-1-memxor@gmail.com>
In-Reply-To: <20260903144433.1716731-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  3 Sep 2026 16:44:18 +0200 you wrote:
> A set of miscellaneous fixes for bugs reported by Nicholas. These are
> easy ones and should not require any major discussion, hence batched
> together. See commit logs and selftests for details.
> 
> Kumar Kartikeya Dwivedi (10):
>   bpf: Mark signal tracepoint siginfo arguments as scalar
>   selftests/bpf: Cover signal tracepoint siginfo sentinels
>   bpf: Reject tail calls directly from callback frames
>   selftests/bpf: Test direct tail calls from callbacks
>   bpf: Reject resilient lock operations in rbtree callbacks
>   selftests/bpf: Reject resilient unlock in rbtree callback
>   bpf: Mark sched_process_wait argument as nullable
>   selftests/bpf: Test sched_process_wait nullable argument
>   bpf: Mark syscall helpers as sleepable
>   selftests/bpf: Check syscall helpers in timer callbacks
> 
> [...]

Here is the summary with links:
  - [bpf,v1,01/10] bpf: Mark signal tracepoint siginfo arguments as scalar
    https://git.kernel.org/bpf/bpf/c/77515ab12e49
  - [bpf,v1,02/10] selftests/bpf: Cover signal tracepoint siginfo sentinels
    https://git.kernel.org/bpf/bpf/c/d7719a1736e6
  - [bpf,v1,03/10] bpf: Reject tail calls directly from callback frames
    https://git.kernel.org/bpf/bpf/c/266aa4ad0b2e
  - [bpf,v1,04/10] selftests/bpf: Test direct tail calls from callbacks
    https://git.kernel.org/bpf/bpf/c/d9ae3e4c7fb5
  - [bpf,v1,05/10] bpf: Reject resilient lock operations in rbtree callbacks
    https://git.kernel.org/bpf/bpf/c/7b7b8b596010
  - [bpf,v1,06/10] selftests/bpf: Reject resilient unlock in rbtree callback
    https://git.kernel.org/bpf/bpf/c/08b4dc83d981
  - [bpf,v1,07/10] bpf: Mark sched_process_wait argument as nullable
    https://git.kernel.org/bpf/bpf/c/a453d6e3b8e8
  - [bpf,v1,08/10] selftests/bpf: Test sched_process_wait nullable argument
    https://git.kernel.org/bpf/bpf/c/c1992ba73b03
  - [bpf,v1,09/10] bpf: Mark syscall helpers as sleepable
    https://git.kernel.org/bpf/bpf/c/d05524794240
  - [bpf,v1,10/10] selftests/bpf: Check syscall helpers in timer callbacks
    https://git.kernel.org/bpf/bpf/c/26a3a510cd34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


