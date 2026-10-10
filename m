Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267C449B01;
	Sat, 10 Oct 2026 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645009; cv=none; b=DpADJMEcpMMAU3O9pVNG+RQroKonpoJTi0yorJ1ErO9SBNVa6J3pLJ388NpX1KTDc05eVP9LRxjYoCS3BHnmazTD/G5MWPED6b81jPonMC3V/rRiyzQyq5cti/BlWc2STaFXtuSVC4q3QxUrxGbg430e0ks/fiWL5DpY5qlOt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645009; c=relaxed/simple;
	bh=uDLPYu4jDpSnWThkhJB7UKaGkDwOWKS7FZMSGvt8Dq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PrANriIjxAlgezO9yg9cCGC6ULt3uaF5xam8KuxTruE8imQinogqFG8VpKbs+pIn+vIi6t5xikXC0GQKSwe9ynfImPc1igfunDoJ954K5pqEN7YwI9arTq3gyqGrDtTBLEYdSskw8m+cXXz/omY57MLUXhwezNn7o576ceurzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/2X/yKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/2X/yKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5FD1F000FF;
	Sat, 10 Oct 2026 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791645008;
	bh=iek8VipYwbptAyUrMEWu1ntqexeiiQemt/HWdWWCSec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N/2X/yKlCQBzE0039rrT3agz6Cj3CWMvqOlT9HQxvHkEp+tSVbI1b/fY2V+FtghAG
	 ySXod3OSWF7zgEoXh6jzTD0OcLawU3mDe7bLf9trSFpvMo4xt1dU7Tm8YEZrp5vahO
	 XVr3ayaDQ2T/5wBj7SfHBhYZACtFpvLyNwM3lipHzove8WnJdpc+tl2OovWzSGB6qN
	 wni/4FhxDYqyTxKZ0v1PNBsoSxgmB8RUgt+ODPenVGYvalhSVEYfrHKPLmvJ0HPh4/
	 ruDE5h6siC/tIAwOTfdAFaXJr5LLedFpKX6ly5xOycPaDiiF5AyC0VlORNGLH0oWRP
	 PdjHiphnZFwTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772EB380DBDA;
	Sat, 10 Oct 2026 15:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] bpf,
 arm64: Fix racy plt target update in bpf_arch_text_poke()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179164500701.1749710.14140149592072860929.git-patchwork-notify@kernel.org>
Date: Sat, 10 Oct 2026 15:10:07 +0000
References: <20261009173802.1248441-1-thepacketgeek@gmail.com>
In-Reply-To: <20261009173802.1248441-1-thepacketgeek@gmail.com>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, puranjay@kernel.org, xukuohai@huaweicloud.com,
 catalin.marinas@arm.com, will@kernel.org, leitao@debian.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  9 Oct 2026 10:37:59 -0700 you wrote:
> When a long-jump trampoline is attached to or detached from a bpf prog,
> bpf_arch_text_poke() updates the plt target at the end of the prog by
> temporarily making the page writable:
> 
> 	set_memory_rw(page);
> 	WRITE_ONCE(plt->target, plt_target);
> 	set_memory_ro(page);
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf, arm64: Fix racy plt target update in bpf_arch_text_poke()
    https://git.kernel.org/bpf/bpf-next/c/6335e6719fd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


