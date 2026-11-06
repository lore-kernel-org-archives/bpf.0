Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996427;
	b=tEO2sWwYVUEd3Hsv0ZrnSPeL2TCpW6ZLUuVh3jcYvwxwVW8YQzOEfOqnFaeaz4wIIfDX
	 aNlx1gEdChN7aaK1TnzteUexppY/mIdtwzsZarFDvcj1Io3YW1ktclOI0JRargs2eVsCW
	 0soGxkS2l1C1EhLzAopEpvjwtMvkq2WkWT4Tr/081DoY4c8eHJjIdsIMKpvtXOx4IYmJz
	 P30OI2qi3j9DWWONb5dMX5OQ62ic+Y1DH7YnJ3sc+Xlz5H5IY2R+xv/VjJyTY0MfgZyil
	 TX0y6dRYpnmY4rRYWmZ6OvjEfVnLcylh5nFEuyQako0WZJBfGcuVW58joQFSAGV977Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=O/OfCfxyOncz9XMEK2pGYU9OBecubSevjBgc45WNx7E=;
	b=s0M5ajA6DBiHHAHqvZ+U+tjXGpLIWyTvvkGUvhYUxYME1aakXH4ATcdVm3YBN4YqfSE2
	 oI3Bk0mMs4Bv3AshSA7lTnWzcAc9CeJtkoACm+pf/YYGo26n6699EF4z+pGD5/dlZCmrr
	 Sb3yDTwhnMjckFFv+utpf9iBpIq5EXncQZ6O6TXPFC9foUEWBUIJRJUwnly9m6F4Uqs1I
	 1uOMf9nIiyQ8X083VoR4Z5nBLHjN45H9R2YJOpZhrjtuC18WxxQpSsDw9D8DfhSwoIMhW
	 SVGYi10YKddcbNZ7kQi0uTYWPrO4WXtUB2I1yScwQZbG89Mf3TRNpCJR21+Xio029sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fXQbx54a;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEFD606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FEFD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fXQbx54a
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b09a466295so811705a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793996412; x=1794601212; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/OfCfxyOncz9XMEK2pGYU9OBecubSevjBgc45WNx7E=;
        b=fXQbx54a8EHxVxlSQqeTn9XAtrER1ec1uQpWP2TMdcg/BcI7Fe4kuzviIsDC9HMxy3
         yNvDPMrrI57PZStRemVMV2QojoPQueQhoff9tQMv2MOJxvMBgLndmYcYT7up2yoBGR9N
         nUvLxZT4rWpd0tdCwQTu/ubj0Jx28hqxgmeEA+RJ/b6kuQ1LYipJnUpERgIsgHrvL/8Q
         gMiAKOnWB8cj9tMtZXQf5LnzE57ZmTe2JyOXsaWYj+RRTpMjYG3G/nxZLd8fV1i34KdJ
         L+TXyoymDQ99Y+Gyy6DNzmJ79MqYyuI0zoVJfrj88ZxDu9rx6hA7yAL4dns+APckbKHl
         jfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996412; x=1794601212;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/OfCfxyOncz9XMEK2pGYU9OBecubSevjBgc45WNx7E=;
        b=hqgG49Ll1xy8rP28ugjXgIKu7m0Vm3syOkavED8Jn5FxQoymtyOe60xFm6XHAbPRwT
         FHXnVp3OZIVuYy0uXOQ6M06DkL3xggU0W4Ng44Aq/icp95Y1EHfGd385sntXDeyo9XGD
         4vxgr1kEPfLfxHhMsLtV0fXvGd0R5VKoKz+97i4xD1GJ5Jqu9GdwF28qUELJ3/rxUbhR
         jGEMREKobj7BrXsLDMaTI27sjzX/QD8Zorh3rxuNcPIZ2WPETf+nJfWjJtqBM8EBPLsP
         I0IaNFeRDs+hOA2uNYNw4aHZ9SNMkh1Z5bYe6i/4/7LGGKlEi6DYJejTK2Gvfu0L9iwa
         wJKg==
X-Gm-Message-State: APuU4Z9YzXXOlux7s/sffb673qpSInb2MBYQOwdOhjYgH+AUYSm0TmsW
	SX65YY+rhsyRfC7DFZT0SgcdQ76buLqRK0nAqDEHWeqVl4P9D0YrfN0NEkyenIFtlN36qMM8VZz
	VCwJ2X5aclH6+XRdaOg==
X-Received: from pjbcx2.prod.google.com ([2002:a17:90a:fd82:b0:3ac:c43b:e307])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4f4c:b0:3a4:acde:1e3b with SMTP id 98e67ed59e1d1-3b0db6d42b7mr3688936a91.13.1793996411133;
 Fri, 06 Nov 2026 12:20:11 -0800 (PST)
Date: Fri, 06 Nov 2026 20:19:48 +0000
In-Reply-To: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261106-lskel-struct-ops-v1-1-a4486ffc79cb@google.com>
Subject: [PATCH RFC bpf-next 1/7] bpf: Add bpf_btf_get_struct_member_info() helper
From: Siddharth Nayyar <sidnayyar@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Giuliano Procida <gprocida@google.com>, 
	Neill Kapron <nkapron@google.com>, "=?utf-8?q?Thi=C3=A9baud_Weksteen?=" <tweek@google.com>, 
	Maxime Ripard <mripard@kernel.org>, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

Add a new BPF helper bpf_btf_get_struct_member_info() for
BPF_PROG_TYPE_SYSCALL programs to query struct member offset and index
(or the struct size when the member name is NULL) from vmlinux or
module BTF.

Given a struct's BTF type ID and an optional BTF object FD (0 for
vmlinux BTF), the helper returns a 64-bit value with the member's byte
offset in the lower 32 bits and the member's index in the upper 32 bits
when a member name is provided, or the byte size of the struct when the
member name is NULL.

This helper will be used by BPF light skeletons (gen_loader) to
initialize struct_ops maps and programs against kernel and module BTF
at load time.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 13 ++++++++
 kernel/bpf/btf.c               | 73 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  2 ++
 tools/include/uapi/linux/bpf.h | 13 ++++++++
 5 files changed, 102 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b011acc22c50..ab4d995b529c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4206,6 +4206,7 @@ extern const struct bpf_func_proto bpf_task_storage_delete_recur_proto;
 extern const struct bpf_func_proto bpf_task_storage_delete_proto;
 extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
 extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
+extern const struct bpf_func_proto bpf_btf_get_struct_member_info_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
 extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_nodelay_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 62de0919db72..3a630411b920 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6065,6 +6065,18 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_btf_get_struct_member_info(u32 btf_id, int btf_obj_fd, const char *name, int name_sz)
+ *	Description
+ *		Find a struct member with given *name* in the struct type identified
+ *		by *btf_id* in the BTF object referenced by *btf_obj_fd* (or in
+ *		vmlinux BTF if *btf_obj_fd* is 0). If *name* is **NULL** (and
+ *		*name_sz* is 0), return the size of the struct instead.
+ *	Return
+ *		Returns the member's byte offset in the lower 32 bits and the
+ *		member's index in the upper 32 bits when *name* is non-**NULL**,
+ *		or the byte size of the struct when *name* is **NULL**. On error, a
+ *		negative error code is returned.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6279,6 +6291,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(btf_get_struct_member_info, 212, ##ctx)	\
 	/* This helper list is effectively frozen. If you are trying to	\
 	 * add a new helper, you should add a kfunc instead which has	\
 	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 228b93d4f8c9..8d9188dda34e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9682,6 +9682,79 @@ const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_btf_get_struct_member_info, u32, btf_id, int, btf_obj_fd,
+	   const char *, name, int, name_sz)
+{
+	const struct btf_member *member;
+	const struct btf_type *t;
+	struct btf *btf;
+	long ret = -EINVAL;
+	u32 i;
+
+	if (!name) {
+		if (name_sz)
+			return -EINVAL;
+	} else if (name_sz <= 1 || !*name || name[name_sz - 1]) {
+		return -EINVAL;
+	}
+
+	if (btf_obj_fd) {
+		btf = btf_get_by_fd(btf_obj_fd);
+		if (IS_ERR(btf))
+			return PTR_ERR(btf);
+	} else {
+		btf = bpf_get_btf_vmlinux();
+		if (IS_ERR(btf))
+			return PTR_ERR(btf);
+		if (!btf)
+			return -EINVAL;
+		btf_get(btf);
+	}
+
+	t = btf_type_by_id(btf, btf_id);
+	if (!t || !__btf_type_is_struct(t))
+		goto out;
+
+	if (!name) {
+		ret = t->size;
+		goto out;
+	}
+
+	ret = -ENOENT;
+	for_each_member(i, t, member) {
+		const char *mname = btf_name_by_offset(btf, member->name_off);
+
+		if (!mname || !*mname)
+			continue;
+		if (!strcmp(mname, name)) {
+			u32 moff;
+
+			if (__btf_member_bitfield_size(t, member)) {
+				ret = -EOPNOTSUPP;
+				goto out;
+			}
+			moff = __btf_member_bit_offset(t, member) / 8;
+			ret = moff | (((u64)i) << 32);
+			goto out;
+		}
+	}
+
+out:
+	btf_put(btf);
+	return ret;
+}
+
+const struct bpf_func_proto bpf_btf_get_struct_member_info_proto = {
+	.func		= bpf_btf_get_struct_member_info,
+	.gpl_only	= false,
+	.might_sleep	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY | PTR_MAYBE_NULL,
+	.arg4_type	= ARG_MEM_SIZE_OR_ZERO,
+};
+
 BTF_ID_LIST_GLOBAL(btf_tracing_ids, MAX_BTF_TRACING_TYPE)
 #define BTF_TRACING_TYPE(name, type) BTF_ID(struct, type)
 BTF_TRACING_TYPE_xxx
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9004f2673ccf..6e7b6b10603e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6756,6 +6756,8 @@ syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		       ? NULL : &bpf_sys_bpf_proto;
 	case BPF_FUNC_btf_find_by_name_kind:
 		return &bpf_btf_find_by_name_kind_proto;
+	case BPF_FUNC_btf_get_struct_member_info:
+		return &bpf_btf_get_struct_member_info_proto;
 	case BPF_FUNC_sys_close:
 		return &bpf_sys_close_proto;
 	case BPF_FUNC_kallsyms_lookup_name:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 62de0919db72..3a630411b920 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6065,6 +6065,18 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_btf_get_struct_member_info(u32 btf_id, int btf_obj_fd, const char *name, int name_sz)
+ *	Description
+ *		Find a struct member with given *name* in the struct type identified
+ *		by *btf_id* in the BTF object referenced by *btf_obj_fd* (or in
+ *		vmlinux BTF if *btf_obj_fd* is 0). If *name* is **NULL** (and
+ *		*name_sz* is 0), return the size of the struct instead.
+ *	Return
+ *		Returns the member's byte offset in the lower 32 bits and the
+ *		member's index in the upper 32 bits when *name* is non-**NULL**,
+ *		or the byte size of the struct when *name* is **NULL**. On error, a
+ *		negative error code is returned.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6279,6 +6291,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(btf_get_struct_member_info, 212, ##ctx)	\
 	/* This helper list is effectively frozen. If you are trying to	\
 	 * add a new helper, you should add a kfunc instead which has	\
 	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\

-- 
2.56.0.455.g6c5a503b38-goog

