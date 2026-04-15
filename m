Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD897225397
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244853; cv=none; b=GF8xCLAYHKZgPMaw4PTXUZPEgBV7eYzTRf0KySG/2Phlpfw6xzB8XapO4zVPB0zbSEreFFPocyNzpX7DqM0IQhlnC9scr+TSq6LEzdMaov4UaM7iEa8c5IRmHRxjtGDresWcR4wiSVfueA/iSnnz9jCt1u4JpLouzS4pYQdYXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244853; c=relaxed/simple;
	bh=WdKNQN0EeATzhbGLdU9WBHDnLcRzwMflBgTTOzt+Wm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mvri3B2FPvMMi1msXoiFF2z+2RRYIFTeykr0EX3fQnz5Wq4fKQAlP0/WXQnRW9Auc9+/KjLD6JN2wrOyYoGwI6HhWcnud72Ctp69F5XAZLXBCW/MFGpR6AMGY6sezRlVAOY9s+3Zju2eMv4dj+ZHeJ8BR1rOlmr1Mu0GVWTIF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIca83Tq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIca83Tq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D0CC19424;
	Wed, 15 Apr 2026 09:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776244853;
	bh=WdKNQN0EeATzhbGLdU9WBHDnLcRzwMflBgTTOzt+Wm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RIca83Tq9HCJCl+409E/0PUsTjBznNecINxNyJ3tQln594JctnDRVfl26T0/mhX2u
	 d5HBa2/be3TVpqMFvNAftTzrityAP/CxXH1qv2EQV4Nc5tanv9MHAnHs2lD24ExtsO
	 +2BCLYF2aMk2M3G8k5fMmeIWYwC6PA2ccG6bukcuEJ4BqM6Tgz+0w3GhsdZlCCnAxw
	 LXMHiNQDrBRJhweWCfLoZaQgOiA95hvHSm/tnwEeV/6irnQmhDiOxIydpCsypbjyRh
	 LfbdxQ9ksbaUhvlapSUW+yE2MnBUR5WWUeXP4huGssV47KnRaZnv2K/HeubfmPid+M
	 WxSRG1P+zeyBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v4 12/14] xsk: separate read-mostly and
 write-heavy fields in xsk_buff_pool
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415082654.21026-13-kerneljasonxing@gmail.com>
References: <20260415082654.21026-13-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 09:20:52 +0000
Message-Id: <20260415092053.72D0CC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The patch groups NAPI RX write-heavy fields and NAPI TX write-heav=
y fields into the exact same cacheline, introducing severe false sharing be=
tween RX and TX CPUs.
--

commit cf39ff4311089098b2e57c37ba6e85e7a36ac4a8
Author: Jason Xing <kernelxing@tencent.com>

xsk: separate read-mostly and write-heavy fields in xsk_buff_pool

This commit separates read-mostly pool geometry fields from write-heavy
fields in struct xsk_buff_pool by adding cacheline alignment. This is
intended to eliminate false sharing between the sendmsg CPU and the NAPI
TX-completion CPU.

> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 0b1abdb99c9ea..0376bd4cc95b0 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h

[ ... ]

> @@ -73,23 +73,27 @@ struct xsk_buff_pool {

[ ... ]

>  	void *addrs;
> +
> +	/* Write-heavy fields */
>  	/* Mutual exclusion of the completion ring in the SKB mode.
>  	 * Protect: NAPI TX thread and sendmsg error paths in the SKB
>  	 * destructor callback.
>  	 */
> -	spinlock_t cq_prod_lock;
> +	spinlock_t cq_prod_lock ____cacheline_aligned_in_smp;
> +	u8 cached_need_wakeup;
> +	u32 free_heads_cnt;
>  	struct xdp_buff_xsk *free_heads[];
>  };

Could placing these four fields together in the same aligned cacheline
introduce new false sharing between the NAPI RX and TX CPUs?

The fields cq_prod_lock and cached_need_wakeup are updated by the TX
completion path.

However, free_heads_cnt and the free_heads flexible array are heavily
mutated by the RX path during buffer allocation and release.=20

Because cq_prod_lock (spinlock_t) and cached_need_wakeup (u8) only consume
a fraction of the 64-byte cacheline, free_heads_cnt and the first several
elements of the free_heads array will pack into this exact same cacheline.

If a deployment pins RX and TX interrupts to different CPU cores, it looks
like this might cause continuous cacheline bouncing between the RX CPU and
the TX CPU for every packet processed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.2102=
6-1-kerneljasonxing@gmail.com?part=3D12
