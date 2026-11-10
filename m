Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286391;
	b=hPnsXt+yrw3jlTiJoyaHnCooCXlFjsMKCq47uKqpXTLE1rbNanyEnKiIGoKr9/Uq0oB6
	 MrKWl7WiN3GJ94xtw0T9ZmVnq0J8+R99fMoXe0f6vsZoV11BxWyuAbtu7iBwuBYWVOoqC
	 KiMz0g3FQC+ttruRU3lpPG5zJYDR0Mh/R9qQqdNRx8fT+aeU3Ke9o5EXHaxr+oaOiERsC
	 U1w7HGIa195gLnVuH+9FtGH4qbJWtCQbiolvbm1zZKs/jKQ62Tahe+IBk2SP8IoN/xdLK
	 BStNjdZPDjyIoLXVxhWs5i2CowS0dbd+AbQYmg1fE/oRAuF7laFxPpaOB/5NG5V6fvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286391;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=USevh6myHxF9emjydPOskkqmK7kqM8+0knzfuWzYf2E=;
	b=UdbQNvq+AhNQllKRfthI7cCVIN5kWaDmoIjPhYdr4zdr/6EViUlBv9OaBn+7y7KOl3/h
	 HQprTnPL8lC5WIXb4Ogd7ZF2jSCn4JvHWBEr/Yj5fRuy3iF4a2KzP6wGb650mSRSclx3r
	 lsaih7NgTxgzqfN06Ed/XsY/vX77Idhw6BdTOEyVYIMrdc7e494ZqwoM5luei8r4RmCul
	 fwdmIx+4PLqAr3hOiHrMdU8dpaB+2YiHR9xWMlSMaKS0JJR5ff+qaQIRVY5NPPUxXQXeB
	 qxzhD6BcHsqVG6AlV7HkYaGVFiESXmBjBFIJUHDDiWHzM10cejw0E0GsfAlOdZ45mYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=fail reason="signature verification failed" header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS8QK0uX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F06606A31C;
	Tue, 10 Nov 2026 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS8QK0uX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1361F008A5;
	Tue, 10 Nov 2026 04:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286390;
	bh=USevh6myHxF9emjydPOskkqmK7kqM8+0knzfuWzYf2E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bS8QK0uXH4CiE/pecLjA47r/58HoMdCcVoCr2Aj5ZbqYX8FUfQZw+zR3zouV2mNmK
	 P0Ggop74FtzZ/noDXpDOmBsU8LuIgDwsRcOwIQBKYfTvnSFlvYyQp6mhCsrJj19i4E
	 8AtFDqwQo6XuCCnMThbj3A/mquKdc778AaGUdSGFxFPfR9Cu+cvr37erupKdTLZRUZ
	 slkziQBQN18Ol9bonmpQusu/LLhK4gYdx+hgOYyYs6truDVcFXoA9KNDzIfFgeEexk
	 mh+SsRfu9Yhsgls4oSul1YEhpSfuBnkutavrJtXalAsKNTjUPk5VxJ5Nr9VxAgQYoD
	 qETaCtYdWvXGA==
Content-Type: multipart/mixed; boundary="===============6368028081372406392=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <debeafe053a315dc6c0634d019ea48075d9f9f0c68b4395deed84a9630dc77ab@mail.kernel.org>
In-Reply-To: <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com>
References: <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com>
Subject: Re: [PATCH bpf-next 10/15] xdp: warn on XDP_PASS with stored values when XDP runs on an skb
From: bot+bpf-ci@kernel.org
To: tianyi@cloudflare.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,kuba@kernel.org,hawk@kernel.org
Cc: john.fastabend@gmail.com,sdf@fomichev.me,lorenzo@kernel.org,deliran@verdict.gg,davem@davemloft.net,edumazet@kernel.org,pabeni@redhat.com,horms@kernel.org,andrew+netdev@lunn.ch,donald.hunter@gmail.com,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,maciej.fijalkowski@intel.com,aleksander.lobakin@intel.com,magnus.karlsson@intel.com,tushar.vyavahare@intel.com,kerneljasonxing@gmail.com,razor@blackwall.org,madalin.bucur@nxp.com,ioana.ciornei@nxp.com,corbet@lwn.net,skhan@linuxfoundation.org,shuah@kernel.org,rdunlap@infradead.org,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com,carges@cloudflare.com,jakub@cloudflare.com,linux-doc@vger.kernel.org,linux-kselftest@vger.kernel.org,intel-wired-lan@lists.osuosl.org,llvm@lists.linux.dev,kernel-team@cloudflare.com,tianyi@cloudflare.com,ast@kernel.org,andrii@kernel.org,d
 aniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:53:09 +0000 (UTC)

--===============6368028081372406392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> xdp: warn on XDP_PASS with stored values when XDP runs on an skb

TL;DR: Comment nit in xdp_skb_ext_warn_pass(): the new
generic-XDP/BPF_PROG_RUN comment is inaccurate for BPF_F_TEST_XDP_LIVE_FRAMES,
which uses a separate rxq, and the next comment is now stale. Not a bug.

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c

[ ... ]

> @@ -1124,12 +1125,17 @@ void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext)
>  void xdp_skb_ext_warn_pass(const struct bpf_prog *prog,
>  			   const struct xdp_buff *xdp)
>  {
> -	const struct net_device *dev = xdp->rxq->dev;
> +	const struct xdp_rxq_info *rxq = xdp->rxq;
> +	const struct net_device *dev = rxq->dev;
>  
>  	/* The skb is built later from the xdp_frame */
>  	if (prog->expected_attach_type == BPF_XDP_CPUMAP ||
>  	    prog->expected_attach_type == BPF_XDP_DEVMAP)
>  		return;
> +	/* Generic XDP and BPF_PROG_RUN use the netdev_rx_queue xdp_rxq */
> +	if (rxq->queue_index < dev->num_rx_queues &&
> +	    rxq == &dev->_rx[rxq->queue_index].xdp_rxq)
> +		return;
>  	/* No native XDP, so only generic XDP or BPF_PROG_RUN runs on dev */
>  	if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC))
>  		return;

This isn't a bug, but is the new comment accurate for BPF_PROG_RUN?

With BPF_F_TEST_XDP_LIVE_FRAMES, xdp_test_run_setup() registers a separate
rxq embedded in struct xdp_test_data:

    xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0)

and xdp_test_run_init_page() then does:

    xdp_init_buff(new_ctx, TEST_XDP_FRAME_SIZE, &xdp->rxq);

so in live-frames mode rxq != &dev->_rx[rxq->queue_index].xdp_rxq and the
early return is not taken.

That also makes the following comment stale: generic XDP and non-live
BPF_PROG_RUN now return at the new check, so only the live-frames
BPF_PROG_RUN can reach the NETDEV_XDP_ACT_BASIC test.

Would something like "Generic XDP and BPF_PROG_RUN without
BPF_F_TEST_XDP_LIVE_FRAMES use the netdev_rx_queue xdp_rxq" match the code
better?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755842687
--===============6368028081372406392==--
