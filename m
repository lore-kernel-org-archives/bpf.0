Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808664;
	b=WQ5djMqeuTTVTdB4qUOekxjMs41T/jUNOLShs9XA+K47mNt+isZHsrC0R9yb+HuwNvfu
	 8HKPdcBl3BwFw/65+8wvRIZgAuyJmmJ7/i7J5xG8f1MEcEHlEZW5VxhfgIos7bO65oAbh
	 8nfmDwgFUBfl6Avl9lbphQfWbJynjqBcwyt5JFbT7NIA+P+lVzEXTHoGNFwWHcuZ/Q+Kq
	 M1KikfkqPvTFzwgtMPpZeFTXEnMnpJLFxx12qRk0kXeE31tKDs3+roBAYoh8r/O47LtKW
	 JzsrwdZv/Ke6n+nFK8ulJMMvKMd5quMVywAZMTDbAAzjpxBBgYcCfjxqBFZYd2ZR7eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jstkA0JFdoP6SWPHO+WGBx6wEgColfbT3T9UnDccMv0=;
	b=HFggeeZOp3FfB4y4b+nHc4ScFnOPa+0ZWpWqb1j2J/9mLGs1sP+WDX/J5A5+jB4l+rjd
	 YcPFvAoKC8lxCGalgADiyAlBmgfUd7WWkZdIhTS+hVL0+FpzAkh7xiiaCgjLM7jSZlKpw
	 W1Sc1N+8tDYRgdbdMdZbIKh2vWw3nCk+7CvDW2sFUTonnOWEJe9dAxp+WZ/RYahBHRkxe
	 xcPMYF0KE4lzYK41bXCMB01B8nHvPyoU5AM2LsntPhu2dhBFSSlgHFfK44pN2Zv1PD81M
	 7d33YFrBieoaha8H1VDknL5+XmI/5KKasq8IbEQpDh183IWJf8bJoEqwFXYvhohGOHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dOKY0vik;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18D606A8B2
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC18D606A8B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dOKY0vik
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1580694a12.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808663; x=1795413463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jstkA0JFdoP6SWPHO+WGBx6wEgColfbT3T9UnDccMv0=;
        b=dOKY0vikspDPit1mz1AR44ZdtIQV6rOyKv1MuHeW5P8NeAVTNPSCuXw1fChibdZmcR
         dzYcsEB4GyrgzXFUThf0t6Am1LnyLiw3JdybsKvcckvKzx26LcnLj0JLvveoUX0NMUpC
         PpRY7uLUFflZRb5U1+gGziA8Hu66WisfmlN+ivMfy+40zRvXvpdhLcZSVrCmLpb0Xu9R
         wZphn/XfdHPxbLNSX87VWB/1vYvT046TfulRD0/WwnNHPsjGOkwMMQ5Xo2X9l3blUlKy
         p0bGBR+rzZ86gs5P3PbO/fKsTTCFbOdTXEmizd5Na3Y/vAWta/3xC2mtXchyDrlrqrUw
         U0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808663; x=1795413463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jstkA0JFdoP6SWPHO+WGBx6wEgColfbT3T9UnDccMv0=;
        b=22oLcOG/ZCYoCUcfHBYBSXZpIpabvvCINem8FD/1mq0iXoSt9Qfx4piObjm9zzAVIs
         yBdEga+ejKSCzKtPgJoWaLF4i+el12p12rO8FiIMmqixi2US28JcwFeKhqmaoiQlL8LE
         eYRmiZG7RYKFlaOlfCo6uHtwep6MYIqDTLo6zsnHHYgbNVMH4LIVCg9VCDrkyyfPOyOt
         43pCd7mZ0RfQLn6fd4WavWJJVQggZYzr7SN1+iBTU906VeHc4clrW4m841YAG0pt4+HY
         0XqYv54M0Uq2YiuR+JbrNxT7hw/YzOpRar2lXCT1R6PXaE8LAFKzqbpwsS0GjCgvZ9lR
         fd5A==
X-Gm-Message-State: APuU4Z/AGq75VWqH7DNIB65fIPkYp78NYBBtB0qfT47OZVoc7yIcOV8v
	hFXKf+vS34D4JfLOw20P+NmJADAfnr6nSvxhJUtTti6dqgdee4KkE9QOygfx8g==
X-Gm-Gg: AYBFou3jAS7D2D5UajHnE1LmaizjxJOjm77oIc9xpue8wJlbprKgHDla0WL4jo620B4
	jc6I0PI7erwsF/wmnO33brP2VqAn0mzTepioeHLT4r6Z08gnDBOSQPD59Pc/fDB2eoJzNQcNpy1
	qqjCOUcT3vsqyMACWEVRdGatm9VAHDiz6qEhLiGTogI9ncVtaJMWHO8DWLffQcLyU6GAOKpIhIT
	5KTV3SWu0/3ZMXBWVMGy/gii0gQkBcPeleWoawrxVrb4FdhgtZ+ClkWb6yPmFlWhRrv2bL/6Iw3
	XYxOhDMmrFa4HT0LWIgBQEqgfiTxg929QwnAh8zsnSd0YwW26bdKNZ+a427JwOUCHHvf5KLUjbz
	6YQ4XOMj2gUn7lhAsAjWHogdnAlpJTmzbowdDDzy0gZX148rLktUCeKCMSNmHzyVrG5MU9swV+l
	7HtdqjH4r9qaJRCVBbSXlzeVJySs8nfJvmHJ4N/TW6Q7EHvh91U6i9rqm/IV08UGusOT+1X8EgO
	wlus11/tb1T5kvQ29SptdCdpgDM/kbQr94jOs90Qd2SAUVDRLDClbs7FxXjkZZodXXW9No/UuyM
	HZFERJXNwrpsddtyWeteou6/e4aD5DzlXfZXZ5ID9pKpd3AxBa2tA4InEkh4ZTxO1cQ/JNRV+UC
	XzNkx4dXczPf7fe2LCckrRptJlSrlpKP52+ZBM0x5MWs13K1cSnv/OQ49rtqxWgqbwaIm2Nv5cg
	==
X-Received: by 2002:a17:90b:4ec5:b0:3b1:6689:a016 with SMTP id 98e67ed59e1d1-3b1b0b8f9cfmr5637088a91.16.1794808662783;
        Sun, 15 Nov 2026 21:57:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b266d873sm7528973a91.1.2026.11.15.21.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:57:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 10/21] bpf: Remove the limits on tables of functions
Date: Mon, 16 Nov 2026 05:56:27 +0000
Message-ID: <20261116055638.4171529-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/verifier.c                         | 127 +++++++-----------
 .../selftests/bpf/progs/verifier_callx_many.c |  31 ++++-
 3 files changed, 79 insertions(+), 84 deletions(-)

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
index f4e2a9f9f787..e29eb7d7162b 100644
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
@@ -7179,49 +7161,39 @@ static int cmp_u16(const void *a, const void *b)
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
+	if (i < 0) {
+		i = env->func_set_cnt;
+		if (!bpf_table_next(env->func_sets, i) ||
+		    bpf_index_add(&env->func_set_index, key, i))
 			return -ENOMEM;
-		env->func_sets = sets;
-		set = kzalloc_flex(*set, subprog, n, BPF_VERIFIER_GFP);
+		set = kvzalloc_flex(*set, subprog, n, BPF_VERIFIER_GFP);
 		if (!set)
 			return -ENOMEM;
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
@@ -7263,7 +7235,8 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	struct tnum offs = tnum_add(reg->var_off, tnum_const(off));
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_map *map = reg->map_ptr;
-	u16 *targets __free(kfree) = NULL;
+	unsigned long *found __free(kvfree) = NULL;
+	u32 *targets __free(kvfree) = NULL;
 	struct bpf_func_ptr *ptrs;
 	u32 i, cnt, n = 0;
 	u64 o, lo, hi;
@@ -7272,13 +7245,14 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
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
@@ -7288,17 +7262,13 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
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
@@ -7313,6 +7283,9 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	if (err)
 		return err;
 
+	n = 0;
+	for_each_set_bit(subprog, found, env->subprog_cnt)
+		targets[n++] = subprog;
 	return mark_reg_func_set(env, regs, value_regno, targets, n);
 
 overlap:
@@ -22834,29 +22807,11 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
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
@@ -22866,6 +22821,11 @@ static int add_func_ptr(struct bpf_verifier_env *env, struct bpf_map *map, u32 m
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
@@ -22890,17 +22850,24 @@ static int add_func_ptr(struct bpf_verifier_env *env, struct bpf_map *map, u32 m
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
@@ -22926,9 +22893,6 @@ static int resolve_func_ptrs(struct bpf_verifier_env *env)
 				return err;
 		}
 	}
-	if (env->func_ptr_cnt)
-		sort(env->func_ptrs, env->func_ptr_cnt, sizeof(*env->func_ptrs),
-		     cmp_func_ptrs, NULL);
 	return 0;
 }
 
@@ -25516,8 +25480,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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

