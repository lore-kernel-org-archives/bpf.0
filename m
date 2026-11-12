Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516607;
	b=kFsMIBlqeofd3b81zP4fl+ioRoxyDPHpMzEKn2vlc/XVSXjbxFKVkrTmccx+1URkrFbE
	 U67Kmtyo705aEIJI5U9X+Y+gC0t8QYuAfUqZA5danlqo2TTD/OFaWZzDpu087P/iHAyY3
	 wXScmFd2M/BSfz+BcbVpAS3G6X4DGszfBhFUHe7xgItPWCLq4oJROpEjpVesXyJz9CLjm
	 ydwFLJzA5e0yrv2wC3RJ97657MDps4EIy1zudJNXknQehsAPHSBBMzrTgXSW50XTmWqKa
	 z182F0eb/R40MtOIonmWtQggp+DEs9tf2Mbo4DJa09mo2QQjdCw9CGuJ9to1TMD7lXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=8q2OZbFYe0B6WBtw+fdxfTx92fe7fmbKjrQa9dDCwWs=;
	b=BxGzUyXbeuVCgbkWbK1tZ3Zfl0jqNZOpu0zpxXGr8IztphrIpV/qrd2+ZDBOxPDY/zNv
	 AhHxMSknrlFz9wU1WuzapPrJ64DxJAFwvUBXEflEp0bu0u33+2gTqPhOtsA2rBno/zcRU
	 FmJ0bGvIJPXRHp/9H2PYDmRBy9fRXZw1p+vPYGBjl5ofdDctOvriDaSaWkWF4Fudjj7s/
	 4oXrld/t4AqIAM/d1Qe+u06pNLaMk7rO8VnxyAj7bK2qywJaZcYvZzUTQOQkhBs68OkqE
	 3PCV4Wy8M3uhmkxfASX/tSdDztdgwOCOzGMP8aSqCIq/v4b/MmLINWh0WC8a2t48bAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W0htGok/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDD606A333
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0htGok/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DAE1F000C4;
	Thu, 12 Nov 2026 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794516607;
	bh=8q2OZbFYe0B6WBtw+fdxfTx92fe7fmbKjrQa9dDCwWs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W0htGok/zeGc58qGMy0RbusiLTGvtVi9Y5r7iUofyau8hLltWh/2R6mPFduCocIUI
	 Ai2ZJeTY7SW5Z4llphzyx5OKAQq6LwVokZ2Pr99Y8c4rCwMlewzQ15LjiaNA6FQV3b
	 ohUNlwYUIrz4T6bQAq0JWxEfifNT/FHYsB8XXy0136rB+QOZ6PsI+4qCydxlGTmDxs
	 cPZ4I8W5xXmexqBIaYOxtq0EHw6kiIpiK6+VHRQw40mu7BkojHoXbzveUEFxRYV8dv
	 xc3Lzcs00Cli4hqKhdrpSUbsxXqN8BJTLe6Vjl+DxlnFev3KfBzAAjMHDs2rLT/GfO
	 zAu1DAIedw8zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3F43926266;
	Thu, 12 Nov 2026 20:50:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf v3] bpf: Check variable-offset accesses against
 special
 fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451660578.639875.6945741268401306815.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 20:50:05 +0000
References: <20261109094723.14614-1-shlomojune6@gmail.com>
In-Reply-To: <20261109094723.14614-1-shlomojune6@gmail.com>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  9 Nov 2026 17:47:23 +0800 you wrote:
> btf_struct_access() rejects direct access to special fields (kptr,
> ...) of program allocated objects, but for a variable offset it only
> checks the access at min_off.  This is enough for compiler generated
> BTF where members don't overlap, but btf_struct_check_meta() allows
> overlapping members in hand-written BTF:
> 
>   struct node {
>           int arr[4];             /* offset 0, size 16 */
>           struct foo __kptr *p;   /* offset 8 */
>   };
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf: Check variable-offset accesses against special fields
    https://git.kernel.org/bpf/bpf/c/b7cc45994c3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


