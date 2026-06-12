Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5A3D9DD3;
	Fri, 12 Jun 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304016; cv=none; b=fn1XoKTezb/yMYwjHPCmteh/j/9Vb9iePs2bd7G/pjkC0ql3UIXsOAxVz1dnIG4ggtikaD32QQNx811jpdA/P/KVhqqewLlEoFuXHC/wQgLOWU3e5T/nr1DyH3jGiL4Tpd/hBHdxguy083FCsKVLvs8KVr1c/lOkWgFpCzadU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304016; c=relaxed/simple;
	bh=O34CWYNB4JNCHuFinuFFQmZbHDr3G62djOQlHcUnWlk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BJZNvpn/kvlXxW+T8FMXuEhjCPvwno/E3+it4T9YDGLt51D3SKpRltxwZn+4yxKzX4FAaF5BqTe15v8PnZaZTtDy0mOocsmkMmGDkylwmg3B4zlDMEKfMALxcRk8iY5Qg5/BqKX8YFT31FKmh57/ZEJWclGh3HS0AJtq9vnlkdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDD/DmxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDD/DmxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FE71F00A3A;
	Fri, 12 Jun 2026 22:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304014;
	bh=u30FmF1ZvAzhrJKphZvci1P+EsZosvD8EEfcSGzZ/is=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NDD/DmxWjHhSgBtz9jrtuCa+eJZelGvRY8O9im70Pu2qDbwJPiDCm+hcTACuIX/Qa
	 a+ikRUGzGx/nKBMcRcnQe9yZ8yjeLEcE7wfUa0XF67eBVW54hmJBsHlV123Sa7uV8+
	 jvMTTo1t5G+aRKonmofEDkSR1LiqoSxs9xw3OQS77DXshJ9EFAm/T4H4yrFjka09eI
	 H1b10IPZBRdMMBRZgc61neVM+qfF/n3qMkbp3u4BfnFCp+WshgTdWK1VGheNxMZS5h
	 P5o32d46biisyVyvZg1ONgnY0dtGY8uom3sdhB6a7QEa1iAuz/fa2p7t1MjAlEorIu
	 V3Ve8H501S1yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5687E39E4DB9;
	Fri, 12 Jun 2026 22:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] selftests/xsk: simplify UMEM setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130401114.1275309.12520760927935385997.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 22:40:11 +0000
References: <20260608130938.958793-1-tushar.vyavahare@intel.com>
In-Reply-To: <20260608130938.958793-1-tushar.vyavahare@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, tirthendu.sarkar@intel.com, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 18:39:33 +0530 you wrote:
> This series simplifies UMEM handling in selftests/xsk.
> 
> It centralizes UMEM property setup through helpers, moves UMEM ownership
> from ifobject to socket-owned state, and normalizes umem_size/mmap_size
> usage across the touched paths.
> 
> v1 -> v2:
> - Applied helper usage consistently across the touched test paths.
> - Moved UMEM ownership to socket-owned state and switched to one
>   heap-backed umem_real object at xsk_arr[0] with explicit reset/cleanup.
> - Kept shared-UMEM TX behavior unchanged via TX-local UMEM state
>   copy/reset during TX configuration.
> - Folded pkt_generate() umem parameter removal into the ownership
>   refactor patch (no standalone cleanup patch). [Maciej]
> - Updated mmap_size teardown handling to join the RX worker thread in
>   single-thread mode before cleanup to synchronize UMEM mapping state.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] selftests/xsk: Introduce helpers for setting UMEM properties
    https://git.kernel.org/netdev/net-next/c/19ff5c545750
  - [net-next,v3,2/4] selftests/xsk: Move UMEM state from ifobject to xsk_socket_info
    https://git.kernel.org/netdev/net-next/c/b17631032769
  - [net-next,v3,3/4] selftests/xsk: Use umem_size() helper consistently
    https://git.kernel.org/netdev/net-next/c/1a24fe421739
  - [net-next,v3,4/4] selftests/xsk: Introduce mmap_size in umem struct
    https://git.kernel.org/netdev/net-next/c/0fe61052acb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


