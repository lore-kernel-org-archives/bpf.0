Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFF274641
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006686; cv=none; b=TXIDl5bVY9lg4iCBI9emrctS42GkmjGQPVzFDVTaVK9oW3ECo0jw95kghXIBcZ7kx0ogaVjtZf0iZY2uyNgEeOGf86tvQ83m3Rcs9et7BpAGP/L4DGwcZ2lm7s2E02pcytCZNXD4tnJoVMjdBW4YVXnj25T8479htXkY3uGMIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006686; c=relaxed/simple;
	bh=Am6LJN+Vmd/w7uLfRvgjVF9sOoZDF4nC2fygJfuwSc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orwG8jPVHordEfRrPFzYLS34B3I2xt+fB9aeNdQrYjaYH9F2X3pMNM00uKXgFjBm/ATG6XelVtm4D078hLoM66prvsgbLqwhgTRg4bjU1/Tdviadl9GDB2Ox3nty1d172ZwX12JC+YxTV9M9khciDThsORk3I2OMqPUiLKDn+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ypdcBJAr; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ypdcBJAr"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb39f64348so114889585a.0
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 10:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771006684; x=1771611484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sm6AUKu2HnNd5hqM78UUttsHFFTZhykbANFHDcg2csg=;
        b=ypdcBJAr+PcaGoEkAZRtR9V7QAN85ht+HyNY/arddQG96vHJohfjC8Pf6YIoLT++1U
         NCcdZTCT+rWoaoXxttfQwsU82a9ta1ENaE+/VkCfbMa6VaDol5CynHqOhyWjL9br23/g
         qyTKmto3yPzIPC04rlpi77ndv9lMhRP1+SgftDRA+dqfpZH0rj0ZaqN+Chkwdy+ycZbi
         +NCjLV4JbB1ZbqEl6OM3ud20Ay1KkU6qqs+tJquNWZgDUpqReMlkHzmvGf6uRm+f0M8C
         L9gH9Ym+oRzV/5VqMyi2Zp+gctbJ0KBdCVE4HNt9DZP0A7rnoxrvKh91s7oBsAjwja+9
         vKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771006684; x=1771611484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sm6AUKu2HnNd5hqM78UUttsHFFTZhykbANFHDcg2csg=;
        b=Gvex7OwgVtxgBLL8TnXqVx8exXmI4lybI5LA0ZxV4GlYvFMgkGw1kISNZ+52fxc41v
         QRXOLhqbjZ6ia3ULcJr7ww0sUlZZokKNkMuvSirD4d+A8ZK88obN3v/9DfP14y4UIvYu
         zOCurnt01Z6UuydTY8NAqKRZjSaovC5+qdE27fzlNGpTDJiDPRJJle9AFUwet+gYWeO4
         0Vc28+tMiQ600sKpWk6D3CtFFXu9Y6TUIER9g1gyEPM2SVFuK5zSs5XgQwnXIYUGaE1f
         mv+bOQbUHdo/6hVdVJ+kgJc3qNaWhcz4ENc4qAc7Pj5mO0gew73vfLUmc07fKeLgHTPV
         3kcg==
X-Gm-Message-State: AOJu0Ywu1crDHz4LSnC8t4LSNy9GVnk6o42JKCe9UvEQdIoBiL2EKOFm
	xWuUMwEm6lLjftpLsL9nf7wrpx3o1rEEXL4EzbqSWcf9kQg7BQ9V8BMncoVSlnGBIquncsVA1PD
	ESy3O
X-Gm-Gg: AZuq6aLZgmRetyz/LBF9VNVErWBvBNshqIglqzznONZgUhalXzdzZjOPrMtSBMN28jc
	l1PrLb6omK+UP1LDeBWOVD8qBEgjKoZfXq3tiLn4ZEeg3KvBb1zlo8fp3UQ6T0j9b12iBp26ZNY
	5VBaqzjQTf9GjWDpEXnqG2oiwhEsUHiGgQSMMe4Lg1OnE4RsZ2RlL1sAG6h8C8TfZ4FF6KinA+y
	sAB6SlOW9misr3SLPBEGcypO49EXWfjyyc+tpjEEzE5c75pPAcqnYBJ4lY7NuEp1YIW0rMypVzX
	adQVKy1GdmmLKfpdaE/nq027M/04LvQ1UEaszNQ6e0UFyz3htD/a4+FiJ5hmfXeSy/rkdSLzVy6
	7xhuDRQMxXFsaWBq6VktRjYUg84bmDJdW0Bv9inB4MEk5ACsAa1DFHaA59W9TpnZxmlPWJ9XQ1H
	zFKm+RkzJoCPTmWPKe1clOHw==
X-Received: by 2002:a05:620a:3947:b0:8bb:a960:a6fd with SMTP id af79cd13be357-8cb4081fab2mr434931785a.10.1771006684332;
        Fri, 13 Feb 2026 10:18:04 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc91eccsm67337166d6.13.2026.02.13.10.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 10:18:03 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 2/2] libbpf: Delay feature gate check until object prepare time
Date: Fri, 13 Feb 2026 13:17:52 -0500
Message-ID: <20260213181752.505318-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260213181752.505318-1-emil@etsalapatis.com>
References: <20260213181752.505318-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 677755d502df ("libbpf: Add gating for arena globals relocation feature")
adds a feature gate check that loads a map and BPF program to
test the running kernel supports large direct offsets for LDIMM64
instructions. This check is currently used to calculate arena symbol
offsets during bpf_object__collect_relos, itself called by
bpf_object_open.

However, the program calling bpf_object_open may not have the permissions to
load maps and programs. This is the case with the BPF selftests, where
bpftool is invoked at compilation time during skeleton generation. This
causes errors as the feature gate unexpectedly fails with -EPERM.

Avoid this by moving all uses of the FEAT_LDIMM64_FULL_RANGE_OFF feature gate
to BPF object preparation time instead.

Fixes: 677755d502df ("libbpf: Add gating for arena globals relocation feature")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/libbpf.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 93e59ed8d9a1..ff38a9db1b13 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3009,11 +3009,11 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	memcpy(obj->arena_data, data, data_sz);
 	obj->arena_data_sz = data_sz;
 
-	/* place globals at the end of the arena (if supported) */
-	if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
-		obj->arena_data_off = mmap_sz - data_alloc_sz;
-	else
-		obj->arena_data_off = 0;
+	/*
+	 * possible offset for arena globals into the arena,
+	 * if supported at load time
+	 */
+	obj->arena_data_off = mmap_sz - data_alloc_sz;
 
 	/* make bpf_map__init_value() work for ARENA maps */
 	map->mmaped = obj->arena_data;
@@ -4672,7 +4672,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		reloc_desc->type = RELO_DATA;
 		reloc_desc->insn_idx = insn_idx;
 		reloc_desc->map_idx = obj->arena_map_idx;
-		reloc_desc->sym_off = sym->st_value + obj->arena_data_off;
+		reloc_desc->sym_off = sym->st_value;
 
 		map = &obj->maps[obj->arena_map_idx];
 		pr_debug("prog '%s': found arena map %d (%s, sec %d, off %zu) for insn %u\n",
@@ -5556,6 +5556,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 {
 	struct bpf_map *map;
 	unsigned int i, j;
+	char *arena_globals;
 	int err;
 	bool retried;
 
@@ -5633,7 +5634,15 @@ bpf_object__create_maps(struct bpf_object *obj)
 					return err;
 				}
 				if (obj->arena_data) {
-					memcpy(map->mmaped + obj->arena_data_off, obj->arena_data,
+					/*
+					 * Only relocate the globals to the end of the arena
+					 * if the kernel supports it.
+					 */
+					arena_globals = map->mmaped;
+					if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
+						arena_globals += obj->arena_data_off;
+
+					memcpy(arena_globals, obj->arena_data,
 						obj->arena_data_sz);
 					zfree(&obj->arena_data);
 				}
@@ -6386,6 +6395,12 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_DATA:
 			map = &obj->maps[relo->map_idx];
 			insn[1].imm = insn[0].imm + relo->sym_off;
+
+			if (relo->map_idx == obj->arena_map_idx &&
+			    kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF)) {
+				insn[1].imm += obj->arena_data_off;
+			}
+
 			if (obj->gen_loader) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
 				insn[0].imm = relo->map_idx;
@@ -14456,7 +14471,7 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 		if (!map_skel->mmaped)
 			continue;
 
-		if (map->def.type == BPF_MAP_TYPE_ARENA)
+		if (map->def.type == BPF_MAP_TYPE_ARENA && kernel_supports(*s->obj, FEAT_LDIMM64_FULL_RANGE_OFF))
 			*map_skel->mmaped = map->mmaped + map->obj->arena_data_off;
 		else
 			*map_skel->mmaped = map->mmaped;
-- 
2.49.0

