Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D673BB11F;
	Mon, 10 Aug 2026 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404067; cv=none; b=acGX+mt8LWxvcBYxsIb2Qj3E6oKdnUinb3yz9Iq1vbuhmMcXy/9wY3TwwG/PCNVCB05nIcAVM7M1S1MwasxWASfF48J3p4VbWtUVfRUPjXDlknNSh5ocfZV0/SUg0/9+yilbT6Cbce0PcIqi4JDaYKzsJDj5iy1EZ6/1KR9LXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404067; c=relaxed/simple;
	bh=WQLYjtIUuN+Rt7qXLUlPGwkAEgWib7xkS9AEGYFBBuo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FNw5EMVk3YuTKC6owaBwpX6KcDPxQixNYCQpg8bsWmyysA79HPqmzGb1OYmheM65a9aD9yQEeFfVUduAZ2ShyiPtoduPHcA0WyIPa9gUlcTgVopG4fKc28i6/Ir5yD0orSoDcgIbEM985piia05PQAe91EyuWqwvjcxABga6E3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htorg6p2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htorg6p2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5313F1F00A3A;
	Mon, 10 Aug 2026 23:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786404065;
	bh=TalYOgZi3h6UZifvD/whJw8vIPnHFPzgKnYN7dciZnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=htorg6p2gRMKGOysgLQHczp52uj1Ql6002AvkNptEkBp4DOitihpRomZRAZQCdybr
	 jd6mKCenqzmVv8x5ENtOQgPxOy+SqVLE3hdIM+w3KAe7h5IAi+Sc6ivbp0M2imosz8
	 REVLiwJjoj3uPA6K912bpfsc35R24UjVTY4mur/mBy/as9izE9qifYgUQ67M2V3cmF
	 4OyJ41Zf8PGTwj7dq6GuAylwTrfWMEAvpLWJAsLESjoYC+TYq35Mh4m6DMUBW++UUi
	 bwzN2FU9mOZpJZjCRemusKg1IqtSXebRVNUcJCAfR0+PluaVv+R53ZH1FGNH9jw/XN
	 ZGuWWUKrPxlvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1990A392626C;
	Mon, 10 Aug 2026 23:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] veth: fix queue index used to wake the peer txq in
 veth_poll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640402163.250217.17935153905345484599.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:20:21 +0000
References: <20260806-veth-fix-poll-queue-idx-v1-1-c5357fb7573d@tu-berlin.de>
In-Reply-To: <20260806-veth-fix-poll-queue-idx-v1-1-c5357fb7573d@tu-berlin.de>
To: =?utf-8?q?Jonas_K=C3=B6ppeler_=3Cj=2Ekoeppeler=40tu-berlin=2Ede=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 toshiaki.makita1@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 6 Aug 2026 13:43:49 +0200 you wrote:
> veth_poll() derives the index of the peer TX queue to wake from
> rq->xdp_rxq.queue_index. That field is only initialized by
> xdp_rxq_info_reg() in veth_enable_xdp_range(), which runs only when an
> XDP program is attached. On the plain GRO/NAPI path
> (veth_napi_enable_range()) xdp_rxq_info_reg() is never called, so
> queue_index stays 0 for every queue, as priv->rq is zero-allocated. The
> same happens once an XDP program is detached while GRO stays enabled,
> since xdp_rxq_info_unreg() clears the struct again.
> 
> [...]

Here is the summary with links:
  - [net] veth: fix queue index used to wake the peer txq in veth_poll
    https://git.kernel.org/netdev/net/c/60db47f02bfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


