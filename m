Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D84F6482
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416165; cv=none; b=Nu2TnMNt7SjilhEoV57Jei36cyxrQoyXDH3UYMWb5fF+RbiesjWLq55hDuYHk8c63+wt6O0c8Zwfx1oNcWXur3QC46rgA4uI2UYwSknPxWYxgvBxQ4GXwUZOH3gyISWeUpfq50u7PtgwMyduF8f8WCRAmu9IM+UeO2JLhTGzJhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416165; c=relaxed/simple;
	bh=b/t8ZuWZDUKOV/2tRDFiPuCX5yZQmsGWn7miL09onxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgLVo0wvpdCK1ADjX7Gu5ndwTBjDOTD0C9zfgtzWQyvhag3nxRikxxo810Fc6EW/4WnGNGGlqwnV7EIniY15X62ZkxsZ6BxYM7TqEz5pWEKwpRVeywfLjUOudqIoNR2Gy5ywCbS3q+K6o9kkF8Y6ULYtj8ZnLGzC0Po2zo7D8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcyEfySO; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcyEfySO"
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-4a77fe1bc0bso698506fac.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416162; x=1793020962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NeUTIgQ0KJJA+c9aUBWzGj/SnLdiQlWwxSsFBKrEdws=;
        b=XcyEfySOu/G65W40C/zwWbvzFSxZXcL2uiBcqwc8qg93retHf1N8eYeEct23cqlHT1
         DGk9dtMynJdjJFlZo38tXV0mLix7sBy59jMhj+nJSdXA50TIAYIokJiuMINNjPysZ+P0
         u27+tecc6/ZITqhTVS6WFPi9DboQiI0b4U7S/SLiHuZ5Ngu2Eu1JRH9NSLra48CJPUCe
         rsGvQMifSVL4G/Vqqgk0bTWyYFsrgRf9Z0UjISUTygsivQ5pyW6Z3eQikIkfJx/P/iR1
         a9kwxJ/uFYk3/OeFTAx4GUrBGtRY+lmGB0apqsWMnVFjFgbPjlqAFddPDjb+L5u0z6V4
         /ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416162; x=1793020962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NeUTIgQ0KJJA+c9aUBWzGj/SnLdiQlWwxSsFBKrEdws=;
        b=A7guwpaFk2QjLcCAAuh7mMn2g8YbWYXLx0zf7X+8Nbtn51rkfIqQVVSt+3uGtZTLo1
         z67z05ECgNxGHVO4vQBsSSURfdyDth+0pbTngoFTIfFimxa2hPFcBWfZw72KPGJ7EmU7
         xE0Odf5WMy8Ig4DKDVSfcU3F54MDZKMLsltIqueypOEDmWZyWMMu4zAQMW1FNg/oqEqe
         5RV0sfzav2jMosQJQFfmVk6bChHiZ4bgrldywGqyrXutCxY9etECFTgGyJOVnhYbfizK
         YThFfd2qgtbGu8KDLUx2JtMvp22pVhqB5suprIIHbIVoJmBvvyqrEaehAhAvNfUqBkdA
         Isvg==
X-Gm-Message-State: AFq9FYKuYxNdkvp4Ki//qOSvEz4PF3xMXJ9YcPiMpK4oRt6gRGHf0LmC
	TQgzYQCvenKwMcQnnOkt5ExyHyRteddkr8gKfvpWnB/3ZO0vjeRIVCzxJbd0Kqot6FY=
X-Gm-Gg: AYBFou3gefvuiWgmR+wSdo97KYhGbyJ6aGXk1Sy/hQ8SrT3fEl6T3UABn1iO/JUOjHS
	YcEvVK8Wb8/4+ExLt27+agbSdq7rNJHM0IGghPix2+tS0yE1eKBB6L2BzalP7uXT0mQutqz4Jsf
	bAMxFIFVybuwLxpGqxSGD4jUusKDoq7rJCF2tIs146t1uQ1Z2vS1+ERCi2hLNoYqh/X2jmD51N0
	ks/buwDGcRrB9Z9M2MOqSsPpTJuWGDvmb02gecuQR0l3gg/hf/GwtrLExqnasyeMUzwqRH+kzmi
	MEKrIA4khJr9JN5zXIzk4rCIMuLLxAsA9GFavNtX9VFNWDTTHeENprEGX5DfSZ9jiOMWOHVGH9y
	pO96bNlMBdq6ZYIXD8iHjAQVXEYiDeTHJJB1MisOxniSMqLe6TDT8BlDx34eDfiHSzq0auE8uTF
	7g+q5ZPVdrU6CVicryjMBgw1HOigSJHhLb7KajNUMUP1ZCnC/IEv9L/M9vq//U3wgcBxIokB+9R
	B1rO6CSdPCoQJhiG1d35yJ58L8rt8c10wMw0q12pGSRNWZtWPOSeSNXG1tt41MrA5TnPr2Tr81m
	z+5Swg==
X-Received: by 2002:a05:6808:ec3:b0:4d6:90d3:e18e with SMTP id 5614622812f47-53cd1cbb717mr5564226b6e.45.1792416161582;
        Mon, 19 Oct 2026 06:22:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:10::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b63cff2sm7949930fac.7.2026.10.19.06.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:39 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 11/16] libbpf: Bind the arena of an object to every program in it
Date: Mon, 19 Oct 2026 15:21:53 +0200
Message-ID: <20261019132203.3034698-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10987; h=from:subject; bh=b/t8ZuWZDUKOV/2tRDFiPuCX5yZQmsGWn7miL09onxE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxFGZm9U3pCTy+N+6Nf+O/+hk+nLXOpP2GfeOtmxOvmTM oX2zo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABORWM3w32uhfX1Y0nvxnh2r7y1UVU o0FIpbKVtxa9X8ixM+P9BYbsLw30Vi74kHDkG75m7zOCSklJ0ecnF//Ze7UVssdzNeW7xgLhsA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A program has an arena only when one of its insns refers to the arena
map. The kernel can hand a program arena pointers all the same: as
__arena struct_ops arguments, through __arena struct members and as
kfunc return values. The verifier rejects those in a program without an
arena, since it has nowhere to place them, and so a struct_ops callback
that touches nothing but its arguments fails to load until it refers to
the arena artificially, e.g. with asm volatile("" :: "r"(&arena)).

Bind the arena of an object to every program loaded from it. The kernel
binds the maps of a continuous fd_array (fd_array_cnt) like maps an insn
refers to, so pass the arena in slot 0, which is free: a kfunc insn with
offset 0 names vmlinux BTF rather than a slot. The module BTF slots that
follow stay as they are. A feature probe keeps older kernels, which
reject a non-zero fd_array_cnt, on the previous behavior.

An object has at most one arena, libbpf refuses a second one, so there
is no ambiguity about which arena a program gets. Programs that never
touch the arena see it among their maps, and pay for the arena base
setup in their JIT prologue until a later patch spares them that; the
arena now lives as long as any program of the object. With the count,
the kernel also resolves every module BTF slot of the array for every
program of the object, so each of them holds the modules the object
calls into, not only the programs that call them. Where the JIT is
disabled or the loader lacks CAP_PERFMON, every program of such an
object now fails to load, since an arena needs both, where before only
the programs using the arena did. bpf_program__clone() binds the arena
the same way, so a program loads through veristat as it does through
bpf_object__load(). An arena exclusive to another program and the
light skeleton loader are left alone.

An arena exclusive to the program itself is bound only where the kernel
checks an exclusive map against the digest of the final program. Earlier
kernels compared a map bound through the fd_array against a digest they
had not computed yet and refused the load for the very program the map
is exclusive to, so a second probe loads a program with a map exclusive
to it through fd_array_cnt; where that fails, the program keeps binding
its arena through its insns, as before.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/features.c        | 82 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 66 +++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |  4 ++
 3 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 9f589980beef..adb5d2e7fdfa 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -77,6 +77,82 @@ static int probe_kern_global_data(int token_fd)
 	return probe_fd(ret);
 }
 
+/*
+ * A continuous fd_array binds every map in it to the program, whether an
+ * insn refers to the map or not. Kernels without the attribute reject a
+ * non-zero fd_array_cnt.
+ */
+static int probe_kern_fd_array_cnt(int token_fd)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+		.fd_array_cnt = 1,
+	);
+	int ret, map, insn_cnt = ARRAY_SIZE(insns);
+
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int), sizeof(int), 1,
+			     &map_opts);
+	if (map < 0) {
+		ret = -errno;
+		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
+			__func__, errstr(ret));
+		return ret;
+	}
+
+	prog_opts.fd_array = &map;
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &prog_opts);
+	close(map);
+	return probe_fd(ret);
+}
+
+/*
+ * The kernel checks an exclusive map bound through fd_array_cnt against the
+ * digest of the final program. Earlier kernels compared it as the map was
+ * added, against a digest they had not computed yet, and refused the load for
+ * the very program the map is exclusive to; kernels without exclusive maps
+ * refuse the map.
+ */
+static int probe_kern_excl_map_fd_array_cnt(int token_fd)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	__u8 hash[SHA256_DIGEST_LENGTH];
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+		.excl_prog_hash = hash,
+		.excl_prog_hash_size = sizeof(hash),
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+		.fd_array_cnt = 1,
+	);
+	int ret, map, insn_cnt = ARRAY_SIZE(insns);
+
+	libbpf_sha256(insns, sizeof(insns), hash);
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_excl", sizeof(int), sizeof(int), 1,
+			     &map_opts);
+	if (map < 0)
+		return 0;
+
+	prog_opts.fd_array = &map;
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &prog_opts);
+	close(map);
+	return probe_fd(ret);
+}
+
 static int probe_kern_btf(int token_fd)
 {
 	static const char strs[] = "\0int";
@@ -742,6 +818,12 @@ static struct kern_feature_desc {
 	[FEAT_PERCPU_DATA] = {
 		"kernel supports percpu data", probe_kern_percpu_data,
 	},
+	[FEAT_FD_ARRAY_CNT] = {
+		"continuous fd_array (fd_array_cnt)", probe_kern_fd_array_cnt,
+	},
+	[FEAT_EXCL_MAP_FD_ARRAY_CNT] = {
+		"exclusive map bound through fd_array_cnt", probe_kern_excl_map_fd_array_cnt,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fcedb78abe00..8fcb8cf39cc0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -797,7 +797,8 @@ struct bpf_object {
 	/*
 	 * Slots handed out so far, slot 0 included. A kfunc insn names a module
 	 * BTF slot through its offset, slot 0 stands for vmlinux BTF and stays
-	 * empty, so the array goes to the kernel without a count.
+	 * empty, so the array goes to the kernel without a count, unless
+	 * bpf_object__bind_arena() puts the arena of the object there.
 	 */
 	size_t fd_array_used;
 
@@ -8804,6 +8805,56 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 
 static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz);
 
+/*
+ * Bind the arena of the object to the program about to be loaded. A program
+ * has an arena only when an insn refers to the map, but the kernel can hand
+ * it arena pointers all the same, as struct_ops arguments, through tagged
+ * struct members or as kfunc return values, and the verifier rejects those
+ * when the program has no arena to place them in. A continuous fd_array
+ * binds every map in it, the arena takes slot 0, which is free: a kfunc insn
+ * with offset 0 names vmlinux BTF rather than a slot.
+ */
+static int bpf_object__bind_arena(struct bpf_object *obj, struct bpf_program *prog,
+				  struct bpf_prog_load_opts *load_attr)
+{
+	struct bpf_map *map;
+	int err;
+
+	if (obj->gen_loader || obj->arena_map_idx < 0 || !kernel_supports(obj, FEAT_FD_ARRAY_CNT))
+		return 0;
+	map = &obj->maps[obj->arena_map_idx];
+	/*
+	 * Nothing to bind when the arena is not created, or no longer is after
+	 * a failed load, when it is exclusive to another program, and nothing
+	 * for an offloaded program, which the kernel does not let near an
+	 * arena.
+	 */
+	if (!map->autocreate || map->fd < 0 || (map->excl_prog && map->excl_prog != prog) ||
+	    load_attr->prog_ifindex)
+		return 0;
+	/*
+	 * An arena exclusive to the program itself needs a kernel that checks
+	 * the map against the digest of the final program. Earlier kernels
+	 * compared a map bound through the fd_array against a digest they had
+	 * not computed yet and refused the load; there the program binds its
+	 * arena through its insns, as before.
+	 */
+	if (map->excl_prog && !kernel_supports(obj, FEAT_EXCL_MAP_FD_ARRAY_CNT))
+		return 0;
+
+	if (!obj->fd_array_used) {
+		err = libbpf_ensure_mem((void **)&obj->fd_array, &obj->fd_array_cap, sizeof(int), 1);
+		if (err)
+			return err;
+		obj->fd_array_used = 1;
+	}
+	obj->fd_array[0] = map->fd;
+	load_attr->fd_array = obj->fd_array;
+	/* with slot 0 filled every slot handed out is valid, so the array can go with a count */
+	load_attr->fd_array_cnt = obj->fd_array_used;
+	return 0;
+}
+
 static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
 				struct bpf_insn *insns, int insns_cnt,
 				const char *license, __u32 kern_version, int *prog_fd)
@@ -8867,6 +8918,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	if (obj->data_in_arena)
 		load_attr.prog_flags |= BPF_F_ARENA_SCALAR;
 	load_attr.fd_array = obj->fd_array;
+	err = bpf_object__bind_arena(obj, prog, &load_attr);
+	if (err)
+		return err;
 
 	load_attr.token_fd = obj->token_fd;
 	if (obj->token_fd)
@@ -9966,8 +10020,10 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
 
 static void bpf_object_post_load_cleanup(struct bpf_object *obj)
 {
-	/* clean up fd_array */
+	/* clean up fd_array, and the slots handed out with it */
 	zfree(&obj->fd_array);
+	obj->fd_array_cap = 0;
+	obj->fd_array_used = 0;
 
 	/* clean up BTF */
 	bpf_object_cleanup_btf(obj);
@@ -10946,6 +11002,12 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 	attr.kern_version = OPTS_GET(opts, kern_version, 0) ?: obj->kern_version;
 	attr.fd_array = OPTS_GET(opts, fd_array, NULL) ?: obj->fd_array;
 	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
+	/* the arena of the object goes with the program, as in bpf_object__load() */
+	if (!OPTS_GET(opts, fd_array, NULL) && !OPTS_GET(opts, fd_array_cnt, 0)) {
+		err = bpf_object__bind_arena(obj, prog, &attr);
+		if (err)
+			return libbpf_err(err);
+	}
 	attr.token_fd = OPTS_GET(opts, token_fd, 0) ?: obj->token_fd;
 	if (attr.token_fd)
 		attr.prog_flags |= BPF_F_TOKEN_FD;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4e45dfacb548..e90b5336bac0 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -404,6 +404,10 @@ enum kern_feature_id {
 	FEAT_BPF_SYSCALL_COMMON_ATTRS,
 	/* Kernel supports percpu data */
 	FEAT_PERCPU_DATA,
+	/* Kernel binds every map in a continuous fd_array (fd_array_cnt) to the program */
+	FEAT_FD_ARRAY_CNT,
+	/* Kernel checks an exclusive map bound through fd_array_cnt against the final digest */
+	FEAT_EXCL_MAP_FD_ARRAY_CNT,
 	__FEAT_CNT,
 };
 
-- 
2.53.0-Meta

