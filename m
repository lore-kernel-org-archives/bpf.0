Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B672C15BB
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791054159; cv=none; b=FE/tA3ifwGd1s/ScYpT7837sNjnNMudr8sGJYAxJ2fXxS5dW46BQvgiHPKP0/MYI2yLTwGS496ANB6DWU9k7jC+q0D/TVRVlX5NqvmvpftGpli0biTOoSlR4c3zCuCP1fLGyyq+0ByujS2WcrXX/bQI3eMu0HaG49TJGp1yle6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791054159; c=relaxed/simple;
	bh=HkjtarNrYmY+LNDFYdgFOyD+uVk2Br0Sbl/LpXc5ask=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n06xBRO/uewqY5zd66n8G8dwQ+2bKBn1RpTiqaHdXrcpyFXVj+pG/sKO0yMkgHCXgVcCOBu19xsNniINnlqct/EruuXb0070wejI7asIyyeGVjnzJtN4kE3rqkrmn4LzxWT9DeV5zKrQEtPmiv8Dx2+qNL54DI0xASGEqmSidQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIOjLpKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIOjLpKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B451F0089B;
	Sat,  3 Oct 2026 19:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791054158;
	bh=YGAVkhOHB/T6mBT1sPhXXOz4NVMkOCvgVkwNqau3g30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jIOjLpKi4bX4jxBOXOICJjyky6m+wjXcJzUBGfs0OgnPEP9Bpx7amtGih2SE5GVT0
	 NoRKYe11OHXMTxw590W6rVXWqJDZF6eHsdtaQIOZskiGCNUBw5CpODVUJIu8sdTUq8
	 3erIemFAwdOIDGRTCPddXQgGQaVmfTtk1K+9Ad6GuaGSJAjikDOvNQvaEHmtNr+NQW
	 Hf6C05Bc7BS5gRuYuEVGaRZlm8xGMDaMFyysh8yWwc60ZiyEM0fplJY0HhM2KHI25z
	 +Iiw6yTv+ENbMwn8UefM7JoGs7Neik/Nwwz1btEHIUbOyTCeEYlLbPvYwChk8Cue/u
	 SwCi/KmvNTvPA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC net-next 03/15] net: Add memory provider capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261002190018.696925-4-bjorn@kernel.org>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-4-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 19:02:36 +0000
Message-Id: <20261003190237.E1B451F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: Use-After-Free in NAPI poll due to erroneous kick after faile=
d queue rollback
--

commit 6916b55bc2fd7fcbee42e2cf1fc4f277ee96ed12
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

    net: Add memory provider capabilities
   =20
    The current memory providers, devmem and io_uring zero-copy RX, give
    memory that the CPU cannot read. The core allows them only on queues
    with header-data split on, a zero header-split threshold, and no XDP
    program. AF_XDP needs a provider that the CPU can read and that
    works with XDP.

> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index 00a7011eb4d57..610e31d1a7173 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
[ ... ]
> @@ -165,6 +197,11 @@ static int netdev_rx_queue_reconfig(struct net_devic=
e *dev,
> =20
>  err_free_new_queue_mem:
>  	qops->ndo_queue_mem_free(dev, new_mem);
> +	/* Freeing the replacement can hand provider memory back to the old
> +	 * queue, which still runs unless the rollback failed.
> +	 */
> +	if (err !=3D -ENETDOWN && netif_running(dev))
> +		netdev_rx_queue_kick(rxq);
> =20
>  err_free_old_mem:
>  	kvfree(old_mem);

[Severity: High]
Does this code risk a use-after-free if the queue rollback fails?

If ndo_queue_start() fails during the rollback, the old memory is freed, but
err is not updated to reflect the failure:

net/core/netdev_rx_queue.c:netdev_rx_queue_reconfig() {
err_start_queue:
	if (qops->ndo_queue_start(dev, qcfg_old, old_mem, rxq_idx)) {
		WARN(1, ...);
		qops->ndo_queue_mem_free(dev, old_mem);
	}

err_free_new_queue_mem:
	qops->ndo_queue_mem_free(dev, new_mem);
	/* err still holds its previous value (e.g., -ENOMEM) */
	if (err !=3D -ENETDOWN && netif_running(dev))
		netdev_rx_queue_kick(rxq);

Because err isn't updated to -ENETDOWN when the rollback fails, the kick wi=
ll
proceed and schedule a NAPI poll on a stopped queue whose memory was just
freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002190018.6969=
25-1-bjorn@kernel.org?part=3D3
