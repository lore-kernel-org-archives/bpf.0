Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC223B63C
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771615099; cv=none; b=U458F4c+tDFue3522M6r53yLtpWGwEqdgFeLIHPRqZLgIEO1at54rDAskEXtm1gIhLClxvEmhw8Q0qWjF60wtSXrMUIeKW57bfO/WLWd9P7Fo4Zy8g2lKbHglGQhH2dzIy6F56wFDiJoxfpJ0Teqo6/5oR25lfFESMeZjReVQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771615099; c=relaxed/simple;
	bh=NZ8Yj65RvlY0GVbCZ2twS7zm5k5JhP8Sh38XTEk0Ckk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehNusR2NK7j4v8k0XzUSRq6wYUKJAiaP/07mCdEyCyKvbvFyy/rgp71LyRkoS3/GLqkAMYzBci16J1lxFFKXq1KfqQAyvu0QboAZoNwLGruM3lknA8eFfwCcm2puod0rPilmJ6RlYQ+pi6Y1S3+Ggj3o75vN3sh+ijch3bWE5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWM+YYVf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWM+YYVf"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43638a33157so2239546f8f.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 11:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771615096; x=1772219896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XTqf/2q4e3+bsnVwet0RKOGTdYGkA4n32Q29UjsPII=;
        b=IWM+YYVffSxdSwGG05qhl+VVAXKvNL5q4WmR0+zXKnFS7ZgtJCpspaAjjqXFyobK7a
         nywHA7yCkeRjJb8IPwjvV9ICap0duAwc9X3bmnMqf8ygfRfRn2x+I1xPeRphdtmFamCV
         FIypT1y8Lyrqs539w77WFImpgtsqjwpRGTXAdF68WPPfB0K4wV0kAXBWor27KPbI5sUk
         LhG7nOamg3BdPmQg6IiVKj1/o2yT6Gz9jHH59KTga7LT3Q89z8nCSMETWBrpzi6RQuuq
         IbWBZnRr3mmvzABu71vHcgZtKCU2Ae2V0Irtst1MvSmwAzMW3i2/tKoxhURlF3bSJDFX
         ADMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771615096; x=1772219896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6XTqf/2q4e3+bsnVwet0RKOGTdYGkA4n32Q29UjsPII=;
        b=Qqo6h35sy/EOFBTM506vrs9zkY/njG4dh8wUX9wdxBq0aIhuGldpacr8vB8/t8HFGV
         pF1bD7bN7GZRimVk53k4a7jE26z2uG7wJGuwHzz6CTtSdFM6upH83WtizDp6W90xjykI
         AJz0hHVW2SPAUOXYBAT/0tb/FCHK8AcNCMXx1XdmP1fFaDvBBomWPB7C0Uk8MlRrLOFQ
         1RjpaxPRJN0Ip75G5FIi/f1tHoUKbwDq57/QAa7PEROyyHaavRN1shSXrIGz8LIELV31
         N5mjHlFnB3PLJeKa6djQGyDsvbUHn4tMFkN9x6DBxp7TVs8ufPMTy/KTYSc+IlJUjXsY
         kWxA==
X-Gm-Message-State: AOJu0YwfhtlnQ2LMFBhlCOGZR9gOqjBtpzsvwqYa6TBfULy/xzOl9Ot0
	nVsOwvMm2AAM4GQoZUJMAW4Lr9n54KtXCnxBj4sd6YO92K0n/A/+62+O
X-Gm-Gg: AZuq6aJHKdkky1SaJgFiVcaIW1y34W63Q1E5B4c7b6kr1C8L4ldhdIFSu+rAkJjR6MI
	6RP4LWAUMVgJSjvgK1NLMSPP4kEI2X0HGRwaW0GWEWfBvIHiPJNwKmSVZ74iso4Ihe408MumM8L
	jWsOngnBXf5LeTFZyqKNfHpw7occcc+30e4afwWmrr2boovfGR3guJtJNsSk9MIhbcQClGpBFY/
	N1l6bt7fQRywzWrebhTTUbeLAqsldeMiRNiv0rakLe5XIwbkrtzQrj4NCJVuMlkjPkTezuT/4ZG
	ah3cfVL3ofHOgcmEU8O8el5G7crQwQreQZ/pHcZbzXBj2vurJBlKRP/nYuh13N6VgPVYVzAr66v
	rrw8VGITIhXm3me1INuZBr9cCH5r/uzef/IFTQ8sJin10x46XoqwJZER69r1DfXNO6wdtdddmbJ
	e18WDWtb91UAl9DnfZ6B8Xtuii3dV/
X-Received: by 2002:a05:6000:188e:b0:436:34e8:e665 with SMTP id ffacd0b85a97d-4396f1819e1mr1644064f8f.54.1771615096241;
        Fri, 20 Feb 2026 11:18:16 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d401aasm92260f8f.23.2026.02.20.11.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:18:15 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 20 Feb 2026 11:18:04 -0800
Subject: [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
In-Reply-To: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771615092; l=5804;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=AFWRnGO1Nrg6jk5nKzIH/ILjyICfh61CLE0imX3oLtY=;
 b=pfVdjk2O5+OlGj2eQQ9LHj41F1xjsZ8pbVh++Stomi2YgMUpB1GH/zzz2VMCvQpHqaGnaj4GI
 yd+k6+IiEvXBcQYFe/JYfoKI2hOeowU35EVkEm2xnJrtySVCzMITPax
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
 tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 17 +++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 82 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce4..4b084bda3f47 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9793,6 +9793,70 @@ __u32 bpf_program__line_info_cnt(const struct bpf_program *prog)
 	return prog->line_info_cnt;
 }
 
+int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, attr);
+	struct bpf_prog_load_opts *pattr = &attr;
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
+	OPTS_SET(pattr, expected_attach_type,
+		 OPTS_GET(opts, expected_attach_type, 0) ?: prog->expected_attach_type);
+	OPTS_SET(pattr, attach_btf_id, OPTS_GET(opts, attach_btf_id, 0) ?: prog->attach_btf_id);
+	OPTS_SET(pattr, attach_btf_obj_fd,
+		 OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_btf_obj_fd);
+	OPTS_SET(pattr, attach_prog_fd, OPTS_GET(opts, attach_prog_fd, 0) ?: prog->attach_prog_fd);
+	OPTS_SET(pattr, prog_flags, OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags);
+	OPTS_SET(pattr, prog_ifindex, OPTS_GET(opts, prog_ifindex, 0) ?: prog->prog_ifindex);
+	OPTS_SET(pattr, kern_version, OPTS_GET(opts, kern_version, 0) ?: obj->kern_version);
+	OPTS_SET(pattr, fd_array, OPTS_GET(opts, fd_array, NULL) ?: obj->fd_array);
+	OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->token_fd);
+	if (attr.token_fd)
+		attr.prog_flags |= BPF_F_TOKEN_FD;
+
+	/* BTF func/line info */
+	if (obj->btf && btf__fd(obj->btf) >= 0) {
+		OPTS_SET(pattr, prog_btf_fd, OPTS_GET(opts, prog_btf_fd, 0) ?: btf__fd(obj->btf));
+		OPTS_SET(pattr, func_info, OPTS_GET(opts, func_info, NULL) ?: prog->func_info);
+		OPTS_SET(pattr, func_info_cnt,
+			 OPTS_GET(opts, func_info_cnt, 0) ?: prog->func_info_cnt);
+		OPTS_SET(pattr, func_info_rec_size,
+			 OPTS_GET(opts, func_info_rec_size, 0) ?: prog->func_info_rec_size);
+		OPTS_SET(pattr, line_info, OPTS_GET(opts, line_info, NULL) ?: prog->line_info);
+		OPTS_SET(pattr, line_info_cnt,
+			 OPTS_GET(opts, line_info_cnt, 0) ?: prog->line_info_cnt);
+		OPTS_SET(pattr, line_info_rec_size,
+			 OPTS_GET(opts, line_info_rec_size, 0) ?: prog->line_info_rec_size);
+	}
+
+	OPTS_SET(pattr, log_buf, OPTS_GET(opts, log_buf, NULL));
+	OPTS_SET(pattr, log_size, OPTS_GET(opts, log_size, 0));
+	OPTS_SET(pattr, log_level, OPTS_GET(opts, log_level, 0));
+
+	/* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
+	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
+		err = prog->sec_def->prog_prepare_load_fn(prog, pattr, prog->sec_def->cookie);
+		if (err)
+			return libbpf_err(err);
+	}
+
+	fd = bpf_prog_load(prog->type, prog->name, obj->license, prog->insns, prog->insns_cnt,
+			   pattr);
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
2.47.3

