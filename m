Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8153E48B368
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129629; cv=none; b=iClGIsAy0372fDGEgYdFASW+Hv3MeFzFHBmma0JwiJ5S1q5N+fq10Vt7B9dLTJ5i8k7dHpa+rxl23zZSPuFxaMsdFKPaV3Y0EW5MqH8ojHoBmZgCvz31B5R/icLRlOPssxmwGXsb8lhQ+zvbia4CBPuvsFWoJ5jfZ9bRNL0ZqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129629; c=relaxed/simple;
	bh=5Gs9lpB29potX4QnrvDusLVJ/aaMcUDBRLbQ9GJSD5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPZsJQOTEdXRiNTR+XjygIRZpfIgp5LM668v4OAOFvfvB9hGK/K2yyf178Ix1CxRTZc3aYRp7/8OEqvgJIyWDW4/G6DNQmr+mUqCMtyUM0cdxMuUTwvBsIVfiogQULgKDz07EH/9IpSuiNQXtn6c/U2hRw2Clo/4oR7abVKsxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nm+VDBkv; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nm+VDBkv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784129624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzeBVrq6hHQ0NkIFbRun2A7rrCztpk43QeGTJlPzK+w=;
	b=Nm+VDBkv5/M6QELYMDLADcjP+T4NzDsxgw0J+AGXq8RAGqBPp08EDiHG/CbE+veEnd/IAI
	ZBOLdvNC1dkDoLDWoAweY0Z5zU2W5G8XF4zIcqVc8Cupa3ocPEMDkjueP2PUG2nnF0LQwB
	HD3oDqVXo2CHCjEv9TqZp2jFSxOAOSU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v10 5/9] bpftool: Generate skeleton for global percpu data
Date: Wed, 15 Jul 2026 23:32:49 +0800
Message-ID: <20260715153254.92010-6-leon.hwang@linux.dev>
In-Reply-To: <20260715153254.92010-1-leon.hwang@linux.dev>
References: <20260715153254.92010-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Enhance bpftool to generate skeletons that properly handle global percpu
variables. The generated skeleton now includes a dedicated structure for
percpu data, allowing users to initialize and access percpu variables more
efficiently.

For global percpu variables, the skeleton now includes a nested
structure, e.g.:

struct test_global_percpu_data {
	struct bpf_object_skeleton *skeleton;
	struct bpf_object *obj;
	struct {
		struct bpf_map *percpu;
	} maps;
	// ...
	struct test_global_percpu_data__percpu {
		int data;
		char run;
		struct {
			char set;
			int i;
			int nums[7];
		} struct_data;
		int nums[7];
	} *percpu;

	// ...
};

  * The "struct test_global_percpu_data__percpu *percpu" points to
    initialized data, which is actually "maps.percpu->mmaped".
  * Before loading the skeleton, updating the
    "struct test_global_percpu_data__percpu *percpu" modifies the initial
    value of the corresponding global percpu variables.
  * After loading the skeleton, "maps.percpu->mmaped" has been marked as
    read-only in libbpf. If users want to update the global percpu
    variables, they have to update the "maps.percpu" map instead.
  * For lightweight skeleton, "lskel->percpu" will be protected by
    "mprotect(p, sz, PROT_READ)".
  * For subskeleton, those variables of global percpu data will be
    skipped.

Acked-by: Quentin Monnet <qmo@kernel.org>
Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/gen.c       | 76 +++++++++++++++++++++++++++--------
 tools/lib/bpf/skel_internal.h | 24 ++++++++++-
 2 files changed, 81 insertions(+), 19 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a01d06d22d1a..b60db1108149 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -101,6 +101,12 @@ static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 		return true;
 	}
 
+	if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY) {
+		snprintf(buf, buf_sz, "%s", name + 1);
+		sanitize_identifier(buf);
+		return true;
+	}
+
 	for  (i = 0, n = ARRAY_SIZE(sfxs); i < n; i++) {
 		const char *sfx = sfxs[i], *p;
 
@@ -117,7 +123,7 @@ static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 
 static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
 {
-	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".percpu", ".kconfig" };
 	int i, n;
 
 	/* recognize hard coded LLVM section name */
@@ -254,7 +260,7 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
 	return NULL;
 }
 
-static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
+static bool is_skel_data(const struct bpf_map *map, char *buf, size_t sz)
 {
 	size_t tmp_sz;
 
@@ -263,13 +269,19 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
 		return true;
 	}
 
-	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+	if (!bpf_map__is_internal(map))
 		return false;
 
 	if (!get_map_ident(map, buf, sz))
 		return false;
 
-	return true;
+	if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
+		return true;
+
+	if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
+		return true;
+
+	return false;
 }
 
 static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
@@ -286,8 +298,11 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 		return -errno;
 
 	bpf_object__for_each_map(map, obj) {
-		/* only generate definitions for memory-mapped internal maps */
-		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
+		/*
+		 * Only generate definitions for internal maps that have
+		 * mmapped data.
+		 */
+		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
 			continue;
 
 		sec = find_type_for_map(btf, map_ident);
@@ -339,8 +354,14 @@ static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name
 		return -errno;
 
 	bpf_object__for_each_map(map, obj) {
-		/* only generate definitions for memory-mapped internal maps */
-		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
+		/*
+		 * Only generate definitions for internal maps that have
+		 * mmapped data.
+		 */
+		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
+			continue;
+
+		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
 			continue;
 
 		sec = find_type_for_map(btf, map_ident);
@@ -493,7 +514,10 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
 	return map_sz;
 }
 
-/* Emit type size asserts for all top-level fields in memory-mapped internal maps. */
+/*
+ * Emit type size asserts for all top-level fields in internal maps that
+ * have mmaped data.
+ */
 static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
 {
 	struct btf *btf = bpf_object__btf(obj);
@@ -517,7 +541,7 @@ static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
 		", obj_name);
 
 	bpf_object__for_each_map(map, obj) {
-		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
+		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
 			continue;
 
 		sec = find_type_for_map(btf, map_ident);
@@ -669,7 +693,8 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 		if (bpf_map__is_internal(map) &&
-		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+		    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
+		     bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY))
 			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zu);\n",
 			       ident, bpf_map_mmap_sz(map));
 		codegen("\
@@ -741,7 +766,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		const void *mmap_data = NULL;
 		size_t mmap_size = 0;
 
-		if (!is_mmapable_map(map, ident, sizeof(ident)))
+		if (!is_skel_data(map, ident, sizeof(ident)))
 			continue;
 
 		codegen("\
@@ -849,8 +874,22 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	bpf_object__for_each_map(map, obj) {
 		const char *mmap_flags;
 
-		if (!is_mmapable_map(map, ident, sizeof(ident)))
+		if (!is_skel_data(map, ident, sizeof(ident)))
+			continue;
+
+		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY) {
+			codegen("\
+		\n\
+			err = skel_protect_map_data(skel->%1$s, &skel->maps.%1$s.initial_value, %2$zd);\n\
+			if (err)					    \n\
+				return err;				    \n\
+		#ifdef __KERNEL__					    \n\
+			skel->%1$s = NULL;				    \n\
+		#endif							    \n\
+			",
+			ident, bpf_map_mmap_sz(map));
 			continue;
+		}
 
 		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
 			mmap_flags = "PROT_READ";
@@ -955,8 +994,7 @@ codegen_maps_skeleton(struct bpf_object *obj, size_t map_cnt, bool mmaped, bool
 				map->map = &obj->maps.%s;	    \n\
 			",
 			i, bpf_map__name(map), ident);
-		/* memory-mapped internal maps */
-		if (mmaped && is_mmapable_map(map, ident, sizeof(ident))) {
+		if (mmaped && is_skel_data(map, ident, sizeof(ident))) {
 			printf("\tmap->mmaped = (void **)&obj->%s;\n", ident);
 		}
 
@@ -1740,7 +1778,9 @@ static int do_subskeleton(int argc, char **argv)
 		/* Also count all maps that have a name */
 		map_cnt++;
 
-		if (!is_mmapable_map(map, ident, sizeof(ident)))
+		if (!is_skel_data(map, ident, sizeof(ident)))
+			continue;
+		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
 			continue;
 
 		map_type_id = bpf_map__btf_value_type_id(map);
@@ -1863,7 +1903,9 @@ static int do_subskeleton(int argc, char **argv)
 
 	/* walk through each symbol and emit the runtime representation */
 	bpf_object__for_each_map(map, obj) {
-		if (!is_mmapable_map(map, ident, sizeof(ident)))
+		if (!is_skel_data(map, ident, sizeof(ident)))
+			continue;
+		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
 			continue;
 
 		map_type_id = bpf_map__btf_value_type_id(map);
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 53fee53d36d5..1f3f332dffbe 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -131,8 +131,10 @@ static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
 {
 	if (addr != ~0ULL)
 		kvfree(p);
-	/* When addr == ~0ULL the 'p' points to
-	 * ((struct bpf_array *)map)->value. See skel_finalize_map_data.
+	/*
+	 * When addr == ~0ULL the init buffer has already been released.
+	 * For skel_finalize_map_data(), 'p' points to
+	 * ((struct bpf_array *)map)->value.
 	 */
 }
 
@@ -170,6 +172,15 @@ static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int
 	return addr;
 }
 
+static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t sz)
+{
+	(void)sz;
+
+	kvfree(p);
+	*init_val = ~0ULL;
+	return 0;
+}
+
 #else
 
 static inline void *skel_alloc(size_t size)
@@ -208,6 +219,15 @@ static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int
 		return NULL;
 	return addr;
 }
+
+static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t sz)
+{
+	(void)init_val;
+
+	if (mprotect(p, sz, PROT_READ))
+		return -errno;
+	return 0;
+}
 #endif
 
 static inline int skel_closenz(int fd)
-- 
2.55.0

