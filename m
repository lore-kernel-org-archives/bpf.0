Received: from mail-ed2-f0.google.com (mail-ed2-f0.google.com [74.125.228.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A241A57C
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355338; cv=none; b=qSc9kwVBe/M9sSmapIKCwQG+jmS2SxjpJ7tGgBwHcJAgy4M29gAqy6wUzDp6hnZa9H+Fk18sHngpRY9xrP4C1aedUBK6n/85IWE258q7pCj/Yh7aZxEVlzS5wYcI8I7GEFgodOYEUyhB8wubbfLXSritqP5XYoLRIxjdsF8QkUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355338; c=relaxed/simple;
	bh=DqN+SjbfUhp/DFHDmmz0JtRsLTu4rtrTfV+FXvRiDqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4F/OSQUSXCytjsmGUaKWEBVm6HpPNhTl1hp13XUodK/UaytCdUooCGkqaM9SeyLlVuIf3pqcY2zIVefifemscVvCetJWBpMFb+jUBRuwYaqNREAw/sSoJ3I7e9jOF/y9o0VR0e5vw+ec3S/7O8udBwvxPfq3JtL1O0bC/BRRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxjZjOtd; arc=none smtp.client-ip=74.125.228.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxjZjOtd"
Received: by mail-ed2-f0.google.com with SMTP id 4fb4d7f45d1cf-69846db5d38so1116080a12.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355335; x=1787960135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnLpi7wzEshydckEIv1Box22nzB492RMSagsVKgT2hA=;
        b=IxjZjOtddXs+G57KhPbMnSYSPiy7XTEittUHQ+DYjURYlOarhxWgVa5AtoXZwAP6/8
         mEm3LAbJpIxKVP2Da6BZWdzPwX+9SXYT8+xmrSNzoC9cRPrgkqxmGNQOm2LCq0RzCw2O
         siq4idoSeX8Zr1HnlokN3R0ItateNmPQEONi5hBfk5I3t2TieFfEz3wD3YSVXZyuYkqz
         kGHuaLTmKjnqOPdDDrmdeMoC2yH1kKC327nE+tqk6HOBNFjAANpMr9lmnVpLQc5Tq4PZ
         lqArpNMooU3jQsB7IJYDN0eGf++Sl0lHLcWsTZGBtiuqBk39/DruHRjMgLpOJerpQ8hn
         Lm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355335; x=1787960135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cnLpi7wzEshydckEIv1Box22nzB492RMSagsVKgT2hA=;
        b=bd4RACP8XlCjCd6u4b5+J3ef+EXj+rRln+DO1BVMwKCEUSISM0N4xTnGHmr9qYRNIR
         yljQ1yOmEMPyY6Q8jARYvlSMLdIWl7yeu9+DX6w4WWt3eBfreNoYb8gdwbrcjxPMDcZv
         iYq+mCu09WgeGXUEC/Y+YW1Ce2lbzZWur2h1THuhVSyCDYNFx3kVwDRRX5faJy2MMZPn
         V84czJ3N2UbvY0XyBERemDsi/iZOk6Do56ywbDSAeASlgF4eO+EXfkcIV7tLZANLqKCp
         HcB4bPin6shW//YMRmw2l3qiUy86l5iAVxOdWrAa1bW7zgffggymcskpoMLOSlwFLpLG
         NUTg==
X-Gm-Message-State: AFuF++kQ4McIAU4DFfE1BVZWRJB/f0T6FVHtxbsWeUJr8Bmfuz/SKE6o
	8wlPBYZvJq+H34lK7ymsIinF6hrbqst9ZkVhqEPsU0LbgPBJouwdWckBda4IiO43
X-Gm-Gg: AR+sD12O6lIe1cnCgMPLh7gvwKQkE5OgCf8WD8qdXLvIi1gpZbS7hmXAda1KLB0rONb
	LXy188E6hnRv5ro9Px/D2KCO0WXXAeiQtI5W0luUDaIcFKWlGMTjsl6yF9YQAZZTB0bi5gff6ix
	tOLCEbgPR59d0yni/LsJ3IXl3FpUz+R2ilBGoJoznsbNyNOwlFodHUUSDz/TyWZ45aOURPH7HSA
	zjH6BVgktC5ESlrv7pS68D0mr9ZxbwRLnXqaCCZSKAOSkAEZmq0HhZ5+198qwSxCXKjNr4AXDy8
	UFSn9gRRirXKkBhpDrr9DWokLPTB3xIV1D7uUImOMTmm/ZFQP3vnqa8NWXSWPcVZQ5J+miT+vtO
	7wp11wqQ73nfeRwt+VUlw1yWBCurwwq6D/ciAmUcJ0hM7/Zt8Ks6caQsvKAnCKbR6ILhsFzWCck
	iwta3ECC/TKkivSPGndB6ARxC5E8m7OQjXyRFeuMiFxz4zrKlZdZc8SlA837eqr1kjilQFK19PD
	tyeI5bB8NWdf1Su2uBG4LerF1HXzjcBbHDVmCsSX76fflV3rBrfkOqtCpXYbjyXHHa1zRIuImEk
	6qGFj0TDzRXsctlpBUikcfqU+m8=
X-Received: by 2002:a05:6402:320e:b0:6a3:7ec1:532d with SMTP id 4fb4d7f45d1cf-6a42f22cf23mr11783062a12.13.1787355334637;
        Fri, 21 Aug 2026 16:35:34 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff156811sm8730742a12.19.2026.08.21.16.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 11/14] bpf: Replace arena kfunc argument flags with suffixes
Date: Sat, 22 Aug 2026 01:35:05 +0200
Message-ID: <20260821233516.3426127-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9524; i=memxor@gmail.com; h=from:subject; bh=DqN+SjbfUhp/DFHDmmz0JtRsLTu4rtrTfV+FXvRiDqw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQf+66fdZKvQuWq8Nrs//ueTkVtl/Geu7FKdnqZS6z 2m3WJTaUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlk/2H4ZzGv0cHgZOKLD7eO bbg77/LG/3UlN3R+duYV/CySfWijKsfI8HzzqYPpHQxP+Xfr9LG965oR2rfc+I6rlKWFfH2agPQ 0ZgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The arena allocation kfuncs still identify pointer arguments with
KF_ARENA_ARG2. These flags cover only the first two parameters and
duplicate the __arena suffix mechanism used by other kfuncs.

Annotate the optional allocation address with __arena__nullable. Mark the
free and reserve addresses with __arena so a valid address whose low 32
bits are zero is rebased unconditionally instead of becoming NULL.

The JIT now passes kernel arena addresses to these kfuncs. Translate them
back to the lower-32-bit user addresses expected by the existing arena
helpers by subtracting kern_vm_start. This preserves allocation-anywhere,
freeing the first page of a 4 GiB arena, and reservation at address zero.

Drop KF_ARENA_ARG1 and KF_ARENA_ARG2 from the kernel interface and remove
the flags from the arena kfunc sets. KF_ARENA_RET remains responsible for
annotating the allocation return value.

Keep the affected selftests synchronized with the conversion. Associate
an arena before the iterator map-pointer failures so they still reach the
intended diagnostics, account for the extra nullable branch in JIT labels,
and treat 1ULL << 32 as the same allocation-anywhere request as NULL after
the required 32-bit truncation.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h                           |  2 -
 kernel/bpf/arena.c                            | 40 ++++++++++++++-----
 .../selftests/bpf/progs/arena_kfunc_jit.c     | 16 ++++----
 .../selftests/bpf/progs/verifier_arena.c      |  6 +++
 .../bpf/progs/verifier_arena_large.c          |  4 +-
 5 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 89d5a5c4f117..65e5f11dc27e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -76,8 +76,6 @@
 #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
 #define KF_FASTCALL     (1 << 12) /* kfunc supports bpf_fastcall protocol */
 #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
-#define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
-#define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
 #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
 
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b43..6c34a0d34b3f 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -1044,18 +1044,28 @@ static void arena_free_irq(struct irq_work *iw)
 	schedule_work(&arena->free_work);
 }
 
+static long arena_kaddr_to_uaddr(struct bpf_arena *arena, const void *addr)
+{
+	if (!addr)
+		return 0;
+
+	return (long)addr - bpf_arena_get_kern_vm_start(arena);
+}
+
 __bpf_kfunc_start_defs();
 
-__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
-					int node_id, u64 flags)
+__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__arena__nullable,
+					u32 page_cnt, int node_id, u64 flags)
 {
 	struct bpf_map *map = p__map;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	long addr;
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
 		return NULL;
 
-	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
+	addr = arena_kaddr_to_uaddr(arena, addr__arena__nullable);
+	return (void *)arena_alloc_pages(arena, addr, page_cnt, node_id, true);
 }
 
 void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt,
@@ -1082,14 +1092,20 @@ void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ign, u32 page_cn
 	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
 }
 
-__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
+/*
+ * A valid arena address can have zero low 32 bits, so ptr must be rebased
+ * unconditionally instead of being treated as nullable.
+ */
+__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__arena, u32 page_cnt)
 {
 	struct bpf_map *map = p__map;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	long ptr;
 
-	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
+	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt)
 		return;
-	arena_free_pages(arena, (long)ptr__ign, page_cnt, true);
+	ptr = arena_kaddr_to_uaddr(arena, ptr__arena);
+	arena_free_pages(arena, ptr, page_cnt, true);
 }
 
 void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt)
@@ -1102,10 +1118,11 @@ void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_c
 	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
 }
 
-__bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_cnt)
+__bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__arena, u32 page_cnt)
 {
 	struct bpf_map *map = p__map;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	long ptr;
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA)
 		return -EINVAL;
@@ -1113,14 +1130,15 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
 	if (!page_cnt)
 		return 0;
 
-	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
+	ptr = arena_kaddr_to_uaddr(arena, ptr__arena);
+	return arena_reserve_pages(arena, ptr, page_cnt);
 }
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
-BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
-BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
-BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_SPINLOCK_SAFE)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
index b5a01cbc33a7..c9af35c683b3 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
@@ -49,15 +49,15 @@ __arch_x86_64
 __jited("...")
 __jited("	movl	%edi, %edi")
 __jited("	testl	%edi, %edi")
-__jited("	je	L0")
+__jited("	je	L1")
 __jited("	addq	%r12, %rdi")
-__jited("L0:	callq	{{.*}}")
+__jited("L1:	callq	{{.*}}")
 __arch_arm64
 __jited("...")
 __jited("	mov	w0, w0")
-__jited("	cbz	w0, L0")
+__jited("	cbz	w0, L1")
 __jited("	add	x0, x28, w0, uxtw")
-__jited("L0:	{{.*}}")
+__jited("L1:	{{.*}}")
 __success
 int arena_arg_jit_nullable(void *ctx)
 {
@@ -79,9 +79,9 @@ __jited("	movl	%ecx, %ecx")
 __jited("	addq	%r12, %rcx")
 __jited("	movl	%r8d, %r8d")
 __jited("	testl	%r8d, %r8d")
-__jited("	je	L0")
+__jited("	je	L1")
 __jited("	addq	%r12, %r8")
-__jited("L0:	callq	{{.*}}")
+__jited("L1:	callq	{{.*}}")
 __arch_arm64
 __jited("...")
 __jited("	add	x0, x28, w0, uxtw")
@@ -89,9 +89,9 @@ __jited("	add	x1, x28, w1, uxtw")
 __jited("	add	x2, x28, w2, uxtw")
 __jited("	add	x3, x28, w3, uxtw")
 __jited("	mov	w4, w4")
-__jited("	cbz	w4, L0")
+__jited("	cbz	w4, L1")
 __jited("	add	x4, x28, w4, uxtw")
-__jited("L0:	{{.*}}")
+__jited("L1:	{{.*}}")
 __success
 int arena_arg_jit_args5(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 815f342eb4b0..d76490e059f9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -445,6 +445,8 @@ int iter_maps1(struct bpf_iter__bpf_map *ctx)
 
 	if (!map)
 		return 0;
+	/* Associate an arena before testing the generic map-pointer path. */
+	bpf_arena_reserve_pages(&arena, NULL, 0);
 	bpf_arena_alloc_pages(map, NULL, map->max_entries, 0, 0);
 	return 0;
 }
@@ -455,6 +457,8 @@ int iter_maps2(struct bpf_iter__bpf_map *ctx)
 {
 	struct seq_file *seq = ctx->meta->seq;
 
+	/* Associate an arena before testing the generic map-pointer path. */
+	bpf_arena_reserve_pages(&arena, NULL, 0);
 	bpf_arena_alloc_pages((void *)seq, NULL, 1, 0, 0);
 	return 0;
 }
@@ -467,6 +471,8 @@ int iter_maps3(struct bpf_iter__bpf_map *ctx)
 
 	if (!map)
 		return 0;
+	/* Associate an arena before testing the generic map-pointer path. */
+	bpf_arena_reserve_pages(&arena, NULL, 0);
 	bpf_arena_alloc_pages(map->inner_map_meta, NULL, map->max_entries, 0, 0);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 6ab8730d4878..f6515e0e9b17 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -49,8 +49,10 @@ int big_alloc1(void *ctx)
 
 	no_page = bpf_arena_alloc_pages(&arena, (void __arena *)ARENA_SIZE,
 					1, NUMA_NO_NODE, 0);
-	if (no_page)
+	/* Only the low 32 bits contribute, so this is equivalent to NULL. */
+	if (!no_page)
 		return 3;
+	bpf_arena_free_pages(&arena, (void __arena *)no_page, 1);
 	if (*page1 != 1)
 		return 4;
 	if (*page2 != 2)
-- 
2.53.0

