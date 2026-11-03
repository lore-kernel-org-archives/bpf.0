Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728806;
	b=CG9T0Vf7e5GWFrBkBBkPu4GGOESxgNlhxcAC+qy40JuCv7In/dxWFbM/0yNoLXrtmckU
	 JYmP8jdvmdTJdoffdPOM80GO6QAnc3qNvd9DgV6XqVwyXTNnq1pS/bLkuhKjcCuuVNqCf
	 ganHOQGMDG9m7ZzPPM3uEY8T+1U+JwZVnn9L6wWbzoTy9s2Lqp+z4+rL8oB8bwp/Mlymq
	 dSsvxqrh4yMuFRAL7umibegwl9pAKi5k7bpMgy9zCkrp2mjQKTBV0oY/msRNCBHNbmMHs
	 JTatBS6e4ABefiR5YN27j3NgpHfqPbwM1OqA221GrMl7UlC1LPewFMgrEvUTeWc1tLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=YTkARBxcnEZ0VhZf1m5BzLHjfGwoOVBuR1l/AQHqM/E=;
	b=2bunUIjqpyFuP8CM2Sk+8OvBYTpNbPjTDMEnRv2R+dlp3DfLe2wstR1rjvCXPgGqLxki
	 rl0Ww/TeoEMEDVgDlNVVD8nEF9pLyhA+iQtNMPNbIwEZ0Ktly8ADkZZ8BwixNkBwayTCP
	 8L+vxOWyeSpVigL8lNpQWpyPnc1cKuQydJASixkMSa+Hye/Htwy6/UcTv9KznzvnoIjZS
	 JJUIBTv/Ak6oFHA423SGnDKZ1THqn6lV24jx/TL8/meRVUyIsirasV3ErxewWSSPoa45d
	 SNDk7kLooxeX9v72CzBpw91RfH7ZSLLpgjY60nil4Drtt4LWvN8GmWNYbIBDtbLcMnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+qRSXqj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB8606A336;
	Tue,  3 Nov 2026 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+qRSXqj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96821F00A15;
	Tue,  3 Nov 2026 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728805;
	bh=YTkARBxcnEZ0VhZf1m5BzLHjfGwoOVBuR1l/AQHqM/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l+qRSXqjBOU6b9voI284qhIym3OjJ5Ub5zJ8D+2BPimgXZIfM5T7q0ytkTIBFUbQd
	 yBE1pTSRSkuW+vw6HVZ2b9Hs5AuOM+ks5axBeZB0KoEPrbJfmd5aVO6MCNKTM368DW
	 i3VWRLabsJeW8T55C2zofYshV17BKyg9YGYbsZO1RqWxGnJXNTYF9fKnPzP9/KejnE
	 jbwJoqmbOOrNdOyNOOKCiUxNebGvKKWmLhLLK4zULbZI8a97uvtswaaDPB2cb7e79Q
	 cqfV5/HbYWmmQ4HrtD2dismCq07MvdhNXWCOf8DFYRHVB9cS2+W+HGh9ZaDEQB+dtE
	 M/QISutLt3l6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3AD391B05D;
	Tue,  3 Nov 2026 18:00:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Wait for wq callback before
 checking ok_sleepable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179372880430.1789085.17442312615310537765.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 18:00:04 +0000
References: <20261103-wq-poll-fix-v3-1-8e7b38f5e71f@gmail.com>
In-Reply-To: <20261103-wq-poll-fix-v3-1-8e7b38f5e71f@gmail.com>
To: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 yatsenko@meta.com, qikeyu2017@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 03 Nov 2026 10:21:38 +0700 you wrote:
> From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
> 
> wq test fails with ok_sleepable reading 0 instead of 2 as workqueue
> callback hasn't executed before check.
> 
> This happens as callback runs later on a kworker and 50us isn't always
> enough.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Wait for wq callback before checking ok_sleepable
    https://git.kernel.org/bpf/bpf-next/c/f2b22071bf84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


