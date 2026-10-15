Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1B4A3D30;
	Thu, 15 Oct 2026 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051808; cv=none; b=GS0mZgb357Z3Ro/c8VmwR7vQIzLrh5tjBO6xIEKNmD8PGzrxpsBQbrsq5KdOSe7u7dICxJTiFZSuzNMSmsBDkRQYzxtUR71P9tu2/I0V+0okS1krMiXzzRU9lgDcnYxOzY4MTdV64+ToWVZuH5RZRIysHKt6Libr0tpV6mwotF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051808; c=relaxed/simple;
	bh=xjijsB8rY6sxIYpMvIGFZ9DMiK6QWjX17nb23UsDA0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V2k/7jzqkPmBTGo2Bzs/tIxUto2OoetF0HZFEF97v4N28OZovX8JgHxV9W2q4J+87i+g21g5gRbGTFD9fB70HTycsMP+c6lsdgtn1Bdm+nAmxE7Aa4TZj0Jxxkx/CpLPUK2Xck96TpQq9sV/aHg7lqSYCdd+57dLx495e0qpeAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rvci+xoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvci+xoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC39D1F000C5;
	Thu, 15 Oct 2026 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792051807;
	bh=bl5NItzMKkZgIBLCpRhYFYJU7NSCllj39ip7UM5IbjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rvci+xojxjY1e98+iFO93lu6DAufz8QrmKVTp00zZR4BcIXuDQ1VrNzTyIP8JEk5T
	 M/Jz39sei/uRvujHafkDyeVecO86c1umg3+UqQMiOXIwF8zCSdliXZ+TEUMzPUaWkW
	 OeOT+6n8tA33piMVLtAw1UOYMmBHG3ZLKSzEnWzuFs4SC2+n+XDMWwYPJW1F+fYZ06
	 dXNpK9XSoLVInrqerepcLyS30x4emOFfSitzZnMpxgtv+n3gS8aTqTW+ptkUQVlFd0
	 3HIYpc8s4Ou5l92Wjw954MFWrUNc4ZUXp2aCyqtKFQZ0iG+DDaem3d0RJi0/f9kNSq
	 j3aTnKuiNRH5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4320392E9D9;
	Thu, 15 Oct 2026 08:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Use its own netns in
 flow_dissector_skb_less_direct_attach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179205180628.3264110.7111063337617892078.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 08:10:06 +0000
References: 
 <20261008-selftests-bpf-flow-dissector-netns-v1-1-5d9889aaad84@gmail.com>
In-Reply-To: 
 <20261008-selftests-bpf-flow-dissector-netns-v1-1-5d9889aaad84@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, sdf@fomichev.me,
 alexis.lothore@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 08 Oct 2026 22:02:39 +0800 you wrote:
> test_flow_dissector_skb_less_direct_attach() and
> test_flow_dissector_skb_less_indirect_attach() each create a netns to run
> in, and test_progs may run the two at the same time.
> 
> Both name their netns flow_dissector_skb_less_indirect_attach_ns. When
> the two tests overlap, one of them fails to create or open the netns, or
> loses it to the cleanup of the other one.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Use its own netns in flow_dissector_skb_less_direct_attach
    https://git.kernel.org/bpf/bpf-next/c/76c1913f311f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


