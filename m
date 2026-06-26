Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07062D3733
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510678; cv=none; b=FrnGI6UYdX+bKbhNOZWODFIffF9uBaoEhql1u7p/NWr+ecVEXmylfuuo/cDQf3PAO7hZDAzueNlNNweWSCMjCITqfB+f54sf1A26K7FrtPO00alsCy9QhlnQHzMu4ekgJOxcZfqYb+ZZEoHLsvo+XvDqe4yDkivgfn7OYxxrpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510678; c=relaxed/simple;
	bh=xgj1fqSaty7d1w67uP5clpyIMX7/l3LQjR4zlkQ7jyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7LB8gceN1QtXE0pl/Ts5glPeBsWNytfMZiRAjWWHBqMYVla1Egf/G0Ehn6uGY8M/XLBpG0cq6anzqorC7O8tlPHe8CfNeKsMonXtCVyc5fNAl8D4ojuSlkVdCvSD6aKQpsBYC9mIKD+qD2BG4Hes5kjGYUYkrFfYoTnxZGdR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSxKRzE6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSxKRzE6"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37d70036426so751628a91.3
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 14:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782510676; x=1783115476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BFr7v/InQf8mH9/7LssCzsBvQ3fJSj/tv3rkGJ45ApU=;
        b=eSxKRzE6cwzA43VxqHRypE0snXXTtDY8IptvXkmgjfMAIZy1WnyOxiV0ZOuDctI8yx
         EK9bEnI8/acHnBykAhkbw3zx4AGEWy3u0RudOEpnVgV/5aWM4rLGU7XDV+yi3mRk4g5j
         lqVCgZCC/jhvy3ry0qsY7WiTvUZNMS7lCTfN6I+eHKLYrsQ3eYEpPyhEsDm3fwL6Oebd
         7SXk9fTn1ASXjMWgLmi+q1LIZ3uQnMb1tUmWuEpzwtvZql9glrn1wBgDeUl5bCz0EmcJ
         8TCciGoytRwQY5vkQZLjO8jDMfTs3JSScajxlUR0Uk2v7P98EdnuCH/+jTO16v4M7R7h
         ctZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782510676; x=1783115476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFr7v/InQf8mH9/7LssCzsBvQ3fJSj/tv3rkGJ45ApU=;
        b=Ku+TynVMiDgomKpfVKjZFJS+8NzoPN4gqj4AIwyz5MEgOWk+wSXKitNbKX8bl3fp0s
         y7AfiNKyvm4q5QJgFm8qumw5v46mFt/JjpyhxHoSl8FHbz26U3mkuvQFSnHwcQioRlAE
         C5kaGh0yrWqi3g9Uc7rY3lq3w6U4xEkvUtS7594iGL5TADd+1pg1d4RKbz5p0iRaRyeJ
         8zG0cM6dsYcLJ68m28dFu8hHBrcpKtLroWBE0pTjWgikOfPTa1xD8zdVyzEvBAfuZoVc
         lkaS25MvsDIpP05ez0uu5Sx5X4vVJHgCoPvei0uDNLXXU8YltXkUvF25aWYAjFb1l/J/
         v5lA==
X-Gm-Message-State: AOJu0Yyfi33WfMkCHanR+DUT2ye2WBIAlwv5FCXi46oNsJEQ7ZZZlZAc
	9rhXjC5rdEffmvvU5zEhdzNhDcW6WrByOBTvvtyzVQOMdJVF6mWWjEhQZwLQew==
X-Gm-Gg: AfdE7clUJGMmU+atQB0yxZk/GEIRfwof6XolifhBa2LzG0qrzHBIrf8bFfymbIdnKoT
	1sABhB5a6ZCc03peL3nBBkkes+o5f0QgQJ4BYaPFGBGoGZp7OipU1vstzD1Y/iESq0NA0jR2ecW
	gSBhxF11OZChCHWLK6NFzVblhJJeDcu4icPWrujUQArqWEeE6PAvNwmQuuFdhgX76fNjweM5ibC
	8clSmTMC4HMXiOcTwXkfRrjRs6DlaVG4W6gbViDunN3ztsCwl/3fOuEawk4rPG+HzQU6y+r70+P
	I4Rgc1/iuYwGFe2iznYo31/EN5wdJ1Z/kfdRtTyz4NmabQya0Oi10IQi0bPCMu4e+2SIla9fYXg
	h5DfqWx6DH2IdsU/UbGGBrEvRlvkz51h2ZX6RLn0qlG035cBQNaElPmhr+1i38UryH7kVgI1YPp
	KvyU8kdaQR4Bo=
X-Received: by 2002:a05:6a20:6a20:b0:3bf:6c08:2b2a with SMTP id adf61e73a8af0-3bf6c084acemr1730132637.50.1782510675991;
        Fri, 26 Jun 2026 14:51:15 -0700 (PDT)
Received: from john-p8 ([98.97.43.120])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92ba0a8666sm4110799a12.13.2026.06.26.14.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:51:15 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	daniel@iogearbox.net
Subject: [PATCH bpf-next 1/2] libbpf: add bpf_map__reuse_fd_from_loader_ctx() to allow shared maps
Date: Fri, 26 Jun 2026 14:51:12 -0700
Message-ID: <20260626215113.52273-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This lets the gen_loader use a map that may already be loaded/pinned on
the target system. When we are loading many signed programs on the target
we often need them to share maps to communicate/pass data between the
programs.

Note it is slightly complicated by needing to ensure on error/close that
we only emit_sys_close_blob() for map ids that are not these shared
type otherwise we could close a shared map unintentionally. To track this
we added a borrowed_fd_array.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/lib/bpf/bpf_gen_internal.h |  2 ++
 tools/lib/bpf/gen_loader.c       | 50 ++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.c           | 11 +++++++
 tools/lib/bpf/libbpf.h           |  1 +
 tools/lib/bpf/libbpf.map         |  1 +
 5 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 49af4260b8e6..e555c3165105 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -50,6 +50,7 @@ struct bpf_gen {
 	struct ksym_desc *ksyms;
 	__u32 nr_ksyms;
 	int fd_array;
+	int borrowed_fd_array;
 	int nr_fd_array;
 	int hash_insn_offset[SHA256_DWORD_SIZE];
 };
@@ -62,6 +63,7 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 			 enum bpf_map_type map_type, const char *map_name,
 			 __u32 key_size, __u32 value_size, __u32 max_entries,
 			 struct bpf_map_create_opts *map_attr, int map_idx);
+void bpf_gen__map_reuse_fd(struct bpf_gen *gen, int map_idx);
 void bpf_gen__prog_load(struct bpf_gen *gen,
 			enum bpf_prog_type prog_type, const char *prog_name,
 			const char *license, struct bpf_insn *insns, size_t insn_cnt,
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index c7f2d2ac7bb3..1cb00e0244b5 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -47,6 +47,11 @@ static int blob_fd_array_off(struct bpf_gen *gen, int index)
 	return gen->fd_array + index * sizeof(int);
 }
 
+static int blob_borrowed_fd_array_off(struct bpf_gen *gen, int index)
+{
+	return gen->borrowed_fd_array + index * sizeof(int);
+}
+
 static int realloc_insn_buf(struct bpf_gen *gen, __u32 size)
 {
 	size_t off = gen->insn_cur - gen->insn_start;
@@ -111,6 +116,7 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
 
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size);
 static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
+static void emit_sys_close_owned_blob(struct bpf_gen *gen, int map_idx);
 static void emit_signature_match(struct bpf_gen *gen);
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps)
@@ -119,6 +125,7 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	int i;
 
 	gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));
+	gen->borrowed_fd_array = add_data(gen, NULL, nr_maps * sizeof(int));
 	gen->log_level = log_level;
 	/* save ctx pointer into R6 */
 	emit(gen, BPF_MOV64_REG(BPF_REG_6, BPF_REG_1));
@@ -137,9 +144,10 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 			      /* size of cleanup code below (including map fd cleanup) */
 			      (nr_progs_sz / 4) * 3 + 2 +
 			      /* 6 insns for emit_sys_close_blob,
+			       * 4 insns for borrowed fd check,
 			       * 6 insns for debug_regs in emit_sys_close_blob
 			       */
-			      nr_maps * (6 + (gen->log_level ? 6 : 0))));
+			      nr_maps * (10 + (gen->log_level ? 6 : 0))));
 
 	/* remember the label where all error branches will jump to */
 	gen->cleanup_label = gen->insn_cur - gen->insn_start;
@@ -150,7 +158,7 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 		emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
 	}
 	for (i = 0; i < nr_maps; i++)
-		emit_sys_close_blob(gen, blob_fd_array_off(gen, i));
+		emit_sys_close_owned_blob(gen, i);
 	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
 	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
 	emit(gen, BPF_EXIT_INSN());
@@ -377,6 +385,17 @@ static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off)
 	__emit_sys_close(gen);
 }
 
+static void emit_sys_close_owned_blob(struct bpf_gen *gen, int map_idx)
+{
+	int close_insn_cnt = 6 + (gen->log_level ? 6 : 0);
+
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, blob_borrowed_fd_array_off(gen, map_idx)));
+	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0));
+	emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, close_insn_cnt));
+	emit_sys_close_blob(gen, blob_fd_array_off(gen, map_idx));
+}
+
 static void compute_sha_update_offsets(struct bpf_gen *gen);
 
 int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
@@ -460,6 +479,11 @@ void bpf_gen__free(struct bpf_gen *gen)
 	_val;							\
 })
 
+static void set_blob_borrowed_fd_array_off(struct bpf_gen *gen, int index)
+{
+	*(__u32 *)(gen->data_start + blob_borrowed_fd_array_off(gen, index)) = tgt_endian(1);
+}
+
 static void compute_sha_update_offsets(struct bpf_gen *gen)
 {
 	__u64 sha[SHA256_DWORD_SIZE];
@@ -596,6 +620,28 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 		emit_sys_close_stack(gen, stack_off(inner_map_fd));
 }
 
+void bpf_gen__map_reuse_fd(struct bpf_gen *gen, int map_idx)
+{
+	int idx;
+
+	if (map_idx != gen->nr_maps) {
+		gen->error = -EDOM;
+		return;
+	}
+
+	idx = add_map_fd(gen);
+	if (gen->error)
+		return;
+
+	set_blob_borrowed_fd_array_off(gen, idx);
+	move_ctx2blob(gen, blob_fd_array_off(gen, idx), 4,
+		      sizeof(struct bpf_loader_ctx) +
+		      sizeof(struct bpf_map_desc) * map_idx +
+		      offsetof(struct bpf_map_desc, map_fd),
+		      false);
+	pr_debug("gen: map_reuse_fd idx %d\n", map_idx);
+}
+
 static void emit_signature_match(struct bpf_gen *gen)
 {
 	__s64 off;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7162146280a8..af1553e9d4df 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5085,6 +5085,15 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	return libbpf_err(err);
 }
 
+int bpf_map__reuse_fd_from_loader_ctx(struct bpf_map *map)
+{
+	if (map_is_created(map))
+		return libbpf_err(-EBUSY);
+
+	map->reused = true;
+	return 0;
+}
+
 __u32 bpf_map__max_entries(const struct bpf_map *map)
 {
 	return map->def.max_entries;
@@ -5659,6 +5668,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 		}
 
 		if (map->reused) {
+			if (obj->gen_loader)
+				bpf_gen__map_reuse_fd(obj->gen_loader, map - obj->maps);
 			pr_debug("map '%s': skipping creation (preset fd=%d)\n",
 				 map->name, map->fd);
 		} else {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..4145a16c8963 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1135,6 +1135,7 @@ LIBBPF_API bool bpf_map__autoattach(const struct bpf_map *map);
  */
 LIBBPF_API int bpf_map__fd(const struct bpf_map *map);
 LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
+LIBBPF_API int bpf_map__reuse_fd_from_loader_ctx(struct bpf_map *map);
 /* get map name */
 LIBBPF_API const char *bpf_map__name(const struct bpf_map *map);
 /* get/set map type */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b731df19ae69..d6c2f1d75cda 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,6 +458,7 @@ LIBBPF_1.7.0 {
 
 LIBBPF_1.8.0 {
 	global:
+		bpf_map__reuse_fd_from_loader_ctx;
 		bpf_program__attach_tracing_multi;
 		bpf_program__clone;
 		btf__new_empty_opts;
-- 
2.53.0

