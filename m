Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794052015;
	b=JfKj3BMMGlimWmYufyHMviZBe7QJza1bxYnJp0Zm9vP+FQLEboLKi/zl7ciCADoaplIy
	 kDMDujJSQSGnS7FEbvDMB9vXC+vJ8pygfQkKI6wdj4HNkzKdnLw+aHiaqH+c1nRSFsQ32
	 eOitqB5g/oEn9BaE0OwNm2ARFZm11tkofw5pw3qaNk7jfU8miDRXlbLS6IXvH4sgTFNHN
	 qkyxmpeSkSv3o9PfmFZ40n/HAImgPMiQIX69gwMI3hWqTB8Y/nJ4nt+tjAU7ILYQfD4NA
	 JSCLe1J5/fZTEX7r37mKkV96rSK5Nqr7+xB23V/SxDgk8rD9mbRTlBshIfEE5dbqWPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052015;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jZXJGG+XZZO3Qp+1TwL7dRA/Q33bpl+vjZqHobSzTvQ=;
	b=NxbA2vQ9YE43xIUVOlcoFAxK4+SuVO/OK0N/iW2Eds7iBVY9yiCwUxMtmkJuzwY9cQpU
	 0GPGuSqpKbCyUCCuXr32KVSnE69Mb5xJYW3YW53DDoru3Buc8ymuKsu8hgDAmh8cdVAPA
	 RGQxdSxy9z1Qb3nOyZQ0TBkyahPtAiOkrJ0SzOxmBfeKOqvyTSlfsn8HitIRpJHQjncye
	 n51BHrrfK12GbFHLBmMZFzcCVpg1W1+pt3YuW3L1RHebiCX/AHq5sSL/qs7zE8hRKEQ53
	 YIkChQRuliywMoaj1Ccsnwl4RGxCBjp6x2lsnn6FFl1J3CuqoRjRnPs003PzQmRY3ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOCudJyX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E179606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOCudJyX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88F91F0089F;
	Sat,  7 Nov 2026 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794052015;
	bh=jZXJGG+XZZO3Qp+1TwL7dRA/Q33bpl+vjZqHobSzTvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cOCudJyXiSXPOwAH4GdJXKgfGFwjs6uNnaMH8We1QF4Py/5rYC/aTx7qDQ1mPj36B
	 McOSGfWnpSKRXFftcTmTJe9vaLxW9ER2fXcl9nJGSrHc4bnGG2VD6j8Q6IA19g/4t+
	 aG2EvirZvqKuXuPwXPgg6QjZ2c6ny+VEvJcWcaDMqsb4WMvekuqwDLjiWoQYK9/6Tl
	 8p4zMn8lGihJMsAoncD+NQ3BBJTd2gNNit4wmRsP3feQL9O/YZIxcAfKYFUsUgUTzi
	 Gek6HihpBVIVS8XkCaqmlknD0pCvUwRx3mYEUvxc2hI6nNv+RwkLysVhxsvj4Pokm3
	 rXoe3xEqlLaIg==
Message-ID: <sashiko-outbox-202865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/2] gve: block XDP on the DQO-QPL queue format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amaan Cheval" <amaan.cheval@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261106114551.212675-2-amaan.cheval@gmail.com>
References: <20261106114551.212675-1-amaan.cheval@gmail.com>
 <20261106114551.212675-2-amaan.cheval@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 11:46:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] gve: gve_verify_xdp_configuration() fails to reject
  GVE_GQI_RDA_FORMAT
--

commit effd5965643e22a2856ad20f55eafb8449ee0b34
Author: Amaan Cheval <amaan.cheval@gmail.com>

gve: block XDP on the DQO-QPL queue format

This commit rejects XDP program attachment on the GVE_DQO_QPL_FORMAT
queue format in gve_verify_xdp_configuration().

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 2437cd8ba6331..4e9e692a0ed0a 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net=
_device *dev,
>  	struct gve_priv *priv =3D netdev_priv(dev);
>  	u16 max_xdp_mtu;
> =20
> +	if (priv->queue_format =3D=3D GVE_DQO_QPL_FORMAT) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "XDP is not supported in DQO QPL queue format.");
> +		return -EOPNOTSUPP;
> +	}

[Severity: Medium]
Should gve_verify_xdp_configuration() also reject GVE_GQI_RDA_FORMAT (or
any queue format other than GVE_GQI_QPL_FORMAT and GVE_DQO_RDA_FORMAT)?

Before d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
RDA"), verify_xdp_configuration() rejected every queue format except
GVE_GQI_QPL_FORMAT, and gve_set_netdev_xdp_features() only advertises XDP
features on GVE_GQI_QPL_FORMAT and GVE_DQO_RDA_FORMAT.

With only GVE_DQO_QPL_FORMAT blocked here, attaching an XDP program on a
running GVE_GQI_RDA_FORMAT interface passes validation and enters
gve_set_xdp() -> gve_configure_rings_xdp() -> gve_adjust_config(). After
gve_close() tears down the existing queues, gve_queues_start() ->
gve_reg_xdp_info() takes the !gve_is_qpl(priv) branch:

drivers/net/ethernet/google/gve/gve_main.c:gve_reg_xdp_info() {
	...
		else if (gve_is_qpl(priv))
			err =3D xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
							 MEM_TYPE_PAGE_SHARED,
							 NULL);
		else
			err =3D xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
							 MEM_TYPE_PAGE_POOL,
							 rx->dqo.page_pool);
	...
}

Because GQI rings do not allocate rx->dqo.page_pool,
xdp_rxq_info_reg_mem_model() returns -EINVAL, causing gve_adjust_config()
to call gve_queues_mem_remove() and leave the interface with all queues
disabled and priv->tx_cfg.num_xdp_queues non-zero so subsequent
gve_open() calls also fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106114551.2126=
75-1-amaan.cheval@gmail.com?part=3D1
