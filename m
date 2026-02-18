Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB52D8391
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771376414; cv=none; b=BWK1o5XPOHlTO5k23s8UzFvi/5hrddCYzPF4Kfuv+Ow3m9ZpNuh1UePNmBQXBC4Cr7NfrBXVdWC7hr2AqTd4HSRJfHBrn8KKgKo4CfKh3VoYMwdKslKpwcSgQylCMA7KB56yw6LMboUAOng5lr6a8pTk0BLUrdAiIFzHIT6x71E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771376414; c=relaxed/simple;
	bh=HE53nnDgKeWTcz/o5syfG2ommipAi8x9Pp/j7tTB8w8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XhgW1tTcwkJJdp3gtrYozTWHrxonfiqXzMHyM7cNC6FUxAVNknWyIwL1LNqPtHdIh3E61/Yj/zBzCE4P8ePpRkFMOVKZj6AodgKsUK23nyRbQ7g8ZwwrYxrcs4WUh/v9Knpb0OCZKSQHPbuKB19imVUoFb5msxa9Dk6zAdHAQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSitgO/F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSitgO/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C39C19423;
	Wed, 18 Feb 2026 01:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771376413;
	bh=HE53nnDgKeWTcz/o5syfG2ommipAi8x9Pp/j7tTB8w8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gSitgO/FQZhq7qw7ChAfqVTNQr3M5hU5pjzwzfpryQ/P0DY9FYBevFgoGAz5tzcHT
	 Ws+1vL0oozlxm9sGvk74NRpjvXhD2zlaBzdqgpO5RMUpqgx+xATMKP6bOt5i3rzGqA
	 sLdt+EdMKEbycRLifh6nnVsX9+5YbYsQA6XoGRh9GaxgHg7n6PpvWG8b090+22N6Sa
	 fw7X823Gd/bQwNW6Gm6G486L3uLS1D+dlLccLRLKRlb4brsIjFbHFj3aNOaLjB+/kz
	 h2s7RNY++w/dn0AltJFPRvI9z7/F1aS72ewUpqxxhozFT5BWlgUXbZWhVoCExiptts
	 LWkLTpttchPmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 852273806667;
	Wed, 18 Feb 2026 01:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] tools: bpftool: fix truncated netlink dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137640533.760690.978400683999368126.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:00:05 +0000
References: <20260217194150.734701-1-kuba@kernel.org>
In-Reply-To: <20260217194150.734701-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 17 Feb 2026 11:41:50 -0800 you wrote:
> Netlink requires that the recv buffer used during dumps is at least
> min(PAGE_SIZE, 8k) (see the man page). Otherwise the messages will
> get truncated. Make sure bpftool follows this requirement, avoid
> missing information on systems with large pages.
> 
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Fixes: 7084566a236f ("tools/bpftool: Remove libbpf_internal.h usage in bpftool")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf,v3] tools: bpftool: fix truncated netlink dumps
    https://git.kernel.org/bpf/bpf/c/3b39d73cc337

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


