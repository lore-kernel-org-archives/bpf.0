Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945329ACC6;
	Tue, 24 Mar 2026 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367426; cv=none; b=o5YHDEpYI+mP8Zye9DL0Sk5+ltsYXKHVUmi5m+D5qR3q9FoCJ0S+rlV5gs+JGW6kkInJRhu+PzCaLKjQA/zn6dfGELafOps1hk/NnBFh20u32YqsauyGG9yL7/W3rOuciy+W0m4fRLY+3y40mtRoE9Nk3PLfC8jy7at2F1HrbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367426; c=relaxed/simple;
	bh=m7nheoxle1ZXzLpwp5582EdFiDQ7cc3yFO43iKbRpPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JPg5XEPzAyogogFlUcPZofyUJO4B3KHAOqzDymsJbFcb7r+idX6WeupOlQta+oBKXtW6AJGg2qyhhMVzdgI2ZKYuNeeR18fjCQpdBCNVUjuIWarJVXsaEZ9UR/t0+VK/AWbkaiPnTETRMq+T2PPBmAGYk80u7UEojAGnrctRJ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eajV56u3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eajV56u3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF86BC19424;
	Tue, 24 Mar 2026 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774367426;
	bh=m7nheoxle1ZXzLpwp5582EdFiDQ7cc3yFO43iKbRpPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eajV56u3m8M/vYcZUGSTazBtaZ8RODjwgVxthjWNpm35nt+oIFOSJNln8g87p6BIH
	 wtN8yw5cRgs+tPNEAxJmpoNUDJY9v3A0WMxcXG4JMdPI5RYAnUfZT0UHan0/Rm3qRW
	 sUwYM4HehB6IRPWvKOOM5H5giPyB6hZSaTu/qoy3ySKJmXvWGuS9JBmVsgqZolswvu
	 xgR/hBHhTVS89A8t44tROzI4GDvE3kyser4VNali1g3qc68qADZgqORKGm2VdJsnn9
	 7pcg6w59zQ7GPcQ0tTfjDpXT0r566o/n8z1Ob8umwHF+nkWHdiF18fsgk6JEy9rqVc
	 uvUwp1+mHY42w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CFC3808203;
	Tue, 24 Mar 2026 15:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Simplify tnum_step()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177436741379.1084685.742970732574986773.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 15:50:13 +0000
References: <20260320162336.166542-1-hao.sun@inf.ethz.ch>
In-Reply-To: <20260320162336.166542-1-hao.sun@inf.ethz.ch>
To: Hao Sun <sunhao.th@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, paul.chaignon@gmail.com,
 harishankar.vishwanathan@gmail.com, shung-hsi.yu@suse.com,
 john.fastabend@gmail.com, martin.lau@linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Mar 2026 17:23:36 +0100 you wrote:
> Simplify tnum_step() from a 10-variable algorithm into a straight
> line sequence of bitwise operations.
> 
> Problem Reduction:
> 
> tnum_step(): Given a tnum `(tval, tmask)` where `tval & tmask == 0`,
> and a value `z` with `tval ≤ z < (tval | tmask)`, find the smallest
> `r > z`, a tnum-satisfying value, i.e., `r & ~tmask == tval`.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Simplify tnum_step()
    https://git.kernel.org/bpf/bpf-next/c/833ef4a954e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


