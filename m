Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1A36B915
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465735; cv=none; b=m0qEmHfZUVEGwoH6vzYFmmxqH1gWK3IEB7bVQA00aJznfZWIyx8gvt5fjE+55va8rL07wl9oVd8MSfbIaHkL0t4BQqIOmMXwU2lpq2AIo+oBY7VFc4N5iYHhMX8cNtAHGu+Fjr6SGvKW9Qz8Q4BoIkNaN9QgPGvwOqpeJ8T6l+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465735; c=relaxed/simple;
	bh=BHSFCoS2EHHR5oShpofAqFqM/2AoiyaOL4afT3MJY90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcERFWU/B36srQO8HQcqkl9NHHnJuUlMrFyDLvJnvG0960rm0TtGLqKrhmYqwwlWLE2xrspHE9Cnlh+apSZu6w62bgIlKdjjBIIXMDmYLZ604+RqqCFw/ZaP8X2tS+cm9Zw3tD1yHnVEpSOrJYjTfbez1EZwjrIjX3wlvdbq2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giSNmZdQ; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giSNmZdQ"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484373a2e82so1211342f8f.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465732; x=1791070532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4z55SOeNpuwvNeysnCruJls1PC7eofFR2pGd5ui1BpM=;
        b=giSNmZdQNyqjXI0RfQkAE2wDZ8ll1yK4Wp3u0lc8eLZfsFN/7wF2ngt70YT6OX4N5s
         ANL6MBEeJF3InKEdsxfQS5v2/NmOreS4dL4CViWYodttALrta2cN2pepJ99vWZUJ4+SO
         TlgyPiwrnCrBeaOPhIOJ3Fp6fWmg70Q9kOPEs1wMe8BO/nyf3fGZlPMFsjbRSVe30Jze
         +Jvx9pFv0YYB/G7fJHbNb0n1NsjHEZ4MB+Pzr+TlKbh6h6fIKZvFAFviY56BikQf2D/F
         PYzvnL8TiTJBFBVsaaBxpwKRIi2v40lJERyl1qHhyAGaCsCSf+YbAfWHSDoMEezClTmO
         /dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465732; x=1791070532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4z55SOeNpuwvNeysnCruJls1PC7eofFR2pGd5ui1BpM=;
        b=QiJl0qQvFJRzmF/xrp0EooMht4pH7LMzRGvi72zCfSQ1YECI3gH5d7n495V8RYLhBt
         y/wOpo3026RUQumWwglaWmgH05ACxA0fJqdxlcbknvbw3Ww6Tr81o19wOb9P8SWWQPT+
         FsdSol15pqx1WQJEldy+r7+suhcDr4hiBdWmh7wye0I/o6L25CA8EiBnlvxjfHj+Z1jR
         s6YYJalSSz4QELgMuHGgqo+213n8ZyrELJJ55Ceg441g6MGBHLdrPEBeEas4WH8unjr5
         S3m+A6l2KJnv7tCT+Z4JP/aVN0GsfbvN/wPRRvC9Ru6uUIR3xlyz4x4Anhw/Xy03Qkyk
         C/ow==
X-Gm-Message-State: AFq9FYLJOHIsfjisT3mTn+G/81tbHua5fFSo7HhTsdblFTS49bKRNb0l
	WKApr3JNnkB2CP7dwrC2hqf6EjILPeJdNkhUR4D6vv0POs3SRpf4aEIhn2REJft4
X-Gm-Gg: AYBFou3/A/i3a+u+T2Y0j+/t5yztJJcMz5otD5dREGHLZ0flV4CVhNzP+2H41kUcwkt
	XmvpXKgmYhyqr9oi+BZHMa5eBlQT0ZVrlvEdPtcvZivl2E5A4lVV7fsGPF01zd+RU4IgkVdqBrn
	3xEhsHUzhTQL1h3BosGzKm1zLyHyFOqjuuMO0E9Y1CAUaJO+wFbsnMPbzWwhXInXeDluARx/m64
	ajm1nyutFrp/Iho3afu4yMpJFrIKur9NVKP7J7M6x1Ray3gfW7K+BklOJNYfYpduquVjgnXeqtR
	RwchGISG6WjpMpzT2ppz/4NDs5UwaJ7vszn5a75YSaQl1npg9h2TcwiQoab6fD7fWiBsfEPlYbN
	ecoJhoBiuueB1bzrkVZeQkJ73cbjc577bCgQG5+7zC1u1x73CPog8SJWOGWN9V1eLYc7zZYbSpj
	ilIIFRhrdMfxWfuhmdg7whp7AoTYt1zwWln6Lp5i7JtIdkJideGBv4XP213NquBJdrN+MskNhfr
	YbCpvs64r3FP2nfOtL1MhZzVlBg2YB4VKrS8ZfPn2oafdyr8SLX7VOul6JFzsmA1m5L2JkxdanN
	mI8Jyua6aXTDmIUmYWizJUf5fqkdIw6WqiqYiQ==
X-Received: by 2002:a05:6000:2383:b0:488:8384:c37e with SMTP id ffacd0b85a97d-4888384c503mr8098176f8f.26.1790465731676;
        Sat, 26 Sep 2026 16:35:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a3627a8sm18457447f8f.23.2026.09.26.16.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 15/16] selftests/bpf: Test typed arena page allocation and release
Date: Sun, 27 Sep 2026 01:34:53 +0200
Message-ID: <20260926233503.3114147-16-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6925; i=memxor@gmail.com; h=from:subject; bh=BHSFCoS2EHHR5oShpofAqFqM/2AoiyaOL4afT3MJY90=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWOIBsX82a8O97D14/6gFZ7nx5Jq+7WF1DQ55KSvsr 3+8trOjlIVBjItBVkyRpeT/PibjE5W/A22XccPMYWUCGcLAxSkAEzmyn5FhHsP15bKvz5cFrgoU KSgJ+M1hOp3vltatH0sS3y0XCreWY/groczxjcP93y//zq2PVGMf/Y+v/OhYuEXQLVizoqrxvxI PAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Allocate a page of typed arena objects, write one, reach it again through
an opaque copy of its address and its neighbour by arithmetic on that copy,
and check that the kfunc receives the registered typed arena in place of
the type ID. Take the chunk a value names and see the same chunk refused
twice, once for the chunk and once for a page inside it. Ask for one page
of an object that spans several and see the request rounded up to the
object's chunk, with the granted count written back. Release a chunk and
see it keep its objects and stay taken within the same invocation, since
the release is deferred behind a grace period.

Reject a use of the returned pointer without a NULL check, a struct without
special fields, and a map that is not the program's arena. Declare the two
kfuncs in bpf_experimental.h.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  12 ++
 .../bpf/progs/verifier_typed_arena.c          | 142 ++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 128654997328..cc1537a5e07a 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -15,6 +15,18 @@
  */
 #define __typed_arena_size(sz) __attribute__((btf_decl_tag("typed_arena_size:" #sz)))
 
+/*
+ * Back the chunks covering *page_cnt pages of the typed arena of the struct
+ * whose local BTF type ID is type_id with zeroed objects, at addr, a typed
+ * pointer naming the first chunk, or anywhere for NULL; round the count up
+ * to whole chunks and write it back; return a pointer to the first object,
+ * or NULL. Release such a range after a grace period, after which its
+ * objects read as the dummy object. Both are safe under a spin lock.
+ */
+extern void *bpf_typed_arena_alloc_pages(void *map, __u64 type_id, void *addr, __u32 *page_cnt,
+					 int node_id) __ksym;
+extern void bpf_typed_arena_free_pages(void *map, __u64 type_id, void *ptr, __u32 page_cnt) __ksym;
+
 /* Convenience macro to wrap over bpf_obj_new */
 #define bpf_obj_new(type) ((type *)bpf_obj_new(bpf_core_type_id_local(type)))
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_typed_arena.c b/tools/testing/selftests/bpf/progs/verifier_typed_arena.c
index 808a65611d4e..8ec75fd1f97b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_typed_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_typed_arena.c
@@ -1157,6 +1157,148 @@ int ptr_field_sanitize_on_one_path(void *ctx)
 	return 0;
 }
 
+#define TYPE_ID(T) bpf_core_type_id_local(T)
+
+SEC("syscall")
+__description("allocated pages hold real objects, reachable through any value that lands in them")
+__success __retval(0)
+__xlated("r2 = 0x{{[0-9a-f]+[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]}}")
+__xlated("call kernel-function")
+int pages_alloc(void *ctx)
+{
+	struct typed_obj *obj, *again, *next;
+	void *opaque;
+	__u32 cnt = 1;
+
+	obj = bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct typed_obj), NULL, &cnt,
+					  NUMA_NO_NODE);
+	if (!obj)
+		return 1;
+	if (cnt != 1)
+		return 2;
+	obj->value = 5;
+	/* The object through an opaque value, and its neighbor by arithmetic on that value */
+	opaque = obj;
+	again = opaque;
+	if (again != obj || again->value != 5)
+		return 3;
+	next = opaque + sizeof(*obj);
+	next->value = 6;
+	if (next == obj || next->value != 6 || obj->value != 5)
+		return 4;
+	return 0;
+}
+
+SEC("syscall")
+__description("a fixed request takes its chunk once")
+__success __retval(0)
+int pages_alloc_fixed(void *ctx)
+{
+	struct typed_obj *obj, *hint;
+	__u32 cnt;
+
+	/* The chunk user space names, the first one here */
+	hint = ptr;
+	cnt = 2;
+	obj = bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct typed_obj), hint, &cnt,
+					  NUMA_NO_NODE);
+	if (!obj)
+		return 1;
+	if (obj != hint || cnt != 2)
+		return 2;
+	cnt = 1;
+	if (bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct typed_obj), hint, &cnt,
+					NUMA_NO_NODE))
+		return 3;
+	/* The page after it, part of the first request */
+	hint = (void *)hint + __PAGE_SIZE;
+	cnt = 1;
+	if (bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct typed_obj), hint, &cnt,
+					NUMA_NO_NODE))
+		return 4;
+	return 0;
+}
+
+SEC("syscall")
+__description("a request is rounded up to whole chunks and the granted count written back")
+__success __retval(0)
+int pages_alloc_granted_count(void *ctx)
+{
+	__u32 cnt = 1, chunk_pages = 16384 > __PAGE_SIZE ? 16384 / __PAGE_SIZE : 1;
+	struct big_obj *obj;
+
+	obj = bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct big_obj), NULL, &cnt,
+					  NUMA_NO_NODE);
+	if (!obj)
+		return 1;
+	if (cnt != chunk_pages)
+		return 2;
+	obj->pad[8191] = 1;
+	return obj->pad[8191] - 1;
+}
+
+SEC("syscall")
+__description("a released chunk keeps its objects and stays taken until the grace period has passed")
+__success __retval(0)
+int pages_free(void *ctx)
+{
+	struct typed_obj *obj;
+	__u32 cnt = 1;
+
+	obj = bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct typed_obj), NULL, &cnt,
+					  NUMA_NO_NODE);
+	if (!obj)
+		return 1;
+	obj->value = 7;
+	bpf_typed_arena_free_pages(&arena, TYPE_ID(struct typed_obj), obj, 1);
+	if (obj->value != 7)
+		return 2;
+	cnt = 1;
+	if (bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct typed_obj), obj, &cnt, NUMA_NO_NODE))
+		return 3;
+	return 0;
+}
+
+SEC("syscall")
+__description("an allocation must be checked for NULL")
+__failure __msg("invalid mem access 'typed_arena_ptr_or_null_'")
+int pages_alloc_null_check(void *ctx)
+{
+	struct typed_obj *obj;
+	__u32 cnt = 1;
+
+	obj = bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct typed_obj), NULL, &cnt,
+					  NUMA_NO_NODE);
+	obj->value = 1;
+	return 0;
+}
+
+SEC("syscall")
+__description("the page kfuncs register the type like a cast: a struct without special fields belongs in the raw arena")
+__failure __msg("struct plain_obj has no special fields and needs no typed arena")
+int pages_alloc_plain_struct(void *ctx)
+{
+	struct plain_obj *obj;
+	__u32 cnt = 1;
+
+	obj = bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct plain_obj), NULL, &cnt,
+					  NUMA_NO_NODE);
+	return obj == NULL;
+}
+
+SEC("syscall")
+__description("the page kfuncs need the program's arena")
+__failure __msg("can only be used in a program that has an associated arena")
+int pages_alloc_needs_arena(void *ctx)
+{
+	struct typed_obj *obj;
+	__u32 cnt = 1;
+
+	obj = bpf_typed_arena_alloc_pages(&not_an_arena, TYPE_ID(struct typed_obj), NULL, &cnt,
+					  NUMA_NO_NODE);
+	return obj == NULL;
+}
+
 #endif /* __BPF_FEATURE_TYPED_ARENA_CAST */
 
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

