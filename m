Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF13A7194
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390911; cv=none; b=p9u1djY8/krXGz6HSkzGO5Lt7JmiJJAwrmfU0lsTNsQogEMAQVjHqXmNuOEn+3NYFAtUxalFxlkBAUK5HQKw37VM3xSMSKqDyTjHa/eexD80ayG6wy/wxA+gNzUr+rKVjOyyxYvJ2Q8Np6BL23ztvrZSL6hasCIrUxZoyMfU9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390911; c=relaxed/simple;
	bh=B5nIhOq7RsNtBRTMT1o+XcFUNnnc+kaB+YDMyMpHQzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R7GhBffP/Trl4sXyGXmPavTqQR+a8D6FUOxktTPXfukzo/UZFdQWQF4C5l3/hVaj58PdccSAF0/deIJj5UxWMEr/pcGoztFQXGtwjUuX+6CM8D2L9k+5yvCxj6SfG+CDUrWK5F5yhRo+0KbdercWWMWZYe7INinO9Rg7QWIB0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tzk0MIFW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tzk0MIFW"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d985df4cfso2478375a91.1
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 15:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781390910; x=1781995710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+vq04JnT1NBWjb7xNUUUw/8bONWR17HLNH9WyhgRV0=;
        b=Tzk0MIFWvRSttZO0STT8xQtO26QN1HsKvyrEe0bzzpigNeGv8mTbQH5n4s+CmRV+3A
         1E3z3jv0ed+u/PAjL1uo2ecZDMU199B4rjVV7uAiefMh5VGMvqOspB55oJwq/9itMAs4
         l2np0WLa/UV6r94GY23kiEWS64S2Xk29+Y995eBvhdwQ1aYYrWuE9xN0HPJx5MtPb7HK
         3nMVYlgvp/Xqt52uHsc/gVkSsFbN2a16L9fqhoA4gS/JaiT7zVEtpP5fVW9Ux3TY+V29
         U/ONsBKtAypNdvyjLmWoT55P6RGs7q3l8LqcSHB/rMdtVKfTBD/a9xXnQwvPhTD8zkDo
         O7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390910; x=1781995710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+vq04JnT1NBWjb7xNUUUw/8bONWR17HLNH9WyhgRV0=;
        b=WDtLMbTCJd1SIOVl/YZMGmJSlTYLjiOEbkPwS1finHhu6qzJ18X8gq3Gu+kOkb56uI
         ek3wyxdxEGy7r3fxoExJoC3Zj+bHYsELKjrcSr1DIKQHx3gjZWIbD3fYNla/j4gj/egd
         RPxNE5mmGyJt/TGw8mCM/flQiM7O6EJWrjanKEeKpUtLVPBA5fxNSj8RV9KEul53V2zq
         sdJTgTHWlb83lrPpPwLTSWq70WJuGzZ7GKeOUtLAlI2THuiJ95yh+6spDQa02uRA3byK
         WXT4bemNU5LatQ+k3gsFxxVO0S/VlR5XpdRwi7NdJzI4/HXh9Spi/UKx7d1noKtBI2x1
         Gnrg==
X-Forwarded-Encrypted: i=1; AFNElJ9TXQLpl05tsQp/uYNXUKFRGiuMH0jefS7MhUSPKMyAValsnrIhYpqYctfzSGu/rns9BhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/J3B+cCvynzVDeluQcy9LqWn8ykdj5ncQ8v8mHSEQW+OMzJoQ
	+5XvlL6ctVyRM0Tp8gTmGkamHzt57jGgVApSIddrcUGIQtriHw5ORwO78yZjRXDT10tJ13Jr7BD
	3Ic8bhw==
X-Received: from pgjz6.prod.google.com ([2002:a63:e546:0:b0:c79:1600:6a09])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:144d:b0:398:840d:39aa
 with SMTP id adf61e73a8af0-3b783f0a3c3mr9468816637.29.1781390909562; Sat, 13
 Jun 2026 15:48:29 -0700 (PDT)
Date: Sat, 13 Jun 2026 22:48:07 +0000
In-Reply-To: <20260613224823.2399535-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613224823.2399535-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613224823.2399535-4-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 3/4] bpf: Add kfunc to proxy TX HW Timestamp.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In the setup mentioned in the previous patch, it is impossible
for socket applications to get TX hardware timestamps via
SCM_TIMESTAMPING.

To proxy TX hardware timestamp, let's add two kfuncs:

  * bpf_skb_scrub_tx_tstamp()    : scrub skb_shinfo(skb)->tx_flags
  * bpf_skb_complete_tx_tstamp() : enqueue skb to sk->sk_error_queue

The key idea is to regenerate an skb that contains all the
information required for the TX timestamp, identical to the
original skb.

Here is how it works:

When the socket application sends a packet, BPF prog at tc/egress
checks skb_shinfo()->tx_flags.  If it has SKBTX_HW_TSTAMP_NOBPF,
BPF prog scrub the value by bpf_skb_scrub_tx_tstamp() and inserts
a GENEVE option to signal that the packet wants TX HW timestamp.

The proxy decapsulates and forwards the packet to the hardware,
and if it has GENEVE option, the proxy keeps the original packet
until TX completion.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              |     ^ decap packet and              |
  userspace   |     |  keep it till TX cmpl         |
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `----|       geneve0       |<---'
  kernel     | |   skb   +---------------------+
             | |             ^             |
             | |             |             v
             | |          +------------------+  check skb_shinfo()->tx_flags
             | |          |  BPF@tc/egress   |    and insert a GENEVE option
             | |          +------------------+
  -----------| |-----------------------------------------------
              |
              v
       +------------+
       |  hardware  |
       +------------+

Once the proxy gets TX hwtstamp, encapsulate the original packet
with TX hwtstamp embedded in GENEVE option, and sends it to the
GENEVE device.

At tc@ingress, BPF extracts the TX hwtstamp and sets it to skb.
Then, it looks up the sender socket, assigns it to skb->sk,
calls bpf_skb_complete_tx_tstamp(), and returns TCX_ERRQUEUE to
put the skb to skb->sk->sk_error_queue.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              ^     | encap packet                  ^ get TX hwtstamp by
  userspace   |     |  w/ TX hwtstamp               |  recvmsg(MSG_ERRQUEUE)
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `--->|       geneve0       |    |
  kernel     | |   skb   +---------------------+    |
             | |             |              ________'
             | |             v             |    extract TX hwtstamp to skb
             | |          +------------------+   and look up the sender sk
             | |          |  BPF@tc/ingress  |   and enqueue skb to its
             | |          +------------------+    sk->sk_error_queue
  -----------| |-----------------------------------------------
              |
              | TX completion w/ TX hwtstamp
       +------------+
       |  hardware  |
       +------------+

This provides transparent TX HW timestamp support, and the socket
application can finally receive it via recvmsg(MSG_ERRQUEUE).

Note that struct bpf_tx_tstamp_cmpl needs network_offset and
payload_offset so that

  1. ip_cmsg_recv() and ipv6_recv_error() can correctly parse
     the IPv4/IPv6 header for some control messages

  2. applications can receive the original payload

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Remove __packed and use unnamed bit-field in struct
    bpf_tx_tstamp_cmpl (Alexei Starovoitov)
  * Check !skb_at_tc_ingress() in bpf_skb_complete_tx_tstamp()
    (Sashiko)
  * Use skb_unclone() instead of skb_heaeder_clone() (Sashiko)
---
 include/linux/filter.h       |  2 ++
 include/linux/skbuff.h       |  8 +++++
 include/net/tcx.h            |  1 +
 include/uapi/linux/bpf.h     |  1 +
 include/uapi/linux/pkt_cls.h |  3 +-
 kernel/bpf/verifier.c        |  6 +++-
 net/core/dev.c               | 39 ++++++++++++++++++++++
 net/core/filter.c            | 63 ++++++++++++++++++++++++++++++++++++
 8 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 67d337ede91b..bd8ce71aabb5 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -792,6 +792,7 @@ struct bpf_nh_params {
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
 #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+#define BPF_RI_F_TX_TS_CMPL	BIT(5)
 
 struct bpf_redirect_info {
 	u64 tgt_index;
@@ -802,6 +803,7 @@ struct bpf_redirect_info {
 	enum bpf_map_type map_type;
 	struct bpf_nh_params nh;
 	u32 kern_flags;
+	struct bpf_tx_tstamp_cmpl txtscmpl;
 };
 
 struct bpf_net_context {
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e0aa190565af..dae49e89aca0 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4703,6 +4703,14 @@ struct bpf_hwtstamp {
 	u64 :64;
 };
 
+struct bpf_tx_tstamp_cmpl {
+	u32 tskey;
+	__be16 protocol;
+	u16 network_offset;
+	u16 payload_offset;
+	u16 :16;
+};
+
 /**
  * skb_complete_tx_timestamp() - deliver cloned skb with tx timestamps
  *
diff --git a/include/net/tcx.h b/include/net/tcx.h
index 23a61af13547..052e751d907e 100644
--- a/include/net/tcx.h
+++ b/include/net/tcx.h
@@ -151,6 +151,7 @@ static inline enum tcx_action_base tcx_action_code(struct sk_buff *skb,
 		fallthrough;
 	case TCX_DROP:
 	case TCX_REDIRECT:
+	case TCX_ERRQUEUE:
 		return code;
 	case TCX_NEXT:
 	default:
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 11dd610fa5fa..5403ffe1a63d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6555,6 +6555,7 @@ enum tcx_action_base {
 	TCX_PASS	= 0,
 	TCX_DROP	= 2,
 	TCX_REDIRECT	= 7,
+	TCX_ERRQUEUE	= 9,
 };
 
 struct bpf_xdp_sock {
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 28d94b11d1aa..337f1bdbabb6 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -76,7 +76,8 @@ enum {
 				   * the skb and act like everything
 				   * is alright.
 				   */
-#define TC_ACT_VALUE_MAX	TC_ACT_TRAP
+#define TC_ACT_ERRQUEUE		9
+#define TC_ACT_VALUE_MAX	TC_ACT_ERRQUEUE
 
 /* There is a special kind of actions called "extended actions",
  * which need a value parameter. These have a local opcode located in
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e29edc101cb1..ce44d4e7f8f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11046,6 +11046,7 @@ enum special_kfunc_type {
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
 	KF_bpf_skb_set_hwtstamp,
+	KF_bpf_skb_scrub_tx_tstamp,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11145,8 +11146,10 @@ BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_skb_set_hwtstamp)
+BTF_ID(func, bpf_skb_scrub_tx_tstamp)
 #else
 BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 
 static bool is_bpf_obj_new_kfunc(u32 func_id)
@@ -11231,7 +11234,8 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data] ||
-	       meta->func_id == special_kfunc_list[KF_bpf_skb_set_hwtstamp];
+	       meta->func_id == special_kfunc_list[KF_bpf_skb_set_hwtstamp] ||
+	       meta->func_id == special_kfunc_list[KF_bpf_skb_scrub_tx_tstamp];
 }
 
 static enum kfunc_ptr_arg_type
diff --git a/net/core/dev.c b/net/core/dev.c
index 0c6c270d9f7d..a45cdf38616a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4456,6 +4456,41 @@ tcx_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
 	return tcx_action_code(skb, ret);
 }
 
+static int skb_do_completion(struct sk_buff *skb)
+{
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
+	struct bpf_tx_tstamp_cmpl *txtscmpl;
+
+	if (!(ri->kern_flags & BPF_RI_F_TX_TS_CMPL))
+		goto drop;
+
+	if (skb_unclone(skb, GFP_ATOMIC))
+		goto drop;
+
+	__skb_push(skb, skb->mac_len);
+
+	txtscmpl = &ri->txtscmpl;
+
+	drop_reason = pskb_may_pull_reason(skb, txtscmpl->payload_offset);
+	if (drop_reason)
+		goto drop;
+
+	skb->protocol = txtscmpl->protocol;
+	skb_set_network_header(skb, txtscmpl->network_offset);
+	__skb_pull(skb, txtscmpl->payload_offset);
+
+	skb_shinfo(skb)->tskey = txtscmpl->tskey;
+	skb_shinfo(skb)->tx_flags = SKBTX_HW_TSTAMP_NOBPF;
+	__skb_tstamp_tx(skb, NULL, skb_hwtstamps(skb), skb->sk, SCM_TSTAMP_SND);
+
+	consume_skb(skb);
+	return NET_RX_SUCCESS;
+drop:
+	kfree_skb_reason(skb, drop_reason);
+	return NET_RX_DROP;
+}
+
 static __always_inline struct sk_buff *
 sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		   struct net_device *orig_dev, bool *another)
@@ -4504,6 +4539,10 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		*ret = NET_RX_DROP;
 		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
+	case TC_ACT_ERRQUEUE:
+		*ret = skb_do_completion(skb);
+		bpf_net_ctx_clear(bpf_net_ctx);
+		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
 	case TC_ACT_QUEUED:
diff --git a/net/core/filter.c b/net/core/filter.c
index bd8c9a7b7505..c8d00067536b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12396,6 +12396,67 @@ __bpf_kfunc int bpf_skb_set_hwtstamp(struct __sk_buff *s,
 	return 0;
 }
 
+__bpf_kfunc int bpf_skb_scrub_tx_tstamp(struct __sk_buff *s)
+{
+	struct sk_buff *skb = (struct sk_buff *)s;
+
+	if (skb_at_tc_ingress(skb))
+		return -EINVAL;
+
+	if (skb_unclone(skb, GFP_ATOMIC))
+		return -ENOMEM;
+
+	skb_shinfo(skb)->tx_flags = 0;
+
+	bpf_compute_data_pointers(skb);
+
+	return 0;
+}
+
+__bpf_kfunc int bpf_skb_complete_tx_tstamp(struct __sk_buff *s,
+					   struct bpf_tx_tstamp_cmpl *attrs,
+					   int attrs__sz)
+{
+	int defined_sz = offsetofend(struct bpf_tx_tstamp_cmpl, payload_offset);
+	struct sk_buff *skb = (struct sk_buff *)s;
+	struct bpf_redirect_info *ri;
+	struct sock *sk = skb->sk;
+	s32 delta;
+
+	if (attrs__sz != sizeof(*attrs) ||
+	    memchr_inv((char *)attrs + defined_sz, 0, sizeof(u16)))
+		return -EINVAL;
+
+	if (!sk || !sk_fullsock(sk))
+		return -EINVAL;
+
+	if (!skb_at_tc_ingress(skb))
+		return -EINVAL;
+
+	if (attrs->payload_offset > skb->len)
+		return -EINVAL;
+
+	delta = attrs->payload_offset - attrs->network_offset;
+	switch (attrs->protocol) {
+	case htons(ETH_P_IP):
+		if (delta < (s32)sizeof(struct iphdr) || !sk_is_inet(sk))
+			return -EINVAL;
+		break;
+	case htons(ETH_P_IPV6):
+		if (delta < (s32)sizeof(struct ipv6hdr) || sk->sk_family != AF_INET6)
+			return -EINVAL;
+		break;
+	default:
+		return -EAFNOSUPPORT;
+	}
+
+	ri = bpf_net_ctx_get_ri();
+	ri->kern_flags |= BPF_RI_F_TX_TS_CMPL;
+	ri->txtscmpl = *attrs;
+
+	return 0;
+}
+
 /**
  * bpf_xdp_pull_data() - Pull in non-linear xdp data.
  * @x: &xdp_md associated with the XDP buffer
@@ -12525,6 +12586,8 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
 BTF_KFUNCS_START(bpf_kfunc_check_set_sched_cls)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
 BTF_ID_FLAGS(func, bpf_skb_set_hwtstamp)
+BTF_ID_FLAGS(func, bpf_skb_scrub_tx_tstamp)
+BTF_ID_FLAGS(func, bpf_skb_complete_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sched_cls)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
-- 
2.54.0.1136.gdb2ca164c4-goog

