Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052348;
	b=kLFk0G4n9rjMXiBvEU0+fBkspEvRipfq3aYR5yOrYPm3d35QDpFMxV3jLihbfiTXumQJ
	 AmND1uZqKpYMmfPDgJ6J6bmI/gmmPwqEtDjijFXQnKtfw7B7c9sJ6ophKTHi4T8nGMUd4
	 Kn3gbXuKyh9otVJjBTKFp5ZldtT+ATcXpA3ky2n2IBFZ1tNPAD83nryvCQlbQn9GLGp/X
	 EII8E6fq95eBfCa8Yn3QfBuZux3cgPeOsSNzu/9Us/2/U339TUwfbRczksw5p6oZvzE+h
	 72gcyjnTZdxak/4cX2b7pFEIrG5RUEOgXzswouYs+NEssxU/v8XBYqTuyVr3A+wgAlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G1da6dUyWZ4J/9UXNFaHL2OGMCoIjNdMm36Wzi/ZIEI=;
	b=OmEejdR4vJWn9qZN7hBr/WdaSl/skljabj8RaH7/rnoaA2jX/PWB8DXJG8qEr85e4/Jl
	 t5ST/5wKmwxc4fgwkQIMP82KTDVYXNvNiUzivbBkQ9qCXRZTHKM3Hel4LnjM+APj2F+Bv
	 ZGrKDiS7+ZrWtTqoEn9QajtHKQbjsiSb5cgSDRHKqf0JApuVeszbr6XQQE2Dx61R3inhs
	 WVO272im+ehhH/1Ft+qRteLjjOnX6c+W8EybmOQ2duTVDnBLPMNWt63CX4tzbru/eSLe9
	 VhD57qNl+Rofb6lnUnt76/v0dnGEowqmoCcUnfGBQGHw+H4yasfZ3KJmbMn9YcsyWPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ZWBwXXw6;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAA60A2618
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66FAA60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ZWBwXXw6
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d427836e9so228797066b.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795052346; x=1795657146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1da6dUyWZ4J/9UXNFaHL2OGMCoIjNdMm36Wzi/ZIEI=;
        b=ZWBwXXw6dCK4aMDG2BrjWh/ZmQ7/0SY3hS85wNn8XJOq5H4wWnU8Hi/Nj1CyqT75mK
         FCjvdyFk22pVD9gjUYAW6HJ2HHZADF1UGMUCK/4aoKEsk58ryR1yvXqzLY1ZlNyb4XWU
         vFwJrzb2x9KnLX6g9RJb7kflOF7NPijGaBVRlorYhewqOUHpUzQamaeNdQN90ZODgWsa
         /Rw+QYUrCwVgTNVEIwRUG6cTQQd70uGkTbzRQGjp1uvanatLtzNvKw79ABtJpnxz5omP
         ZzymHzQ6eQOKYzAGNQmlMBd5LhlBJL/6afHTBtKbfKmwfqFVBKSXuCB9ZTTgXAflPz4N
         hnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795052346; x=1795657146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G1da6dUyWZ4J/9UXNFaHL2OGMCoIjNdMm36Wzi/ZIEI=;
        b=I3PzDtb+9b5Vh64DJdedz+64ePm17Om121Yy9hNgtBrknQBx+z2A5gzi02ZGlWLqdw
         hCf49B+133jelRtgsXqQ1fAzS28lQDObW16fXEduM2UoVLHrQfgz+oKYdvngGSrQvVEd
         z2TVE1oNmT4TXmkXCAX4zDBSRUsc9fvhC+Z5pOcorhjmoiWE6OiDeH32RVbO/1Z60Kpa
         6QYwxYQKGtDE1zyzMFUjNhKzrpT1mnlLNm8J55RUKYKTalaViB7D4RHd79I+33eNBxg1
         SPjG6Lrc/U41bycOXsh3GHpO9IDGDM9eJxnEABAtywDd+QCYk7D/LG9KACRJaBVa/x7W
         cylA==
X-Forwarded-Encrypted: i=1; AL+hErGBo+ZYwaIROQh+CSUnmDjZHxiwILYYML7kIzM02uEkiwZ14RjwM+MPN9dCDYpkTk6nCvw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gZHRj/Q4kv31lBlIaiYzwzjBechIrpX1aaZAoxC4Z6AbGRH30
	d6MnxOA9LpNaXaLOAv5jusqEsrX2+qpvj4gDvyxZ/4JPAL+KweVKkFO100k41fa4ciw=
X-Gm-Gg: AYBFou0yMhNHfK/AGp24K5EEKHi8hsY4Qi0lSAXchhSlCSqVqc+s+KIwVLVcLKLM/zA
	tl9QWa2O9ZSV0RaYYpcOmMfRfdW5l92LF9UT4QdYEIXTPA9ph76zgBVxW0fSkN9ck5FKLewn/mr
	+Q7k4gaqSsUBjm1Tf9RN90vTVcmjB3dYGCEcnTeu0sTPC60r0fQgymmDwWOwL6fUNpSgwd57Yjn
	3P1yhuxwSoyhnOvYOMfFCbrrRMCM5RsztY97GqMllxY7LlHrtd7meOrYMtZgJDgCIrI4NZGTO19
	X5Zewvt95iiMPqwp5UxPaS1MvmI6Eaqucce4LJp88x25JC/vFPRX5pBfvUParlpx1E2JWuPvrFv
	FpbBCZH9s4yLss9MWmxssd8kaP9FmnLWcTANF630HCrAMMCOuWq8tFriN9sl2sCH73X6e+VjjNc
	b8+XSw4yeKJ+RsUM24hjC4dJKp/RJ99m45DG+NzqzbU+XQfm7hrVXluc1mJj827dq0SJM+iVtSu
	I37nv089k/b9phoXiT+ZQNM8iJbxBiYjNMlBbE0ELO9FBtEyB4pU+HxCfbxnpSvlTElLM2qFQG/
	zKSqSAfqMjSCC1Iu2HGXAy+E+N75jN+qm48HX3RS0yn6Msm+BmZcNY29CQ==
X-Received: by 2002:a17:907:9607:b0:c49:a235:8e0c with SMTP id a640c23a62f3a-c510e1f18bfmr426811266b.22.1795052345799;
        Wed, 18 Nov 2026 17:39:05 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4080sm59785966b.16.2026.11.18.17.39.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 17:39:05 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Danielle Ratson <danieller@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Anil Kaushik <anilkaushikwireless@gmail.com>,
	Demos Ra <demosthenes.ra@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Joe Damato <joe@dama.to>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Li RongQing <lirongqing@baidu.com>,
	Louis Scalbert <louis.scalbert@6wind.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Song Liu <song@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Wang Zhan <wang.zhan@smartx.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Zhou Qiuyue <n0ps1edzz@gmail.com>,
	Tianyi Gao <tianyi.gao@linux.dev>,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 09/11] veth: add VETH_INFO_TX_EXTRA_HEADROOM
Date: Thu, 19 Nov 2026 01:38:28 +0000
Message-ID: <20261119013830.36935-10-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119013830.36935-1-tianyi@cloudflare.com>
References: <20261119013830.36935-1-tianyi@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packets that a namespace sends through a veth pair can be encapsulated
on another device, for example by a program at TC egress of the host
uplink. The veth device cannot see this, so the packets are reallocated
on the uplink.

Add VETH_INFO_TX_EXTRA_HEADROOM, so that the CNI plugin can set the
headroom for both devices when it creates the pair. It cannot be changed
later, like IFLA_NETKIT_HEADROOM.

Store the value in struct veth_priv, and add ndo_get_tx_extra_headroom
so that the core reads it whenever it recalculates tx_extra_headroom.
The value cannot be written to tx_extra_headroom itself, because the
core recalculates tx_extra_headroom from scratch when XDP on the peer
or a program at tcx egress is attached or detached. A new field in
struct net_device would also work, but it would grow struct net_device.

IFLA_NETKIT_HEADROOM, added by commit b9ed315d3c4c ("netkit: Allow for
configuring needed_{head,tail}room"), is similar but differs in two
ways:

- it is the total headroom of the device and sets needed_headroom;
- it is a u16. The new attribute is a uint, as commit 374d345d9b5e
  ("netlink: add variable-length / auto integers") recommends.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
The iproute2 patch for VETH_INFO_TX_EXTRA_HEADROOM will be posted after
this series is accepted.

v2:
- New patch, replaces IFLA_TX_EXTRA_HEADROOM for headers pushed on
  another device (Willem, Stephen).
---
 Documentation/networking/netdevices.rst |  5 +++
 drivers/net/veth.c                      | 44 +++++++++++++++++++++++++
 include/linux/netdevice.h               |  5 +++
 include/uapi/linux/veth.h               |  1 +
 net/core/dev.c                          |  3 ++
 5 files changed, 58 insertions(+)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 128a93303a6d..cf7b84897f61 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -460,6 +460,7 @@ values:
 * ``XDP_PACKET_HEADROOM`` (256 bytes) minus ``needed_headroom``, when the
   peer of a veth or netkit device has an XDP program
 * the headroom that the programs at tcx egress of the device declare
+* ``VETH_INFO_TX_EXTRA_HEADROOM`` of a veth device
 
 When the peer has an XDP program, locally generated UDP, raw and
 AF_PACKET packets and AF_XDP packets in copy mode have enough headroom
@@ -480,6 +481,10 @@ tail call targets, freplace programs and programs at tcx ingress are
 ignored. Loading a program whose tag is above 512 or does not parse fails
 with ``-EINVAL``.
 
+``VETH_INFO_TX_EXTRA_HEADROOM`` is for headers that are pushed on another
+device, for example at TC egress of the uplink. It is set for both
+devices of a veth pair when the pair is created.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0539b3661793..06f691568f3a 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -77,6 +77,7 @@ struct veth_priv {
 	struct bpf_prog		*_xdp_prog;
 	struct veth_rq		*rq;
 	unsigned int		requested_headroom;
+	unsigned int		tx_extra_headroom;
 	netdevice_tracker	peer_tracker;
 };
 
@@ -1580,6 +1581,13 @@ static void veth_set_rx_headroom(struct net_device *dev, int new_hr)
 	rcu_read_unlock();
 }
 
+static unsigned int veth_get_tx_extra_headroom(const struct net_device *dev)
+{
+	const struct veth_priv *priv = netdev_priv(dev);
+
+	return priv->tx_extra_headroom;
+}
+
 static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			struct netlink_ext_ack *extack)
 {
@@ -1731,6 +1739,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_set_features	= veth_set_features,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_set_rx_headroom	= veth_set_rx_headroom,
+	.ndo_get_tx_extra_headroom = veth_get_tx_extra_headroom,
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
 	.ndo_get_peer_dev	= veth_peer_dev,
@@ -1832,6 +1841,7 @@ static int veth_newlink(struct net_device *dev,
 	struct net *peer_net = rtnl_newlink_peer_net(params);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
+	unsigned int tx_extra_headroom = 0;
 	int err;
 	struct net_device *peer;
 	struct veth_priv *priv;
@@ -1854,6 +1864,10 @@ static int veth_newlink(struct net_device *dev,
 		tbp = tb;
 	}
 
+	if (data && data[VETH_INFO_TX_EXTRA_HEADROOM])
+		tx_extra_headroom =
+			nla_get_uint(data[VETH_INFO_TX_EXTRA_HEADROOM]);
+
 	if (ifmp && tbp[IFLA_IFNAME]) {
 		nla_strscpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
 		name_assign_type = NET_NAME_USER;
@@ -1875,6 +1889,9 @@ static int veth_newlink(struct net_device *dev,
 
 	netif_inherit_tso_max(peer, dev);
 
+	priv = netdev_priv(peer);
+	priv->tx_extra_headroom = tx_extra_headroom;
+
 	err = veth_init_queues(peer, tbp);
 	if (err)
 		goto err_register_peer;
@@ -1908,6 +1925,9 @@ static int veth_newlink(struct net_device *dev,
 	else
 		snprintf(dev->name, IFNAMSIZ, DRV_NAME "%%d");
 
+	priv = netdev_priv(dev);
+	priv->tx_extra_headroom = tx_extra_headroom;
+
 	err = veth_init_queues(dev, tb);
 	if (err)
 		goto err_register_dev;
@@ -1930,6 +1950,8 @@ static int veth_newlink(struct net_device *dev,
 	rcu_assign_pointer(priv->peer, dev);
 	netdev_hold(dev, &priv->peer_tracker, GFP_KERNEL);
 
+	netdev_update_tx_extra_headroom(dev);
+
 	veth_disable_gro(dev);
 	/* update XDP supported features */
 	veth_set_xdp_features(dev);
@@ -1972,9 +1994,29 @@ static void veth_dellink(struct net_device *dev, struct list_head *head)
 }
 
 static const struct nla_policy veth_policy[VETH_INFO_MAX + 1] = {
+	[VETH_INFO_UNSPEC]	= { .strict_start_type =
+				  VETH_INFO_TX_EXTRA_HEADROOM },
 	[VETH_INFO_PEER]	= { .len = sizeof(struct ifinfomsg) },
+	[VETH_INFO_TX_EXTRA_HEADROOM] =
+		NLA_POLICY_MAX(NLA_UINT, NETDEV_TX_EXTRA_HEADROOM_MAX),
 };
 
+static size_t veth_get_size(const struct net_device *dev)
+{
+	return nla_total_size(sizeof(u64)); /* VETH_INFO_TX_EXTRA_HEADROOM */
+}
+
+static int veth_fill_info(struct sk_buff *skb, const struct net_device *dev)
+{
+	const struct veth_priv *priv = netdev_priv(dev);
+
+	if (nla_put_uint(skb, VETH_INFO_TX_EXTRA_HEADROOM,
+			 priv->tx_extra_headroom))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static struct net *veth_get_link_net(const struct net_device *dev)
 {
 	struct veth_priv *priv = netdev_priv(dev);
@@ -2003,6 +2045,8 @@ static struct rtnl_link_ops veth_link_ops = {
 	.policy		= veth_policy,
 	.peer_type	= VETH_INFO_PEER,
 	.maxtype	= VETH_INFO_MAX,
+	.get_size	= veth_get_size,
+	.fill_info	= veth_fill_info,
 	.get_link_net	= veth_get_link_net,
 	.get_num_tx_queues	= veth_get_num_queues,
 	.get_num_rx_queues	= veth_get_num_queues,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 786b63f21d4f..b99e3afc89ce 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1416,6 +1416,9 @@ struct netdev_net_notifier {
  *	appropriate rx headroom value allows avoiding skb head copy on
  *	forward. Setting a negative value resets the rx headroom to the
  *	default value.
+ * unsigned int (*ndo_get_tx_extra_headroom)(const struct net_device *dev);
+ *	Return the headroom that the device adds to tx_extra_headroom.
+ *	The caller must hold RTNL and be under RCU read context.
  * int (*ndo_bpf)(struct net_device *dev, struct netdev_bpf *bpf);
  *	This function is used to set or query state related to XDP on the
  *	netdevice and manage BPF offload. See definition of
@@ -1688,6 +1691,8 @@ struct net_device_ops {
 						       struct sk_buff *skb);
 	void			(*ndo_set_rx_headroom)(struct net_device *dev,
 						       int needed_headroom);
+	unsigned int		(*ndo_get_tx_extra_headroom)(
+					const struct net_device *dev);
 	int			(*ndo_bpf)(struct net_device *dev,
 					   struct netdev_bpf *bpf);
 	int			(*ndo_xdp_xmit)(struct net_device *dev, int n,
diff --git a/include/uapi/linux/veth.h b/include/uapi/linux/veth.h
index 52b58e587e23..04cb408e5b3a 100644
--- a/include/uapi/linux/veth.h
+++ b/include/uapi/linux/veth.h
@@ -5,6 +5,7 @@
 enum {
 	VETH_INFO_UNSPEC,
 	VETH_INFO_PEER,
+	VETH_INFO_TX_EXTRA_HEADROOM,
 
 	__VETH_INFO_MAX
 #define VETH_INFO_MAX	(__VETH_INFO_MAX - 1)
diff --git a/net/core/dev.c b/net/core/dev.c
index 6d11d5ad13e1..6c655b0a949e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10688,6 +10688,9 @@ static void __netdev_update_tx_extra_headroom(struct net_device *dev,
 	    needed_headroom < XDP_PACKET_HEADROOM)
 		tx_extra_headroom = XDP_PACKET_HEADROOM - needed_headroom;
 	tx_extra_headroom += tcx_tx_extra_headroom(dev);
+	if (dev->netdev_ops->ndo_get_tx_extra_headroom)
+		tx_extra_headroom +=
+			dev->netdev_ops->ndo_get_tx_extra_headroom(dev);
 
 	WRITE_ONCE(dev->tx_extra_headroom,
 		   min(tx_extra_headroom, NETDEV_TX_EXTRA_HEADROOM_MAX));
-- 
2.56.0

