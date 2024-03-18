Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098F38DE9
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767907; cv=none; b=apcs2+IPzqXSNptHApC5lwbGWbiCbOjZUPESuRR9hTdBs1zqsaOsP77ziGrexBGR5cpcQjo6s8zDN4wKAZqrl0A/piB8IJGldQj4iagZxOBdlL9isWZfW+9LwRZMDd2tnpRFiJQJz5NuON+pPhnLX1Qn8UkA6Yr+2HionW6k3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767907; c=relaxed/simple;
	bh=A5AksU+b+moaYFSMBLcp06e//YAQgyp5CnrSV25/B3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIHa1nb3ittf9r5son3PMQf46nuyRtYPxn7GaekbTGSoyG/flz8acc6XRyCPVpu125dBSFXI32SKZZu7pm1VrXRhbSH7apM77BaCkjpeQKena1G+zxtxmRlnqcDjWb7MRDtZwGEB5ZRkJ8Fw2mnIOIbW79NIX/XAdeoDnvgF7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so5541085a12.1
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 06:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710767904; x=1711372704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6d3VlNqXZpzxs/l6E9vlsqnBULa0MGCnX46vFd2z8m8=;
        b=CCEV1wiP0TnzjHMW/Mktwv35P9gAhH237WM5Mo8MOF22dCv9bMZiNLOHUO3HRO4OiV
         2yEQrYxWTfYp67B4mxpOFqauYOJZbrj/8KJIqECR5zAgQUYoiKzcZl6OAbK3vVG6UGaZ
         SLRtH8e7ZFvR6UGl1Yaop7qw8+znTiXy75JqE+7AvA7aHuL1zjMIQv5XQYxHfylVLvzS
         oQpSdDL/3sYG53LtGOT3nhexti9QUpbIRyC3GMB0lGLPRcc1/gWHI64GS4LTZmcR9P3P
         Epp/pQZC+OwdHcmLwrpju4Bh+Ca3KXlmQJkx3dOB57FDH9kHVqp8cLqtX8AM9QF3IQZn
         eU5Q==
X-Gm-Message-State: AOJu0Yzu2XAhnV3f6tshNf2mfzjZdEjRF/ajvvunvCsfIiCW4WpDMzbh
	WHY/GJCmyi5Jk/Hrc8puvs0vBQPQpUhoYUvSUTJpcldQ/xyW2/CAO5cKXnIizFE=
X-Google-Smtp-Source: AGHT+IEO77NJWvxyqSBiPNZODQ+/oi6zOz1sXALCrypU/AmVnUR/VOafOBg48yfa2lFmMam4GVIAzA==
X-Received: by 2002:a05:6402:3986:b0:568:223e:f2b0 with SMTP id fk6-20020a056402398600b00568223ef2b0mr10086991edb.21.1710767904030;
        Mon, 18 Mar 2024 06:18:24 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:400::5:c8e1])
        by smtp.gmail.com with ESMTPSA id g19-20020aa7c593000000b005689a4b250fsm4718368edq.48.2024.03.18.06.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 06:18:23 -0700 (PDT)
From: Mykyta Yatsenko mykyta.yatsenko5@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] bpf: check bpf_map/bpf_program fd validity
Date: Mon, 18 Mar 2024 13:18:08 +0000
Message-ID: <20240318131808.95959-1-yatsenko@meta.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

libbpf creates bpf_program/bpf_map structs for each program/map that
user defines, but it allows to disable creating/loading those objects in
kernel, in that case they won't have associated file descriptor
(fd < 0). Such functionality is used for backward compatibility
with some older kernels.

Nothing prevents users from passing these maps or programs with no
kernel counterpart to libbpf APIs. This change introduces explicit
checks for kernel objects existence, aiming to improve visibility of
those edge cases and provide meaningful warnings to users.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 56 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 604368cfbf02..d1febdb036de 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8572,6 +8572,12 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
 		return libbpf_err(-EINVAL);
 	}
 
+	if (map->fd < 0) {
+		pr_warn("map '%s': can't pin BPF map without FD (was it created?)\n",
+			bpf_map__name(map));
+		return libbpf_err(-EINVAL);
+	}
+
 	if (map->pin_path) {
 		if (path && strcmp(path, map->pin_path)) {
 			pr_warn("map '%s' already has pin path '%s' different from '%s'\n",
@@ -10316,6 +10322,11 @@ static int validate_map_op(const struct bpf_map *map, size_t key_sz,
 		return -EINVAL;
 	}
 
+	if (map->fd < 0) {
+		pr_warn("map '%s': can't use BPF map without FD (was it created?)\n", map->name);
+		return -EINVAL;
+	}
+
 	if (!check_value_sz)
 		return 0;
 
@@ -10428,8 +10439,15 @@ long libbpf_get_error(const void *ptr)
 int bpf_link__update_program(struct bpf_link *link, struct bpf_program *prog)
 {
 	int ret;
+	int prog_fd = bpf_program__fd(prog);
 
-	ret = bpf_link_update(bpf_link__fd(link), bpf_program__fd(prog), NULL);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't use BPF program without FD (was it created?)\n",
+			prog->name);
+		return libbpf_err(-EINVAL);
+	}
+
+	ret = bpf_link_update(bpf_link__fd(link), prog_fd, NULL);
 	return libbpf_err_errno(ret);
 }
 
@@ -11347,6 +11365,13 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
 		return libbpf_err_ptr(-EINVAL);
 
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't attach BPF program without FD (was it created?)\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
 	syms    = OPTS_GET(opts, syms, false);
 	addrs   = OPTS_GET(opts, addrs, false);
 	cnt     = OPTS_GET(opts, cnt, false);
@@ -11387,7 +11412,6 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	}
 	link->detach = &bpf_link__detach_fd;
 
-	prog_fd = bpf_program__fd(prog);
 	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, &lopts);
 	if (link_fd < 0) {
 		err = -errno;
@@ -11770,6 +11794,13 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	if (!OPTS_VALID(opts, bpf_uprobe_multi_opts))
 		return libbpf_err_ptr(-EINVAL);
 
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't attach BPF program without FD (was it created?)\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
 	syms = OPTS_GET(opts, syms, NULL);
 	offsets = OPTS_GET(opts, offsets, NULL);
 	ref_ctr_offsets = OPTS_GET(opts, ref_ctr_offsets, NULL);
@@ -11845,7 +11876,6 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	}
 	link->detach = &bpf_link__detach_fd;
 
-	prog_fd = bpf_program__fd(prog);
 	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &lopts);
 	if (link_fd < 0) {
 		err = -errno;
@@ -12671,6 +12701,12 @@ struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
 	if (!prog->sec_def || !prog->sec_def->prog_attach_fn)
 		return libbpf_err_ptr(-EOPNOTSUPP);
 
+	if (bpf_program__fd(prog) < 0) {
+		pr_warn("prog '%s': can't attach BPF program w/o FD (did you load it?)\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
 	err = prog->sec_def->prog_attach_fn(prog, prog->sec_def->cookie, &link);
 	if (err)
 		return libbpf_err_ptr(err);
@@ -12711,9 +12747,14 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 	__u32 zero = 0;
 	int err, fd;
 
-	if (!bpf_map__is_struct_ops(map) || map->fd == -1)
+	if (!bpf_map__is_struct_ops(map))
 		return libbpf_err_ptr(-EINVAL);
 
+	if (map->fd < 0) {
+		pr_warn("map '%s': can't attach BPF map w/o FD (did you load it?)\n", map->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
 	link = calloc(1, sizeof(*link));
 	if (!link)
 		return libbpf_err_ptr(-EINVAL);
@@ -12760,8 +12801,13 @@ int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map)
 	__u32 zero = 0;
 	int err;
 
-	if (!bpf_map__is_struct_ops(map) || !map_is_created(map))
+	if (!bpf_map__is_struct_ops(map))
+		return -EINVAL;
+
+	if (map->fd < 0) {
+		pr_warn("map '%s': can't use BPF map w/o FD (did you load it?)\n", map->name);
 		return -EINVAL;
+	}
 
 	st_ops_link = container_of(link, struct bpf_link_struct_ops, link);
 	/* Ensure the type of a link is correct */
-- 
2.42.0

