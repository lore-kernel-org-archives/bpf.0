Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A274B04B7
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559849; cv=none; b=i+ng6EEX2fM5qWlmUqrH23PC9vwtP7ROzkdAS7Fbr4GwGByaHUbM7SIhlU9rb0OqD8eof9r1K3hM2CNttJMrJ2m2OBg8jth5jXeEYZz0dWKpk8kWh5qBdLBPOuXV7b2H1/Waxxwk6Q2jCttJMcwa+DP+lUdUe430J52b2vuh3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559849; c=relaxed/simple;
	bh=Ak5qJTNBQSNUoNW2slHQ6kTwkwRiPXb7zVeXSVvJtYc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=slEkiEbDlUcKo1VPK8Z5shRisjIi7oJb33aMmWryPGSQ3z58Hav+htgKlzPSG9NTtSbpr9Em7kqyOHQjR2vzSoR2oDSJICGFMPB7cJhngssakpY9tFFPzlb82Tw+cOGrYKiRWRKVdB0CEtdxqxH0E6ryO1Hg74j4Q61GwmyZabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw5DtOCh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw5DtOCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5281F000E9;
	Wed, 12 Aug 2026 18:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786559848;
	bh=JFg7tL5mzq65BQnyJMGjitljGX5ACHLRx5/TMaeazsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Bw5DtOChlRZynmI/rpOBmWwm1klbV/j5R85EmR07I889jJrhFoZR/N6sgljMMd7Ws
	 C5oVD9SmRN9onikvHpulnDWntriwZsOL1oP38Tvz6dCg6fokrguxjgt1HnhE+gFAYk
	 zQPZu+BcwPQqOy50qTiWQ5m8KY7gPjTcvgIABq/iEdmAJQz1JCrGmbFt1Teu+lNkWL
	 YDgoxKGMvXbXMp2J3pBMgv3Bc2Ef1NWqbY+KGPB0T6JPWyEMTaPaPWw8fke90T5dzf
	 hgTa/iHWVdQuVP93rc9uOakwdjYphbYp7iOqdL9zZQFsMfA65XDJxBMmVAAG4ppCAR
	 pZ1RXLEyF9JcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939DE380AAFE;
	Wed, 12 Aug 2026 18:36:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] selftest related fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178655980319.2049475.15941799001392665951.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 18:36:43 +0000
References: <20260807204434.1036279-1-vineet.gupta@linux.dev>
In-Reply-To: <20260807204434.1036279-1-vineet.gupta@linux.dev>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  7 Aug 2026 13:44:30 -0700 you wrote:
> Hi,
> 
> This is a set of fixes accumulated during BPF_GCC testing and an in-works
> verifier enhancement series for 32-bit tracking.
> 
> Changes since v1:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] selftests/bpf: map_kptr: expect BPF_ST reject msg on cpuv4 toolchains
    https://git.kernel.org/bpf/bpf-next/c/e28b4922679e
  - [bpf-next,v2,2/4] selftests/bpf: add --no-error-summary to skip end-of-run error log dump
    https://git.kernel.org/bpf/bpf-next/c/2614285f3262
  - [bpf-next,v2,3/4] selftests/bpf: report failed subtest count in test_progs summary
    (no matching commit)
  - [bpf-next,v2,4/4] selftests/bpf: vmtest.sh: preserve command quoting when running in the VM
    https://git.kernel.org/bpf/bpf-next/c/3a59f11e0f98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


