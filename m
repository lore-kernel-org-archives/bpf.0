Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8AD175A91;
	Wed, 18 Mar 2026 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773799813; cv=none; b=BOIVjHLKabJ68vmVouig8jh0bghHq+v07R2o3PzI0fHijIMqBEUTUi90wbHiusiKKYvYI8XzPJfvYxMwcquriJFurvQuneqIx6LJaQzAfdm4RNjlQCP/b2Ab2dcJ/WFbNbVugAidxO4qwmaK4VFhygL7jkWnjfwuUTLvgccvvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773799813; c=relaxed/simple;
	bh=EbQz2NcBW3prrNekaftuszmWKPrH/FLX5fa1fLFDxAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hs5BI2RMrTJ8Nn8SeMbtvwnBU8Qu6iCTRWnT/KYQNws8czNB8PkfvSco4lGDRSWqr+uGUgEDvwpiUQX7kYJRoBl75j1rHzopTimFNSb02UE9LFcq6VWWQQn9qDDGBVeJL36AEm8IewEpAHimvvw5ngta/YlDha4vaP020bLyK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0HceKAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0HceKAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08198C4CEF7;
	Wed, 18 Mar 2026 02:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773799813;
	bh=EbQz2NcBW3prrNekaftuszmWKPrH/FLX5fa1fLFDxAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k0HceKAVriwf8VCqU0qypRat3Brax8l/2/0lZ3BpL6ryKPbkCxFfTKqfqCKgwBy8N
	 CNGe6x2LoDDYeptUOwSLVwJFU8T7myaqPxHgb6jppa5qEV7WKsE5yhWobSfCtNz/wd
	 RXp+XgOilGihUVCYEe0nE6sV2K/N+II9Dk69wtMU5nd0FMdQ+dYIT+96ILV8v2tUnM
	 1KOhY+Ytp8GnXwYKf928PP/f0+vm1FY++6SCE0iiXdFZ7Mlx8jwz+hMgfy9pmDCZnE
	 x3sdkldVmxsIQFKDz7UdSUmGZqvAMyIdilAMEpWeMTLF1GHkXnhUZUkao8ZcF0Y7zY
	 RJLrSmVSFFojA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE1E3808200;
	Wed, 18 Mar 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx
 processing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177379980505.93590.3046591457108374673.git-patchwork-notify@kernel.org>
Date: Wed, 18 Mar 2026 02:10:05 +0000
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 16 Mar 2026 15:05:57 +0100 you wrote:
> Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> full") addressed a case in copy mode, when working with multi-buffer
> xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> there is a space to produce descriptors.
> 
> Adjust ZC path to follow the same principle.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer Rx processing
    https://git.kernel.org/bpf/bpf-next/c/77378dabb50f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


