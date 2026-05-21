Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0135675C;
	Thu, 21 May 2026 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375006; cv=none; b=bZRO4DbvKkB8voNInCCWd7ZIKjwGcYPnvT2pCoRbQRnnkraMhEzWckFJXCIj93FumBx9l2wT6UbIMcDfUsMYBUNvW63cdFR3dCb4X9FCYTfEL4HfLvaDt1fH2Xi/hd629nl8Da+ZaxxT0Um6OqlK87IRCAuI9PKy1lJPukQgybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375006; c=relaxed/simple;
	bh=6ZXrLRQJaVUkk4RLvHu/IuNp63JzBiutBMedmCXCipw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jMsvy25mHhwaYDVpIKgRPvZdeE+gvsuNFV2VhYE8NlaPjMmoELJtDRjPmMe8l/r8gUO6fZazzzsR3u5rQMXz136WeG7TjfDZYCkgrFELyHrPnaxx9V2Jv4HyqqQxBB67LvDdIHRjVwVOThyYPjwLmuPMB3RRKTjkKt/WavgoYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwux+s+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwux+s+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9E91F000E9;
	Thu, 21 May 2026 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375004;
	bh=Y5/Yk2ZnXM1T3ZsKaelmlrfmKvHwGGyAGp4YK4SZkGM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rwux+s+PrmTcHuAQvSRUDh6xWYNHUXfdGOwTbHfR/MhJNRlH212YEh8EBzicJQ5nd
	 03tT460tutB8+vCLH6ZHn8qLItlXDOn9VPK4Vn6KuWnvqBZENeilvZg/EbWXOPP6HV
	 BKygrNvqJaKYvtbPn5BexURIOoX0YeUiP42KyMsg68MFpAtGT/DzKMo2fk5FIFzv6z
	 6hR87ztq90EhfWpOllcqDbanPrr2EvTuVu7ia4pdJHEhS8KsAtl2iHlA5FH9HWK3GN
	 b60KJ60Pe12PiCVtod2lGAcWLbKGEjAMFygHjbWKPrUI3x5wQJCY3nGY/jC3iNsOBs
	 AfLZHj0BMfXdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A853930DF1;
	Thu, 21 May 2026 14:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: net: Fix checksums in xdp_native
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937501442.361786.10654244140459827358.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 14:50:14 +0000
References: <20260520153928.3371765-1-noren@nvidia.com>
In-Reply-To: <20260520153928.3371765-1-noren@nvidia.com>
To: Nimrod Oren <noren@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, mohsin.bashr@gmail.com, ameryhung@gmail.com,
 martin.lau@kernel.org, dimitri.daskalakis1@gmail.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, cjubran@nvidia.com, dtatulea@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 18:39:28 +0300 you wrote:
> Data adjustment cases failed with "Data exchange failed" when using IPv4
> because the program did not update the IP and UDP checksums in the IPv4
> branch. The issue was masked when both IPv4 and IPv6 were configured,
> since the test harness prefers IPv6.
> 
> While here, generalize csum_fold_helper() to fold twice so it works for
> any 32-bit input.
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: net: Fix checksums in xdp_native
    https://git.kernel.org/netdev/net/c/dfc077043351

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


