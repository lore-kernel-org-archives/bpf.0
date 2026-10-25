Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792891808;
	b=EufaF80XPEYcraxWsQHaMDOIhMPaJa+/9Wuyy4/lHkYKUDy6A9z0Kx76MElbtk3QB/Dh
	 2lpzjueoX9SbZhLyjTqynvrEEVtmJK2e+drACQRcUjUFTS7wJR/jCLbpYEWZ8Y4rQCBYH
	 ZDkdbyYazljvQmjmPlFbFgxn7pyqxm/Uqf7jQUloNdMVUiR3MIS4nubMFh2ooWskEKX1f
	 ERYLVbeS1ccaDuFm3OTPropXQ5ynnehO3EBbT8rlnUwUrUYr8OnNS2d9lY0vVL52iO4kg
	 zRFFXiqqJCOdzzHqe4Ymr3nxP4aiSJ1mfc7gfoVTjbSWp81yUTD7uLChnegac2p2RWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792891808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xGjNp4tGG1tER6oz8MN3+BRtXOJjEQloElrhYvwXrFU=;
	b=XvLTAZfA4UoF5cbkIhXDX+Qxu3EJGLss/y97E9RJBtwZj/vMQzXJXPruCh1sgKiUK/Ht
	 UfeuZfk7v7zpiegaLH/VMt1MNSaTRmlToFpURsuXis0rKq/ItuesTeQZJBvt7cbvqQvKF
	 GCpbfm3DfONlc2zQIDbr0FNw/8bXYIYD4PfA+h7XXZ7R+rSjgrRpySJnjxXi82i3fKGuN
	 z/XgQ+wdADS6L+kqBlezTvJ8B1UlfSeauniTheC/0yg4JZuGI5N2RrYmhs8OC+lhuwGzA
	 AAirnRdgPsq4f/zMdLgM75ensSje1o+idZPOALAU8R895GpEqWQVHk2CShn3s/ObFkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXnbUdbg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA6606A31D
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXnbUdbg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C171F01825;
	Sun, 25 Oct 2026 01:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792891807;
	bh=xGjNp4tGG1tER6oz8MN3+BRtXOJjEQloElrhYvwXrFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lXnbUdbgC6kKlVZ2mEK83OeClerJQdE+7icoCQdsBW0S76f+YGUnl8Z5g4wcWFJWB
	 lAA8x4skRzM9vFLQ/Yccr5R8eYMoq/ZTfDR6WjGnC+kn4OimogugWz5aXeSnw9ZipF
	 xUbyIaknJU3X9GriXuvS+2o92pBAk7+IDM3NANubcT4uZB2/bwiwAd09wXc5cV7H0h
	 Q8Jk975dG3RCfNWJhNBtRc4wTVs5XECiSaHmLTAQY0WLHC58Ud7t5ewilOfkrdwdLF
	 ewqMwwQpZIvB3dPNmurpUmKU1J8JnrVH5VUOUnsXm3kXPkx24U5tzhOlny5E/nmDlP
	 rB0p7eHjCJXUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8158E391B1B5;
	Sun, 25 Oct 2026 01:30:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v8 0/2] bpf: Track borrowed iterator result
 lifetimes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179289180632.1858530.12978151582222219070.git-patchwork-notify@kernel.org>
Date: Sun, 25 Oct 2026 01:30:06 +0000
References: <20261024100647.2579244-1-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20261024100647.2579244-1-xyx2021@mail.ustc.edu.cn>
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, ameryhung@gmail.com,
 yonghong.song@linux.dev, puranjay@kernel.org, utilityemal77@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 24 Oct 2026 18:06:45 +0800 you wrote:
> Make non-RCU, non-acquired struct iterator results borrow the current
> element lifetime by default. KF_ITER_RET_INDEPENDENT marks the explicit
> exception for results whose lifetime is independent of the iterator.
> 
> Trusted field loads and dynptr constructors propagate the source lifetime
> so derived pointers stay in the invalidation graph. Next preserves the
> iterator itself and invalidates old dependents before both return
> outcomes; destroy propagates outstanding-child errors.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/2] bpf: Track borrowed iterator results by default
    https://git.kernel.org/bpf/bpf/c/d09c2aa3109f
  - [bpf-next,v8,2/2] selftests/bpf: Test borrowed iterator result lifetimes
    https://git.kernel.org/bpf/bpf/c/2d7eaeb05ae2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


