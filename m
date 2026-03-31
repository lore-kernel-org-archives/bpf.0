Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FD369234
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978005; cv=none; b=gRpW8XI6D7r8+rsWuhoexRv87DUk5a2cE2DO7hHZzIS6yLP+dzc08JBrs3eIvPuA+tIjcl6KxXsjOR45uRY13E7xHKfFcsIzVKqfZbSA468WZbj4nXQgyNWCJc38WdRbquswMArkxPsnDcIKn0dXVYBzslkyzp/SLJx+/5uJ8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978005; c=relaxed/simple;
	bh=OBdlpBeEi79UodujR7gwKGv87ZeIOxfk1NuulGfm+eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qre3DahIP4A9F5US46rafWdh9mSdHjPFptRVVQ606sVEXEeDn/U5WXGdWZRNUu+lgROyhfbwN3wlhW6PRB47UhGd0AIyLr8uNAiDebBUkzQO7xcXYlJ/RRKAGfwm0LMVAS8L1+ShDbDTocOhmUN3tr5uVVpNmEL/t3aYtmC85OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdEjnvn0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdEjnvn0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48704db565eso74796045e9.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774978002; x=1775582802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmd2CeGXlQYIPx+y80UEttpsxYUwGrUWnqDpUBs9UfI=;
        b=IdEjnvn0Iccmdp7Icv3M0V79GE88mmMg5RpAwZsIF2GaJdVRNa+R2C5e+leINWGfUH
         cuFxH/o5VG1396l/EpjuKhJDpWj6YStOWcZRpYuZffWgzE5QOA9q1/9KbNCh2TVFLRXN
         hddMTA6qbOk8HraheimU9Zz6XAlaqkd5uFV9S+QXp/oTRKatqlC82idRXaje6/n9+qo7
         bCvgzKfakZUQwYhhWW0t1Y4aORJedHMxJSm66BzrxBb7r3Y8PyFSe+/B+DKzB/oRIC5F
         vLzlhfrnXmbFBYo/x9SC97DURyMlyScxuENAJVYb62wI9PdcCQeYc5PcbU7QP3ovq57o
         jyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774978002; x=1775582802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mmd2CeGXlQYIPx+y80UEttpsxYUwGrUWnqDpUBs9UfI=;
        b=Ep8QywG/5BNWoz8d8qRY000kE4+9HNcptB3xvQrSd6V6l7Z5XqqRMrD+LNDbcPW2xl
         GRAq9eCWa2iYrD9gh261Z5BerzUn8Ne2/9npD5vSNoSRakVOGstO3oMl7C4HgC4AEWRa
         tMzQdXA4eZ112t3Us7fRFEfE9eI8B+NcGYFpb/OpojbEmWCc8hp8GkDO4Prf4NEA2bay
         LNwOlQ1gSTLEjcT9jBmGm4r1NOxDnkbgeIJYHJUpnrH8fg/Ev+EChDVQ2krYO5SzeMFo
         8zcGAtgTxbEjzUYgxUCiHldHcVnvKcGYbBpzglHvpthZFv8F3KMY4AVQdGUHE31Ejzyd
         FZHw==
X-Gm-Message-State: AOJu0YzDQPnPsa6bXzklSMQeIT8O8+4mabt+BTbooFVzcU+K9KxUlyr1
	FPgsyuKwcCkYecZReun7767rWi0i9sXgVAZgkiytEG/GOuEQgTiA3LO0UzAIjTFr
X-Gm-Gg: ATEYQzzfrh4NXsKGctlp62iw2itc/gVifQFZeBO3WRhREnsFG9rcqZsc8+aF4T6ihj8
	Du+1X53m43PcnWW/dNc0aMzSAzPV8QpOcVmo01RRDnjSA3QuJSiBjI2M/40BfDjIbOqMvty5Cbh
	PKirhc+i5L4mW25ZcFSqUlbIB97R3njFK+D5q5S9LNwowfjBhagU6jm8aSeowhcjztU2nQCdXUK
	YwLpgSz+TtYQ0PnSoWYyQZ7omiO/0kQSN+eycb1+hwqi/M+LVhtn7r3QATwSAEaDG3UzqVa4HQQ
	Qv2o/BMrHpTvBLApcYUaio/sx5CdfgxEruIFWzaLSD73+4d6zatpMDxFDaekGGNghqFw0Ntu5BE
	w9sjShudd3wGxV9UPny89LYQbwF9D3KU61ddCe2PqXYnUPcI6tHVy/qOPdCKQ+yOEf6UE3wQPih
	WFUMt/fXYEHa2ELCV5PEa9uLW5tmRz4PC8x944msMinoKG
X-Received: by 2002:a05:600c:19d0:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-488835626a8mr3881215e9.9.1774978001856;
        Tue, 31 Mar 2026 10:26:41 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c536a7fsm51668975e9.1.2026.03.31.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:26:41 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 1/2] libbpf: Fix BTF handling in bpf_program__clone()
Date: Tue, 31 Mar 2026 18:26:33 +0100
Message-ID: <20260331172634.57402-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Align bpf_program__clone() with bpf_object_load_prog() by gating
BTF func/line info on FEAT_BTF_FUNC kernel support, and resolve
caller-provided prog_btf_fd before checking obj->btf so that callers
with their own BTF can use clone() even when the object has no BTF
loaded.

While at it, treat func_info and line_info fields as atomic groups
to prevent mismatches between pointer and count from different sources.

Move bpf_program__clone() to libbpf 1.8.

Fixes: 970bd2dced35 ("libbpf: Introduce bpf_program__clone()")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c   | 66 ++++++++++++++++++++++++++--------------
 tools/lib/bpf/libbpf.map |  2 +-
 2 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ea41f40dc82..d1358ca0a15a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9852,7 +9852,7 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, attr);
 	struct bpf_object *obj;
-	int err, fd;
+	int err, fd, prog_btf_fd;
 
 	if (!prog)
 		return libbpf_err(-EINVAL);
@@ -9865,8 +9865,9 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 		return libbpf_err(-EINVAL);
 
 	/*
-	 * Caller-provided opts take priority; fall back to
-	 * prog/object defaults when the caller leaves them zero.
+	 * Caller-provided opts take priority; fall back to prog/object defaults when the
+	 * caller leaves them zero. 0/NULL means "use default". Callers cannot explicitly
+	 * clear an inherited non-zero value by passing 0.
 	 */
 	attr.attach_prog_fd = OPTS_GET(opts, attach_prog_fd, 0) ?: prog->attach_prog_fd;
 	attr.prog_flags = OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags;
@@ -9878,27 +9879,45 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 	if (attr.token_fd)
 		attr.prog_flags |= BPF_F_TOKEN_FD;
 
-	/* BTF func/line info */
-	if (obj->btf && btf__fd(obj->btf) >= 0) {
-		attr.prog_btf_fd = OPTS_GET(opts, prog_btf_fd, 0) ?: btf__fd(obj->btf);
-		attr.func_info = OPTS_GET(opts, func_info, NULL) ?: prog->func_info;
-		attr.func_info_cnt = OPTS_GET(opts, func_info_cnt, 0) ?: prog->func_info_cnt;
-		attr.func_info_rec_size =
-			OPTS_GET(opts, func_info_rec_size, 0) ?: prog->func_info_rec_size;
-		attr.line_info = OPTS_GET(opts, line_info, NULL) ?: prog->line_info;
-		attr.line_info_cnt = OPTS_GET(opts, line_info_cnt, 0) ?: prog->line_info_cnt;
-		attr.line_info_rec_size =
-			OPTS_GET(opts, line_info_rec_size, 0) ?: prog->line_info_rec_size;
+	prog_btf_fd = OPTS_GET(opts, prog_btf_fd, 0);
+	if (!prog_btf_fd && obj->btf)
+		prog_btf_fd = btf__fd(obj->btf);
+
+	/* BTF func/line info: only pass if kernel supports it */
+	if (kernel_supports(obj, FEAT_BTF_FUNC) && prog_btf_fd > 0) {
+		attr.prog_btf_fd = prog_btf_fd;
+
+		/* Treat func_info fields as an atomic group */
+		if (OPTS_GET(opts, func_info, NULL)) {
+			attr.func_info = OPTS_GET(opts, func_info, NULL);
+			attr.func_info_cnt = OPTS_GET(opts, func_info_cnt, 0);
+			attr.func_info_rec_size = OPTS_GET(opts, func_info_rec_size, 0);
+		} else {
+			attr.func_info = prog->func_info;
+			attr.func_info_cnt = prog->func_info_cnt;
+			attr.func_info_rec_size = prog->func_info_rec_size;
+		}
+
+		/* Treat line_info fields as an atomic group */
+		if (OPTS_GET(opts, line_info, NULL)) {
+			attr.line_info = OPTS_GET(opts, line_info, NULL);
+			attr.line_info_cnt = OPTS_GET(opts, line_info_cnt, 0);
+			attr.line_info_rec_size = OPTS_GET(opts, line_info_rec_size, 0);
+		} else {
+			attr.line_info = prog->line_info;
+			attr.line_info_cnt = prog->line_info_cnt;
+			attr.line_info_rec_size = prog->line_info_rec_size;
+		}
 	}
 
+	/* Logging is caller-controlled; no fallback to prog/obj log settings */
 	attr.log_buf = OPTS_GET(opts, log_buf, NULL);
 	attr.log_size = OPTS_GET(opts, log_size, 0);
 	attr.log_level = OPTS_GET(opts, log_level, 0);
 
 	/*
-	 * Fields below may be mutated by prog_prepare_load_fn:
-	 * Seed them from prog/obj defaults here;
-	 * Later override with caller-provided opts.
+	 * Fields below may be mutated by prog_prepare_load_fn(). Seed them from prog/obj
+	 * defaults here; re-apply caller overrides afterwards
 	 */
 	attr.expected_attach_type = prog->expected_attach_type;
 	attr.attach_btf_id = prog->attach_btf_id;
@@ -9910,16 +9929,19 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 			return libbpf_err(err);
 	}
 
-	/* Re-apply caller overrides for output fields */
+	/* Re-apply caller overrides for fields that prog_prepare_load_fn may have modified */
 	if (OPTS_GET(opts, expected_attach_type, 0))
-		attr.expected_attach_type =
-			OPTS_GET(opts, expected_attach_type, 0);
+		attr.expected_attach_type = OPTS_GET(opts, expected_attach_type, 0);
 	if (OPTS_GET(opts, attach_btf_id, 0))
 		attr.attach_btf_id = OPTS_GET(opts, attach_btf_id, 0);
 	if (OPTS_GET(opts, attach_btf_obj_fd, 0))
-		attr.attach_btf_obj_fd =
-			OPTS_GET(opts, attach_btf_obj_fd, 0);
+		attr.attach_btf_obj_fd = OPTS_GET(opts, attach_btf_obj_fd, 0);
 
+	/*
+	 * Unlike bpf_object_load_prog(), we intentionally do not call bpf_prog_bind_map()
+	 * for RODATA maps here to avoid mutating the object's state. Callers can bind the
+	 * required maps themselves using bpf_prog_bind_map().
+	 */
 	fd = bpf_prog_load(prog->type, prog->name, obj->license, prog->insns, prog->insns_cnt,
 			   &attr);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 346fd346666b..dfed8d60af05 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -452,12 +452,12 @@ LIBBPF_1.7.0 {
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
 		bpf_prog_assoc_struct_ops;
-		bpf_program__clone;
 		bpf_program__assoc_struct_ops;
 		btf__permute;
 } LIBBPF_1.6.0;
 
 LIBBPF_1.8.0 {
 	global:
+		bpf_program__clone;
 		btf__new_empty_opts;
 } LIBBPF_1.7.0;
-- 
2.52.0

