Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3533D4EC
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398437; cv=none; b=ZV5ElodURZJrT2LhE9wBITH1WDGMVTkyUfcG+hsblEgQxvRJ6uONdzM0OKn0ZhfTpDigKbMS39CCo0/6gVvSbWBZbrEccxaOngRyGsc2kAdqXNUaXgzETbOaSeDwhaDd1rbM/YNEZHhChkeB4YepRyFfLNCFFvdVUG0VCAeLeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398437; c=relaxed/simple;
	bh=Fyk3hXBwDbumAIiV9ngChE52tCRCYwa2q3rWIUMa2vs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=em3u2xZNEqB9XgCpG0mHBqZHbiCs+D4vIJtpZjUICYKqfHM7t7eC+q3AHkGAMZItOzd/yoqZHSMFYb4H8FLelFeXl1caJp7+5YYil0kTihqmKRouH9Zx0qOOxW6ikjNEu9NrEWEaMUG+pdz0D2AzPT3NyvkQMNk4lBRHELTM7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxMREx9x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxMREx9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E57C2BCAF;
	Tue, 28 Apr 2026 17:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777398437;
	bh=Fyk3hXBwDbumAIiV9ngChE52tCRCYwa2q3rWIUMa2vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gxMREx9x6ZBrww3B2chZEYhKpX17QbDf7cKCUGwpjKhcCMpLtK4JTYrKtV4SYFEyX
	 8uwgSnuZbG/SVJ0jde7YFDE96h2STUwzBu44iqlUq+g9GL7K3rq8luMAeV03r4sCC9
	 nZdaJuZ2KdIKCj2ndOXb3ivOVI9dap5yHdgZETUC3NC/wCuJlXggNLn+m+ZdWhL9yk
	 Gn/q7WoBtXrPWL4R94aduarj8XlhQ/98GS3rjGbc1kx5gd4TcV+trWOgh944k4j/qL
	 ML09s5X1EWS/M+MygYnaJy8aFjuqDLvnmqq7UlRCxEGfwsH2ene9FvSnCs6rL3uLgR
	 RkxGXnHqyRtQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: mana: Use kvmalloc for large RX
 queue and buffer allocations
Reply-To: sashiko@lists.linux.dev
To: "Aditya Garg" <gargaditya@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427132807.1642290-3-gargaditya@linux.microsoft.com>
References: <20260427132807.1642290-3-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 17:47:16 +0000
Message-Id: <20260428174716.E8E57C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The error path in `mana_create_rxq()` accesses and attempts to dou=
ble-free a CQ object embedded within an `rxq` structure that has already be=
en freed, leading to a Use-After-Free and Double Free.
--

commit 2b2a9ca2dc8ac87d8832a2a8e0d3a6c8f2d70ca9
Author: Aditya Garg <gargaditya@linux.microsoft.com>

net: mana: Use kvmalloc for large RX queue and buffer allocations

This commit switches the RX path allocations for pre-allocated buffers and
queues from kmalloc to kvmalloc variants to handle fragmented contiguous
memory, and updates the free paths to use kvfree.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 8adf72b96145..e1d8ac3417e8 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> @@ -2564,7 +2564,7 @@ static void mana_destroy_rxq(struct mana_port_conte=
xt *apc,
>  	if (rxq->gdma_rq)
>  		mana_gd_destroy_queue(gc, rxq->gdma_rq);
> =20
> -	kfree(rxq);
> +	kvfree(rxq);
>  }

Does this change to kvfree() expose an existing use-after-free in the error
path of mana_create_rxq()?

In mana_create_rxq(), cq is initialized as a pointer into the rxq structure:

	cq =3D &rxq->rx_cq;

If an error occurs later in the function, the cleanup path calls
mana_destroy_rxq(), which frees rxq, and then it accesses cq again:

out:
	if (!err)
		return rxq;

	netdev_err(ndev, "Failed to create RXQ: err =3D %d\n", err);

	mana_destroy_rxq(apc, rxq, false);

	if (cq)
		mana_deinit_cq(apc, cq);

Because mana_destroy_rxq() now uses kvfree(rxq), if the allocation fell back
to vmalloc, the memory will be unmapped immediately. Can accessing cq inside
mana_deinit_cq() trigger a page fault here?

Also, since mana_destroy_rxq() already calls mana_deinit_cq(apc, &rxq->rx_c=
q)
before freeing rxq, does calling it a second time in the out path result in=
 a
double-free?

> @@ -2704,7 +2704,7 @@ static struct mana_rxq *mana_create_rxq(struct mana=
_port_context *apc,
> =20
>  	gc =3D gd->gdma_context;
> =20
> -	rxq =3D kzalloc_flex(*rxq, rx_oobs, apc->rx_queue_size);
> +	rxq =3D kvzalloc_flex(*rxq, rx_oobs, apc->rx_queue_size);
>  	if (!rxq)
>  		return NULL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427132807.1642=
290-1-gargaditya@linux.microsoft.com?part=3D2
