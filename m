Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708834;
	b=hBaL7uxZ3L/s0QE5uYVjhdnOaCEnj031gHgJSRrVwbVQS1SI3BFA2Wq3B9NsVBtkJMv/
	 P1n4atrkNo5llXSVO4bgomQOXW9lHJJgNqKzzhedryujKMbPwUfX536SPd6k9KzOA4f6f
	 m4Xt9BMZfvSYAfb269GMZ/8/1OWi1IrBnFLkIkXM0ooNkpb7j+b5aC+OFpfdYX3Vj7C85
	 3A2hbpT0cyTxJS5NnrtRhvjiOx5PMH7PXGHBZVI4DNvBc2bqwRUReIGF6A45sVZqIjXIs
	 ecFvOh0Mv2kYN6woTL5GNXTs/W2pqS7jjPOA7se0QbI5uBonKqPrLQqkoMpqtDXhzWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708834;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sbNcZKPG9w7AwGG2dtrY7nVCYbAVfu7qnvLtENI0C/U=;
	b=n24Zt7DlsIp9jO3epLVbFHdPn+LS8+La3GCVNpCp//rClMCACqWrLAFeP04YTIgP0x4X
	 280ssk4yF50/6WTbs9D7rqaGd14Nr/1/AFncvMkTqJEAjFprgYdoOsZTCT1IcfzqXB2xg
	 3FDyZlB05W9CWIWRMhE9UIjeulIixxvhHFHHx/Huo5PrWzix5cph+YFORSk2sE1f/cSoB
	 nYQ2mTc3z1kuIEN0irn06Jlcok0Sf1cM8QM241bxZslqlN+rh+f2UUzVuqlGkgP7VtG+1
	 5LFDLT3BDlh6CO2SiepA0SzTEUNbixsfTEgvta3p+VIMJDE1FMRp8NpnrEAnfJl3itg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U+/SfPFx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E1606A323;
	Sun, 15 Nov 2026 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+/SfPFx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AE11F000C5;
	Sun, 15 Nov 2026 02:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794708833;
	bh=sbNcZKPG9w7AwGG2dtrY7nVCYbAVfu7qnvLtENI0C/U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U+/SfPFxkpqYB8YbpJNl7wi+RwjaQguYH2qsk0ik2i0LfvoepIKL1gAe3Kwmji6au
	 iAw8IJ/Je3//m3O6cRD8HfnlpiBZc85vDUl/1uJOlEMZPEyZjrnXG/4CnUrd96kO83
	 5OcrqesJHVQsQB0f40OAJnJaEF/rEC9uws8y0Wob8BxJpdPF2oABrL6TrBkQoSNywd
	 1p13ouLUf/8AK136C5g7ifRe7zz3K3nLKHEcC9bDH5Nj/pknYigYeC+W+3reGdZqDE
	 d0+KDB9KF5JzNAfmwHFLybA4Vl4ExLBxGxxQKL12U3riHGmujXBgKALKeqTjGbRp0e
	 bjl/qiizpQn7A==
Subject: Re: [PATCH net-next v2 1/3] veth: refactor NAPI enable paths
From: netdev-bot+sashiko@kernel.org
To: tianyi@cloudflare.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, toke@redhat.com,
 lorenzo@kernel.org, horms@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
 hawk@kernel.org, kernel-team@cloudflare.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org
Date: Sun, 15 Nov 2026 02:13:52 +0000
Message-ID: <179470883254.2199510.15270739408094114749@kernel.org>
In-Reply-To: <20261111015922.67745-2-tianyi@cloudflare.com>
References: <20261111015922.67745-2-tianyi@cloudflare.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch changes the order of NAPI setup in
  veth_napi_enable_range() (drivers/net/veth.c).

--

veth: refactor NAPI enable paths

This patch stops passing rq->xdp_napi.napi_id to xdp_rxq_info_reg(). It
moves netif_napi_add() out of veth_enable_xdp_range() and the old
veth_napi_enable_range() wrapper and into the loop in
__veth_napi_enable_range() that enables each NAPI. The trivial wrappers
are removed, and the double-underscore helpers take over their names.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 0539b3661793d..f5097696df15e 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -1059,6 +1059,7 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
>  	for (i = start; i < end; i++) {
>  		struct veth_rq *rq = &priv->rq[i];
>  
> +		netif_napi_add(dev, &rq->xdp_napi, veth_poll);
>  		rcu_assign_pointer(rq->xdp_prog, priv->_xdp_prog);
>  		napi_enable(&rq->xdp_napi);

[Severity: Low]
Can this leave a veth device with threaded NAPI half on and half off?

Before this patch, every caller added all NAPIs in the range before it
enabled any of them. The core seems to depend on that order.
netif_napi_add_weight_locked() in net/core/dev.c says:

	/* Create kthread for this napi if dev->threaded is set.
	 * Clear dev->threaded if kthread creation failed so that
	 * threaded mode will not be enabled in napi_enable().
	 */
	if (napi_get_threaded_config(dev, napi))
		if (napi_kthread_create(napi))
			dev->threaded = NETDEV_NAPI_THREADED_DISABLED;

napi_enable_locked() reads dev->threaded at the time it runs:

	if (n->dev->threaded && n->thread)
		new |= NAPIF_STATE_THREADED;

With add and enable now in the same loop, suppose threaded mode is on and
napi_kthread_create() fails for some queue k > start. Queues start..k-1
have already been enabled with NAPIF_STATE_THREADED. Queue k and the
queues after it come up non-threaded, and dev->threaded is cleared.

The device then reports threaded mode as disabled through sysfs and
netlink, while some of its NAPIs are still polled by kthreads. This can
happen in any path that reaches veth_napi_enable_range():
veth_set_features() toggling GRO, veth_set_channels() calling
veth_enable_range_safe(), veth_open(), and veth_enable_xdp(). The
kthread_run() failure can come from ENOMEM or from a pending fatal
signal.

netif_set_threaded() avoids this state by reverting all NAPIs when
kthread creation fails, but this path doesn't do that.

Could netif_napi_add() stay in its own loop over the whole range? It
could sit after the page_pool and ptr_ring allocations that can fail and
before the napi_enable() loop. That would keep the new error handling
and the old ordering.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111015922.67745-1-tianyi%40cloudflare.com
