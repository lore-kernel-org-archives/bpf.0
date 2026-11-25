Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598309;
	b=elbkBqE4kqx4LBuGE58Stb0vsSHI/X4qTom3XjPr20I/A2mq+rfh9diEFvLqTLPoAvJi
	 N/DYjN+Fv661ep5KWZ/LQ5YEhXo729Y+Th14KaJMpTq0oH8D1baqA4aNt9X4TOZaMRwH0
	 ot7RIWidd02fbs5jFMBkxBHCdteE2+K1RGFud/+rI3LLM+ci26C9Nbtt/toGbvtozC133
	 iT/7f5yqovAwd1OhT7j6CgVPUKL4/M0ob/oX+PR2eQhhVRSaFYZGoYwYlFLaPSG8pa5Zj
	 6WfAwBudV7/dd1seLnOJdJzAjvCa8yidzf981marVg+Py7dYagMXSsEWswF5mb3PAYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yIwUFLmeRw1KpQ9XwXq9SYNPEljeGRIzuu+m7pRCfvs=;
	b=TPOYITfSGpEUhOL00DQSD1/Bfbb+HZHOo7uJRPWPGSZCEbVORIgH4wZeM6Q9yufJUKRs
	 ZQdsviVkXUkaRqF0h1HjCluUd4OJInrpP8ciACZECaKAQMLFHtqJl+S4LBPnp2T4TUcwR
	 UYMc8CnEA0RdRxPQTvXqxK5SYeghVX7tgPVUXj326kChDI53DM9q+mjD0RrxIHSNgtaKD
	 mLOu1ocSq/h+Fx8EseEUqi4rLSzf6OUW+DU4q8my6G3NHS8h/UDVoj4b/5/3GWZVbs1Af
	 D4CVxK7+/sEw91uew0aMNiJ2nTA9RIuKL+PkVra++2/9Dzcr1e1ej3hQiOhkiaexWbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCrFniYM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF5606A699
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCrFniYM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8321F000C4;
	Wed, 25 Nov 2026 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795598308;
	bh=yIwUFLmeRw1KpQ9XwXq9SYNPEljeGRIzuu+m7pRCfvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GCrFniYMSjyljVLWX99jR33bQx5njrq/pS8LHE3mEZOKPdU5nEOiYKWpKqHO2oAhv
	 e3MwOsa1eaopen2QQK0xzkrZOSVcBvWbmjrqeKcUGBAXvxqy6YmMU1naDT5Maknj3w
	 E5Uh5JX3advVujCty+s1DowO+bTNK3nYL4tccr2zeqnXlDKikugRh+vGdL6T8oWWcn
	 MkrLrZkuSGkEpP9yiPeGifa1usOM3pf0JccUKoziTxQXKGVTzQMh9pLYeQZXt5824E
	 Z0uX8zzI+enT7Adz7/5OV9pewYFwbPh0Ix+iL+TTWOqg5YvFdYZMvuHY3jsFz4Dkus
	 qJjpjhLXkZ+Og==
Message-ID: <sashiko-outbox-232996@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] xen-netfront: unregister the XDP rxq before
 destroying its page_pool
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Syms" <mark.syms@citrix.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261124091806.2736453-1-mark.syms@citrix.com>
References: <20261124091806.2736453-1-mark.syms@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:18:28 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] xen-netfront: use-after-free in talk_to_netback() [1]
--

commit 28bf900783c8239db158b535f3cda9d162761b0d
Author: Mark Syms <mark.syms@citrix.com>

xen-netfront: unregister the XDP rxq before destroying its page_pool

This commit unregisters each queue's XDP rxq before destroying its page_pool
in xennet_disconnect_backend() and clears queue->page_pool so that the pool
and its recycled receive buffers are not leaked on backend disconnect.

> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index fdcb91042f290..b82b3bdb2fb31 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -1860,7 +1860,10 @@ static void xennet_disconnect_backend(struct netfr=
ont_info *info)
>  		queue->tx.sring =3D NULL;
>  		queue->rx.sring =3D NULL;
> =20
> +		if (xdp_rxq_info_is_reg(&queue->xdp_rxq))
> +			xdp_rxq_info_unreg(&queue->xdp_rxq);
>  		page_pool_destroy(queue->page_pool);
> +		queue->page_pool =3D NULL;
>  	}
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but can talk_to_netback()
trigger a use-after-free on info->queues and leak page pools [1] when
xennet_create_page_pool() fails on a queue after the first?

In xennet_create_queues(), each initialized queue registers its page_pool
and links &queue->napi into netdev->napi_list via netif_napi_add().  If
xennet_create_page_pool() fails on a later queue, talk_to_netback() frees
info->queues directly without calling xennet_destroy_queues():

drivers/net/xen-netfront.c:xennet_create_queues() {
	...
		ret =3D xennet_create_page_pool(queue);
		if (ret < 0) {
			dev_err(&info->xbdev->dev, "can't allocate page pool\n");
			*num_queues =3D i;
			return ret;
		}

		netif_napi_add(queue->info->netdev, &queue->napi, xennet_poll);
	...
}

drivers/net/xen-netfront.c:talk_to_netback() {
	...
	err =3D xennet_create_queues(info, &num_queues);
	if (err < 0) {
		xenbus_dev_fatal(dev, err, "creating queues");
		kfree(info->queues);
		info->queues =3D NULL;
		goto out;
	}
	...
}

The earlier queues' NAPI instances remain on netdev->napi_list after
info->queues is freed, causing a use-after-free when netdev->napi_list is
later traversed, and their page pools are leaked.

[1] https://sashiko.dev/#/bug/linux-22a8f703-85e5-42c6-864c-250ab284af6d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124091806.2736=
453-1-mark.syms@citrix.com?part=3D1
