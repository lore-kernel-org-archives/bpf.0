Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321008;
	b=q9e2LlGK4Y60/KmEMDuw/BPxRkdawQTeJBb9HLl+4hz9rDz5fH6Onz/gojaHeNx2TksK
	 XXR4Z0KkrXCs0rJUeSVriJig2710B3gcqYNJ8ce4pfs6nX954snbwojioQF2RCs1h1SiW
	 Xhnm4fVgmWdnUMC/WU/Z18tzOi4xE9uTWfF3J/Q7ia7T/NYdh9emxbCBryJ5llbw0d7QZ
	 JaXMfwYz9hlHZS5ersCnWjtKa8j2adNAsy0r/IW8cFwUu9hn1i9VI7coxhvFwn6dRdOcg
	 f8vcGkXpjRuKiHzjgK3ghE2OoK06deo3/wfncZGaoGE6xkPEFoIB6yxsuYslmXjjAeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6re/8M7BAKbsJAaby7V03QwRwM9/MqNLLzk54nsXA00=;
	b=A8X7K2S7c88Mp95r51kLcO0sf/ypWipKLTHzo6xkatL1FCUj5UVK5uqqVde0LBlc9Vyr
	 u9rrVFJ6qBv3zhJHpKVxTFfOvyEPK9MCNmaQxw6/qi+ywJIqsQ7DLj76SWnvUxkwUvLkc
	 /kmQ0lU4RqlG2YTcOTyQlkjUuKYfvVWFb/Cyse2hl+c8XW1MxWdPPOIZHwQYowlKUVCh7
	 lwhPIngTNgaJpaPP8qAZsiRKRIccwiRbHbumTyW79AcJltGHp07GYTN4PSixQmpuMadi/
	 d25OQdiC2m2MDXwhqWWDCuWQXlGKUNJWV3IQw7hR4sXrGcqrFOIsTf7JaqbZCIdGasw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlqNEHB0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07D606A321;
	Tue, 10 Nov 2026 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlqNEHB0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A819E1F0089F;
	Tue, 10 Nov 2026 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321007;
	bh=6re/8M7BAKbsJAaby7V03QwRwM9/MqNLLzk54nsXA00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JlqNEHB0x83jrWOU+aXt+t6KdxBWq2a0su5gwKhZDBDzwdt1vIQ+NwqadIVD620Jl
	 ZMlJKnzaNQn8mqKyJ431cKwCEnd14z50i39yzmzWsET+nkfQI0rpvua3TRIDtlNlIs
	 7KNJgu85+cPAH0ouhch2WhSEoivO1FCxEzftHMCnDRMIwOywBFSqKLXWsH/34mPlV9
	 6Z/vZWe/lIqMC5Cnyp86SOtVRvWI/qdbB0K6nMI9TKgEONPlilb/c8gOfxOH8CpsqH
	 giLI4Stt/6YsFC+0yROroPr0/dQcoL6af4eM2KZEYtFU7qm6auzjkc3xxDdGbx1W7+
	 N39ZX/MLnwP6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B09D39D0CA0;
	Tue, 10 Nov 2026 14:30:07 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] net: fix mac_len of skbs copied by generic XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179432100643.3999302.15619209426166377365.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 14:30:06 +0000
References: <20261103200036.65764-2-tianyi@cloudflare.com>
In-Reply-To: <20261103200036.65764-2-tianyi@cloudflare.com>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org,
 toke@redhat.com, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Nov 2026 20:00:35 +0000 you wrote:
> Generic XDP copies the skb before it runs a program with frags support.
> The copy happens when the skb is cloned, nonlinear, or has less than 256
> bytes of headroom. skb_pp_cow_data() makes the copy, but it does not
> copy mac_len. After XDP, the skb has mac_len 0.
> 
> Two places after generic XDP move skb->data by mac_len:
> - On XDP_REDIRECT to a cpumap, cpu_map_generic_redirect() pulls mac_len
>   bytes, the length of the Ethernet header. Then it queues the skb to
>   the target CPU. With mac_len 0, the IP layer on that CPU sees the
>   Ethernet header and drops the packet.
> - On XDP_PASS, the skb can go on to tc ingress with a BPF program
>   attached (tcx, cls_bpf or act_bpf). Before it runs the program, tc
>   pushes mac_len bytes, the length of the Ethernet header. With
>   mac_len 0, skb->data stays at the IP header. Therefore, the program
>   reads the IP header as the Ethernet header.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: fix mac_len of skbs copied by generic XDP
    https://git.kernel.org/netdev/net/c/71578e43b8a6
  - [net,2/2] selftests: drv-net: ping: test generic XDP redirect to cpumap
    https://git.kernel.org/netdev/net/c/71b116cf334b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


