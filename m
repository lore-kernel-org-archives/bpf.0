Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653D279DC8
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770820384; cv=none; b=FKoIRAOwqNeItYpPd2Ou7v8n2uGRFY1PCSqCEF4zAnqRMw5z5y4WcHKE4TmBM8sH7CC9tJgOnbFZGT3F1EfqNDBW+TOq8H7+zsW9/CfOvVNKUk9KkVct38/6zA9cjApUm4HhouXrSsY3CLnEHze1Yqwha5yigC3e5YkJldGK1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770820384; c=relaxed/simple;
	bh=g4mdqd7erSkmwxKY9UiIrJU3ZZ8yqMXNSbz5+qbf1+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TanOakdbMeWeuNgVdVHSjLMuTM05MdAa5zWebUKLINomREDfP5wm/Xs7uK44SF3qdjEskeUdxs+DRgzVVbY+jDwtI3N/9AM1KBt/2htnBmM9kJITVnuPszBEKjzGVFnZxJesjx1CYyUoLfBHU0rqOI5fr6AfsE3Ub4gJllSSKvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKAEofTU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKAEofTU"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43638a33157so1740036f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770820381; x=1771425181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62cY8G3KXbsi1k8TXxllrcY8LMCUpYkMlLMKQPPJB74=;
        b=BKAEofTU4VQGomFjh7iFzk+KBDbbm8yd7uEFhWfXjhnMyP9C82r8Z0vHRI9CZLlUOM
         HpeysL7bU1AYrppM2IHZ1X61uRqHSpSQilRWJscjSii247eXE2V/6qPY9ohY1uxbTUNN
         kZ8TH6vGdyW2K7WRbXUqawjm2Z8eD5XXvl3vMNQALjAzzOUQBcVYDUGzD7sJszdnI3uY
         HFA5/N7su/+wN0PSLHwiFDNy5Jq2RPU/St0LxnKLoMVkOguQ/c5cHR8wbsKPclMlIJNr
         hb+tgbTT1zBHWgP2qjVIr3J7hCEDGO+yPVic/G0sBdbWWHV4rICaBCzUYAmFQ9IDxIKm
         aYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770820381; x=1771425181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62cY8G3KXbsi1k8TXxllrcY8LMCUpYkMlLMKQPPJB74=;
        b=oG5wUTBEk/G6Pbe23fr+Llwtg5L0ponbtJ/baG89O3Xn3JGg2JnJhxWaVo/lprlkUQ
         WZPO5W6S/Zhoq73xibD3Bunn9SGQaSOuFflnbkM0jw2p7xT9B1yyozaL4LWsPjrHEGm+
         wHF8DqO/xqdeD3oDPoccFBUHGDHy3O1h7k1EMH1ZmtCRIZpFqS38mstnHdk66dx7WNSW
         YzM+SLdmppsIsvv0ZXquaqEooKGXkKAyCemjvvgK5fcFWTt6cVq7bmJAYvmKGJxKCVLf
         T6FxIwDhHwBOPhmIhtRKSG/ok73ncTt7+5RRYS/CkNHJ6cL+Eunc3dNmWePZES2NNlBS
         RiAw==
X-Forwarded-Encrypted: i=1; AJvYcCUnl5jGqVBxoyq0S/nO8amGGxjDzsT+HXXjIRCIxeLsREyaqF1gGcgCL8oFcRFgxeRKMRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WT55TaGdRwKXQwVJFWp96JgbSJQSOGEVhVhFzIghOs5Eq6uD
	EXNvfZLOpH+/qalm9W4/cYakQtKJaVLpWuS9AD3fOpvKNl1kRwD8xCsIuq6H36Cr
X-Gm-Gg: AZuq6aK+C6cFiuVQdbjFHrckYZuivSIcukD7ePE7SJU7+4Buanf3TVcMHeZ5Ae92wV5
	eqLWAyGdeau0L46MNVlJ4iH2W73KkJODbQa+eVY9PyEVrRMfhnj5fsiMCGM7vyvW7rS344KNsqc
	1ZLlYBzwAM0M4/9iJaU6Fem+Zw8Xn2rL/mWJLm8o4KG1SUcm9zR+RllyeA3gVhaSIuAcoQIh85Q
	gMQM8c41QaNvzwAAPRW9Zr2zTb3hugJRdAMNY/lWYBOKQs4NuPzsnsFGysvg8oFjytGz9zl+Ac3
	vcnFRI2aUzwZT6N/NcCq95poqr/JZ7MkYlBHxYt3hyElFskP48QcuzY34fNmjmFmXdOQjpgfRkE
	pkXltJg9Ef8XdA2JqYdSyaSbH3SonhPEKEWtjoaIRHjIwHggO97Ssj+dmYY1Yr57zovqTF+kJxn
	SAoixhgveYmlV85iWGXZMH5zlllSObJqt11xL/6iz28WX40OzQxShKh8l7V6ZLIW503SWM0ea4r
	WAx0FgxOA==
X-Received: by 2002:a5d:5f82:0:b0:435:e460:235b with SMTP id ffacd0b85a97d-436293800admr25979703f8f.59.1770820380905;
        Wed, 11 Feb 2026 06:33:00 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:b997])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e39c75sm4973747f8f.29.2026.02.11.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 06:33:00 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v5 2/5] io_uring/bpf-ops: implement loop_step with BPF struct_ops
Date: Wed, 11 Feb 2026 14:32:41 +0000
Message-ID: <2bd493f5b24df63f19499f0d65e5349c440e5d9c.1770818588.git.asml.silence@gmail.com>
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

Introduce io_uring BPF struct ops implementing the loop_step callback,
which will allow BPF to overwrite the default io_uring event loop logic.

The callback takes an io_uring context, the main role of which is to be
passed to io_uring kfuncs. The other argument is a struct iou_loop_params,
which BPF can use to request CQ waiting and communicate other parameters.
See the event loop description in the previous patch for more details.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/Kconfig    |   5 ++
 io_uring/Makefile   |   1 +
 io_uring/bpf-ops.c  | 127 ++++++++++++++++++++++++++++++++++++++++++++
 io_uring/bpf-ops.h  |  14 +++++
 io_uring/io_uring.c |   1 +
 5 files changed, 148 insertions(+)
 create mode 100644 io_uring/bpf-ops.c
 create mode 100644 io_uring/bpf-ops.h

diff --git a/io_uring/Kconfig b/io_uring/Kconfig
index a7ae23cf1035..a283d9e53787 100644
--- a/io_uring/Kconfig
+++ b/io_uring/Kconfig
@@ -14,3 +14,8 @@ config IO_URING_BPF
 	def_bool y
 	depends on BPF
 	depends on NET
+
+config IO_URING_BPF_OPS
+	def_bool y
+	depends on IO_URING
+	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
diff --git a/io_uring/Makefile b/io_uring/Makefile
index 1c1f47de32a4..c54e328d1410 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_NET) += net.o cmd_net.o
 obj-$(CONFIG_PROC_FS) += fdinfo.o
 obj-$(CONFIG_IO_URING_MOCK_FILE) += mock_file.o
 obj-$(CONFIG_IO_URING_BPF) += bpf_filter.o
+obj-$(CONFIG_IO_URING_BPF_OPS) += bpf-ops.o
diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
new file mode 100644
index 000000000000..7db07eda5a48
--- /dev/null
+++ b/io_uring/bpf-ops.c
@@ -0,0 +1,127 @@
+#include <linux/mutex.h>
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+
+#include "io_uring.h"
+#include "register.h"
+#include "bpf-ops.h"
+#include "loop.h"
+
+static const struct btf_type *loop_params_type;
+
+static int io_bpf_ops__loop_step(struct io_ring_ctx *ctx,
+				 struct iou_loop_params *lp)
+{
+	return IOU_LOOP_STOP;
+}
+
+static struct io_uring_bpf_ops io_bpf_ops_stubs = {
+	.loop_step = io_bpf_ops__loop_step,
+};
+
+static bool bpf_io_is_valid_access(int off, int size,
+				    enum bpf_access_type type,
+				    const struct bpf_prog *prog,
+				    struct bpf_insn_access_aux *info)
+{
+	if (type != BPF_READ)
+		return false;
+	if (off < 0 || off >= sizeof(__u64) * MAX_BPF_FUNC_ARGS)
+		return false;
+	if (off % size != 0)
+		return false;
+
+	return btf_ctx_access(off, size, type, prog, info);
+}
+
+static int bpf_io_btf_struct_access(struct bpf_verifier_log *log,
+				    const struct bpf_reg_state *reg, int off,
+				    int size)
+{
+	const struct btf_type *t = btf_type_by_id(reg->btf, reg->btf_id);
+
+	if (t == loop_params_type) {
+		if (off >= offsetof(struct iou_loop_params, cq_wait_idx) &&
+		    off + size <= offsetofend(struct iou_loop_params, cq_wait_idx))
+			return SCALAR_VALUE;
+	}
+
+	return -EACCES;
+}
+
+static const struct bpf_verifier_ops bpf_io_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
+	.is_valid_access = bpf_io_is_valid_access,
+	.btf_struct_access = bpf_io_btf_struct_access,
+};
+
+static const struct btf_type *
+io_lookup_struct_type(struct btf *btf, const char *name)
+{
+	s32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, name, BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return NULL;
+	return btf_type_by_id(btf, type_id);
+}
+
+static int bpf_io_init(struct btf *btf)
+{
+	loop_params_type = io_lookup_struct_type(btf, "iou_loop_params");
+	if (!loop_params_type) {
+		pr_err("io_uring: Failed to locate iou_loop_params\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bpf_io_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	return 0;
+}
+
+static int bpf_io_init_member(const struct btf_type *t,
+			       const struct btf_member *member,
+			       void *kdata, const void *udata)
+{
+	return 0;
+}
+
+static int bpf_io_reg(void *kdata, struct bpf_link *link)
+{
+	return -EOPNOTSUPP;
+}
+
+static void bpf_io_unreg(void *kdata, struct bpf_link *link)
+{
+}
+
+static struct bpf_struct_ops bpf_ring_ops = {
+	.verifier_ops = &bpf_io_verifier_ops,
+	.reg = bpf_io_reg,
+	.unreg = bpf_io_unreg,
+	.check_member = bpf_io_check_member,
+	.init_member = bpf_io_init_member,
+	.init = bpf_io_init,
+	.cfi_stubs = &io_bpf_ops_stubs,
+	.name = "io_uring_bpf_ops",
+	.owner = THIS_MODULE,
+};
+
+static int __init io_uring_bpf_init(void)
+{
+	int ret;
+
+	ret = register_bpf_struct_ops(&bpf_ring_ops, io_uring_bpf_ops);
+	if (ret) {
+		pr_err("io_uring: Failed to register struct_ops (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+__initcall(io_uring_bpf_init);
diff --git a/io_uring/bpf-ops.h b/io_uring/bpf-ops.h
new file mode 100644
index 000000000000..e8a08ae2df0a
--- /dev/null
+++ b/io_uring/bpf-ops.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef IOU_BPF_OPS_H
+#define IOU_BPF_OPS_H
+
+#include <linux/io_uring_types.h>
+
+struct io_uring_bpf_ops {
+	int (*loop_step)(struct io_ring_ctx *ctx, struct iou_loop_params *lp);
+
+	__u32 ring_fd;
+	void *priv;
+};
+
+#endif /* IOU_BPF_OPS_H */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 52f9a5c766c1..1f7c03728083 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -87,6 +87,7 @@
 #include "msg_ring.h"
 #include "memmap.h"
 #include "zcrx.h"
+#include "bpf-ops.h"
 
 #include "timeout.h"
 #include "poll.h"
-- 
2.52.0

