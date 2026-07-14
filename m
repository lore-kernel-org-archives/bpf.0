Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78F32ABCD
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051343; cv=none; b=DvK4ILtlT3tmnVbmNG5eQwwxWQUduWhdfl1H0dAo1nM20nsPWk3RmIThtQ35YNMIbtlP7EXXhq0qIKoc//if0PiAR2mzwelspFKhtv5AP53WprQ08u4qIYl31oDd+jvG+E3EwzgvAAoTt7A9HjBuMo5usc9VqFW84O80fShLj/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051343; c=relaxed/simple;
	bh=NBQVXSq3ge4WZet+B04CqVO4ytC9gfgJNC6960m+9qU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAj0mKxIgAeRaSoaG6P5ZU6w3Sh1NgaOVpAs3+wgpDa1a+z3pUW4WrhzZ/nDte5Dj8ieGFJYS3pXTR8Y3+OSPuqF1ECbpX6g7QelXMBCMqBQ/UjdZNjtFPs9O0aGcfCIejPDzUtgxe7BiXt/kqS0HonQD/fNP7p/d6QGzOF6RuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IlY91g8S; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IlY91g8S"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so8905295e9.1
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784051308; x=1784656108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3OO4fRTO9gQL70tJpmoG4ro+TvWS4qVkzydSltM5rnQ=;
        b=IlY91g8SakW2Bg0OA86WEOixO4uBFa/4853IqDiXElEVVKKlx0KrhxfjwrqeGgGURD
         c0ZPrn8FcdsAFk+sszepxMlgBptnMR00p3GVb9Ji5fIWCHCIknqnJyx2u9NalAsQnmdH
         ksaEujIX5DIIv7XW4xcKWiWKquhlOHZRP+4g63yBv26xuMSWPNh9IJFhDaQ6OqYWvdgK
         FS/cRrJf1Wps3iY5Rk9JtpS0baRXwcjg2M0jJSuHaPcv98ZyIseBozPTlE6pNBeZENa/
         8OPp9MCP2MY4x5eT1a2b9r7wqYsFHn/7158UPcwhruoxxqwVpQuO3AhjTFUFt3DOLp7d
         8ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051308; x=1784656108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3OO4fRTO9gQL70tJpmoG4ro+TvWS4qVkzydSltM5rnQ=;
        b=NXKXEI30xw5wqFjexbWeOcU5Rnb9K8lPZC8zQhrW2QinXdgrOjFypj69Yn/Nuvchcs
         ICqtw0quwsFtlHOPReERLpZ1PFRAEe7yQ1pKc+mF/9xzgha4VcA4admQ1LIk4OgkoXj8
         Roxm2hRD9xh9iidfAuk7iLDx+cen6lX0Z0WiNnOYPFWcgYfx+QTV9AlO9ah/Sz6aoXaA
         7pwAILJvelCXkxXahoU2mV9y4Fc0/K0UgFVirr3S+pxoPed3S9Row2iBQQnZZN71BgQT
         jxSdkqT83iPkNdD93ewtaVOcMMPOVIs0HAnHnZQ+GS24Qgngq/Ot0c6qNQ3rWpJvAKRf
         Peuw==
X-Gm-Message-State: AOJu0YzxQOFXMfLSKV/Kct30cWbFrdcgK6NZQjFcW2zGbb1BDqk9XsyR
	x0JFeooOT7NNl1GNZnFdxgcSSueidJup/kRCPl8b8aUFH11cWWZ+0+49aHH7s9ORYYA=
X-Gm-Gg: AfdE7cnCNeln4bPqrp1qK4bpovGzyqh/Cv/3GsfPEBu4OIclGBfb+YLxYl7V5d6wGvC
	D90XNHK+JwVBVsbcDn7OE2By1hANnBcUtXPfGDTN17ebr6X7Uy0sNhLiddMCy6WMn9g21wCS+8g
	7OXeqQVQUj0SAyvdeGjks4Eeumjmm9COzBEcHF18iO0lrTzMWropm8Bus/aH8ipyV910zQjX0i3
	XRGGLkcvL/JX130oMa4aay4RJahP127lKv7R+F6KIz2WGmGIivGN1TfYuXGqGC6JM6whLdO5b7P
	6O9qoBZ3NQ5lrAF4O77W8/ScEKm4BaAwQF4P+cfgYeaRlh+9tj6kjT6648SaySCGGD6jdtO1GA5
	zXeniG/srhOZIyOmi04Am0Aw0jY2sx0F++Z1DivqHkk5jjsWetzzu4ggxw5hE7JEvtJJp8/drK3
	3S5e0vfkizkcbbWMA+kmf7hwRi6m0BQ3G9uamZBk/Nfs9p2Gg=
X-Received: by 2002:a05:600c:8011:b0:493:c0ec:9a5f with SMTP id 5b1f17b1804b1-493f8818045mr151168605e9.19.1784051308064;
        Tue, 14 Jul 2026 10:48:28 -0700 (PDT)
Received: from cloudflare.com (93-57-92-86.ip163.fastwebnet.it. [93.57.92.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e036sm11236056f8f.5.2026.07.14.10.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:48:27 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 14 Jul 2026 19:48:20 +0200
Subject: [PATCH RFC net-next 1/6] bpf: Introduce per-packet metadata
 storage for BPF programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bpf-meta-inside-skb-ext-v1-1-5871c07a8dd6@cloudflare.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2

BPF programs attached at different points in the network stack have no way
to pass data between each other on a per-packet basis, other than by
stashing it into a shared BPF map. xdp/skb->data_meta works for XDP-to-TC
handoff, but is not available to programs running at later hooks like
cgroup/skb, sock_ops, socket filters, tracing or LSM.

Add a new skb extension (struct bpf_skb_ext) that provides up to 256 bytes
of per-packet storage. Size is configurable at build time though the
CONFIG_BPF_SKB_EXT_SIZE option. The storage is embedded inside the
extension chunk itself.

Expose the storage to BPF programs via bpf_dynptr_from_skb_ext() kfunc.
The caller passes BPF_SKB_EXT_F_CREATE to allocate or COW (unshare) the
extension and get a read-write dynptr. Without the flag, it gets a
read-only dynptr to the existing extension, or -ENOENT if none exists.

Guard the feature behind a new CONFIG_BPF_SKB_EXT option.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h      |  10 ++++
 include/linux/filter.h   |  26 ++++++++++
 include/linux/skbuff.h   |   3 ++
 include/uapi/linux/bpf.h |   5 ++
 kernel/bpf/helpers.c     |   7 +++
 kernel/bpf/log.c         |   2 +
 kernel/bpf/verifier.c    |  10 +++-
 net/Kconfig              |  20 ++++++++
 net/core/filter.c        | 129 +++++++++++++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c        |   3 ++
 10 files changed, 214 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..6b918a5b61bf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1484,6 +1484,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_SKB_META,
 	/* Underlying data is a file */
 	BPF_DYNPTR_TYPE_FILE,
+	/* Underlying data is a bpf_skb_ext chunk */
+	BPF_DYNPTR_TYPE_SKB_EXT,
 };
 
 int bpf_dynptr_check_size(u64 size);
@@ -4209,4 +4211,12 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
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
index 67d337ede91b..839e56708594 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1903,4 +1903,30 @@ static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
 }
 #endif /* CONFIG_NET */
 
+#ifdef CONFIG_BPF_SKB_EXT
+void *bpf_skb_ext_pointer(struct sk_buff *skb, u32 offset);
+int __bpf_skb_ext_load_bytes(const struct sk_buff *skb, u32 offset, void *to,
+			     u32 len);
+int __bpf_skb_ext_store_bytes(struct sk_buff *skb, u32 offset, const void *from,
+			      u32 len, u64 flags);
+#else /* CONFIG_BPF_SKB_EXT */
+static inline void *bpf_skb_ext_pointer(struct sk_buff *skb, u32 offset)
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
index 115db8c44db2..584d8440d352 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5033,6 +5033,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_CAN)
 	SKB_EXT_CAN,
+#endif
+#if IS_ENABLED(CONFIG_BPF_SKB_EXT)
+	SKB_EXT_BPF,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 89b36de5fdbb..3eee4467422d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7732,4 +7732,9 @@ struct bpf_insn_array_value {
 	__u32 :32;
 };
 
+/* Flags to control bpf_dynptr_from_skb_ext() behavior. */
+enum {
+	BPF_SKB_EXT_F_CREATE = (1ULL << 0),
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8e196c9b7c50..c7a823586225 100644
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
@@ -3087,6 +3092,8 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
 		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset);
+	case BPF_DYNPTR_TYPE_SKB_EXT:
+		return bpf_skb_ext_pointer(ptr->data, ptr->offset + offset);
 	case BPF_DYNPTR_TYPE_FILE:
 		err = bpf_file_fetch_bytes(ptr->data, offset, buffer__nullable, buffer__szk);
 		return err ? NULL : buffer__nullable;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index b740fa73ee26..d66e154649e0 100644
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
index 2abc79dbf281..a78ef1e37f24 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -635,6 +635,7 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 	case BPF_DYNPTR_TYPE_XDP:
 		return DYNPTR_TYPE_XDP;
 	case BPF_DYNPTR_TYPE_SKB_META:
+	case BPF_DYNPTR_TYPE_SKB_EXT:
 		return DYNPTR_TYPE_SKB_META;
 	case BPF_DYNPTR_TYPE_FILE:
 		return DYNPTR_TYPE_FILE;
@@ -11014,6 +11015,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_from_skb_meta,
 	KF_bpf_xdp_pull_data,
+	KF_bpf_dynptr_from_skb_ext,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
@@ -11094,6 +11096,11 @@ BTF_ID_UNUSED
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
@@ -12192,7 +12199,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
-			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
+			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta] ||
+				   meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_ext]) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB_META;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
 				dynptr_arg_type |= DYNPTR_TYPE_FILE;
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
index 2e96b4b847ce..b0b039c64b02 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12254,6 +12254,48 @@ int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
 	return 0;
 }
 
+#ifdef CONFIG_BPF_SKB_EXT
+void *bpf_skb_ext_pointer(struct sk_buff *skb, u32 offset)
+{
+	struct bpf_skb_ext *ext;
+
+	ext = skb_ext_find(skb, SKB_EXT_BPF);
+	if (!ext)
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
+	memmove(ext->buf + offset, from, len);
+	return 0;
+}
+#endif /* CONFIG_BPF_SKB_EXT */
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)
@@ -12271,6 +12313,71 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 	return 0;
 }
 
+#ifdef CONFIG_BPF_SKB_EXT
+/**
+ * bpf_dynptr_from_skb_ext() - Initialize a dynptr to the skb_ext BPF area.
+ * @skb_: socket buffer to attach the extension to
+ * @size: dynptr size in bytes, 0 for maximum (BPF_SKB_EXT_SIZE_MAX)
+ * @flags: BPF_SKB_EXT_F_CREATE to create/COW (read-write), 0 to find (read-only)
+ * @ptr__uninit: dynptr to initialize
+ *
+ * Return:
+ * * %0         - dynptr ready to use
+ * * %-ENOENT   - extension not found (when not creating)
+ * * %-ENOMEM   - allocation failed
+ * * %-EINVAL   - invalid flags
+ * * %-E2BIG    - size exceeds CONFIG_BPF_SKB_EXT_SIZE
+ */
+__bpf_kfunc int bpf_dynptr_from_skb_ext(struct __sk_buff *skb_, u32 size,
+					u64 flags,
+					struct bpf_dynptr *ptr__uninit)
+{
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
+	struct sk_buff *skb = (struct sk_buff *)skb_;
+	bool create = flags & BPF_SKB_EXT_F_CREATE;
+	struct bpf_skb_ext *ext;
+	bool exists;
+	int err;
+
+	if (flags & ~BPF_SKB_EXT_F_CREATE) {
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
@@ -12571,6 +12678,12 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
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
@@ -12598,6 +12711,13 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_skb_meta = {
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
@@ -12635,6 +12755,15 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_meta);
+#ifdef CONFIG_BPF_SKB_EXT
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCKET_FILTER, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_kfunc_set_skb_ext);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb_ext);
+#endif
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9cfa..4efc06c426b2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5149,6 +5149,9 @@ static const u8 skb_ext_type_len[] = {
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

