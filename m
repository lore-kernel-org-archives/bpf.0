Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB3A285058
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777794447; cv=none; b=m4pC2v3CnxxQsuCRy5eIPep7xAG8VNQn2gzUFAntJb/xUNoxiQBP3Emfp+/x2yJ5mk4m2uwD8XkhMJwlTjWUlVrGpCoWf9DjyC4vQfVusSI1Iwi5Boo8Yyq6ec2mggCmp4q0e5iHXWpFJUjIySoc6FONxgYM1/ZP5cux70ccqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777794447; c=relaxed/simple;
	bh=AUvylvy68dl04OdIiiLs+NuPkDs4SC2DZfWj5iFnP98=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oH3+0ydE8N9ybWtREMfzOAJI7laKzBqyxT6vcj41ux/nSOBlPXqVn4455w197P4eQ8xV0IVD0D56JDwKgR9zKl2TqckRF/sBwxW22GlW+KkL04YWIXx+lszQyz2puDa6Ew3QpT3h5dWT45pEGcP4XolaR+2BIYj0IKfHAug7Www=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkZ6qwRU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkZ6qwRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C84EC2BCB4;
	Sun,  3 May 2026 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777794446;
	bh=AUvylvy68dl04OdIiiLs+NuPkDs4SC2DZfWj5iFnP98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QkZ6qwRULKW/EzqVZD6kqMnlzBlHPwNL57HPg4blh74Ib9B9LKWAnjCkXg7FLPPQF
	 ULLgnOp/um7o0L3UBw8Ighghb3IBl2H0QGj2Vn4yzODEs1+8fpU/83Kysxz/257ASo
	 aq4zbiUzyX9X+ErpLP5ZuEE8lc/IG7ptNagfcx0o8I4FjhViLDgoTzucd+xpog8UGF
	 XULiw5SoBFgbxOlJKgWKssboBIYhnhNg6iZY1X6rUIBoxO0yjYe9o0mmAjPywZcG6N
	 XJKjJDgODpskAHPF78hAQL+ETcRHu544YZBapshOgDHCZaqPz5jd47WIVaFlHCCIXT
	 wPZNzcoGTje1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: mana: Use per-queue allocation for
 tx_qp to reduce allocation size
Reply-To: sashiko@lists.linux.dev
To: "Aditya Garg" <gargaditya@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260502074552.23857-2-gargaditya@linux.microsoft.com>
References: <20260502074552.23857-2-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 07:47:25 +0000
Message-Id: <20260503074726.1C84EC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Lockless functions (mana_get_stats64 and mana_xdp_xmit) can experi=
ence a TOCTOU Use-After-Free when accessing the dynamically allocated tx_qp=
 arrays during driver teardown.
- [High] Unprotected updates to u64_stats sequence counters in mana_xdp_xmi=
t can corrupt stats synchronization for readers, leading to a hard lockup.
--

commit a5fe13810d8b6aacf3c073e5e3abaddcaa39dd5d
Author: Aditya Garg <gargaditya@linux.microsoft.com>

net: mana: Use per-queue allocation for tx_qp to reduce allocation size

This commit converts tx_qp from a contiguous array allocation to an array of
pointers. It allocates each queue's mana_tx_qp individually via kvzalloc,
which provides vmalloc fallback and helps avoid allocation failures due to
memory fragmentation.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net=
/ethernet/microsoft/mana/mana_bpf.c
> index 7697c9b52ed3..b5e9bb184a1d 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> @@ -68,7 +68,7 @@ int mana_xdp_xmit(struct net_device *ndev, int n, struc=
t xdp_frame **frames,
>  		count++;
>  	}
> =20
> -	tx_stats =3D &apc->tx_qp[q_idx].txq.stats;
> +	tx_stats =3D &apc->tx_qp[q_idx]->txq.stats;

Can mana_xdp_xmit() be called concurrently on multiple CPUs that map to the
same q_idx?

If the number of online CPUs exceeds the number of TX queues,
smp_processor_id() % ndev->real_num_tx_queues will result in multiple CPUs
sharing the same queue index.

The subsequent call to u64_stats_update_begin() requires mutual exclusion
among writers. Concurrent writes without locks could corrupt the underlying
sequence counter, potentially leaving it permanently odd and causing readers
to spin infinitely.

Additionally, since this function runs locklessly, could this pointer
dereference race with the driver teardown path?

If a teardown thread clears port_is_up right after the early check in
mana_xdp_xmit(), and proceeds to call mana_destroy_txq(), it frees the tx_qp
elements via kvfree() without an intervening synchronize_net() or RCU grace
period. This could lead to a use-after-free when accessing txq.stats.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index a654b3699c4c..8adf72b96145 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -614,7 +614,7 @@ static void mana_get_stats64(struct net_device *ndev,
>  	}
> =20
>  	for (q =3D 0; q < num_queues; q++) {
> -		tx_stats =3D &apc->tx_qp[q].txq.stats;
> +		tx_stats =3D &apc->tx_qp[q]->txq.stats;

Could this suffer from the same use-after-free race with teardown as
mentioned above?

Since mana_get_stats64() runs locklessly, it can run concurrently with
teardown paths like mana_per_port_queue_reset_work_handler(). The tx_qp
array elements might be freed by mana_destroy_txq() while mana_get_stats64()
is attempting to read the stats.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502074552.2385=
7-1-gargaditya@linux.microsoft.com?part=3D1
