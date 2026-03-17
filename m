Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678D337B81
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769185; cv=none; b=PAtCuPlqMOSAuYCfqt6NFMtFP0Pcy+HdluxFV1ZfUfW1PnEPAYTM4JaLAY4to4UpwYzuHApENVu9TzFoKo4sz4Uj3TYptx32tduJ3iLJtXKu+vJZjrObCOLTHxVcCEU8poCHnvlP3LqW1QNZHy/+LrqZF556AC2DCYNaTqQIBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769185; c=relaxed/simple;
	bh=R+0IywjtBhWBmhzlyQIgI+PyYCOkxoGjdcE7Zn72U4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmxh56MCzYPz1LLQkEOe/N9wF5bvrfgQeSAymTJ0CCt2Dl1O8OucCXJnj6noMqpdo94OfHKhBSZw7rDNtFFp2OpD5Gz7bRb4oFzDupkhTIivsCuXAsEQqBQpSIPbCWTZG682h7NwO/Fs+BID3Nz49TisyavGFjFw3/LnBXvAUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeyvbxGE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeyvbxGE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48538c5956bso1247645e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773769182; x=1774373982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOa0THwiOISyWRpaVdtklSJLjJnmfGR+A8nH9FsP7C8=;
        b=LeyvbxGEQltnENB20dItCuoMFs/YjCRrpO9mPoqrzw9FA7gkObr22+Cpo07kKeqcqM
         MOeQh18O4+ht4NQnhQu4jp78ZdaoLxIFzvLZL8efmtDEBDKtQHLjXx/lgy2uyA0ofomc
         /byhc4vhxkjXWpqmDaKoqmxqU6KO4C54Zdk7GY9DvJ+6GW4DUOwd1eRtawtZuBDY6tLp
         a5XWb7M0rK4YUug0yVTbPvXvcGKJhnNDquOGkOYeZOf4C77bhw6no0dx0p2kqg7GE27o
         j1qxrVv8GVT+qt8Dz+4+hrbhINYBTW8e1yRTZUwjff9aoMRK//mqTMWH1dvB/75zbdfS
         nYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773769182; x=1774373982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pOa0THwiOISyWRpaVdtklSJLjJnmfGR+A8nH9FsP7C8=;
        b=Lc1G8sHvye4jk4JNS0BGOykfeEz5lrt74Rvy7tcSAFaiBkTPQoxZ7BfoYKssb6KdRC
         r2YhlFPQ6xNhR/vDW/I7xSTXPwCG5zG9ZWtx9EpcycIDEzdf8v4rfxuxS0ijzZd4pESj
         Hbbtv2wv+HFTq4Q+fEpQH2p5UztgdYVjDszKajYvV+fXkNTywKQWLIlwDl2Q3oEHJfgV
         nAWhBBaLmK089mJVvIMg1sTDsAyyuZ3cV5LGjdo4BKqL/Ex4Tytnzialex5GbPVHgIG1
         v0d+wwCZ4kvR54IMW8qTB5RayXWGf4WkmkEBGvfcLtQwT7Y5M9whM/oWO+s0eO5ezxCl
         AsvA==
X-Gm-Message-State: AOJu0YxZb/8NBvFUAjN01l/iRR3Q6NHasFRMFuzHi+rIXih/mYP092zS
	oC5/diBmiK6mJB+Ov4zPtXYr+riglTPwd93pvy9a+wRPasVEk3l7M0hC
X-Gm-Gg: ATEYQzzVzkZDa2NaFcBTUsV7CioML4UOpaE7t4ZZ21SEMM+5XAOAcRe/4qU/iGdZc2B
	3B9Bu3C+8qZHqzvNUSttR5F5w6otMQiVXMRbC8na0YCVQVBtkN2zwlrmqKKhL8z/53KS58EqLzc
	288GvUoBSkHKmos74adhsidfqKx7lvkm2f1aw5jBrpVAHIpsHN6MW+pFfIHNzq1LJ4L+EPiR1em
	f0ZYl5V4YriwsP67II1GeAJ0ADvogIUc+s19PRoL6lie3zEYcyrrp8bvFDQEO0Lk1g2CVjhw4KA
	XlrWhOyQcToUnIbWX4zz0R8e+t/gIDGOkJ/qV91ifqFU5Ld486WpkbJME3izpupEF4cwAMrVND3
	hwvXjFPx7HahC+UlDFPiNns9Nahxv/owLY1pW0praj+IlmL/efa18Sx1aAqvic3YXQx6Ascftaw
	KhZ/R0rrrKQm8f
X-Received: by 2002:a05:600c:c4a4:b0:485:3c11:de84 with SMTP id 5b1f17b1804b1-486f40c9015mr7655125e9.14.1773769181900;
        Tue, 17 Mar 2026 10:39:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4214664sm5318155e9.4.2026.03.17.10.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:39:41 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 17 Mar 2026 10:39:21 -0700
Subject: [PATCH bpf-next v4 1/3] libbpf: Introduce bpf_program__clone()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-veristat_prepare-v4-1-74193d4cc9d9@meta.com>
References: <20260317-veristat_prepare-v4-0-74193d4cc9d9@meta.com>
In-Reply-To: <20260317-veristat_prepare-v4-0-74193d4cc9d9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773769179; l=5803;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=WeMEdkO9RPxcL+x+s1xWrz7bf7w6r010yEwLQ1oocMk=;
 b=fiU02Sb7J8UUHqut0rw/ZpuDzqxj/aDVjKzG/CtMPs0+0E8B9k+xIaxF2pc6wV796m7h/444o
 jJLSN8ses/7DP+rM8me6+z/Q49vAsEMvN1ZQr1VF4bPD40rprvQqN8r
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add bpf_program__clone() API that loads a single BPF program from a
prepared BPF object into the kernel, returning a file descriptor owned
by the caller.

After bpf_object__prepare(), callers can use bpf_program__clone() to
load individual programs with custom bpf_prog_load_opts, instead of
loading all programs at once via bpf_object__load(). Non-zero fields in
opts override the defaults derived from the program and object
internals; passing NULL opts populates everything automatically.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 17 +++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 96 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0662d72bad20..1eaa7527d4da 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9802,6 +9802,84 @@ __u32 bpf_program__line_info_cnt(const struct bpf_program *prog)
 	return prog->line_info_cnt;
 }
 
+int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, attr);
+	struct bpf_object *obj;
+	int err, fd;
+
+	if (!prog)
+		return libbpf_err(-EINVAL);
+
+	if (!OPTS_VALID(opts, bpf_prog_load_opts))
+		return libbpf_err(-EINVAL);
+
+	obj = prog->obj;
+	if (obj->state < OBJ_PREPARED)
+		return libbpf_err(-EINVAL);
+
+	/*
+	 * Caller-provided opts take priority; fall back to
+	 * prog/object defaults when the caller leaves them zero.
+	 */
+	attr.attach_prog_fd = OPTS_GET(opts, attach_prog_fd, 0) ?: prog->attach_prog_fd;
+	attr.prog_flags = OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags;
+	attr.prog_ifindex = OPTS_GET(opts, prog_ifindex, 0) ?: prog->prog_ifindex;
+	attr.kern_version = OPTS_GET(opts, kern_version, 0) ?: obj->kern_version;
+	attr.fd_array = OPTS_GET(opts, fd_array, NULL) ?: obj->fd_array;
+	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0) ?: obj->fd_array_cnt;
+	attr.token_fd = OPTS_GET(opts, token_fd, 0) ?: obj->token_fd;
+	if (attr.token_fd)
+		attr.prog_flags |= BPF_F_TOKEN_FD;
+
+	/* BTF func/line info */
+	if (obj->btf && btf__fd(obj->btf) >= 0) {
+		attr.prog_btf_fd = OPTS_GET(opts, prog_btf_fd, 0) ?: btf__fd(obj->btf);
+		attr.func_info = OPTS_GET(opts, func_info, NULL) ?: prog->func_info;
+		attr.func_info_cnt = OPTS_GET(opts, func_info_cnt, 0) ?: prog->func_info_cnt;
+		attr.func_info_rec_size =
+			OPTS_GET(opts, func_info_rec_size, 0) ?: prog->func_info_rec_size;
+		attr.line_info = OPTS_GET(opts, line_info, NULL) ?: prog->line_info;
+		attr.line_info_cnt = OPTS_GET(opts, line_info_cnt, 0) ?: prog->line_info_cnt;
+		attr.line_info_rec_size =
+			OPTS_GET(opts, line_info_rec_size, 0) ?: prog->line_info_rec_size;
+	}
+
+	attr.log_buf = OPTS_GET(opts, log_buf, NULL);
+	attr.log_size = OPTS_GET(opts, log_size, 0);
+	attr.log_level = OPTS_GET(opts, log_level, 0);
+
+	/*
+	 * Fields below may be mutated by prog_prepare_load_fn:
+	 * Seed them from prog/obj defaults here;
+	 * Later override with caller-provided opts.
+	 */
+	attr.expected_attach_type = prog->expected_attach_type;
+	attr.attach_btf_id = prog->attach_btf_id;
+	attr.attach_btf_obj_fd = prog->attach_btf_obj_fd;
+
+	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
+		err = prog->sec_def->prog_prepare_load_fn(prog, &attr, prog->sec_def->cookie);
+		if (err)
+			return libbpf_err(err);
+	}
+
+	/* Re-apply caller overrides for output fields */
+	if (OPTS_GET(opts, expected_attach_type, 0))
+		attr.expected_attach_type =
+			OPTS_GET(opts, expected_attach_type, 0);
+	if (OPTS_GET(opts, attach_btf_id, 0))
+		attr.attach_btf_id = OPTS_GET(opts, attach_btf_id, 0);
+	if (OPTS_GET(opts, attach_btf_obj_fd, 0))
+		attr.attach_btf_obj_fd =
+			OPTS_GET(opts, attach_btf_obj_fd, 0);
+
+	fd = bpf_prog_load(prog->type, prog->name, obj->license, prog->insns, prog->insns_cnt,
+			   &attr);
+
+	return libbpf_err(fd);
+}
+
 #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
 	.sec = (char *)sec_pfx,						    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index dfc37a615578..0be34852350f 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -2021,6 +2021,23 @@ LIBBPF_API int libbpf_register_prog_handler(const char *sec,
  */
 LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
 
+/**
+ * @brief **bpf_program__clone()** loads a single BPF program from a prepared
+ * BPF object into the kernel, returning its file descriptor.
+ *
+ * The BPF object must have been previously prepared with
+ * **bpf_object__prepare()**. If @opts is provided, any non-zero field
+ * overrides the defaults derived from the program/object internals.
+ * If @opts is NULL, all fields are populated automatically.
+ *
+ * The returned FD is owned by the caller and must be closed with close().
+ *
+ * @param prog BPF program from a prepared object
+ * @param opts Optional load options; non-zero fields override defaults
+ * @return program FD (>= 0) on success; negative error code on failure
+ */
+LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d18fbcea7578..e727a54e373a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
 		bpf_prog_assoc_struct_ops;
+		bpf_program__clone;
 		bpf_program__assoc_struct_ops;
 		btf__permute;
 } LIBBPF_1.6.0;

-- 
2.52.0

