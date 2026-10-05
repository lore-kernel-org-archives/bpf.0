Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09F49502C
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222691; cv=none; b=u8CWXoBrBHRmkZkz8hiL39la89JbgnF8UPCHWuCxvDhTAZgu/YaWbY2BO/GKlln/aG7DgnhSDa9RmTGp2ojUGgOkqb/02i4d8xf5+x1nURLsK2FJGsWgtUtCEnBeqLzkuFVWc+r3BHY7PA+lPEy2v4dcTBhg0LYUgCJ1X0cY75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222691; c=relaxed/simple;
	bh=qTjClDFPsIOczWsIZMvAm2JlV3P09bYn+CtG/Fzce3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7JO4qy+8p8ZNTFN2ANbtzueS+o/XbKjCVxs394nTMmXAJxW/cFfDcTtqN6wJKBK3tMvJNaimgnaRoVyKCa3bHYCEC57DJYMOeL13D/LxPYTnrwA2cbqRzZ2NUwnkazMzQzW17XmEpYsoctq9oDa30mcyLq0kvgyQqRVRFA/9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNG6fIh9; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNG6fIh9"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a834ff6565so130311a91.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 10:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791222687; x=1791827487; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A2s9btviDXFgkFzalpgxtIgBWXpEQE8bYrYjAqj6skg=;
        b=tNG6fIh9wwutYa2HLOMDia8JQn7cOItxft2wsh1Nvtaxo6uyYA1IfGumA6WVOV3EwA
         lDG3RGm2tfjZzvHCFrL8e+0sb7A2ZHjQwDzLreEjeBEj4Mhq8V01rKXpc30+SRiK52Sr
         4Eurtci5I8xb6AgqnelOxnm6sTYnOObvWcgZi1XfVfAfPSFDI8fRj0LF64HLs3ONGjBT
         YW0/2GombaHpIM0yYDkAVU0sKvf+JThwjbXlBvwY/VxjyBV7CqW+rep08UbDb0eK+YOa
         qFXJa6AcM0krdmnWxV+mKEMEflLwsYmfeE6yroTa6ZmeLL1PATyT2/zD+L6EDpG6+nhj
         WABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791222687; x=1791827487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A2s9btviDXFgkFzalpgxtIgBWXpEQE8bYrYjAqj6skg=;
        b=W62dyDsfd8Cgb8PSHbqQuvy1b0Vke86TF4TA27Dprt4seVbw9TpTxHdu1BgFak2ZmM
         /tzYiBux8xdWeYGbNJxioefxO5W6umh70RJNGglcd6pdYOjK672WXasIPNFXfIYgjaL8
         42GBuIsraq52KUbGMJofKbl4gcJCkX2G/5pU9QZHCAsqAGOYonXlFSUeEgSQU96mUybo
         QQ48CZjrAytNNU10nmWjChx8Bjz8LQr2+NScFL5wvo7wLYhzxTzJ68+lemymwLaZXeBd
         YwIgyyNlRRCPN12y1UUwnSERwT4C3HL4bCMceZjym1W4RhWmPp73m+1FsJBV5Tgrlq7Q
         gceA==
X-Forwarded-Encrypted: i=1; AKwUvBxZ19s7l6I7Jp4YrkZe+vrhIpOmIUUDcAjiyNZwjldTID/bP70bGpMoAPrKmsyD5TxaHZs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVIYJDPnj5KQZCAW7xW37Fl5C7A6V6vg99UkzNvfR253QD/0+8
	G3hcXKdluNO4ToKQOw/JdBcxZO6Gdo+0PEdKa4aaS1d+zREZ1cd+s1kb
X-Gm-Gg: AYBFou2uafiTBXnNLtGNMUg4iC7F7yMFjTquR3Oh6FlxRe9PgJGFc7wPA8yoB97jjo2
	0txx7Dkkms/CooENPLL0VJBL4IsDJLzPO7YxMBnOzMOvd4WFba+jbvGGlTnWgHJxf5uAdBsT74R
	mMvEKoltWz6oxx2NfXdsttIIw5a99nCx+2v1SvA71rlXxjferqIXe/c8bb/AGKWIHqxqogkSPCi
	/SPQf2cNzHTJNaDZDMHxplpGeOhVpg6JIXgXGV9YXbWCIm/Vo8xm1SzhzaB7I+QLwZcXDvCprW5
	Oz90poByi4gn5tCEhyChdMXgggpvzWW5vxDLxpW1XvDDap2qXZpzN/NhsyItGYkCT975znsg46X
	L0oWghMrCQXuM1ZTgrol+6TK6EKxEzcV2GbZLMqtfzhGR9wucff3C12atSH0sD6q4gYSEh8rzJ6
	0a6PR5g8gILmEE4n3Lr4eyQJ/d5yqZWp5EyAsw7h04Ituj8AKPHvFOzsImWdnuexvszPU/HvtzV
	Oc=
X-Received: by 2002:a17:90a:ad7:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3a8541509e6mr118029a91.23.1791222687218;
        Mon, 05 Oct 2026 10:51:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7ad87874esm5891628a91.0.2026.10.05.10.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:51:26 -0700 (PDT)
Date: Mon, 5 Oct 2026 10:51:21 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	io-uring@vger.kernel.org, "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, 
	Weiming Shi <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>
Subject: Re: [RFC net-next 13/15] eth: fbnic: Support AF_XDP zero-copy receive
Message-ID: <asPhAnm830qFxGMv@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-14-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002190018.696925-14-bjorn@kernel.org>

On 10/02, Björn Töpel wrote:
> fbnic gets RX buffers from page_pool. Use the XSK buffer pool as the
> RX queue's page-pool memory provider, so allocation, DMA sync,
> recycling and refill stay in page_pool. Only aligned 4 KiB UMEM
> chunks are supported.
> 
> Each UMEM frame on the header queue must hold one packet. Raise the
> header-split threshold to at least 3072 bytes, more than half of a
> 4 KiB page, so the device finishes the frame after one header. Cap
> it to the space left in the frame after the headroom. An MTU above
> the threshold needs a socket with XDP_USE_SG and an XDP program with
> frags support. With XDP_USE_SG, the payload queue also uses UMEM
> frames, and the device uses each frame for one descriptor only.
> Without it, the payload queue uses a normal page pool. If the device
> does not finish a provider frame after one descriptor, drop the
> packet.
> 
> The BDQ refill loop now alternates header and payload buffers on all
> queues, so two rings that share one finite provider stay balanced.
> It keeps NAPI scheduled while the provider still has buffers.
> 
> Provider frames are never split, so they get no fragment bias. A
> redirected frame can be recycled before its old BDQ slot is cleaned,
> and a stale bias would corrupt the new allocation.
> 
> The headroom comes from the queue configuration. It must be at least
> XDP_PACKET_HEADROOM, a multiple of 128 bytes, and fit the hardware
> field; otherwise queue validation fails. MTU, ring parameter and XDP
> program changes that do not fit an active provider are rejected.
> 
> fbnic did not support XDP_REDIRECT. Add it, with xdp_do_flush(), and
> advertise it. This also enables copy-mode AF_XDP and the other
> redirect targets on fbnic. Do not advertise AF_XDP zero copy until
> TX support is added.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   5 +
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 140 ++++++-
>  .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   4 +
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 350 +++++++++++++-----
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   6 +
>  5 files changed, 402 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index e774740fcb5d..188abe0ead14 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -385,6 +385,11 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>  		return -EINVAL;
>  	}
>  
> +	err = fbnic_xsk_validate(fbn, fbn->xdp_prog, netdev->mtu,
> +				 kernel_ring->hds_thresh, extack);
> +	if (err)
> +		return err;
> +
>  	if (!netif_running(netdev)) {
>  		fbnic_set_rings(fbn, ring, kernel_ring);
>  		return 0;
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index 8a6703afca38..038e91ef14e4 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -5,6 +5,8 @@
>  #include <linux/ipv6.h>
>  #include <linux/types.h>
>  #include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
> +#include <net/xdp_sock_drv.h>
>  
>  #include "fbnic.h"
>  #include "fbnic_netdev.h"
> @@ -276,6 +278,8 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
>  static int fbnic_change_mtu(struct net_device *dev, int new_mtu)
>  {
>  	struct fbnic_net *fbn = netdev_priv(dev);
> +	struct netlink_ext_ack extack = {};
> +	int err;
>  
>  	if (fbnic_check_split_frames(fbn->xdp_prog, new_mtu, fbn->hds_thresh)) {
>  		dev_err(&dev->dev,
> @@ -285,6 +289,15 @@ static int fbnic_change_mtu(struct net_device *dev, int new_mtu)
>  		return -EINVAL;
>  	}
>  
> +	err = fbnic_xsk_validate(fbn, fbn->xdp_prog, new_mtu,
> +				 fbn->hds_thresh, &extack);
> +	if (err) {
> +		if (extack._msg)
> +			netdev_err(dev, "%s\n", extack._msg);
> +
> +		return err;
> +	}
> +
>  	WRITE_ONCE(dev->mtu, new_mtu);
>  
>  	return 0;
> @@ -534,26 +547,123 @@ bool fbnic_check_split_frames(struct bpf_prog *prog, unsigned int mtu,
>  	return mtu + ETH_HLEN > hds_thresh;
>  }
>  
> +u32 fbnic_xsk_hds_thresh(u32 headroom, u32 hds_thresh)
> +{
> +	u32 max_hds;
> +
> +	/* Reserve more than half a device page for each header so the device
> +	 * retires the provider frame after one descriptor.
> +	 */
> +	static_assert(2 * FBNIC_XSK_HDS_THRESH > FBNIC_BD_PAGE_SIZE);
> +
> +	max_hds = FBNIC_BD_PAGE_SIZE - headroom - FBNIC_RX_TROOM -
> +		  FBNIC_RX_PAD;
> +
> +	return min(max_t(u32, hds_thresh, FBNIC_XSK_HDS_THRESH), max_hds);
> +}
> +
> +static int fbnic_xsk_validate_frames(struct xsk_buff_pool *pool,
> +				     struct bpf_prog *prog,
> +				     unsigned int mtu, u32 hds_thresh,
> +				     struct netlink_ext_ack *extack)
> +{
> +	u32 xsk_hds_thresh;
> +
> +	xsk_hds_thresh = fbnic_xsk_hds_thresh(xsk_pool_get_headroom(pool),
> +					      hds_thresh);
> +
> +	if (mtu + ETH_HLEN <= xsk_hds_thresh)
> +		return 0;
> +
> +	if (!xsk_pool_uses_sg(pool)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "AF_XDP zero-copy socket requires XDP_USE_SG");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (fbnic_check_split_frames(prog, mtu, xsk_hds_thresh)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "AF_XDP zero-copy socket requires XDP frags");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +int fbnic_xsk_validate(struct fbnic_net *fbn, struct bpf_prog *prog,
> +		       unsigned int mtu, u32 hds_thresh,
> +		       struct netlink_ext_ack *extack)
> +{
> +	struct net_device *netdev = fbn->netdev;
> +	struct xsk_buff_pool *pool;
> +	unsigned int qid;
> +	int err;
> +
> +	for (qid = 0; qid < fbn->num_rx_queues; qid++) {
> +		pool = xsk_get_pool_from_rxq(netdev, qid);
> +		if (!pool)
> +			continue;
> +
> +		err = fbnic_xsk_validate_frames(pool, prog, mtu, hds_thresh,
> +						extack);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fbnic_xsk_setup_pool(struct net_device *netdev,
> +				struct xsk_buff_pool *pool, u16 queue_id,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	int err;
> +
> +	if (queue_id >= fbn->num_rx_queues)
> +		return -EINVAL;
> +
> +	if (!pool)
> +		return xsk_pool_setup_page_pool(netdev, NULL, queue_id, extack);
> +
> +	err = fbnic_xsk_validate_frames(pool, fbn->xdp_prog, netdev->mtu,
> +					fbn->hds_thresh, extack);
> +	if (err)
> +		return err;
> +
> +	return xsk_pool_setup_page_pool(netdev, pool, queue_id, extack);
> +}
> +
>  static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
>  {
>  	struct bpf_prog *prog = bpf->prog, *prev_prog;
>  	struct fbnic_net *fbn = netdev_priv(netdev);
> +	int err;
>  
> -	if (bpf->command != XDP_SETUP_PROG)
> +	switch (bpf->command) {
> +	case XDP_SETUP_PROG:
> +		if (fbnic_check_split_frames(prog, netdev->mtu,
> +					     fbn->hds_thresh)) {
> +			NL_SET_ERR_MSG_MOD(bpf->extack,
> +					   "MTU too high, or HDS threshold is too low for single buffer XDP");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		err = fbnic_xsk_validate(fbn, prog, netdev->mtu,
> +					 fbn->hds_thresh, bpf->extack);
> +		if (err)
> +			return err;
> +
> +		prev_prog = xchg(&fbn->xdp_prog, prog);
> +		if (prev_prog)
> +			bpf_prog_put(prev_prog);
> +		return 0;

[..]

> +	case XDP_SETUP_XSK_POOL:
> +		return fbnic_xsk_setup_pool(netdev, bpf->xsk.pool,
> +					    bpf->xsk.queue_id, bpf->extack);

Is there a good reason to ask drivers to call us back with
xsk_pool_setup_page_pool? For the PP mode, maybe we should add new
XSK_VALIDATE_POOL or something? So most of that fbnic_xsk_setup_pool stays
in core?

I guess I'm mentally trying to have a clear separation between
pp vs non-pp modes. Even that whole xsk_buff_pool might be legacy non-pp
artifact? New drivers shouldn't bother with it? Or is it too much?
