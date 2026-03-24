Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441503FE644
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370317; cv=none; b=JtZy51V2bR0KBUVZ8GhsJl6zIPaF++vq2LmG6dZMqMV/mp0iW1aYXPlUc0LeDfkhF4I8e7I4djVk/4LgpK5LOUinm5iTPLg2dTmH18HdIR2b0ntY7BWYeNIrvqyLpP35SlcTir4Jca00sMHA1bxqDYuh1GLoQbpvG9dzVm9cmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370317; c=relaxed/simple;
	bh=aqUPcHmClTjF53ZHePA3J36k4uU0uYL6cA/8Zzagt0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBp3/XlEAF3v3f7kWMYcJYLm3CcKXVFSzvEHBDl2dgf7SqMDzV0qmCF1LwGC6PD8CEpcoLleFXc5SScyNqza1jvdvAHvHKD7vtj/fV5P++BuLrg5iUrYN6HuTxLxAS8Gr+duscfWtALE4tmJ3EDaM+cluvsX8+e9ub+yquzZ6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dD3vXDFr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dD3vXDFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774370315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUCVqhLBcXk4vJeeUen5lavregCZVJAGDSk5uNnqxwg=;
	b=dD3vXDFrtY23PY7fWZlVhwwxvBEabBr0eZlHPbT0NZtiJBNkz9bxQzF6q7p/hSm15r7d8h
	nRM2Le8Z1RaGFGaV4EilvEr3Nlun/S66Ydspivpl1/CDsqUFl9pl8DcmJs/uZtHn4/metH
	hkrfU/B6TOiXH1TISrfxD7BLjoZvpkg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-I1uJ11pQOSSxgSm_RoxNvg-1; Tue,
 24 Mar 2026 12:38:33 -0400
X-MC-Unique: I1uJ11pQOSSxgSm_RoxNvg-1
X-Mimecast-MFC-AGG-ID: I1uJ11pQOSSxgSm_RoxNvg_1774370311
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 003F818002CD;
	Tue, 24 Mar 2026 16:38:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.133])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EEA218001FE;
	Tue, 24 Mar 2026 16:38:29 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	bpf@vger.kernel.org,
	Xiao Ni <xni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 06/12] io_uring: bpf: implement struct_ops registration
Date: Wed, 25 Mar 2026 00:37:27 +0800
Message-ID: <20260324163753.1900977-7-ming.lei@redhat.com>
In-Reply-To: <20260324163753.1900977-1-ming.lei@redhat.com>
References: <20260324163753.1900977-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Complete the BPF struct_ops registration mechanism by implementing
refcount-based lifecycle management:

- Add refcount field to struct uring_bpf_ops_kern for tracking active
  requests
- Add wait_queue_head_t bpf_wq to struct io_ring_ctx for synchronizing
  unregistration with in-flight requests
- Implement io_bpf_reg_unreg() to handle registration (refcount=1) and
  unregistration (wait for in-flight requests to complete)
- Update io_uring_bpf_prep() to increment refcount on success and reject
  new requests when refcount is zero (unregistration in progress)
- Update io_uring_bpf_cleanup() to decrement refcount and wake up waiters
  when it reaches zero

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/io_uring_types.h |   2 +
 io_uring/bpf_ext.c             | 104 ++++++++++++++++++++++++++++++++-
 io_uring/bpf_ext.h             |   3 +
 3 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 3a558da86f83..5a240c5705cb 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -516,6 +516,8 @@ struct io_ring_ctx {
 	struct io_mapped_region		ring_region;
 	/* used for optimised request parameter and wait argument passing  */
 	struct io_mapped_region		param_region;
+
+	wait_queue_head_t		bpf_wq;
 };
 
 /*
diff --git a/io_uring/bpf_ext.c b/io_uring/bpf_ext.c
index e2151cc7f9f5..96c77a6d6cc0 100644
--- a/io_uring/bpf_ext.c
+++ b/io_uring/bpf_ext.c
@@ -12,6 +12,7 @@
 #include <linux/filter.h>
 #include <uapi/linux/io_uring.h>
 #include "io_uring.h"
+#include "register.h"
 #include "bpf_ext.h"
 
 static inline unsigned char uring_bpf_get_op(u32 op_flags)
@@ -29,7 +30,9 @@ int io_uring_bpf_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct uring_bpf_data *data = io_kiocb_to_cmd(req, struct uring_bpf_data);
 	u32 opf = READ_ONCE(sqe->bpf_op_flags);
 	unsigned char bpf_op = uring_bpf_get_op(opf);
+	struct uring_bpf_ops_kern *ops_kern;
 	const struct uring_bpf_ops *ops;
+	int ret;
 
 	if (unlikely(!(req->ctx->flags & IORING_SETUP_BPF_EXT)))
 		goto fail;
@@ -37,11 +40,20 @@ int io_uring_bpf_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (bpf_op >= IO_RING_MAX_BPF_OPS)
 		return -EINVAL;
 
-	ops = req->ctx->bpf_ext_ops[bpf_op].ops;
+	ops_kern = &req->ctx->bpf_ext_ops[bpf_op];
+	ops = ops_kern->ops;
+	if (!ops || !ops->prep_fn || !ops_kern->refcount)
+		goto fail;
+
 	data->opf = opf;
 	data->ops = ops;
-	if (ops && ops->prep_fn)
-		return ops->prep_fn(data, sqe);
+	ret = ops->prep_fn(data, sqe);
+	if (!ret) {
+		/* Only increment refcount on success (uring_lock already held) */
+		req->flags |= REQ_F_NEED_CLEANUP;
+		ops_kern->refcount++;
+	}
+	return ret;
 fail:
 	return -EOPNOTSUPP;
 }
@@ -78,9 +90,18 @@ void io_uring_bpf_cleanup(struct io_kiocb *req)
 {
 	struct uring_bpf_data *data = io_kiocb_to_cmd(req, struct uring_bpf_data);
 	const struct uring_bpf_ops *ops = data->ops;
+	struct uring_bpf_ops_kern *ops_kern;
+	unsigned char bpf_op;
 
 	if (ops && ops->cleanup_fn)
 		ops->cleanup_fn(data);
+
+	bpf_op = uring_bpf_get_op(data->opf);
+	ops_kern = &req->ctx->bpf_ext_ops[bpf_op];
+
+	/* Decrement refcount after cleanup (uring_lock already held) */
+	if (--ops_kern->refcount == 0)
+		wake_up(&req->ctx->bpf_wq);
 }
 
 static const struct btf_type *uring_bpf_data_type;
@@ -157,10 +178,82 @@ static int uring_bpf_ops_init_member(const struct btf_type *t,
 		 */
 		kuring_bpf_ops->id = uuring_bpf_ops->id;
 		return 1;
+	case offsetof(struct uring_bpf_ops, ring_fd):
+		kuring_bpf_ops->ring_fd = uuring_bpf_ops->ring_fd;
+		return 1;
 	}
 	return 0;
 }
 
+static int io_bpf_reg_unreg(struct uring_bpf_ops *ops, bool reg)
+{
+	struct uring_bpf_ops_kern *ops_kern;
+	struct io_ring_ctx *ctx;
+	struct file *file;
+	int ret = -EINVAL;
+
+	if (ops->id >= IO_RING_MAX_BPF_OPS)
+		return -EINVAL;
+
+	file = io_uring_register_get_file(ops->ring_fd, false);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ctx = file->private_data;
+	if (!(ctx->flags & IORING_SETUP_BPF_EXT))
+		goto out;
+
+	ops_kern = &ctx->bpf_ext_ops[ops->id];
+
+	mutex_lock(&ctx->uring_lock);
+	if (reg) {
+		/* Registration: set refcount to 1 and store ops */
+		if (ops_kern->ops) {
+			ret = -EBUSY;
+		} else {
+			ops_kern->ops = ops;
+			ops_kern->refcount = 1;
+			ret = 0;
+		}
+	} else {
+		/* Unregistration */
+		if (!ops_kern->ops) {
+			ret = -EINVAL;
+		} else {
+			ops_kern->refcount--;
+retry:
+			if (ops_kern->refcount == 0) {
+				ops_kern->ops = NULL;
+				ret = 0;
+			} else {
+				mutex_unlock(&ctx->uring_lock);
+				wait_event(ctx->bpf_wq, ops_kern->refcount == 0);
+				mutex_lock(&ctx->uring_lock);
+				goto retry;
+			}
+		}
+	}
+	mutex_unlock(&ctx->uring_lock);
+
+out:
+	fput(file);
+	return ret;
+}
+
+static int io_bpf_reg(void *kdata, struct bpf_link *link)
+{
+	struct uring_bpf_ops *ops = kdata;
+
+	return io_bpf_reg_unreg(ops, true);
+}
+
+static void io_bpf_unreg(void *kdata, struct bpf_link *link)
+{
+	struct uring_bpf_ops *ops = kdata;
+
+	io_bpf_reg_unreg(ops, false);
+}
+
 static int io_bpf_prep_io(struct uring_bpf_data *data, const struct io_uring_sqe *sqe)
 {
 	return 0;
@@ -191,6 +284,8 @@ static struct bpf_struct_ops bpf_uring_bpf_ops = {
 	.init = uring_bpf_ops_init,
 	.check_member = uring_bpf_ops_check_member,
 	.init_member = uring_bpf_ops_init_member,
+	.reg = io_bpf_reg,
+	.unreg = io_bpf_unreg,
 	.name = "uring_bpf_ops",
 	.cfi_stubs = &__bpf_uring_bpf_ops,
 	.owner = THIS_MODULE,
@@ -218,6 +313,8 @@ static const struct btf_kfunc_id_set uring_kfunc_set = {
 
 int io_bpf_alloc(struct io_ring_ctx *ctx)
 {
+	init_waitqueue_head(&ctx->bpf_wq);
+
 	if (!(ctx->flags & IORING_SETUP_BPF_EXT))
 		return 0;
 
@@ -225,6 +322,7 @@ int io_bpf_alloc(struct io_ring_ctx *ctx)
 			sizeof(struct uring_bpf_ops_kern), GFP_KERNEL);
 	if (!ctx->bpf_ext_ops)
 		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/io_uring/bpf_ext.h b/io_uring/bpf_ext.h
index 5a74f91bdcad..a568ea31a51a 100644
--- a/io_uring/bpf_ext.h
+++ b/io_uring/bpf_ext.h
@@ -27,14 +27,17 @@ typedef void (*uring_bpf_cleanup_t)(struct uring_bpf_data *data);
 
 struct uring_bpf_ops {
 	unsigned short		id;
+	int			ring_fd;
 	uring_bpf_prep_t	prep_fn;
 	uring_bpf_issue_t	issue_fn;
 	uring_bpf_fail_t	fail_fn;
 	uring_bpf_cleanup_t	cleanup_fn;
 };
 
+/* TODO: manage it via `io_rsrc_node` */
 struct uring_bpf_ops_kern {
 	const struct uring_bpf_ops *ops;
+	int refcount;
 };
 #ifdef CONFIG_IO_URING_BPF_EXT
 int io_uring_bpf_issue(struct io_kiocb *req, unsigned int issue_flags);
-- 
2.53.0

