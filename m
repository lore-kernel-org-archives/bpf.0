Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934061;
	b=LcKKspHy64FoWxKyii+TiOK2pS2wnF/xNW3vlLHDCORdP6j5OCQ+04POgJdE8uEHPIik
	 9Da1TGUpa8BlFcg9It/VWUTcHgbE1DyRxeV4OGUyo6duh7SFev8TUze8/jA4kCElC/NRc
	 qLr9O+KSwmTErcByCieC1Gjoq55XqR8ALEPMNaKV7Ti4tIety6+AerFSj6g4kA8ZMdguY
	 ROYzdj8cm/a5V4Gt4gy0ZuAKFu69SuevkcrZuQNjNMNv4CDa4pbyA61Dt5/xgoCf7jk+8
	 n+OkpwRi3ZTt8meXgev3lgKCgrFG9ZdK075SSqP1q6I9ydB/MQODOY24ffHdgS6aw/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934061;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RnwfFk6AHPB5f1u9wr05tM7Qbndh69kpJh8fYIlFxE4=;
	b=NN38M0f+B2qE2EpQ3IVD8gJ8oFHQWpq+TLCdP243+9mWJIcSDTSK3sl+GqzHxp6L7XZS
	 Shgap5lJpBdVNoqQwe+HGfi90cCyWCJOrSkllkHPbPrOF7l+XbGP/VHKpdiwQcUGECqjF
	 O2lEaF1z8Zg8dRrfxMfN014oJmgJdqqWjtQWh39T14jEEQsbPrqw08LJNyb0gSaQ1Vo/M
	 rYnaH0oMDXNaJiJFad/PDtl7hgnCe+6W0QWSG4EFqK8dlH31eb7Y+ewWXUlIQ0ow7L6Db
	 A462rv22a9t6NkljEsw3glUJKjyXu9Lc0LJVe3amHOXmSp65JkIYJew/xWVAymSAONw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuFs7obK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72F606A339;
	Tue, 17 Nov 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuFs7obK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF3F1F000C5;
	Tue, 17 Nov 2026 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794934061;
	bh=RnwfFk6AHPB5f1u9wr05tM7Qbndh69kpJh8fYIlFxE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CuFs7obKrjhpxlkV1g+UAHgLi7+qD/gerhXYffCz5RKPItq2+v2ZJ47Ngc1g5fyak
	 ZslFFZa4EWAK3kf0Zz5VJIeJaTlUay+1zjnGkUI2vJ8jfRqb7I5DtAeZ+chDnlkm1u
	 astry4UjSCAuSPY5CnkSroutapdscRk4/PslRpoNsD0YWagqr/CDc4GXikn4Vz4IK2
	 U+SP2owqoIDRSiUd35E8g8m4tBh79GMV7xnLt2/5hRg+R7N7YdRl82g60Y59QB9BQl
	 rXABnTqs98/SlzNt3lmPask43Gj2fofXyBGwfIo4otymvJ5CxxfmfzbT1fDLJ19XHg
	 SjkcrsMcZxxMA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel-team@meta.com,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 3/7] net: Admit native XDP on provider queues
Date: Tue, 17 Nov 2026 17:46:54 +0100
Message-ID: <20261117164700.2157816-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117164700.2157816-1-bjorn@kernel.org>
References: <20261117164700.2157816-1-bjorn@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

XDP and memory providers are currently rejected on the same device.
Header-split RX keeps headers in normal memory, so a program can
filter packets without reading the provider payload.

Keep this restriction unless the driver declares xdp_unreadable
support. Admit native XDP in either attach order on these drivers.
Existing header-split checks require frags-aware programs.

The driver must mark provider fragments and reject XDP_TX while those
fragments remain. The core rejects helper access and frame redirects.

Keep generic and hardware-offloaded XDP rejected. Generic XDP builds
an xdp_buff from an skb without carrying the unreadable flag. Its
transmit and redirect paths also bypass the native driver guard.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 Documentation/networking/netmem.rst |  8 ++++++++
 include/net/netdev_queues.h         |  6 ++++++
 include/net/xdp.h                   |  5 ++---
 net/core/dev.c                      | 28 ++++++++++++++++++++++++++--
 net/core/dev.h                      |  1 +
 net/core/netdev_rx_queue.c          |  2 +-
 6 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index 6871dcdd700c..1ac94fc9d667 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -131,6 +131,14 @@ Driver RX Requirements
    circulation times, such as when userspace holds a reference in zerocopy
    scenarios.
 
+8. XDP programs run next to unreadable memory providers only if the driver
+   sets netdev_queue_mgmt_ops.xdp_unreadable, and only in native mode. The
+   programs see the headers in the linear part, and helpers that reach
+   unreadable fragments fail. Attach payload fragments with
+   xdp_buff_add_frag(), which marks unreadable ones, and drop XDP_TX of a
+   buffer for which xdp_buff_is_frag_unreadable() is true: the payload is
+   mapped for receive only. Redirects of such a buffer fail in the core.
+
 Driver TX Requirements
 ======================
 
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index c5335e935b7d..4f6702b284b4 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -199,6 +199,11 @@ enum {
  *
  * @supported_params:	Bitmask of supported parameters, see QCFG_*.
  *
+ * @xdp_unreadable:	Native XDP programs may run on queues with unreadable
+ *			memory providers. The driver builds XDP buffers with
+ *			xdp_buff_add_frag(), and drops XDP_TX of a buffer for
+ *			which xdp_buff_is_frag_unreadable() is true.
+ *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
  * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
  * be called for an interface which is open.
@@ -229,6 +234,7 @@ struct netdev_queue_mgmt_ops {
 				    struct netlink_ext_ack *extack);
 
 	unsigned int supported_params;
+	bool xdp_unreadable;
 };
 
 void netdev_queue_config(struct net_device *dev, int rxq,
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 20d173fe163c..167f733a0bb0 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -76,9 +76,8 @@ enum xdp_buff_flags {
 	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
 						   * pressure
 						   */
-	/* frags have unreadable mem, this can't be true for real XDP packets,
-	 * but drivers may use XDP helpers to construct Rx pkt state even when
-	 * XDP program is not attached.
+	/* frags have unreadable mem: XDP programs reach only the linear part,
+	 * and the buffer cannot become an xdp_frame
 	 */
 	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
 };
diff --git a/net/core/dev.c b/net/core/dev.c
index a230ecce9327..f0c3d56d5b83 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10575,6 +10575,27 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
 	return count;
 }
 
+/* Only native programs run next to unreadable memory providers. Drivers must
+ * mark unreadable fragments and reject XDP_TX while they remain attached.
+ * Tcp-data-split, which these providers need, also needs frags support.
+ */
+static bool netif_xdp_mp_mode_ok(const struct net_device *dev,
+				 enum bpf_xdp_mode mode)
+{
+	return mode == XDP_MODE_DRV && dev->queue_mgmt_ops->xdp_unreadable;
+}
+
+/* Can the XDP programs of @dev run next to a new memory provider? */
+bool netif_xdp_mp_ok(struct net_device *dev)
+{
+	int i;
+
+	for (i = 0; i < __MAX_XDP_MODE; i++)
+		if (dev_xdp_prog(dev, i) && !netif_xdp_mp_mode_ok(dev, i))
+			return false;
+	return true;
+}
+
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	if (!dev->netdev_ops->ndo_bpf)
@@ -10588,7 +10609,9 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 		return -EBUSY;
 	}
 
-	if (dev_get_min_mp_channel_count(dev)) {
+	if (dev_get_min_mp_channel_count(dev) &&
+	    (bpf->command != XDP_SETUP_PROG ||
+	     !netif_xdp_mp_mode_ok(dev, XDP_MODE_DRV))) {
 		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
 		return -EBUSY;
 	}
@@ -10664,7 +10687,8 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 		return -EBUSY;
 	}
 
-	if (dev_get_min_mp_channel_count(dev)) {
+	if (dev_get_min_mp_channel_count(dev) &&
+	    !netif_xdp_mp_mode_ok(dev, mode)) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory provider");
 		return -EBUSY;
 	}
diff --git a/net/core/dev.h b/net/core/dev.h
index 4e9e8cd15697..a7036302f120 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -118,6 +118,7 @@ int netdev_queue_config_revalidate(struct net_device *dev,
 bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx);
 bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx);
 bool netif_is_queue_leasee(const struct net_device *dev);
+bool netif_xdp_mp_ok(struct net_device *dev);
 
 void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
 			      const struct pp_memory_provider_params *p);
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index a7261fedd5e7..dab5107e31f8 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -204,7 +204,7 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
 		return -EINVAL;
 	}
-	if (dev_xdp_prog_count(dev)) {
+	if (!netif_xdp_mp_ok(dev)) {
 		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
 		return -EEXIST;
 	}
-- 
2.56.1

