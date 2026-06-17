Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3224402429
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706278; cv=none; b=m8RDDvEi9BpCaLD8TC5BDcFoI5YzGLC8uA53Gw+7wMrhswMbM/wkp/lJRKWPlAhP6ICN2853ZYYkY1LYj7Tz+oRMMIhNz4spyezbwPXZlQvE/n79pvWSKXVdWaHr5yTh7+cLcfARJdTi4Lk8cwnIzHLlcKSq9Kp9rQ290HYN3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706278; c=relaxed/simple;
	bh=N1tFMZrv2PI+KUzmkUGEyg9r2wURvsmxOb4Q7zdmHMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B1Vi+tQD9Q0aE5vyyne5fNp9LCdo9n3/myJB2+/MPeufCWd4diu2Qg3QJCJWYNrcgu/YwjyQxPSgR7E5vrPXtd/y2JsaQNuJTEhCjwkfnKaAhXSvLFxLpkIqTiyME83khfxeKNE87ISroSemnOj3OZ0domKPWriPSay8BCq6b9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYnh+NJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYnh+NJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7121A1F000E9;
	Wed, 17 Jun 2026 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706276;
	bh=/bNAIpo/DpIlbKSx4Ax6XBFJ8M6WSzkW1InwQWw2DBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AYnh+NJNIxH3neKB6SLluiLOaUJSqUuiQOPsO3/ztmOrf14PUhWOeLfPRrMKOgOol
	 MJZwBALdujMVQSi99e5CSJT04EAXHmAkMIEdiNK3GrUcvbNJt2sHdG5VBo0JrqZfQ1
	 ef0Q3BQ7c2y/3UX8cG8pojNpzoQGz1mCDy8Ad8As+9TIHP8rESTwBlLBSANpHEr3f2
	 IaVgyLVgdXUGPFN7SH1q6xwlT5nNKVwj7yxwn+8n6vuhO0a0vpzPxKGbdJ5Gj4dEB6
	 SgoeyBAatrsiH+KtlMUoPJ+oNyO2Jb48XPOJjUxRGUbIBMrvJFqMN+N2PCiouIG1ph
	 PpQP2tv7eJgyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: ena: clean up XDP TX queues when regular TX
 setup fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dawei Feng" <dawei.feng@seu.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260616142424.4005130-1-dawei.feng@seu.edu.cn>
References: <20260616142424.4005130-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 14:24:36 +0000
Message-Id: <20260617142436.7121A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] set_io_rings_size() fails to resize XDP TX queues, breaking the me=
mory backoff loop.
- [High] Improper synchronization of per-device and per-ring u64_stats_sync=
 counters.
- [Medium] XDP TX buffers mapped with `dma_map_single` are unmapped with `d=
ma_unmap_page`.
--

commit a770b28356c829d571213a6237ea259eef94fd54
Author: Dawei Feng <dawei.feng@seu.edu.cn>

net: ena: clean up XDP TX queues when regular TX setup fails

create_queues_with_size_backoff() creates XDP TX queues before setting
up the regular TX path. If the subsequent allocation or creation of
regular TX queues fails, the error handling paths omit the teardown of the
XDP TX queues, leading to a resource leak.

> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/e=
thernet/amazon/ena/ena_netdev.c
> index 92d149d4f0917..5d05020a6d058 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
[ ... ]
> @@ -2078,14 +2090,21 @@ static int create_queues_with_size_backoff(struct=
 ena_adapter *adapter)
>  		rc =3D ena_setup_tx_resources_in_range(adapter,
>  						     0,
>  						     adapter->num_io_queues);
> -		if (rc)
> +		if (rc) {
> +			ena_destroy_xdp_tx_queues(adapter);
> +			ena_free_all_io_tx_resources_in_range(adapter,
> +							      adapter->xdp_first_ring,
> +							      adapter->xdp_num_queues);
>  			goto err_setup_tx;
> +		}
> =20
>  		rc =3D ena_create_io_tx_queues_in_range(adapter,
>  						      0,
>  						      adapter->num_io_queues);
> -		if (rc)
> +		if (rc) {
> +			ena_destroy_xdp_tx_queues(adapter);
>  			goto err_create_tx_queues;
> +		}

[Severity: High]
This is a pre-existing issue, but does set_io_rings_size() properly resize
the XDP TX queues during this backoff loop?

If memory allocation fails with -ENOMEM in this function, the driver halves
the requested ring sizes and calls set_io_rings_size() to apply them before
retrying:

ena_netdev.c:set_io_rings_size() {
    for (i =3D 0; i < adapter->num_io_queues; i++) {
        adapter->tx_ring[i].ring_size =3D new_tx_size;
    ...
}

Because it only iterates over regular IO queues and ignores the XDP TX
queues (which start at index num_io_queues), when the retry loop calls
ena_setup_and_create_all_xdp_queues(), won't it continue to use the origina=
l,
unscaled ring size?

Could this cause the driver to repeatedly attempt to allocate the same
large memory block for XDP TX queues, guaranteeing persistent -ENOMEM
failures until the regular queues shrink below ENA_MIN_RING_SIZE?

[Severity: Medium]
This is a pre-existing issue, but does the driver unmap XDP TX buffers
using the correct DMA API?

When mapping the XDP frame, it uses dma_map_single():

ena_xdp.c:ena_xdp_tx_map_frame() {
    dma =3D dma_map_single(tx_ring->dev, data, size, DMA_TO_DEVICE);
    ...
    tx_info->map_linear_data =3D 0;
}

However, because tx_info->map_linear_data is explicitly set to 0, the
teardown path seems to skip the dma_unmap_single() block and falls through
to dma_unmap_page():

ena_netdev.c:ena_unmap_tx_buff() {
    if (tx_info->map_linear_data) {
        dma_unmap_single(...);
    ...
    for (i =3D 0; i < cnt; i++) {
        dma_unmap_page(...);
    }
}

Since the DMA API requires buffers mapped with dma_map_single() to be
unmapped with dma_unmap_single(), will this mismatch trigger runtime
warnings when CONFIG_DMA_API_DEBUG is enabled?

[Severity: High]
This is another pre-existing issue, but is it safe to update the
u64_stats_sync structures from process context without disabling
preemption?

The driver updates stats via a helper:

ena_netdev.h:ena_increase_stat() {
    u64_stats_update_begin(syncp);
    (*statp) +=3D cnt;
    u64_stats_update_end(syncp);
}

This helper is called from process context, such as modifying the
interface_up stat:

ena_netdev.c:ena_up() {
    ...
    ena_increase_stat(&adapter->dev_stats.interface_up, 1, &adapter->syncp);
}

If a reader (like ndo_get_stats64) preempts this writer while the seqcount
is odd, could the reader enter an infinite retry loop on 32-bit systems?

Additionally, tx_ring->syncp appears to be written concurrently by
different CPUs (e.g., ena_start_xmit() updating queue_wakeup while holding
netif_tx_lock, and ena_clean_tx_irq() updating bad_req_id from NAPI softirq=
).
Does this violate the requirement that u64_stats_sync writers must be
mutually exclusive?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616142424.4005=
130-1-dawei.feng@seu.edu.cn?part=3D1
