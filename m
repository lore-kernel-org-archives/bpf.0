Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A134F46D
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869220; cv=none; b=laH235XArYwOlXXD+zFg5DmM1WkxUJ16BaPgFuBRnNxuy1JJ86K9WffNuo294uQ1q/Q5LpIajAv7woyILrSF9fc6iKouWpk3xJhKtIIiV685i5Z/EP/lucCi+jH1yoIF6iExtLBh5k98cwfWaQ+qcl93aGjKpuk44BFgIILj/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869220; c=relaxed/simple;
	bh=gN9jZwHwbNucBArY7SnQV0+ZQnNIS+x6blCfpltkCYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fCqknCP/rV3UzSpFT9gaevrmF0OMxNta1B3Z29Yebprd8kDfxySW7uwjA4rRJgJc+RhIajSeA30aoGXGcHuZ/FRG58HRCOemaMXPLHdUGHh3FrSEIT3wNLK3k5oseOak9g+aQgb7jNlLvqMxsSvzSoBfjloH45qS/pSIYGhbjiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3EWK1H6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3EWK1H6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516A31F000E9;
	Tue,  4 Aug 2026 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869219;
	bh=618KVFIUHod6IIABNE+FJsolX/j06bOpkvh9fcPPi3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3EWK1H6oAFh6N082hc7TfEd5w9TSSJQ91/AYt9WRaUj4WmLrp/a+D8dnOinMN9C6
	 qzHNa5cnmS72nJiXkMfG7q52drkxyY99ia4SZYV2+ZRaQpEaMwBKR1D3xZ4GOT+efn
	 R7gs5iAMQSj8nZec/H7soMV4ZY4izI0eja3jx1YBtNPfyxvD7wUmQ2HuKm0nuVsStk
	 ZuWNKDcP5B+8BoI+wrK5gUcIdolKiEjmG3/erRbEvnAqn95M9bKR84tb8EAOrK1gbn
	 NA4ujTsByO855c/ENkSmfewKd+kUFYDRd9Eq7pMqW1dZJTAJPQFyh0yLKDL5leW5XS
	 roNycgxWlA+GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 01/15] gve: don't pass in unused parameter
 to gve_adminq_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803184630.3813311-2-hramamurthy@google.com>
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-2-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:46:58 +0000
Message-Id: <20260804184659.516A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of the adminq DMA pool during device reset due to an e=
arly return in gve_adminq_free().
--

--- Patch [1]: [PATCH net-next v3 01/15] gve: don't pass in unused paramete=
r to gve_adminq_free ---
commit 3b6d21bb1589b652e4e7777b1b6be55fff25b9f0
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: don't pass in unused parameter to gve_adminq_free

This commit cleans up gve_adminq_free by removing an unused parameter.

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 08587bf40ed4a..70ffed8b52c3d 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
[ ... ]
> @@ -385,7 +385,7 @@ void gve_adminq_release(struct gve_priv *priv)
>  	gve_clear_admin_queue_ok(priv);
>  }
> =20
> -void gve_adminq_free(struct device *dev, struct gve_priv *priv)
> +void gve_adminq_free(struct gve_priv *priv)
>  {
>  	if (!gve_get_admin_queue_ok(priv))
>  		return;

[Severity: High]
This isn't a bug introduced by this patch, but does returning early here
cause a memory leak of the adminq DMA pool during a device reset?

When a reset happens, gve_reset_and_teardown() calls gve_trigger_reset()
which clears the admin queue OK flag. It then calls
gve_teardown_priv_resources() which calls gve_adminq_free():

drivers/net/ethernet/google/gve/gve_main.c:gve_reset_and_teardown() {
	...
	gve_trigger_reset(priv);
	/* With the reset having already happened, close cannot fail */
	if (was_up)
		gve_close(priv->dev);
	gve_teardown_priv_resources(priv);
	...
}

Because the OK flag is cleared, gve_adminq_free() returns early, skipping
the dma_pool_free() and dma_pool_destroy() calls, leaking the allocations.
During subsequent recovery, gve_init_priv() calls gve_adminq_alloc() which
overwrites priv->adminq_pool and priv->adminq with new allocations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803184630.3813=
311-1-hramamurthy@google.com?part=3D1
