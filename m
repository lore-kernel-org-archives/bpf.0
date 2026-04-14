Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5283E51FF
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173147; cv=none; b=QbWAhSxSncVzJYwqwFTUHW4PJs+WDTBSLPV50KkGqXwptw507l4hht7s620cPPEMH4+/yItEGUEW/ygF4bmw+afuhn+W12iYbSYDwT2NtZDe4J88vl6FUVG5Rd3SAxwOcSxBEEBEA5VGu/58GzYOrO8Pr6sL3OI5+Q8XISAhPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173147; c=relaxed/simple;
	bh=waUXf3Jqbvzm4E3k6uLnnYuQwXpeViHcirUx1HVQhOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT+l+szzx68vf/4DZZjG94wMrSYXBH+8dQE8hR/YT6hoFD90bW09v1o/lF4OqsiS+41AO6zKkbL6O5Udu9qKoyw6dvBxvDps4pCD3CaUVIqGj0vuEZo/Rnon8/36+YsseVaD+r3MSbZ7ybkgJ97Mu0mivZRx0XfR0GdMT3qRJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hRVzDDEC; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hRVzDDEC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776173144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLhuO6umau2jGMSqyUh9o4RuZqsZkSpK8JCnskaghHQ=;
	b=hRVzDDECuDxZAUF83w0sNSo4/GwnqOYlu6bL5klSwDuvd/w2rgnBh/F8AMVcq2LQsejCBI
	C5VaOsvwXl2dcgSNvto0/yL5mNutalWsGixBRAKl5Fopu2wAzmjQbN3gDqjzftGTnE7g5i
	mFXXw6N87++j3SeRCRaabypaRaXFJ9g=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 6/8] bpftool: Generate skeleton for global percpu data
Date: Tue, 14 Apr 2026 21:24:18 +0800
Message-ID: <20260414132421.63409-7-leon.hwang@linux.dev>
In-Reply-To: <20260414132421.63409-1-leon.hwang@linux.dev>
References: <20260414132421.63409-1-leon.hwang@linux.dev>
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
    read-only. If users want to update the global percpu variables, they
    have to update the "maps.percpu" map instead.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/gen.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 2f9e10752e28..ec63eb871443 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char *obj_name, const char *suff
 
 static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 {
-	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".percpu", ".kconfig" };
 	const char *name = bpf_map__name(map);
 	int i, n;
 
@@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 
 static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
 {
-	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".percpu", ".kconfig" };
 	int i, n;
 
 	/* recognize hard coded LLVM section name */
@@ -254,6 +254,11 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
 	return NULL;
 }
 
+static bool bpf_map_is_percpu_data(const struct bpf_map *map)
+{
+	return bpf_map__is_internal(map) && bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY;
+}
+
 static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
 {
 	size_t tmp_sz;
@@ -263,13 +268,12 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
 		return true;
 	}
 
-	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
-		return false;
-
-	if (!get_map_ident(map, buf, sz))
-		return false;
+	if (bpf_map__is_internal(map) &&
+	    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf_map_is_percpu_data(map)) &&
+	    get_map_ident(map, buf, sz))
+		return true;
 
-	return true;
+	return false;
 }
 
 static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
@@ -669,7 +673,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 		if (bpf_map__is_internal(map) &&
-		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+		    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf_map_is_percpu_data(map)))
 			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zu);\n",
 			       ident, bpf_map_mmap_sz(map));
 		codegen("\
@@ -847,7 +851,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	bpf_object__for_each_map(map, obj) {
 		const char *mmap_flags;
 
-		if (!is_mmapable_map(map, ident, sizeof(ident)))
+		if (!is_mmapable_map(map, ident, sizeof(ident)) || bpf_map_is_percpu_data(map))
 			continue;
 
 		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
-- 
2.53.0

