Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572008;
	b=GWmPDBLdZDUrQ8ghEq0XAcYHVRxl6diQB0aMONQxG49c6k/Pfi+PK6BjB85G5nmbnBDw
	 WrYrVIQWaFnXZ4SDy/H6VuQuF4kesvIJ+b63Hl7i5Ud3cEohnWtFeMX1mdcvbejo77vFd
	 3N/NZFNN++8pHSc3/JrF9byc6SOmhN+gkfyj0IDTC8niwQ7QBamr65Tzj3xaI+4E69/qx
	 GfT1LZoEgO7qU0SAOEGt+NT19T7/zjiecmQjx8wTQPCY2zteGvt+LKiBHv72lguqxz/29
	 ToBOSDE9mgav9ce6+hIIS1Ydl9A9W0bhHWIrfLUahaJNbIUMQ65lV+PVQr5pq/yZMwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=DVfwtxzzvnAJNGDvHlnTq0Okp2oOukMbqcZQEKS+xJI=;
	b=ABlCb8CdWbrRJYkBnfRLMA5NTf/9iWhWmyjJda2XeWdMLwPPIUsU/qJGOEEoYtHRCaAV
	 Kb96vDvxJq0/47Td8lnEzyfWLpid/D9QhcJIaz4s5sKYRFN2pmdbtm9PcOSI2CDaM/JRt
	 P3nwpAklpEPtYL9+Jv22VCypMFYs+xOeNQ8VXXKYKhMGCIz672AEKfu6T83IMn/qouAbK
	 zlaUEwrf6dp3reToO/lvXYT9dPAEEHSpzAC4VLABCryH/c2d5lTRAsLnJlmEC91TEMQrD
	 mzcNHRH5IbNvFo9Mc5xDDD/9TWusDscaSHVIq7fODBtoFdLresvJpgO6ADb4CU8dkCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ui691x3X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777B60A4AC3;
	Wed, 21 Oct 2026 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ui691x3X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FFC1F000CA;
	Wed, 21 Oct 2026 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792572008;
	bh=DVfwtxzzvnAJNGDvHlnTq0Okp2oOukMbqcZQEKS+xJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ui691x3XZMUSY9AIPhP2UWlcuv4HRaau+rB7h3Rp9utRpB7bOJXK4dyh5dEt4YVMX
	 WOmTkEXwWx8C+aDI+uXmXW/ZqrCAptbRe6gvgxJ3eR+EiOANEt5NRu4G2n3kvwHEkf
	 tVaKAlcNLujVuzL62UhcDnjTuHwKZWNtTiLwQKQ8qvQ9kuEhAZrnllfzbNy38MdFby
	 nwSSlQn9cGA3FSUXnVeoaJyWMr1LujYb+zMlsZWwL/68y8AbAR+pPdSllecBPboJ1A
	 uEXCWmg0SZd9z5qgwyKxToO5NqqTPt4lTbAhBMdmaGg8fnv1bTOA/VU0271Qn4JoDc
	 GYJGaDj0nTFWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15D13809A0A;
	Wed, 21 Oct 2026 08:40:07 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2 0/4] eth: mpnic: add basic netdev statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179257200678.486685.1500275130118777466.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 08:40:06 +0000
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
In-Reply-To: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, edumazet@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 Oct 2026 05:04:33 -0700 you wrote:
> Add basic netdev statistics and report them via ndo_get_stats64 and
> netdev_stat_ops.
> 
> Track per queue netdev statistics such as Tx/Rx: packets, bytes, drops,
> etc. The driver keeps per-queue state for statistics that is updated
> mostly from the NAPI poll and ndo_start_xmit paths. The stats are made
> available through the usual driver APIs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] eth: mpnic: count packets, bytes, and drops per ring
    https://git.kernel.org/netdev/net-next/c/554c7af9367a
  - [net-next,v2,2/4] eth: mpnic: report per-queue stats
    https://git.kernel.org/netdev/net-next/c/5cc79ff41b07
  - [net-next,v2,3/4] eth: mpnic: count Tx queue stops and wakes
    https://git.kernel.org/netdev/net-next/c/3b28e126619f
  - [net-next,v2,4/4] eth: mpnic: count Rx allocation failures
    https://git.kernel.org/netdev/net-next/c/ce0d47658920

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


