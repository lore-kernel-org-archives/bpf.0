Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3FF2F39C2;
	Thu,  9 Apr 2026 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766630; cv=none; b=K2HYYlkhYT/Fo7PHys+l3i1JnmsykqQKh7PVLq5pSBQ+UFniBqhRStShGqRNffktnozdhMluLRxHa8j4aIiB5DhM/SSXgqOSU/OPZ701iMCuwMCSjxXrDe1CycXzQ6aqDdXF/HgBMVI+di0dq8W9UzV+tX84LssWAe1Kxt5qCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766630; c=relaxed/simple;
	bh=YuFF0row2xbw1GIj/sy7Sd+bYuSOqtTAR9QJHHBt27M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kqfc2nJoUHaoZHjidD4vqTXuQn34X6h8CN9SEpu2SWBVD+8KfiZGomaPyzlKf09pegnYGDXid1RimDoJOhkfBHssvj8cCUsYpydK6kUMODyoMYMZImrFTjv1m/a7mqJ9IJ3NCOQiUW/0GHUtzX8bDmltNeMQ2KCWWlJ2DGYuFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NF0u/wPa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NF0u/wPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE03C4CEF7;
	Thu,  9 Apr 2026 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775766629;
	bh=YuFF0row2xbw1GIj/sy7Sd+bYuSOqtTAR9QJHHBt27M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NF0u/wPaniW9nexwAkqokvWZONOeSSwxxaiQqTGC4esQTUjGD4LtamgYtNsgNfmUM
	 0Tv2AebBi7737dasyi0P2j1tZyCOncehlcoURu6kuWQ0xD/772wbJufAwtNo/zGlBJ
	 O9wdwaSOr/cL6vk44e+me+I8ZfDBIbMRzNc2ESRZmJG8OAMKcvHrfnEQMhDFwhump2
	 HA2MoZ9lUF9cs5c7Sjkz+jt64KfooqGsuFMxQZG9sEyfmNAbfG4WHuGVgr+vJX2MXh
	 2l/McuDAmaukfFHkf2QAteIiEY9Fl5pAeTvvJ76L/2dvP/vHHooVkK0lfogG5MvazE
	 r5IWal5d1/1xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDD739308B7;
	Thu,  9 Apr 2026 20:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: Fix use-after-free in offloaded map/prog info
 fill
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177576660531.1728013.12983748791423250538.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 20:30:05 +0000
References: <20260409023733.168050-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260409023733.168050-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, dddddd@hust.edu.cn, M202472210@hust.edu.cn,
 dzm91@hust.edu.cn, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  9 Apr 2026 10:37:32 +0800 you wrote:
> When querying info for an offloaded BPF map or program,
> bpf_map_offload_info_fill_ns() and bpf_prog_offload_info_fill_ns()
> obtain the network namespace with get_net(dev_net(offmap->netdev)).
> However, the associated netdev's netns may be racing with teardown
> during netns destruction. If the netns refcount has already reached 0,
> get_net() performs a refcount_t increment on 0, triggering:
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: Fix use-after-free in offloaded map/prog info fill
    https://git.kernel.org/bpf/bpf-next/c/a0c584fc1805

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


