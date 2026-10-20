Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455613;
	b=JuWchwk+oP4z8pbRI1hg5AUFwk5I8J/dNiD15QJ5vCm+DMeWMkTmJ78T34Nk2+3/1X3W
	 cetqhQ4XoXfqljvs8KEmNbLHL9aCg1E16nHzpvU7mcGmUlfFL2aHZDN6/lfMBGz2NH8bd
	 UbwmesxOOvPaGFvEoCQrnYOyoKCLX6A2O0IrLSIi1fqke1VgUKXdmYMEp/G5yBk/6FyNx
	 JizP7QcZ0ii/bWICgwlLXdiIfB5IW0A1bezgh0w25DbZHSneVjIkOtNkaq3SbTBT5l4yv
	 xXL9Dw1G9Cmn+9y4/qcIjvI7QffYARkk39wFOT10TSLWW3RpP6SNklfAA2cP0yO4YOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455613;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=zPrDuXU+qul5SBHHR8AdZmqE/d5fyyD0AILjgbV+C7g=;
	b=yaHYDfm4Q0RsoZregqkC5XWLDw6AaHVg5GRJWbWDHF4El9qzpVdhSOeIIGpKXbh9sqWm
	 b03hlAY8KQKdmm+zTETkwCFMDwA1G3arbzYepZOEPD3bHNbsqiTNsFhjIil+SABe9sKff
	 gHqppN9gW9a4/vpLSsDfrH73IBoc5FsqKs3+Pdhygkr0MEQdxXfSzXuY3fQxCJtdfnSiS
	 W7MvmgW1tFxQmcSFc6lPvvcZdNyQ9fqCtYUQ8M3sfDycUuxUEbqoD53krlq/JQi49oFfV
	 h2P9GmBSbBSLfpQZ0Sla9IQ9zDWpKwR1kR3ZRoQ2siKAA/RX9n5sRlLQivozh/M4owQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfviUlE3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3188D606A31F;
	Tue, 20 Oct 2026 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfviUlE3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCFF1F000C7;
	Tue, 20 Oct 2026 00:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792455612;
	bh=zPrDuXU+qul5SBHHR8AdZmqE/d5fyyD0AILjgbV+C7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gfviUlE3najpuFiwcxmBkjnbV1P2lWYo3dGmKQqet3VDyJLtEhwh0D5A3E6tMj6/A
	 yxWgreysZpclaqPYAnGwgQbgMfvgh4e8Gb2aFoBvJZFfccwnDt6bTr51kFB78aXIka
	 VDgbiZFpvCC/TQFA7qcTCaaZPhiF51XTmgXFp5haJu5YagvVUBq3gubPj2mZGxBGRX
	 gDJqJXp6VKL5nNozNA8CxPaDuKrspCSAgn3gu4i0rt8kylao1qY2m7xKlYBLCBphbH
	 959yjicNv5iuGirwMQ+bZCpeGtJ+SuN3gxkuLfPIeE9p9R8fSMkPhHkfKqd3cgh+W2
	 Zme8hVVwVoRhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44803924A6F;
	Tue, 20 Oct 2026 00:20:12 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/3] bpf: Fix builds broken by fatal
 resolve_btfids
 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179245561140.3398635.15879772378050778401.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 00:20:11 +0000
References: <20261019211006.2574350-1-sashal@kernel.org>
In-Reply-To: <20261019211006.2574350-1-sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, edumazet@kernel.org, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, ameryhung@gmail.com, puranjay@kernel.org, sdf@fomichev.me,
 mahe.tardy@gmail.com, jiayuan.chen@linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, petr.pavlu@suse.com, leon.hwang@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 Oct 2026 17:10:03 -0400 you wrote:
> Commit 201a454df948 ("resolve_btfids: Fix the --fatal_warnings exit
> status") makes resolve_btfids warnings fail the build again with
> CONFIG_WERROR=y. That exposed BTF ID references to functions some
> configs don't build. KernelCI has been seeing i386
> i386_defconfig+kselftest builds fail on linux-next since next-20261015:
> 
>   WARN: resolve_btfids: unresolved symbol bpf_arena_reserve_pages
>   WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
>   WARN: resolve_btfids: unresolved symbol bpf_arena_alloc_pages
>   Failed to generate BTF for vmlinux
>   Try to disable CONFIG_DEBUG_INFO_BTF
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: Drop unused entries from special_kfunc_list again
    https://git.kernel.org/bpf/bpf-next/c/63be110a96ae
  - [bpf-next,2/3] bpf: Don't reference arena kfuncs when arena isn't built
    https://git.kernel.org/bpf/bpf-next/c/ced6a0993e2f
  - [bpf-next,3/3] bpf: Fix ksock build with BPF_LSM=y and SECURITY_NETWORK=n
    https://git.kernel.org/bpf/bpf-next/c/a81bd9262cde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


