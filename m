Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94E3C3458;
	Mon, 17 Aug 2026 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957855; cv=none; b=maFFyCsX3kt3beZi2O/LYwfctZfbc5UhIoJcvMOd5EuiJ7AIA5p4PBdkzguwDWvRToCHgH8qJTnFYMa7yvQ7KYjmt5wxIw0WeTXrq0SS/GwNy7rJ9kF6XJZBnMTg3iHk80ffRL2pa04mtSHx0jAIJhTBS2h2ssqsdmbo4DaOqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957855; c=relaxed/simple;
	bh=APpwken6/kn8nPUE5Dl3oYBovFkpIHIiEI6GMR3WFiE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p4IkEVPLlM/ctGgX51VAheOVDVUf4en9v/NEpR3+gOrNp3aN/Ph14evKOL5PCZj1l2HQCA4t6F7L3wPlms4ZJZnEuZnhoxA9KYj8ZwxhbEwrcdVvbZ/lADVRc+7UR9BisfU3wjfeMptjzAS1zC2+8Q8/+u2QGwlbNsG8416nRCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP/FAlgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP/FAlgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB781F00A3F;
	Mon, 17 Aug 2026 09:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786957853;
	bh=gRQSUtkmmSk1F9ZN+pwA6ejx6E7c2c41ltEUjaJV+aY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JP/FAlgRG/5+t91U8h0fpGWDBaQZ7vcl8+qJasbNGmxW0kZTQQh4VsaKtIHrtN490
	 8koYxojyhxSavdXcvgLV7ICsp1nvhhLApmVuMQan/FOSUvHg3kS5CgTOHo2dwPby4u
	 2nTSHviHZTEjf63gQK1hNhX9zEvAQNRH01+PuV0JRTSZRsVpd4VczDOmawqjesALSh
	 ZZMopwI1jc5zQ0KC7YHNJzjUDE8zYeHR+FrG3qj1F2Xe/sMsScGKQUFH8LXghjl9ND
	 PfPTL+AFmx/S/dcqYoeC+uF8C1axLv9/ut6kwPt7RmBE9/ectytCREIrJXbQuUfD5N
	 oThvdv5eHDzfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5680D3924FE9;
	Mon, 17 Aug 2026 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] lwt_bpf: restore reserved headroom after xmit
 program
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178695780590.1031338.13848902843812824537.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 09:10:05 +0000
References: <20260811044149.118235-1-zirajs7@gmail.com>
In-Reply-To: <20260811044149.118235-1-zirajs7@gmail.com>
To: Junseo Lim <zirajs7@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 martin.lau@kernel.org, leon.hwang@linux.dev, ast@kernel.org,
 gnault@redhat.com, fmancera@suse.de, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tgraf@suug.ch,
 rhkrqnwk98@gmail.com, emil@etsalapatis.com, daniel@iogearbox.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 11 Aug 2026 13:41:49 +0900 you wrote:
> ip_finish_output2() expands an skb to LL_RESERVED_SPACE(dev) before LWT
> xmit. An LWT_XMIT BPF program can then modify the skb head and still
> return BPF_OK, so bpf_xmit() rechecks the remaining headroom before the
> skb continues to neighbour output.
> 
> That recheck uses dst->dev->hard_header_len. This is not enough for the
> neighbour cached-header path: neigh_hh_output() copies the cached hardware
> header using the aligned hh_cache size, HH_DATA_MOD for short headers or
> HH_DATA_ALIGN(hh_len) otherwise.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] lwt_bpf: restore reserved headroom after xmit program
    https://git.kernel.org/bpf/bpf-next/c/5fe7007aed9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


