Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E23D8902
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026107; cv=none; b=AGLbzFV9jfd7pyDaKJK2ovEd4vbtIVjw8fc1hgcppDFsFOksSKhv4fp1xExxshQwEyLfE58VFDtBRRn4bv/5HysjPSJMNj8N0inkNrrGI4xiRaGPJdh4DkxmPa2mu9V6XzJeVfOmO/3hNEFZQhi3D3DWpuhQ0H0THfdz4usTLds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026107; c=relaxed/simple;
	bh=g5GJG6c9xyTT7+BCnWj7ZXdcGKvL8usybthaZcLAXkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NUzcWphzVCrv3f6W0RRCblGdCwQrXKw7Jh3IgXImsHnlD5RrpyHZK/DTFKGS8JIIjf4LjQQloHE2Hz17Cedjhgr3OENUWvjJoVZaV+5jrdu5ny1fya7DCHW5OzOCJUMn+HR/1N6ORXpYuPSfxxsCpDu2qQeKpWEtmhNxXhryfW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGFBvLiG; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGFBvLiG"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a39a42dso1285424b6e.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790026105; x=1790630905; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+i6o7GkzSF5xhU7sycQXlwKc3jnyfIN+7UiK/HuibvU=;
        b=IGFBvLiG07ELHn9u/BMlzp+jCeXd2vaVbRYvxAe9quiIG9GYIiTLrY8hQ+Gbhqaw4i
         iSssVB8gljiCSOIgt1qlnOI6MMRUuUBarzqRMPYWJGqbP6SFpaiZDLV6lFdQBLzUlEUY
         N6eoo+2/0MYNeAUeVRiFiY9SmI25izeBajgyVuz4B7DBSJyEHakJ0cxwBZTgsbrzPktq
         B/iE/crfBH/YVMFBRw8Mi9YEY+Y3dfG8/lZrmGF7Ua3Yep/qbnpw+ipmG0sec0JEqcF/
         JK2+ejC7HBwI2p1JkT8IJ7QXDU8AyUgS3qNb6tvYeUtGy9IY/WJFRfizncAIZa9Knrm4
         ikIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026105; x=1790630905;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+i6o7GkzSF5xhU7sycQXlwKc3jnyfIN+7UiK/HuibvU=;
        b=pucLg47Gh2Mr9wmpwmgMUNlr0pKCboeqHtVtANveCo5MdIyo0BSIvjHFzezz9ZVc4R
         7czoqJhHLoi5qP5EFF/Idem7MtUFmCWyMaIE9hZsGaW1yJBhBRO0zdXOIZAu13jFV8Ef
         l/q6k9vQpi9BuVx5vlAaigKt+MAzYT5B2s2oBp+dT4iDflNjP9CjGOxeIqh7uKRWTIgF
         YLLb6a/SytwVI3T1n6R143HLqnsKRWaEq8Zc7gf2xj2OcGY6FJfeT4JRtQsf6qBK3acQ
         eyAD5wmXjefx4udtPROUwgvk/7b9zVSzNZ4EXsU3TsJ0FWazFPzgXADy6HDbd/oSGnMQ
         Re9w==
X-Gm-Message-State: AFuF++m/Q/MQM4HTM714LpgPOYazaYhR5xeNeZGoBC3w5+lsMdJvLHFw
	QtEdnwy+0L4fBVc+BLt6kKJw+J2ojP2py3Gp6BDBW+jej4Hkv/ePQgiN
X-Gm-Gg: AYBFou2sybmq1pajhOVQC74EvRTkBbv6FWlm2zleA9SjU5sFjU1YDGFLuButCbsXPzF
	zsQ7oCIKQfY6khhQ01zHVq0p5L8iPYJENoprU6HmKNDXr5NL98dgeLAGkpmdmKjK4VCaMPoiu6L
	LzWRcicHaXoJze/SuPDT9ESLTLdgnBOUCrHYrvWwaySIc8vyEP1YIC2KtF7iAMAVaPnGp2/YXyV
	6SOHWkViD/LUupBM8r8R/O0z9UUFaFXcIx6TtUiwewA2cOeDxurJNh8kYaXBRz6Ssbo35ic+DI0
	se0j+PZOBeIfkZU7a/abZwCNwgigO2DiVuot3p8Z7zxFIIxI7SLvDr695d3bsbtcjUiGC8CFld4
	+PNFLSqG0xRNlArjBz/HvkgoAtdYk76VqqEJXRgI5nYfX1O4gnsWjrZUmEf4GaCWSf8BJ9vgiLd
	SwMuL/mZO55Nz+FQRDJ8zfTVu8Gz/unP0gfTO4Rua51gI1rHRpGfzN54tlvqB0ag==
X-Received: by 2002:a4a:edc3:0:b0:6b1:4845:9a76 with SMTP id 006d021491bc7-6d1580786f3mr856610eaf.1.1790026105131;
        Mon, 21 Sep 2026 14:28:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d181ae5a14sm432138eaf.3.2026.09.21.14.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:28:24 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 21 Sep 2026 14:28:17 -0700
Subject: [PATCH bpf-next v2] bpf: Speed up htab lookups for u32/u64 keys
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
X-B4-Tracking: v=1; b=H4sIAHChsWoC/23NQQqDMBSE4auEWZtiXqmiq95DRGJ8abIwShLEI
 t691G67HH745kDi6DmhFQcibz75JaAVVAgYp8OLpZ/QClBJVdmoSjqdXNbjYHXKw3fYIBt+0Hg
 3RHXFKATWyNbvl9phXK0MvGf0hYDzKS/xfd1t6uo/mdRfeVNSSduQ5poMWzM9Z876ZpYZ/XmeH
 8XKCW2/AAAA
X-Change-ID: 20260916-hashtab_fast_hashfn-9e52b3c2276e
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790026102; l=6161;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=klYkD/UfVahvAsNX2ylLTW4rdg2QjBRyrXyE08PFpDg=;
 b=SGZgAlzgiv7AQaLH2XNin2+l5siBUfozckwp3eik+oYJ3vs2E5fFbRXnJT+JMdPTbJI5hw/OR
 1+BT220qfFzD1dQPurP8J8/ZaOvwiLaKprEM304Bxg4I/BXBPVOVLMk
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Four- and eight-byte keys are common enough to warrant specialized htab
lookups. Fold JHASH_INITVAL and the key length into hashrnd once when
allocating maps with these key sizes.

For JITed BPF_MAP_TYPE_HASH lookups, htab_map_gen_lookup() also knows the
map's fixed key size. Select u32- and u64-specific lookup entry points so
the compiler can specialize both hash setup and key comparison. Other key
sizes continue to use the generic lookup entry point.

This preserves the jhash2() result and lookup semantics while avoiding
generic length handling and repeated state setup.

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
    small         86.95   233.63   168.65    90.88
    medium       124.97   150.20   137.76    77.51
    large        131.06    80.51    76.04    47.25

  Change:
                         key size (bytes)
                      1        4        8       10
    small         -2.79% +156.15%  +63.11%   -0.94%
    medium        -0.79%  +87.17%  +49.83%   -1.28%
    large         -6.84%  +50.32%  +29.58%   -0.12%

The u32 specialization improves lookup throughput by 50-156%, and the
u64 specialization improves it by 30-63%. Ten-byte controls remain
within a 1.3% slowdown. One-byte controls range from -6.8% to -0.8%.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
Changes in v2:
- Added variants of __htab_map_lookup_elem() functions with inlined
u32/u64 key sizes, use them in htab_map_gen_lookup();
improved lookup perf significantly (Alexei)
- Link to v1: https://patch.msgid.link/20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com
---
 kernel/bpf/hashtab.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6f331c80130d..77c96105eda8 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -612,6 +612,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 		htab->hashrnd = 0;
 	else
 		htab->hashrnd = get_random_u32();
+	/*
+	 * Fold the jhash constant and key length into hashrnd once for the
+	 * fixed-size fast paths instead of doing it on every lookup.
+	 */
+	if (htab->map.key_size == sizeof(u32) ||
+	    htab->map.key_size == sizeof(u64))
+		htab->hashrnd += JHASH_INITVAL + htab->map.key_size;
 
 	htab_init_buckets(htab);
 
@@ -679,9 +686,19 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
 {
-	if (likely(key_len % 4 == 0))
+	const u32 *k = key;
+	u32 b;
+
+	if (key_len == sizeof(u32))
+		b = 0;
+	else if (key_len == sizeof(u64))
+		b = k[1];
+	else if (likely(key_len % 4 == 0))
 		return jhash2(key, key_len / 4, hashrnd);
-	return jhash(key, key_len, hashrnd);
+	else
+		return jhash(key, key_len, hashrnd);
+
+	return __jhash_nwords(k[0], b, 0, hashrnd);
 }
 
 static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 hash)
@@ -735,17 +752,15 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
  * The return value is adjusted by BPF instructions
  * in htab_map_gen_lookup().
  */
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
@@ -755,6 +770,21 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 	return l;
 }
 
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
@@ -783,7 +813,12 @@ static int htab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 
 	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
 		     (void *(*)(struct bpf_map *map, void *key))NULL));
-	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
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

