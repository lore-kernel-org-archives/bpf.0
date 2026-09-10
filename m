Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E94A2A64
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050430; cv=none; b=gitHNqgXguEmRMThO1vIydMKPCgcFN9WIgpaxLaUd3oY+R7wszvyeJqOZzBWPv+DrWCkWmogGHkSXv016QrZ5bF6Jiiq6WrHQyV8NR10PWTH7bxXI1sR949KNrvnj+9nnLIdXCbjjHjylOoylZjI/O6RzWAgL6xXAFk0g3C4iwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050430; c=relaxed/simple;
	bh=QotrqA0nyg5H1q3cAtUrQFntTJh2mebxexsXo8j8Wzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5m6vwEEZDK+s2LvB8j+NS3d9e9NTqx6fHKkl0mrUZc0YTnCTAEt1xdKrwxGbmHQ443KSbKp5sLTp93649dQIwR2au2s5suub9DsCO2lYUD/VRcGKMbdECDCJqknTZjrULKD3bkAPvm5Ndt4bbR8BC4K1kxKzMEgI5zMfTuqMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YEDa070t; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YEDa070t"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b899413537so2340342e87.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789050424; x=1789655224; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T9d5rLLKI3FGNbnIlRqBiYY1u4XhrTNvOZ/UPbipOmA=;
        b=YEDa070thTgChsIpSkEpaxPyWDzJQodO0BEUH/DCpLz6La1cixSNSDsV00+IEHrZJp
         VOYQTQN+afvHLPVrH3oUA9B/n8k8wXx4ciDUZ2ItqRk3QU8hYalLpRIjA25dI6/FKY79
         Sxp4rYhJPylAojmYpjcsq7eUtwNM1UJeIOpkF59H9I9+DI+WlW3cq/xonk0KZNlkvsFL
         abr49cSIabM4Uun00Nk2U41gV/N9ht/0pXl1RrzqYea75RZSngIpJCaI4NVgG+LJKaL0
         WioQEHreNB4tNJ3UFs4TDBW3wuGeFZ5MQEZVdhD5w21yVH/pfiBqQXlDu0o0oJ9mp0be
         6lRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050424; x=1789655224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T9d5rLLKI3FGNbnIlRqBiYY1u4XhrTNvOZ/UPbipOmA=;
        b=fii9iCmxXpFkik3ktn8YNqklY13Woat+YdOLYdRxnNy+koqulMiInGY+rLx8RPY/+P
         5yWGTSRvVp7F87wMsIDUX7K++v3LFhp0QxUaOBIi3zpWsD3B3HSEWNPfZqnOHO2x5x5T
         +7/8J7qcqU/47LclCyHRASVwUgCVDMeHztIe7/R6B0jLXo5Pk1ibrOYezENF/bTobc1V
         nKMMWxhKsnBtFs6SiTCRd6BoMkp4T399pK8uqF4MtlhvlQz6du3FmCQSKZ7vek47Hb+X
         AEpOC0UaFAXM/WQiOgBNX5EJeaYapj/BTbz8GpBp9dwDP1r5E/CHFU76Pf1myQs5gW1Z
         fuSA==
X-Gm-Message-State: AFuF++loj5yKgb4uS7G8pFm0OXnHTo0Kylp3j+thiTWxM7+ME/xRaQ+j
	u66qT2C2vqW5aSbLg/dePXvern94JBnI/3wEo3PC2pTcagBxfjcs5ADK1+A5e2tVU5enLOmYEtL
	iCf5vB+g=
X-Gm-Gg: AYBFou21aV2O2gmNF63UOHKDVv79dKt8rKx+TZZfKi4/rqNMNMp0vwaMsrlH08RVuzt
	sqOeWzhx/HCkaB2eXw1UK4loLNPustePlsB0TCkOnMy1KotYsqdvMGffXcYynhGbQMabvtbyc0O
	U0T5lpQ1xUhB/d43GVhjVr83dXNp5ez7wGmPVCa9H1zyFyZBLwqVDL4Ms2KcHF/cUv8AgQ5achB
	+N1f/7ecXPnPudtLUvQ6/oSCP0V5e2HhRIdslPkeh9huqb/pS5L6S6dWcNKI3XJphh6lCFSvUoP
	I6mW/m3anOIgF8FRIDmIwStjMKbkEON0Yt9eNNykARl6qfi47LpCLGArJX26AYu1WrPmH8LTw3p
	Sj/ea1XbX0a9dpBTdi+vNQtgU4Kiyv/5DszCe4PfL6Ad+IL3e2ZSkHH62myOz9Z1duKo1XFHNUQ
	uAf3jWcfLZr1JS6gl1Us1RAaCCFisGTV2lRUzf+M1iJfxl8SkzukYmc/hiquP5zsKyqGmm1StfF
	dRi7INYcFsmrfUApv8796JqBpgV6V17AjkmoiPXdI8iy4ny
X-Received: by 2002:a17:907:3909:b0:c25:23d:5295 with SMTP id a640c23a62f3a-c29419f58bcmr328672066b.17.1789048964441;
        Thu, 10 Sep 2026 07:02:44 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260cb7a18dsm922778166b.0.2026.09.10.07.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:43 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:36 +0200
Subject: [PATCH net-next v2 01/14] bpf: Introduce per-packet metadata
 storage for BPF programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-1-0b21e42180b0@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
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
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Jack Wang <163wangjack@gmail.com>
X-Mailer: b4 0.16.0

BPF programs attached at different points in the network stack have no way
to pass data between each other on a per-packet basis, other than by
stashing it into a shared BPF map. xdp/skb->data_meta works for XDP-to-TC
handoff, but is not available to programs running at later hooks like
cgroup/skb, sock_ops, socket filters, tracing or LSM.

Add a new skb extension (struct bpf_skb_ext) that provides up to 256 bytes
of per-packet storage. Size is configurable at build time through the
CONFIG_BPF_SKB_EXT_SIZE option. The storage is embedded inside the
extension chunk itself.

Expose the storage to BPF programs via bpf_dynptr_from_skb_ext() kfunc.
The caller passes BPF_SKB_EXT_F_CREATE to allocate or COW (unshare) the
extension and get a read-write dynptr. Without the flag, it gets a
read-only dynptr to the existing extension, or -ENOENT if none exists.

Two corner cases need special handling:

First, a clone made by bpf_clone_redirect() shares the extension block, so
a write through a writable dynptr acquired beforehand would land in the
shared block and leak into the clone's copy. Refuse such writes: fail
bpf_dynptr_write() with -EBUSY and bpf_dynptr_slice_rdwr() with NULL while
the block is shared. Re-acquiring the dynptr with BPF_SKB_EXT_F_CREATE
COWs the block and restores write access. For the same reason, mark
bpf_dynptr_from_skb_ext() as packet-changing so the verifier invalidates
slices acquired from an earlier dynptr when a re-open with
BPF_SKB_EXT_F_CREATE can COW the block and leave them dangling.

Second, tracing and LSM programs can run on a shared skb concurrently on
another CPU, and bpf_dynptr_from_skb_ext() with BPF_SKB_EXT_F_CREATE would
mutate skb->extensions without synchronization. Disallow it at load time:
for these program types require the flags argument to be a known constant
without BPF_SKB_EXT_F_CREATE. Read-only access remains available.

Guard the feature behind a new CONFIG_BPF_SKB_EXT option.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h      |  10 ++++
 include/linux/filter.h   |  27 +++++++++
 include/linux/skbuff.h   |  11 ++++
 include/uapi/linux/bpf.h |   5 ++
 kernel/bpf/helpers.c     |  21 ++++++-
 kernel/bpf/log.c         |   2 +
 kernel/bpf/verifier.c    |  20 ++++++-
 net/Kconfig              |  20 +++++++
 net/core/filter.c        | 149 +++++++++++++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c        |   3 +
 10 files changed, 263 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ffa5626411ac..6c35f8c74147 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1481,6 +1481,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_SKB_META,
 	/* Underlying data is a file */
 	BPF_DYNPTR_TYPE_FILE,
+	/* Underlying data is a bpf_skb_ext chunk */
+	BPF_DYNPTR_TYPE_SKB_EXT,
 };
 
 int bpf_dynptr_check_size(u64 size);
@@ -4216,4 +4218,12 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 	return 0;
 }
 
+#ifdef CONFIG_BPF_SKB_EXT
+
+struct bpf_skb_ext {
+	u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
+};
+
+#endif /* CONFIG_BPF_SKB_EXT */
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4a9bc6a848f2..e9a93492253b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1958,4 +1958,31 @@ static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
 }
 #endif /* CONFIG_NET */
 
+#ifdef CONFIG_BPF_SKB_EXT
+void *bpf_skb_ext_pointer(struct sk_buff *skb, u32 offset, bool wr);
+int __bpf_skb_ext_load_bytes(const struct sk_buff *skb, u32 offset, void *to,
+			     u32 len);
+int __bpf_skb_ext_store_bytes(struct sk_buff *skb, u32 offset, const void *from,
+			      u32 len, u64 flags);
+#else /* CONFIG_BPF_SKB_EXT */
+static inline void *bpf_skb_ext_pointer(struct sk_buff *skb, u32 offset,
+					bool wr)
+{
+	return NULL;
+}
+
+static inline int __bpf_skb_ext_load_bytes(const struct sk_buff *skb,
+					   u32 offset, void *to, u32 len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __bpf_skb_ext_store_bytes(struct sk_buff *skb, u32 offset,
+					    const void *from, u32 len,
+					    u64 flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_BPF_SKB_EXT */
+
 #endif /* __LINUX_FILTER_H__ */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 421f6fc45451..0202bcb9338d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5061,6 +5061,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_CAN)
 	SKB_EXT_CAN,
+#endif
+#if IS_ENABLED(CONFIG_BPF_SKB_EXT)
+	SKB_EXT_BPF,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
@@ -5153,6 +5156,13 @@ static inline bool skb_has_extensions(struct sk_buff *skb)
 {
 	return unlikely(skb->active_extensions);
 }
+
+/* True if the extension block is shared with cloned skbs */
+static inline bool skb_ext_shared(const struct sk_buff *skb)
+{
+	return skb->active_extensions &&
+	       refcount_read(&skb->extensions->refcnt) != 1;
+}
 #else
 static inline void __skb_ext_put(struct skb_ext *ext) {}
 static inline void skb_ext_put(struct sk_buff *skb) {}
@@ -5161,6 +5171,7 @@ static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
 static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
 static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
 static inline bool skb_has_extensions(struct sk_buff *skb) { return false; }
+static inline bool skb_ext_shared(const struct sk_buff *skb) { return false; }
 #endif /* CONFIG_SKB_EXTENSIONS */
 
 static inline void nf_reset_ct(struct sk_buff *skb)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 732b35cc08d1..a48399afe494 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7825,4 +7825,9 @@ struct bpf_insn_array_value {
 	__u32 :32;
 };
 
+/* Flags to control bpf_dynptr_from_skb_ext() behavior. */
+enum {
+	BPF_SKB_EXT_F_CREATE = (1ULL << 0),
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..cfcb79399ed0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1926,6 +1926,8 @@ static int __bpf_dynptr_read(void *dst, u64 len, const struct bpf_dynptr_kern *s
 		return 0;
 	case BPF_DYNPTR_TYPE_FILE:
 		return bpf_file_fetch_bytes(src->data, offset, dst, len);
+	case BPF_DYNPTR_TYPE_SKB_EXT:
+		return __bpf_skb_ext_load_bytes(src->data, src->offset + offset, dst, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1985,6 +1987,8 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u64 offset, void *src,
 	case BPF_DYNPTR_TYPE_SKB_META:
 		return __bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src,
 						  len, flags);
+	case BPF_DYNPTR_TYPE_SKB_EXT:
+		return __bpf_skb_ext_store_bytes(dst->data, dst->offset + offset, src, len, flags);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -2032,6 +2036,7 @@ BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u64, offset, u6
 	case BPF_DYNPTR_TYPE_SKB:
 	case BPF_DYNPTR_TYPE_XDP:
 	case BPF_DYNPTR_TYPE_SKB_META:
+	case BPF_DYNPTR_TYPE_SKB_EXT:
 		/* skb and xdp dynptrs should use bpf_dynptr_slice / bpf_dynptr_slice_rdwr */
 		return 0;
 	default:
@@ -3048,8 +3053,8 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
  * provided buffer, with its contents containing the data, if unable to obtain
  * direct pointer)
  */
-__bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
-				   void *buffer__nullable, u64 buffer__szk)
+static void *__bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
+				void *buffer__nullable, u64 buffer__szk, bool wr)
 {
 	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 	enum bpf_dynptr_type type;
@@ -3087,6 +3092,8 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
 		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset);
+	case BPF_DYNPTR_TYPE_SKB_EXT:
+		return bpf_skb_ext_pointer(ptr->data, ptr->offset + offset, wr);
 	case BPF_DYNPTR_TYPE_FILE:
 		err = bpf_file_fetch_bytes(ptr->data, offset, buffer__nullable, buffer__szk);
 		return err ? NULL : buffer__nullable;
@@ -3096,6 +3103,13 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
 	}
 }
 
+__bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
+				   void *buffer__nullable, u64 buffer__szk)
+{
+	return __bpf_dynptr_slice(p, offset, buffer__nullable, buffer__szk,
+				  false);
+}
+
 /**
  * bpf_dynptr_slice_rdwr() - Obtain a writable pointer to the dynptr data.
  * @p: The dynptr whose data slice to retrieve
@@ -3168,7 +3182,8 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u64 offset,
 	 * will be copied out into the buffer and the user will need to call
 	 * bpf_dynptr_write() to commit changes.
 	 */
-	return bpf_dynptr_slice(p, offset, buffer__nullable, buffer__szk);
+	return __bpf_dynptr_slice(p, offset, buffer__nullable, buffer__szk,
+				  true);
 }
 
 __bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr *p, u64 start, u64 end)
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 589770ca3d3a..02f9bf72ac07 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -462,6 +462,8 @@ const char *dynptr_type_str(enum bpf_dynptr_type type)
 		return "skb_meta";
 	case BPF_DYNPTR_TYPE_FILE:
 		return "file";
+	case BPF_DYNPTR_TYPE_SKB_EXT:
+		return "skb_ext";
 	case BPF_DYNPTR_TYPE_INVALID:
 		return "<invalid>";
 	default:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e421ea2b80c3..9029cb56128f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -621,6 +621,7 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 	case BPF_DYNPTR_TYPE_XDP:
 		return DYNPTR_TYPE_XDP;
 	case BPF_DYNPTR_TYPE_SKB_META:
+	case BPF_DYNPTR_TYPE_SKB_EXT:
 		return DYNPTR_TYPE_SKB_META;
 	case BPF_DYNPTR_TYPE_FILE:
 		return DYNPTR_TYPE_FILE;
@@ -11615,6 +11616,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_from_skb_meta,
 	KF_bpf_xdp_pull_data,
+	KF_bpf_dynptr_from_skb_ext,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
@@ -11692,6 +11694,11 @@ BTF_ID_UNUSED
 BTF_ID_UNUSED
 BTF_ID_UNUSED
 #endif
+#ifdef CONFIG_BPF_SKB_EXT
+BTF_ID(func, bpf_dynptr_from_skb_ext)
+#else
+BTF_ID_UNUSED
+#endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
@@ -11824,7 +11831,8 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_call_arg_meta *meta)
 
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data] ||
+	       meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_ext];
 }
 
 static int
@@ -12835,7 +12843,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
-			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta] ||
+				   meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_ext]) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB_META;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
 				dynptr_arg_type |= DYNPTR_TYPE_FILE;
@@ -13763,6 +13772,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_ext] &&
+	    (prog_type == BPF_PROG_TYPE_LSM || prog_type == BPF_PROG_TYPE_TRACING) &&
+	    (meta.arg_constant.value & BPF_SKB_EXT_F_CREATE)) {
+		verbose(env, "BPF_SKB_EXT_F_CREATE is not allowed in lsm/tracing programs\n");
+		return -EINVAL;
+	}
+
 	if (is_bpf_rbtree_add_kfunc(meta.func_id)) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_rbtree_add_callback_state);
diff --git a/net/Kconfig b/net/Kconfig
index e38477393551..6d57320dfea3 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -540,4 +540,24 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config BPF_SKB_EXT
+	bool "skb extension for BPF metadata"
+	depends on BPF_SYSCALL
+	select SKB_EXTENSIONS
+	help
+	  Enable an sk_buff extension for storing BPF metadata. This allows BPF
+	  programs to associate arbitrary data with individual packets as they
+	  traverse the network stack. The storage is automatically freed when
+	  the sk_buff is freed.
+
+config BPF_SKB_EXT_SIZE
+	int "Size of the BPF skb extension metadata buffer"
+	depends on BPF_SKB_EXT
+	range 1 256
+	default 64
+	help
+	  Configures the size of the inline metadata buffer in struct
+	  bpf_skb_ext, which is the maximum amount of data a BPF program can
+	  store or retrieve with bpf_dynptr_from_skb_ext().
+
 endif   # if NET
diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..bf754f330346 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12418,6 +12418,54 @@ int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
 	return 0;
 }
 
+#ifdef CONFIG_BPF_SKB_EXT
+void *bpf_skb_ext_pointer(struct sk_buff *skb, u32 offset, bool wr)
+{
+	struct bpf_skb_ext *ext;
+
+	ext = skb_ext_find(skb, SKB_EXT_BPF);
+	if (!ext)
+		return NULL;
+
+	if (wr && skb_ext_shared(skb))
+		return NULL;
+
+	return ext->buf + offset;
+}
+
+int __bpf_skb_ext_load_bytes(const struct sk_buff *skb, u32 offset, void *to,
+			     u32 len)
+{
+	struct bpf_skb_ext *ext;
+
+	ext = skb_ext_find(skb, SKB_EXT_BPF);
+	if (!ext)
+		return -ENOENT;
+
+	memmove(to, ext->buf + offset, len);
+	return 0;
+}
+
+int __bpf_skb_ext_store_bytes(struct sk_buff *skb, u32 offset,
+			      const void *from, u32 len, u64 flags)
+{
+	struct bpf_skb_ext *ext;
+
+	if (unlikely(flags))
+		return -EINVAL;
+
+	ext = skb_ext_find(skb, SKB_EXT_BPF);
+	if (!ext)
+		return -ENOENT;
+
+	if (skb_ext_shared(skb))
+		return -EBUSY;
+
+	memmove(ext->buf + offset, from, len);
+	return 0;
+}
+#endif /* CONFIG_BPF_SKB_EXT */
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)
@@ -12435,6 +12483,79 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 	return 0;
 }
 
+#ifdef CONFIG_BPF_SKB_EXT
+/**
+ * bpf_dynptr_from_skb_ext() - Initialize a dynptr to the skb_ext BPF area.
+ * @skb_: socket buffer to attach the extension to
+ * @size: dynptr size in bytes, 0 for maximum (CONFIG_BPF_SKB_EXT_SIZE)
+ * @flags__k: BPF_SKB_EXT_F_CREATE to create/COW (read-write), 0 to find
+ *            (read-only)
+ * @ptr__uninit: dynptr to initialize
+ *
+ * Writes to the dynptr (bpf_dynptr_write(), bpf_dynptr_slice_rdwr()) fail with
+ * %-EBUSY or NULL if the extension chunk is shared with clones, e.g. after
+ * bpf_clone_redirect(). Re-acquire the dynptr with BPF_SKB_EXT_F_CREATE to get
+ * a writable private copy.
+ *
+ * BPF_SKB_EXT_F_CREATE is not allowed in tracing and LSM programs.
+ *
+ * Return:
+ * * %0         - dynptr ready to use
+ * * %-ENOENT   - extension not found (when not creating)
+ * * %-ENOMEM   - allocation failed
+ * * %-EINVAL   - invalid flags
+ * * %-E2BIG    - size exceeds CONFIG_BPF_SKB_EXT_SIZE
+ */
+__bpf_kfunc int bpf_dynptr_from_skb_ext(struct __sk_buff *skb_, u32 size,
+					u64 flags__k,
+					struct bpf_dynptr *ptr__uninit)
+{
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
+	struct sk_buff *skb = (struct sk_buff *)skb_;
+	bool create = flags__k & BPF_SKB_EXT_F_CREATE;
+	struct bpf_skb_ext *ext;
+	bool exists;
+	int err;
+
+	if (flags__k & ~BPF_SKB_EXT_F_CREATE) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (size > ARRAY_SIZE(ext->buf)) {
+		err = -E2BIG;
+		goto error;
+	}
+	if (!size)
+		size = ARRAY_SIZE(ext->buf);
+
+	exists = skb_ext_exist(skb, SKB_EXT_BPF);
+	if (!create) {
+		if (!exists) {
+			err = -ENOENT;
+			goto error;
+		}
+		goto out;
+	}
+
+	ext = skb_ext_add(skb, SKB_EXT_BPF);
+	if (!ext) {
+		err = -ENOMEM;
+		goto error;
+	}
+	if (!exists)
+		memset(ext, 0, sizeof(*ext));
+out:
+	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_EXT, 0, size);
+	if (!create)
+		bpf_dynptr_set_rdonly(ptr);
+	return 0;
+error:
+	bpf_dynptr_set_null(ptr);
+	return err;
+}
+#endif /* CONFIG_BPF_SKB_EXT */
+
 /**
  * bpf_dynptr_from_skb_meta() - Initialize a dynptr to the skb metadata area.
  * @skb_: socket buffer carrying the metadata
@@ -12816,6 +12937,12 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 
+#ifdef CONFIG_BPF_SKB_EXT
+BTF_KFUNCS_START(bpf_kfunc_check_set_skb_ext)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb_ext)
+BTF_KFUNCS_END(bpf_kfunc_check_set_skb_ext)
+#endif
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_ID_FLAGS(func, bpf_xdp_pull_data)
@@ -12847,6 +12974,13 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_skb_meta = {
 	.set = &bpf_kfunc_check_set_skb_meta,
 };
 
+#ifdef CONFIG_BPF_SKB_EXT
+static const struct btf_kfunc_id_set bpf_kfunc_set_skb_ext = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_skb_ext,
+};
+#endif
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_xdp,
@@ -12889,6 +13023,21 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_meta);
+#ifdef CONFIG_BPF_SKB_EXT
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SK_SKB, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCKET_FILTER, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_OUT, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_IN, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb_ext);
+#endif
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab195b99c853..9c03cd7c63af 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5169,6 +5169,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_CAN)
 	[SKB_EXT_CAN] = SKB_EXT_CHUNKSIZEOF(struct can_skb_ext),
 #endif
+#if IS_ENABLED(CONFIG_BPF_SKB_EXT)
+	[SKB_EXT_BPF] = SKB_EXT_CHUNKSIZEOF(struct bpf_skb_ext),
+#endif
 };
 
 static __always_inline __no_profile unsigned int skb_ext_total_length(void)

-- 
2.43.0

