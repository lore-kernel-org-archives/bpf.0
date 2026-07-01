Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795BF3BB67F;
	Wed,  1 Jul 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936626; cv=none; b=SXM7PykTpUuiRqrHxUyP6dM8TVGWo2WspnLDzBPHou3u2txDddEanojaTjHO1DvWuYb4FK7mzTRpMjJxUVvMVvyRSfRhzpJKX0GrR6XTsXfcm3xDnDvUOks85OLmWw2dqdZ6Ykc9wCkI0xwAo6Bpux70jYadz+p4A8Y5YLSR8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936626; c=relaxed/simple;
	bh=0noMDwCMu34Lz/ngTph0vgLOeRVJ7GlIHp5vQZl68Aw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cQ/401gMt/M+dlU/GgWG1DkiMrrs57nwKokyYvb4YfMsFDtUyw/ysRzfaD6oBhnE8MUKMPP8zpnih20Q0BRSdzLldlsPsk9Jb3op89U26Q0sLKFpdLWMRz7EmY548LQdLbVxOwEENZ0QQIluf81MS3tG69GznPiaYe5NFEHqplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgFnXSxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgFnXSxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A72F1F000E9;
	Wed,  1 Jul 2026 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782936625;
	bh=yZeyX8nbUrPFd0IWDwrGEth1c6tK16aRA+fBBBONStM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GgFnXSxWXC0i1wuOBmJ76cdbJbbLnK4WbqLMGxJAukDMSrHV3UoNj5ohEVL3kKVN4
	 gaaFXXnu54eprwJ8apC8BAZx5RKOdpKtwIOeFpXRutFPOjm0hf4WU73e4JRhuEj05q
	 q0N8sWfWZMhrOwUYP5R57occVAkVKsP0skwp5lo/lDBXK759WZQmMGHiZWzVwrQKl8
	 8E9wr6OJ0TnmVwTaZz2kPuER17pYfnlObS+BG42c6iNpzQdVfWX+FWDC6N6Q9oq7G5
	 keo9cUecJ5QDjBwKJ4JICsGbx1m3Ha21UVhkZJlLnU5oVae+1vmam10rGge0xhpTL3
	 XJCJohuqJanfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398C383BA30;
	Wed,  1 Jul 2026 20:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix test_maps sockmap failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178293660813.1278318.4274170682804829324.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 20:10:08 +0000
References: <20260701071501.39628-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260701071501.39628-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, ihor.solodrai@linux.dev, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org, axboe@kernel.dk,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  1 Jul 2026 15:14:22 +0800 you wrote:
> test_maps fails in the sockmap test because sockmap_verdict_prog.c
> drops the packet when the first 8 bytes are not directly accessible:
> 	  if (data + 8 > data_end)
> 			  return SK_DROP;
> 
> The blamed commit removed bpf_skb_pull_data() from the stream parser
> program so that the parser no longer modifies the skb. That was needed,
> but it also removed an implicit side effect: bpf_skb_pull_data()
> linearized enough of the skb for later direct packet access.
> 
> [...]

Here is the summary with links:
  - [bpf,v1] selftests/bpf: Fix test_maps sockmap failure
    https://git.kernel.org/bpf/bpf-next/c/27a0f3635d86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


