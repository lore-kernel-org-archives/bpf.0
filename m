Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724411;
	b=Y0UAivbOppf9yXmj1u9+ZeURhcwQ4Fyko0qU9FruaT+PuTyuv0YYkcmZtVDT3kzwj0Zf
	 rRlMV3SUZrhWx8MlsOZJlylZB85E2keJxHRe1CCZnw4G/Tfo6mvGwCP5LVDuBpeAFUXGW
	 o6akdADLj1b+Klm42A4Xj+G8RYoOG+ov3UO8exRXZ04Ui9wUHfbvyNOTCrih6vWXYdRrl
	 1WL1/9t/RNbwfe/VEzKwkQeNa0NQ2pbW++gquPFy0ywqcejSxiKPX6+9LCWyQmvsB3Wvt
	 2U6K/XaDGX588IQa2ZW+MQ5FFd8Qu6MGbNs9r20cwIKOBRI0MxwQCFXqrY3ND3wKpaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=CLaBQcMsluLiCV/w9lKTfb5enmVgf1uI0kFQhXqbj4I=;
	b=0dWBjiUzYxaaQou/e+nwjqpi78m/vHYja4scdCx61s1cMEu8vnZpEGd8UybmQggswTzR
	 zBJoN3Fnas1hBM/fEYaWKKJq5139AYrNyIvJOlO6VYGyLqVvJXjyw2Hgr30nOEn87yh9j
	 I5i4NABvBMAD6+O6F1mdBXSCS/REuNtpO/DaqF19oz6Nha0YHcCBKSYM3vGPpiASJB8tA
	 6PWm5IbLcDT85UCCSsp966s8hGdiPPTx3iqRahACI/CzZx1MyvmAB+LXlC75uFjqtEhLQ
	 fsXQZaRDRwqPsRnpE/b/K3Y+0GP4fqvaDbYLks70qlV6XCt9zLFzx79dlmHdNkpggLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtlGc8RT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E8606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtlGc8RT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C991F00897;
	Thu, 26 Nov 2026 20:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795724410;
	bh=CLaBQcMsluLiCV/w9lKTfb5enmVgf1uI0kFQhXqbj4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UtlGc8RTRIfNkVWD0GLjTHrGCK12TTfC3f/+ASd33P7SAtYyiCj6kfZjad6Sn+Jgw
	 edtZhI/NbBqSYQfXAXYJZlTH5AB+1HuzKGkOvEnGc0h0wF373i6yOl2jYTj8j52hJm
	 XzdUiVmbOFM4izh6JhUBz+XYoZKyGce0bY03DTsqNZmjcCGdS/HJ3e+kOZMiLzTogG
	 e3Ph0z9kapmBjlNH7pIbb2nQc/ECdwydDnXjTb1nsmaVidLYeKUrgUsl9hNZoRaNLq
	 YhREu+lkxUM5jRIDhtCUPa3UR2rAzvXDc35gDngf8cXOmUchscxRzgNDmnJf7JOxxK
	 U61PNSOKu0EUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8383803325;
	Thu, 26 Nov 2026 20:20:10 +0000 (UTC)
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
Subject: Re: [PATCH] bpf: Add missing const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179572440925.600058.15609850494575559764.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 20:20:09 +0000
References: 
 <d2339f5ddaa65ea2e711bc063f53c6359d470370.1795628913.git.alx@kernel.org>
In-Reply-To: 
 <d2339f5ddaa65ea2e711bc063f53c6359d470370.1795628913.git.alx@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Nov 2026 18:49:33 +0100 you wrote:
> This pointer is derived from other const pointers.
> 
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
> 
> Hi,
> 
> [...]

Here is the summary with links:
  - bpf: Add missing const
    https://git.kernel.org/bpf/bpf-next/c/525f3c2552a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


