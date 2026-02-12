Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C1262BD
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770857113; cv=none; b=i4stZBpZiwA+EFHitz9dCVzs6xt5fjJ1PNtkwN/+Sfkvb7hWjPlYET0ujI9jnhLts16K238o5S4vw/LiIsLqZjdLXUUfoLfVgE3RqY4yBTG/dgO07QtUU9hAqwY4ulJTy2r8Kjd7wuWKv4buAmfaAIveca00Yjd0R9gKdg7ASqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770857113; c=relaxed/simple;
	bh=Jo8s43MlRnaKT8SJV9OQ/B+2kATMXUn28xjpO/OIuIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDsVy4q2ihkBGUxq4olY6xUcmBMjksJIAh2JH0kN3xJq+X4lYcCqRpRfqkgyVLjeUkm2bfQFfw69nI8PJSE2FkJYMQJuGTrj6Hpbm78mLtM9xYd1G7H9jb5Ue0k7+4CErjanfu1xHRyqMzZ8xcOzZ1Q+3NLTDb7CvORKp85qi70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFXVF1be; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFXVF1be"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3874746f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 16:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770857111; x=1771461911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAAJAFIYj9HfyBUU3nx/72oJhhdEF+skc3aF9HpyNII=;
        b=eFXVF1bec91K7R+A0WoGwe4X8T72QJW5vh+bYehHADiTPmBZC+ct8qqxpTITsrYIp5
         N6OxwG5W0fUSblMIBc8wFax7yn+0eIAUDosAwwgpb0U9AQ0vRA3V/vgW/aZhf1wOukUx
         6M/CAfUIj/WC3hw0ni7XAAa2fLFrqerbxnR3VVvuyMJm5IHjItE7Z92OrYlhXgheeXUk
         E+iaXTmcSPZ8M/vBZ3OlywKqmsna+gIZVid6QeQ7LNTVTAT8/wAe64IM09s6xZlrs8vq
         nhV4c6UjOXvk5O7So+r1bJ/WE/XqlHxnQjePP1Pt1vYr8pstiXVPNYvroLtnYv+SsdbY
         Oa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770857111; x=1771461911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GAAJAFIYj9HfyBUU3nx/72oJhhdEF+skc3aF9HpyNII=;
        b=dFvGEJv5F4EmtetPj8gJMSQBBrMTPRI2yeywITGe1NHnFGDR97W+hDSrUI6rd4C3WT
         StOVqExk73AmS5OqTbCO+0+1ZaPGLYKuEuMjJpeceV6g/yf8DdU61CC5KsCcw1hl54Bx
         gCq0g7ZVwjy24ORe8dnMpTIEH1Sb3WDNhNxH8cwGkC1aSOA/C6fgrGOBlqvdDSxu/Zbp
         +aBng/mM5/jFDEAfMa1LkXwAQ53gb78iAr0wrRoEDNpUOMqO7zZ8ny7ONNTOxiCDmGta
         CZMFV3QtyHMookoocoI/p65Tx9T/Q3hO9zSd4kPShwy071KiLfpA5E61x4V80cfKVo7h
         /l8Q==
X-Gm-Message-State: AOJu0YyyBkLhp/fchbktlINukDrAgB3dbthWk6Xn/hxtwmR/6Ot4/Emn
	5AmAzbIK19Nrxn42469mhhzjr9FNIsunmyh3EV3ainBpXnlx1ycQ5xEC
X-Gm-Gg: AZuq6aKjYAJMtPfwwhcHsoXr2MaiI4WXTr/i/k9QVOfx138E5Weq9sL6Gz7kZK+63lo
	MCPPRgXjIMiqMfoswd/XU65pjjUFg9UUOMp6HnH8X/a341tIggTULgEDPzsjOIkV9NW5AXtZKaj
	MrLuyZH8aUAWaGx+Yizxx0+ZjkKRhgyCnc7qFBTRBLN3vAQKE4OBgnzci5BnWeywY4hWJcM9ty/
	xEsW0Iqqqn/tUf4myjBtUFcuEEq4NHHxQ6cQrGybtqFSQxLPUYHlS4rdkNg7G2A5xA69qGKWmyi
	x+8CFz/0zWda++xSzkrbCGDmixBBijSgovbFjtcYSQe13d6DF60ehlezGB5XJ9vjOVEmP1QzQAu
	Td0jda0+6K3T4bidGzyfyGiyDckJBSPLYW0Zy0rBqNW3CtMrJ7R2YyQDY5IyD+pOWGNMtiHhLzP
	sn3uEYE81qoZzyVrrr5shCxMAdNw==
X-Received: by 2002:a05:6000:420b:b0:437:6963:a115 with SMTP id ffacd0b85a97d-4378ad5f6f8mr1778262f8f.42.1770857110481;
        Wed, 11 Feb 2026 16:45:10 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d36f86sm7614050f8f.7.2026.02.11.16.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 16:45:10 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 12 Feb 2026 00:44:36 +0000
Subject: [PATCH bpf-next 1/2] libbpf: Introduce bpf_prog_clone()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-veristat_prepare-v1-1-c351023fb0db@meta.com>
References: <20260212-veristat_prepare-v1-0-c351023fb0db@meta.com>
In-Reply-To: <20260212-veristat_prepare-v1-0-c351023fb0db@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770857108; l=7750;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=HS6M1d+S6lXFa4rEKe/Qenrx9q06BjemQ4c97BjDG+M=;
 b=z3Ppbjrg3gMKy46FqYgPnDL6g80s6I7qEZwRyfvRrY07KlGK++lACqLLUHzj4GV1v/haF6nVY
 I/o30HRKyM6CXuFPDWxKQyn9K1W2yfzfDWO0mArtNhrG6rsWpumsVgm
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add bpf_prog_clone() API that loads a single BPF program from a
prepared BPF object into the kernel, returning a file descriptor owned
by the caller.

After bpf_object__prepare(), callers can use bpf_prog_clone() to load
individual programs with custom bpf_prog_load_opts, instead of loading
all programs at once via bpf_object__load(). Non-zero fields in opts
override the defaults derived from the program and object internals;
passing NULL opts populates everything automatically.

Internally, bpf_prog_clone() resolves BTF-based attach targets
(attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
func/line info, fd_array, license, and kern_version from the
prepared object before calling bpf_prog_load().

Program-containing maps (PROG_ARRAY, DEVMAP, CPUMAP) track the owner
program type in the kernel. When loading programs with different
attributes (e.g. sleepable vs non-sleepable) from the same prepared
object, the shared map would reject incompatible programs. To handle
this, bpf_prog_clone() creates temporary copies of program-containing
maps for each load and patches the instruction references, so each
program gets a fresh map without owner conflicts.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c   | 139 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  18 ++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 158 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce44462414e99a958260e940148e818..b2d8277a3ef04d266148c3fc0cf5f907b357358b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9793,6 +9793,145 @@ __u32 bpf_program__line_info_cnt(const struct bpf_program *prog)
 	return prog->line_info_cnt;
 }
 
+static bool map_type_contains_progs(enum bpf_map_type type)
+{
+	return type == BPF_MAP_TYPE_PROG_ARRAY ||
+	       type == BPF_MAP_TYPE_DEVMAP ||
+	       type == BPF_MAP_TYPE_CPUMAP;
+}
+
+/*
+ * Clone program-containing maps to avoid owner compatibility conflicts.
+ * PROG_ARRAY, DEVMAP, and CPUMAP maps track the owner program type; loading
+ * programs with different attributes (e.g. sleepable vs non-sleepable) against
+ * the same map fails. Create fresh maps and patch instruction references.
+ */
+static int clone_prog_maps(struct bpf_object *obj, struct bpf_insn *insns,
+			   size_t insns_cnt, int *temp_fds)
+{
+	int i, j, old_fd, new_fd, num_fds = 0;
+
+	for (i = 0; i < obj->nr_maps; i++) {
+		struct bpf_map *map = &obj->maps[i];
+
+		if (!map_type_contains_progs(map->def.type))
+			continue;
+
+		old_fd = map->fd;
+		if (old_fd < 0)
+			continue;
+
+		new_fd = bpf_map_create(map->def.type, map->name,
+					map->def.key_size, map->def.value_size,
+					map->def.max_entries, NULL);
+		if (new_fd < 0)
+			return -errno;
+
+		for (j = 0; j < insns_cnt; j++) {
+			if (insns[j].code != (BPF_LD | BPF_IMM | BPF_DW))
+				continue;
+			if (insns[j].src_reg != BPF_PSEUDO_MAP_FD &&
+			    insns[j].src_reg != BPF_PSEUDO_MAP_VALUE)
+				continue;
+			if (insns[j].imm == old_fd)
+				insns[j].imm = new_fd;
+		}
+
+		temp_fds[num_fds++] = new_fd;
+	}
+
+	return num_fds;
+}
+
+int bpf_prog_clone(struct bpf_program *prog, struct bpf_prog_load_opts *opts)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, local_opts);
+	struct bpf_insn *insns = NULL;
+	int temp_fds[256], num_fds;
+	struct bpf_object *obj;
+	int i, err, fd;
+
+	if (!prog)
+		return libbpf_err(-EINVAL);
+
+	obj = prog->obj;
+	if (!obj || obj->state < OBJ_PREPARED)
+		return libbpf_err(-EINVAL);
+
+	if (!opts)
+		opts = &local_opts;
+
+	/* Fill unset fields from prepared program/object */
+	if (!opts->expected_attach_type)
+		opts->expected_attach_type = prog->expected_attach_type;
+	if (!opts->attach_btf_id)
+		opts->attach_btf_id = prog->attach_btf_id;
+	if (!opts->attach_btf_obj_fd)
+		opts->attach_btf_obj_fd = prog->attach_btf_obj_fd;
+	if (!opts->attach_prog_fd)
+		opts->attach_prog_fd = prog->attach_prog_fd;
+	if (!opts->prog_flags)
+		opts->prog_flags = prog->prog_flags;
+	if (!opts->prog_ifindex)
+		opts->prog_ifindex = prog->prog_ifindex;
+	if (!opts->kern_version)
+		opts->kern_version = obj->kern_version;
+	if (!opts->fd_array)
+		opts->fd_array = obj->fd_array;
+	if (!opts->token_fd)
+		opts->token_fd = obj->token_fd;
+	if (opts->token_fd)
+		opts->prog_flags |= BPF_F_TOKEN_FD;
+
+	/* BTF func/line info */
+	if (obj->btf && btf__fd(obj->btf) >= 0) {
+		if (!opts->prog_btf_fd)
+			opts->prog_btf_fd = btf__fd(obj->btf);
+
+		if (!opts->func_info) {
+			opts->func_info = prog->func_info;
+			opts->func_info_cnt = prog->func_info_cnt;
+			opts->func_info_rec_size = prog->func_info_rec_size;
+		}
+		if (!opts->line_info) {
+			opts->line_info = prog->line_info;
+			opts->line_info_cnt = prog->line_info_cnt;
+			opts->line_info_rec_size = prog->line_info_rec_size;
+		}
+	}
+
+	/* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
+	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
+		err = prog->sec_def->prog_prepare_load_fn(prog, opts,
+							   prog->sec_def->cookie);
+		if (err)
+			return libbpf_err(err);
+	}
+
+	/* Clone program-containing maps to avoid owner compatibility issues */
+	insns = malloc(prog->insns_cnt * sizeof(*insns));
+	if (!insns)
+		return libbpf_err(-ENOMEM);
+
+	memcpy(insns, prog->insns, prog->insns_cnt * sizeof(*insns));
+
+	num_fds = clone_prog_maps(obj, insns, prog->insns_cnt, temp_fds);
+	if (num_fds < 0) {
+		err = num_fds;
+		free(insns);
+		return libbpf_err(err);
+	}
+
+	fd = bpf_prog_load(prog->type, prog->name, obj->license,
+			   insns, prog->insns_cnt, opts);
+
+	for (i = 0; i < num_fds; i++)
+		close(temp_fds[i]);
+
+	free(insns);
+	return libbpf_err(fd);
+}
+
 #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
 	.sec = (char *)sec_pfx,						    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index dfc37a6155786f325935aaac1508eed679151f0d..e6a0bb881cd2d1e69f9089c94dc4158a89620591 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -2021,6 +2021,24 @@ LIBBPF_API int libbpf_register_prog_handler(const char *sec,
  */
 LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
 
+/**
+ * @brief **bpf_prog_clone()** loads a single BPF program from a prepared
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
+LIBBPF_API int bpf_prog_clone(struct bpf_program *prog,
+			       struct bpf_prog_load_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d18fbcea7578d5f75d5fc925ea9edff52e423faf..515c26b0a139394048fd2b24174363b65a0ee644 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
 		bpf_prog_assoc_struct_ops;
+		bpf_prog_clone;
 		bpf_program__assoc_struct_ops;
 		btf__permute;
 } LIBBPF_1.6.0;

-- 
2.53.0

