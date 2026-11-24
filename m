Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543133;
	b=Voz5+7PBaeBnRmPKduBeM2GFbuRNpdAmRapwQEms90n7/ADBpaBtVMJbJ3CY9OCoymoU
	 9JdNPdaUQZ3/enuiUVNzSw8n2Mhto6atzNb9FdBXLuEIqy+dcO+frFItkB27eEKKXAfyw
	 JJKAOA5AsMWhruwa8Kv40g9/kHKSTgcDRb/ND0ZqMAzCnDU/3SXg+mIUKJgA/vMvfJ1Pd
	 poeG6hQuX1Q1obsXYdTwizfuuCnGgHJoEBFlMzjwNDX7UfUDgSOrRUB799vu+BIC26gZW
	 JjVlBmXZ1KmwUAEn4kNV79AF5CqVzbfv9t+HmqMCRncoOxfQ9VCb/Jw3QN4e7PuRhUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QVKzXmezLyb1NzGGicKlncvxhs46uSTwixCg7Ak8Quw=;
	b=yPWjLxtgTnBtiynM9FT1cs8Bu55vDtxIKxlChC0+VYlOWE0FbdIUwX1RLNkkntVB6yeU
	 SlOODujmfXhTNzLIazSaoXhBN0aSRSUReDnsi+nychLmr6HZ+2mN91A22lTm1bvQGq1oM
	 eRZF2Yt6Tu6TT/JaVSDX2OTQLbI0Lm+M6jACgTOXDgwq3MrNJZtmKvNCR+1O7DhPHqYgD
	 B4jyqcbHx69p+InTFPPjAHU1UQwrvNE9ngJo4JjCypbIaflXCZzEgm/XjupK81FPn4aSy
	 kXTs2M8yN/fbQF7eqbzXpyd49cXN8rIMCLRHa5vGXOecR+2Xm2Wb9Ui73atzo4HmuMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QtXjcB4o;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D629606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D629606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QtXjcB4o
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ba38c41804so5606213a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795543132; x=1796147932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QVKzXmezLyb1NzGGicKlncvxhs46uSTwixCg7Ak8Quw=;
        b=QtXjcB4oQ5HtEFGw561LNSn69+Ml0BSi25Bv5mpPJnz/b7yezCgL9QUbRGZoN054zV
         RKtYuB8YcYIOAVmoueHSaDTuvibpcufl4GNBRM4O8ZXkWsA0kCFFXv/1j7ypByJR/3i4
         cP3jlgLRvgQaTeHcafIwcYzOZFUPLw8tgGVSXJDl9r4kIwbiK05xZ1/rA+6LyCzn4HhY
         bl81uoif9lyjmkHr6iie0mA5Yn7F8EhJugrPFVSWCAYsPPc6YCfhlA3BWlZFvD/KoGTw
         RFNJ/ITyx5YqpHZNdCYtmy92mxSHjGI21uW56CsZC9OXS+v2tlIbTZVDucJfTvgMvh2/
         s3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543132; x=1796147932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QVKzXmezLyb1NzGGicKlncvxhs46uSTwixCg7Ak8Quw=;
        b=yU9U5fvDq4EbcPmJ1nFWgwqkhCkzxUlia6PFxyjlr0Ds+VXxUktgEvvlRyZdnU2ICy
         AQvo+k+YyM7PZ5UiiFPdP78fZDczmH1r1YJTU5D71xL4lRlc+jXpVuSbVIoKS2yct9oY
         BzF7m5lIgDBsTsDGucmiZHL0QB9r0DwHJ/DpmQ9SVUV3X3gdE82K8Etqw4t1YmIgvavQ
         BpnXwg+pYXhOa1ihwAAKumN+T0tLOxtwc5+mDcL1s3gxcxAGTfomn5hTH8SeOPByDf+q
         B1CtyU99itSosWznmZW7Yx6Q1v07WUHc2uitcAYkDIKx4JOiVZDFByGge68n4hQJCV8X
         JDOA==
X-Forwarded-Encrypted: i=1; AL+hErHH4Hft3szdrNT5zeo5rACXxPYuybcHvY+mFVUq+neZ6hbi7zpA6PJ4uUm9PSR09zV3c9w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BlLzsZj14G8W3Nw02uOi8S+iyJ0ykcZXLjCh1T2BxQ3Z7MC2h
	6RKAImG1ejmnkyITVAVzIyppA85sUgQAsgxR44DqzY5jA540YK0qnrOB+HvG3kF1Rkc=
X-Gm-Gg: AZFdTZc7QCZqf0Forx6RAXuu/b1b7poUNg4Gq/9/f9PS6KdE37WkJWnrBm5DjV6zg9Z
	pKj77Qh3o6ym59OZv+RNrKWSMs7dQ4/69kjNWVKaUDT4/Lec5LVaomCyd7pP4MO7vvmWQS1ynuP
	igYWa0ZenueEOAOLy99pvrbL2rUzYPVIp69D9n9YLyrLNLRlomOXBxjrBt9eQn5a5AH8PGzoGdM
	t3TO4K3ZnLpGb2hxZCqfclSTNYK9cW+hbe9aDwcxqFMSA/EUzi1YtPBF9s/f8PHJcNqA78Z43cB
	92nNT2oeSE+9bXb6EfRUPKaOpeJ38QQSfLLVb/IJGV+w4vS+Psm8mESqnIDChL8RU6UJ4K/9KOF
	8mWnC83D1xBfSNvHUXjzpkCUtpoFbGgwcyfRNvLDZb5EMR8wmzyM3LxKHoVKdq8Vvbv9rPCsISn
	Jdr1aC88Z5gGX1dfyWEJFZkmVK4H+vYhoZ0fwQq6ElLleD1gBQSHelo4tzjPXu3NlBJuKgBotC1
	F9PiWWesP68U384dgkUa5bMgPSUbZHa8j4wbgu/UW2wsgU48cIHocdfHdbRg0eugAWAQAt4STFr
	kZdb5USp8tuDdCrC9JexQhWmo2eT8YV9iadlSe8im3Q91dw=
X-Received: by 2002:a05:6402:400d:b0:6b5:9849:e328 with SMTP id 4fb4d7f45d1cf-6ba37ebdda1mr10870750a12.39.1795543131550;
        Tue, 24 Nov 2026 09:58:51 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba3711ad52sm7205762a12.35.2026.11.24.09.58.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:58:51 -0800 (PST)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	Tianyi Gao <tianyi.gao@linux.dev>,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v3 03/11] net: set tx_extra_headroom of the peer on XDP attach
Date: Tue, 24 Nov 2026 17:58:16 +0000
Message-ID: <20261124175824.60470-4-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124175824.60470-1-tianyi@cloudflare.com>
References: <20261124175824.60470-1-tianyi@cloudflare.com>
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

XDP needs XDP_PACKET_HEADROOM (256 bytes), but locally generated packets
only get needed_headroom. XDP on the peer of a veth or netkit device
then copies every packet. Generic XDP copies it in
netif_skb_check_for_xdp(), and native XDP on veth in
veth_convert_skb_to_xdp_buff().

While the peer has an XDP program, set tx_extra_headroom of the device
to XDP_PACKET_HEADROOM minus needed_headroom.
netdev_update_tx_extra_headroom() recalculates it when an XDP program
is attached or detached, also when an upper device such as a bond
propagates its program to the peer with netif_xdp_propagate(). It does
not recalculate it:

- for IFLA_NETKIT_HEADROOM, which cannot change after the netkit
  device is created,
- in dev_xdp_uninstall(), because veth and netkit unregister both ends
  together,
- when bridge or openvswitch change needed_headroom later.

openvswitch changes needed_headroom under ovs_mutex, without RTNL.
There are three ways to handle a later change of needed_headroom:

- Recalculate tx_extra_headroom in netdev_set_rx_headroom(). This
  races with an XDP attach or detach under RTNL. The last write can
  leave tx_extra_headroom at 0 while XDP is attached.
- Do not subtract needed_headroom. This always reserves needed_headroom
  bytes more than XDP needs.
- Subtract needed_headroom only when tx_extra_headroom is recalculated.

This patch uses the last one, because it does not race and reserves
only what XDP needs. If needed_headroom shrinks later, XDP on the peer
copies packets again until the next recalculation.

This removes the copy for generic XDP. Native XDP on veth also copies a
packet whose head is not a page fragment, and a locally generated
packet has a kmalloc head. A follow-up veth patch changes this for
XDP_PASS and XDP_DROP. Until then, native XDP does not use the extra
headroom, and a packet close to the MTU gets a larger head.

tx_extra_headroom is used rather than needed_headroom, because raising
needed_headroom can regress the performance of other paths.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
v3:
- Mention in the commit message and the documentation that native XDP
  on veth still copies locally generated packets (Sashiko).

v2:
- New patch, replaces IFLA_TX_EXTRA_HEADROOM for XDP on the peer
  (Stephen).
---
 Documentation/networking/netdevices.rst | 12 ++++++++
 include/linux/netdevice.h               |  1 +
 net/core/dev.c                          | 38 +++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 1f4ff67eb0fc..a1c12ca704d6 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -458,6 +458,18 @@ Packets built by ip_append_data() or ip6_append_data(), raw packets with
 IP_HDRINCL, AF_PACKET and AF_XDP copy-mode packets reserve
 ``tx_extra_headroom``.
 
+The kernel sets ``tx_extra_headroom`` of a device to the sum of these
+values:
+
+* ``XDP_PACKET_HEADROOM`` (256 bytes) minus ``needed_headroom``, when the
+  peer of a veth or netkit device has an XDP program
+
+The kernel updates ``tx_extra_headroom`` when an XDP program is attached
+to or detached from the peer, to reserve the headroom that XDP needs.
+Native XDP on veth still copies locally generated packets, because
+their head is not a page fragment. ``tx_extra_headroom`` is not updated
+when a bridge or openvswitch changes ``needed_headroom`` later.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c55a1cf42498..2486b0d10474 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4485,6 +4485,7 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u8 dev_xdp_sb_prog_count(struct net_device *dev);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
+void netdev_update_tx_extra_headroom(struct net_device *dev);
 
 u32 dev_get_min_mp_channel_count(const struct net_device *dev);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 4fedd5765867..c1788a18f0fd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10671,6 +10671,7 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
+	netdev_update_tx_extra_headroom(dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(netif_xdp_propagate);
@@ -10682,6 +10683,41 @@ u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 	return prog ? prog->aux->id : 0;
 }
 
+static void __netdev_update_tx_extra_headroom(struct net_device *dev,
+					      struct net_device *peer)
+{
+	unsigned int needed_headroom = READ_ONCE(dev->needed_headroom);
+	unsigned int tx_extra_headroom = 0;
+
+	if (peer && dev_xdp_prog_count(peer) &&
+	    needed_headroom < XDP_PACKET_HEADROOM)
+		tx_extra_headroom = XDP_PACKET_HEADROOM - needed_headroom;
+
+	WRITE_ONCE(dev->tx_extra_headroom, tx_extra_headroom);
+}
+
+/**
+ *	netdev_update_tx_extra_headroom - recalculate tx_extra_headroom
+ *	@dev: the device to check
+ *
+ *	Recalculate tx_extra_headroom of @dev and its peer. Should be called
+ *	after conditions that influence tx_extra_headroom might have changed.
+ *	The caller must hold the RTNL lock.
+ */
+void netdev_update_tx_extra_headroom(struct net_device *dev)
+{
+	struct net_device *peer = NULL;
+
+	rcu_read_lock();
+	if (dev->netdev_ops->ndo_get_peer_dev)
+		peer = dev->netdev_ops->ndo_get_peer_dev(dev);
+	__netdev_update_tx_extra_headroom(dev, peer);
+	if (peer)
+		__netdev_update_tx_extra_headroom(peer, dev);
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(netdev_update_tx_extra_headroom);
+
 static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 			   bpf_op_t bpf_op, struct netlink_ext_ack *extack,
 			   u32 flags, struct bpf_prog *prog)
@@ -10892,6 +10928,7 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 	if (cur_prog)
 		bpf_prog_put(cur_prog);
 
+	netdev_update_tx_extra_headroom(dev);
 	return 0;
 }
 
@@ -10918,6 +10955,7 @@ static int dev_xdp_detach_link(struct net_device *dev,
 	bpf_op = dev_xdp_bpf_op(dev, mode);
 	WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
 	dev_xdp_set_link(dev, mode, NULL);
+	netdev_update_tx_extra_headroom(dev);
 	return 0;
 }
 
-- 
2.56.0

