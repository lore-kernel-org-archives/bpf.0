Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545478;
	b=puj0OO69F37dywKiSaXGxJ36nqtM5Yw5mne//FFafysayMVLdXzqSE4TADVQClpFX0I4
	 5NZ4i8f/GTBq5kgAqCEAMbQN7n9Wiv74V1Md0etaRT/r/XUBAjJ0+05i9m5RtI7IzAY5e
	 rhdPqvFdJTR5daGQeYwDoIuLq2RTWaG8oyS0xs9IjDYvWbxsJ5yHHSf2FkcnqJU2aYjWc
	 mdLW+5STEvhHqNjFneIeYXYN67nPPBA4xH3fZ47jH7QFQXe53sWrE+3PkMnEoz14fhuJk
	 wBle3Ut/2O1lhsH4zyaXvhNAuGvYwcyh//nRzQAnfyPuOVjL4M7Xggd5SuHqtzTt6Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LTpJszTPfdrFGTPrUWviGsFCLOFVk1Llppz1WHIBDvc=;
	b=xjxBd7MeqgCft15AB1B7KDLbcRHJKmVcQwRd8/XxB63zu9gRA2U6Cd08PoHhCjSDmOys
	 wc/+n4ugS/SknYwASUHTUuG2qFpNYVPkL/Jaj5iouu0Hn8C1g0auLKd5JG/Go3ofs4GVJ
	 kQv+Edd+/xRX1TVxHidkeKB5I4PABhIc7y5Z1E+e0WJWzdvJF/CqaOnfkyR6ZBzcbz4Hi
	 Znb7QZa1STedfvFuZJsTyY84fe9BVHxhtJ3Karsn0GJ8etF+Py+PJwI2cGiIYJo4/LE1j
	 wkPLYxb9pE9m4Nmtc9LZePcd9EM2y5rL9XFrII6mi3EbiDnEsZYuxRV9gY+eHKW8eLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UW7NdP6c;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC74606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 15:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC74606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UW7NdP6c
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eadef147ffso1169852e0c.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 07:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793545476; x=1794150276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LTpJszTPfdrFGTPrUWviGsFCLOFVk1Llppz1WHIBDvc=;
        b=UW7NdP6cNBj35KZ/i9idexIpyePATb7OkV9Qdt9wlAOnkr360QM+YTlZfvzQPwM285
         EDl4xPAFLwDOEXQhtJZvXoC0U40FRY3561R7a8jp0ddChOR8Lt2rX6fKsBTbB9u3EwZL
         4WTku0HorZFXyEgn8pGDgpw1TOa8wHeLQPXP6Lct0l2R9VWIpHJVdnw4JrxnPMRWRm4b
         70TR268Huw1UengkrTk32x7zLFhaokpng9I5zPvuyLL8itaUunFOMuV8+/P4bKpPseZW
         3LiF7nxfvFO5oGh1PlsiWXylVrQwzM56YqnCWal2Bs104Qlyhzdjn3hwZJaezqMkgWaa
         mgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793545476; x=1794150276;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTpJszTPfdrFGTPrUWviGsFCLOFVk1Llppz1WHIBDvc=;
        b=EbsmTbJp42IBgRt/3et/aQv/7oirHrCx2h8JSOxFY0yMI7E/gko5BKYo/nlpRg+NDh
         CH2UU+OX/jzK6UrmfYnI+c5pVo2KP+BY8N4vgdKBM/wtjddEllLMemPyH4ggWPiNqSzS
         4/bhN9euFThaRGZ84ckoGHk6/k0ZmtsiKexWS9UEn7RnqxSrIl5KaFuzjRR95XDRrnuN
         2igNtjrcGe5MrGGyuSaKUNVoDir7Yz3YNZgChrTz5nDWyGeyUDKctodwWq9IKp+Fj/fT
         yLbe3XeZ2PJu8V2c1LRmjig/TZ/VeySD/jWZa6CqvZkJWEaXl7kceWjAEUSI2a2D62Iv
         uV5A==
X-Forwarded-Encrypted: i=1; AKwUvBz+U+q4mkCLwReoEQJdBalR0dwQ3M7f4xyXPOuW5ihW6MRzMXSYoi/PXrML8YkItu9nInE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBB/uIgNQ7IUWABe4dHmwrZuN9OfQ+qcRJqNK5wvLniUQmupMt
	IwS/9wRCzpwGrH6XHIXtALFZb26qbGeb7CHXINnm6/izIYaCXMkn0uO3
X-Gm-Gg: AYBFou1eRiXG2aDFQFG9678vDXbbN65RJ6Bmh6+cK3KA93I2g1zhVR1xfNi1f0gwIMp
	DvDdI3jvCmIzrikX9Bjzi9y5KNM2jklzpWicM+6+SRalGqHEkdfby13mk7u0BoY3y1fFKagxf15
	/9Nd3g9qaiM572R1W09x93H6QAaZbItDkq8mLqRfBAMlKF3wLTeLrMsm3LW8k8ELcg8+1P/okus
	BZw1IDAB8VmHEnRX5FLkNAPaouUdVHWOZUS0yyjAAFDWtnhPGQFjm8RY3EQaPAvLZxt4isuQ73g
	yxN6uCGh6cNtP0BnBn/+s/vbsnLXWWneutdwel6y7UTxXtuiYZEW5KgMia4/oQwRnpw3bPIlJNT
	V8y4K86k6uxdHMASgdapUm8VOOukHLDXgryCDHB0SboFXkwsb9AT0S1ukrGzyVa9cliczFGo+7u
	zK+10plRyxRe44nFNZsMUA6lrkhey8An7X9GVrUMu5bC7XV7NMXkNo2waUYhXjUTAkSlVrMvn14
	sZp/UvwQLI1P3DxERwRjMPb5g4MFEKv4iRjqruT7T4Aa5q0v1ush3sfaWxvxJ5DdVvunsSOq22u
	BWUamCjoD60t8gaHNp+KFM6q9oUqNcNVOEJNZRea6++3vGvc8w4kv5lHZCh5W4zqR4a1YZ8mNPL
	decY5PFkndbqwHGABEP5w1IOAb3XV8jdIVjpmbKQfGCMoO7xF8zr16E3QdsyRRGGs30ub
X-Received: by 2002:a05:6122:e46c:b0:5e9:6d96:a598 with SMTP id 71dfb90a1353d-5ec68953084mr3744746e0c.6.1793545476321;
        Sun, 01 Nov 2026 07:04:36 -0800 (PST)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c5389dsm8369176e0c.12.2026.11.01.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:04:35 -0800 (PST)
Date: Sun, 01 Nov 2026 10:04:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 kvm@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2adf5c78ee0e8@gmail.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-2-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <20261026-v6-7-topic-virtio-net-ptp-v4-2-008af03cd43b@pengutronix.de>
Subject: Re: [PATCH RFC v4 2/6] virtio-net: support receive timestamp
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> Add optional hardware rx timestamp offload for virtio-net.
> 
> Introduce the virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
> virtio-net header grows by room for a 64 bit TAI timestamp (header
> size 40 bytes), stored in struct virtio_net_common_hdr. The layout is
> cumulative: the field is at the same offset whether or not the
> features before it were negotiated. The fixed layout needs
> VIRTIO_F_VERSION_1, so the feature is cleared without it.
> 
> Implement ndo_hwtstamp_get/set so the timestamping can be enabled
> and disabled at runtime with SIOCSHWTSTAMP. The driver cannot filter
> what the device timestamps, so any rx filter other than NONE becomes
> ALL. The timestamp is read before the packet is handed to the XDP
> program or the stack, and attached to the skb with skb_hwtstamps().
> It is a raw TAI value; there is no PHC.
> 
> The header size is negotiated per device and also applies to
> transmitted packets. On transmit, zero the header behind the fields
> the driver fills in, so the device sees a zero tstamp and no stale
> skb->cb or headroom bytes.
> 
> On receive in big packet mode, the header is placed in front of the
> data in the first page. Grow padded_vnet_hdr to 48 bytes so the
> 40 byte header still fits there.
> 
> Tested in a guest with a patched QEMU:
>   guest: ./timestamping eth0 \
>           SOF_TIMESTAMPING_RAW_HARDWARE \
>           SOF_TIMESTAMPING_RX_HARDWARE
>   host:  nc -4 -u 192.168.1.1 319
> 
> Based on work by Willem de Bruijn.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Assisted-by: Claude:claude-opus-5-5
> ---
>  drivers/net/virtio_net.c        | 136 +++++++++++++++++++++++++++++++++++-----
>  include/linux/virtio_net.h      |  10 +++
>  include/uapi/linux/virtio_net.h |   1 +
>  3 files changed, 131 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 17d3e32eed9d6..23af10c613b48 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -20,6 +20,7 @@
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
>  #include <linux/dim.h>
> +#include <linux/unaligned.h>
>  #include <net/route.h>
>  #include <net/xdp.h>
>  #include <net/net_failover.h>
> @@ -416,6 +417,12 @@ struct virtnet_info {
>  	u32 rss_hash_types_supported;
>  	u32 rss_hash_types_saved;
>  
> +	/* Device passes time stamps to the driver */
> +	bool has_rx_tstamp;
> +	bool hwts_rx_en;

nit: cryptic name. rx_tstamp_supported and rx_tstamp_enabled or so?
> +
> +	struct kernel_hwtstamp_config tstamp_config;
> +
>  	/* Has control virtqueue */
>  	bool has_cvq;  

> +static int virtnet_get_ts_info(struct net_device *dev,
> +			       struct kernel_ethtool_ts_info *info)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +
> +	/* setup default software timestamp */
> +	ethtool_op_get_ts_info(dev, info);
> +
> +	if (vi->has_rx_tstamp) {
> +		info->so_timestamping |=
> +			SOF_TIMESTAMPING_RX_HARDWARE |
> +			SOF_TIMESTAMPING_RAW_HARDWARE;
> +
> +		info->tx_types = BIT(HWTSTAMP_TX_OFF);
> +		info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
> +				   BIT(HWTSTAMP_FILTER_ALL);
> +	}

    `ethtool_op_get_ts_info()` leaves `info->phc_index = -1`, which breaks Ethtool
    Netlink `ETHTOOL_MSG_TSCONFIG_GET` and `ETHTOOL_MSG_TSCONFIG_SET`
    (`ethtool --show-hwtstamp-cfg` / `--set-hwtstamp-cfg`): `tsconfig_prepare_data()`
    in `net/ethtool/tsconfig.c` rejects `ts_info.phc_index == -1` with `-ENODEV`.

    Either `net/ethtool/tsconfig.c` must be taught to allow PHC-less `ndo_hwtstamp_*`
    drivers, or the device needs an associated PHC (e.g. `virtio_rtc`).


> @@ -7250,7 +7353,8 @@ static struct virtio_device_id id_table[] = {
>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
>  	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
>  	VIRTIO_NET_F_VQ_NOTF_COAL, \
> -	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
> +	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS, \
> +	VIRTIO_NET_F_RX_TSTAMP

    `VIRTNET_FEATURES` expands into `features_legacy[]` as well as `features[]`.
    Legacy virtio only supports 32 feature bits (`0..31`) and never has
    `VIRTIO_F_VERSION_1`. Move `VIRTIO_NET_F_RX_TSTAMP` (bit 49) into `features[]`
    alongside `VIRTIO_NET_F_*_UDP_TUNNEL_GSO*`.

>  
>  static unsigned int features[] = {
>  	VIRTNET_FEATURES,
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index a6de308b8f25e..2abd8a614a23f 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -17,6 +17,16 @@ struct virtio_net_common_hdr {
>  		struct virtio_net_hdr_v1_hash hash_v1_hdr;
>  		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
>  	};
> +	/*
> +	 * The wire layout is fixed and cumulative: a field sits at the same
> +	 * offset whether or not the features before it were negotiated; unused
> +	 * bytes are padding. tstamp is thus always at offset 32 and only
> +	 * present (header size 40) if VIRTIO_NET_F_RX_TSTAMP was negotiated.
> +	 * The negotiated header size tells how much of this struct is
> +	 * on the wire. Only ever append new fields at the end.
> +	 */
> +	__u8 reserved[8];	/* outer_nh_offset, ipsec_resource_hdr (not implemented) */
> +	__le16 tstamp[4];	/* le64 TAI receive time in ns, 0 if none */
>  };
>  
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 1db45b01532b5..15e8e408d50fb 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_RX_TSTAMP	  49	/* Device sends TAI receive time */
>  #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
>  #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
>  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
> 
> -- 
> 2.52.0
> 


