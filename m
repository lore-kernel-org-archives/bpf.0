Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606008;
	b=4uS58fsi9BlLRWu9QjLs6wlrD8JcoB5pFZvH8LhT5ycFrFEkFPnmuMXl6oOYFRglrOt3
	 pyIoyIHBk3OfPDatc5BhqNVtVc+04J3QXw04YzHKi5gApJ8d2wGFzbytEWgUBXukAeOo1
	 8nLU3RGMC3Ujv9tE19AMYSk/P9JzJ6Xlz0JHHxRdwC4lNUtZOucT8DFpThlpb2PFTo/ZO
	 UdsG7xwDV1g+Lo9VJAnecPbvijezUacfbtPdN2KVjDDioDzJxd2xmFI/e+PYJ6nCIa4TY
	 aNoPQMG4bdOisRuA8Ost8b1Q9FF2SQn9W0a6f8HyjZwIfB1dxLDMnxLjCoyeKRpd0EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Nrqhvqr/i2EoXqHkA1xxvEv5ep3yiAFTSve3A+551mM=;
	b=ZQwygIBrMFDM0Zd4fGU/KyOyDKk6Kd1VoXmzr92B5zyeKnz2XDxMvc+o1sI/OlMNC8F3
	 mdvXEgYpcUIRcweUdfOWMVM8sLQ8RXWNKGyl8sVfZ5IwjAxSSt+xNrPqSD83n23lwnf3q
	 A9/CydSsfIqktsnNiSKO+tgaS1NTP51gqcChDBIlnrwZlRW9804ledgvtdpDAHbpMzNvO
	 qMvAk0JX/aKndKjNEh9CYdIOi4fHYS5gvI4pZLbex5bEaczCG+/o6BUdcHGk/lxaC//lT
	 Vw7bnoOtsy/JuuSP7bhAS162P7H+UwzgtyK/uDjHDrN8rcufHUv3BOQftwPsS0WEyFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BR1xzx80;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA1606A8A7;
	Fri, 13 Nov 2026 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BR1xzx80
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EB01F000C4;
	Fri, 13 Nov 2026 21:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606008;
	bh=Nrqhvqr/i2EoXqHkA1xxvEv5ep3yiAFTSve3A+551mM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BR1xzx80M9v7zX9thY+44h57psw6DllFOj6poaDj5vBAMdoFyk5ClFEbQkpy7eGZz
	 gBo1VQ6bt22exOnbB3GtidbWNS2Pj64VEVyT3R88ZR2bEBL8duwbmt26crLqmGKWZg
	 klqwfsRIw/Ztpo0dHpjwroyEKivoHctQD0em0V5qtPwdF/62UuMQ1Kvpap7a+HADaA
	 DNhgXhgEoJEbrTjkbJ70MngWgEbJ0FWbwOpkgEbIkzeYKWZ8NVSm1GytfsAZre8cHh
	 FEz1maIUIf5Htnwet4kX6kaPO3BRrKuIW8xR/haYly1x+/AECMnlv4fyUXrdIjb5LX
	 XADjs2CIp0QFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1553380821F;
	Fri, 13 Nov 2026 21:40:07 +0000 (UTC)
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
Subject: Re: [PATCH v2 0/2] selftests/bpf: Fix d_path check_mem_access and
 drop
 CHECK()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179460600678.1853483.7161886083844264787.git-patchwork-notify@kernel.org>
Date: Fri, 13 Nov 2026 21:40:06 +0000
References: <20261106-dpath-memfd-v2-0-1dc0799b4aa6@gmail.com>
In-Reply-To: <20261106-dpath-memfd-v2-0-1dc0799b4aa6@gmail.com>
To: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 06 Nov 2026 10:37:07 +0700 you wrote:
> Patch 1 replaces the deprecated CHECK() calls with ASSERT_*().
> 
> Patch 2 fixes check_mem_access, which creates a temp file in
> /dev/shm that isn't mounted under vmtest.sh in local runs. This
> causes mkstemp() to fail with ENOENT. mkstemp() is replaced with
> memfd_create() as it gives a shmem-backed file with no mount
> needed while still reaching vfs_fallocate.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] selftests/bpf: Replace d_path CHECK() with ASSERT_*()
    https://git.kernel.org/bpf/bpf-next/c/ed6624f3e8b6
  - [v2,2/2] selftests/bpf: Use memfd_create instead of mkstemp in d_path
    https://git.kernel.org/bpf/bpf-next/c/75cf1b5e5489

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


