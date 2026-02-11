Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3142C21E6;
	Wed, 11 Feb 2026 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845415; cv=none; b=Ew9qQnnKTkvanzvWay9gMgiTRtu9t0DOgYeGq8zJwpdNQ6gx3+r/NPufPjPirgVh8rLSfnvpxDusCXfZVYCxT7IBn75NWiZds2KAivglwSER4COGQXJJjuWIYXbrxzq3WcpaR+l5fHrAmdRCNp9CH7GtGRbMDfHk5BQkYLkcHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845415; c=relaxed/simple;
	bh=jGSWgobZu8SSkt96gwsYuyQDTPK+maSuIoQySGd+Yiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l5hTZr1Tk8cRRF46/8t68qN4Xc3TXHHIpePDNgiiyD5crRb5U7SdhjEfFD+YXv3z8fSKsRcgSdeX+Drh3Dr+hauUf0ZvgAjcu4cjsoLXc/d4QgOTASBoMSJgojdSHTtWrTEXApJ53PFZC+r25iT0EnYjzJBowzsvP+6CPe8EVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXLE/ffK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXLE/ffK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAF8C4CEF7;
	Wed, 11 Feb 2026 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770845414;
	bh=jGSWgobZu8SSkt96gwsYuyQDTPK+maSuIoQySGd+Yiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LXLE/ffKLeIzA6+Yz0lSWUCmtRxXLvs310sCDcDp3Pb+tTvSP498dd6ZZpS4+7Ou3
	 3eiZNuzIpH2TrskdtyHS+LmQK5J+7TdpXfa4NasD169uYdxXpkKQqX+VKvkOuJVZzi
	 xsjIlBF2p2eyVBYdCO4BiRgukzeYj+LgLFn6wWq6Jr/ukm7wYZlwomhLWqblETvo+K
	 8ijDgH3//TIh1OnD0x7eaAJ3oQidiOKrdalseABYmvHojkwYPuH/yCS4HlH0RSMACA
	 ccWVC8ERTUbtRkiCNsozjHKmfIsv+pMyTTyjoE2eoORMIpOf2aE0+r2ar2t8Ye1CYR
	 RXXXn3hV7mj9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C265C39EF964;
	Wed, 11 Feb 2026 21:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] bpf: fsession support for riscv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177084540958.756737.255449740151994166.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 21:30:09 +0000
References: <20260208053311.698352-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260208053311.698352-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, bjorn@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jiang.biao@linux.dev

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  8 Feb 2026 13:33:08 +0800 you wrote:
> Implement bpf fsession for the riscv architecture.
> 
> Changes v4 -> v3:
> * fix the build error
> * v3: https://lore.kernel.org/bpf/20260206122002.1494125-1-dongml2@chinatelecom.cn/
> 
> Changes v3 -> v2:
> * fix some comments.
> * v2: https://lore.kernel.org/bpf/20260206115823.1070354-1-dongml2@chinatelecom.cn/T/#t
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf, riscv: introduce emit_store_stack_imm64() for trampoline
    https://git.kernel.org/bpf/bpf/c/63ad3d614241
  - [bpf-next,v4,2/3] bpf, riscv: add fsession support for trampolines
    https://git.kernel.org/bpf/bpf/c/2277c14bc90b
  - [bpf-next,v4,3/3] selftests/bpf: enable fsession_test on riscv64
    https://git.kernel.org/bpf/bpf/c/5749b6532b4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


