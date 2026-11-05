Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877608;
	b=ByZxJqYwgJ1fC2BA3hzf/+xTWdlkDAxKlKAW1mmNvzCH9PE98kXb1ecPXYck46IW+Arq
	 whxO+3hab5AG/SO8gc5sTWnPqExUFwDSqMwUzV1CKcMA35N8lsLlTnEKu4nOPSKmmkEtx
	 uYPl8LkLVcpg5DLyuoen4ikajCWrPfelcYq9UIBnhiVRmTBWPLHG/lWtrtaRm7w/bAlbA
	 tBYPXXtmsXJTDDK0Ij17WMtwORrS3+hJWBc9ywcmcwVF235kccrl9dy2vj7fta6ShZlQR
	 4wadSQct4kfO5mtW1t6hU6TAmdgFTfXb1clWPEVi02KsfpLDGzr46uf0P9qtX1Kd5hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=yJ6jwCSMdHazaeDevwzr1iFTTCXWiF1dUr52R0r7mYk=;
	b=I0gnmeM7iK+BAySjVtEZF9b29U73z0xEKpgdmZp1NGKLrfmZa2Xb3c3Nbw3Yd20z503U
	 IYze2dDcq2H3LJwXxrPhCwmd/cHAE7MtS6l/mF8dOpeuc39Ms9+ATox2gBXdGF+Wbo8Pa
	 lq1A4TNIS521egoBcleAgkkrNz1nAoCQZbEJ3d7HL63MY9nt9Oyz6QslQk0JKY47rIbyM
	 UrXb60Rp7Poa2HF5BP4AiGtC6GeucxMTStBIVvrXkvFpvqfXP9eJJTHtr2YfGtBjkmg9S
	 JGzNb+Zn/T3gSkB1DdPhbHTgpjP8VYpmQBW9j2hzJY0K7z4IIb6OqrO8yHv+klFDP+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SpVxVr/C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E5606A330;
	Thu,  5 Nov 2026 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpVxVr/C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485A41F00A17;
	Thu,  5 Nov 2026 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877608;
	bh=yJ6jwCSMdHazaeDevwzr1iFTTCXWiF1dUr52R0r7mYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SpVxVr/Cw/EdfQvRxRLWHRgtTYDRNsFlejkW1DKj9y6mFbs0d6wtmiQUVzbDH+S8x
	 C1fsuU3kV1LU8WFI/BuA7PoAOUBXWrOB+3kWdJPJ6jBEP1zubRVuEXSzziHNn1RaBj
	 eyRxgqo49S0yEDFpjHP7lxeLZ79dthD7bwSKyVIrYmePCzcrPwbHTGLyZ+GZE4VBfI
	 VFWolX4MfMcMurvJRZmpxgIjIxHPFExEKtPXTe1Md7QODFLbuFBvoTx07kuwCHF8c1
	 zmHewHhaNDBIoHkdL4v6IZWDZ/K3FymWEbict/3t2V/8i934ODuGbyViXl6OxURwyQ
	 u8ZCg/aJT+KUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400FE391AFCF;
	Thu,  5 Nov 2026 11:20:08 +0000 (UTC)
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
Subject: Re: [PATCH net] net: stmmac: set XDP metadata length on the page_pool
 RX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179387760679.3608225.7162106017208201958.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 11:20:06 +0000
References: 
 <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
In-Reply-To: 
 <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, yoong.siang.song@intel.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 02 Nov 2026 12:46:04 +0100 you wrote:
> stmmac_rx() initializes the XDP buffer with the metadata area valid, so
> an XDP program can reserve metadata with bpf_xdp_adjust_meta() and write
> it in [xdp->data_meta, xdp->data), for example to export the RX hardware
> timestamp obtained from the metadata kfunc. When such a frame is passed
> to the stack, the skb is built in place around the same page with
> napi_build_skb(), but skb_metadata_set() is never called.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: set XDP metadata length on the page_pool RX path
    https://git.kernel.org/netdev/net/c/6d9b7c85af57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


