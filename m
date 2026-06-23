Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D73ACA7C;
	Tue, 23 Jun 2026 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247827; cv=none; b=ASw1O/eOm0AduKgBW3JQ1NE79QFwOUc8v7jdS8GoFgDr23qXffRDIU38AWE6HqvqoJrV01EPDmCSFIX3dUavSk/Fv0SiI/Tb+l4z32yq7KdrS5yJ2xaitvgdCrewfRN4XfwYzLc7h9L4x6N0RWucxOikx5GCbxM3XEf2BwZYmsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247827; c=relaxed/simple;
	bh=YoVVfnYPkqa27FTalLHq5H/8TBBYIGuzOa3jGRIdYnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iUb7ixGl6hScGOxmi2PGULzEAP6QXeobqXcUPuSTpXt17rgU7HvA9k1sjNzPoXqvgRhrMXVIUdfNhyfUWrwWzXXveRKZAuY0pypzVTgGyzS3AIDeRhwwbvcZiUpSnUxyh8c4Ym/UhZjlBrYFcQvF3Hx0eSzd3OIr+Qf+FQeOxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyc2n1mI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lyc2n1mI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ACB1F000E9;
	Tue, 23 Jun 2026 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782247825;
	bh=Xt6aIhrvbwFjJyQUiZfjpHAiIDxb++JS0psq4z5/buI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lyc2n1mIqwItRV+MkTULqbCSwygjPWblG26lSsLc8QVKOr8ZseHj3Qi2Xa1Ixs5Bu
	 K8+xpbI/eD+fmEw2Tz7MDTD02AiYTw5pa37Z8FFvPkLFq52JkkWgJVczS9EkhXdD28
	 nomGQz3XplpzKg+S5iYOA7Z5rxsQFBtJRXjAQSyIYclHK2CSSVvX/fuT3g/+ZKHEKt
	 rR7/eqFHCR8SRdIZMsUIdzpjFz6X1e3gLCyl1BSPa1wps1ow7b8T4f2ty9Bc/7yo38
	 NtMtKvuAB6xZz+uDw9VKdh0WzJZxbIEjRMsVhQVx6X2uEi165TI0NGOU/YN/DLgXhO
	 SzNr8HwbomqKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A193931005;
	Tue, 23 Jun 2026 20:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test
 behavior
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178224781523.2413852.13473008974792105464.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 20:50:15 +0000
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
In-Reply-To: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, tirthendu.sarkar@intel.com, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 21:19:51 +0530 you wrote:
> This series improves AF_XDP selftests by making timeout handling
> explicit and fixing sources of non-determinism in xsk timeout tests.
> 
> Patch 1 introduces test_spec::poll_tmout and removes implicit
> dependence on RX UMEM setup state for timeout behavior.
> 
> Patch 2 fixes thread harness sequencing by attaching XDP programs
> before worker startup, removing signal-based termination, and using
> barrier synchronization only for dual-thread runs.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] selftests/xsk: make poll timeout mode explicit
    https://git.kernel.org/netdev/net/c/b56cded13137
  - [net-next,2/3] selftests/xsk: fix timeout thread harness sequencing
    https://git.kernel.org/netdev/net/c/483c1405f817
  - [net-next,3/3] selftests/xsk: restore shared_umem after POLL_TXQ_FULL
    https://git.kernel.org/netdev/net/c/ea4e9c9d8b2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


