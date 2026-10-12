Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326939B94A;
	Mon, 12 Oct 2026 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814581; cv=none; b=doBnQ3GQy3aPMT4IMG/on0WOPKR63aTHjiN2l4VrEU45PBsUvpQvx4HLG9MINRG/WDc1qUb7QAJ4ASahWE82MYWq4Sw6dGDbTUgZwIgAeUvhuTuUkGCSFZ/epOoxxwxzT+c6J5QNDnuq6Lx/1wBVwF3aiwL6QXcnCDwxpBKCc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814581; c=relaxed/simple;
	bh=obtm2pJQXpPvJeHZ5dJoSxxASOKS7F3tPagSNJHyvoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgdBJlYSQLhBfmFdoQ0NBKJdqbejVy1oMgswbWpsBLvDfc7YUfIDn82ZJXEFjQTnXYqNgR3fAEt4x7HFUQxCct9oEpGze93XBZKa/Q9+Va+Y/fLNITK+0bCPiy5OGMGwIGzD0G/M7kG2LCHVGWuq5nLWsSDxBBGGgZHAu5XO/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eigxJMr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eigxJMr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B88F1F0089B;
	Mon, 12 Oct 2026 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791814580;
	bh=wkfKRTjp6/s95orK5T+FwDlOCT9z7CXe0scB7cxcwpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=eigxJMr7QbJhMg4Wylwlyh3XTs3rt3CeVegIl9N7mWd0t2NVjNqQMHXMNVr4M9dNo
	 FYh/nL+lX9/Mu49s24BMu5NoXFAGjJn6hde6bqsqxm0J11fvhp2553Psy+/l/Bu6J0
	 XM6HUM6tTJWKg+d9Xwu5oezB7FdJ4G1fSHuIvXHbweyICjOw5MUVZpIAPFK8ZaPM51
	 5iJNEgoJ+Dgp+Ge3Ni0ajp640O4dHlCEb6pqj7F60g/RrlRUJvCa9V/s2eRm2Qumpn
	 sWc1BBRtRArvs4ceqwiafnTb/jJSVrfnh94Bi1txF4zgV+ie0QJ5vPSt4vEnbtTK4Z
	 DNYbSkyynM+/A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org,
 "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi
 <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, David
 Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mina Almasry
 <almasrymina@google.com>
Subject: Re: [RFC net-next 13/15] eth: fbnic: Support AF_XDP zero-copy receive
In-Reply-To: <asPhAnm830qFxGMv@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-14-bjorn@kernel.org>
 <asPhAnm830qFxGMv@devvm7509.cco0.facebook.com>
Date: Mon, 12 Oct 2026 16:16:17 +0200
Message-ID: <87tsmratse.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> On 10/02, Bj=C3=B6rn T=C3=B6pel wrote:
>> fbnic gets RX buffers from page_pool. Use the XSK buffer pool as the
>> RX queue's page-pool memory provider, so allocation, DMA sync,
>> recycling and refill stay in page_pool. Only aligned 4 KiB UMEM
>> chunks are supported.
>>=20
>> Each UMEM frame on the header queue must hold one packet. Raise the
>> header-split threshold to at least 3072 bytes, more than half of a
>> 4 KiB page, so the device finishes the frame after one header. Cap
>> it to the space left in the frame after the headroom. An MTU above
>> the threshold needs a socket with XDP_USE_SG and an XDP program with
>> frags support. With XDP_USE_SG, the payload queue also uses UMEM
>> frames, and the device uses each frame for one descriptor only.
>> Without it, the payload queue uses a normal page pool. If the device
>> does not finish a provider frame after one descriptor, drop the
>> packet.
>>=20
>> The BDQ refill loop now alternates header and payload buffers on all
>> queues, so two rings that share one finite provider stay balanced.
>> It keeps NAPI scheduled while the provider still has buffers.
>>=20
>> Provider frames are never split, so they get no fragment bias. A
>> redirected frame can be recycled before its old BDQ slot is cleaned,
>> and a stale bias would corrupt the new allocation.
>>=20
>> The headroom comes from the queue configuration. It must be at least
>> XDP_PACKET_HEADROOM, a multiple of 128 bytes, and fit the hardware
>> field; otherwise queue validation fails. MTU, ring parameter and XDP
>> program changes that do not fit an active provider are rejected.
>>=20
>> fbnic did not support XDP_REDIRECT. Add it, with xdp_do_flush(), and
>> advertise it. This also enables copy-mode AF_XDP and the other
>> redirect targets on fbnic. Do not advertise AF_XDP zero copy until
>> TX support is added.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>> ---
>>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   5 +
>>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 140 ++++++-
>>  .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   4 +
>>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 350 +++++++++++++-----
>>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   6 +
>>  5 files changed, 402 insertions(+), 103 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/n=
et/ethernet/meta/fbnic/fbnic_ethtool.c
>> index e774740fcb5d..188abe0ead14 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> @@ -385,6 +385,11 @@ fbnic_set_ringparam(struct net_device *netdev, stru=
ct ethtool_ringparam *ring,
>>  		return -EINVAL;
>>  	}
>>=20=20
>> +	err =3D fbnic_xsk_validate(fbn, fbn->xdp_prog, netdev->mtu,
>> +				 kernel_ring->hds_thresh, extack);
>> +	if (err)
>> +		return err;
>> +
>>  	if (!netif_running(netdev)) {
>>  		fbnic_set_rings(fbn, ring, kernel_ring);
>>  		return 0;
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/ne=
t/ethernet/meta/fbnic/fbnic_netdev.c
>> index 8a6703afca38..038e91ef14e4 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
>> @@ -5,6 +5,8 @@
>>  #include <linux/ipv6.h>
>>  #include <linux/types.h>
>>  #include <net/netdev_queues.h>
>> +#include <net/netdev_rx_queue.h>
>> +#include <net/xdp_sock_drv.h>
>>=20=20
>>  #include "fbnic.h"
>>  #include "fbnic_netdev.h"
>> @@ -276,6 +278,8 @@ static int fbnic_set_mac(struct net_device *netdev, =
void *p)
>>  static int fbnic_change_mtu(struct net_device *dev, int new_mtu)
>>  {
>>  	struct fbnic_net *fbn =3D netdev_priv(dev);
>> +	struct netlink_ext_ack extack =3D {};
>> +	int err;
>>=20=20
>>  	if (fbnic_check_split_frames(fbn->xdp_prog, new_mtu, fbn->hds_thresh))=
 {
>>  		dev_err(&dev->dev,
>> @@ -285,6 +289,15 @@ static int fbnic_change_mtu(struct net_device *dev,=
 int new_mtu)
>>  		return -EINVAL;
>>  	}
>>=20=20
>> +	err =3D fbnic_xsk_validate(fbn, fbn->xdp_prog, new_mtu,
>> +				 fbn->hds_thresh, &extack);
>> +	if (err) {
>> +		if (extack._msg)
>> +			netdev_err(dev, "%s\n", extack._msg);
>> +
>> +		return err;
>> +	}
>> +
>>  	WRITE_ONCE(dev->mtu, new_mtu);
>>=20=20
>>  	return 0;
>> @@ -534,26 +547,123 @@ bool fbnic_check_split_frames(struct bpf_prog *pr=
og, unsigned int mtu,
>>  	return mtu + ETH_HLEN > hds_thresh;
>>  }
>>=20=20
>> +u32 fbnic_xsk_hds_thresh(u32 headroom, u32 hds_thresh)
>> +{
>> +	u32 max_hds;
>> +
>> +	/* Reserve more than half a device page for each header so the device
>> +	 * retires the provider frame after one descriptor.
>> +	 */
>> +	static_assert(2 * FBNIC_XSK_HDS_THRESH > FBNIC_BD_PAGE_SIZE);
>> +
>> +	max_hds =3D FBNIC_BD_PAGE_SIZE - headroom - FBNIC_RX_TROOM -
>> +		  FBNIC_RX_PAD;
>> +
>> +	return min(max_t(u32, hds_thresh, FBNIC_XSK_HDS_THRESH), max_hds);
>> +}
>> +
>> +static int fbnic_xsk_validate_frames(struct xsk_buff_pool *pool,
>> +				     struct bpf_prog *prog,
>> +				     unsigned int mtu, u32 hds_thresh,
>> +				     struct netlink_ext_ack *extack)
>> +{
>> +	u32 xsk_hds_thresh;
>> +
>> +	xsk_hds_thresh =3D fbnic_xsk_hds_thresh(xsk_pool_get_headroom(pool),
>> +					      hds_thresh);
>> +
>> +	if (mtu + ETH_HLEN <=3D xsk_hds_thresh)
>> +		return 0;
>> +
>> +	if (!xsk_pool_uses_sg(pool)) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "AF_XDP zero-copy socket requires XDP_USE_SG");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (fbnic_check_split_frames(prog, mtu, xsk_hds_thresh)) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "AF_XDP zero-copy socket requires XDP frags");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int fbnic_xsk_validate(struct fbnic_net *fbn, struct bpf_prog *prog,
>> +		       unsigned int mtu, u32 hds_thresh,
>> +		       struct netlink_ext_ack *extack)
>> +{
>> +	struct net_device *netdev =3D fbn->netdev;
>> +	struct xsk_buff_pool *pool;
>> +	unsigned int qid;
>> +	int err;
>> +
>> +	for (qid =3D 0; qid < fbn->num_rx_queues; qid++) {
>> +		pool =3D xsk_get_pool_from_rxq(netdev, qid);
>> +		if (!pool)
>> +			continue;
>> +
>> +		err =3D fbnic_xsk_validate_frames(pool, prog, mtu, hds_thresh,
>> +						extack);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int fbnic_xsk_setup_pool(struct net_device *netdev,
>> +				struct xsk_buff_pool *pool, u16 queue_id,
>> +				struct netlink_ext_ack *extack)
>> +{
>> +	struct fbnic_net *fbn =3D netdev_priv(netdev);
>> +	int err;
>> +
>> +	if (queue_id >=3D fbn->num_rx_queues)
>> +		return -EINVAL;
>> +
>> +	if (!pool)
>> +		return xsk_pool_setup_page_pool(netdev, NULL, queue_id, extack);
>> +
>> +	err =3D fbnic_xsk_validate_frames(pool, fbn->xdp_prog, netdev->mtu,
>> +					fbn->hds_thresh, extack);
>> +	if (err)
>> +		return err;
>> +
>> +	return xsk_pool_setup_page_pool(netdev, pool, queue_id, extack);
>> +}
>> +
>>  static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
>>  {
>>  	struct bpf_prog *prog =3D bpf->prog, *prev_prog;
>>  	struct fbnic_net *fbn =3D netdev_priv(netdev);
>> +	int err;
>>=20=20
>> -	if (bpf->command !=3D XDP_SETUP_PROG)
>> +	switch (bpf->command) {
>> +	case XDP_SETUP_PROG:
>> +		if (fbnic_check_split_frames(prog, netdev->mtu,
>> +					     fbn->hds_thresh)) {
>> +			NL_SET_ERR_MSG_MOD(bpf->extack,
>> +					   "MTU too high, or HDS threshold is too low for single buffer XD=
P");
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>> +		err =3D fbnic_xsk_validate(fbn, prog, netdev->mtu,
>> +					 fbn->hds_thresh, bpf->extack);
>> +		if (err)
>> +			return err;
>> +
>> +		prev_prog =3D xchg(&fbn->xdp_prog, prog);
>> +		if (prev_prog)
>> +			bpf_prog_put(prev_prog);
>> +		return 0;
>
> [..]
>
>> +	case XDP_SETUP_XSK_POOL:
>> +		return fbnic_xsk_setup_pool(netdev, bpf->xsk.pool,
>> +					    bpf->xsk.queue_id, bpf->extack);
>
> Is there a good reason to ask drivers to call us back with
> xsk_pool_setup_page_pool? For the PP mode, maybe we should add new
> XSK_VALIDATE_POOL or something? So most of that fbnic_xsk_setup_pool stays
> in core?

Makes sense. I'll try core-owned setup with driver opt-in and
validation. Existing direct drivers can keep their setup.

> I guess I'm mentally trying to have a clear separation between
> pp vs non-pp modes. Even that whole xsk_buff_pool might be legacy non-pp
> artifact? New drivers shouldn't bother with it? Or is it too much?

Hmm. New RX code shouldn't need allocator internals, but rings, DMA and
TX state are still shared. I need to noodle a bit on it...
