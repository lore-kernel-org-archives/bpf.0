Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651DC54707A
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243608; cv=none; b=WwrePqfYCrklxObeK4yXzU8bpCgSMXI12lKZ1mc2kCartWzUhLc+4rX9eC9RIslvrYdzX0Wn0zB++kO+svOmrdyjC8NeUqs8HPxYDZ+nAMl25syzhAmk1cJ27Hl0t68/ZeI7TGTgaBPIFT+SpoXj+6hCLOtOq4NmZvhzgejNOfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243608; c=relaxed/simple;
	bh=1dAGTPSk1vd0ES0T052oMIB6sUEwUg8iyDzO79MwzJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xd5ttQLguhsj3zmjfhobBgcoU4VPbZvS5p9TDHbLpCqhNBa+lcwKQY+MMh8brvTHc8jz5YAZZ33PrfaE59pYExYUgzHEbVIbsE+llvqTD/xMnaKpKGVs1/FVlgW3G9QTyktrKU9T7giKBjHz/g8giP4HMXBrWxu6bhdJF5AP0fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgZlfGJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgZlfGJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056341F000FF;
	Mon,  5 Oct 2026 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791243607;
	bh=9XPIsSeRFOc5XDAfXTRS9iIeVb7BKsriM00NUhz9q1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WgZlfGJ3+hFKyDqNf/stSwFh4Ye6nOSamCjxQSzSEyiBFDvKOhSnK6jl4bW2eA2sJ
	 +vzGN7cNevNFdmRALy8qONS2879ANHoBkFVHISWzMxRZTmNHFzfgAa4Bjf51nxmMzW
	 J3+ygp2EYtUy6iO0PqQSvNj2/YTWHyPXtES2x82coPV1CQDl6e0OYRNBjsOtg2sXpF
	 8GvUS/ZG4q9jxXOfsFhVYD5RZ9R//ib8qfOdnBAcKlKpgsmR5Igxtlt4up23nedOnv
	 FZH1pCPG8lVAHEyLih26XzGcOJAV3+K6Cpa8MpXUT/UoLwwPc0hoB4hRcrTF39YNCu
	 938FrZnNRumRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F167D392667F;
	Mon,  5 Oct 2026 23:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Destroy callee-local dynptrs on
 subprog
 return
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124360578.1939764.3003662912880693578.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 23:40:05 +0000
References: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn>
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, ameryhung@gmail.com,
 sashiko-bot@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sun, 27 Sep 2026 20:04:20 +0800 you wrote:
> A dynptr data slice is valid only while the specific dynptr that produced
> it remains valid. Apply normal dynptr stack-slot teardown before a callee
> frame disappears, so its descendants are invalidated and its last
> release-capable referenced dynptr cannot be lost.
> 
> Patch 1 adds a helper to destroy dynptrs in an inclusive range of stack
> slots and reuses it for initialization, variable-offset writes and
> subprogram returns. The callback diagnostic expectation changes in that
> same commit. Patch 2 tests callee-local slices, last-holder rejection and
> caller-owned slice compatibility.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/2] bpf: Track borrowed iterator results by default
    (no matching commit)
  - [bpf-next,v6,2/2] selftests/bpf: Test dynptr teardown on subprog return
    https://git.kernel.org/bpf/bpf-next/c/b04ba9375a9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


