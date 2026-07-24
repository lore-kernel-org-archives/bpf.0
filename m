Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FD41F350;
	Fri, 24 Jul 2026 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931685; cv=none; b=ege3qKyAgfeUlxoxp731Fy++msKrvYJKs7HDh8peWa0pA1wrLvVjE/pkEp7OtdD9v8PjyJ/VrY0/BXMvYQzKxqnOSUYz3AbOP3/WibOVXmVJ7Tq6fpeKuHRjwjw9ylNJT3Mn9bFGRLGT4vNXJ0OrrQFF8utVEzehEtYe0OZf07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931685; c=relaxed/simple;
	bh=+Pdrl7GIT80aXuM/5Oq3GL8XQdT0O7/ffodayoazIJc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fg8jBbrcqv8aR0AYJHkcP9nKIuSqwSDi+n0xaX5TxShCXiFTLA8+eZirITmrjIQuzqJVwFJ5vvjGhu+aB9cOB9oCCw5Hznh9TkIFe5fZsnUAVsWE7va/V1GkbO/LprpKmUyM2PJV1utEsdltsb1YuPDHB1sFKvR4TF8Gntgi3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7CyMKrb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7CyMKrb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74DE1F00A3A;
	Fri, 24 Jul 2026 22:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784931681;
	bh=9tqCbmWrSkO3s7QLwlyJJOX9ETiCEAAK04846K6UYTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G7CyMKrbt1hqVGlsAikEC1PRL5dCRZ2Lxb62aFuZaHE7+NIe4WZJGOfjKCpYjGHHu
	 WMFGVyfA0Pgll1riKGjoytDfZiDQc1qYrSbQnZylfeiEVmAQIMIBTAp2lOwTfAAmVh
	 FAe+Rcd2YKAEY6l2dMV6l9MRIUb8M6jMiJzp5AiWlismmvHFOj0w6tRjNH7pKeNOcs
	 1gwRv53vAdjLNKez5LMdJHTCUNO38KDFd+lxjOd5rU5lPetgM5IKKvqtUk2X0VatPl
	 PRaq1thUu+tjM29ZO3zgrhAjLQQNRR8a6V5H0RcWfr10F0mg47M9wuat5eKuMvxrvy
	 h9qLN7QNtPdWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1986638111D7;
	Fri, 24 Jul 2026 22:20:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net 0/6] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493164863.3333291.2999893217736208336.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 22:20:48 +0000
References: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bjorn@kernel.org, kerneljasonxing@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 19 Jul 2026 15:56:03 +0200 you wrote:
> v3:
> https://lore.kernel.org/netdev/20260714140722.111645-1-maciej.fijalkowski@intel.com/T/
> v3->v4:
> 
> * Return standalone invalid Tx descriptors through the completion ring in
>   both the generic and zero-copy Tx paths. Advancing the Tx-ring consumer
>   releases only the ring slot; returning the descriptor address through
>   the CQ also transfers ownership of the corresponding UMEM frame back to
>   userspace.
> 
> [...]

Here is the summary with links:
  - [v4,net,1/6] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
    https://git.kernel.org/netdev/net/c/a3c8382ebce4
  - [v4,net,2/6] xsk: drain continuation descs after overflow in xsk_build_skb()
    https://git.kernel.org/netdev/net/c/bd44a6dcd424
  - [v4,net,3/6] xsk: provide sufficient space in pool->tx_descs
    https://git.kernel.org/netdev/net/c/08c9a8e794b4
  - [v4,net,4/6] xsk: reclaim invalid Tx descriptors in ZC batch path
    https://git.kernel.org/netdev/net/c/72f2b4516faf
  - [v4,net,5/6] selftests/xsk: fix too-many-frags multi-buffer Tx test
    https://git.kernel.org/netdev/net/c/c5b1ca6a0288
  - [v4,net,6/6] selftests/xsk: account reclaimed invalid Tx descriptors
    https://git.kernel.org/netdev/net/c/f49d99eaee7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


