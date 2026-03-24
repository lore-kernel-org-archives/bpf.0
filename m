Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4093FADFB
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370307; cv=none; b=cxrpmTWAdAESxDGOhQ37Sr+sN6n3zjb/6s0VOpB1SpUJBxRmg5JgN8+n5//Vuggiy+ltg1aBGysdMpaXVhBeA+iJB55Pb22ZBFbkxs+9xD0nFjZ1U4XYGJypPJNyuB2LohCOeXcrlVnL04xZwhdyNvh3qUhAZd0R1XSRzBBbpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370307; c=relaxed/simple;
	bh=2uiAGOZMzwS2AU1xbr9rip9UicGOt8hjiQX1y4LeSPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbvfsVXLMxqv6FyR9xmQPq5sNxFbKzxBpst03JrrvPTV9+YGaDjJkHOCXxBKAj7MBSiDh52etVB4SDSHj+kr3YUwioMKFKUSCLirvIVJLjEjXd1Hn/MG5KbVjFu6C4DAfNy8PgmIWKT6AvW+Jkuw8c2p1IkuKhIr9lC/TLstCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvBomx2C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvBomx2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774370304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mPtJ37TRrzlJTC6iXy5hCQJrY9b1hS1zwNGerPRFB0=;
	b=XvBomx2C1kd5ei3ev4fs+h6WGawg+sEDXExKl3gS/7QS+zeoFxea/Riy5dQMY+ofyg4ClM
	NGeX/kE4KpsVX14/SHZSmbAZ8GW6lOce1Wif5XaptHYooeRpbBghMGHGEFbOrCJJzEFU4J
	/SRDBFXQNd7Z9KpvQniE1S/caZdU4zY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-xrDAg1NdOWOh-p8zrk9JYw-1; Tue,
 24 Mar 2026 12:38:21 -0400
X-MC-Unique: xrDAg1NdOWOh-p8zrk9JYw-1
X-Mimecast-MFC-AGG-ID: xrDAg1NdOWOh-p8zrk9JYw_1774370300
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E36381800561;
	Tue, 24 Mar 2026 16:38:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.133])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1A59300019F;
	Tue, 24 Mar 2026 16:38:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	bpf@vger.kernel.org,
	Xiao Ni <xni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 03/12] io_uring: refactor io_import_reg_vec() for BPF kfunc use
Date: Wed, 25 Mar 2026 00:37:24 +0800
Message-ID: <20260324163753.1900977-4-ming.lei@redhat.com>
In-Reply-To: <20260324163753.1900977-1-ming.lei@redhat.com>
References: <20260324163753.1900977-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Split io_import_reg_vec() into:
- __io_import_reg_vec(): core logic taking io_mapped_ubuf directly
- io_import_reg_vec(): inline wrapper handling buffer lookup and
  request flags

The core function takes 'imu' and 'need_clean' parameters instead of
accessing req directly. This allows BPF kfuncs to import vectored
buffers without request association, enabling support for multiple
buffers per request.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/rsrc.c | 18 +++++-------------
 io_uring/rsrc.h | 29 ++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 0b3e4cb5e879..49d9f0b05e7c 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1453,23 +1453,14 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
 	return 0;
 }
 
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
-			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags)
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
+			struct io_mapped_ubuf *imu, struct iou_vec *vec,
+			unsigned nr_iovs, bool *need_clean)
 {
-	struct io_rsrc_node *node;
-	struct io_mapped_ubuf *imu;
 	unsigned iovec_off;
 	struct iovec *iov;
 	unsigned nr_segs;
 
-	node = io_find_buf_node(req, issue_flags);
-	if (!node)
-		return -EFAULT;
-	imu = node->buf;
-	if (!(imu->dir & (1 << ddir)))
-		return -EFAULT;
-
 	iovec_off = vec->nr - nr_iovs;
 	iov = vec->iovec + iovec_off;
 
@@ -1508,7 +1499,8 @@ int io_import_reg_vec(int ddir, struct iov_iter *iter,
 
 		*vec = tmp_vec;
 		iov = vec->iovec + iovec_off;
-		req->flags |= REQ_F_NEED_CLEANUP;
+		if (need_clean)
+			*need_clean = true;
 	}
 
 	if (imu->flags & IO_REGBUF_F_KBUF)
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index c2c729a9f568..87ee5a76cbfc 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -81,9 +81,32 @@ static inline int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 		return -EFAULT;
 	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
 }
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
-			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags);
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
+			struct io_mapped_ubuf *imu, struct iou_vec *vec,
+			unsigned nr_iovs, bool *need_clean);
+
+static inline int io_import_reg_vec(int ddir, struct iov_iter *iter,
+				    struct io_kiocb *req, struct iou_vec *vec,
+				    unsigned nr_iovs, unsigned issue_flags)
+{
+	struct io_rsrc_node *node;
+	struct io_mapped_ubuf *imu;
+	bool need_clean = false;
+	int ret;
+
+	node = io_find_buf_node(req, issue_flags);
+	if (!node)
+		return -EFAULT;
+	imu = node->buf;
+	if (!(imu->dir & (1 << ddir)))
+		return -EFAULT;
+
+	ret = __io_import_reg_vec(ddir, iter, imu, vec, nr_iovs, &need_clean);
+	if (need_clean)
+		req->flags |= REQ_F_NEED_CLEANUP;
+	return ret;
+}
+
 int __io_prep_reg_iovec(struct iou_vec *iv, const struct iovec __user *uvec,
 			size_t uvec_segs, bool compat, bool *need_clean);
 
-- 
2.53.0

