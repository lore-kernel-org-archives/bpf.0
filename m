Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500407;
	b=VOf3ax4yClyAYMui/txTNqPv/CpbpOYQ671rFlBQhTUn+OJqR1LfWNz0hxcR3bBMSQny
	 775YvT1JRXsbOtzYuk2uUPbuzmsPBjaa0ZoeYIM/9mNamtGjxfyK4+ZhABEj6WcPbdJoD
	 vgm0KwOYYBO+Qeo//Z8GFnbJTNjUc+5SlAjWB1uTxDX67x3rD5qIfStBt1gihm/TrnXMJ
	 D6d41x5qHTZlck7WyHqtnVeKgEZdvAWkotijV0x+8WLo11zWmMzD46rvUWRu4X0ed2QdS
	 E4z9cSq6LVfcxT7WwHVyDWuPCoMWZbpNb135Pies/70HY6D92bQpchXs0rDaXA3mhOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=/KbZqwAX9q3OhGF17k4YUyCJru5x7wrgR3CRRpIUUzc=;
	b=oPjhjk2qSIEjmGTgHPS71Dh0ignifrXB/8XWHPJxrhVEUGs2niga+60X104iA8zVXeaW
	 YeMWgRhFU6bxvhuHylKeuiDuSGbT5/0k1LbiEEkScphiN5QKQLOgcWYLmkEZIomftwBid
	 4Gasi9yA6UibS+C3bbzMKIPhJU2U5tRRUKZqtwhUD00OJXeKzG4WPTfDKbIxAcONWiX8F
	 2/JZpsoX5yu4hUL+XsME/vsf4WQH9X2sSB2GhQRSvzWokqa/INclRfUzY9ruQdzYuzZmI
	 OHmX7H+AiW1RiTuwK325ygI/fcsUOAp/AzkidXZ383F8u4pQy1JjU0DOfRayB+ZIfYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jggp6FrR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7B606A31C;
	Thu, 12 Nov 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jggp6FrR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3AE1F000C4;
	Thu, 12 Nov 2026 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794500407;
	bh=/KbZqwAX9q3OhGF17k4YUyCJru5x7wrgR3CRRpIUUzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Jggp6FrRtXMrsRjhkZ/ZiF9INv9FTKscEaxcc1xp0lUUn+9MdyuMIKK7mGdrr5At2
	 MV7GbV0xRUcsQZHMRfc5NRqHd4BH/HiYTTLnqwWAsweq/xhw466vyNQyzJvQ+S9Pbr
	 F7mbZ2kiKEHy8b2KS4HqgagYt1ICHs5ppNwDtOOVqcpezeWjD6JOjE3P26dF6AqCuK
	 xX9PQ1ziZlFoht3ZpH70C8B7kYEE+GobZO30ptZeoNkVJm/sZAQ+KHz3/ehEsIKdft
	 KSWE9K4kiQPhvQH2ZwPHkGImd2BOUVDB8886SYTZNZrFs/6/DHeqUslXRcKkfhTsaF
	 UCk8dyyx4P3jQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1537380AA5F;
	Thu, 12 Nov 2026 16:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3 0/2] net: psp: preserve SKB_EXT_PSP across packet
 scrubbing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450040578.42282.14929639226978181632.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 16:20:05 +0000
References: <20261106182007.374660-1-weiwan@google.com>
In-Reply-To: <20261106182007.374660-1-weiwan@google.com>
To: Wei Wang <weiwan@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org,
 jakub@cloudflare.com, daniel.zahka@gmail.com, willemb@google.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Nov 2026 18:20:05 +0000 you wrote:
> When a virtual interface such as netkit is associated with a PSP device
> in another network namespace via PSP_CMD_DEV_ASSOC, incoming PSP packets
> decapsulated on the physical device lose their SKB_EXT_PSP extension
> when scrubbed during redirection (e.g. skb_do_redirect() or
> netkit_xmit() calling skb_scrub_packet()). As a result,
> __psp_sk_rx_policy_check() rejects incoming PSP-encrypted TCP data
> segments at the socket layer.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: Make PSP skb extension survive packet scrubbing
    https://git.kernel.org/netdev/net/c/b22268fc3ddc
  - [net,v3,2/2] selftests/net: psp: test bidirectional data transfer
    https://git.kernel.org/netdev/net/c/51127238570b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


