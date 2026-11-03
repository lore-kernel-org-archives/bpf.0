Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729406;
	b=xJcpYXxYbSD4vsbf94OivgcAYrX7yOVDr6qSHM4IxXLhj+gY764mMlapJuLfPBEccQOU
	 mMQ+naT2aKSeskmbSEFsh3/vpwBqlq25w6yMnkROt90HReV3vWElA2S6dTweJa5LIJnD5
	 GfaHRdLJoaF/S3YPtXLu1B6miHYw14yj4oCmlfo4Qkn5OkeQFySeA45Pi93jqWpH6rTRT
	 BDIJUIsjlzSmwxWMfGgqYdalzWTdwjoaJUfj+0khqBgwNMHjw3gt1K17jjNOXTmo475Xm
	 jyqjbhWNuXIfc8vieBUCeO3GHYPIqN8TQtbd4RXP0XeycHN1H3Pc5NLkuAlagiCWkxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TaotS+H5OTwJKSRCJIUWvWvXQkNTobAio9pfya/ZGkY=;
	b=1zXevCPLN9dE/n+5k2veYWQ42IMH/PMxww32CrWdygT4IUE56m9BiH2+MuLsQ0DCj/Ui
	 0MxyR0HHbQDhLyPeO8jKrWIMcnL8AHUTZzCUl8cJRaCNUluuzzJAlyj+zWpNXvqVgr7Ck
	 SpEoXMnepyBg+8k/OfK9uPQv3XcnE6xmKCf+caOqpKEDvpLqqkd21ihhtltDSF8xZcGFx
	 QZpv5+aM4eYNtex1OieABCnVnszJLl5AojyCMVaRhKdD6+Es1bboK8WqOmWi+41BTalJb
	 q4+GscpU+KUMFzOeU0HhZeLxKIr8qGGNc67OqD8lAG1y62jurFCni5KHjoAExbb6+Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJOZ5KwA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3658B606A31B;
	Tue,  3 Nov 2026 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJOZ5KwA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2131F000C1;
	Tue,  3 Nov 2026 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793729406;
	bh=TaotS+H5OTwJKSRCJIUWvWvXQkNTobAio9pfya/ZGkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NJOZ5KwAeLghomwJsrjYQ3gOCTV1myEAjyOTnWFHBsyiBUwmf3weXeZWJI/jZrZAl
	 Vl4gG81GdXHDB28E7ev9Yo/qLULwE6LdrteFInaWDTSMyGANpdu/9lohlUs+gHlPSg
	 2nc5SuYdtZTX7sMCRgrMaG7xGaC5c1O6Ed464cNVptkd24uMkHd6wFPccyKuWku21I
	 TTeLcimunOImKF3rYlaRQJxoHOhlRVdrRFCKlgsCtuatgQVe1a3dInuo7OuSZz2Dcn
	 vaYSlvo+Ud6ThaGwxKHC0FMpfn/L5VhVgMZmqgy238vzF1f8Ixz1WdgRHVswhlWPMp
	 skoVSsa+bQy+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030E7391B05D;
	Tue,  3 Nov 2026 18:10:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2] libbpf: Fix stale raw data after
 btf__relocate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179372940480.1794115.11055566429963645138.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 18:10:04 +0000
References: <20261103081836.381430-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261103081836.381430-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, wanghai8081@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 alan.maguire@oracle.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Nov 2026 16:18:35 +0800 you wrote:
> btf_relocate() rewrites type ids in place but doesn't drop the cached
> raw_data, so btf__raw_data() after btf__relocate() returns the old
> bytes with pre-relocation ids.
> 
> Only modifiable BTF keeps raw_data as a cache. For read-only BTF, e.g.
> module BTF relocated in btf_parse_elf(), types_data points into
> raw_data and is already rewritten in place, so it must not be freed.
> Make btf_invalidate_raw_data() tell the two apart and call it from
> btf__relocate(). Also recompute named_start_id since start_id changes
> after relocation, like the kernel does.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: Fix stale raw data after btf__relocate()
    https://git.kernel.org/bpf/bpf-next/c/b2bb14d8035d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


