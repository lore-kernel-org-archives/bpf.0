Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0813DAABA
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273312; cv=none; b=rSa0ihP+HPL20KF/TZsXnlvGadCb5WlgfvGpwKdVFeKyZK4+EPvbDP4YJYIEVLsBQ/9OYc/lX+P2FYVMb1jSsmExgp5gqCXxSdccwgc7FOpzTFNp8pNECKUPhiqzkCxBXatWDcub6b+/lu4nJfggeOxWF/ei3nawbyiWL16v6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273312; c=relaxed/simple;
	bh=y2dgIzI1jEhhQaqgsHE6s3vNWuiQDPJuqsgcNFyJFwY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=QvH7Mm4TaPl37Ukzeo+iyCghh5UIV/lzz6AfP+wc1x/p07/vKAwMJ+sG+R83TKvPMlbRzXT/yr1L7sRs6Keb347jU5HoCLY+XaRH3gFugdDC+A9wz5coHBUDFg1k6t19WpwmzKg0xrNOfbE4yt7f+oVYxt/dgN9MxNs2K23Ng18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGgPP33X; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGgPP33X"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76ef19aso1290451cf.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790273310; x=1790878110; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TCtgp1UKc8IZvUhq6/TBhiCnYxTAzLL9cCbNh4j7qwQ=;
        b=IGgPP33XzsKRX5R6HwLiXmCdje7ym6EqcDboIgChOOof5ce6/v0ywXjumw3pDwmR+d
         ps8b5rpfay7AgMdtgsYiQ7BdPrzn+zd4p9egszJ/seHObMztEdBqlIImpw/g+OEGo6Yq
         UcM1DLSrLJw5DGMc+d3evigP7evVA6ul7zv7Jd2R8iJd+G7efRohQsRYHGN1K5ic1ZD5
         sqjUBg2NI3+X72uRR4HxoykA4R7t72tjIqWhxkQQF65JIGw+A/VA2bEK1N3D5I0sDY6K
         wqs+amSYk1x/bclP12TQEC2NID+XMotrLSatvP+2NH/sJ0S05DHUO7Q2HhHO2Cm3vrQU
         dQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790273310; x=1790878110;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCtgp1UKc8IZvUhq6/TBhiCnYxTAzLL9cCbNh4j7qwQ=;
        b=q8BC1r+wZ0YjpGGUUmM6eQ3TPub8OFopiicsDCotEqwbN7jCGh3jViI9S3KpIO1WFe
         gM1M8J01RfLnIJCNucCbbibjKIUo7Y9JYqlr2YQvlSY3YbNucCYHoDxEIBmqFR0cpWQF
         TJQTvWic2b4mVFLkcEotZPLw/UwE0GXz1K0F4K6lIAatG9xrlDwxmnSHpEzalbj6o7xk
         Wdvn8VhmEmnBYNm5UWd//AQ0tueMCQIDiFmvlU3zPhg2UtaiP5xFXY3uQIduc/MFvstx
         TANVl4lzf7xa45yffkJMGgrdou4p2Uzes3TiMIqx/P5YRr4FOA3CPknN6JnuWwDucY/w
         /fhw==
X-Forwarded-Encrypted: i=1; AKwUvBwTnnzPR+yZECdSlsJKleSZsrXG/Rx+pBt/y65/jk+/1pt7RwZhLi+1LAFazVCMbdCh4Ns=@vger.kernel.org
X-Gm-Message-State: AFuF++m0gBtpyWB+mjp2Hl6ojj62RWLAnYtOs01RuknhubycCVHMiHoz
	KtGDl6EE+67dYv0r/T/fO1AZ+GC6WcniPBdEilVyod7w8p+sfUBFer8I
X-Gm-Gg: AYBFou10Mo4sqzI7Qp2uMfFzkEab1IK2CEfX1sI4t/XlFZHgri4xmzSdab3ZgdalDgQ
	dGfQXDaFcgCl4z80FKgZbqj4XadwnLXgQ6hl0uu+tOyeiXq3RANIIrCsmhPa87AUNYFLXT7lK/z
	/3zhBE4r7QkEBxu1AApee9bpaUS7QJV8SL3QIcQBSs9tLTZ5+sXQlZHyAOq1dnfr2nPmqKOM7/Q
	cu47Vtona02ELA5/5xhGKz4ohQT6Rrt8J5QG+cKix7UPJhnx+zpDTXgrTaD2+W2ntvP7Q9ze7IR
	s3KYMIOoo1yo9y8vTa3l0ow5zxvRjyZIEJQnZCsgcMmUlj6LEu+SGUqUn54jr//nmL5ujw60iJw
	7NlBNRT9Vv6qgpxlmchrGswhU6PagSCe05ql0d2E5lMfHvJCFFou8zFS5yMBVYlrXE4fTlIILrS
	+BhN5ELaJg7jV/l2jfzDFCtFugcvYi7ywb0u6PCtZ4m3PnbMsFklqtsr8xSoArzRVvZk/bHPfh7
	uM=
X-Received: by 2002:a05:622a:4819:b0:532:9e96:5773 with SMTP id d75a77b69052e-5330b68c45bmr730231cf.37.1790273309616;
        Thu, 24 Sep 2026 11:08:29 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ead2226bsm47703031cf.0.2026.09.24.11.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 11:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 14:08:28 -0400
Message-Id: <DLNQX7U9QRFW.2G0KYKS5W3X3H@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <dimitri.daskalakis1@gmail.com>, <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 6/8] eth: mpnic: add a netdevice and basic Tx
 handling
From: "Daniel Zahka" <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260922-linux-mpnic-v1-6-236844f53072@gmail.com>
 <179021553756.2160803.6381610175873058359@kernel.org>
In-Reply-To: <179021553756.2160803.6381610175873058359@kernel.org>

On Wed Sep 23, 2026 at 10:05 PM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 3 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] mpnic_open() (drivers/net/ethernet/meta/mpnic/mpnic_netdev.c)
>   can succeed and show a dead device as up.
> - [Medium] The new ndo_stop, mpnic_stop() in
>   drivers/net/ethernet/meta/mpnic/mpnic_netdev.c, reclaims DMA memory=E2=
=80=A6
> - [Medium] No TX traffic or drops are ever accounted.
>
> --
>
> eth: mpnic: add a netdevice and basic Tx handling
>
> This patch registers a netdev for the mpnic driver and adds ndo_open and
> ndo_stop. It also adds a basic transmit path that builds one metadata
> descriptor plus address/length descriptors per skb, defers doorbells for
> xmit_more bursts, and flushes the deferred doorbell when a packet is
> dropped. mpnic_mmio_err() now detaches the netdev when MMIO fails.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/ne=
t/ethernet/meta/mpnic/mpnic_netdev.c
>> new file mode 100644
>> index 0000000000000..62dc9018f2f8c
>> --- /dev/null
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
>> @@ -0,0 +1,176 @@
>
> [ ... ]
>
>> +static int mpnic_open(struct net_device *netdev)
>> +{
>> +	struct mpnic_net *mpn =3D netdev_priv(netdev);
>> +	int err;
>> +
>> +	err =3D mpnic_alloc_napi_vectors(mpn);
>> +	if (err)
>> +		return err;
>> +
>> +	err =3D mpnic_alloc_resources(mpn);
>> +	if (err)
>> +		goto err_free_napi_vectors;
>> +
>> +	err =3D mpnic_set_netif_queues(mpn);
>> +	if (err)
>> +		goto err_free_resources;
>> +
>> +	mpnic_enable(mpn);
>> +	mpnic_napi_enable(mpn);
>> +
>> +	netif_tx_wake_all_queues(netdev);
>> +	netif_carrier_on(netdev);
>> +
>> +	return 0;
>
> [Severity: Medium]
> Can mpnic_open() return success for a device that has just been
> detached?
>
> mpnic_enable() and mpnic_napi_enable() both end with mpnic_wrfl(), which
> is mpnic_rd64(mpd, MPNIC_BDQ_SPARE). If that read returns all ones, the
> confirmation read is skipped because reg =3D=3D MPNIC_BDQ_SPARE. As a res=
ult,
> mpnic_mmio_err() runs. With this patch that handler now does:
>
> 	/* Tell the stack the device has lost its PCIe link */
> 	if (mpd->netdev)
> 		netif_device_detach(mpd->netdev);
>
> __dev_open() has already set __LINK_STATE_START before calling ndo_open.
> netif_running() is therefore true, and the detach stops all tx queues.
> mpnic_open() then continues without checking anything:
>
> mpnic_open()
>     mpnic_enable()
>         mpnic_wrfl()->mpnic_rd64()->mpnic_mmio_err()
>             netif_device_detach()->netif_tx_stop_all_queues()
>     mpnic_napi_enable()
>     netif_tx_wake_all_queues()
>     netif_carrier_on()
>     return 0
>
> netif_tx_wake_queue() does not check whether the device is present. So
> the queues are awake again, carrier is on and IFF_UP gets set, while
> __LINK_STATE_PRESENT is clear and uc_addr0 is NULL.
>
> mpnic_xmit_frame() doesn't check presence either. It keeps filling
> descriptors and calling writeq() on the cached ring->doorbell. No
> completions come back, and dev_watchdog skips non-present devices, so no
> tx timeout fires either.
>
> Would it make sense to check mpnic_present() or netif_device_present()
> after the enable steps, and unwind if the check fails?
>

I don't think so. Losing the device here should be benign, and will
require a reset, or the device to be re probed.

>> +
>> +err_free_resources:
>> +	mpnic_free_resources(mpn);
>> +err_free_napi_vectors:
>> +	mpnic_free_napi_vectors(mpn);
>> +	return err;
>> +}
>> +
>> +static int mpnic_stop(struct net_device *netdev)
>> +{
>> +	struct mpnic_net *mpn =3D netdev_priv(netdev);
>> +
>> +	netif_carrier_off(netdev);
>> +
>> +	mpnic_napi_disable(mpn);
>> +	netif_tx_disable(netdev);
>> +
>> +	mpnic_disable(mpn);
>> +	mpnic_wait_all_queues_idle(mpn->mpd);
>> +	mpnic_flush(mpn);
>> +
>> +	mpnic_reset_netif_queues(mpn);
>> +	mpnic_free_resources(mpn);
>> +	mpnic_free_napi_vectors(mpn);
>
> [Severity: Medium]
> What happens here if mpnic_wait_all_queues_idle() times out? It returns
> void and only logs the failure:
>
> mpnic_wait_all_queues_idle() {
>     ...
> 	err =3D read_poll_timeout(mpnic_non_idle_queues, non_idle_bitmap,
> 				!non_idle_bitmap, 20, 500000, false, mpd,
> 				queues, ARRAY_SIZE(queues));
> 	if (err)
> 		mpnic_idle_dump(mpd, queues, ARRAY_SIZE(queues),
> 				non_idle_bitmap, err);
> }
>
> mpnic_stop() then always carries on with:
>
> mpnic_flush()
>     mpnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail)
>         unmaps and frees every outstanding skb
> mpnic_free_resources()->mpnic_free_ring_resources()
>     dma_free_coherent() on the TWQ and TCQ rings
>
> If a Tx block (TWQ/TQS/TDE/TCQ) is still busy after 500 ms, can the
> device read from unmapped skb pages or write completions into freed
> coherent memory? The TCQ is only disabled by writing TCQ_CTL =3D 0.
>
> This path has no fallback: no flush retry, no function reset, no clearing
> of bus mastering. For comparison, fbnic calls fbnic_tx_flush() and polls
> again before giving up.
>
> A related case: if an earlier MMIO failure already cleared uc_addr0,
> mpnic_disable() skips all its writes, and mpnic_rd64() returns ~0 for
> every idle register. Does the wait then report idle straight away, so
> the rings are freed even though the queues were never disabled?
>

This was addressed in prior patch.

>> +
>> +	return 0;
>> +}
>
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index cb4d1427434c9..f4ad8caf6ce66 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>
> [ ... ]
>
>> +static netdev_tx_t mpnic_xmit_frame_ring(struct sk_buff *skb,
>> +					 struct mpnic_ring *ring)
>> +{
>> +	__le64 *meta =3D &ring->desc[ring->tail];
>> +	u32 tail =3D ring->tail;
>> +
>> +	if (skb_put_padto(skb, MPNIC_MIN_FRAME_LEN))
>> +		goto err_drop;
>
> [ ... ]
>
>> +	if (mpnic_tx_map(ring, skb, meta))
>> +		goto err_free;
>> +
>> +	return NETDEV_TX_OK;
>> +
>> +err_free:
>> +	dev_kfree_skb_any(skb);
>> +	ring->tx_buf[tail] =3D NULL;
>> +	ring->tail =3D tail;
>> +err_drop:
>> +	mpnic_tx_flush_doorbell(ring);
>> +
>> +	return NETDEV_TX_OK;
>> +}
>
> [Severity: Medium]
> Are these drops counted anywhere?
>
> Both drop paths return NETDEV_TX_OK without calling
> dev_core_stats_tx_dropped_inc() or updating any other counter:

doesn't sound like dev_core_stats_tx_dropped_inc() is supposed to be
used in drivers.

>
>   - err_drop, when skb_put_padto() fails
>   - err_free, when mpnic_tx_map() fails on a DMA mapping error or an
>     oversized head or fragment
>
> The only trace is the rate-limited netdev_err() on the DMA path.
>
> There is also no stats path in general. mpnic_netdev_ops has no
> .ndo_get_stats64 or .ndo_get_stats, and netdev->stats is never updated.
> mpnic_clean_twq0() passes its totals only to BQL, through
> netif_txq_completed_wake().
>
> Won't ip -s link then show tx_packets, tx_bytes and tx_dropped as 0 on an
> interface that is transmitting and dropping packets?
>
> The struct net_device_ops statistics comment in include/linux/netdevice.h
> says drivers must implement one of the supported statistics mechanisms.
> This still seems to be the case at the end of the series.

Stats are planned as the next series.
