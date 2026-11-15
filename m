Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708008;
	b=KlgI36+HkWZW7nIg28Qnv5JHcLfp/Y7zd53pVJPlLsB55iSt2yEcw1UrT2K7Itc1Fg5l
	 ocbNs4nLqoRfGzEGZ1LHK1sCNlS0rbFkAqgNQmxBoGxR9ZK5Xv/3PhNfIcFXKN2gbx/HB
	 Q7hbpa6fN5VfiugFfRNDl5eH/RIDWJAflcnf0XXFF9uvb9UyioBcHO3u0NJk/Zg7meLuM
	 D6GH8wwCrRfntbvj+CYdE1siqmEzDkTs0xC+6d/ZQu7PZkiNyzahL2lIpuBmiXRVjtj3n
	 FV4FF7ZGdADBgkumlXI5PRtxQ2IDHy3DPVUjYFK+KYWblhHwVbew1bSmcb6TgMEGpDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QJDJ8+4L0JyVB/Pic2Ka+NweJk2nPMK5pxQBaooRh5I=;
	b=Us9DoxCNdKYJG0M+jSnJXRYAJuHM5xO+R72gixNAmk2gBqY+eLWSi3/lEvH03QTtxo5E
	 TeosbSiIq4sMFTAqvug9omozuCbacIqunn7ZE0j9Okpm9oO8wBtQwruvHDuUhjcn6mp6O
	 Kcu4z7KkqToBi2b29CAXsHpcgNlaDwjIQ1uR1SvNgtkn0Hu6CuU0bAX+rDdF/Cdk0exA3
	 UhfxpxSwiqp2j3iIUaMABb5TjMU64szoFuuDvaH1YPivo9W5R9Sk/9mveajpYf04yJsR1
	 WCB9eKfSA+xoFSON4SwM4TA3AEY5QqVuO/dyt8kH9GHacjzCPTOpR+B5xYCR5mONL/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gv1mbzv6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873F606A323
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gv1mbzv6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6A81F000C4;
	Sun, 15 Nov 2026 02:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794708008;
	bh=QJDJ8+4L0JyVB/Pic2Ka+NweJk2nPMK5pxQBaooRh5I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gv1mbzv6P0UMCgttA/mfrWTzj++/6vbEEJeE6m7z3jMJWpYJg6mH1W32x/pcGUWeh
	 XPEc2JqoDq0NGXUNyC0jrngSwKyMqERn8lioHEIFojFqKolZj2ldqsVuKqBh82jtkP
	 bfHwnT23POXSJwlJR8UyOm6676CMs3IDal1D1QdIwvKJSoueGvTQmnHvYjUgUhJw/a
	 fz0a0lbmQ/7nnAuDjwu48U9z9ZDlKoyq359DC3uc16lGEgpTzZkS4i/OeLmCCyRQrs
	 S8EYhNhCMZC70j70emAq3pSDAsURRO/kYgpgQLiXf8+R37Xn9PGWJeKx8u1KrHyj1G
	 pPJVFqmoTUEsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15133808210;
	Sun, 15 Nov 2026 02:00:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] bpf: Quiet two smatch warnings in the verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179470800653.2445485.3258690472659285371.git-patchwork-notify@kernel.org>
Date: Sun, 15 Nov 2026 02:00:06 +0000
References: <20261114232526.2727027-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261114232526.2727027-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 14 Nov 2026 23:25:26 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The kernel test robot runs smatch on bpf-next and reports:
> 
>   kernel/bpf/flow.c:2758 flow_merge() warn: missing unwind goto?
>   kernel/bpf/scev.c:5350 bpf_widen_scev_regs() error: we previously assumed 'reg' could be null (see line 5336)
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Quiet two smatch warnings in the verifier
    https://git.kernel.org/bpf/bpf-next/c/283fb1db0d42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


