Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2A3C1097;
	Fri, 24 Jul 2026 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928829; cv=none; b=g219atdXE7QkSqSoOsVbp9r9Topb/Dz2Em3rtTCOThN4ir1W0RTn7Dk9TWjaMkTVIuxexhkiQz4s+G8SupPnpo3k+kpN7PAkfhGTL2f9Bsw9ifhy3q+EWbR/6gGEglvEpUXECtiMCnmCgqOnSRSjc3iUI6fhVUo2qanxTx92I1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928829; c=relaxed/simple;
	bh=Z5uNbuyLMJFjarfoUWbEuxpvwb+ICwQ/r8CHQ55qZug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dAWegHgGdaiMvhSVdZDj6ljJRaUHoT9lsRE61WcXlugEbmDWXEHFeiMb4ZpZzdhv+MPxRMPNFy25sQtxjP4rrtOsXyZzqjsF+7iOvhEzxY7f74yQ4l6LKleuNHsufl0xGzU5j1b80uggzH8Ml78MdvDB1kY6hXDaLYjKKs2stU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBz09CkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBz09CkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3201F00A3A;
	Fri, 24 Jul 2026 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784928828;
	bh=VdjY8AbKL9V8VHyjNSSrDBurZ0IIjaJqBGK1hxMPvQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VBz09CkAxqfdOruWYuYhsUIX1ybFS5Ld+7DrFI4sg+mKuK/262TEjxIW2vzkQWw2x
	 De8KZsWWzaJ42RYuoJwwCUzDCELMpWHmpakBq0byEyGBzEpHUa84D6Mw9kmCs89CLB
	 8JK3hD1D0fV88TQP4PvvRb1N2suOsEcIkXSQFz4RdOdbMAqeKjgN9MZUXnotus0pek
	 /90WcuU8Evu8/7aYfUPzSyjoqnIG98XOjB60ywvJq0Gzgn1eYQ8EN4nyWFVJySjdV2
	 HVfoIofcTNIlTMfsPBWfjbacwd4UHktYGGq1ueWhEX9544K0TIpqpJDLab5p0VAKzb
	 oUoNY1W80Qymw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567E738111D7;
	Fri, 24 Jul 2026 21:33:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/5] selftests/bpf: Fix several issues in
 test_progs.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178492879488.3315717.16767263989748199323.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 21:33:14 +0000
References: <20260723085100.482147-1-yangfeng59949@163.com>
In-Reply-To: <20260723085100.482147-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 23 Jul 2026 16:50:55 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Fix several issues in test_progs.c
> 
> v3: Add fix incorrect error checking for pthread_create patch
>     Memory allocation null checks for the worker logic are relatively complex;
>     remove them for now and submit them separately in a follow-up patch.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/5] selftests/bpf: Fix double free of subtest_state->name
    https://git.kernel.org/bpf/bpf-next/c/791841e038c4
  - [v3,bpf-next,2/5] selftests/bpf: Fix incorrect error checking for pthread_create
    https://git.kernel.org/bpf/bpf-next/c/b04b8d4e198a
  - [v3,bpf-next,3/5] selftests/bpf: Fix missing allocation null checks in test_progs.c
    https://git.kernel.org/bpf/bpf-next/c/12b362b2f06b
  - [v3,bpf-next,4/5] selftests/bpf: Use calloc to allocate subtest_states
    https://git.kernel.org/bpf/bpf-next/c/a813ad2185cd
  - [v3,bpf-next,5/5] selftests/bpf: Fix memory leak on subtest_states reallocation
    https://git.kernel.org/bpf/bpf-next/c/06efb01c6530

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


