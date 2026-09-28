Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1AE4AB3BA
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595630; cv=none; b=MCqWNz2AXeXg6qJPEGPCNMEH9kPUZ3OanNZNdkhBxhYWIKfmfJVyhztbk1pol9N5fXdy0yVca8bPQHKmaqLFtHnX1zbdEl0wsV+nY/gM12S8bwoBF2OHxRcMAoYoxT+muhuBObba39IWu/9wXJEZCvMRAZ7YJNKYFABvoc6LMp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595630; c=relaxed/simple;
	bh=TQO/YDKaAKByOrZ287fzmO0yzMZMEuL0VZqkVGjjWcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=meI0vf/jn+psDErCNOjSAiAOTmuL4xz+yN7br7Ugo+RpOrA58szwlMEydw7MfMA+XsqBDrHgxhGe+5iTu7WoNa5CNwYpzd9qUU8nBaVemOC1/s7DHEY6wiwLDUOFqe+v00x+QiTPr27F6K8DfMLE4E7hcBdgRNO2mLPflCEPk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VGQvqOfp; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VGQvqOfp"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2cd04e72f6so250433066b.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595625; x=1791200425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dR4bZ550YwPJBeY8+XdIVkLXaQjeXYLJu9gw3Uy0mho=;
        b=VGQvqOfpbuKwjrT+4zpOn3DZbFPiEVXLPJwuxOMKEzoTAtvIol6A+6/a0kwHfkWTEO
         twI4jjfY7MKMHPsIbjkgT19Hyxb1zsFveh/ZZCZUwfHRS/GVLYADENuabz/F0SG9EyH+
         ySLJSy6PhPGJCi1c6V73/yOpnrzQmVOHqYy7TwIWF72/03076ONrbbUY+ll4WWVBG6xb
         IMIgHaK5tTvU4Q+eyQfEoJMU2/l/KynvYqNiPuCSi1TsXbnXQv3tq8js4Wu7SiQM5tfF
         fpcjV+HsQNLj8B4r2LKu0qPTn74zYq5ZVHeQOfL2EQwySUyARqWdWLY7Sbd8lwq+4ZiQ
         Ucpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595625; x=1791200425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dR4bZ550YwPJBeY8+XdIVkLXaQjeXYLJu9gw3Uy0mho=;
        b=m8FEAX+5CMGgYWddngA8/KiVwo82NN+szbI5IW+qq6cUYgkCxK9Y4ydjvGAqyskNib
         srtcdAochdM0ePJHq8ArEcFajCEOP6KJJqHJsBWWVkhtrnuB0/3nsyHpIxB613uQDdFj
         bnKociwzeAXd3DwW8O8ZFScoFrj+lDAKN+gskxG6s/E/oc38rEc6ibtVetFKk6HtwO18
         RaP/pql+NWE/qLQTaKwwzz+NwYiTDJQkSTirCcvIqKphrfZY/jIZ96/8g4YyNCSqYCfY
         FjMpIL0OYtGKCJtcRz9aimci1bDsK7HWSoygTaAt+7/S3xVHqcecMHo1gYsR83BdD8Z7
         qDhA==
X-Gm-Message-State: AFuF++nNZ/LKtPjRh2Ow91oSZp45dZWsqt0wjeW5uezeaZaXVCivPdJR
	4q8zyhIGNj8q8UDkip0ZhvA+EdCgFuNYjUxuU7G0UKk1cdlNRFW57zUsjsY801sa2ZA=
X-Gm-Gg: AYBFou3TiJCiq9lpzcQXurB3KBqF0wgOnMqaGnagBWkorsUennNTAUZVSsH8Q5yrCBw
	EO6KdaxgrURwov7AElw9kw/kfFTSfofvCckTLOMJRDUNZp6HlO9f00TGpaKNz5mPYdYeTVp7pZY
	jE9qpb7mPcNvS9cQ6yS4W9Q3ZLcntT8Y2nc27/WUjlICNLZc9nw/AnOHIRv9rXtAsLQtlY8o3ea
	t71XkmTTrXYC2MB2+Jbba01L356426rquTtl2xHyDXsbCaM1MnNv+BLZtPze1AzeNonpUrnf7YJ
	HZOJTcPmoqA8De4tD4UW1nPdV3NjyaeYfh38RonCm1G1ZgQgv7gRDiEO2QRnkGBh4vXgrPY6g6d
	G9jYICdCRrt94GmabBquMWkqrviJAhQp/fYUGb/NOSEmRilc9I/pLglHpszvdISENTlKCdb7t1l
	PE8iELxG/WbUrTY8oEI6H1NierwnuGwFwiImXijnRrSQZ+RCJqpXcYQo8s7pSxjrjbNxTxXZ0aY
	swGh7V1OHTZe89HWxRuX/Qb5coEE2MIk8cL08Lxyf2B5rSfUvRFH6UUPfdGOTLXKdpPaLx5xCW7
	15k3n8dwkjhfjYf7oM1Wnvg=
X-Received: by 2002:a17:907:c789:b0:c21:757:1bb4 with SMTP id a640c23a62f3a-c2ac23c4dfamr1009215266b.16.1790595625194;
        Mon, 28 Sep 2026 04:40:25 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae780e291sm447493566b.57.2026.09.28.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:18 +0200
Subject: [PATCH net-next 01/15] bpf: Add gated tracepoints for skb
 life-cycle
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-1-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: b4 0.16.0

BPF programs attached at different points in the network stack have no way
to pass data between each other on a per-packet basis. xdp/skb->data_meta
works for XDP-to-TC handoff, but is not available to programs running at
later hooks like cgroup/skb, sock_ops, socket filters, tracing or LSM.

Enable programs to keep per-packet metadata in a shared BPF map keyed by
the skb address. What rides on the packet is only a marker: a new
skb->traced flag, occupying the spare bit after csum_valid, which makes the
packet's lifetime events observable. The flag lives in the sk_buff itself,
not in the extension block, so it adds no memory pressure and naturally
survives packet scrubbing (tunnel encap/decap, cross-netns forwarding).

The flag makes the packet emit gated tracepoints, which fire only while the
flag is armed, driving the lifecycle of the map-backed metadata stash:

1. skb_free fires when the skb is freed, so the program can reap the stash
   entry. It carries the skb address, the free location, and the drop
   reason (mirroring kfree_skb). It is emitted from:

   - the kfree_skb and consume_skb tracepoint call sites, and
   - skb_release_head_state() to cover TCP RX delivery, queue purges, head
     theft in TCP coalesce/collapse,
   - napi_skb_free_stolen_head() and napi_reuse_skb() to cover skb stealing
     and recycling by GRO.

2. skb_copy fires when a copy or clone of a traced skb is created, so the
   program can propagate the entry. The flag is not inherited by the copy:
   __copy_skb_header() fires the tracepoint after the headers memcpy, which
   would otherwise silently carry the flag over, and the hook clears it
   again before handing the copy to the program, so the tracepoint program
   decides whether to tag the copy with bpf_trace_skb() as well.

The flag is armed by calling bpf_trace_skb(). It must be called from a hook
that owns the skb - the flag is updated without locking.

Guard the feature behind a new CONFIG_SKB_GATED_TRACEPOINTS option.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h     | 38 ++++++++++++++++++++
 include/trace/events/skb.h | 57 ++++++++++++++++++++++++++++++
 net/Kconfig                |  9 +++++
 net/core/dev.c             |  1 +
 net/core/filter.c          | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 net/core/gro.c             |  1 +
 net/core/skbuff.c          | 25 +++++++++++++
 7 files changed, 218 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 84308498a3a8..0353df4a4637 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -842,6 +842,7 @@ enum skb_tstamp_type {
  *	@encapsulation: indicates the inner headers in the skbuff are valid
  *	@encap_hdr_csum: software checksum is needed
  *	@csum_valid: checksum is already valid
+ *	@traced: tagged for gated life-cycle tracepoints
  *	@csum_not_inet: use CRC32c to resolve CHECKSUM_PARTIAL
  *	@csum_complete_sw: checksum was completed by software
  *	@csum_level: indicates the number of consecutive checksums found in
@@ -1002,6 +1003,9 @@ struct sk_buff {
 	__u8			encapsulation:1;
 	__u8			encap_hdr_csum:1;
 	__u8			csum_valid:1;
+#ifdef CONFIG_SKB_GATED_TRACEPOINTS
+	__u8			traced:1;
+#endif
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	__u8			ndisc_nodetype:2;
 #endif
@@ -5075,6 +5079,38 @@ void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_put(struct skb_ext *ext);
 
+#ifdef CONFIG_SKB_GATED_TRACEPOINTS
+
+void __skb_trace_free(struct sk_buff *skb, enum skb_drop_reason reason,
+		      void *location);
+void __skb_trace_copy(struct sk_buff *dst, const struct sk_buff *src);
+
+static __always_inline void skb_maybe_trace_free(struct sk_buff *skb,
+						 enum skb_drop_reason reason)
+{
+	if (skb->traced) {
+		__skb_trace_free(skb, reason, __builtin_return_address(0));
+		skb->traced = 0;
+	}
+}
+
+static __always_inline void skb_maybe_trace_copy(struct sk_buff *dst,
+						 const struct sk_buff *src)
+{
+	if (src->traced) {
+		dst->traced = 0;
+		__skb_trace_copy(dst, src);
+	}
+}
+
+#else
+
+static inline void skb_maybe_trace_free(struct sk_buff *skb,
+					enum skb_drop_reason reason) {}
+static inline void skb_maybe_trace_copy(struct sk_buff *dst, const struct sk_buff *src) {}
+
+#endif /* CONFIG_SKB_GATED_TRACEPOINTS */
+
 static inline void skb_ext_put(struct sk_buff *skb)
 {
 	if (skb->active_extensions)
@@ -5147,6 +5183,8 @@ static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
 static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
 static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
 static inline bool skb_has_extensions(struct sk_buff *skb) { return false; }
+static inline void skb_maybe_trace_free(struct sk_buff *skb,
+					enum skb_drop_reason reason) {}
 #endif /* CONFIG_SKB_EXTENSIONS */
 
 static inline void nf_reset_ct(struct sk_buff *skb)
diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 2945aa7fe9a7..b162a8f23f26 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -92,6 +92,63 @@ TRACE_EVENT(skb_copy_datagram_iovec,
 	TP_printk("skbaddr=%p len=%d", __entry->skbaddr, __entry->len)
 );
 
+#ifdef CONFIG_SKB_GATED_TRACEPOINTS
+
+#undef FN
+#undef FNe
+#define FN(reason)	{ SKB_DROP_REASON_##reason, #reason },
+#define FNe(reason)	{ SKB_DROP_REASON_##reason, #reason }
+
+TRACE_EVENT(skb_free,
+
+	    TP_PROTO(struct sk_buff *skb, enum skb_drop_reason reason,
+		     void *location),
+
+	    TP_ARGS(skb, reason, location),
+
+	    TP_STRUCT__entry(
+		    __field(	void *,		skbaddr)
+		    __field(	enum skb_drop_reason,	reason)
+		    __field(	void *,		location)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->skbaddr = skb;
+		    __entry->reason = reason;
+		    __entry->location = location;
+		    ),
+
+	    TP_printk("skbaddr=%p reason=%s location=%pS",
+		      __entry->skbaddr,
+		      __print_symbolic(__entry->reason,
+				       DEFINE_DROP_REASON(FN, FNe)),
+		      __entry->location)
+	);
+
+#undef FN
+#undef FNe
+
+TRACE_EVENT(skb_copy,
+
+	    TP_PROTO(struct sk_buff *dst, const struct sk_buff *src),
+
+	    TP_ARGS(dst, src),
+
+	    TP_STRUCT__entry(
+		    __field(	void *,	dst)
+		    __field(	const void *,	src)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->dst = dst;
+		    __entry->src = src;
+		    ),
+
+	    TP_printk("dst=%p src=%p", __entry->dst, __entry->src)
+	);
+
+#endif /* CONFIG_SKB_GATED_TRACEPOINTS */
+
 #endif /* _TRACE_SKB_H */
 
 /* This part must be outside protection */
diff --git a/net/Kconfig b/net/Kconfig
index 76ab44aa439a..c2e57198862c 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -539,4 +539,13 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config SKB_GATED_TRACEPOINTS
+	bool "gated skb life-cycle tracepoints"
+	depends on BPF_SYSCALL
+	help
+	  Enable the gated skb life-cycle tracepoints (skb_free, skb_copy).
+	  The tracepoints fire only for packets tagged with bpf_trace_skb(),
+	  which arms a flag on the skb, allowing BPF programs to pass
+	  per-packet state across the network stack.
+
 endif   # if NET
diff --git a/net/core/dev.c b/net/core/dev.c
index f660fccfc0db..6a4c1d8b8f2f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5863,6 +5863,7 @@ static __latent_entropy void net_tx_action(void)
 			else
 				trace_kfree_skb(skb, net_tx_action,
 						get_kfree_skb_cb(skb)->reason, NULL);
+			skb_maybe_trace_free(skb, get_kfree_skb_cb(skb)->reason);
 
 			if (skb->fclone != SKB_FCLONE_UNAVAILABLE)
 				__kfree_skb(skb);
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..33c1ee3b966b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12426,6 +12426,51 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 	return 0;
 }
 
+#ifdef CONFIG_SKB_GATED_TRACEPOINTS
+/**
+ * bpf_trace_skb() - Opt an skb into gated lifetime tracepoints
+ * @skb_: socket buffer to tag
+ * @flags__k: future use, must be zero
+ *
+ * Tag the skb as traced so that the gated tracepoints fire for it: skb_free
+ * when the skb is freed or stolen, and skb_copy when a copy or clone of the skb
+ * is created. Programs can use this to drive the life-cycle of per-packet
+ * metadata kept in a BPF map keyed by the skb address - reaping the entry on
+ * skb_free and propagating it on skb_copy. skb_free carries the drop reason,
+ * mirroring kfree_skb. The tracepoint program decides whether the copy is also
+ * traced; the tag is not inherited.
+ *
+ * The caller must own the skb because the traced flag is updated without
+ * locking.
+ *
+ * Return:
+ * * %0         - skb tagged or already tagged
+ * * %-EINVAL   - nonzero flags
+ */
+__bpf_kfunc int bpf_trace_skb(struct sk_buff *skb, u64 flags__k)
+{
+	if (flags__k)
+		return -EINVAL;
+
+	if (!skb->traced)
+		skb->traced = 1;
+
+	return 0;
+}
+
+/**
+ * bpf_skb_is_traced() - Check whether an skb is tagged
+ * @skb_: socket buffer to query
+ *
+ * Return: true if the skb was tagged with bpf_trace_skb().
+ */
+__bpf_kfunc bool bpf_skb_is_traced(struct sk_buff *skb)
+{
+	return skb->traced;
+}
+
+#endif /* CONFIG_SKB_GATED_TRACEPOINTS */
+
 /**
  * bpf_dynptr_from_skb_meta() - Initialize a dynptr to the skb metadata area.
  * @skb_: socket buffer carrying the metadata
@@ -12807,6 +12852,13 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 
+#ifdef CONFIG_SKB_GATED_TRACEPOINTS
+BTF_KFUNCS_START(bpf_kfunc_check_set_skb_tracepoints)
+BTF_ID_FLAGS(func, bpf_trace_skb)
+BTF_ID_FLAGS(func, bpf_skb_is_traced)
+BTF_KFUNCS_END(bpf_kfunc_check_set_skb_tracepoints)
+#endif
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_ID_FLAGS(func, bpf_xdp_pull_data)
@@ -12838,6 +12890,13 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_skb_meta = {
 	.set = &bpf_kfunc_check_set_skb_meta,
 };
 
+#ifdef CONFIG_SKB_GATED_TRACEPOINTS
+static const struct btf_kfunc_id_set bpf_kfunc_set_skb_tracepoints = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_skb_tracepoints,
+};
+#endif
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_xdp,
@@ -12880,6 +12939,34 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_meta);
+#ifdef CONFIG_SKB_GATED_TRACEPOINTS
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SK_SKB,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCKET_FILTER,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_OUT,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_IN,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					       &bpf_kfunc_set_skb_tracepoints);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					       &bpf_kfunc_set_skb_tracepoints);
+#endif
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
diff --git a/net/core/gro.c b/net/core/gro.c
index 29b4d02bf519..51cd0b6040af 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -683,6 +683,7 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 		nf_reset_ct(skb);
 		skb->slow_gro = 0;
 	}
+	skb_maybe_trace_free(skb, SKB_CONSUMED);
 
 	napi->skb = skb;
 }
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8912a66cd909..038854c83701 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1187,6 +1187,7 @@ void skb_release_head_state(struct sk_buff *skb)
 	}
 	nf_reset_ct(skb);
 	skb_ext_reset(skb);
+	skb_maybe_trace_free(skb, SKB_DROP_REASON_NOT_SPECIFIED);
 }
 
 /* Free everything but the sk_buff shell. */
@@ -1229,6 +1230,7 @@ bool __sk_skb_reason_drop(const struct sock *sk, struct sk_buff *skb,
 		trace_consume_skb(skb, __builtin_return_address(0));
 	else
 		trace_kfree_skb(skb, __builtin_return_address(0), reason, sk);
+	skb_maybe_trace_free(skb, reason);
 	return true;
 }
 
@@ -1445,6 +1447,7 @@ void consume_skb(struct sk_buff *skb)
 		return;
 
 	trace_consume_skb(skb, __builtin_return_address(0));
+	skb_maybe_trace_free(skb, SKB_CONSUMED);
 	__kfree_skb(skb);
 }
 EXPORT_SYMBOL(consume_skb);
@@ -1460,6 +1463,7 @@ EXPORT_SYMBOL(consume_skb);
 void __consume_stateless_skb(struct sk_buff *skb)
 {
 	trace_consume_skb(skb, __builtin_return_address(0));
+	skb_maybe_trace_free(skb, SKB_CONSUMED);
 	skb_release_data(skb, SKB_CONSUMED);
 	kfree_skbmem(skb);
 }
@@ -1504,6 +1508,7 @@ void napi_skb_free_stolen_head(struct sk_buff *skb)
 		skb_orphan(skb);
 		skb->slow_gro = 0;
 	}
+	skb_maybe_trace_free(skb, SKB_CONSUMED);
 	napi_skb_cache_put(skb);
 }
 
@@ -1539,6 +1544,7 @@ void napi_consume_skb(struct sk_buff *skb, int budget)
 
 	/* if reaching here SKB is ready to free */
 	trace_consume_skb(skb, __builtin_return_address(0));
+	skb_maybe_trace_free(skb, SKB_CONSUMED);
 
 	/* if SKB is a clone, don't handle this case */
 	if (skb->fclone != SKB_FCLONE_UNAVAILABLE) {
@@ -1601,6 +1607,7 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 	CHECK_SKB_FIELD(tc_index);
 #endif
 
+	skb_maybe_trace_copy(new, old);
 }
 
 /*
@@ -7342,6 +7349,24 @@ void __skb_ext_put(struct skb_ext *ext)
 	kmem_cache_free(skbuff_ext_cache, ext);
 }
 EXPORT_SYMBOL(__skb_ext_put);
+
+#ifdef CONFIG_SKB_GATED_TRACEPOINTS
+
+void __skb_trace_free(struct sk_buff *skb, enum skb_drop_reason reason,
+		      void *location)
+{
+	trace_skb_free(skb, reason, location);
+}
+EXPORT_SYMBOL(__skb_trace_free);
+
+void __skb_trace_copy(struct sk_buff *dst, const struct sk_buff *src)
+{
+	trace_skb_copy(dst, src);
+}
+EXPORT_SYMBOL(__skb_trace_copy);
+
+#endif
+
 #endif /* CONFIG_SKB_EXTENSIONS */
 
 static void kfree_skb_napi_cache(struct sk_buff *skb)

-- 
2.43.0

