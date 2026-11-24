Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795492206;
	b=D8C/qCqADSDHo8U/xKiNVqm/cZ9U2ukIsaY1asclFGQw+SGoCHUPZidzvZZebJOdGNNg
	 uZstoNMKHy/I8pUvlpT79cN8Z8e7HnTLVnbVXPXRAdXYBh7TbbIXS0Z/BP36ngRHouzuf
	 AN6tDM2cZH36cSD8DhIMSTMRwUONt6jMrL8VU170DXaymVwWwMduOwZRlr/I5v/+hBqnA
	 rXV5F58lZ3pvMv4TOnUso3j9v8OyXZj/RxrWAxgPoUnEXKXZwYlLZMk0SPSFm1oNpTxFX
	 lmLappULaIpT8SA40Dzax1QV2j8hlYMA62pNj5S3vZGPIXfPs1HxnJWIVVLkAVaIh2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795492206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=YVPXyJMQigH1Kiu5fH5Sm0imCNiie4ePM2h7KAJUg1M=;
	b=UQG/MvSSaDksj3y4hlOd/JOw+hou9Q5zP4Aslzc3xGsRvGhqG+eYFS8tOQ9jImVbmz9a
	 3fLWdWhnqlxPjQ5J+bCi3940njbihKzMYdRRcHjklJlfeAFAQIFgFvgeKidyChKzr+WDn
	 O+rOS25umCPnXpXVyob2R1LVDpfBMd9fiRbcKbcKonQ6gD7Her8l7MHxpFwcRgF71B9MO
	 WRK955cFlkbQMoh5Mc/nDoBwfeL71UF8rrUDJJwhygaG1HrRGudilD8VB7xyaIi6KZyf+
	 bHTzUdH1aWJQxP/OiLGhaCZp4Xi8Ibpj1xny3j2MdN2glCSTjbQEFxskHQMDbiXw2lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvUIS1rh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08027606A31E;
	Tue, 24 Nov 2026 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvUIS1rh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436021F000CF;
	Tue, 24 Nov 2026 03:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795492205;
	bh=YVPXyJMQigH1Kiu5fH5Sm0imCNiie4ePM2h7KAJUg1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fvUIS1rhI/cR63wEIvo/JCGshcKuP68lTHZPITiexpmcM+dEdh9G9aSvg2zwkur69
	 hKiwePAU3dwwx0UU6IDVTKG2lKG6ZsnH+PaQrYSIVy2g/4xEjK89reoOXyRd21GSzE
	 rduEeEemNzUUUW4Y2ZRFoU2TeS6WvBapyYJGGPDR9lHUnAjIrAt6NViJb+cQEwHRoG
	 Wi7zZDS+8ctG0Yai+j7dKUYonjpHtvykpt5XTmaYlr5fUPDl1OQqMx6v0A0sQmVt6B
	 0eBPibwgZMox1OUy2z2eNXdLX4GKysdIyK9MbExvY755qUR6dQZTqpW09Lm7JKCw4y
	 1/BJsgl2xVXYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A39639302D7;
	Tue, 24 Nov 2026 03:50:05 +0000 (UTC)
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
Subject: Re: [PATCH v2] net: sock_reuseport: check program type on the
 migration
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179549220403.3266642.5931361258119056737.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 03:50:04 +0000
References: <20261118153541.172499-1-shlomojune6@gmail.com>
In-Reply-To: <20261118153541.172499-1-shlomojune6@gmail.com>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, edumazet@kernel.org,
 kuniyu@google.com, pabeni@redhat.com, willemb@google.com,
 davem@davemloft.net, kuba@kernel.org, horms@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Nov 2026 23:35:41 +0800 you wrote:
> A BPF_PROG_TYPE_SOCKET_FILTER program can be loaded with
> expected_attach_type set to BPF_SK_REUSEPORT_SELECT_OR_MIGRATE and
> attached to a SO_REUSEPORT TCP group.  Closing a listener that still
> has queued children then runs it with a struct sk_reuseport_kern
> context even though it was verified against struct sk_buff, which
> KASAN reports as a stack-out-of-bounds in ___bpf_prog_run().
> Reaching this without CAP_BPF requires
> kernel.unprivileged_bpf_disabled=0; with
> CONFIG_BPF_UNPRIV_DEFAULT_OFF=y, the Kconfig default, the sysctl
> starts at 2.
> 
> [...]

Here is the summary with links:
  - [v2] net: sock_reuseport: check program type on the migration path
    https://git.kernel.org/bpf/bpf/c/cbaaeff649b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


