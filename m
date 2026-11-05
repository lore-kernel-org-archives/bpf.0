Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897789;
	b=e59bIMu0R6TrehLG5myuP7Sxl+UoUyGJVSqihwRT50vKInQIl2Q5XVWP3tzusN6I+6nl
	 5ZzEPLxeoTrQHLFFFfKAc79yFw/6M8pjJkk9KRE5pvlHiZ7Q0ZkBSUdJ5KyQ9uINyXIVa
	 NiP4T+4a6pqXtZcBaazPmbLSfcywNF5INbg1loWTrb4STJB2x0A133JXkE8SCHBDpR4YV
	 6oLV0KymLTelg5Fe5FoO6Z/v/PBIwr14xIxwN6L8g/3a8dcgF5P61GfkB/EyDryQJFN96
	 TgXe9PiO2x/IHw286kmeum+A6lD5ljxrDm/9mTE0ltie05Gt35PwRFfE8wBfjG0W24Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=pBRlR/8tjMbA9qhIkAsEpuNhsprVSue5FxFuEQbdXfQ=;
	b=uhRcGMiYW1EmWe77wF3T5nFJiZ9VNaOsSRUvW70sPqePh2aWgKxpJtB4+mMUiiXAnM8J
	 wxI5De4NnO8CJ0XD4xbz7cMESS/J7zgPt3Y5IdBMTik93eCVHXf+mTW/qIc/T1g8hMm/0
	 ynIes4Hjt0iSehVzWrg7Pgx7haDmoLRRJf3nXgszFxKNPlErbebZgJBBAHKtuf+R6997C
	 zDgip/dglGnOo0sjCTbX5Gg7SyX2A/53xlXj0ZW+SE/NbImsz80IqLPWxRgD5cWJ7LJ2X
	 lkcxdUMfAYtS2TH2gKgDZVYOTM/2C9Xpv/rAlMDS9FJQsNIhQnFzzuddoyBxIs3VPHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QDwnx4Zw;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3270606A33B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 16:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3270606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QDwnx4Zw
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-677bc4704cbso2571504d50.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793897788; x=1794502588; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pBRlR/8tjMbA9qhIkAsEpuNhsprVSue5FxFuEQbdXfQ=;
        b=QDwnx4ZwyAqBSEaTbknjMqjEaUNlnoc1+z2esjIo80wNxGlfkK8Z3L0DoYhcWa2XFM
         ri95qRMHk1Q8QwOGHuKyAvPOMarHwSREi0IhDO8ODCEZdtPwNnfYaUjdh1MMVbdoZF1+
         mnf37Y+foviHtHTbfHf1V1dapBgBmgWP6y6Z5SkWnBd8mqsiDE95i76T0tmzyyY2UtIJ
         HpVMxZSLFG83JiRTWjIfnLtcxVIMItCWKKgFN41GjlgxaZFBbjQRguv8qibCWEAjuDvM
         dJ7PH5AptFiThYTDFWnwLDThZi6ub5HhsScGTH7jzyD7wguO+MYB3695eCZ4OG8ZANka
         O8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897788; x=1794502588;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pBRlR/8tjMbA9qhIkAsEpuNhsprVSue5FxFuEQbdXfQ=;
        b=UpjyHW1dUaHZF69vxocd7QZeAK2rOmStPgLVnE9bccxaJSQFcwU5tNdjMPEkkIPbHB
         GjdP4akaSjFgrZbRkxe00nkPR0wDabAYvNGQDXhvFy0Jy8Cgz3v5c7aYkEH5iDBytUM5
         ImyWWYCfAjN4i3s/lQ3hWCHgeUeI3ixaVyNhE0CsL0N1FRIqVjDZ87gOAgxTFGvuQlRM
         NreYD98LwJUo/lAzuktfKIz34HOCDD5W5XUV9Im6UjtQEjsCujwRrfiS8+iCOHG/8VXI
         5CT0+jJ77RAkmg7eFGNIT13feAUJCUXIM14rdPBcnivS+w8tHKAkeCD6o5BQ3s5vcNgB
         BPBg==
X-Gm-Message-State: APuU4Z+RPSYZ9VRtRk3GjWfE7QHhsTfAMDf1ZGI/EMAx2sJF/vgdNe4P
	58W/kLHT3TZj+Lc/aDneQRLOePnqoyOsacOnR9MY0CnzXTFEQsw20IGb
X-Gm-Gg: AYBFou0BuDe3+e9wc8Igph4Tn199Y7A1a2nx6zkD5GvlBVLMRsie7GAvDH+MC/+dGCz
	yPOI4ivZmVknSn6TQVKBp5nPpgxlfi/0PcIjX+namlEojzzhRrLLrLHJFAf03ws2oQgvO3hgVRf
	GSRMJA8KrDjwMuDFX6fHQMn4cwouI40YhQSdgmRkVGkrxw/fYwGYJ7nCSgVwrrWWkK2Yav93qdn
	BChl3UPJXR4N1lvJBILi/XrslQiueI/rgdNOrvZdKqLKaUx03sBRAOC7XcAM2AqkOYOHXE67wF3
	w26VxF+vIwRQJOOQZAJrNhtRAWwEKyI1QkDYuEb1hkdYF9ZqOjdzEFcPfa2T3SgTfjzDbPiFr4k
	iaBUMoU6IN+hv9YtnJBgc7Qc+Cpna8QLq6jJzPJgL8qkV/PehI4cQOJKVhTJQrc+7aOdM7yK1qT
	AFdEHRhx8yy9C3JaFrBrRhIIl184javaNMuEa2mn0GrkCa8BO2pWBxPB/FDH14GpzkozZx53Sxt
	8dvK3oCeDWcQgj8TKnsVWEEJeJXzeBwwr4Pdys88ww3D4CGXBqKFky4kLBzupb3l0BkBSkFXysz
	/82tYImWdM+TKKdDFWfK
X-Received: by 2002:a05:690e:13cb:b0:67c:4b5:d5e0 with SMTP id 956f58d0204a3-67c04b5dd40mr1292540d50.142.1793897787700;
        Thu, 05 Nov 2026 08:56:27 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:44::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c135a36fasm17142d50.13.2026.11.05.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:56:27 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Nov 2026 08:56:04 -0800
Subject: [PATCH bpf-next] bpf: Specialize inlined lookups for more htab
 types
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-hashtab-fast-hashfn-all-types-v1-1-287199376359@meta.com>
X-B4-Tracking: v=1; b=H4sIACS17GoC/x3NQQrDIBAF0KvIX2cg2qDgVUIX2o5VCEYcKSkhd
 y9k+VbvhHAvLPDqROdvkbJXeKUnhVcO9cNU3vAKZjZW63mhuFAOkkeIlIKMG6lS2DYav8ZCD+c
 4Om3ZGsak0DqnctzFitgSVT4Gntf1B3GRfgV8AAAA
X-Change-ID: 20261104-b4-hashtab-fast-hashfn-all-types-377eb716e62e
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793897785; l=10125;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=/LBRS/z3oKULVL8ZKe4T/FnD+GKnCwQoZkE5FLBDHvI=;
 b=PU471nGQp/Ui7BeirsMbQV+DC63ImjQ8WMleutyn5lDEfS8x0ZR+TFCZLLGvGWN6rGDY4Dlwv
 avA+DC+D4AOAgx3aQbmiOQCdwYKF6icXcpyUYboEBGVReLxuo6dBUyu
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Commit 63b13537e6b2 ("bpf: Speed up htab lookups for u32/u64 keys")
specializes the inlined lookup only for BPF_MAP_TYPE_HASH. LRU_HASH,
PERCPU_HASH and HASH_OF_MAPS still call the generic lookup.

Select the lookup function in all htab map_gen_lookup() callbacks by
key size and by has_hash. has_hash does not change after map creation,
so each variant uses a constant elem_has_hash. This also removes the
load and the branch on htab->has_hash for other key sizes.
LRU_PERCPU_HASH has no inlined lookup and does not change.

Calculate has_hash from map_type and key_size, not from struct
bpf_htab. For map-in-map, map_gen_lookup() gets the inner map
template, which is only a struct bpf_map. bpf_map_meta_equal() makes
these fields the same for all inner maps.

Measure with ten runs of:

  ./bench -q -a -w3 -d10 bpf-hashmap-lookup --key_size KEY_SIZE \
      --max_entries MAX_ENTRIES --nr_entries NR_ENTRIES \
      --nr_loops NR_LOOPS --map_flags 0x40

in a vng guest with two vCPUs, 4 GiB of RAM and KASAN off. For LRU and
PERCPU, the benchmark was changed locally to create an LRU_HASH or
PERCPU_HASH map. The workloads are:

               max_entries   nr_entries    nr_loops
  small                512          256   8,388,608
  medium            10,000        5,000   8,000,000
  large            100,000       50,000   8,000,000

Change of median lookup throughput:

                            key size (bytes)
                         1        4        8       10
  HASH     small     +2.4%    +1.7%    -0.3%    +2.7%
           medium    -0.2%    +1.8%    +0.1%    +5.1%
           large     +0.3%    +1.5%    +2.1%    +8.4%
  LRU      small     -0.8%  +116.6%   +42.8%    +3.3%
           medium    +1.2%   +62.1%   +37.6%    +5.1%
           large     +2.6%   +48.7%   +31.4%    +5.9%
  PERCPU   small     +0.1%  +195.3%   +82.0%    +4.0%
           medium    +1.6%  +133.1%   +73.6%    +4.3%
           large     +0.7%   +71.0%   +73.3%    +8.8%

HASH with u32 and u64 keys runs the same code as before, so these
changes are noise. HASH_OF_MAPS uses the same lookup functions as HASH.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
The LRU_HASH and PERCPU_HASH numbers come from a local change to the
hashmap lookup benchmark. That change is not part of this patch.
---
 kernel/bpf/hashtab.c | 107 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6e2115477cb9..a2d0bfd4c3ec 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -196,10 +196,15 @@ static inline void htab_unlock_bucket(struct bucket *b, unsigned long flags)
 
 static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
 
+static bool htab_map_is_lru(const struct bpf_map *map)
+{
+	return map->map_type == BPF_MAP_TYPE_LRU_HASH ||
+		map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
+}
+
 static bool htab_is_lru(const struct bpf_htab *htab)
 {
-	return htab->map.map_type == BPF_MAP_TYPE_LRU_HASH ||
-		htab->map.map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
+	return htab_map_is_lru(&htab->map);
 }
 
 static bool htab_is_percpu(const struct bpf_htab *htab)
@@ -224,6 +229,12 @@ static __always_inline bool htab_key_size_needs_hash(u32 key_size)
 	return key_size > sizeof(unsigned long);
 }
 
+/* map can be the inner map template, which is not a struct bpf_htab */
+static bool htab_map_needs_hash(const struct bpf_map *map)
+{
+	return htab_map_is_lru(map) || htab_key_size_needs_hash(map->key_size);
+}
+
 /*
  * When hash is omitted, key reads and writes must be atomic to support lockless
  * RCU readers. Zero-extend keys to the word size to support all sub-word key
@@ -676,8 +687,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	bpf_map_init_from_attr(&htab->map, attr);
 
 	/* Avoid hash memory use and comparisons where unnecessary. */
-	htab->has_hash = htab_is_lru(htab) ||
-			 htab_key_size_needs_hash(htab->map.key_size);
+	htab->has_hash = htab_map_needs_hash(&htab->map);
 
 	if (percpu_lru) {
 		/* ensure each CPU's lru list has >=1 elements.
@@ -892,13 +902,6 @@ static __always_inline void *__htab_lookup(struct bpf_map *map, void *key,
 	return l;
 }
 
-/*
- * Called from syscall or from eBPF program directly, so
- * arguments have to match bpf_map_lookup_elem() exactly.
- * The return value is adjusted by BPF instructions
- * in htab_map_gen_lookup(). u32/u64 specializations
- * allow utilizing compile-time key_size for optimization.
- */
 static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
@@ -907,19 +910,58 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 }
 
 /*
- * Specialized lookups for htab_map_gen_lookup(). These are only used for
- * BPF_MAP_TYPE_HASH (never LRU), so elem_has_hash depends only on key size.
+ * Called from eBPF program directly, so arguments have to match
+ * bpf_map_lookup_elem() exactly. The return value is adjusted by BPF
+ * instructions in the htab *_map_gen_lookup() callbacks. Constant key_size
+ * and elem_has_hash let the compiler specialize the hash and the compare.
  */
-static void *__htab_map_lookup_elem_u32(struct bpf_map *map, void *key)
+static void *__htab_map_lookup_elem_nohash(struct bpf_map *map, void *key)
+{
+	return __htab_lookup(map, key, map->key_size, false);
+}
+
+static void *__htab_map_lookup_elem_hash(struct bpf_map *map, void *key)
+{
+	return __htab_lookup(map, key, map->key_size, true);
+}
+
+static void *__htab_map_lookup_elem_u32_nohash(struct bpf_map *map, void *key)
+{
+	return __htab_lookup(map, key, sizeof(u32), false);
+}
+
+static void *__htab_map_lookup_elem_u32_hash(struct bpf_map *map, void *key)
+{
+	return __htab_lookup(map, key, sizeof(u32), true);
+}
+
+static void *__htab_map_lookup_elem_u64_nohash(struct bpf_map *map, void *key)
 {
-	return __htab_lookup(map, key, sizeof(u32),
-			     htab_key_size_needs_hash(sizeof(u32)));
+	return __htab_lookup(map, key, sizeof(u64), false);
 }
 
-static void *__htab_map_lookup_elem_u64(struct bpf_map *map, void *key)
+static void *__htab_map_lookup_elem_u64_hash(struct bpf_map *map, void *key)
 {
-	return __htab_lookup(map, key, sizeof(u64),
-			     htab_key_size_needs_hash(sizeof(u64)));
+	return __htab_lookup(map, key, sizeof(u64), true);
+}
+
+typedef void *(*htab_lookup_fn)(struct bpf_map *map, void *key);
+
+static htab_lookup_fn htab_gen_lookup_fn(struct bpf_map *map)
+{
+	bool hash = htab_map_needs_hash(map);
+
+	switch (map->key_size) {
+	case sizeof(u32):
+		return hash ? __htab_map_lookup_elem_u32_hash :
+			      __htab_map_lookup_elem_u32_nohash;
+	case sizeof(u64):
+		return hash ? __htab_map_lookup_elem_u64_hash :
+			      __htab_map_lookup_elem_u64_nohash;
+	default:
+		return hash ? __htab_map_lookup_elem_hash :
+			      __htab_map_lookup_elem_nohash;
+	}
 }
 
 static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
@@ -941,25 +983,14 @@ static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
  *         __htab_map_lookup_elem
  * do:
  * bpf_prog
- *   __htab_map_lookup_elem
+ *   __htab_map_lookup_elem_*()
  */
 static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 {
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
 
-	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
-		     (void *(*)(struct bpf_map *map, void *key))NULL));
-	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem_u32,
-				  (void *(*)(struct bpf_map *map, void *key))NULL));
-	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem_u64,
-				  (void *(*)(struct bpf_map *map, void *key))NULL));
-	if (map->key_size == sizeof(u32))
-		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u32);
-	else if (map->key_size == sizeof(u64))
-		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u64);
-	else
-		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
+	*insn++ = BPF_EMIT_CALL(htab_gen_lookup_fn(map));
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
 				offsetof(struct htab_elem, key) +
@@ -1001,9 +1032,7 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
 			    (int)offsetof(struct bpf_lru_node, ref) -
 			    (int)offsetof(struct htab_elem_lru, elem);
 
-	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
-		     (void *(*)(struct bpf_map *map, void *key))NULL));
-	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
+	*insn++ = BPF_EMIT_CALL(htab_gen_lookup_fn(map));
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 4);
 	*insn++ = BPF_LDX_MEM(BPF_B, ref_reg, ret, ref_off);
 	*insn++ = BPF_JMP_IMM(BPF_JNE, ref_reg, 0, 1);
@@ -2642,9 +2671,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn
 	if (!bpf_jit_supports_percpu_insn())
 		return -EOPNOTSUPP;
 
-	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
-		     (void *(*)(struct bpf_map *map, void *key))NULL));
-	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
+	*insn++ = BPF_EMIT_CALL(htab_gen_lookup_fn(map));
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
 				offsetof(struct htab_elem, key) + roundup(map->key_size, 8));
@@ -2931,9 +2958,7 @@ static int htab_of_map_gen_lookup(struct bpf_map *map,
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
 
-	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
-		     (void *(*)(struct bpf_map *map, void *key))NULL));
-	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
+	*insn++ = BPF_EMIT_CALL(htab_gen_lookup_fn(map));
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 2);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
 				offsetof(struct htab_elem, key) +

---
base-commit: 5b3d3e7e676630400bfb8a1470a7019803dbd997
change-id: 20261104-b4-hashtab-fast-hashfn-all-types-377eb716e62e

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

