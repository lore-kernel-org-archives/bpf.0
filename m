Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF43280317
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855857; cv=none; b=qvRhBeCW/xTJ1JSFkain7IVHYhxlP+Gi1nxT+tCyFPVDHkvGRow4Wu3gXRGIL/u0/i5+yc6/I5D8Vth9Fv+FaO7nC8+67H8Ja/EUokDOSRSMbEhMRqQqVHb1ouJXjSU6geMpqiSabou+CWljy5ZGiDNbu9ZbsAJkbx7Je4eFTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855857; c=relaxed/simple;
	bh=2ZcR9zAA+ijCun56ms8GzK5P5WiOGsy+pTvH1/xiMto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGWI6f1YjfEUCNMyPjITtHaLvizmMDe/O9BBnWdvgOk34vfB5aLvmha4ZlYlTSQCVv8ehwq5y+5doiKMtOWXuac0DsnDT7/9GYOX8rqvH5YVh4TeYaElMQLxQUqH3qfZ3odK5sAyCBGBdVSuTeaO8GVqiFu+5ITKewZiwi6Lhxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbkmaR9E; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbkmaR9E"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so2793722f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855854; x=1772460654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQvbDRlp6zr7sqW0Cbja8/AWgExmrJVPBZ7Jd+Q7MAs=;
        b=IbkmaR9EudHgC533Ym9AddriN9mk1ADfGbTbaFdBnSNjig6NSehogxEuFHOrci2fet
         Cacq7IgNjJwcUoLpCTrFSb/sgMnBMugl+hT88mwbiKSA8i54AGD77/L9jhm9PUz3nMTZ
         hc72j83i7l9CsK2b+efrqIZz4yiR8l4xTtNqsTgtGZKj9dSBJn9wKqbn1CBLLm4//j37
         nNdT41OhbuQRvLnkTsn7YvLarEm+x3EZdRkDcb3w711KD6ukzrjI8sXeuGnt+LD19MIa
         uhfMFNW1/GeBKEQRnYbRZnAM7vBrLvWtUQfOsmZYyDlPm3BmARCAP7Dzmy6qmPkXgtjY
         mZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855854; x=1772460654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hQvbDRlp6zr7sqW0Cbja8/AWgExmrJVPBZ7Jd+Q7MAs=;
        b=wZVUC+QVn/8rAH/6is4rHSqet6s4OsHZvznqaoge47DFNR2LhmDmfjOQiXZ0lRHqu/
         fT0Ec0zkCSMWl1w1XnjlDYqRVaVvdMI3zgQbULOUpxVqzrg6UshI+k82jbyd1R98SVeX
         19qDcGxTb2Giqtmb0skizcim/aTwYbX68y0VDDEMPudl/qLsRRtrVWK2EdQdH0rEacsq
         HXUKRdZQjbQKi1aAig2OCB61nUUB0EwziiiSC+lkM+g2r6EfJJWQyY+7fzie2Oeb7Tz/
         1ClXyNSOu659F0SMfLF3E0tFQhF60ezMFz5KMfmwjmkWLXQqCLy+PVdKOvFkVN9A/x0W
         GJxw==
X-Forwarded-Encrypted: i=1; AJvYcCXfJ+zXoAj0ZnCp5vYHKqsBI1dTbKk9w/BXyHcYhNc3CI1zOJpV9Jvl6Aj1s4WJ6lRtmKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2UlBNR+vfPilvZu8NvaxZBAvaK5yxWCeLeI5cWiTqj5d4mou
	pLENiSiah/XDMtTQR9g6Ftd+h9lw5ko51N8bNdEFw3nvE3LK0daJ18tG
X-Gm-Gg: ATEYQzzVgU9X8FpV34nx8OzKXri8CurDthgDr9H4ovWG8Ls4IbQ2lmHk6oFPwkwbSxN
	SBYWvqweBFVPAZ6+sVxqxqff+8cIL9gxdxvaXERspNLBNFVUSSmzgieDeM0acCH6pKlJE2JXHE3
	vyOXga9pe/ZxM+RlolqDYnY0SgatdY/UHV1iJH/6ueNpkPuGwnW7ynf3pRJFGeI7jTfVBL1JF19
	ggh1WdSAJzmcF4IsATwnVdsG4rh8JrxMRBDJLFg3HDOnhzUVt6ZFcWsZQl0DddK4pcIimspyyiS
	/Op4hLvT027zuIHA5q5TfDtrKsaTDcGtS/+SWoYtHsYQSsxnNWYOTfXuqXNsEH0BFFVhpcdaNKg
	Ap/ofh8rrV9LpIB5St0IGzWT/C7PE0HpvL+4I8xdgb4IJte6ViXsLmqbqTgr4LNQyAtpb4A+Zt6
	+PirX6m2+GpTQ4d9SLVUMeb2iOGMdMrY0Y7lAsvJldbceXQ0uqiObs+tVR9uEHPvOMo5p1qik2F
	hygvQiwfQ==
X-Received: by 2002:a05:6000:1883:b0:437:893f:3361 with SMTP id ffacd0b85a97d-4396f15ae17mr15852198f8f.20.1771855854172;
        Mon, 23 Feb 2026 06:10:54 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm19464640f8f.6.2026.02.23.06.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:10:53 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v9 10/10] io_uring/selftests: test BPF [un]registration
Date: Mon, 23 Feb 2026 14:10:21 +0000
Message-ID: <6015650200dd82a41a50b0b23fd30f57b76a6203.1771855761.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771855760.git.asml.silence@gmail.com>
References: <cover.1771855760.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure BPF registration and unregistration leave io_uring in the
right state.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 tools/testing/selftests/io_uring/Makefile     |  2 +-
 .../testing/selftests/io_uring/common-defs.h  |  4 +
 tools/testing/selftests/io_uring/unreg.bpf.c  | 25 +++++
 tools/testing/selftests/io_uring/unreg.c      | 92 +++++++++++++++++++
 4 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/io_uring/unreg.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/unreg.c

diff --git a/tools/testing/selftests/io_uring/Makefile b/tools/testing/selftests/io_uring/Makefile
index 77df197449ef..37f50acdba37 100644
--- a/tools/testing/selftests/io_uring/Makefile
+++ b/tools/testing/selftests/io_uring/Makefile
@@ -3,7 +3,7 @@ include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
-TEST_GEN_PROGS := nops_loop overflow
+TEST_GEN_PROGS := nops_loop overflow unreg
 
 # override lib.mk's default rules
 OVERRIDE_TARGETS := 1
diff --git a/tools/testing/selftests/io_uring/common-defs.h b/tools/testing/selftests/io_uring/common-defs.h
index 948453c90375..9a44e0687436 100644
--- a/tools/testing/selftests/io_uring/common-defs.h
+++ b/tools/testing/selftests/io_uring/common-defs.h
@@ -24,4 +24,8 @@ struct nops_state {
 	int		reqs_left;
 };
 
+struct unreg_state {
+	unsigned	times_invoked;
+};
+
 #endif /* IOU_TOOLS_COMMON_DEFS_H */
diff --git a/tools/testing/selftests/io_uring/unreg.bpf.c b/tools/testing/selftests/io_uring/unreg.bpf.c
new file mode 100644
index 000000000000..e872915b09dd
--- /dev/null
+++ b/tools/testing/selftests/io_uring/unreg.bpf.c
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/types.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "vmlinux.h"
+#include "common-defs.h"
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+SEC("struct_ops.s/unreg_loop_step")
+int BPF_PROG(unreg_loop_step, struct io_ring_ctx *ring,
+			      struct iou_loop_params *ls)
+{
+	struct unreg_state *us;
+
+	us = (void *)bpf_io_uring_get_region(ring, IOU_REGION_MEM, sizeof(*us));
+	if (us)
+		us->times_invoked++;
+	return IOU_LOOP_STOP;
+}
+
+SEC(".struct_ops.link")
+struct io_uring_bpf_ops unreg_ops = {
+	.loop_step = (void *)unreg_loop_step,
+};
diff --git a/tools/testing/selftests/io_uring/unreg.c b/tools/testing/selftests/io_uring/unreg.c
new file mode 100644
index 000000000000..43076681999f
--- /dev/null
+++ b/tools/testing/selftests/io_uring/unreg.c
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Test BPF registration / unregistration works and doesn't leave a dangling
+ * function pointer.
+ */
+#include <linux/stddef.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdlib.h>
+
+#include <bpf/libbpf.h>
+#include <io_uring/mini_liburing.h>
+
+#include "helpers.h"
+#include "unreg.bpf.skel.h"
+
+static struct unreg *load_unreg(struct ring_ctx *ctx)
+{
+	struct unreg *skel;
+	int ret;
+
+	skel = unreg__open();
+	if (!skel) {
+		fprintf(stderr, "can't generate skeleton\n");
+		exit(1);
+	}
+
+	skel->struct_ops.unreg_ops->ring_fd = ctx->ring.ring_fd;
+
+	ret = unreg__load(skel);
+	if (ret) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
+	return skel;
+}
+
+int main()
+{
+	struct bpf_link *link1, *link2;
+	struct unreg *skel1, *skel2;
+	struct unreg_state *us;
+	struct ring_ctx ctx;
+
+	ring_ctx_create(&ctx, sizeof(struct unreg_state));
+	us = ctx.region;
+
+	skel1 = load_unreg(&ctx);
+	skel2 = load_unreg(&ctx);
+
+	link1 = bpf_map__attach_struct_ops(skel1->maps.unreg_ops);
+	if (!link1) {
+		fprintf(stderr, "failed to attach ops\n");
+		return 1;
+	}
+
+	ring_ctx_run(&ctx);
+	if (us->times_invoked != 1) {
+		fprintf(stderr, "failed to run BPF\n");
+		return 1;
+	}
+
+	/* remove the program and give the kernel time to actually destroy it */
+	bpf_link__destroy(link1);
+	unreg__destroy(skel1);
+	sleep(1);
+
+	ring_ctx_run(&ctx);
+	if (us->times_invoked != 1) {
+		fprintf(stderr, "Executed removed BPF\n");
+		return 1;
+	}
+
+	/* try to attach another program */
+	link2 = bpf_map__attach_struct_ops(skel2->maps.unreg_ops);
+	if (!link2) {
+		fprintf(stderr, "failed to reattach ops\n");
+		return 1;
+	}
+
+	ring_ctx_run(&ctx);
+	if (us->times_invoked != 2) {
+		fprintf(stderr, "failed to run reattached BPF\n");
+		return 1;
+	}
+
+	bpf_link__destroy(link2);
+	unreg__destroy(skel2);
+	ring_ctx_destroy(&ctx);
+	return 0;
+}
-- 
2.53.0

