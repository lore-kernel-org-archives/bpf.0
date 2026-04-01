Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A646AEDF
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056612; cv=none; b=ADGJx/7LjTarfIplc1jtNgPMC9yy4izDt2g70uyXI7xSGBrxjc0HvST6+lbhvp/Y/X8IBLfmfUpibXj8k24oIepaecK7Xn/dyKIJGhOZHfv6wzEqenf8IlGcPgBbpC+kMbUZok/5wH0q6wsikMjMCwWAd1gfo5ra1Qu/I2hUOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056612; c=relaxed/simple;
	bh=uAnOsoSOWMZrjwjPcfGuJYo99ngNE31MrBXJ5o2jerQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQjZ3FPeYfxxPe900B3YargT5sV2A2JKOu3QSzUE56gJG85F0YyiuXt99gbg+T6gToMipD9SbX2MFVUlHkeytNe8SQDqZeKwNS/Zlxtq+Hr8uB72Oq6UqR9H0qCiqMX6WyTEY83DrsxOiBRSlja6gnyw5DC9NPmCiK0ew6rtvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f92pBcyP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f92pBcyP"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso2514775f8f.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775056609; x=1775661409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ijWKtXv0+xTneQWS/mu4atANaDzJjRgEPle+iQlO2U0=;
        b=f92pBcyPD9Ix6wUUK42u3ctDuNq3rY4riRrcP0uyHnJzK9jy6Shb+8QX5lvEzrlBus
         zAq8JjMyef4nnR8VsoIwfUecbeIUxjpJsTMX6+b/BdMjIlzBmTpPaVXmVtAkvQi2GoZT
         hNWpq197FunamCw/4w87CCKGCwu+QHQyD4l5xaZ8pVpjnzTjPb67k8FFwQ0w6mLvJ60W
         oeHdzPAR5v4Msq4lIztF/wo3yvmwMdH36QqQ6kaCF2cjvSkEJdHWeukvq4ftndgql6Jt
         qfIuRxkZ9xq4aKRfjx1gMQavp+qTfKU02EjncKybdYRPgKQdajoIgFf+F1YIQCyqRRCH
         RISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056609; x=1775661409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijWKtXv0+xTneQWS/mu4atANaDzJjRgEPle+iQlO2U0=;
        b=hWKziJEioLRKgTkg8O2rNcPZPA1K+w+GBIR6zbViAT6nWmB8nH5CE5rHEAbzX766eo
         JgAE1TSamySuRa9TtWWme6+1SdmXoY+41nukQm7/dxP5gpdVqe6bPmzqt+/EmsJ0NBVm
         0FyBTAt1VVaP5hUPIgtpHrLOFqnnxCe17k40uxyL4RWQjhzqwK/H/vefkH/BonJWUP6G
         J25gspxKxWm0dWBsi3rIZlGrl7vCP9lFJ131DGcN8+kS+lPnFgk2XVX5cQtjkn25tC3P
         vBRGdDNV3Q+oPAL9vWVhIeJm0+3OeB1TdUE4U1gYl/W6g4a7nnJRgKN+XFtdkIzkxatN
         dBOg==
X-Gm-Message-State: AOJu0YyFrBeg7PkQhv7voxB3SDNiBCRtM6QtXAW+tFrDJWrdacUH8rWa
	4a22mBnWZ7gzAIdDR2VY3qDxMsDxPAgJSHX9PYXp8uypMIv/BbP1/1ZYj/fC2ahh
X-Gm-Gg: ATEYQzwe+NvKlKSq0koGMDWQAyUQFHz++noPtilMNhsfHaciGdnt9PhW4JOsROdG/xH
	uuoONF7J4QlccjH0QE8VSNdFodC5KCjk9hl39tElryYQay+3pyNXUUvXYngzZoqc2S1fnG4j6Cp
	7iT8JUVQ0I5M1D4EWON2BlPkHKVrBJ7XHeriStd/YPo+D+vdcAYGjo1sVIHnvNJm31YdY2XH1iQ
	3NndNTgiQVQl+kFoQ5ZQ0aUJiuDTjBAWRmH6jitQ2knFPEnAHfLGY2ey8imQ53jgzMpkdUfS46V
	4EVcp5iNljmr5yjVXkoZBwysFFitjKa/ikiMuo1md7dNHk/AXIYkSzzlZm1XEnxdh3c2t+dkOAa
	6e00a7Rr3/JumcyGgLymn/aPdRBDHLvjCeJ0mrjuGrNSO8QGmKOS4b4vQYRhzqOAsxJpblL8ewp
	Ef8+kZDK7yZ1gCTqI=
X-Received: by 2002:a05:6000:402a:b0:43b:4d37:cd37 with SMTP id ffacd0b85a97d-43d1504d681mr7506592f8f.7.1775056609070;
        Wed, 01 Apr 2026 08:16:49 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:b4a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e1a9asm513149f8f.28.2026.04.01.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 08:16:48 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] libbpf: Fix BTF handling in bpf_program__clone()
Date: Wed,  1 Apr 2026 16:16:40 +0100
Message-ID: <20260401151640.356419-1-mykyta.yatsenko5@gmail.com>
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
v1 -> v2:
 * All or nothing logic for info/line_info triples
v1: https://lore.kernel.org/all/20260331172634.57402-1-mykyta.yatsenko5@gmail.com/
---
 tools/lib/bpf/libbpf.c   | 59 +++++++++++++++++++++++++++++-----------
 tools/lib/bpf/libbpf.map |  2 +-
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ea41f40dc82..589085466903 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9852,7 +9852,9 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, attr);
 	struct bpf_object *obj;
-	int err, fd;
+	const void *info;
+	__u32 info_cnt, info_rec_size;
+	int err, fd, prog_btf_fd;
 
 	if (!prog)
 		return libbpf_err(-EINVAL);
@@ -9878,19 +9880,41 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
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
+		/* func_info/line_info triples: all-or-nothing from caller */
+		info = OPTS_GET(opts, func_info, NULL);
+		info_cnt = OPTS_GET(opts, func_info_cnt, 0);
+		info_rec_size = OPTS_GET(opts, func_info_rec_size, 0);
+		if (!!info != !!info_cnt || !!info != !!info_rec_size) {
+			pr_warn("prog '%s': func_info, func_info_cnt, and func_info_rec_size must all be specified or all omitted\n",
+				prog->name);
+			return libbpf_err(-EINVAL);
+		}
+		attr.func_info = info ?: prog->func_info;
+		attr.func_info_cnt = info ? info_cnt : prog->func_info_cnt;
+		attr.func_info_rec_size = info ? info_rec_size : prog->func_info_rec_size;
+
+		info = OPTS_GET(opts, line_info, NULL);
+		info_cnt = OPTS_GET(opts, line_info_cnt, 0);
+		info_rec_size = OPTS_GET(opts, line_info_rec_size, 0);
+		if (!!info != !!info_cnt || !!info != !!info_rec_size) {
+			pr_warn("prog '%s': line_info, line_info_cnt, and line_info_rec_size must all be specified or all omitted\n",
+				prog->name);
+			return libbpf_err(-EINVAL);
+		}
+		attr.line_info = info ?: prog->line_info;
+		attr.line_info_cnt = info ? info_cnt : prog->line_info_cnt;
+		attr.line_info_rec_size = info ? info_rec_size : prog->line_info_rec_size;
 	}
 
+	/* Logging is caller-controlled; no fallback to prog/obj log settings */
 	attr.log_buf = OPTS_GET(opts, log_buf, NULL);
 	attr.log_size = OPTS_GET(opts, log_size, 0);
 	attr.log_level = OPTS_GET(opts, log_level, 0);
@@ -9912,14 +9936,17 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 
 	/* Re-apply caller overrides for output fields */
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

