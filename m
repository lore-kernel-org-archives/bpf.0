Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286389;
	b=yvohGxFcLMzatlXUtvtIo6KXVX3CP632RKGPLHsMzib3ckROqYDyBFVIVvgmfb631GZH
	 nbeRtrYOGoUKWjdX3Vt75CHVrXfok53YCueF2k33J7l+QnqrWQUF/CIDQ49+SYwj44zi9
	 OIp1XTuzv0gHWxSZ0eeFRugS84K6n2/zMaxUyGDBFFTanBLg382ZLjTm8kOqWp4Dd0YhH
	 /Zq49k2hr1MpjeCUVAiIy9QaUJAIacTKGRyoqUyXkMjGAK9x4lqd66BGNFtgJRQSMpWls
	 2D5tsCU61XFgOeXj+QaeSlJE1/xjTINm5oxDaegCVmC33QBye35bFVdx+ZU5NFUa5QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286389;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=kqmjBtXE7ujUmwu/F7BLQZ3+Q+KZAoq8PrY6Vye5p3k=;
	b=GLQrZPJhyOuqOY0Ri2OGRPGqCGbXCm2u33lJXK7H9rqCjtdONTuywMgD11lkCuiSTjaK
	 9edxKAXX49OTMuhn2n6waLX551XXhaEYHQ0lxcnwSnPiowfrpLi2+JJps8Jx8LH7uKfLD
	 t6YQ5sRPfZ8fx0WsKK6nMMkhKXDl4vnjuSCYWQUITOTa7xAti9qVsAalQogbdYxF2V/Mm
	 ajGQ2CyZg5RtCW/IGX5DknzGJNURQ0TStf47iF0/5r8HnjGnPoiSWZrlnJjPXG68mmdsO
	 3IAQQRuM8EtUu1eN6c23IBR5akMU6tAAc93yLDAHfPp4JSkuqHKwE0y+HNSlHL1KlVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=fail reason="signature verification failed" header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7fB0Ilp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B9606A31C;
	Tue, 10 Nov 2026 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7fB0Ilp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E061F0089F;
	Tue, 10 Nov 2026 04:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286388;
	bh=kqmjBtXE7ujUmwu/F7BLQZ3+Q+KZAoq8PrY6Vye5p3k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d7fB0IlpLWmUwbDnryvM5899pnrNTy5uNETPNZo840EgVLOP5+et3DY1L1Qn+goyY
	 jC65QlAsFDaZ8Cg0+U64X87GX9rI5gST4yjS8h1vyOu82+J/UjtCoDDZe7Mx62gDus
	 vaOgk9mRXZzvLBC/r3kQf+BvBzLZ/LCCBmJvmvFaZ/WFNN5VqU54YypfozcpAQWFhP
	 NZIPFQ+scHgXZXkTxXRYTzYy+NH23fpvr+0/q0LO/CBEpvF2NYAjb9eQVZol7uYg7z
	 IQ3x2uwPyORm64Zt4T5y9R+4knhriqmU+dhQiYwyw30sjzyYFfi6teX8lYRPY1WFd+
	 lSi9fBytYHlRQ==
Content-Type: multipart/mixed; boundary="===============6053616401328202004=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7ac9f990a73ce7a3fb3eaca0830962acb0b4ef0585c7429c89b22b7244a2925e@mail.kernel.org>
In-Reply-To: <a37a908598e396446c1a389e3a58a1fe44a514ac.1794281983.git.tianyi@cloudflare.com>
References: <a37a908598e396446c1a389e3a58a1fe44a514ac.1794281983.git.tianyi@cloudflare.com>
Subject: Re: [PATCH bpf-next 15/15] docs: net: document the skb core extension area
From: bot+bpf-ci@kernel.org
To: tianyi@cloudflare.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,kuba@kernel.org,hawk@kernel.org
Cc: john.fastabend@gmail.com,sdf@fomichev.me,lorenzo@kernel.org,deliran@verdict.gg,davem@davemloft.net,edumazet@kernel.org,pabeni@redhat.com,horms@kernel.org,andrew+netdev@lunn.ch,donald.hunter@gmail.com,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,maciej.fijalkowski@intel.com,aleksander.lobakin@intel.com,magnus.karlsson@intel.com,tushar.vyavahare@intel.com,kerneljasonxing@gmail.com,razor@blackwall.org,madalin.bucur@nxp.com,ioana.ciornei@nxp.com,corbet@lwn.net,skhan@linuxfoundation.org,shuah@kernel.org,rdunlap@infradead.org,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com,carges@cloudflare.com,jakub@cloudflare.com,linux-doc@vger.kernel.org,linux-kselftest@vger.kernel.org,intel-wired-lan@lists.osuosl.org,llvm@lists.linux.dev,kernel-team@cloudflare.com,tianyi@cloudflare.com,ast@kernel.org,andrii@kernel.org,d
 aniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:53:07 +0000 (UTC)

--===============6053616401328202004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> docs: net: document the skb core extension area

TL;DR: The docs don't match the code: the "lost metadata" warning may fire
spuriously for BPF_PROG_RUN live frames on native drivers lacking
skb-ext-pass, and may hide a later real warning. Fix the code or the docs?

> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst

[ ... ]

> +The kernel sets the stored values on the ``skb`` in these cases:
> +
> +- When cpumap or veth builds the ``skb`` from an ``xdp_frame`` after
> +  ``XDP_REDIRECT``.
> +- When ``BPF_PROG_RUN`` with ``BPF_F_TEST_XDP_LIVE_FRAMES`` builds the
> +  ``skb`` after ``XDP_PASS``.
> +- On ``XDP_PASS``, in a driver with the ``skb-ext-pass`` XDP feature,
> +  see `Supported Devices`_.
> +
> +On ``XDP_PASS``, the stored values replace the values that the driver
> +sets from the RX descriptor. On a native XDP driver without the feature,
> +the kernel warns once when the program returns ``XDP_PASS`` with stored
> +values.

This isn't a bug in the text itself, but it doesn't match the code.  Can the
warning fire for BPF_PROG_RUN with BPF_F_TEST_XDP_LIVE_FRAMES even though the
kernel does set the stored values there?

xdp_skb_ext_warn_pass() in net/core/xdp.c skips BPF_PROG_RUN only by testing
for the netdev_rx_queue xdp_rxq:

	/* Generic XDP and BPF_PROG_RUN use the netdev_rx_queue xdp_rxq */
	if (rxq->queue_index < dev->num_rx_queues &&
	    rxq == &dev->_rx[rxq->queue_index].xdp_rxq)
		return;
	/* No native XDP, so only generic XDP or BPF_PROG_RUN runs on dev */
	if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC))
		return;

In live frames mode the buffers use a private rxq instead.
xdp_test_run_setup() in net/bpf/test_run.c does:

	xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0);

and xdp_test_run_init_page() passes &xdp->rxq to xdp_init_buff().

So with ctx_in.ingress_ifindex set to a native XDP device that lacks
NETDEV_XDP_ACT_SKB_EXT_PASS (any native driver other than ice or veth), a
program that calls bpf_xdp_skb_ext_store_rx_hash() and returns XDP_PASS gets:

  bpf_prog_run_xdp()
    xdp_skb_ext_warn_pass()
      pr_warn_once("... the stored RX metadata is lost")

while xdp_test_run_batch()->xdp_recv_frames()->__xdp_build_skb_from_frame()
->xdp_skb_ext_to_skb() still applies the values to the skb.

Since this is pr_warn_once(), the false report also uses up the one warning,
so a later real loss on a native driver without the feature is not reported.

Should the warning skip the live frames rxq, or should the documentation say
that BPF_PROG_RUN live frames can warn?  The code comes from f5e7dade0555
("xdp: add the skb-ext-pass XDP feature and warn without it"), and no later
commit in the series changes it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755842687
--===============6053616401328202004==--
