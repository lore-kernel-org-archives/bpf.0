Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738E360EE9
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039658; cv=none; b=OEXFgv1at4XtNz82od0ZrR6NBhKEb8aRG6NDAigDBu/VtfxJq3U/VmVUJue+R6Zv0bJZhf5PsxqX1cOERmYQPW+s2ekOK2DKgINXTrrV/ZuvcHnz5qYj/EwIqCCaa5fIzVgLgU1bR9547AP+g1Ks3hSqJnnLz4d5JnrisnQ4UJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039658; c=relaxed/simple;
	bh=LmooVtb4gkF6eswftQ261j46gbWRqCdd9BlG5GtykVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwrfKtECbHplhlRaixGdT5iLFok8c6C0TDmX4ctM0YKZ3851qCdXfgrdxr4y3rEc50dV4pGfivuzbDhFXRl25XoheR9WFFj6fBOcoOpAyzBYYy6SGuIK3J5tGAZ1xa/CgYEp4Gyn9iMQyTcRXvFbsIWqWoiBZ/wtTGnt35jGGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwY8dyVX; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwY8dyVX"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91a931f66so25100535ad.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039656; x=1790644456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNWkI7bHQPXdcFNF3a9YrAv6xRLSqGlABro9EfBAbDs=;
        b=PwY8dyVXVZUuMJY+sSPMKPNQVprN2Ne2hpt3QEDlLQKH/nG5fLlm8ieLe953kFHvaE
         aSUtKHwiQYhlrGSKWxXTNaXunqiBOgkZ6jo4n5yepIIP4aFEj+EonFeAv3zqg9OBU1YX
         PQahT7o7ijZbsosoaeZlOrw1KxSNiL504Ji4GKEY8QF6j7dOs7+9lPrOCG7iwHFaIepW
         X60YYQYuHbsDRIErRRf+HlAMCh2Xj2uKFPHmMqC1EF4oLQHz0WAcynN1WdIGjCoYX8TI
         J6hMu8YhpwuKhvaUsjVhHue9X/UKIT57YcYXj/R1pKdc89uneue8BsIVVWyWGvd1yXUK
         kpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039656; x=1790644456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNWkI7bHQPXdcFNF3a9YrAv6xRLSqGlABro9EfBAbDs=;
        b=LRE/8RkTbUEdCF54pG/wnF6MQfFw/QJf0ZPUw2HeFcxfBmTVSN2dIQQbT18XcG/Mc+
         R1lTtfn7m+M3lXp4KLyvPQRUVScRaeLiWeT9KblMonfoqAL+kLOhALlb7bVz24Rluk2K
         jO6Np5lurbSMOtwq2Xrg0+c1DVD/FQwFfU4MR7g2czBoQdze0UP8B6KPaWdr0GL7/1j4
         m4GDfcGlp6BUutcZN3xOCrprHyAMv4NIA6UnVSgIh9sIuZAWANX554s92lxV5x8OK/LL
         fzEaCC9gW9lwKGaNTLCesaT+9IrapiKITGns4QWEpUuLti2gBg/LvMvnQY3StouLO5IC
         n4kg==
X-Gm-Message-State: AFuF++ntREjhDguxurqYd838H1EUCXXlSTAIOTMBDWQ1WfMka2U0Cm18
	9dKai6K/OXjr2jsZ1d6cns07Hvw+Y9qU8cgWeOmIKLfFf1Du5ePh01I6gBA7Tg==
X-Gm-Gg: AYBFou2QUbqY1rsn+AK9tJhSzLAFwu8NN8symD8diQv0DRWS6YObb4fXqPwCd2XdzKK
	NehCwfmb85rR7Fjycm1ImOi84gxVBrXUpYYRH9iT0oOPF2rBWRTbLGQ2UxyO1sr3tzH5nimXNJh
	U3eeoXQPfJw1l20VD5r6Zn6ydsJsyPuQpSGxyCnQAleQIMTAjesEsWVwSMT6a5TMxR2qpVpm2oq
	QUnvtdsZGa5RwlMOGubFwO/sm6Wx8BbEv12vtu3mJFcRHwJ+2JZcJ8ckJggUs7k9EeH00swj6+z
	X4NZ4Xnrbllhx2g4GyPDEu1eY6Wv36Jv+IHo9+tBe8YyZoRkFv0HWdrrSQeN3hXVEWwWWZANUfX
	hSMffSWns3rZ7gtB6cdk0pQmiXiRT2CIj9G4VqUdogAEXTGu7OJIyMOM0HqTprgyKC1cQRAMOL8
	v7nOaf+zEf8CZHVaKIk+hK+A8EF73+9OTzw8QfFIS7okcAStEHbn1WY0oL8Qy4a7ZwI/yo8gDrY
	+i/JY+eE0MqT1bZDkAVb1QmKunrHnLGj6MUcp+HyIFl3Z07RRcZVdlc+r4iOtJn//kjlbjEl8K+
	c+12wBQItI1EOIv/Hu7D3jayJk3AzT+rBrihzOmeKfU=
X-Received: by 2002:a17:903:8c8:b0:2dd:c100:4b75 with SMTP id d9443c01a7336-2ddc1007eeemr119369915ad.44.1790039655648;
        Mon, 21 Sep 2026 18:14:15 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d01996dsm925115ad.28.2026.09.21.18.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:14:15 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 14/17] libbpf: Support pointers to functions in read-only data in light skeleton
Date: Tue, 22 Sep 2026 01:13:20 +0000
Message-ID: <20260922011323.1298619-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Light skeleton doesn't create maps. The loader prog does at run time.
Teach gen_loader to create a copy of .rodata map with offsets of
functions for a prog, see create_func_ptr_map().

- Such maps are not maps of the object and are not in the loader ctx.
  Reserve slots in fd_array after the maps of the object for them and
  close their fds when the loader is done or fails. The progs hold them.

- Add bpf_gen__func_ptr_map_create() that emits map create, update,
  freeze and returns the index in fd_array for ld_imm64
  BPF_PSEUDO_MAP_IDX_VALUE.

- User space can set .rodata before loading the skeleton, see
  initial_value in bpf_map_desc. Copy it into the copy of the map as
  well and store the offsets of functions on top, since user space
  doesn't have them.

- Light skeleton can be generated for a target of another endianness.
  Store the offsets in the byte order of the object.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |  13 ++-
 tools/lib/bpf/gen_loader.c       | 172 ++++++++++++++++++++++++-------
 tools/lib/bpf/libbpf.c           |  64 ++++++++++--
 3 files changed, 201 insertions(+), 48 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 6c5ad6c55e8a..206adf28793d 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -51,9 +51,17 @@ struct bpf_gen {
 	__u32 nr_ksyms;
 	int fd_array;
 	int nr_fd_array;
+	/*
+	 * Maps with pointers to functions, that programs get their own copies
+	 * of, take slots in fd_array after nr_obj_maps maps of the object.
+	 */
+	__u32 nr_obj_maps;
+	__u32 nr_func_ptr_maps;
+	__u32 max_func_ptr_maps;
 };
 
-void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps);
+void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps,
+		   int max_func_ptr_maps);
 int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps);
 void bpf_gen__free(struct bpf_gen *gen);
 void bpf_gen__load_btf(struct bpf_gen *gen, const void *raw_data, __u32 raw_size);
@@ -68,6 +76,9 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *value, __u32 value_size,
 			      __u64 flags);
 void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
+int bpf_gen__func_ptr_map_create(struct bpf_gen *gen, const char *map_name, int obj_map_idx,
+				 void *value, __u32 value_size, const __u32 *ptr_offs,
+				 const __u64 *ptr_vals, int ptr_cnt);
 void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum bpf_attach_type type);
 void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
 			    bool is_typeless, bool is_ld64, int kind, int insn_idx);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index af3a04f161ac..251392aa8b41 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -112,13 +112,23 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size);
 static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
 
-void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps)
+void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps,
+		   int max_func_ptr_maps)
 {
 	size_t stack_sz = sizeof(struct loader_stack), nr_progs_sz;
 	int i;
 
 	gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));
 	gen->log_level = log_level;
+	gen->nr_obj_maps = nr_maps;
+	gen->max_func_ptr_maps = max_func_ptr_maps;
+	if (nr_maps + max_func_ptr_maps > MAX_USED_MAPS) {
+		pr_warn("Total maps exceeds %d\n", MAX_USED_MAPS);
+		gen->error = -E2BIG;
+		return;
+	}
+	/* their fds are closed like the fds of the maps of the object when loading fails */
+	nr_maps += max_func_ptr_maps;
 	/* save ctx pointer into R6 */
 	emit(gen, BPF_MOV64_REG(BPF_REG_6, BPF_REG_1));
 
@@ -385,6 +395,9 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 		return gen->error;
 	}
 	emit_sys_close_stack(gen, stack_off(btf_fd));
+	/* programs hold their maps with pointers to functions, nothing else needs them */
+	for (i = 0; i < gen->nr_func_ptr_maps; i++)
+		emit_sys_close_blob(gen, blob_fd_array_off(gen, gen->nr_obj_maps + i));
 	for (i = 0; i < gen->nr_progs; i++)
 		move_stack2ctx(gen,
 			       sizeof(struct bpf_loader_ctx) +
@@ -1127,12 +1140,59 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	gen->nr_progs++;
 }
 
+/*
+ * if (map_desc[map_idx].initial_value) {
+ *    if (ctx->flags & BPF_SKEL_KERNEL)
+ *        bpf_probe_read_kernel(value, value_size, initial_value);
+ *    else
+ *        bpf_copy_from_user(value, value_size, initial_value);
+ *    nr_more_insns that the caller emits
+ * }
+ */
+static void emit_copy_initial_value(struct bpf_gen *gen, int map_idx, int value,
+				    __u32 value_size, int nr_more_insns)
+{
+	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
+			      sizeof(struct bpf_loader_ctx) +
+			      sizeof(struct bpf_map_desc) * map_idx +
+			      offsetof(struct bpf_map_desc, initial_value)));
+	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 8 + nr_more_insns));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, value));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_2, value_size));
+	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
+			      offsetof(struct bpf_loader_ctx, flags)));
+	emit(gen, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, BPF_SKEL_KERNEL, 2));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_copy_from_user));
+	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
+}
+
+/* Update the element of the map whose fd is in the slot map_idx of fd_array */
+static void emit_map_update_elem(struct bpf_gen *gen, int map_idx, union bpf_attr *attr,
+				 int attr_size, int key, int value, __u32 value_size)
+{
+	int map_update_attr;
+
+	map_update_attr = add_data(gen, attr, attr_size);
+	pr_debug("gen: map_update_elem: idx %d, value: off %d size %u, attr: off %d size %d\n",
+		 map_idx, value, value_size, map_update_attr, attr_size);
+	move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
+		       blob_fd_array_off(gen, map_idx));
+	emit_rel_store(gen, attr_field(map_update_attr, key), key);
+	emit_rel_store(gen, attr_field(map_update_attr, value), value);
+	/* emit MAP_UPDATE_ELEM command */
+	emit_sys_bpf(gen, BPF_MAP_UPDATE_ELEM, map_update_attr, attr_size);
+	debug_ret(gen, "update_elem idx %d value_size %d", map_idx, value_size);
+	emit_check_err(gen);
+}
+
 void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
 			      __u32 value_size, __u64 flags)
 {
 	int attr_size = offsetofend(union bpf_attr, flags);
-	int map_update_attr, value, key;
 	union bpf_attr attr;
+	int value, key;
 	int zero = 0;
 
 	memset(&attr, 0, attr_size);
@@ -1142,47 +1202,16 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
 	key = add_data(gen, &zero, sizeof(zero));
 
 	/*
-	 * if (map_desc[map_idx].initial_value) {
-	 *    if (ctx->flags & BPF_SKEL_KERNEL)
-	 *        bpf_probe_read_kernel(value, value_size, initial_value);
-	 *    else
-	 *        bpf_copy_from_user(value, value_size, initial_value);
-	 * }
-	 *
 	 * The runtime initial_value comes from the host-supplied loader
 	 * ctx and would overwrite the blob value that the program signature
 	 * covers and the kernel verifies at load time. For a signed loader
 	 * (gen_hash) the attested blob value must be authoritative, so skip
 	 * the override and leave the signed value in place.
 	 */
-	if (!OPTS_GET(gen->opts, gen_hash, false)) {
-		emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
-				      sizeof(struct bpf_loader_ctx) +
-				      sizeof(struct bpf_map_desc) * map_idx +
-				      offsetof(struct bpf_map_desc, initial_value)));
-		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 8));
-		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
-						 0, 0, 0, value));
-		emit(gen, BPF_MOV64_IMM(BPF_REG_2, value_size));
-		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
-				      offsetof(struct bpf_loader_ctx, flags)));
-		emit(gen, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, BPF_SKEL_KERNEL, 2));
-		emit(gen, BPF_EMIT_CALL(BPF_FUNC_copy_from_user));
-		emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
-		emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
-	}
+	if (!OPTS_GET(gen->opts, gen_hash, false))
+		emit_copy_initial_value(gen, map_idx, value, value_size, 0);
 
-	map_update_attr = add_data(gen, &attr, attr_size);
-	pr_debug("gen: map_update_elem: idx %d, value: off %d size %u, attr: off %d size %d\n",
-		 map_idx, value, value_size, map_update_attr, attr_size);
-	move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
-		       blob_fd_array_off(gen, map_idx));
-	emit_rel_store(gen, attr_field(map_update_attr, key), key);
-	emit_rel_store(gen, attr_field(map_update_attr, value), value);
-	/* emit MAP_UPDATE_ELEM command */
-	emit_sys_bpf(gen, BPF_MAP_UPDATE_ELEM, map_update_attr, attr_size);
-	debug_ret(gen, "update_elem idx %d value_size %d", map_idx, value_size);
-	emit_check_err(gen);
+	emit_map_update_elem(gen, map_idx, &attr, attr_size, key, value, value_size);
 }
 
 void bpf_gen__populate_outer_map(struct bpf_gen *gen, int outer_map_idx, int slot,
@@ -1214,6 +1243,77 @@ void bpf_gen__populate_outer_map(struct bpf_gen *gen, int outer_map_idx, int slo
 	emit_check_err(gen);
 }
 
+/*
+ * A copy of the read-only data map obj_map_idx for a program, with the offsets
+ * of its functions in it, see create_func_ptr_map() in libbpf.c. It's not
+ * a map of the object: it's not in the loader ctx. Its content is the content
+ * of obj_map_idx, that the host may supply when the skeleton is loaded, with
+ * ptr_cnt 64-bit ptr_vals at ptr_offs.
+ * Return the index of the map in fd_array for instructions to refer to.
+ */
+int bpf_gen__func_ptr_map_create(struct bpf_gen *gen, const char *map_name, int obj_map_idx,
+				 void *pvalue, __u32 value_size, const __u32 *ptr_offs,
+				 const __u64 *ptr_vals, int ptr_cnt)
+{
+	int attr_size = offsetofend(union bpf_attr, map_extra);
+	int map_create_attr, map_idx, key, value, zero = 0, i;
+	union bpf_attr attr;
+
+	if (gen->nr_func_ptr_maps == gen->max_func_ptr_maps) {
+		gen->error = -EDOM; /* internal bug */
+		return 0;
+	}
+	map_idx = gen->nr_obj_maps + gen->nr_func_ptr_maps++;
+
+	memset(&attr, 0, attr_size);
+	attr.map_type = tgt_endian(BPF_MAP_TYPE_ARRAY);
+	attr.key_size = tgt_endian((__u32)sizeof(int));
+	attr.value_size = tgt_endian(value_size);
+	attr.max_entries = tgt_endian((__u32)1);
+	attr.map_flags = tgt_endian((__u32)BPF_F_RDONLY_PROG);
+	if (map_name)
+		libbpf_strlcpy(attr.map_name, map_name, sizeof(attr.map_name));
+
+	map_create_attr = add_data(gen, &attr, attr_size);
+	pr_debug("gen: func_ptr_map_create: %s idx %d value_size %u, attr: off %d size %d\n",
+		 map_name, map_idx, value_size, map_create_attr, attr_size);
+	emit_sys_bpf(gen, BPF_MAP_CREATE, map_create_attr, attr_size);
+	debug_ret(gen, "func_ptr_map_create %s idx %d value_size %d", map_name, map_idx,
+		  value_size);
+	emit_check_err(gen);
+	/* remember map_fd in fd_array */
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, blob_fd_array_off(gen, map_idx)));
+	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_7, 0));
+
+	/* pvalue has the pointers already */
+	value = add_data(gen, pvalue, value_size);
+	key = add_data(gen, &zero, sizeof(zero));
+
+	/* see bpf_gen__map_update_elem() */
+	if (!OPTS_GET(gen->opts, gen_hash, false)) {
+		/* the jump over these instructions has 16-bit offset */
+		if (ptr_cnt > 10000) {
+			gen->error = -E2BIG;
+			return 0;
+		}
+		emit_copy_initial_value(gen, obj_map_idx, value, value_size, 3 * ptr_cnt);
+		/* the content that the host supplied doesn't have them */
+		for (i = 0; i < ptr_cnt; i++) {
+			emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+							 0, 0, 0, value + ptr_offs[i]));
+			emit(gen, BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, ptr_vals[i]));
+		}
+	}
+
+	attr_size = offsetofend(union bpf_attr, flags);
+	memset(&attr, 0, attr_size);
+	emit_map_update_elem(gen, map_idx, &attr, attr_size, key, value, value_size);
+
+	bpf_gen__map_freeze(gen, map_idx);
+	return map_idx;
+}
+
 void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx)
 {
 	int attr_size = offsetofend(union bpf_attr, map_fd);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b5c580ec02bc..2e11808f7508 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6553,19 +6553,19 @@ static int create_func_ptr_map(struct bpf_object *obj, struct bpf_program *prog,
 		    obj->func_ptr_maps[i].map_idx == map_idx)
 			return obj->func_ptr_maps[i].fd;
 
-	if (obj->gen_loader) {
-		pr_warn("prog '%s': map '%s': pointers to functions in data are not supported by light skeleton\n",
-			prog->name, map->name);
-		return -ENOTSUP;
-	}
-
 	data = malloc(value_size);
 	if (!data)
 		return -ENOMEM;
 
-	/* the content of the map is final, it's frozen already */
+	/*
+	 * The content of the map is final, it's frozen already. There is no map
+	 * when light skeleton is generated, but there is what it's created with.
+	 */
 	if (map->mmaped) {
 		memcpy(data, map->mmaped, value_size);
+	} else if (obj->gen_loader) {
+		err = -EINVAL;
+		goto err_free;
 	} else if (bpf_map_lookup_elem(map->fd, &zero, data)) {
 		err = -errno;
 		pr_warn("prog '%s': map '%s': failed to read the content: %s\n",
@@ -6595,6 +6595,9 @@ static int create_func_ptr_map(struct bpf_object *obj, struct bpf_program *prog,
 		} else {
 			val = (__u64)prog->subprogs[j].sub_insn_off * BPF_INSN_SZ;
 		}
+		/* light skeleton can be generated for a target of another endianness */
+		if (!is_native_endianness(obj))
+			val = bswap_64(val);
 		memcpy(data + ptrs[i].sec_off, &val, sizeof(val));
 	}
 
@@ -6610,6 +6613,8 @@ static int create_func_ptr_map(struct bpf_object *obj, struct bpf_program *prog,
 		if (j < cnt && ptrs[j].sec_off == i)
 			continue;
 		memcpy(&val, data + i, sizeof(val));
+		if (!is_native_endianness(obj))
+			val = bswap_64(val);
 		if (!val || val % BPF_INSN_SZ)
 			continue;
 		for (k = 0; k < prog->subprog_cnt; k++) {
@@ -6621,6 +6626,30 @@ static int create_func_ptr_map(struct bpf_object *obj, struct bpf_program *prog,
 		}
 	}
 
+	if (obj->gen_loader) {
+		__u32 *ptr_offs = calloc(cnt, sizeof(*ptr_offs));
+		__u64 *ptr_vals = calloc(cnt, sizeof(*ptr_vals));
+
+		if (!ptr_offs || !ptr_vals) {
+			free(ptr_offs);
+			free(ptr_vals);
+			err = -ENOMEM;
+			goto err_free;
+		}
+		for (i = 0; i < cnt; i++) {
+			ptr_offs[i] = ptrs[i].sec_off;
+			memcpy(&ptr_vals[i], data + ptrs[i].sec_off, sizeof(val));
+			if (!is_native_endianness(obj))
+				ptr_vals[i] = bswap_64(ptr_vals[i]);
+		}
+		/* it's an index in fd_array of the loader, not an fd */
+		map_fd = bpf_gen__func_ptr_map_create(obj->gen_loader, map->name, map_idx, data,
+						      value_size, ptr_offs, ptr_vals, cnt);
+		free(ptr_offs);
+		free(ptr_vals);
+		goto done;
+	}
+
 	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, map->name, sizeof(int), value_size, 1, &opts);
 	if (map_fd < 0) {
 		err = map_fd;
@@ -6634,6 +6663,7 @@ static int create_func_ptr_map(struct bpf_object *obj, struct bpf_program *prog,
 		err = -errno;
 		goto err_close;
 	}
+done:
 
 	tmp = libbpf_reallocarray(obj->func_ptr_maps, obj->func_ptr_map_cnt + 1,
 				  sizeof(*obj->func_ptr_maps));
@@ -6653,7 +6683,8 @@ static int create_func_ptr_map(struct bpf_object *obj, struct bpf_program *prog,
 	return map_fd;
 
 err_close:
-	close(map_fd);
+	if (!obj->gen_loader)
+		close(map_fd);
 err_free:
 	free(data);
 	return err;
@@ -6706,7 +6737,8 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 						prog->name, i, map->name);
 					return map_fd;
 				}
-				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
+				insn[0].src_reg = obj->gen_loader ? BPF_PSEUDO_MAP_IDX_VALUE :
+								    BPF_PSEUDO_MAP_VALUE;
 				insn[0].imm = map_fd;
 			} else if (obj->gen_loader) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
@@ -9583,8 +9615,17 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	 * permit cross-endian creation of "light skeleton".
 	 */
 	if (obj->gen_loader) {
+		int nr_func_ptr_maps = 0, nr_progs = 0, i;
+
+		/* every program may get a copy of every map with pointers to functions */
+		for (i = 0; i < obj->nr_maps; i++)
+			if (obj->maps[i].autocreate && obj->maps[i].func_ptr_cnt)
+				nr_func_ptr_maps++;
+		for (i = 0; i < obj->nr_programs; i++)
+			if (obj->programs[i].autoload && !prog_is_subprog(obj, &obj->programs[i]))
+				nr_progs++;
 		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level,
-			      obj->nr_programs, obj->nr_maps);
+			      obj->nr_programs, obj->nr_maps, nr_func_ptr_maps * nr_progs);
 	} else if (!is_native_endianness(obj)) {
 		pr_warn("object '%s': loading non-native endianness is unsupported\n", obj->name);
 		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
@@ -10125,7 +10166,8 @@ void bpf_object__close(struct bpf_object *obj)
 	zfree(&obj->jumptable_maps);
 
 	for (i = 0; i < obj->func_ptr_map_cnt; i++)
-		close(obj->func_ptr_maps[i].fd);
+		if (!obj->gen_loader)
+			close(obj->func_ptr_maps[i].fd);
 	zfree(&obj->func_ptr_maps);
 	zfree(&obj->func_ptrs);
 
-- 
2.55.0

