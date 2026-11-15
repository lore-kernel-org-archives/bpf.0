Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708007;
	b=UJNSPe/hVXtkx4Z9FcfhSHsrbKcPwvibm8TiarG2cmP4UmxtKfaSFwmayIO2qmxA3wsZ
	 pnx7nkWAPyoHIt3kHMEPf4DT7Zx9FqJvQL7eqKoiDYtd4TQmISw4s+e0nSh8kK3+a9v1Z
	 Kcq/izQos2ZSN7mdT/Mddnvh+gg2A4aKYnMMYKP4JsK8A5fNTPTgIREy6ffPNhycpyE/+
	 hG9/fPKBJNRXgNerdvt8ZY3urnsj5z+cWFPDLIL4v/7vIMO4OOOg107Wj/vlYM07fv1Fa
	 BMkPdB4NpmX2CA96hb7nnzH56vc8Rr4nn9U8jOyRe4c+XxKGXA00t+qsW18s8zEG0cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=vqdKRL/yHTMsoPPimcjEY+qFG6wFBirzzjYZDhMG/mQ=;
	b=y42AlcXKkjKd0EXiJxmMy+e5Y6UeECQ0RC2j1tVSdHhCJObq3w8zwvQaiUr9zeLzEHBT
	 UpwvMhSYV2UiS0ybCsoBYpCOUcdKa7YYjRfdvCdComlX+IXOIVnbG0TuQ3pc+sXYemnoY
	 27BQDZXfdgTNPdtUMU/Ziou5a0hbCUTHnwLHFSQZbp7bwMrJXD2DOSopu9slfDc/1Bm2q
	 g85eYVBaO3OqkT+XWXpYZouicNB0CS0i2jU6voqCXWrGQR7dPUiyk38fucbTZrCeQdCj+
	 Q2GXQINdm/JoviNeocAGHjlCcCAlHOc+F9GTzJTUvGCsecW9iLf0msEFdNeOu4Zualw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JX++0bBa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C3606A32C
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JX++0bBa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837171F000C4;
	Sun, 15 Nov 2026 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794708006;
	bh=vqdKRL/yHTMsoPPimcjEY+qFG6wFBirzzjYZDhMG/mQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JX++0bBaBNuFLd/SpdaypX4RvPnkgRAfWW3mE0YI/tPFMEGNVI8XbTwRYcNDC6xis
	 qyB4CY0nk4gQkEqRtZrkVQ8H/C0i9lxP+i3KWIvyPChAEI4/oj2XiFYuDvuzJH9yAa
	 vl/J6JaQGSF9lVpAk0Vjpwu2D++Z+sb2zY+XvM96L6aU2jyCbM+MWV4wvgQNxUf4NL
	 5qPHQ5NiPW+ne4SUWncRuVpfHxLffJLdZQv6D3638virdtXHO5xWrvrlzcqW0VyNYd
	 ZDIanxWNaD2rnfUNS26BiypwwqwdGU5/SYBmzsLrFUdREU8bcSuiuphZVfGLYlbFyv
	 Z8MzhTqNOG87Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774983808210;
	Sun, 15 Nov 2026 02:00:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] resolve_btfids: Don't list -EBUSY next to
 -EINPROGRESS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179470800504.2445485.14147273883421189279.git-patchwork-notify@kernel.org>
Date: Sun, 15 Nov 2026 02:00:05 +0000
References: <20261114232754.2732901-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261114232754.2732901-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, a.s.protopopov@gmail.com,
 dwindsor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 14 Nov 2026 23:27:54 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> crypto_enqueue_request() returns three codes. Only -ENOSPC is a failure:
> 
> 	int err = -EINPROGRESS;
> 
> 	if (unlikely(queue->qlen >= queue->max_qlen)) {
> 		if (!(request->flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
> 			err = -ENOSPC;
> 			goto out;
> 		}
> 		err = -EBUSY;
> 		..
> 	}
> 	queue->qlen++;
> 	list_add_tail(&request->list, &queue->list);
> out:
> 	return err;
> 
> [...]

Here is the summary with links:
  - [bpf-next] resolve_btfids: Don't list -EBUSY next to -EINPROGRESS
    https://git.kernel.org/bpf/bpf-next/c/8835113107b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


