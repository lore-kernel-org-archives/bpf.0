Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6127FD51;
	Mon, 15 Jun 2026 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566832; cv=none; b=NbLAClD03u7W7xWCBXO7bEMFjrOaQ7yG1ymk+S2pLxVYs4nvSJ8MgRVHi4lbB9zlrLXXbpkc+boLUMyHGU/io1hy7hGITZmygI6d8iuYIAM2ngwPuQrCy9fY/eZvzJd7UfnMuuR6eG8BcIb6vvkE382n8MqXc13TPWWvOKYQMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566832; c=relaxed/simple;
	bh=YWFhuLh47LIuayAiYIm3986IlaylnHH07h8VfodK68U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IVuzs4veS94TyAEsX9JZdzXwkf3NTUGbHmcjH0rkYy3yybJtyq21M+Gr09kWpbY/PiE3Gj2Mp7lb5+z1GrkrACJAAv8Pg5dy3OK1y9S50Yf6BuoPLbPuIrEPiLHXNLc0klLB7yeCP+ZtNyGLegZWtlTbpvQw7TIk2QqjnRC4h+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S997qUK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S997qUK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9E11F000E9;
	Mon, 15 Jun 2026 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566830;
	bh=0HG/R2bpOUkgG08uopBzx3JjVKz2/3HN1JP1LTvWEOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S997qUK6RKKv1he7OdNjuWK4MJQAH2p6y4j2o86GRE4k6ZN/RDa70tfvb7JnuSBYF
	 cV/pS9yhDC/7PhpnY4cSNKCAW4s2ohMxsM3LGaQpZ3NGuShpUvcZSpyDHlmeO9f1AR
	 l3B5pRqKl/mvmbUfJQulY/M12AQPQKu/w8ID9GK8OJ2XnxH7uFDppVGnadNGZiF36L
	 oWBva62MzGekwdZvx2g2JvsPXKwbBAkrL35Y6AJNGRoVma1mqx9n+q6uAPugTSqDbg
	 J07xTrmLlbloW/EPBFOhM39NjHHs/iI/TYaLilez1AziFuN3JiGZGpkgBCYZyT4Qmu
	 6xPaI4ucSV1Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568963839A08;
	Mon, 15 Jun 2026 23:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v14] selftests: net: add local ECMP rehash test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156682488.339383.9205404821532401957.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 23:40:24 +0000
References: <20260615042158.1600746-3-ntspring@meta.com>
In-Reply-To: <20260615042158.1600746-3-ntspring@meta.com>
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 21:21:58 -0700 you wrote:
> Add ecmp_rehash.sh with nine scenarios verifying that TCP rehash
> selects a different local ECMP path for IPv6:
> 
>   - SYN retransmission (forward path blocked during setup)
>   - SYN/ACK retransmission (reverse path blocked during setup)
>   - Midstream RTO (forward path blocked on established connection)
>   - Midstream ACK rehash (reverse path blocked on established connection)
>   - PLB rehash (ECN-driven congestion on established connection)
>   - Hash policy 1 negative test (rehash attempted but path unchanged)
>   - No flowlabel leak (client mp_hash does not alter on-wire flowlabel)
>   - Dst rebuild consistency (dst invalidation does not change path)
>   - Syncookie server path consistency (SYN-ACK and post-cookie ACKs
>     use the same ECMP path)
> 
> [...]

Here is the summary with links:
  - [v14] selftests: net: add local ECMP rehash test
    https://git.kernel.org/netdev/net-next/c/ae57a5533243

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


