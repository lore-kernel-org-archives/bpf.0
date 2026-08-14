Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F53368AA
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746053; cv=none; b=ezfzx8C+6HJUfNT18eXvgkOH1cnONtYPInIxLZz5+TfzUYcEbqPClGOltC8owGoA3zeMCE9rfzgfZfP4mxuRNBsiOjPD427Mq57/iGeR+aPIl0f93/bSzfzAmAcBH8ZHn5pGZED2pBxVQdHDEXiG8P3I5ZwTtqRhUiZaiC1RHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746053; c=relaxed/simple;
	bh=xHDKFFy+EzLiaIyUlsrSVGTsTs9djwD+kBFQcYgT8k4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VLqgoilroJ50Fi2gXqyzgCWs3EETY3Ik2tUZsyWLnv7dP2OUPyiGjRVtUQ0PccJ1J867z6S/rfqus3mTd1Azea51DCBQaYiP6WdkDPLujW3bUt0pPKBPBCMBMwbZSPysua2e4iZ3djV25bLNcHCMH8SrRzBa29q8RGpWWJabzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThE19d0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThE19d0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB77D1F000E9;
	Fri, 14 Aug 2026 22:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786746051;
	bh=r8rVAjxxKEaGp1OwxVN9RFZnP+fsvJpzDgwUrtvy5Lk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ThE19d0xHWJzxt0EZGtKmeZguieljoZWT2FNLZZiMjNfmwOls0JPXCSWAweQWkw9s
	 VImNP2lSEyHv8bNw9Wp9sDnMpdFPTXdcWojPll4uiWYMWmA83/r9tpenDMmzb+DoGH
	 X9n1QKIqyVazFjXqtzLs9eCFJS/AKd4pRyr1m6M11FR8YUPZLcC+dIxjJnOM9Xhg3p
	 8nXSQBLb8eUUGpwHRYUH1pWFN8+9AKLHZ4vLGsT4V9anp56wNmpE6g6OI1aY7FUvZR
	 L/UnMdgveugr3imiVwzt4o5K8edbvUaAoG5fAHjAhZhLJ0X88l8fiOnJNWwS2aNIfO
	 oOy0XqO48NsJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987A392445D;
	Fri, 14 Aug 2026 22:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix selftest build after filter.h
 update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178674600565.3979181.10843148924741279043.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 22:20:05 +0000
References: <20260814173522.2783625-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260814173522.2783625-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 14 Aug 2026 10:35:21 -0700 you wrote:
> Upstream commit 7a1f400ff5e5 ("tools: Ensure tools copy of
> linux/filter.h exports the UAPI") caused selftests/bpf build to
> fail [1] with:
> 
>   In file included from progs/arena_atomics.c:9:
>   /codebuild/output/src2365462129/src/actions-runner/_work/bpf/bpf/tools/testing/selftests/bpf/../../../include/linux/filter.h:9:10: fatal error: 'uapi/linux/filter.h' file not found
>       9 | #include <uapi/linux/filter.h>
>         |          ^~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
>     CLNG-BPF [test_progs] bind_perm.bpf.o
>   make: *** [Makefile:888: /codebuild/output/src2365462129/src/actions-runner/_work/bpf/bpf/tools/testing/selftests/bpf/arena_atomics.bpf.o] Error 1
>   make: *** Waiting for unfinished jobs....
>     GEN-OBJ  [libarena] libarena.bpf.o
>     GEN-SKEL [libarena] libarena.skel.h
>   make: Leaving directory '/codebuild/output/src2365462129/src/actions-runner/_work/bpf/bpf/tools/testing/selftests/bpf'
>   Process completed with exit code 2.
> 
> [...]

Here is the summary with links:
  - [bpf,v1] selftests/bpf: Fix selftest build after filter.h update
    https://git.kernel.org/bpf/bpf-next/c/a2b83a8c8430

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


