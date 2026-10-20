Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527016;
	b=qTuN5KLmYZHG+Q+ygjG07w23scVd6t6x7ykbOrLWxO5cbY4zZpp+A1JKnolsCH/cSrNc
	 gxW5ai/Fz6EV/TZDyNyxJG6NqQZ9a9mDOSMx0ZFa9oCi0bVLPEaq0J6hQ6eFRoz/Y1w/R
	 3HRJZt/glqlTA2avLeR1t0Ezfkk4YN57fOSmxx5wmR1PsP1nMYI2dAW2dj+QY4A/rnmVF
	 umjicIBKXy4MGZS+AbB2hg8gvUloEyO70wsv5K1qN1xi7mQDfws6kCd60Y0Ph3q6XXqcz
	 RL0mgSqVZk1Nqu0mWg7khaQNYWoxLXtpqCQ+NaegG8YwBKaEzP5otZe6x93s/Uds3mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527016;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ScSEejHb7NfkJGEdOKnoYcp0hYXqiNV3pa9I4r/NVRA=;
	b=i/Kd65M3OaM0gT46+5fOI1VqCda9G+EULSjRYpIDqPPvD+l1/e5DxLrXANrgn5DUS5lB
	 uYwmv+HsgT/OHGBrN/iKDAgQJzuQgIwd8UN8LvDZtaWCBcLYDzaY3G1gcZGJcLqR1YcQx
	 6x0ENWvrRwSYiUHT7aEnaAVoewz0Y5EENVvjtKTRTDXbU0NsyLSizrA47AlRKrOYGwGCX
	 f4lUEn+gaLCLf6FowcUoUpMgDeq136KpABmzcFM2k5yVewq1OKF0efWRVv9eqrexe0pjv
	 NFmLqb/mTGAnNZ+hgHK1Dm9/nhpzFnZkVptWrvQQzLuli+oADHMz0UDaZ1917/UB04g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8GsMGGo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D82606A31D;
	Tue, 20 Oct 2026 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8GsMGGo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E4A1F000CA;
	Tue, 20 Oct 2026 20:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792527016;
	bh=ScSEejHb7NfkJGEdOKnoYcp0hYXqiNV3pa9I4r/NVRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P8GsMGGo3DblBFQoa2N3IJZrY6HTLhxiERLX1AhlzXJp6bnLZRsVK4Vhj6pRVBW+j
	 vdwVnU2RTp75Q1w5i5mXQAdmEjFZ3KB0RSTyKlVTmrjh/EuVtpPR306NMoPOCwtnve
	 xEGTr1J0tQhxAcRf+fE7zPvnd2zpDUzakP0oH308DCaBtggg19dowst4pFQJESJcjm
	 DID1TH86cOQLgzyOvVRZQ+KdvrIZwRuOmrmF2dOjtXrpzjZyvQ7RfZK6WDCvRxh1Ss
	 CyqDJYQaMjZO1OBWCQS1WftNsUWodazTvdGMDxqes5ctoi5fk3r5OV/MITsJuBcHI1
	 rVSDFyAVq+tNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14AC3809A09;
	Tue, 20 Oct 2026 20:10:15 +0000 (UTC)
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
Subject: Re: [PATCH net-next v3 0/5] net/sched: reject oversized action dumps
 and
 cap unbounded entry lists
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252701452.186787.8173064049574810392.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:10:14 +0000
References: <QDISC-H19Z.v3.r0.20261012193813@mojatatu.com>
In-Reply-To: <QDISC-H19Z.v3.r0.20261012193813@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 bpf@vger.kernel.org, vinicius.gomes@intel.com, olteanv@gmail.com,
 vladimir.oltean@nxp.com, p@1g4.org, eadavis@qq.com, dcaratti@redhat.com,
 sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 04:54:26 -0400 you wrote:
> An action dump is carried inside nested netlink attributes whose lengths
> are u16. When a single action's dump does not fit, a plain nla_nest_end()
> writes a wrapped length and the kernel hands userspace a corrupt reply; on
> the classifier path the -EMSGSIZE this produces is mistaken for socket
> buffer exhaustion and retried in a loop that can never succeed.
> 
> Patch 1 makes every nest an action dump can be carried in fail cleanly
> (-EMSGSIZE) instead of wrapping, bounds the tfilter_notify_prep() retry,
> and stops a notification that cannot be built from vetoing a filter or
> action delete. Patch 2 stops an action add whose actions were already
> committed from being reported as a failure when the notification cannot
> be built. Patch 3 caps the number of gate scheduling entries at 1024,
> rejected with -E2BIG and an extack message. Patch 4 caps the number of
> taprio schedule entries at 1024 in the same way. Patch 5 makes the action
> dump report an action that cannot be serialized into one dump skb as
> -EMSGSIZE instead of returning success and silently dropping the rest of
> the list.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] net/sched: act_gate: reject oversized dumps instead of wrapping them
    https://git.kernel.org/netdev/net-next/c/ed9e404dcf9b
  - [net-next,v3,2/5] net/sched: act_api: keep an add that created its actions from failing
    https://git.kernel.org/netdev/net-next/c/1a49567560a1
  - [net-next,v3,3/5] net/sched: act_gate: cap the number of scheduling entries
    https://git.kernel.org/netdev/net-next/c/150167ea4d7a
  - [net-next,v3,4/5] net/sched: sch_taprio: cap the number of schedule entries
    https://git.kernel.org/netdev/net-next/c/2bc124a5f8df
  - [net-next,v3,5/5] net/sched: act_api: report an oversized action dump instead of silently truncating it
    https://git.kernel.org/netdev/net-next/c/10a486c17dff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


