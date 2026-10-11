Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031D444713;
	Sun, 11 Oct 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726016; cv=none; b=aaCE0lq53gbanNkAjd9BgSsp9ONiWLn34xYMzJzNVGU4TibC96rPTln2eiEMoZ5etwnXxwiEb5Z4U+/OXvbyndFPpTsRFXcV4VHJLPiBy+MjnL6p0EKbA2s1XOQJfRic3K7tphxY3EVYoMda+q5WwGTCyBUivYN6b9ldIQasvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726016; c=relaxed/simple;
	bh=9byi1tVmdAD8XxreWFxKKvizpB6f3qIA8OtkmDPVEUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Excw5MC9qpabJRQ6i3aCYS5Rv+wTHAeIbBh0qLdzHso69wCXmlcavSmtAqM1undw1/OLn2iD3pArldt9J7iE9rOwgP+Q+CDMW9Rn90PQ0SPFW0Q30hK7MQDlI8K8K95IMvvdZsSzaB38XNPhu6GIhQEsfalmhAsmk4MK3HhKooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+ANgdx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+ANgdx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820601F0089C;
	Sun, 11 Oct 2026 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791726011;
	bh=dC6sK2uDDpjnsPQCMiprzwDVtvUZBRCHhZuHjbIbSXE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X+ANgdx53YnCadU42EK77uENt55rFmD+tnaErltmgodFMXfj/9s8+y37LtsWrukny
	 Cx7wceCEjR8NtudAX/WUs7ygCz3c248LJH361ZGThkbSx4KXZUsXAcqcgYQET7o0+X
	 S7ld54U/nytHVp1pqAOi0KSfOKNsmYupdLKQ5iKPyablex3aWkPBBzfZOpealDCw8W
	 EWramJXdKjm3lsdmV3fhfk4GcPhizKvbHCShgacOMFjOMVWVzjeYpd/J1LN1kI/Dbs
	 2YtRPFYnKXmRwuJQFoy4eiwcjvEe/52b8Zuvsp4gjJsytxd6s+PJCpsfuMnYMcVj2t
	 LT0VQchO+BD6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773AA3811966;
	Sun, 11 Oct 2026 13:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] riscv, bpf: Prepare for upcoming daily CI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179172601001.2055679.10398551714592277673.git-patchwork-notify@kernel.org>
Date: Sun, 11 Oct 2026 13:40:10 +0000
References: <20260930083522.1914145-1-pulehui@huaweicloud.com>
In-Reply-To: <20260930083522.1914145-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bjorn@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, puranjay@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 30 Sep 2026 08:35:18 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> For some time, bpf selftests on riscv64 have suffered from several
> silent breakages and test failures. These mainly stemmed from changes
> such as riscv ftrace atomic patching [0], qemu pmu behavior changes, and
> environment mismatches. While some issues have already been addressed in
> previous patches [1-3] and some are in progress [4], the remaining ones
> are handled in this series.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] bpf, riscv: Fix stack-passed arguments for indirect trampolines
    https://git.kernel.org/bpf/bpf-next/c/b4a1ecae94ae
  - [bpf-next,v3,2/4] selftests/bpf: Avoid jiffies quantization error in setget_sockopt
    https://git.kernel.org/bpf/bpf-next/c/153a855d0b3d
  - [bpf-next,v3,3/4] selftests/bpf: Update qemu config for riscv64 in vmtest.sh
    https://git.kernel.org/bpf/bpf-next/c/78142aa07ef6
  - [bpf-next,v3,4/4] selftests/bpf: Update DENYLIST.riscv64
    https://git.kernel.org/bpf/bpf-next/c/52e98bc77f32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


