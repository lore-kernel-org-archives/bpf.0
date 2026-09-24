Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2E3CF02B;
	Thu, 24 Sep 2026 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215281; cv=none; b=HqDG47W1j51wSXhYJxsUpV+6z9YOZdAOP370MTIDOq2DdsyXZ0i2e8kDoeInSUuuIoHOgaM5ZjsLE1D1yUMz9IpMmkFJ1CABjZXrmL5XaU36V988fHddyAjnVnhdx7hzrJPbKk+TaJIHBy9oNawJ6tIZC0RqxPrLCtCe172hs8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215281; c=relaxed/simple;
	bh=cFgWPpD6JCmOcvH1toFhnd2Gh8rjX0lo+SV5YG1PRDM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=anXdfT+FnndId2No0jVSLTCyCFzHin7bBjsp+7JHsQK11/eRp5pkX4QabE2wMLDmWxpo/crsh4ihIo18q2lNb0SdBEn3RPoRHzllfxCGlt5FTLRCKSecYZC/xCPGanIsKLxWdeflfspD8sKorCnjDfwARGfwdc7m0EiJM0b6jRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yoh3yZiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yoh3yZiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C9B1F000FF;
	Thu, 24 Sep 2026 02:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215280;
	bh=GzfyTkoi/q62POwnDFlbBbueJDmngNl0TC9UDuE7M/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yoh3yZiJbNhn0zax05+RXrCCnKf2UN6NiXfw6AMPCds/j9ITjPnq+0OdaS9osg+6Z
	 TVopUoKn1rcCTwgCe92cVmYsM1IFeCA+/fEB0yzM3/myQbMOH+HjFyKSO2zJdhpcHG
	 TOAIXh7HNYlNhmfb9pQDAiwCTV/750MGErra0GPNuRWg8K8J8d5c6MPZ4My+hnld1o
	 0YVnhcO9xuy4nLnFgCIn7X6yDjBf37nT/2nAKh200JWmNKJwZgvtLH6xH0EuEIeo6Z
	 aundxxE2VR1MBNVrf3FDOL+1QM8zfGgqbKxnsSb5m6KpmW6eP1h3nMHW/Rw7rv4XzQ
	 F0OjzRNK5CO+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B4239E9611;
	Thu, 24 Sep 2026 02:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/2] bpf,
 arena: fix range_tree consistency on allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021520990.1274904.3625396704224193293.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:00:09 +0000
References: <20260923085817.365930-1-chenyuan_fl@163.com>
In-Reply-To: <20260923085817.365930-1-chenyuan_fl@163.com>
To: chenyuan <chenyuan_fl@163.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 ihor.solodrai@linux.dev, chenyuan@kylinos.cn

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 23 Sep 2026 16:58:15 +0800 you wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> The arena range tree can be left inconsistent when kmalloc_nolock()
> fails mid-operation. Patch 1 fixes range_tree_clear(), patch 2 fixes
> range_tree_set().
> 
> Thanks for the review.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/2] bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure
    https://git.kernel.org/bpf/bpf-next/c/3941710a504a
  - [bpf-next,v7,2/2] bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
    https://git.kernel.org/bpf/bpf-next/c/b51b058999e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


