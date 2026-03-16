Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A97359703
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697795; cv=none; b=sat4f6vARHI3nvvK8FvTW9Efu+81s1RAh1ndUYdsoPXbDPhUUzdSJ/DYNIMFgCwyCYw+9JENFWqUIw8yA9uuySh/kQ1yiZITG/clUaubjG8qgu+EIVILGgWF9pPfKrga67G0z6vAh+25Ocx2kP7e53VZ/2Mj98djSaqBQ2mM+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697795; c=relaxed/simple;
	bh=HRNBgUvzwJJyqwUmErsaMfifuq4JZqbuYr6iu0QPDAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juDdDdjFR3L3aFOb+mt8OVlyH3h1bv4g5HLoPzLRwVVqu6wckHilRZPR+52Xu5x2D8yKZ/jol7PTME9rDUyIRTNsrAXPHj6HTZCJSbx3Fl/bRVFIiaF2fSeslHgCgCgH22TpM3/bE5mq8qLWlNXMXuUEi+NrCB7X9rkQ4J/5ysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqdpykbt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqdpykbt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso46390745e9.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697792; x=1774302592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TznWUFuDyO83ZxDT3al5oU3/IQKDZ7zIBxEbQskFnwo=;
        b=aqdpykbtNNz/yGEYPdY87JDg7EyyK0DjQDFf4qMfXLQ4o6HwwAoKAJhVEPVn2SYLKM
         K8UfQ9HrT3gXy+8vVk2/QCYiTZxM9yBOSlwp/9f+ZmtjxTwuxnEdqzbBwRJDHuTE8oj2
         vKmpwIS8lirgGJ73OX1ZHm3urN+IX94UqQdRlBQq58zbVPmjU/TY3bFRP6DD8Bkujmad
         rUEOI+wsWxdmfvgxIzVIAej1RFkadiWxdx17RQ1meeH8eav4g//sx0DX7gul5EFdLq+L
         RbpOLfTW3V9fpNlLvBpMP5fEom+Eyo751hbXl3Mp/7zXKQng0KHl0a97PJliR1K4gKHr
         HGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697792; x=1774302592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TznWUFuDyO83ZxDT3al5oU3/IQKDZ7zIBxEbQskFnwo=;
        b=q3nmsuVXRtCjrB1LXMv1hNMv9dQkC/1IWi8tGGNf2W/1A6C7McIvFPvWbjPnWGwm+W
         RgQDY1XLSAX28TSV4kMMmvEQJsEYmvNjPSNwLBKam7kbZL/BlgecxxG+HhkSEdLKSFmh
         5ilnK9jaqzUBdTF8sj+A6P0gmip1rZ+gL9iZskUJttY6qHsxGWD5OxNPjngpgYev3jyM
         c4gZV1NeIeWTytNBk1WtlFkcXwH5tduKG0cgj/UrIVzxyOjLhvrjKPn846RDuc4/PP7k
         KUJavD1/vpSL6nTEvRDZU5iaPzTjfPciLYwcGIa58uoJqA7Z30OjFARd2pjR+8z0VPfy
         Pr+A==
X-Gm-Message-State: AOJu0Yw9UH2plSJwX5onnZLauwFb2qDIarjYGZhdwW+6t/IAFek9jGF6
	JiP4aXFWKL1/yN/FT8eCQ93N4S/uQbYCS/EUg3gW0f4a/RoBU2ucVtm0
X-Gm-Gg: ATEYQzzsnG363a0smEb96doUz2AC9LisHn2fhQ45V6Ip5PHQeTTjUl2EVjTGxsXRvCB
	RZhV4Q182iVulFKTHSEVLpAfLY6TuRAWl7BrgSNErKTArvl32/c8Prhd9cPBtxNrmk8aljXUDY2
	7i57vVRBvChiMGWxCYSbWWUbZZOTlaVMl3OXEVsVMqGkMbGnpHhuutxHolIdxI8aM2MVvRnfbep
	Zpowi0te7Tp28RPNn9NipTPJbE3sEM7+N5V0aXTiJOftiWV7093mTvxLo+x0n/hjeUlAOmfkEx3
	cwiC1O1WQl2pj+cvnffrFeXmXTTdo6KTyH37wUpmpIFOfVJaP0qTS226Vh1cEQZhqgmkJFJ19b4
	tuiG+uw2nG8AoGIY75XgZjEeOSDCmULQOEq/issEbbV1X2kE5l2lFmBgDgGFSyTHwe+q74F0HBq
	ULTN+Kv3OTM9Sf
X-Received: by 2002:a05:600d:8488:10b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-4859a503566mr1049775e9.8.1773697791854;
        Mon, 16 Mar 2026 14:49:51 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c387sm25331035e9.8.2026.03.16.14.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:49:51 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 16 Mar 2026 14:49:36 -0700
Subject: [PATCH bpf-next v3 1/2] libbpf: Introduce bpf_program__clone()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-veristat_prepare-v3-1-94e5691e0494@meta.com>
References: <20260316-veristat_prepare-v3-0-94e5691e0494@meta.com>
In-Reply-To: <20260316-veristat_prepare-v3-0-94e5691e0494@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773697789; l=5608;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=XsKiADe+7+zjwxPv7fIB8KjsLtBEE13gIrbuMBOSQ7E=;
 b=NZt24jCqzAXRsaXlNWOLHKoye36uo3/olsJS5s8hJYTLezxwTy8iYAh5k7M3n657UwtDWnpYx
 28GfNdAhUlAD7Iky7bS3fPSyPUjX7Vyb20VmoAGnvEbUbkRm+zg3ftB
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

Internally, bpf_program__clone() resolves BTF-based attach targets
(attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
func/line info, fd_array, license, and kern_version from the
prepared object before calling bpf_prog_load().

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 17 ++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 79 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0662d72bad20..0f6b9e773c52 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9802,6 +9802,67 @@ __u32 bpf_program__line_info_cnt(const struct bpf_program *prog)
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
+	/* Copy caller opts, fall back to prog/object defaults */
+	attr.expected_attach_type =
+		OPTS_GET(opts, expected_attach_type, 0) ?: prog->expected_attach_type;
+	attr.attach_btf_id = OPTS_GET(opts, attach_btf_id, 0) ?: prog->attach_btf_id;
+	attr.attach_btf_obj_fd = OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_btf_obj_fd;
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
+	/* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
+	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
+		err = prog->sec_def->prog_prepare_load_fn(prog, &attr, prog->sec_def->cookie);
+		if (err)
+			return libbpf_err(err);
+	}
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

