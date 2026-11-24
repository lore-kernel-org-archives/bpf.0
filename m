Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533185;
	b=lKiNxvjiRWVel6aSfVkF+1jldBP+5m6psApb4acELHqsNeb9kdf0rej/Qlmp/xuanbbd
	 ir4EP36DJi48d7l12WHZfdWWaB3IDtbFJ2VMV6A/ZW1YE3Oe0JIUkJ5czLNOBwS+EdWkF
	 f6Sf9oaGJa1pd6cYClkBt+h740cFBaEr8NvZYNrtCUKP4H4PMhygdO32cHg6iWrjR62ix
	 guH8GnuQF4g0ZMwEtmf5m5kDI3v0CSm8ReYXClS1IKu7YQSYJjrKSKJEM3NdXxqI5Mxhk
	 9GzJHgu5ZSobuVK0K9JZ59BYx3jBqQK3MKuu4u1vIzRREVXjxhT45465x/NEuPyDgAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vpd0lROsX5a/XF56z2hf5LS7nxFovlUX1TJjxvTaxHs=;
	b=qA7RBxwFqWQTHbFXSeFPlXhpGq03G084iOUTpxk2OqNferqLBiezYkQFFMfnllb1Q9dJ
	 Bbs2w6+kFmPSPn8ead5gNXsDc7I89QSsPMWH6Cb3LuE9qKkfJKm5OGzivESs/NECMP78V
	 8TcbboEEM6nPcPm79NUyDroFLUBFiG+NVma4urUpF9HJ9eicf7s9E0COHQWURHyNWeeXL
	 dBhkz+Q4xgo0Fa/D2uGRkPTmyUxa90e9GBoszPiKotNNWbTxkz+hQ5zcQE7pFAFss2TF8
	 cRWSq/drjA9fdxRsfvwCNAq/N8rLjageJPEhq6gxUh0VIteWMVszmkDtnRRU2v+NgYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=H7SZps7d;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29355606A336
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29355606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=H7SZps7d
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso56692505e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 07:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795533182; x=1796137982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpd0lROsX5a/XF56z2hf5LS7nxFovlUX1TJjxvTaxHs=;
        b=H7SZps7dlT2FpBTrfNfi1083KMNJ6FiEwqlfaapdzLdWZBI+eeY1Pb6ifPToJr7B/K
         vQbD11jgSjp/S27apFzaF+EhrM+K50VmbgQ8hYz/sQIp4tcYP4H0avpBpNcvmj9d1/w4
         6HFQrkIMlzUJXuaIufsTJGnKy68XrhN5h+st0203hwZU6Vf6UWz0Slc1j2Btf/hILZ98
         ESj0LVOCEW2c8lMpNn+9hh1nHkcVpMu1zLS5+LTePpzX8O+bllmzvUe7WRJ4bLe6S5ye
         mY9wdv2ojMEzwpyixY4ElFWst1uf7BcRod9xjmQBqCXDwIGrCgpAqWhxIsggYFOcAcEt
         yOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795533182; x=1796137982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpd0lROsX5a/XF56z2hf5LS7nxFovlUX1TJjxvTaxHs=;
        b=JUi92ZEy80D1zx/YzsvOKgEGk4o+jXSWv7ppHISoH1qNTIGfgXIwdUSmROroeK3jBC
         lHak5RpXNXZo1kDXLy9FhzOdkOx9njrQfWZ9O5iFSCY5As3BSTRDfQwFxjOa+xTA4cWQ
         lRyrBg5G7bD/p1obTYvGtr12vYSTLlIWL0uuDUM/0+tjqewKTnEewFwL7Xp7hwGnOdPk
         liWp5yfg2uRY/f/BBg1MLcFpu9rIk4mMPycR8Q95eJ2Cs69L//BNxDPQdD5psLGIja7b
         JfM5CZJXIAnmB04oEFKCvgP1u3dqswMw2DQaWTdfVCpuoj0HoYCBLHbu/5uYoOMY9tGI
         Aj3g==
X-Gm-Message-State: APuU4Z8OtM3qaXIzrwYtVqipY8aGCM++xyd9iEWmL00kUmnQWMqepHkA
	vYz6PJl8gPPHqtLlhc1lfdCVcDIvyEFRGD/exGpc6jIPouLF35UDIApJFkzjlTy2ALayo8a1+ja
	vVOmezm1GMA==
X-Gm-Gg: AZFdTZeDbiteKr0+Xex37iEtD/vauDaS21yqMkIxb0in08McsqAFQW0T3J5QqNA4xz4
	ip0J3TDNHjqn8Xheg9JEtl7NCdFgNfQXysOz5mHFVhZuHMNy5v0GOAoJVlSMb/olMju4lUUci6I
	8L7E0MbLWCSCI4q8KVrOicHpyYXSdHwE1p6jggCt0LsdSU3lUqFKGGt5M7hAHBNd7GRAFZHk/aq
	NfY9RW0eW945Y6UGapZjePo5RrV73GIVkx00L2MvBD6MTWEssByMS/2aIeMIpbtJF7x8pfmC1aG
	+zGXrGOxkkQd7wO+Xs29OOh6kITp+RPZSklDOHWlJxUZw9rWYx/foM2k4QObBOatx03/hFxjmbU
	xGPZngfW0UtWwo/+hGuPWhS7DGXusof5X0lTLDlc8fRgxLN4SRs5hdLfkdImGeU2EpIWlSoC8MZ
	eBlNFNbKmQyztSoPy5Dl9k0VDNAmhFzOGMETKQq3XggXz3DVLq7Zy6fvGci+iN3IMaX9BxOATYT
	a1AWkDK/AqT/Qp9Wzk9dpLAIfVfs6Awn9wFUb4uBeUK5bkg4akgdZYdJsIMaTlJGagnDrtZK0d3
	FpgshhCWoeE0KpaPspqNe6KDI5IcXaafAEf4XHeeshDcw/83Xg8=
X-Received: by 2002:a05:600c:820c:b0:4bb:7987:fbbc with SMTP id 5b1f17b1804b1-4bb887c29b4mr273103965e9.1.1795533182447;
        Tue, 24 Nov 2026 07:13:02 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb906e4ce6sm244162175e9.4.2026.11.24.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:13:01 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH RFC bpf-next 3/4] bpf: support bpf_sk_assign in netkit tx path
Date: Tue, 24 Nov 2026 17:12:43 +0200
Message-ID: <20261124151244.1423343-4-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124151244.1423343-1-razor@blackwall.org>
References: <20261124151244.1423343-1-razor@blackwall.org>
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

Let netkit programs assign a socket in the receiving network namespace,
for example a transparent proxy listener on the host for traffic coming
from a pod.

A netkit program runs with skb->dev already set to the peer and on
NETKIT_PASS the skb goes straight to __netif_rx() on that peer. The
assigned skb therefore doesn't travel the tx path of the sending side, so
transmit code doesn't need to understand the new ownership.

General tc egress assignment stays unsupported.

netkit records the skb it is running programs for in the BPF net
context and the helper only takes the netkit path for that skb.
A clone made with bpf_clone_redirect(), test runs, cls_bpf and act_bpf on
egress still get -EOPNOTSUPP.

The backlog queue outlives the RCU section so the skb takes a reference
with sock_pfree_ref even for SOCK_RCU_FREE sockets such as tcp
listeners.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c           | 10 ++++++++++
 include/linux/filter.h         |  4 ++++
 include/net/netkit.h           | 15 +++++++++++++++
 include/uapi/linux/bpf.h       |  9 +++++++--
 net/core/filter.c              | 13 ++++++++++---
 tools/include/uapi/linux/bpf.h |  9 +++++++--
 6 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 75a1a561e5aa..d32d98cad6f6 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -53,15 +53,25 @@ static __always_inline int
 netkit_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
 	   enum netkit_action ret)
 {
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
 	const struct bpf_mprog_fp *fp;
 	const struct bpf_prog *prog;
+	struct sk_buff *prev = NULL;
 
+	if (bpf_net_ctx->ri.kern_flags & BPF_RI_F_NETKIT_SK_ASSIGN)
+		prev = bpf_net_ctx->sk_assign_skb;
+	bpf_net_ctx->sk_assign_skb = skb;
+	bpf_net_ctx->ri.kern_flags |= BPF_RI_F_NETKIT_SK_ASSIGN;
 	bpf_mprog_foreach_prog(entry, fp, prog) {
 		bpf_compute_data_pointers(skb);
 		ret = bpf_prog_run(prog, skb);
 		if (ret != NETKIT_NEXT)
 			break;
 	}
+	if (prev)
+		bpf_net_ctx->sk_assign_skb = prev;
+	else
+		bpf_net_ctx->ri.kern_flags &= ~BPF_RI_F_NETKIT_SK_ASSIGN;
 	return ret;
 }
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 61448be53f8d..ddc4e6912e0c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -981,6 +981,7 @@ struct bpf_nh_params {
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
 #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+#define BPF_RI_F_NETKIT_SK_ASSIGN	BIT(5)
 
 struct bpf_redirect_info {
 	u64 tgt_index;
@@ -998,6 +999,9 @@ struct bpf_net_context {
 	struct list_head cpu_map_flush_list;
 	struct list_head dev_map_flush_list;
 	struct list_head xskmap_map_flush_list;
+#ifdef CONFIG_NETKIT
+	struct sk_buff *sk_assign_skb;
+#endif
 };
 
 static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
diff --git a/include/net/netkit.h b/include/net/netkit.h
index 9ec0163739f4..70992f145a63 100644
--- a/include/net/netkit.h
+++ b/include/net/netkit.h
@@ -4,6 +4,7 @@
 #define __NET_NETKIT_H
 
 #include <linux/bpf.h>
+#include <linux/filter.h>
 
 #ifdef CONFIG_NETKIT
 int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
@@ -11,6 +12,15 @@ int netkit_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int netkit_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog);
 int netkit_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr);
 INDIRECT_CALLABLE_DECLARE(struct net_device *netkit_peer_dev(struct net_device *dev));
+
+static inline bool netkit_runs_skb(const struct sk_buff *skb)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	return bpf_net_ctx &&
+	       (bpf_net_ctx->ri.kern_flags & BPF_RI_F_NETKIT_SK_ASSIGN) &&
+	       bpf_net_ctx->sk_assign_skb == skb;
+}
 #else
 static inline int netkit_prog_attach(const union bpf_attr *attr,
 				     struct bpf_prog *prog)
@@ -40,5 +50,10 @@ static inline struct net_device *netkit_peer_dev(struct net_device *dev)
 {
 	return NULL;
 }
+
+static inline bool netkit_runs_skb(const struct sk_buff *skb)
+{
+	return false;
+}
 #endif /* CONFIG_NETKIT */
 #endif /* __NET_NETKIT_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 62de0919db72..25f89f3cca1e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4611,7 +4611,10 @@ union bpf_attr {
  *		**bpf_clone_redirect**\ () or other methods outside of BPF may
  *		interfere with successful delivery to the socket.
  *
- *		This operation is only valid from TC ingress path.
+ *		This operation is valid from TC ingress and from netkit
+ *		programs. In netkit programs, only full TCP and UDP sockets
+ *		are accepted, and the *skb* then holds a reference on *sk*
+ *		until the receive path consumes it or the *skb* is freed.
  *
  *		The *flags* argument must be zero.
  *	Return
@@ -4624,7 +4627,9 @@ union bpf_attr {
  *		**-ENETUNREACH** if the socket is unreachable (wrong netns).
  *
  *		**-EOPNOTSUPP** if the operation is not supported, for example
- *		a call from outside of TC ingress.
+ *		a call from outside of TC ingress or netkit programs, or, in a
+ *		netkit program, a socket other than a full TCP or UDP socket or
+ *		an *skb* that already carries a socket it does not own.
  *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
diff --git a/net/core/filter.c b/net/core/filter.c
index 3206b40887c5..a8e7b46bd648 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8132,21 +8132,28 @@ static const struct bpf_func_proto bpf_tcp_gen_syncookie_proto = {
 
 BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 {
+	bool from_netkit = netkit_runs_skb(skb);
+
 	if (!sk || flags != 0)
 		return -EINVAL;
-	if (!skb_at_tc_ingress(skb))
+	if (from_netkit) {
+		if (!sk_fullsock(sk) || (!sk_is_tcp(sk) && !sk_is_udp(sk)) ||
+		    (skb->sk && !skb->destructor))
+			return -EOPNOTSUPP;
+	} else if (!skb_at_tc_ingress(skb)) {
 		return -EOPNOTSUPP;
+	}
 	if (unlikely(dev_net(skb->dev) != sock_net(sk)))
 		return -ENETUNREACH;
 	if (sk_unhashed(sk))
 		return -EOPNOTSUPP;
-	if (sk_is_refcounted(sk) &&
+	if ((from_netkit || sk_is_refcounted(sk)) &&
 	    unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 		return -ENOENT;
 
 	skb_orphan(skb);
 	skb->sk = sk;
-	skb->destructor = sock_pfree;
+	skb->destructor = from_netkit ? sock_pfree_ref : sock_pfree;
 
 	return 0;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 62de0919db72..25f89f3cca1e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4611,7 +4611,10 @@ union bpf_attr {
  *		**bpf_clone_redirect**\ () or other methods outside of BPF may
  *		interfere with successful delivery to the socket.
  *
- *		This operation is only valid from TC ingress path.
+ *		This operation is valid from TC ingress and from netkit
+ *		programs. In netkit programs, only full TCP and UDP sockets
+ *		are accepted, and the *skb* then holds a reference on *sk*
+ *		until the receive path consumes it or the *skb* is freed.
  *
  *		The *flags* argument must be zero.
  *	Return
@@ -4624,7 +4627,9 @@ union bpf_attr {
  *		**-ENETUNREACH** if the socket is unreachable (wrong netns).
  *
  *		**-EOPNOTSUPP** if the operation is not supported, for example
- *		a call from outside of TC ingress.
+ *		a call from outside of TC ingress or netkit programs, or, in a
+ *		netkit program, a socket other than a full TCP or UDP socket or
+ *		an *skb* that already carries a socket it does not own.
  *
  * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
  *	Description
-- 
2.47.3

