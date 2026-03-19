Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61E35A933
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951015; cv=none; b=ZT45SlnbBlscqd5QN8bxkAbSU9SorHklt20qzzsYBW9FmXiKGxbdBVhEnfiT7OMe2wOIwfd7xzjejWK9aBpUfEHWC4GqIYOL2tBodzUzCJN+QTodLMOKftM++9OI+H72FLsKZuY2PFjxSA0bD1Vc3QUZWX4d9qboDLJFmuxHZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951015; c=relaxed/simple;
	bh=B3QQrlzQBt9mOhwgv7UXmdIEFVKfHBgUY53wL9MuFW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SHzS6LRr+tojGJTwLIW9nuRkImHOEdso/Ojtltz5r+czCmnfJTiex8oapNRBzuydYkHXJyhbBQA5UiO3FxxQ1vr0PWo9p/cB3NM3aFIGLpSyCJVL6lKT1FM1+8ppk0RAwYfBe+6Kpf7Im9ZlWFnH/IfG4jWeKSR1A0hNqvIIRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ29BNtn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ29BNtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDBCC19424;
	Thu, 19 Mar 2026 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773951014;
	bh=B3QQrlzQBt9mOhwgv7UXmdIEFVKfHBgUY53wL9MuFW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kJ29BNtnlTrRdnVP68e9ZDBNpCIcp8E8L8RGbQRDleu2srhPmGQcQ41oT9WR3zbTj
	 Cbt0FmsTnEa//fS1JQVIrIqEOnm2E0Ck8uv0QbzwHuoWcsi6CtKjEltWx3qiPMXT4F
	 1VObPPjQg8rr/pCd+32N1b/v9zS8q5uMxW+BoMc7bGRGSGn7TwItuGUhl0PmgTqanc
	 qSL4gyDAx7vjnD3phrLvZViXJHiVkQG/AuTggSuEpL9QWdpCpt70L4C/51QaLtqSdC
	 EU+jO9/UZCbbcf0NdeZjEAU1NrXFhKh/Lpx/NHkuKUQ0zl2h+hkX6+Cg253n4cHPp1
	 geg2eScnKRckg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F4139302F6;
	Thu, 19 Mar 2026 20:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Add warning to detect memory leak in
 bpf_selem_unlink_nofail()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177395100555.1784142.14136304459255173504.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 20:10:05 +0000
References: <20260318224219.615105-1-ameryhung@gmail.com>
In-Reply-To: <20260318224219.615105-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 18 Mar 2026 15:42:19 -0700 you wrote:
> While very unlikely, local storage theoretically may leak memory of the
> size of "struct bpf_local_storage" when destroy() fails to grab
> local_storage->lock and initializes selem->local_storage before other
> racing map_free() see it. Warn the user to allow debugging the issue
> instead of leaking the memory silently.
> 
> Note that test_maps in bpf selftests already stress tested
> bpf_selem_unlink_nofail() by creating 4096 sockets and then immediately
> destroying them in multiple threads. With 64 threads, 64 x 4096 socket
> local storages were created and destroyed during the test and no warning
> in the function were triggered.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/1] bpf: Add warning to detect memory leak in bpf_selem_unlink_nofail()
    https://git.kernel.org/bpf/bpf-next/c/4b21ea502483

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


