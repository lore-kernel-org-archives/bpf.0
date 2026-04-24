Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656993016EE;
	Fri, 24 Apr 2026 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777002048; cv=none; b=pD+//g/KMWajPFrkvVrnsrhx9y5RKc+qaDB2EAw6ip7n9STXKoKCidDh0OpklRfAidkopDuLONGBpfN9ADWHULqxeehYpoAYB6/qYCTDFRiHURTYEKrPmBpG3NXYgY5aQKs1uHzXYk4nRAzxziYifX5clB/l5ymomqm196S8pVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777002048; c=relaxed/simple;
	bh=z+i21OJKn1la4NaUMI0aRtz/cLcc7j+ZFWCwDlyoWVs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=giVYiFIByu3zRtkvZDfZlbR++aFo8ROP7oK1+n+a3QmlfNz/fnkwpThk1neq/sNQt0Tbv91yvI3Oy7JB39ffgsbDOznwN+HeUwxs9IRa9qzdRUXO4hfBiKH8Kwfao1El2a/FWvp6GtPV+yNb1e+TwYB3Z2iSv9pRVqldcGHicKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjjyo3oE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjjyo3oE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB9C19425;
	Fri, 24 Apr 2026 03:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777002048;
	bh=z+i21OJKn1la4NaUMI0aRtz/cLcc7j+ZFWCwDlyoWVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sjjyo3oEkVTxHa3FH0hE4tGQ3jUmi1jWBdNDbamC8lcZWjW8Ykx4UdLn6my1AFifz
	 diUF4alVgaampnfdqtNspeBP61rHbJr2PxyoTiMU8voE4o7EdKaVGCb8TLZb9kN8ef
	 +XE+psYFesx/MSLKjJjJEDtaTOOS91CYLp+OJ3gWLWjVRR+KeV0uFOqcnIi5cEy1aJ
	 /MjJ/H8ialC4qJWTs0AeVZdZevA8L3X9+JsUDzHIpEzL/c2V0qYtdZz8RQ+FoDyOL7
	 sl4sZlH5EvVZzgV2yK7eg/SoxN3sXSJoGZcHKTxeFc1WtI/JLASjHpbgmilEgeo9g2
	 WJHMsEMwIVkag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE4A3811955;
	Fri, 24 Apr 2026 03:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177700200880.900079.12370704381484059680.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 03:40:08 +0000
References: <20260422065411.1007737-2-bestswngs@gmail.com>
In-Reply-To: <20260422065411.1007737-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, martin.lau@kernel.org, ast@kernel.org,
 ameryhung@gmail.com, leon.hwang@linux.dev, kees@kernel.org,
 wangfushuai@baidu.com, menglong8.dong@gmail.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, xmei5@asu.edu

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 21 Apr 2026 23:54:12 -0700 you wrote:
> bpf_selem_unlink_nofail() sets SDATA(selem)->smap to NULL before
> removing the selem from the storage hlist. A concurrent RCU reader in
> bpf_sk_storage_clone() can observe the selem still on the list with
> smap already NULL, causing a NULL pointer dereference.
> 
>  general protection fault, probably for non-canonical address 0xdffffc000000000a:
>  KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
>  RIP: 0010:bpf_sk_storage_clone+0x1cd/0xaa0 net/core/bpf_sk_storage.c:174
>  Call Trace:
>   <IRQ>
>   sk_clone+0xfed/0x1980 net/core/sock.c:2591
>   inet_csk_clone_lock+0x30/0x760 net/ipv4/inet_connection_sock.c:1222
>   tcp_create_openreq_child+0x35/0x2680 net/ipv4/tcp_minisocks.c:571
>   tcp_v4_syn_recv_sock+0x123/0xf90 net/ipv4/tcp_ipv4.c:1729
>   tcp_check_req+0x8e1/0x2580 include/net/tcp.h:855
>   tcp_v4_rcv+0x1845/0x3b80 net/ipv4/tcp_ipv4.c:2347
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag paths
    https://git.kernel.org/bpf/bpf/c/375e4e33c18d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


