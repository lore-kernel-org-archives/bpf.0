Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129823EAA4;
	Tue,  7 Apr 2026 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526642; cv=none; b=UFTyyZDtgD3UbStVO5tfFCC0Lw3dZ9Mrygicbjp+VMBH44KjnLtxwzJmu+ZwPc0ufnyEeRzM7CDmMbiNEch/G0q36N+DjZEYr1pviaBs8/MWzpzD2iJTXRkmCRqjRUActtN2gfKfQ20Ngew8iaQXxVg4YmH1MsOnypXH9Fujaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526642; c=relaxed/simple;
	bh=0LbS2OrKFJw0MdswpvXmypIBcvdFiRSeOyf/Z9ojaA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MF3u+5Edr7eZgAXYSKem/JIwYptazdpwBvXcLGamTs+lMiyYf7chgCMhGQMVgTgD1wUX8Bqp58yfv99L0S5RWtxor+FxknRAa69TsM30dbuQ5CSh6OxYmfN9P+HIpieZrr/eTe5QNTi5jZbKakkSHOl/VgsY6ENLwdBgBP6n6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0VSB3uC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0VSB3uC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A482DC4CEF7;
	Tue,  7 Apr 2026 01:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526641;
	bh=0LbS2OrKFJw0MdswpvXmypIBcvdFiRSeOyf/Z9ojaA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y0VSB3uCXO+zkDJEJ52RekXcWfK21WJ5O3+FKYSz/wD7asnIXnoDI4E0hG7yv2cIE
	 TYpGcPZKG1AbRIpfBGi20aRuWxbecErjTTG6WExNwbdEDTht2nBD7GMBfkVJHW2kLl
	 w+6RMNNZki3AiqTMLrMSdMiNCH9kCBO2GlVpiIJfkR8vUA1N37sw2x9J/e/8vSa30b
	 WfLisxSXjYLZGeWsgvJWtVlvP8B3j64vT/E1fu4JJpMey600s9rs/oH7zzjQ+CLvMY
	 +MfGB8RELgm+OcQgjq8VhyozX296NoQ1S+TEsYl6aUKJRx5YnL2a2hi5SWbSbSbhf0
	 0W9G73KHvhM9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC463809A28;
	Tue,  7 Apr 2026 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 net 0/8] xsk: tailroom reservation and MTU validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552661979.3337768.6596157597799089134.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:50:19 +0000
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, bjorn@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 17:49:50 +0200 you wrote:
> v5->v6:
> - refrain from relying on umem refcnt when disabling zc on error path
>   (Sashiko)
> - have a separate __xsk_pool_get_rx_frame_size() which preserves old
>   behavior and use it on copy path (Sashiko)
> - drop driver cleanups
> 
> [...]

Here is the summary with links:
  - [v6,net,1/8] xsk: tighten UMEM headroom validation to account for tailroom and min frame
    https://git.kernel.org/netdev/net/c/a315e022a72d
  - [v6,net,2/8] xsk: respect tailroom for ZC setups
    https://git.kernel.org/netdev/net/c/1ee1605138fc
  - [v6,net,3/8] xsk: fix XDP_UMEM_SG_FLAG issues
    https://git.kernel.org/netdev/net/c/93e84fe45b75
  - [v6,net,4/8] xsk: validate MTU against usable frame size on bind
    https://git.kernel.org/netdev/net/c/36ee60b569ba
  - [v6,net,5/8] selftests: bpf: introduce a common routine for reading procfs
    https://git.kernel.org/netdev/net/c/c5866a6be472
  - [v6,net,6/8] selftests: bpf: fix pkt grow tests
    https://git.kernel.org/netdev/net/c/3197c51ce2fa
  - [v6,net,7/8] selftests: bpf: have a separate variable for drop test
    https://git.kernel.org/netdev/net/c/16546954e117
  - [v6,net,8/8] selftests: bpf: adjust rx_dropped xskxceiver's test to respect tailroom
    https://git.kernel.org/netdev/net/c/62838e363e4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


