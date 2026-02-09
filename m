Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D42E06ED
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670965; cv=none; b=e8kdb6P4ndaSFoTzvMJQwnJfMOqLATU4yYc0j/LBPCXcTS5BIBUeu8XSSwRyTDWWimP1Pk4u9QbCC2cz9R0sQb7O/0PtLs1q2BIUIxWo/TXrpb+bp9+H3GIGLdFirKwxex+awNbrMMLx9uW5B+JYQ46Nbh2xpzIcXH6YTK7r0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670965; c=relaxed/simple;
	bh=uthVYtoK6Py2p6tfpDG5ceZ4HUaz7JyNRMMenj6wHo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrvIKv2+iuL4d1a1E0XctKOgFanUSgnY/qTww/idMd6W2x39AUcRpRwCeYr2EUuuFI4p3mynGprUfRFW17L5DwuqYWhPqKpP3Y2W4SEx3oWSISTnVLl5zLqEFUvCzX/tUuSip+5gviNr6RQ0FwW3J9xEwd7uoRhT+E8NlIsQ47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=iGwe1yop; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="iGwe1yop"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8947e6ffd30so37426826d6.0
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 13:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770670963; x=1771275763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UpznQ5QtKL+/BMnmaM7AmayREmS/8IKGCYsK08yInlY=;
        b=iGwe1yopujhEoxn9gTPt8UkIleDH1Bqf0od+wDUQuc5hIOf5a443X8+TBRHErV2Ng5
         vwfMQeIHulexFh0SDeks9kLHFRJBzomlvK3pxZsnzsWKlJu1kYjvDD5k0r9PtDWTEQPg
         RYuFb4NZy20F4WeeZG1sReuDLgTT64IKwjfSyZcD4Or7FWT6noUNoLi7cXiU43kAFXQz
         U+6sIot6Do7rw4kh+IsuVPKbcn+qsHvJyU89Cn8fLDe5BsI048ej7oa2zulzfWgMfi7c
         fLpEGWA79+oH/ai/MzIAQ3MDP+taceN+6sqL/VBx/5yTfoTF5aPZiqf2aFPtBQSWCQru
         PVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670963; x=1771275763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpznQ5QtKL+/BMnmaM7AmayREmS/8IKGCYsK08yInlY=;
        b=NO1B4ZLEjyN532wCRNgiw0Syi4dJ97ePUi2nKE42j2sGXEqOZ2vK4SRuDdlU9t0fQB
         NiTEOaI4de/kBComoQsLhU1LMZt+Xwc52ZLPUEdt6Cq0LyWcVZ8qQMPeT0oV+Jch3xM9
         y1rnc/VJ93ZWDA848WaxpftTOFBavbpQK7GvRAfdrFZzcPZR6k443tjiC8TTOg9NSqv/
         0/LiokbAeLlRIvqiuad4CroF4qd6zwUecXYZlgoZLeGNczx42nY99WVfgtTS8QEgLD77
         0CQaX92ZhMuarq4QT5wx3k9GLXx6z11wrTzIuOZuwG9pqlC8uv0u0dUA+HBJr08Q7/oF
         GJSQ==
X-Gm-Message-State: AOJu0YzilDSiLtOJELVpjqeQBAnK8gEet0hFunpgPICTRBmyKNikhPB2
	2xWviSNbUGn9UjbQqF95/HYjjhDbm7jVAf+ZfmAeFyo8ZlzXWt/JyCzujJNpzzEC2TueCJLx+bd
	gQeJGn8Q=
X-Gm-Gg: AZuq6aJmB+2dj/tDoVqqutsEfFFVt34gv8zlj0rwwNLmCoxv5bYU7Fawoq0ms5oros+
	qTBjpqBvv0vrzjm1G5D9UNAKiA2Ndd303Z8ZL8qLsFakhLXGvpQJXufBmv/oD4qUetx8fUC4dXM
	3Qfio4NjxQojELdweZNJ5rcZ3uS1NnutHAyDdoTKXGK8bs+p8+h+Bkg3AywZl2n9ddOMMtA/vr5
	PHBQU9/nc6pEI8R01Wu+TMP0a55R1mkt9yamIBdWxdjwbe9kpAQzlYeWGIBQ+DEWCMMxdlESmQA
	0mBHlUD1SU4NrSCwMkY3xJW5d1YWkFjfL/m6NyADPQEJS9HBkNbKBnv3dhpRUKDIGppkKLjMme7
	7jPhhBtVsbCPBosHAlvag00y4KrELjuRpecgbIQAUobgRU3mc6petcB2bq1PiGCFDWTxwtnWJNY
	hVig81IFACyw==
X-Received: by 2002:a05:6214:1d27:b0:895:4bec:c629 with SMTP id 6a1803df08f44-8954becc85cmr117850336d6.31.1770670962859;
        Mon, 09 Feb 2026 13:02:42 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c0574a0sm87063816d6.40.2026.02.09.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:02:42 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next] libbpf: Add gating for arena globals relocation feature
Date: Mon,  9 Feb 2026 16:02:40 -0500
Message-ID: <20260209210240.2051209-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add feature gating for the arena globals relocation introduced in
commit c1f61171d44b. The commit depends on a previous commit in the same
patchset that is absent from older kernels, causing arena programs using
arenas >= 512MiB to fail to load and breaking libbpf's backwards
compatibility. Introduce a libbpf feature to check whether the running
kernel includes the required patch and only relocate arena globals
if it does.

Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the arena")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/include/linux/filter.h    |  10 ++
 tools/lib/bpf/features.c        | 178 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          |   7 +-
 tools/lib/bpf/libbpf_internal.h |   2 +
 4 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index bcc6df79301a..70d4b5c08a7e 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -366,4 +366,14 @@
 		.off   = 0,					\
 		.imm   = 0 })
 
+/* Program address space cast from 1 -> 0 */
+
+#define BPF_ADDR_SPACE_CAST_TO_ARENA(REG)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
+		.dst_reg = REG,					\
+		.src_reg = REG,					\
+		.off   = BPF_ADDR_SPACE_CAST,			\
+		.imm   = 1U })
+
 #endif /* __TOOLS_LINUX_FILTER_H */
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b842b83e2480..a412b63b3e96 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -7,6 +7,8 @@
 #include "libbpf_common.h"
 #include "libbpf_internal.h"
 
+#include <sys/mman.h>
+
 static inline __u64 ptr_to_u64(const void *ptr)
 {
 	return (__u64)(unsigned long)ptr;
@@ -506,6 +508,179 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+static int probe_kern_arena_global_reloc(int token_fd)
+{
+	long PAGE_SIZE = sysconf(_SC_PAGESIZE);
+	size_t arena_size = 1ULL << 32;
+	size_t arena_pages = arena_size / PAGE_SIZE;
+#if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
+	size_t arena_offset = 1ULL << 32;
+#else
+	size_t arena_offset = 1ULL << 44;
+#endif
+
+	int btf_fd, prog_fd, map;
+	void *mapping;
+	int insn_cnt;
+	int ret;
+	static const char strs[] = "\0"
+		"int\0"				/* [1, 5) */
+		"arrind\0"			/* [5, 12) */
+		"counter\0"			/* [12, 20) */
+		"type\0"			/* [20, 25) */
+		"map_flags\0"			/* [25, 35) */
+		"max_entries\0"			/* [35, 47) */
+		"map_extra\0"			/* [47, 57) */
+		"arena\0"			/* [57, 63) */
+		"func";				/* [63, 68) */
+
+	/*
+	 * BTF for a trivial arena program, taken from a real compilation (some
+	 * autogenerated type names changed for brevity).
+	 */
+	/*
+	 * [1] PTR '(anon)' type_id=3
+	 * [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
+	 * [3] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=33
+	 * [4] INT 'arrind' size=4 bits_offset=0 nr_bits=32 encoding=(none)
+	 * [5] PTR '(anon)' type_id=6
+	 * [6] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1024
+	 * [7] PTR '(anon)' type_id=8
+	 * [8] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1048576
+	 * [9] ENUM64 '(anon)' encoding=UNSIGNED size=8 vlen=1
+	 * 	'__unique_value__COUNTER__' val=17592186044416ULL
+	 * [10] STRUCT '(anon)' size=32 vlen=4
+	 * 	'type' type_id=1 bits_offset=0
+	 * 	'map_flags' type_id=5 bits_offset=64
+	 * 	'max_entries' type_id=7 bits_offset=128
+	 * 	'map_extra' type_id=9 bits_offset=192
+	 * [11] VAR 'arena' type_id=10, linkage=global
+	 * [12] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
+	 * [13] FUNC 'func' type_id=12 linkage=global
+	 */
+	const __u32 types[] = {
+		/* [1] PTR '(anon)' type_id=3 */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 3),
+
+		/* [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED */
+		BTF_TYPE_INT_ENC(1 /* "int" */, BTF_INT_SIGNED, 0, 32, 4),
+
+		/* [3] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=33 */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_ARRAY, 0, 0), 0),
+		/* struct btf_array [type, index_type, nelems] */
+		2, 4, 33,
+
+		/* [4] INT 'arrind' size=4 bits_offset=0 nr_bits=32 encoding=(none) */
+		BTF_TYPE_INT_ENC(5 /* "arrind" */, 0, 0, 32, 4),
+
+		/* [5] PTR '(anon)' type_id=6 */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 6),
+
+		/* [6] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1024 */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_ARRAY, 0, 0), 0),
+		/* struct btf_array [type, index_type, nelems] */
+		2, 4, 1024,
+
+		/* [7] PTR '(anon)' type_id=8 */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 8),
+
+		/* [8] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1048576 */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_ARRAY, 0, 0), 0),
+		/* struct btf_array [type, index_type, nelems] */
+		2, 4, 1U << 20,
+
+		/* [9] ENUM64 '(anon)' encoding=UNSIGNED size=8 vlen=1 */
+		/* 	'counter' val=17592186044416ULL */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+		 /* struct btf_enum64 [name_off, val_lo32, val_hi32 */
+		12 /* counter */, 0, 1U << 12,
+
+		/* [10] STRUCT '(anon)' size=32 vlen=4 */
+		/* 	'type' type_id=1 bits_offset=0 */
+		/* 	'map_flags' type_id=5 bits_offset=64 */
+		/* 	'max_entries' type_id=7 bits_offset=128 */
+		/* 	'map_extra' type_id=9 bits_offset=192 */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 4), 32),
+		/* struct btf_member [name_off, type, offset] */
+		20 /* 'type' */, 1, 0,
+		25 /* 'map_flags' */, 5, 64,
+		35 /* 'max_entries' */, 7, 128,
+		47 /* 'map_extra' */, 9, 192,
+
+		/* [11] VAR 'arena' type_id=10, linkage=global */
+		BTF_TYPE_ENC(57 /* 'arena' */, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 10),
+		/* struct btf_var [ linkage ] */
+		BTF_VAR_GLOBAL_ALLOCATED,
+
+		/* [12] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0 */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 0), 2),
+
+		/* [13] FUNC 'func' type_id=12 linkage=global */
+		BTF_TYPE_ENC(63 /* 'func' */, BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 12),
+	};
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0xfffffffc), /* Very last 32 bits in the arena */
+		BPF_ADDR_SPACE_CAST_TO_ARENA(BPF_REG_1),
+		BPF_LDX_MEM(BPF_W, BPF_REG_1,  BPF_REG_1, 0),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_func_info_min func_infos[] = {
+		{ 0, 13 },
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = BPF_F_MMAPABLE | (token_fd ? BPF_F_TOKEN_FD : 0),
+		.map_extra = arena_offset,
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.token_fd = token_fd,
+		.prog_flags = BPF_F_SLEEPABLE | (token_fd ? BPF_F_TOKEN_FD : 0),
+	);
+
+	insn_cnt = ARRAY_SIZE(insns);
+	btf_fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs), token_fd);
+	if (btf_fd < 0) {
+		ret = -errno;
+		pr_warn("Error in %s(): %s. Couldn't load BTF.\n",
+			__func__, errstr(ret));
+		return ret;
+	}
+
+	/* Create the arena and patch the instruction. */
+	map = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena", 0, 0, arena_pages, &map_opts);
+	if (map < 0) {
+		ret = -errno;
+		pr_warn("Error in %s(): %s. Couldn't create arena map.\n",
+			__func__, errstr(ret));
+		close(btf_fd);
+		return ret;
+	}
+	insns[0].imm = map;
+
+	/* The mapping the arena is hosted on is created by libbpf. */
+	mapping = mmap((void *)arena_offset, arena_size, PROT_READ | PROT_WRITE, MAP_SHARED, map, 0);
+	if (mapping == MAP_FAILED) {
+		ret = -errno;
+		pr_warn("Error in %s(): %s. Failed to mmap arena.\n",
+			__func__, errstr(ret));
+		close(map);
+		close(btf_fd);
+		return ret;
+	}
+	opts.prog_btf_fd = btf_fd;
+	opts.func_info = &func_infos;
+	opts.func_info_cnt = ARRAY_SIZE(func_infos);
+	opts.func_info_rec_size = sizeof(func_infos[0]);
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL", insns, insn_cnt, &opts);
+	munmap(mapping, arena_size);
+	close(btf_fd);
+	close(map);
+
+	return probe_fd(prog_fd);
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -581,6 +756,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_QMARK_DATASEC] = {
 		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
 	},
+	[FEAT_ARENA_GLOBAL_RELOC] = {
+		"Relocatable arena globals support", probe_kern_arena_global_reloc,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce4..0aeb740a5f47 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3009,8 +3009,11 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	memcpy(obj->arena_data, data, data_sz);
 	obj->arena_data_sz = data_sz;
 
-	/* place globals at the end of the arena */
-	obj->arena_data_off = mmap_sz - data_alloc_sz;
+	/* place globals at the end of the arena (if supported) */
+	if (kernel_supports(obj, FEAT_ARENA_GLOBAL_RELOC))
+		obj->arena_data_off = mmap_sz - data_alloc_sz;
+	else
+		obj->arena_data_off = 0;
 
 	/* make bpf_map__init_value() work for ARENA maps */
 	map->mmaped = obj->arena_data;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fc59b21b51b5..e0223a6e4c95 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -392,6 +392,8 @@ enum kern_feature_id {
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
 	FEAT_BTF_QMARK_DATASEC,
+	/* Kernel supports relocating arena globals to end of the arena */
+	FEAT_ARENA_GLOBAL_RELOC,
 	__FEAT_CNT,
 };
 
-- 
2.49.0

