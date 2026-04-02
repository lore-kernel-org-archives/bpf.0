Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB551F7575;
	Thu,  2 Apr 2026 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161827; cv=none; b=ji7j6jrRW+o6FMB4bCgRzUgk/tHJtou+O2q6hnWzgogVSjmINWHdMVMutx9TXvjk3GzvSqLgnRmnngvTF6Po+JPZrJSUbwJhVpxDK0Ns8Yi66MPOkJn8c7B3vxysTcP0U9b55M21O3ms71MVGkWGWB+xE4w5niVPuNnhnFSLBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161827; c=relaxed/simple;
	bh=onzn5soQ8SI5RtgTGNOpWEEtCO0mzbfi8iMp2h0fnj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PVr34AmNqtnd39EIqFejzhf8lszJo4IlWcscGvawkwMtS/oW2a60CImVgLO5xdo9kQLBtYKqZATdWpAG2Ijd7MkhFMAvNbNZlsrDdTPbEl418PLu2XSC8uYa8IW7UIpwplV7J+vKpb4tbvfHICF1Yc/XPgNHEzxy3Z3ATs9S0Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R86BR4qW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R86BR4qW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427AFC116C6;
	Thu,  2 Apr 2026 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775161827;
	bh=onzn5soQ8SI5RtgTGNOpWEEtCO0mzbfi8iMp2h0fnj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R86BR4qWx8S0BqdfIYXKPY4f9Rfits/tisuHRSr3AES5KVJF7eB8R4nrDDhs6ni+D
	 zAQjwA5buxDuj7RtazAYKB5Wy2ToEgOf+wOObILNK95JEAtTUz2bOvleoNL7MT8N2A
	 jK9PtXa0sxSWZmKME0Re4KZmeKhlkhHti+5trc3rEHuwZTVWHGmtiG4zeQZmuBhhyq
	 gGriiRlw1tTxe2dob2AqZGegiSe65NV7MRqimFawGroy3dpJt+BEAa8SVqid87v7vP
	 KxIZ1ywgeyILEQ7FV1mEC4kmtYq7ikqR/iX4pAzbvKM0ly5aQQRB6EmA31YfjIRNLR
	 WB9wLB3WTSPeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F5D3809A09;
	Thu,  2 Apr 2026 20:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/3] libbpf: clarify raw-address single kprobe
 attach behavior
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177516180954.605612.3114427119348580758.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 20:30:09 +0000
References: <20260401143116.185049-1-hoyeon.lee@suse.com>
In-Reply-To: <20260401143116.185049-1-hoyeon.lee@suse.com>
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 yangfeng@kylinos.cn, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  1 Apr 2026 23:29:28 +0900 you wrote:
> Today libbpf documents single-kprobe attach through func_name, with an
> optional offset. For the PMU-based path, func_name = NULL with an
> absolute address in offset already works as well, but that is not
> described in the API.
> 
> This patchset clarifies this behavior. First commit fixes kprobe
> and uprobe attach error handling to use direct error codes. Next adds
> kprobe API comments for the raw-address form and rejects it explicitly
> for legacy tracefs/debugfs kprobes. Last adds PERF and LINK selftests
> for the raw-address form, and checks that LEGACY rejects it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/3] libbpf: use direct error codes for kprobe/uprobe attach
    https://git.kernel.org/bpf/bpf-next/c/f547cf79475f
  - [bpf-next,v7,2/3] libbpf: clarify raw-address single kprobe attach behavior
    https://git.kernel.org/bpf/bpf-next/c/e1621c752865
  - [bpf-next,v7,3/3] selftests/bpf: add test for raw-address single kprobe attach
    https://git.kernel.org/bpf/bpf-next/c/9d77cefe8fcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


