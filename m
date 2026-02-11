Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872402C21F7
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770820386; cv=none; b=O6xWPjR8wpxymHuwfBfDywHq6lDeLoQ66f+virYkebvUnxTdxmO0NyBFgkLo6PNqkWSTws6n3fWs+A8hdByRQwPggC6sCW9Xdbh9CvwvNbgidudpaXjnCm/+10BSIH41XaUzfu0PkPQW4RgBPzM9pFbE3D9V8cypZezhh9qySHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770820386; c=relaxed/simple;
	bh=r30MLe29szL2uwyHGB8qRAfhFIwiRx+7vdW7aJXtJwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoGZZOH+4lJ9Bowm8Q+5OlW5GrJgEzO1kRiHCKYDdQ+jbZpXSdDuRZU0BZhm5PwJ3isJmhwrSUey7fxlw/K8xRi6ip0kXq8gTCwcjsH/XHkn5ttEwDQtBWa13H3t3Jj2a9qCeh17sXotPe5xryxT6ATxpSPVdzSSTYkfrkoXLZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctEqIoa7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctEqIoa7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43638a33157so1740060f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 06:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770820383; x=1771425183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmuPYRgZNocGtfV0uNTYRs6VwU8MDvoDCmzkUFRtnDo=;
        b=ctEqIoa7reuHR3FPzucy0T93jVw6aTu3pt9WPgHyw2uwQRsexbzhVrJflmQQ+9WvIr
         6xUEP04K9e9dnDpQTOmibDZUFFJv1fX9cOCk4MZGGTaZ7XD252YS/qHTMIYrsvRQsnxM
         NjewxYlaIdQVGIjPFap8Ruc38CJcUaxdcCIKyZCE8Xcy+umX3PKtsBtPKlHaEbgMaB84
         jCRzD/rztey2zb5VI0B+1pKPPk5FJnQGBgOGdSfRFAUqE/Uq4yUODw9cW6RGA/797ay5
         zhfTRx41uItKf4ZwAFJvyBJAWejkZaP41C7Zm9pgWfv5z5F0W3liPl7FJMFG4NYN86FK
         m7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770820383; x=1771425183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EmuPYRgZNocGtfV0uNTYRs6VwU8MDvoDCmzkUFRtnDo=;
        b=V+oIUWgM+O0M/3YEwV88AwO04J09/aeJyZz8dkxNjJ3nMeXYgcydSQPXe8M19JXfTF
         pyCF73YoiQpEKRpRJUwqqWI9s8CXzC5dewRimiaUx4ncu83COkz+Xs+kVZWw0mlr2aKR
         pRCm2JkkLDW6mt+KnhSoI/SZZRKqPeRJEn7QaGogQW28Ew0wysmyFMstRjjSLK4870+5
         9KMSJOcstEbaC63RBrkwUn9gbkNqrwsqUCYSnTBQqJvV/trmdMV0pV6NM0OPpELz2QRB
         dxV3sX+86HIVs6cjT4uCLWBXVETbC6Mo/oNxWpIQ1X8K4p+fnNi4Ed9tam0A2faEF/jh
         u5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWfakV26ZAFGKgMRhlRijaShz41Fm4wM2EvNoaF4nKqlwQKAaTaj1wqWdGzrxA0j9NBugE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6RP0nbOheewVu8FNGYkdCq13CQeBzAr4B6KbCy6UVIsdp3OX
	9B0zZiwj1n9y9JY6eSS7WGH8tKdvneWSGiMQCgwtmYr4Qgv+PwLpKLuu
X-Gm-Gg: AZuq6aJ/NBk9GyWmxDTdP77vr/gj1/SJ23REdano7Aw4FykYFPN0EyPc4ZA/BgDTpoS
	/u8aGEXjVy0XERiKb5Q8pbq0jVFR1+EA895Ce/6+1uaOOHauPg2YfurROzuWJE/Gwj5YzqdLhCz
	9WvquSOHl+qOIIkCOkn4ngiYJa81eA2aveFuU2s2pN/Uh+tZe8g/HC6od0ex0wKDwGjopFbVPkg
	Zut1dBYT0e6PY1dBropPbTo2dOuPtHRBzUKTw1AAx+KTpPyd4zK1LA3UL2n7FXmFFxX30yhggaq
	/zgzqMX9q8peLZwdFXD9qm3sVqp3CHdsJi71qhiF+5hGHE+fJYy4WG3Z16K+zAZNBJ3LU8FjiV7
	2V9ms1GsQtxfy8JfoV87ArOACJLs4iZqsufLCEAfBlE+/UNLa6RtYi9flOPUznp95SBR/YpwKN2
	uqYkOiHhIOpPG5jLdlrMLwJGaH0G7EwyTByx4TrN8bOkKb5GFcIys3v8/OIHdf4vWcDx1sy8EpD
	bFrySKRPA==
X-Received: by 2002:a5d:64e7:0:b0:437:6efe:94c0 with SMTP id ffacd0b85a97d-4376efe9b22mr13982304f8f.7.1770820382706;
        Wed, 11 Feb 2026 06:33:02 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:b997])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e39c75sm4973747f8f.29.2026.02.11.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 06:33:02 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v5 4/5] io_uring/bpf-ops: implement bpf ops registration
Date: Wed, 11 Feb 2026 14:32:43 +0000
Message-ID: <7ca5070830c022493eaf45948e146f418aceb747.1770818588.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770818588.git.asml.silence@gmail.com>
References: <cover.1770818588.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement BPF struct ops registration. It's registered off the BPF
path, and can be removed by BPF as well as io_uring. To protect it,
introduce a global lock synchronising registration. ctx->uring_lock can
be nested under it. ctx->bpf_ops is write protected by both locks and
so it's safe to read it under either of them.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_uring_types.h |  5 ++
 io_uring/bpf-ops.c             | 91 +++++++++++++++++++++++++++++++++-
 io_uring/bpf-ops.h             |  8 +++
 io_uring/io_uring.c            |  1 +
 4 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index cceac329fcfd..976d85f82f86 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -8,6 +8,9 @@
 #include <linux/llist.h>
 #include <uapi/linux/io_uring.h>
 
+struct iou_loop_params;
+struct io_uring_bpf_ops;
+
 enum {
 	/*
 	 * A hint to not wake right away but delay until there are enough of
@@ -481,6 +484,8 @@ struct io_ring_ctx {
 	DECLARE_HASHTABLE(napi_ht, 4);
 #endif
 
+	struct io_uring_bpf_ops		*bpf_ops;
+
 	/*
 	 * Protection for resize vs mmap races - both the mmap and resize
 	 * side will need to grab this lock, to prevent either side from
diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
index 66938514211f..c75a0b858715 100644
--- a/io_uring/bpf-ops.c
+++ b/io_uring/bpf-ops.c
@@ -4,10 +4,12 @@
 
 #include "io_uring.h"
 #include "register.h"
+#include "loop.h"
 #include "memmap.h"
 #include "bpf-ops.h"
 #include "loop.h"
 
+static DEFINE_MUTEX(io_bpf_ctrl_mutex);
 static const struct btf_type *loop_params_type;
 
 __bpf_kfunc_start_defs();
@@ -143,16 +145,103 @@ static int bpf_io_init_member(const struct btf_type *t,
 			       const struct btf_member *member,
 			       void *kdata, const void *udata)
 {
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+	const struct io_uring_bpf_ops *uops = udata;
+	struct io_uring_bpf_ops *ops = kdata;
+
+	switch (moff) {
+	case offsetof(struct io_uring_bpf_ops, ring_fd):
+		ops->ring_fd = uops->ring_fd;
+		return 1;
+	}
+	return 0;
+}
+
+static int io_install_bpf(struct io_ring_ctx *ctx, struct io_uring_bpf_ops *ops)
+{
+	if (ctx->flags & (IORING_SETUP_SQPOLL | IORING_SETUP_IOPOLL))
+		return -EOPNOTSUPP;
+	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
+		return -EOPNOTSUPP;
+
+	if (ctx->bpf_ops)
+		return -EBUSY;
+	if (WARN_ON_ONCE(!ops->loop_step))
+		return -EINVAL;
+
+	ops->priv = ctx;
+	ctx->bpf_ops = ops;
+	ctx->loop_step = ops->loop_step;
 	return 0;
 }
 
 static int bpf_io_reg(void *kdata, struct bpf_link *link)
 {
-	return -EOPNOTSUPP;
+	struct io_uring_bpf_ops *ops = kdata;
+	struct io_ring_ctx *ctx;
+	struct file *file;
+	int ret = -EBUSY;
+
+	file = io_uring_register_get_file(ops->ring_fd, false);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+	ctx = file->private_data;
+
+	scoped_guard(mutex, &io_bpf_ctrl_mutex) {
+		guard(mutex)(&ctx->uring_lock);
+		ret = io_install_bpf(ctx, ops);
+	}
+
+	fput(file);
+	return ret;
+}
+
+static void io_eject_bpf(struct io_ring_ctx *ctx)
+{
+	struct io_uring_bpf_ops *ops = ctx->bpf_ops;
+
+	if (!WARN_ON_ONCE(!ops))
+		return;
+	if (WARN_ON_ONCE(ops->priv != ctx))
+		return;
+
+	ops->priv = NULL;
+	ctx->bpf_ops = NULL;
+	ctx->loop_step = NULL;
 }
 
 static void bpf_io_unreg(void *kdata, struct bpf_link *link)
 {
+	struct io_uring_bpf_ops *ops = kdata;
+	struct io_ring_ctx *ctx;
+
+	guard(mutex)(&io_bpf_ctrl_mutex);
+	ctx = ops->priv;
+	if (ctx) {
+		guard(mutex)(&ctx->uring_lock);
+		if (WARN_ON_ONCE(ctx->bpf_ops != ops))
+			return;
+
+		io_eject_bpf(ctx);
+	}
+}
+
+void io_unregister_bpf_ops(struct io_ring_ctx *ctx)
+{
+	/*
+	 * ->bpf_ops is write protected by io_bpf_ctrl_mutex and uring_lock,
+	 * and read protected by either. Try to avoid taking the global lock
+	 * for rings that never had any bpf installed.
+	 */
+	scoped_guard(mutex, &ctx->uring_lock) {
+		if (!ctx->bpf_ops)
+			return;
+	}
+
+	guard(mutex)(&io_bpf_ctrl_mutex);
+	guard(mutex)(&ctx->uring_lock);
+	if (ctx->bpf_ops)
+		io_eject_bpf(ctx);
 }
 
 static struct bpf_struct_ops bpf_ring_ops = {
diff --git a/io_uring/bpf-ops.h b/io_uring/bpf-ops.h
index b9e589ad519a..b39b3fd3acda 100644
--- a/io_uring/bpf-ops.h
+++ b/io_uring/bpf-ops.h
@@ -17,4 +17,12 @@ struct io_uring_bpf_ops {
 	void *priv;
 };
 
+#ifdef CONFIG_IO_URING_BPF_OPS
+void io_unregister_bpf_ops(struct io_ring_ctx *ctx);
+#else
+static inline void io_unregister_bpf_ops(struct io_ring_ctx *ctx)
+{
+}
+#endif
+
 #endif /* IOU_BPF_OPS_H */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 1f7c03728083..259412b6b072 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2149,6 +2149,7 @@ static __cold void io_req_caches_free(struct io_ring_ctx *ctx)
 
 static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
+	io_unregister_bpf_ops(ctx);
 	io_sq_thread_finish(ctx);
 
 	mutex_lock(&ctx->uring_lock);
-- 
2.52.0

