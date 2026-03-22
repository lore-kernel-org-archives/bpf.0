Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DE1F30AD
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774143897; cv=none; b=lMLmV+C8lP8dS2XCIoO5M7bBoTYl5vhzE3Ya+eIR/DKdNChrpm2/yVNR8ab2KRAyqDdoZqVtRnehNxDIfEvMzwkgpY+h8d/SgaNN127YYrnhnEnSy7Doe0WyRj4ob5Y0MBls95LGJwfBS7apL7nnlwaGHo2Kd8yQnSs0kVu+TBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774143897; c=relaxed/simple;
	bh=FC5uQXV7crRBTVBElwFW7HLe2rG6bGvWT6YjTy65euI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDL4UdwzMyTVIHgR47wq9bqsEOlja03OOwUOG3SF76KVZ9dkB1AJQ4Qp7MKOn01VOd3R5dgJAus5ZV9HNrTJ+zgF1/2BNo6QP/yHNIa9ntGneWKgWWkzIjVmgu0NCVOQTL86eQv7BD+t/fZnXXrYGlB8hTeb9krXA1w1BLG0KNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKemwgFq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKemwgFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774143894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CwWLC1ynWW8IemkY1+a4g7N2hZG2j6xq11JxcVWyNu4=;
	b=jKemwgFqNTXpXVzRj3MIQsJSFVE5ipcinEAD/2b+Jm0OD8Md2TLc1iWwk+WKI/j0CAqdgG
	5Fkl43uhLnSGT3RiZLSeuQbjz+COQeQqTlnFTkvu0z7gYkc4FQvZIOb89f65pEkuv/f15a
	zEEnMpZuHC8Dt0DHDfQdcqeiPZRtknk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-nfl0JzubPsOR4KCoDrX7qQ-1; Sat,
 21 Mar 2026 21:44:51 -0400
X-MC-Unique: nfl0JzubPsOR4KCoDrX7qQ-1
X-Mimecast-MFC-AGG-ID: nfl0JzubPsOR4KCoDrX7qQ_1774143888
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA1D61956048;
	Sun, 22 Mar 2026 01:44:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1177730001A2;
	Sun, 22 Mar 2026 01:44:32 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: bpf@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCHv7 01/13] bpf: Introduce kfuncs to parser buffer content
Date: Sun, 22 Mar 2026 09:43:50 +0800
Message-ID: <20260322014402.8815-2-piliu@redhat.com>
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
References: <20260322014402.8815-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In the security kexec_file_load case, the buffer holding the kernel
image should not be accessible from userspace.

Typically, BPF data flow occurs between user space and kernel space in
either direction. However, the above case presents a unique scenario
where the kernel, instead of a user task, reads data from a file, passes
it to a BPF program for parsing, and finally stores the parsed result.

This requires a mechanism to channel the intermediate data from the BPF
program directly to the kernel. BPF buffer parser kfuncs are introduced
to serve this purpose:

    BTF_ID_FLAGS(func, bpf_get_parser_context, KF_ACQUIRE | KF_RET_NULL)
    BTF_ID_FLAGS(func, bpf_put_parser_context, KF_RELEASE)
    BTF_ID_FLAGS(func, bpf_buffer_parser, KF_SLEEPABLE)

where bpf_get_parser_context() and bpf_put_parser_context() manage the
trusted argument, and bpf_buffer_parser() forwards data to a callback
that processes the structured buffer constructed by the BPF program.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David S. Miller <davem@davemloft.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
To: bpf@vger.kernel.org
---
 include/linux/bpf.h            |  20 ++++
 kernel/bpf/Makefile            |   3 +
 kernel/bpf/bpf_buffer_parser.c | 186 +++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 kernel/bpf/bpf_buffer_parser.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b03..93a1c9163685f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4005,4 +4005,24 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 	return 0;
 }
 
+struct bpf_parser_buf {
+	char *buf;
+	int size;
+};
+
+struct bpf_parser_context;
+typedef int (*bpf_parser_handler_t)(struct bpf_parser_context *ctx);
+
+struct bpf_parser_context {
+	struct kref ref;
+	struct hlist_node hash_node;
+	/* This callback should be sync so that @buf can be freed */
+	bpf_parser_handler_t func;
+	struct bpf_parser_buf *buf;
+	void *data;
+};
+
+struct bpf_parser_context *alloc_bpf_parser_context(bpf_parser_handler_t func,
+			void *data);
+void put_bpf_parser_context(struct bpf_parser_context *ctx);
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 79cf22860a99b..cceff165b4037 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -66,6 +66,9 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
 ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
 obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
 endif
+ifeq ($(CONFIG_KEXEC_BPF),y)
+obj-$(CONFIG_BPF_SYSCALL) += bpf_buffer_parser.o
+endif
 
 CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/bpf_buffer_parser.c b/kernel/bpf/bpf_buffer_parser.c
new file mode 100644
index 0000000000000..5d5c068330791
--- /dev/null
+++ b/kernel/bpf/bpf_buffer_parser.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/hashtable.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/vmalloc.h>
+#include <linux/bpf.h>
+
+#define BPF_CONTEXT_HASH_BITS 10
+
+static DEFINE_SPINLOCK(bpf_parser_context_lock);
+static DEFINE_HASHTABLE(bpf_parser_context_map, BPF_CONTEXT_HASH_BITS);
+
+/* Generate a simple hash key from pointer address */
+static inline unsigned int bpf_parser_context_hash_key(struct bpf_parser_context *ctx)
+{
+	return hash_ptr(ctx, BPF_CONTEXT_HASH_BITS);
+}
+
+static void release_bpf_parser_context(struct kref *kref)
+{
+	struct bpf_parser_context *ctx = container_of(kref, struct bpf_parser_context, ref);
+
+	if (ctx->buf) {
+		vfree(ctx->buf->buf);
+		kfree(ctx->buf);
+	}
+	spin_lock(&bpf_parser_context_lock);
+	hash_del(&ctx->hash_node);
+	spin_unlock(&bpf_parser_context_lock);
+	kfree(ctx);
+}
+
+struct bpf_parser_context *alloc_bpf_parser_context(bpf_parser_handler_t func,
+		void *data)
+{
+	struct bpf_parser_context *ctx;
+	unsigned int key;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+	ctx->func = func;
+	ctx->data = data;
+	kref_init(&ctx->ref);
+	key = bpf_parser_context_hash_key(ctx);
+	spin_lock(&bpf_parser_context_lock);
+	hash_add(bpf_parser_context_map, &ctx->hash_node, key);
+	spin_unlock(&bpf_parser_context_lock);
+
+	return ctx;
+}
+
+void put_bpf_parser_context(struct bpf_parser_context *ctx)
+{
+	if (!ctx)
+		return;
+	kref_put(&ctx->ref, release_bpf_parser_context);
+}
+
+static struct bpf_parser_context *find_bpf_parser_context(unsigned long id)
+{
+	struct bpf_parser_context *ctx;
+	unsigned int key;
+	int cnt;
+
+	key = bpf_parser_context_hash_key((struct bpf_parser_context *)id);
+	spin_lock(&bpf_parser_context_lock);
+	hash_for_each_possible(bpf_parser_context_map, ctx, hash_node, key) {
+		if (ctx == (struct bpf_parser_context *)id) {
+			cnt = kref_get_unless_zero(&ctx->ref);
+			if (!cnt)
+				ctx = NULL;
+			spin_unlock(&bpf_parser_context_lock);
+			return ctx;
+		}
+	}
+	spin_unlock(&bpf_parser_context_lock);
+
+	return NULL;
+}
+
+__bpf_kfunc_start_defs()
+
+__bpf_kfunc struct bpf_parser_context *bpf_get_parser_context(unsigned long id)
+{
+	struct bpf_parser_context *ctx;
+
+	ctx = find_bpf_parser_context(id);
+
+	return ctx;
+}
+
+__bpf_kfunc void bpf_put_parser_context(struct bpf_parser_context *ctx)
+{
+	put_bpf_parser_context(ctx);
+}
+
+__bpf_kfunc void bpf_parser_context_release_dtor(void *ctx)
+{
+	put_bpf_parser_context(ctx);
+}
+CFI_NOSEAL(bpf_parser_context_release_dtor);
+
+__bpf_kfunc int bpf_buffer_parser(char *buf, int buf_sz,
+		struct bpf_parser_context *context)
+{
+	struct bpf_parser_buf *parser_buf;
+	void *old_val;
+	int ret;
+	char *b;
+
+	if (buf == NULL || buf_sz <= 0)
+		return -EINVAL;
+
+	if (unlikely(context->func == NULL))
+		return -EINVAL;
+
+	/* Lock the pointer */
+	old_val = cmpxchg(&context->buf, NULL, (void *)1);
+	if (old_val != NULL)
+		return -EBUSY;
+	b = __vmalloc(buf_sz, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!b) {
+		context->buf = NULL;
+		return -ENOMEM;
+	}
+	ret = copy_from_kernel_nofault(b, buf, buf_sz);
+	if (!!ret) {
+		context->buf = NULL;
+		vfree(b);
+		return ret;
+	}
+
+	parser_buf = kmalloc(sizeof(struct bpf_parser_buf), GFP_KERNEL);
+	if (!parser_buf) {
+		vfree(b);
+		context->buf = NULL;
+		return -ENOMEM;
+	}
+	parser_buf->buf = b;
+	parser_buf->size = buf_sz;
+	context->buf = parser_buf;
+	/* @func should be a sync call */
+	ret = context->func(context);
+	context->buf = NULL;
+	vfree(b);
+	kfree(parser_buf);
+
+	return ret;
+}
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(buffer_parser_ids)
+BTF_ID_FLAGS(func, bpf_get_parser_context, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_put_parser_context, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_buffer_parser, KF_SLEEPABLE)
+BTF_KFUNCS_END(buffer_parser_ids)
+
+static const struct btf_kfunc_id_set buffer_parser_kfunc_set = {
+        .owner = THIS_MODULE,
+        .set   = &buffer_parser_ids,
+};
+
+
+BTF_ID_LIST(buffer_parser_dtor_ids)
+BTF_ID(struct, bpf_parser_context)
+BTF_ID(func, bpf_parser_context_release_dtor)
+
+static int __init buffer_parser_kfunc_init(void)
+{
+	int ret;
+	const struct btf_id_dtor_kfunc buffer_parser_dtors[] = {
+		{
+			.btf_id	      = buffer_parser_dtor_ids[0],
+			.kfunc_btf_id = buffer_parser_dtor_ids[1]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &buffer_parser_kfunc_set);
+	return  ret ?: register_btf_id_dtor_kfuncs(buffer_parser_dtors,
+						   ARRAY_SIZE(buffer_parser_dtors),
+						   THIS_MODULE);
+}
+
+late_initcall(buffer_parser_kfunc_init);
-- 
2.49.0

