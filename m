Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795576208;
	b=crgLPi+W5qY43+e/gea/jCGAxgLUXj9Zo0BymVf9ssuFAYFVy8gWH6jQZw3BCtN/+QFD
	 290CWGr2fNr4TKDO5J63wmiLHL52VRvUzktPf+UOEtsY2EuTYdT2NMU0LZy87WTnmgUdH
	 QgcXal8476dfSYNwogdnKAHhhLwRnDvfN182UMjTzGyQJPvAYVvbFVbY+Ia4m/mAYak1S
	 OtYXHZcD8GTV0xJJHTH0LWZCewPUz/30+nWtpZd0rrSKrhf0JezV5SCWjV/hveNEo5UrX
	 F0G0se0S4LYLvDmVqR+CON2/C67LEjEl0LxBt2XiyrQsGGLAhj/Ngc9OgLLNtJjOELQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795576208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=uv81qEki1IsXCUTVxfosVRprmoqvAriHj9lY6cBxSRU=;
	b=giWLp+C9x1bB79YvvRW6aBcUN/RRab9HPy6RpRJg8KjkhR/lP4HVen/zJFzf8Mxcw0CT
	 JiKwHYhn+/l5ElNFwzpnbdXpnSVEntHYsSEwQUrm2HdK6UegXZt9V9I9pab+7sVrdTjJt
	 aqEeW7CPp59m26qzY4GXwxfolubK7c6YkLSjSqZGmfgCsOT8Bt/ZfwnyTsAFBunzDjZao
	 349xbJqJ/F+rqcURDZHtKnDS562PTVfPEvDyatm52ogUOmajPHFXzFkK4BUmCYyxv+nRr
	 WPHz5lh1mvlzjxgMQOdYXBpU+ICy85WoqZzMHMbj9DvWANoB7Qv+iieYfsEomohzu6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdxdK5p2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E2606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdxdK5p2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8FD1F000C6;
	Wed, 25 Nov 2026 03:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795576207;
	bh=uv81qEki1IsXCUTVxfosVRprmoqvAriHj9lY6cBxSRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MdxdK5p22Ect1nQwuSmw5Nz+1fNJdhq8OZiW1QazQuHJUnVEZRo9yodwdUS8BuOPE
	 Y9OLT0tMJQGLPbxSB7jKbhEYzKU9EGfO90uB/nHKvB+i9lzSj/zLDW8s/sZGlrlPMD
	 uouA161dQf4lrcgtFJNoMOVN6rcFPdcOAuigJqyltOlOwb6MKXOuUfCtYX59Wf6Tk7
	 nwWx05gZ9Ya4+qjPCywqbTciVZ6WCHhSOpBWtHueBirazQNKLM6PTGXU7GpYRfIMOD
	 FfS8Y1sgTVJqz6Tv7WMFgafeiDqcYwOg+iawWuTIHwdT5h5Nq2NRhrBrwmRTnvy9We
	 lrd3+FSAo8Bbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45023808209;
	Wed, 25 Nov 2026 03:10:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf v1] bpf: Save irq flags on the stack when freeing a
 list
 head or rb root
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179557620627.191109.5266289873737735342.git-patchwork-notify@kernel.org>
Date: Wed, 25 Nov 2026 03:10:06 +0000
References: 
 <178849392dfb8ddf82d7ba4259be6113349bdc2e.1795550092.git.memxor@gmail.com>
In-Reply-To: 
 <178849392dfb8ddf82d7ba4259be6113349bdc2e.1795550092.git.memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kkd@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Nov 2026 20:54:56 +0100 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> bpf_spin_lock() saves the irq flags in the per-cpu variable irqsave_flags,
> and bpf_spin_unlock() restores them from there. One word per cpu is enough
> as long as a cpu takes no second bpf_spin_lock before it releases the
> first.
> 
> [...]

Here is the summary with links:
  - [bpf,v1] bpf: Save irq flags on the stack when freeing a list head or rb root
    https://git.kernel.org/bpf/bpf/c/81c6c8c608b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


