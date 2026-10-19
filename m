Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326543F0BF;
	Mon, 19 Oct 2026 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412407; cv=none; b=r+atG99vdO7cdknlcTQjcG5EIAaaSx6638GarcA5k0DN/s6HhOedSibqxVRQZtx7Lm2mgDE/mgRH//k5S6i3RlKUMSM1xOtrnpZVhpZAUpYqN2RK156/ZDy1K7Qp9Fc0Bz0T9P57h3Xd+NieBqJ+9K7WHQyS7uiMc6GM6th3KCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412407; c=relaxed/simple;
	bh=WfZwg3fzFek5yW/qzvQeQpYiL5vYC46xuIKuiuTDFQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AKbJCEOnPmlZneCbObeFyKYC3jWg9c2uYYjURlZ5vPlvr3jbzzdJAMjhX+LhTLamH84MhfQX3ApUEZqRqukjY6gsAp4k7WUZV6UcZ8Z/rptswpmBlF1FBrurUUSQ1tew1xHPbLx1fqpJbwxJ517YtEXGjOmnun8ntBQKmMz4Qmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myxMooLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myxMooLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075C71F000C4;
	Mon, 19 Oct 2026 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792412406;
	bh=AqdQ2bzWh0I8Yqbdhr9KRT48Z3OdFkoLt+kAiQf2IXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=myxMooLZ9BJfxhUxs/8qL+A95tpI/mcSXLq/otscRgDCYZGyd3J7rGNMtvMCTOH8H
	 ZGUKfB0mE5+tv7ULn4kXWRk+6aYQYUIDL7nkbNM0oSUXNfmTRZWpNsGqp77yft5Hkw
	 Cp5/0dsF8D14SpRZlNobRPf31bBipFa1quZyGwgf2d5t2pV2VWV9e43A346v7j78wL
	 s8i4kB4KP0jCgXiVKIk0TWjTkeE67Fe5RnNWNTr3J1gjhfOJxrxbPU9RtFjdcSkXVu
	 fft7bwhmj0l3HSm2aIk6FP2GhXlyssvIPq12FgzHi+40DkcrSNEquYAneTYz06kU4X
	 AhR1dvVHNZTGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F183A3811A59;
	Mon, 19 Oct 2026 12:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Drop subtest descriptions in
 jit_insns_arena.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179241240478.2601898.6135742721862792752.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 12:20:04 +0000
References: <20261019083005.12236-1-yangtiezhu@loongson.cn>
In-Reply-To: <20261019083005.12236-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 19 Oct 2026 16:30:05 +0800 you wrote:
> Drop the redundant __description macros from arena_zero_off and
> cast_to_user inside jit_insns_arena.c.
> 
> This allows the test_loader framework to automatically fallback
> to the snake_case C function names rather than the description
> string for test display.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Drop subtest descriptions in jit_insns_arena.c
    https://git.kernel.org/bpf/bpf-next/c/25bb03f0a47b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


