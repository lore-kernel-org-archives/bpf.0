Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142607;
	b=K+PXdxAIM10KPjBlAHWuugANaFPtt3d5fS7xa5/kG75ItMYxBLwuSfzJmesNaOhPBg5b
	 W2CYRNRB2yDhveaBz7sRTFpmRgxq01mw6rrbCYvelrJwHR4wvCkUyasdlk52c3snguAdh
	 iDg4ZPDE0sMgBcz70aunrcB8y4qvljeUEuFu+4U89EgshyxFFyMYm+ywW/4fCj9mapOf9
	 +7HdZzYqzOSHo/3qv2YiGEmWajLEI4fxsn6Vak6MBFK942d0AxGTj61/4pr8i324zk+Ls
	 B1i9JrMpzNTqafEGyzNcXyAs+agGAMBP809xX1CArAk8HDPErMIceqx+FKdkeEAIClQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JeKGnijomadQzdHHJok2RAUaAIDhnUbgHxZOYPiyzzo=;
	b=3DfX90cmr416tkiR5bK597sYEnZTi8gra9J8uLsGDgSwQrarYNrMjAh48ztb9yYAQ7mw
	 DZkK+3oGpezzaTpRWxVkMAdWCgkDZqNEd0lQq86V+8Wr/FziKOcrJajj+Ueax1DJrGfHy
	 i/UZT03PDm1UMXufY3JWmNPp9BuJ8sxqjNJN6tlp6saoA+j8x34teowtvnMe9yiy9TZEZ
	 3pVsl27u5NKRNrsjWo365uIwaRXxva9IDwbsiKIutT7ZIb8r525QGFICmv2vIugznB9r3
	 ZL/AUgR5RwxmKbhoZG30+lnx/IDTsbvXlO/2e1N3zytK+WD+nH+2er1w9MWGH9290uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mheR8DDB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02349606A31A;
	Tue, 27 Oct 2026 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mheR8DDB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D921F01825;
	Tue, 27 Oct 2026 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142606;
	bh=JeKGnijomadQzdHHJok2RAUaAIDhnUbgHxZOYPiyzzo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mheR8DDBbze8gcXBj2XRoORCifxerjUvp9dvzHkJERkVbsQmnSNID0Nfjbo2eGURG
	 w+b1QCw2FRa3bj5mWmBM0vlFoIFBequeet/eguIDPkpylPbEEtOy+++KozeIIU17el
	 VniP+XzIdd6Li81b17eLMDRyUA9iIsNvuY6Q5fQRib5ioWZ5bdFiS526mIxZkAmpMF
	 mq8q3tW/Y/U5eyvY2K6eCwhAnXQt3+5JniY31augiUspkdWfRRK9rNY2WFQZ3cZQFr
	 fuszAAVZusPqBQ8Ewx6XFC3Rxi82YK6j2KM4rK7VBUvunIP5Cu8mgpUfKSZyutEjM+
	 very1xVg4xJsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE57C3AA940D;
	Tue, 27 Oct 2026 23:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: lan966x: don't disable hardirqs in fdma tx clear
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314260557.383254.3851394909135159768.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 23:10:05 +0000
References: 
 <20261026-lan966x-fdma-tx-clear-hardirq-v1-1-5f70f026a2e4@microchip.com>
In-Reply-To: 
 <20261026-lan966x-fdma-tx-clear-hardirq-v1-1-5f70f026a2e4@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 14:45:58 +0100 you wrote:
> lan966x_fdma_tx_clear_buf() runs from the NAPI poll and frees the
> buffers of completed tx DCBs with napi_consume_skb(),
> page_pool_recycle_direct() and xdp_return_frame_bulk(), under
> lan966x->tx_lock.
> 
> Before this patch, the lock is taken with spin_lock_irqsave(), so the
> buffers are freed with hardirqs disabled. RX skbs are marked for
> page_pool recycling, so when such an skb is forwarded back out and its
> tx completion frees it here, the free path reaches __page_pool_put_page(),
> which warns via lockdep_assert_no_hardirq().
> 
> [...]

Here is the summary with links:
  - [net] net: lan966x: don't disable hardirqs in fdma tx clear path
    https://git.kernel.org/netdev/net/c/b2e17432e7ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


