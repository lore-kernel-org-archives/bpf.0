Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D647A898
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099899; cv=none; b=CWBhAeVIB5anK+RyQuqzlQkM7GqUghmZqnqrt0c/K/opx323NIff5ba3q81OwwYaUIYpiU45Dcf49BKctl5c7aoH1iuGUm812qns4glzhPsIzPwnpI0aztwEBdini+L96cj2H4aW7e6IsOUEMXndhKjVcaN//mbltht8imTYIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099899; c=relaxed/simple;
	bh=oGpSvo0YAJhidR2cDORQyLO/pPfGFdaYIQbFGCMe5ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H6A1hvqgt1P+Y2DDhmhDeB+RBN8Bltkzy0rRZWeDmO2EG3ijCuLeQFLrzUXsnJ0uSU61TZe2M2Y1hGWO4Xez3mpP2g6go3cqTRYBLVzxKVrXd6abGd1H4610JtwMsZEpwxu2Ikcf/QsRaw0A9pF8UmffX2of0t/W1Phz/ysdiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjQPo2P4; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjQPo2P4"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a3c0d7aso33291b6e.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790099896; x=1790704696; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0Li3uXuovhdRU3e38N2WTOeZe15+HUxcSqtL1G0axbU=;
        b=AjQPo2P4V17ZtgbU6GEGi5/2DHWpgbGIlbYbxAB6yhjXoWauInqlNxnxlKtUy5JwPt
         wJ/2draZBvf71T0lu8JBjvJFzbZriReGp0hmZpsf+2+SVaCVZBtG6GTObHpUe1j8Xirx
         jVu6hI2GZ4Vwp1mGkpvWA9zlWOva5DincW0okLDxDZvboMmeJ/o5NWlzKp7mghZTvuMA
         2fgn2i6+WAFZmI9dDGHYd3L5kTf5pA0w/qYtExUU4sBBxeqo758Q20rVFQTxv2WI7JJl
         aGiTKLdJjELtFxHAxqsYR4N1cjTzW31U+1sKobsqMbB7hEB1zwdQa+nOcvYMMTB4fLCs
         ygJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790099896; x=1790704696;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0Li3uXuovhdRU3e38N2WTOeZe15+HUxcSqtL1G0axbU=;
        b=mxjw16IzkxnkijYOw7PKAN4GCTIhYIxPKAUVrL3laequ/6qGoLSjqWBfZ1oXx9K1a6
         h83MGcmA85WWCyiBwzFz8IMpslFATIwb/gMsoqUR7E0l9fg8X2DeS7ev44j4cm+Frwx7
         3FK41IUj5yrmdiHhBTgG2KOyDbi+/DJMXcXH6HbPxO26Ga6XFLfT3RJmvbJpZYbmiBFi
         fxqYpRLBBwqNYZt4ByX0Oa7y74YGpxNawEU9p9lVGxNQmEkFrA1WPkHsoXGwoBYTEPpA
         mWQmRdjystlSp2/rY9pEoh1j9IZ4j7CPFVzhUfO+ZA/RuY0x07Q9Iq2IBS+54wFlFVhz
         YAYw==
X-Gm-Message-State: AFuF++lXycQYR9BR3dSIUVYfCxZ5FCuePEsassPb9f7sgQP19CELe+Sa
	Li/BnwAJ7ikmdAQYcrhmejBZEuhIP/fxopAPL9AHeaXTHopaUvPCmsX0
X-Gm-Gg: AYBFou2wauXpcw/SYKMIvGmBJ24WnB3CVngrUIJ/LpIuSwHAkrDlxoTk5an6s3n4bMB
	ttyTvYXkSGVmG8nPpw98vmwouxDFr7r9H2e9ps0j3gng/xFHBDsrDOOUukwrgb9kNzG6TbDwNho
	AqIL8UtthvqZae0M2SPE2IA36KKbBUt3A+SPyz2DpjUgSdZZiY/9A79k3zpKHrowSRuf/5BMJCS
	ObkzqFcfTF2rmOeB4kJIx9WdnpGAoYkbubeXVYJNu3sQezzf1QNEodBLewxzxonOV8ZxbWFpZeA
	q+TBxMnlKGI4VTfqjwigOMBvzMEjlTTnY0ToH6WEHVWI1LGXWIZe+fwBvUfzDHqChSE9R9V/OQm
	LBsXj+bBfY8sZThXKnPRfbPP/csretGHmFkYolh0lgh7NrhUdOcd7LsN1qEASLWwC4BKxH1Oc/y
	fuW+pZ/NKmjzyOoV1l390nG2L9UEyanJ04iE1R0nwtkon+OHxiAVUyE1ar6y1R
X-Received: by 2002:a05:6808:1917:b0:4b8:46e3:e223 with SMTP id 5614622812f47-4d5af68b691mr217219b6e.15.1790099896192;
        Tue, 22 Sep 2026 10:58:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c4aed99bsm7791b6e.12.2026.09.22.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:58:15 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 22 Sep 2026 10:58:02 -0700
Subject: [PATCH bpf-next v3] bpf: Speed up htab lookups for u32/u64 keys
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-hashtab_fast_hashfn-v3-1-b7b0e9bc33ac@meta.com>
X-B4-Tracking: v=1; b=H4sIAKnBsmoC/43NywqDMBCF4VcJszbFjBiJq75HKTLGSc3CC0kQi
 /jupemmiy66PPzwnQMiB88RWnFA4M1Hv8zQiqoQYEeaHyz9AK0ALFGXRmk5UhwT9Z2jmLr3cLM
 0XGNfWcRGMxQC1sDO71m9Qb86OfOe4F4IGH1MS3jmu03l/pFR/ZQ3JZV0BokbtOzscJ040cUuU
 +Y2/INAqWRjiIxGtrXuv4jzPF8qfeodAgEAAA==
X-Change-ID: 20260916-hashtab_fast_hashfn-9e52b3c2276e
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790099893; l=7325;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=31kziWDsl7OBCb9JptO/q9S7jZ+wppXaQjFdHvKOCXE=;
 b=cilRPzhmbNfIhaVZfMG8oAbq+4SxGOAQ97KPs1MReMywIm/tQz5DiTZX3DIw6AhdkV7DXecF8
 I60gnk0R+HnDZYafo9uIqEPMpVcKWdyVoJ86OdbKq5E/cuAldPVGyLg
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Four- and eight-byte keys are common enough to warrant specialized htab
lookups. Use jhash_1word() and jhash_2words() for these key sizes instead
of the generic jhash2() path.

For JITed BPF_MAP_TYPE_HASH lookups, htab_map_gen_lookup() also knows the
map's fixed key size. Select u32- and u64-specific lookup entry points so
the compiler can specialize both hashing and key comparison. Other key
sizes continue to use the generic lookup entry point.

This preserves the jhash2() result and lookup semantics while avoiding
generic length handling.

Measure this with six runs of:

  ./bench -w3 -d10 -a bpf-hashmap-lookup \
      --key_size KEY_SIZE --max_entries MAX_ENTRIES \
      --nr_entries NR_ENTRIES --nr_loops NR_LOOPS \
      --map_flags 0x40

inside a vng guest with two vCPUs and 4 GiB of RAM. Run the baseline
first and the optimized kernel second. Use these workloads:

             max_entries   nr_entries    nr_loops
  small              512          256   8,388,608
  medium          10,000        5,000   8,000,000
  large          100,000       50,000   8,000,000

Mean throughput in million lookups per second is:

  Baseline:
                         key size (bytes)
                      1        4        8       10
    small         89.45    91.21   103.40    91.74
    medium       125.97    80.25    91.94    78.52
    large        140.67    53.56    58.68    47.31

  Optimized:
                         key size (bytes)
                      1        4        8       10
    small         86.95   197.77   168.65    90.88
    medium       124.97   147.48   137.76    77.51
    large        131.06    78.51    76.04    47.25

  Change:
                         key size (bytes)
                      1        4        8       10
    small         -2.79% +116.83%  +63.11%   -0.94%
    medium        -0.79%  +83.78%  +49.83%   -1.28%
    large         -6.84%  +46.58%  +29.58%   -0.12%

The u32 specialization improves lookup throughput by 47-117%, and the
u64 specialization improves it by 30-63%. Ten-byte controls remain
within a 1.3% slowdown. One-byte controls range from -6.8% to -0.8%.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
Changes in v3:
- Use __allways_inline everywhere compile-time key_size is
used (Alexei)
- Remove hashrnd adjustment in htab init, call jhash_1word()/jhash_2word()
- Link to v2: https://patch.msgid.link/20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com

Changes in v2:
- Added variants of __htab_map_lookup_elem() functions with inlined
u32/u64 key sizes, use them in htab_map_gen_lookup();
improved lookup perf significantly (Alexei)
- Link to v1: https://patch.msgid.link/20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com
---
 kernel/bpf/hashtab.c | 63 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6f331c80130d..f744a42bb813 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -677,11 +677,18 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
-static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
+static __always_inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
 {
-	if (likely(key_len % 4 == 0))
+	const u32 *k = key;
+
+	if (key_len == sizeof(u32))
+		return jhash_1word(k[0], hashrnd);
+	else if (key_len == sizeof(u64))
+		return jhash_2words(k[0], k[1], hashrnd);
+	else if (likely(key_len % 4 == 0))
 		return jhash2(key, key_len / 4, hashrnd);
-	return jhash(key, key_len, hashrnd);
+	else
+		return jhash(key, key_len, hashrnd);
 }
 
 static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 hash)
@@ -712,9 +719,9 @@ static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash
  * the unlikely event when elements moved from one bucket into another
  * while link list is being walked
  */
-static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
-					       u32 hash, void *key,
-					       u32 key_size, u32 n_buckets)
+static __always_inline struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
+							       u32 hash, void *key,
+							       u32 key_size, u32 n_buckets)
 {
 	struct hlist_nulls_node *n;
 	struct htab_elem *l;
@@ -730,22 +737,15 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
 	return NULL;
 }
 
-/* Called from syscall or from eBPF program directly, so
- * arguments have to match bpf_map_lookup_elem() exactly.
- * The return value is adjusted by BPF instructions
- * in htab_map_gen_lookup().
- */
-static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
+static __always_inline void *__htab_lookup(struct bpf_map *map, void *key, u32 key_size)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct hlist_nulls_head *head;
 	struct htab_elem *l;
-	u32 hash, key_size;
+	u32 hash;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
-	key_size = map->key_size;
-
 	hash = htab_map_hash(key, key_size, htab->hashrnd);
 
 	head = select_bucket(htab, hash);
@@ -755,6 +755,28 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 	return l;
 }
 
+/*
+ * Called from syscall or from eBPF program directly, so
+ * arguments have to match bpf_map_lookup_elem() exactly.
+ * The return value is adjusted by BPF instructions
+ * in htab_map_gen_lookup(). u32/u64 specializations
+ * allow utilizing compile-time key_size for optimization.
+ */
+static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
+{
+	return __htab_lookup(map, key, map->key_size);
+}
+
+static void *__htab_map_lookup_elem_u32(struct bpf_map *map, void *key)
+{
+	return __htab_lookup(map, key, sizeof(u32));
+}
+
+static void *__htab_map_lookup_elem_u64(struct bpf_map *map, void *key)
+{
+	return __htab_lookup(map, key, sizeof(u64));
+}
+
 static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct htab_elem *l = __htab_map_lookup_elem(map, key);
@@ -783,7 +805,16 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 
 	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
 		     (void *(*)(struct bpf_map *map, void *key))NULL));
-	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
+	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem_u32,
+				  (void *(*)(struct bpf_map *map, void *key))NULL));
+	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem_u64,
+				  (void *(*)(struct bpf_map *map, void *key))NULL));
+	if (map->key_size == sizeof(u32))
+		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u32);
+	else if (map->key_size == sizeof(u64))
+		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem_u64);
+	else
+		*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, ret,
 				offsetof(struct htab_elem, key) +

---
base-commit: 6e1ac8758fcd07bee12ccaff0087cc66930a4187
change-id: 20260916-hashtab_fast_hashfn-9e52b3c2276e

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

