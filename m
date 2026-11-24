Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540208;
	b=LNodaQQZOt3MYYKP4Sl1IgHEWvBCg2SA8LpshPVAjZ0bzy3ysqFso8SkT/efKS/VJNQ7
	 UinEfjd3uCx23DtG03MNMFbsrEW0vhbJObHKhHLZzwV0RHS4rl3DyymkgA8yVHg+6zhZH
	 iEguVdq7Yv1Ay4isI3JzJouhvVSObIBALfhqC+PJ6cygBUxoZ6fs3QTZKRplkqcY6RPwQ
	 Tb+KJqSdw1r5bFNnp7/xXa29ljTPvRpYraDpdLlTAyCFGAWRp/ZqgTrntNdNmVhLMq6FF
	 kQK4PULJiLf5k0/RXOx2fvIFMedzKZ8MIDz5HUuJ32P2VFJFJSkUOsd9FeOcCKWoY9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3gEA9ver3LRZOk45yPCmpz9bhELUsuxLXD8q6tXpL8E=;
	b=uEEdPCWIhxqtWVnGLaXXqX+kAeeP/8oCS0CpYxFH2o4PKqs67OTSuC7mHYt6DgIHDwPe
	 ENo3u5x3brhkpVgawv9DwL8WNtCZnhGL0q8qo9XTbh41iIvcCVF4S/MsNpnifgsTEe+rz
	 91nLFvucwNqrcWfw6YofRZwHVfoRj+4oqHmfNJkz2x8xR5bj+PFnb+kXW/WOxp0fV5R7p
	 yEeKebCo5adzjWS0aNBLRCOSsIcwCnvuyDrESNcbCy+s4QqUBYeCQvTTXE2taQlcDH5bx
	 jR6CgNpIOOebkJs9O4hWrwRbcuHys5SoQmOJf6ULmZsksg/d8tHEMVe9iL28SpXtX3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIw8cEuX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146C60A2627;
	Tue, 24 Nov 2026 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIw8cEuX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0BA1F000D0;
	Tue, 24 Nov 2026 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540207;
	bh=3gEA9ver3LRZOk45yPCmpz9bhELUsuxLXD8q6tXpL8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RIw8cEuXR3kZnyQe/eo3jKhE6YKJueD7bV8AuRTJ1B2/JE3kbysmYSQaV6RBM2WMp
	 uDnDzRjDrUHefv/zWw045aKLrUPN420hC+L3kpSqAcmsS3w4YgNg9qwLLzlOxM2jjM
	 txG52EFOJW1xRTwM5PRnEnx03kyPL9D4yTMAgqs9rn8jg868vtJZOLLpYbWdlpMRfU
	 NPWjY++MOgvCjpKzp2ZedXUfNdxU1qezGm9g56a6RfIYmHyxFOa2N2uImuGMFtf8v8
	 L78CoPzfYnXmDtLfO2itn3i0tNi2HwOHqxrMliuZL4hFab/xgrzRcfKdnHxHOGTnpG
	 ZS51mFdmbKQ6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B47923938FA1;
	Tue, 24 Nov 2026 17:10:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3] rqspinlock: Keep claiming the lock while the
 queue head is still the tail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179554020654.3659447.12677983340762574773.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 17:10:06 +0000
References: <20261119023307.65178-1-jain.sm@gmail.com>
In-Reply-To: <20261119023307.65178-1-jain.sm@gmail.com>
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: memxor@gmail.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 19 Nov 2026 08:03:07 +0530 you wrote:
> From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> When the head of the wait queue claims the lock and its cmpxchg from
> n,0,0 to 0,0,1 fails, it sets the locked bit and waits for node->next,
> with no timeout. The comment, taken from qspinlock, says the cmpxchg
> can only fail if somebody queued behind us, or if a waiter set PENDING,
> which will then see our tail and queue behind us.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] rqspinlock: Keep claiming the lock while the queue head is still the tail
    https://git.kernel.org/bpf/bpf-next/c/bb5c4dfacff2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


