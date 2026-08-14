Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428743990A
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695274; cv=none; b=dYujiEJsFIjPRZVzjpBVKdEuIE4PUx+TphmOYuSPzuFX9fZnRDedLSRkKIA602jyQ7ULEjO59YsnMytKQkdH6wFFD1+oU3EJlortAGLqbt22j7854EFGMBXPt2KeU+8zZ6Vg7TTCc1uslWu75uXYyfxmNNQrTQiwU0i00kSvWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695274; c=relaxed/simple;
	bh=wWJLSuyol+Aq4xPzj6HPvyEH7H+6lfttbygrBGkw0vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eKbIv3MrbEy4hmXlZ6exF4yLJl3nu2x0FH/1/9VxBrxkpZmk3nKY6iN8YftVbMHbumBsGqDEgn2+A/8QmIp8WrN/3Zsdmg4DClsKNll2HhyrzvhRb9MbDz6X3ZydJvT9yGK+qxwLjYsKZL5gpU11CppzMZOr8UITcsQhvNpfgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cMw+xLz8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cMw+xLz8"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c20363107f4so82037466b.2
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695262; x=1787300062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=le38amcpgaakrs8GCAo8mgslxCeXno1G2+YL/DPAXik=;
        b=cMw+xLz8M1vPnuw5y2SeLDZs3cvBUgt+Wo6DMdi9d2Uut0WMGugbJrCM0nAR5Kgjjx
         EHgxGB1U0ZCJRv9N6iUFiCymt9F0ps0jba+HI9F0BAeaavcCcc5JPlAzP818PdvhuJUd
         tTi2Qec+lFpTBWlb0GLiQ+w0eDGUyN4bF6psdnkHidXUrZqYOUsQMgqVrBrVL645VOLU
         vzQ2DZAHh4XFmTPMb7Jc5Z0xQLWcNl4HdEXF9s9asLhSApJpZ1lIsvgdR/GANTpfiUXV
         CSk0HX07cym8xpid3SVlYZtUye51vzBHZG+1C8HMq1F1+ZrjR84bMax1Uwculs3Mml9g
         hpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695262; x=1787300062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=le38amcpgaakrs8GCAo8mgslxCeXno1G2+YL/DPAXik=;
        b=Dxrz+8KegDqx5Kw5QwYuGI6YQMo4xdfyknS1vTzZEv/GNUbOQAad33JMuAcyr1V8dP
         dbPlU6OETWx99pRj0q9ObRfVI/OLqk3DPi0TmTIECMDPDypVCPLSjak1hsxM5psIG8AK
         Cmdfe2aLQViIlfIXPmPyKDwa2XU+vh23RaW/+EaNLcVgXCJLd/sn3wShZj5bGO3kV9YH
         V+gtQfUV6nP89NMEXHrXbwY+BFAQlF9H5id/k52Re5X29CKRP3D+fkQMGR4q2KrUthyS
         qjFG1nK0qS99+e2Ud1MuzcYJHhCpbFP7EnjPZt4x8uXvzP8E5/H9MOEd89BAXcSgunbY
         rJDQ==
X-Gm-Message-State: AOJu0Yw2Hyr1JkVrafQsfkOJOpohcEFttyMRrOysgVcEwuMnZuoZzf6X
	ncb3MAsHw5nO697y8glp6qnH6rFrcxkPwPZI57g4VhDjDBxZXtCR/a2tR8hvigtpla0=
X-Gm-Gg: AR+sD11qU7msuBjXY0oSMUa9IAFRFuaCQEUL+iIpDiuqP9odSYqB2WSG8eoYJ6G8Wqb
	PmIOD2q6RVXe6okG0ND0vsOFl1hCqLtMJ1Bfk0dDbcToVBlNa0kaxzMF9Ch3UPaHlugBe0RBmRV
	VRNRCXlXWY/AfDmi4PlhTF6FWaaLA4GdN96kDUZ3MVtQx0YANJi10njPm5twjbs187/aOb7LXNw
	4yW8MetcCuwZITWjAIg32TF4bKGDiIaPawkt0CzwbU5cQ6fbpw5H8uydcS2qDxsWj5ueQ4/RVJr
	uPImF+y3QBUqvUcB9yU6igPsEsMj11eqyR7z1zL3TKP5pqNtVggtMMnySrdXI1ItkApe++fdiNZ
	kjG6/DqLYm2KaiyDQEjDniWL7+Qy28lzqaOAjpj7cZ24wX8Ju7l2l5PGezd9j2I4XeHqekH6Dtf
	hfUyaaOe6b5Fjg7VBuKUf/tPrvVWcQ8yjUBD9KVFOBMsoZSHBi4+AbyEMmvWh8A59iVlCJzJvAJ
	te+TKCC7Z7rqp7NlUFT13dyl8z20PozK4EtUw==
X-Received: by 2002:a17:906:7953:b0:c05:b9db:68cc with SMTP id a640c23a62f3a-c2129914be2mr189000666b.0.1786695262422;
        Fri, 14 Aug 2026 01:14:22 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c212378da3esm78615966b.37.2026.08.14.01.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:21 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:02 +0200
Subject: [PATCH net-next 01/14] bpf: Introduce per-packet metadata storage
 for BPF programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-1-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
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
 include/linux/filter.h   |  26 +++++++++
 include/linux/skbuff.h   |   3 ++
 include/uapi/linux/bpf.h |   5 ++
 kernel/bpf/helpers.c     |   7 +++
 kernel/bpf/log.c         |   2 +
 kernel/bpf/verifier.c    |  10 +++-
 net/Kconfig              |  20 +++++++
 net/core/filter.c        | 135 +++++++++++++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c        |   3 ++
 10 files changed, 220 insertions(+), 1 deletion(-)

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
index 14acb2455746..6a2955487504 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1914,4 +1914,30 @@ static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
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
index 22eda1d54a0e..a4f88107c2d5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5031,6 +5031,9 @@ enum skb_ext_id {
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
index c18f1e16edee..aa28cc6a75f7 100644
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
index 7aa47342dc65..1fab69fec478 100644
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
@@ -11036,6 +11037,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_from_skb_meta,
 	KF_bpf_xdp_pull_data,
+	KF_bpf_dynptr_from_skb_ext,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
@@ -11116,6 +11118,11 @@ BTF_ID_UNUSED
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
@@ -12219,7 +12226,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
index 11bb0d236822..a9a164738389 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12259,6 +12259,48 @@ int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
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
@@ -12276,6 +12318,71 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 	return 0;
 }
 
+#ifdef CONFIG_BPF_SKB_EXT
+/**
+ * bpf_dynptr_from_skb_ext() - Initialize a dynptr to the skb_ext BPF area.
+ * @skb_: socket buffer to attach the extension to
+ * @size: dynptr size in bytes, 0 for maximum (CONFIG_BPF_SKB_EXT_SIZE)
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
@@ -12576,6 +12683,12 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
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
@@ -12603,6 +12716,13 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_skb_meta = {
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
@@ -12640,6 +12760,21 @@ static int __init bpf_kfunc_init(void)
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
index c82a1472a5ea..9947d2ed6635 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5155,6 +5155,9 @@ static const u8 skb_ext_type_len[] = {
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

