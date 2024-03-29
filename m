Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D082C41206
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736429; cv=none; b=c6tqW1kaHqgjyNeT6dsHoRbj/PItsTwE8DDt3EAFaJEqcxCjLtroEyEoWUT/iiteyX3EycYEJu02hn6wkRm4RepEQhILDGYvsKLIMuDlrUaYVb89yNQxRgPjBIqr2r1TtCNEYt8EShAecWpxZxTcW6Eq0giCeRERNbD65mZFTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736429; c=relaxed/simple;
	bh=CsN/M268NdQtWcjT6yHYOOgyvfN8oLh42fsAZz4Q8PY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QuJWc5yEFIXH5dmflL4Kj3KlSSge2Fe5RSEWon9yXhgARbPkhxA4t+xkQg0HMfBHv1BhGgU31jvIx5XRrzV/rXHVbCau/twDuapK0Gqn0g1MaIEyxbO1NMBsx1141HZWm6nVuVpOGwE4FqyNe6Vo4pFbZUS+MsjF8buVnlGXse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQpDc+6n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQpDc+6n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42B12C43390;
	Fri, 29 Mar 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711736429;
	bh=CsN/M268NdQtWcjT6yHYOOgyvfN8oLh42fsAZz4Q8PY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qQpDc+6nr1LWjr9mCjv2Yuptf+4ySwT0HESMOZwFPAqnZwQFUc1cwbf3ADBzHEtA7
	 9YGbYNewQpIfepHDtrXr93oScIW60TNP8XbnbwSxiIOmXIoqKLKQ8a2OyXwM3t0ccl
	 PUpyLYG569HYl0V9T3D8kD/gijA+Mnd8vHRIAm7CJMqwRsuib55xs4S7vFSLkf9xHs
	 gHjFHdEPmFf/vYc3lJHRO2vFDxkIgkLva94NO9eDAhoGPyC7VkiJrfF6OcCFGOrP31
	 CGqr7t8amWCxfGJXt1OZUgdyswJvXdJsMuOvCeoo+J9MMKs7JdZm0iaK5sRi01qnaj
	 azcQajy7fwgvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33072D84BAF;
	Fri, 29 Mar 2024 18:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Avoid kfree_rcu() under lock in bpf_lpm_trie.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171173642920.7934.10045055948482690211.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 18:20:29 +0000
References: <20240329171439.37813-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240329171439.37813-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, eddyz87@gmail.com, paulmck@kernel.org,
 kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 29 Mar 2024 10:14:39 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> syzbot reported the following lock sequence:
> cpu 2:
>   grabs timer_base lock
>     spins on bpf_lpm lock
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Avoid kfree_rcu() under lock in bpf_lpm_trie.
    https://git.kernel.org/bpf/bpf-next/c/59f2f841179a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


