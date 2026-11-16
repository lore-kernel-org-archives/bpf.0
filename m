Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842854;
	b=D+d46fQDWM3LCPkRXCrzqG6vXUpOAT3ixInxl3pwMUxQHtF7mMLqjwejbPmSfmRa53eH
	 jmI0hJAeBOKpER1s8AS2kZd788tzeeC255nRgmXHUiKJISqwFbHAS+FKJ0z4P/XcDRvTK
	 TJvrqAo0BWDmRB1WTREhDK+Lq654aQwWwJlahWe1rK7TOzPXZX15MpuHnvt4n4AbT1TTT
	 c6Wyrke0KTP6cuePiAIWhkNNhFQk1yfYKYkVx1AKwtuUPkQBXBNWp/nTDnSUSEOHPCfbi
	 jW2NOBq2bFfnb1ILwv3AL4JHAP04FoRbYstheYI7ctSGXGIQ+Od/kK1zw66WF6hnkFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B7yaOb9lvsHe7rD6wPnCf3vd5e4YsNKVNzHxbF/nHTU=;
	b=Md8d8zzXxQt/ie0Pcdx9J4slCgC7QUfMKNYN7t9RYGF4FdlIrSPs6x/ukApz5u4zkZpA
	 4dLZsJxPOwggCcffxKEFE2499n84ui3lp/UYZAODajce2gH/Z/BKWQmKPN7HFZQxO9NAf
	 oynFicDRzamkULAYBsGSmdYyXzWXcTiHmexDI0JBw3WGYWPLdcm9boxnqiTY/QuEurbkc
	 i4JlqJj44433LiJ0LH7u50BMebuwrr9U27lc5Cuy1COFwezseQe82GP2eQ+mgwxrz/79K
	 lpEBhSlAwLxa0246MckyhnU50aK1GfzASG8io9jUXxVcp8IXvu+lY8mp7sY6i9d7u/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DkbQkBWI;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AA606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 868AA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DkbQkBWI
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so4517397a91.3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842853; x=1795447653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B7yaOb9lvsHe7rD6wPnCf3vd5e4YsNKVNzHxbF/nHTU=;
        b=DkbQkBWIzsSxpSxM7W3Z23ZJAJvhENQ8FPW9FA5x6glrzZJzxn1aUkLeiYT+HIBeSb
         JBvBMU4cWb0yBR8AplvzOjW6b5syL0vxotpoT8G/OBQk9hlQadVkzNPDo5fhiNGQhGmL
         eCCRGToX6b5ZklZ8n0fYbtxxIY7i5wJuSOYxX1EJMPsZcT4OuWs3BAhE8Sug9h3na9U0
         jEL4eHNU5Z5uQg1/X+0bUQqp/zhrq7dVPsTKGHpbyTMdBNqom2hqAveg/NwkHQUUwR4r
         ere05ml/jYXh9RjVJTtl5x+mDJbMj38X6xwKpbS1/s23carKIaOINKN2CSqa13fdq+wx
         Z4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842853; x=1795447653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B7yaOb9lvsHe7rD6wPnCf3vd5e4YsNKVNzHxbF/nHTU=;
        b=kUho7dNbDVWisspt2/v3tT6ugZWexWRIO2jfNSvMJBYFCx9eV3ZvyP8qVikHxRZ68Y
         dwftf1fz2E015UIQW6bK/B6/pSL9slaNP5D7eOFUcAOrw+r2dgWroX8c2jLqSoPJQxxh
         s2HMBAH7JxDZ8fUYd1eqrUqeJIJae5boIEUyTVYc9wbbFNcT8xJf9oBHebBv19qz3MSR
         R6EzOE9la1Cj4DTlK4hBSo4DE1HprCPJJ69fjvExLRNge8QZ0p+I7aAQQdDvZGeaPEsH
         cnF+ziYMH3m3JEma72YpTZRvRQ7ORudNYaXKaOUVrSiupGVeXCKWDJywe2lSJlP+amx4
         AREA==
X-Gm-Message-State: APuU4Z8sX98J9aWUN+ngYK5BqGp14YQEvLA3Uf9W8eoZ5NuXAHRVOo22
	s2GyUt134Toukkp52D+xOj4Y+56danqoFTuU2a5jU2r3gSWupHW8H8TlCLVwMg==
X-Gm-Gg: AZFdTZe0pBvlfjcRWkVdL1oRpIoaRJXXb91idrLTgLKyPrm6r9loafi5d6soYGtLTsK
	9eBKtZ25LJ4DvaYL+IMJ0jjHYgklfNRPoIbQrPCOFtouUrPktS/jfTcqYT0QXNbLPnVz7Y4owUs
	99hAxzH5RBvrIxC40Wj947SvizFIMSJUiAORi2AWxutfR1fz+V9GAI1HNIsxW0jF2c1J3WYeUOL
	jBuJU+1bXEcwhyVguQGEYrS1UzYe97GFy17BrKDLORLe98XAmZWHkKD02mKY9iuPZoCeKEqsjzY
	jYFKtemtrFhei6oYcAp3eLxly7meqBRwg05GUZBuKUt+7fcdjXjSF7ZtqEp974x5FsUgzjiI+sQ
	/JR/v/VUfmBjyyMeNK+riT6LAls2W2vvwWttEF/PngvaY/wiB54ZP1mhaWrVmq7AZGa/sN7oc5s
	oMi6UqHjulrgygOqs3JS76MvOTX9xKbx8PTo9CJuDo/KeI6oKGWuj7gCJCqNVeilWa2AzcDbOww
	iVC0XYDV+xyaKLmJ2X0BYP7AzEt0TgWJRYQl1An/lHudZJ0fDtCj0zOKJh5EFspys8OsP48MMLu
	tubv81U6vmZiyG5CxLb1xAQ5n6rU6iI5CHqZ/L5DB80zwb8J1ZMIiIh4HhmacsHOyvzwhBw83ZN
	uEuUIl5MzRCKbDgFDz53F7uCyOO1iTMKma1wRiPBe21WYy3FGQWoAVeQWYRHsS6JY+loM44V1fw
	==
X-Received: by 2002:a17:90b:2247:b0:3ae:2969:9031 with SMTP id 98e67ed59e1d1-3b1b0d08f2cmr11373921a91.54.1794842852531;
        Mon, 16 Nov 2026 07:27:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aed76f95sm16670478a91.17.2026.11.16.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:27:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 10/21] bpf: Remove the limits on tables of functions
Date: Mon, 16 Nov 2026 15:26:15 +0000
Message-ID: <20261116152626.4032587-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

  4096 sets of functions       sets are in a hash table now
  1024 targets of one load     counted before duplicates were removed
  4096 pointers near a load    the scan is linear and can be killed
  1M pointers in all maps      the table grows

Nothing sorts the pointers: walk the maps in the order of their addresses,
and collect the targets of a load in a bitmap.

The number of a subprog in a set has 32 bits.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |   5 +-
 kernel/bpf/verifier.c                         | 132 +++++++-----------
 .../selftests/bpf/progs/verifier_callx_many.c |  31 +++-
 3 files changed, 82 insertions(+), 86 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 508aef9bad9d..3b40f66894d9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1332,6 +1332,7 @@ struct bpf_verifier_env {
 	/* What a pointer that was read from a table of functions may point to. */
 	struct bpf_func_set **func_sets;
 	u32 func_set_cnt;
+	struct bpf_index func_set_index;
 	bool has_callx;
 	/*
 	 * Call graph edges created by callx instructions. A bitmap of
@@ -1718,8 +1719,8 @@ static inline bool bpf_register_is_null(struct bpf_reg_state *reg)
 bool bpf_map_is_rdonly(const struct bpf_map *map);
 /* Sorted, no function is there twice */
 struct bpf_func_set {
-	u16 cnt;
-	u16 subprog[] __counted_by(cnt);
+	u32 cnt;
+	u32 subprog[] __counted_by(cnt);
 };
 
 struct bpf_func_ptr *bpf_map_func_ptrs(struct bpf_verifier_env *env,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f4e2a9f9f787..c5a44c887ada 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18,6 +18,7 @@
 #include <linux/vmalloc.h>
 #include <linux/stringify.h>
 #include <linux/bsearch.h>
+#include <linux/jhash.h>
 #include <linux/sort.h>
 #include <linux/perf_event.h>
 #include <linux/ctype.h>
@@ -6503,17 +6504,6 @@ int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 	return 0;
 }
 
-static int cmp_func_ptrs(const void *_a, const void *_b)
-{
-	const struct bpf_func_ptr *a = _a, *b = _b;
-
-	if (a->map != b->map)
-		return a->map < b->map ? -1 : 1;
-	if (a->map_off != b->map_off)
-		return a->map_off < b->map_off ? -1 : 1;
-	return 0;
-}
-
 /* Find the first pointer to a function at or after 'off' in the value of 'map' */
 static u32 func_ptr_lower_bound(struct bpf_verifier_env *env, const struct bpf_map *map, u64 off)
 {
@@ -7164,14 +7154,6 @@ static void mark_reg_func_ptr(struct bpf_verifier_env *env, struct bpf_reg_state
 	regs[regno].subprogno = subprog;
 }
 
-static int cmp_u16(const void *a, const void *b)
-{
-	return *(const u16 *)a - *(const u16 *)b;
-}
-
-/* that many different sets at most: each load from a table looks through all of them */
-#define BPF_MAX_FUNC_SETS 4096
-
 /*
  * A load from a table of functions gives one register: a pointer to one of a set of functions.
  * One state for each function would differ in nothing else up to the call, and there every
@@ -7179,49 +7161,40 @@ static int cmp_u16(const void *a, const void *b)
  * Equal sets have the same number, so registers are compared as they are.
  */
 static int mark_reg_func_set(struct bpf_verifier_env *env, struct bpf_reg_state *regs, int regno,
-			     u16 *subprogs, u32 cnt)
+			     const u32 *subprogs, u32 n)
 {
-	struct bpf_func_set **sets, *set;
-	u32 i, n = 0;
+	struct bpf_func_set *set;
+	u64 key;
+	int i;
 
-	sort(subprogs, cnt, sizeof(*subprogs), cmp_u16, NULL);
-	for (i = 0; i < cnt; i++)
-		if (!n || subprogs[n - 1] != subprogs[i])
-			subprogs[n++] = subprogs[i];
 	mark_reg_func_ptr(env, regs, regno, n == 1 ? subprogs[0] : 0);
 	if (n == 1)
 		return 0;
 
-	for (i = 0; i < env->func_set_cnt; i++) {
+	/* sets with the same hash have keys in a row */
+	key = (u64)jhash2(subprogs, n, 0) << 32;
+	for (; (i = bpf_index_find(&env->func_set_index, key)) >= 0; key++) {
 		set = env->func_sets[i];
 		if (set->cnt == n && !memcmp(set->subprog, subprogs, n * sizeof(*subprogs)))
 			break;
 	}
-	if (i == env->func_set_cnt) {
-		if (i == BPF_MAX_FUNC_SETS) {
-			verbose(env, "more than %d sets of functions\n", BPF_MAX_FUNC_SETS);
-			return -E2BIG;
-		}
-		sets = krealloc_array(env->func_sets, i + 1, sizeof(*sets), BPF_VERIFIER_GFP);
-		if (!sets)
-			return -ENOMEM;
-		env->func_sets = sets;
-		set = kzalloc_flex(*set, subprog, n, BPF_VERIFIER_GFP);
-		if (!set)
+	if (i < 0) {
+		i = env->func_set_cnt;
+		set = kvzalloc_flex(*set, subprog, n, BPF_VERIFIER_GFP);
+		/* nothing fails between the entry of the index and the set that it stands for */
+		if (!set || !bpf_table_next(env->func_sets, i) ||
+		    bpf_index_add(&env->func_set_index, key, i)) {
+			kvfree(set);
 			return -ENOMEM;
+		}
 		set->cnt = n;
 		memcpy(set->subprog, subprogs, n * sizeof(*subprogs));
-		sets[env->func_set_cnt++] = set;
+		env->func_sets[env->func_set_cnt++] = set;
 	}
 	regs[regno].func_set = i + 1;
 	return 0;
 }
 
-/* a read from a table of functions yields one of that many at most */
-#define BPF_MAX_FUNC_PTR_TARGETS BPF_MAX_SUBPROGS
-/* and that many pointers at most are next to what is read at variable offset */
-#define BPF_MAX_FUNC_PTR_RANGE 4096
-
 /* Count up to 'limit' offsets in [min_off, max_off] that the read is possible at */
 static u32 count_read_offsets(struct tnum offs, u64 min_off, u64 max_off, u32 limit)
 {
@@ -7263,7 +7236,8 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	struct tnum offs = tnum_add(reg->var_off, tnum_const(off));
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_map *map = reg->map_ptr;
-	u16 *targets __free(kfree) = NULL;
+	unsigned long *found __free(kvfree) = NULL;
+	u32 *targets __free(kvfree) = NULL;
 	struct bpf_func_ptr *ptrs;
 	u32 i, cnt, n = 0;
 	u64 o, lo, hi;
@@ -7272,13 +7246,14 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	ptrs = bpf_map_range_func_ptrs(env, map, min_off, max_off - min_off + size, &cnt);
 	if (!ptrs)
 		return -ENOENT;
-	if (cnt > BPF_MAX_FUNC_PTR_RANGE)
-		goto overlap;
-	targets = kmalloc_array(BPF_MAX_FUNC_PTR_TARGETS, sizeof(*targets), BPF_VERIFIER_GFP);
-	if (!targets)
+	targets = kvmalloc_array(min(cnt, env->subprog_cnt), sizeof(*targets), BPF_VERIFIER_GFP);
+	found = kvcalloc(BITS_TO_LONGS(env->subprog_cnt), sizeof(long), BPF_VERIFIER_GFP);
+	if (!targets || !found)
 		return -ENOMEM;
 
 	for (i = 0; i < cnt; i++) {
+		if (bpf_must_abort())
+			return -EINTR;
 		/* the offsets at which the read overlaps with the pointer */
 		lo = ptrs[i].map_off >= size ? ptrs[i].map_off - size + 1 : 0;
 		lo = max(lo, min_off);
@@ -7288,17 +7263,13 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 				continue;
 			if (o != ptrs[i].map_off || size != sizeof(u64) || value_regno < 0)
 				goto overlap;
-			if (n == BPF_MAX_FUNC_PTR_TARGETS) {
-				verbose(env, "read from map '%s' may yield more than %d pointers to functions\n",
-					map->name, BPF_MAX_FUNC_PTR_TARGETS);
-				return -E2BIG;
-			}
 			subprog = bpf_find_subprog(env, ptrs[i].xlated_off);
 			if (verifier_bug_if(subprog <= 0, env,
 					    "no function at insn %u for map '%s' offset %u",
 					    ptrs[i].xlated_off, map->name, ptrs[i].map_off))
 				return -EFAULT;
-			targets[n++] = subprog;
+			__set_bit(subprog, found);
+			n++;
 		}
 	}
 	/* pointers are next to what is read, e.g. the data of an array of vtables */
@@ -7313,6 +7284,9 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	if (err)
 		return err;
 
+	n = 0;
+	for_each_set_bit(subprog, found, env->subprog_cnt)
+		targets[n++] = subprog;
 	return mark_reg_func_set(env, regs, value_regno, targets, n);
 
 overlap:
@@ -22834,29 +22808,11 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 	return claim_used_maps(env);
 }
 
-/* that many pointers to functions are recognized in the maps of a program at most */
-#define BPF_MAX_FUNC_PTRS (1 << 20)
-
 static int add_func_ptr(struct bpf_verifier_env *env, struct bpf_map *map, u32 map_off,
 			u32 xlated_off)
 {
-	struct bpf_func_ptr *ptrs;
-
-	if (env->func_ptr_cnt == BPF_MAX_FUNC_PTRS) {
-		verbose(env, "too many pointers to functions in maps, the limit is %d\n",
-			BPF_MAX_FUNC_PTRS);
-		return -E2BIG;
-	}
-
-	/* grow by doubling, the array is sorted and searched later */
-	if (!(env->func_ptr_cnt & (env->func_ptr_cnt - 1))) {
-		ptrs = kvrealloc(env->func_ptrs,
-				 array_size(max(2 * env->func_ptr_cnt, 16U), sizeof(*ptrs)),
-				 BPF_VERIFIER_GFP);
-		if (!ptrs)
-			return -ENOMEM;
-		env->func_ptrs = ptrs;
-	}
+	if (!bpf_table_next(env->func_ptrs, env->func_ptr_cnt))
+		return -ENOMEM;
 	env->func_ptrs[env->func_ptr_cnt++] = (struct bpf_func_ptr){
 		.map = map,
 		.map_off = map_off,
@@ -22866,6 +22822,11 @@ static int add_func_ptr(struct bpf_verifier_env *env, struct bpf_map *map, u32 m
 	return 0;
 }
 
+static int cmp_maps(const void *a, const void *b)
+{
+	return cmp_int(*(const unsigned long *)a, *(const unsigned long *)b);
+}
+
 /*
  * Compilers put pointers to functions into read-only data: tables of functions,
  * structures of operations, vtables, where they are mixed with other data.
@@ -22890,17 +22851,24 @@ static int add_func_ptr(struct bpf_verifier_env *env, struct bpf_map *map, u32 m
  */
 static int resolve_func_ptrs(struct bpf_verifier_env *env)
 {
+	struct bpf_map *map, **maps __free(kvfree) = NULL;
 	int insn_cnt = env->prog->len;
 	int i, err, subprog;
-	struct bpf_map *map;
 	u64 addr, val;
 	u32 off;
 
-	if (!env->has_callx || !env->allow_ptr_leaks)
+	if (!env->has_callx || !env->allow_ptr_leaks || !env->used_map_cnt)
 		return 0;
 
+	/* with the maps in order the pointers are in order */
+	maps = kvmalloc_objs(*maps, env->used_map_cnt, BPF_VERIFIER_GFP);
+	if (!maps)
+		return -ENOMEM;
+	memcpy(maps, env->used_maps, env->used_map_cnt * sizeof(*maps));
+	sort(maps, env->used_map_cnt, sizeof(*maps), cmp_maps, NULL);
+
 	for (i = 0; i < env->used_map_cnt; i++) {
-		map = env->used_maps[i];
+		map = maps[i];
 		/* coincidences in maps that are shared with other programs don't matter */
 		if (READ_ONCE(map->user) != (unsigned long)env->prog->aux)
 			continue;
@@ -22926,9 +22894,6 @@ static int resolve_func_ptrs(struct bpf_verifier_env *env)
 				return err;
 		}
 	}
-	if (env->func_ptr_cnt)
-		sort(env->func_ptrs, env->func_ptr_cnt, sizeof(*env->func_ptrs),
-		     cmp_func_ptrs, NULL);
 	return 0;
 }
 
@@ -25516,8 +25481,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->callx_edges);
 	kvfree(env->func_ptrs);
 	for (i = 0; i < env->func_set_cnt; i++)
-		kfree(env->func_sets[i]);
-	kfree(env->func_sets);
+		kvfree(env->func_sets[i]);
+	kvfree(env->func_sets);
+	kvfree(env->func_set_index.slots);
 	bpf_diag_free(env);
 	kvfree(env->idoms);
 	kvfree(env);
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_many.c b/tools/testing/selftests/bpf/progs/verifier_callx_many.c
index 23c8948c24b8..804cdeb04845 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_many.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_many.c
@@ -47,7 +47,7 @@ REP400(MANY_FUNC)
 #define SETS400(mask) "r7 = r6; r7 &= " #mask "; r7 += r8;" REP400(SET_LOAD)
 
 SEC("socket")
-__failure __msg("more than 4096 sets of functions")
+__success __retval(11)
 __naked void callx_rodata_4400_sets(void)
 {
 	asm volatile (
@@ -65,6 +65,35 @@ __naked void callx_rodata_4400_sets(void)
 		: __clobber_all);
 }
 
+#define TABLE_5000(name, last, mask)				\
+__naked void name(void)						\
+{								\
+	asm volatile (						\
+		RODATA(tab, ".rept 2500; .quad many000; .quad many001; .endr;" last) \
+		"call %[bpf_get_prandom_u32];"			\
+		"r0 &= 8191;"					\
+		"if r0 < " #mask " goto +1;"			\
+		"r0 = 0;"					\
+		"r0 <<= 3;"					\
+		"r2 = tab_%= ll;"				\
+		"r2 += r0;"					\
+		"r2 = *(u64 *)(r2 + 0);"			\
+		"r1 = 10;"					\
+		"callx r2;"					\
+		"exit;"						\
+		:						\
+		: __imm(bpf_get_prandom_u32)			\
+		: __clobber_all);				\
+}
+
+SEC("socket")
+__success __retval(11)
+TABLE_5000(callx_rodata_5000_pointers, "", 5000)
+
+SEC("socket")
+__failure __msg("overlaps with a pointer to a function")
+TABLE_5000(callx_rodata_5000_pointers_and_data, ".quad 1;", 5001)
+
 /* 3 states that have no join get to a table of 400 functions: 3 states, and not 1200 */
 SEC("socket")
 __success __retval(11)
-- 
2.55.0

