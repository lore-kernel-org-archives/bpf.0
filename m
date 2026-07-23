Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E6435504;
	Thu, 23 Jul 2026 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802651; cv=none; b=iUC0OfczT4/6wBB+g9WiD4kFUBRgdqMh6VzuqXYNE6tUWtq0xOoC0Rfxhpg+os2uWsv5/I4CaZNjNu4+BwAlmi0SLVzVEvoZlROJrfVlOpm+Qwg1m5N2m7qu44mULj+pIyE8mSI0pQnrtWewj+yKe/o3InGLcS4xNdKJ7RL8Xg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802651; c=relaxed/simple;
	bh=ASQWPFUUAoLqZgqtMMqUcI4jebwaHdb6C9a3ohbr5KI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CJTKVdFY6oZyK5YEzpvFOcJ9u38lpjgmeMgrIMG58J6sHnHLh95HbOB2Bqd0D6995omZ6pUpv55xsRfZEYtYwLjmIhfjBDfZjD9OnyezPfV+N7eSBAU7kUC5Va4hp5JE37ITWFnhMcIqqhO8hhZ+28Vq4bgCCuzhHEVjvER6e4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJQ8SHKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJQ8SHKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5AE1F000E9;
	Thu, 23 Jul 2026 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784802642;
	bh=Yw6JxDO1FOBKqYV8vuSFenZKuBcEU2T/wEe+2aBhofk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eJQ8SHKLuHR2QzIwyW9H4LbwrbbQNz0I+kUppH3CS1Udvd6M0dVqWEUlZUfrFQAY6
	 RxAehYmxuqBTLnm3q2mpclkvmRlXjBumfOkPQUPRv0XME8QzaGqy74jciAIQWhM8dm
	 NHaGhCOC/e+/7ziHVNIGv41wHnWuIpBpi5mpZx/0KRvQ8JqObQJv5Yj0n6TzOOi19n
	 gDcpuZBZWGMS5pzDw0LoptmskEu9rcBAQirnOWK5TgxBPEixlMo7RUqrsAbXT7eued
	 H+x81G1QYLez2bwsjdQGPGtkZG2jpquQdf2KEHVIylXTintHak9c4kqSEP6+oKstB5
	 AJIexbROs/o/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B68380DBFA;
	Thu, 23 Jul 2026 10:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bpf: tcp: fix double sock release on batch realloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178480260615.2224243.6176040937478238105.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 10:30:06 +0000
References: <20260713233230.3553593-1-xmei5@asu.edu>
In-Reply-To: <20260713233230.3553593-1-xmei5@asu.edu>
To: Xiang Mei (Microsoft) <xmei5@asu.edu>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 jordan@jrife.io, martin.lau@kernel.org, sdf@fomichev.me,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Jul 2026 23:32:30 +0000 you wrote:
> bpf_iter_tcp_batch() releases the current batch via
> bpf_iter_tcp_put_batch(), which drops the socket refs and rewrites
> each slot with the socket cookie, then grows the batch. cur_sk/end_sk
> are kept for bpf_iter_tcp_resume(), but on realloc failure the function
> returns ERR_PTR() before resume runs, leaving cur_sk < end_sk over
> slots that now hold cookies rather than sock pointers.
> bpf_iter_tcp_seq_stop() then calls bpf_iter_tcp_put_batch() again and
> dereferences a cookie as a struct sock.
> 
> [...]

Here is the summary with links:
  - [net] bpf: tcp: fix double sock release on batch realloc
    https://git.kernel.org/netdev/net/c/980a81345275

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


