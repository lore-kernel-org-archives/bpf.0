Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412593;
	b=qCQWLWlFeqiJCb1pan98PunPwt7pOrCGoDYGgnTuXxRj+LLB7+rVpj5CdQJ94luw1DDG
	 JDAtbagliNMbIEA/i2/fFCuOottNuPPVUPdo5vQJ/oPTTM4ks3k9XHcCjQnRUY7jimNmw
	 aVFShh/o8FCIGIJBXAFvtDu/pYFsoKbrF4vV5vWruibFWXeYlKlflChq7+NUJm/lyIbfx
	 U9lDwajwIduD91MboB7CF14JGYkCAO+E5A6JK8Jp3rdQ+MoFNq0nhaH5qlZoYLnYQZ0ab
	 Tibrr7l1WhiHyA8mXv7CY1Mevnq/C7HnjFFsXcE6imw6F4Ey9oDX6B6saBiTFOTGxnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412593;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=mDcqBZYEfPYqTUhw+INbPCC+AxyX98Z8Vjb1MhfikuY=;
	b=wQAEJQaHqK2tXvN8tVWekuOiHJ8D7O85iayBS7U6joIvTbdPLaIy8jikKjxNT3o1Hvq5
	 muTCEuZTa8xve9UxNZ5MQPbC5WvZkFrXN4/eWFVCbhIDxhIXcC2miY9gtXH1FNUARGO3B
	 /acWmPikDDYAky2qJ+1Z9nnTGpFZaTd3JJxRou7BPdyDKYVg8vdXvrULu6Xq9zbn8pVAL
	 ySLbC3W4/RyikaUi5HfxWpG1Ym6QUjyRHwVxd6pKtTee4LCSRa8x5fMddEcDCi44d7pLD
	 9JDj0dpZGY7+AIf+wwzJwqJ1sMW5xaK2SqdqXpJt32wN3eSNuQGndsoUpeV4r3EcH1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=R4PjgWNF;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716A606A31A;
	Mon, 23 Nov 2026 05:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9716A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=R4PjgWNF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mD
	cqBZYEfPYqTUhw+INbPCC+AxyX98Z8Vjb1MhfikuY=; b=R4PjgWNFsBUg3LY7Uh
	t6jmDjA4Ocd7pgJdN6+kYLoXkoDTRi6V0KMy010Hiq5hqrp+sqtwG5sSu1U28zJD
	4ZMqQ+B0mmns3gpui8vYvr/PT7gxPbsE4Aq+vljbYIQrfRSL6IpxsWz4+rSSDcrB
	lmcZsVkVe51GPxCSVQ/Pw6DSc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnL9ky0gNrZC+QIw--.65118S3;
	Mon, 23 Nov 2026 13:42:12 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	ast@kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v12 1/2] tun: run the socket filter from tun_net_xmit()
Date: Mon, 23 Nov 2026 13:42:08 +0800
Message-Id: <20261123054209.89946-2-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261123054209.89946-1-clementwei90@163.com>
References: <20261123054209.89946-1-clementwei90@163.com>
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
X-CM-TRANSID:_____wDnL9ky0gNrZC+QIw--.65118S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFyrJFy7XrWfury3Ww17ZFb_yoWfWrW7pF
	W5Ka4UtrWUGFW0gw4vyFW8Zr1aqw1Ig34xury8G34Y9Fn0gryF9ay5KFyYv3Z8CrW8CF1x
	XF42grW5Ww1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwfHUUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-RRdyGsD0jQ2kAAA3U

From: Rongguang Wei <weirongguang@kylinos.cn>

TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
points into the address space of the process that issued the ioctl, and
tun_attach() reads it again whenever a queue is attached to a persistent
device. That read can fail, and with the inverted check below the
failure was not fatal either: the queue was attached without a filter,
while a successful read returned early and left the queue unpublished.

Keep the program on the device instead: TUNATTACHFILTER builds it once
with bpf_prog_create_from_user() and stores it in tun->cbpf_prog, and
tun_net_xmit() runs it from there. A per-queue flag records whether the
queue was attached with IFF_NOFILTER, so a queue attached later does not
depend on the caller's buffer at all.

Also tun no longer calls sk_attach_filter() and sk_detach_filter(). There
is no caller in a module, so the exports are unused and here removed it.
The users left in the tree are SO_ATTACH_FILTER and SO_DETACH_FILTER in
net/core/sock.c, which is always built in.

The inverted check was discovered by manual code inspection first.

Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/tun.c | 93 ++++++++++++++++++++++-------------------------
 net/core/filter.c |  2 -
 2 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d4870bdc156f..fe3e19799709 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -135,6 +135,7 @@ struct tun_file {
 	struct fasync_struct *fasync;
 	/* only used for fasnyc */
 	unsigned int flags;
+	bool nofilter;			/* attached with IFF_NOFILTER */
 	union {
 		u16 queue_index;
 		unsigned int ifindex;
@@ -176,8 +177,8 @@ struct tun_prog {
 };
 
 /* Since the socket were moved to tun_file, to preserve the behavior of persist
- * device, socket filter, sndbuf and vnet header size were restore when the
- * file were attached to a persist device.
+ * device, sndbuf and vnet header size were restore when the file were attached
+ * to a persist device.
  */
 struct tun_struct {
 	struct tun_file __rcu	*tfiles[MAX_TAP_QUEUES];
@@ -196,9 +197,7 @@ struct tun_struct {
 	int			vnet_hdr_sz;
 	int			sndbuf;
 	struct tap_filter	txflt;
-	struct sock_fprog	fprog;
-	/* protected by rtnl lock */
-	bool			filter_attached;
+	struct sock_fprog	fprog;		/* header, for TUNGETFILTER */
 	u32			msg_enable;
 	spinlock_t lock;
 	struct hlist_head flows[TUN_NUM_FLOW_ENTRIES];
@@ -213,6 +212,7 @@ struct tun_struct {
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
+	struct tun_prog __rcu *cbpf_prog;	/* from TUNATTACHFILTER */
 	struct ethtool_link_ksettings link_ksettings;
 	/* init args */
 	struct file *file;
@@ -731,7 +731,7 @@ static void tun_force_wake_queue(struct tun_struct *tun,
 }
 
 static int tun_attach(struct tun_struct *tun, struct file *file,
-		      bool skip_filter, bool napi, bool napi_frags,
+		      bool nofilter, bool napi, bool napi_frags,
 		      bool publish_tun)
 {
 	struct tun_file *tfile = file->private_data;
@@ -757,15 +757,6 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 
 	err = 0;
 
-	/* Re-attach the filter to persist device */
-	if (!skip_filter && (tun->filter_attached == true)) {
-		lock_sock(tfile->socket.sk);
-		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
-		release_sock(tfile->socket.sk);
-		if (!err)
-			goto out;
-	}
-
 	if (!tfile->detached &&
 	    ptr_ring_resize(&tfile->tx_ring, dev->tx_queue_len,
 			    GFP_KERNEL, tun_ptr_free)) {
@@ -819,6 +810,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	 * initialized tfile; otherwise we risk using half-initialized
 	 * object.
 	 */
+	WRITE_ONCE(tfile->nofilter, nofilter);
 	if (publish_tun)
 		rcu_assign_pointer(tfile->tun, tun);
 	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
@@ -1071,6 +1063,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	int txq = skb->queue_mapping;
 	struct netdev_queue *queue;
 	struct tun_file *tfile;
+	struct tun_prog *prog;
 	int len = skb->len;
 	int ret;
 
@@ -1096,10 +1089,20 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
-	if (tfile->socket.sk->sk_filter) {
-		drop_reason = sk_filter_reason(tfile->socket.sk, skb);
-		if (drop_reason)
+	/* Classic filter set with TUNATTACHFILTER.  A queue attached with
+	 * IFF_NOFILTER does not run it.
+	 */
+	prog = rcu_dereference(tun->cbpf_prog);
+	if (prog && !READ_ONCE(tfile->nofilter)) {
+		/* A filter returning 0 drops the packet, any other value is
+		 * the length to keep.  pskb_trim() does nothing when that
+		 * length is larger than the skb.
+		 */
+		len = bpf_prog_run_clear_cb(prog->prog, skb);
+		if (!len || pskb_trim(skb, len)) {
+			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 			goto drop;
+		}
 	}
 
 	len = run_ebpf_filter(tun, skb, len);
@@ -2417,6 +2420,7 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	__tun_set_ebpf(tun, &tun->cbpf_prog, NULL);
 }
 
 static void tun_setup(struct net_device *dev)
@@ -2975,7 +2979,6 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		tun->vnet_hdr_sz = sizeof(struct virtio_net_hdr);
 
 		tun->align = NET_SKB_PAD;
-		tun->filter_attached = false;
 		tun->sndbuf = tfile->socket.sk->sk_sndbuf;
 		tun->rx_batched = 0;
 		RCU_INIT_POINTER(tun->steering_prog, NULL);
@@ -3079,39 +3082,34 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
 	return 0;
 }
 
-static void tun_detach_filter(struct tun_struct *tun, int n)
+static int tun_attach_filter(struct tun_struct *tun, void __user *data)
 {
-	int i;
+	struct sock_fprog fprog;
 	struct tun_file *tfile;
+	struct bpf_prog *prog;
+	int i, ret;
 
-	for (i = 0; i < n; i++) {
-		tfile = rtnl_dereference(tun->tfiles[i]);
-		lock_sock(tfile->socket.sk);
-		sk_detach_filter(tfile->socket.sk);
-		release_sock(tfile->socket.sk);
-	}
+	if (copy_from_user(&fprog, data, sizeof(fprog)))
+		return -EFAULT;
 
-	tun->filter_attached = false;
-}
+	ret = bpf_prog_create_from_user(&prog, &fprog, NULL, false);
+	if (ret)
+		return ret;
 
-static int tun_attach_filter(struct tun_struct *tun)
-{
-	int i, ret = 0;
-	struct tun_file *tfile;
+	ret = __tun_set_ebpf(tun, &tun->cbpf_prog, prog);
+	if (ret) {
+		bpf_prog_destroy(prog);
+		return ret;
+	}
 
 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
-		lock_sock(tfile->socket.sk);
-		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
-		release_sock(tfile->socket.sk);
-		if (ret) {
-			tun_detach_filter(tun, i);
-			return ret;
-		}
+		WRITE_ONCE(tfile->nofilter, false);
 	}
 
-	tun->filter_attached = true;
-	return ret;
+	/* Only TUNGETFILTER reads it */
+	tun->fprog = fprog;
+	return 0;
 }
 
 static void tun_set_sndbuf(struct tun_struct *tun)
@@ -3307,7 +3305,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 
 		if (tfile->detached)
 			ifr.ifr_flags |= IFF_DETACH_QUEUE;
-		if (!tfile->socket.sk->sk_filter)
+		if (tfile->nofilter || !rcu_access_pointer(tun->cbpf_prog))
 			ifr.ifr_flags |= IFF_NOFILTER;
 
 		if (copy_to_user(argp, &ifr, ifreq_len))
@@ -3455,11 +3453,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EINVAL;
 		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
 			break;
-		ret = -EFAULT;
-		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
-			break;
-
-		ret = tun_attach_filter(tun);
+		ret = tun_attach_filter(tun, argp);
 		break;
 
 	case TUNDETACHFILTER:
@@ -3467,8 +3461,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EINVAL;
 		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
 			break;
-		ret = 0;
-		tun_detach_filter(tun, tun->numqueues);
+		ret = __tun_set_ebpf(tun, &tun->cbpf_prog, NULL);
 		break;
 
 	case TUNGETFILTER:
diff --git a/net/core/filter.c b/net/core/filter.c
index 53c042b267ab..fdd7fd854274 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1565,7 +1565,6 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(sk_attach_filter);
 
 int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk)
 {
@@ -11775,7 +11774,6 @@ int sk_detach_filter(struct sock *sk)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(sk_detach_filter);
 
 int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len)
 {
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

