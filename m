Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B0378830
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361035; cv=none; b=iQ9O0aRcqAzVkafuYddqqtAYB5fJ6uIAgaARpWT7PMEV9LjJoYtAQCyAK9qSDJDkaiVz4tuzIDJ7XL8FQHOb1uc5YpBcdS6O+3jYrTZl4qNdA+kkEOYDUAgfI+0NCwLmTNYAZaAOQuenFbaUTmefDuGNc9kD2U6B8wodX2nZINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361035; c=relaxed/simple;
	bh=7ZlZ02tOxvnsJM0I8ezGkWzXfwbAxqDMrZZqqpurG6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9wMyKvYbR2NO3wm5y1th77BuGaJE6l4C5V+L/ndsJpEcxTk4a8fwZkXb5haPzdZd/zdJEXYeGR1IQMYcw9Odct8Il8HJ/OXvi6R3WNScjgWXdQHR07LtGr++KsDvLQcDZqE0JLrcub7RxElWASbTfquM4vKMDhM6YjgCToUUG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=CABz8cl3; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="CABz8cl3"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-896f632d206so2456946d6.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 12:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771361033; x=1771965833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEDjLS1saIb0wBQPUNGL7fyh1rwuYwn4exU8ZXm/KKc=;
        b=CABz8cl33I6U+Vhhr60VrpX5LY9xOewHT5PNvdwZFyjV58ezEISloCnJq8nZcG3iHU
         IYj3vL3OJb20hcZ4Axol/JaHEBiIL0Sv8I8AS/OHQhNwu29oI8A3or3o0G6x4hAxZ+R8
         H2YdVD5UOX/fsqRD4mqq6gaaUjAVd4AOxNM7h6TQdJ5/i22qZudAGBeBjmgJS+J5Yujk
         sjj6sHGsagbqM7m4bGZakQv8IwcJxx1TGdX08hWU2ska3S2CDhTrLHX6/JmZSMg0/p3e
         gPNG5bUPYg9DYy/ixlWOuzYa/iE5u9osi5ceYRSG4KZlFoJ7HOEdlCsHlv8fCSAYA3M6
         ud8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771361033; x=1771965833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VEDjLS1saIb0wBQPUNGL7fyh1rwuYwn4exU8ZXm/KKc=;
        b=vO6XmbOOWTFyG2q3GmWtg2bSy/tSSLNikw/8dvPh1OK3UUipdixmILroy0wSHf7ovs
         z/ueMt4YU9L1Wo0klmckMXmLioHgZq/qs0S4UnyNftkC2odxD+ZYgw2iHIHPBNAZkdCA
         XoR6GOEt9O6IFmWPI9w98RuJ/ni37jIwtQdbJuxTDLLon8huE6GzSSMzQeFbo5kcUVe6
         FNCBj6rE53uv9wQWP3PxfZrDcxxBeSLiK7H3B4mLYZH6SDJ/eFiK1Ea4/DM6KOfxA3Xz
         9OauGFakO85EnwCjWBm+7uqqmusFgcu9QFFIKgGoWVd/2YaCfVPtptYudrkZv1pgMBqP
         36sA==
X-Gm-Message-State: AOJu0Yxu/qgQjQ4hFTjbXZk3aNYhKdxvprtARrQnKpkA0jlzpYRGAwp+
	LFXg21GXEBLtw+mkHumVzz+hJSRzdq+ZeALdSSoZ1Z3Vb+3djw0L60kwcYysxycnBNQF+hhApfy
	Ilq5vkBY=
X-Gm-Gg: AZuq6aLoup2GetBDioCsUuP11xWSpSbzUKolMuPRRocRSJG8ec7GRDKWLdFoabTbqhH
	8ZR+zYj3VtrmepeegJ6mVsOiXRWE2uA34TVTyYucRDpFxzmR6TdnSQD7WhkGc7W11phlHQYmsbn
	TWYj/U/jfouivU6QBxQyUc4LjsZqdWGLfKLiPCVrl/LYgjq1eMhcA6aFu18IyavDT6nP/EIem39
	i45F9rsEbF9NUiOhky3T9ZRj+F7nB/d98MWk2eLaCV8fb05c8jbgkmIa1zmePIohZU+EZVC4Gep
	+vfo64OnL+p5EI+HAnhiKz4aFJNpwRtWeuP5a46VdJ5pxTBsHXR9LKhHMUdumohxb2j0ohaKC/u
	3wUoPzKGpBr+JXPR017J7DzbcHI6hq4f4/yoaWxj6ufHDyH0vWcITJNzGKdLO3jI5+q0Zb3J/dX
	1a/P2o+3HLAfMmPMoKFGqFyA==
X-Received: by 2002:a05:6214:c2b:b0:894:5b77:ca26 with SMTP id 6a1803df08f44-8973f297175mr196230496d6.14.1771361033121;
        Tue, 17 Feb 2026 12:43:53 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0e12eesm1645349985a.15.2026.02.17.12.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 12:43:52 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 2/2] libbpf: Delay feature gate check until object prepare time
Date: Tue, 17 Feb 2026 15:43:45 -0500
Message-ID: <20260217204345.548648-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260217204345.548648-1-emil@etsalapatis.com>
References: <20260217204345.548648-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 728ff167910e ("libbpf: Add gating for arena globals relocation feature")
adds a feature gate check that loads a map and BPF program to
test the running kernel supports large direct offsets for LDIMM64
instructions. This check is currently used to calculate arena symbol
offsets during bpf_object__collect_relos, itself called by
bpf_object_open.

However, the program calling bpf_object_open may not have the permissions to
load maps and programs. This is the case with the BPF selftests, where
bpftool is invoked at compilation time during skeleton generation. This
causes errors as the feature gate unexpectedly fails with -EPERM.

Avoid this by moving all the use of the FEAT_LDIMM64_FULL_RANGE_OFF feature gate
to BPF object preparation time instead.

Fixes: 728ff167910e ("libbpf: Add gating for arena globals relocation feature")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/libbpf.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 93e59ed8d9a1..fa2da486124e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3009,12 +3009,6 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	memcpy(obj->arena_data, data, data_sz);
 	obj->arena_data_sz = data_sz;
 
-	/* place globals at the end of the arena (if supported) */
-	if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
-		obj->arena_data_off = mmap_sz - data_alloc_sz;
-	else
-		obj->arena_data_off = 0;
-
 	/* make bpf_map__init_value() work for ARENA maps */
 	map->mmaped = obj->arena_data;
 
@@ -4672,7 +4666,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		reloc_desc->type = RELO_DATA;
 		reloc_desc->insn_idx = insn_idx;
 		reloc_desc->map_idx = obj->arena_map_idx;
-		reloc_desc->sym_off = sym->st_value + obj->arena_data_off;
+		reloc_desc->sym_off = sym->st_value;
 
 		map = &obj->maps[obj->arena_map_idx];
 		pr_debug("prog '%s': found arena map %d (%s, sec %d, off %zu) for insn %u\n",
@@ -6386,6 +6380,10 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_DATA:
 			map = &obj->maps[relo->map_idx];
 			insn[1].imm = insn[0].imm + relo->sym_off;
+
+			if (relo->map_idx == obj->arena_map_idx)
+				insn[1].imm += obj->arena_data_off;
+
 			if (obj->gen_loader) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
 				insn[0].imm = relo->map_idx;
@@ -7373,6 +7371,7 @@ static int bpf_program_fixup_func_info(struct bpf_object *obj, struct bpf_progra
 
 static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 {
+	struct bpf_map *arena_map;
 	struct bpf_program *prog;
 	size_t i, j;
 	int err;
@@ -7387,6 +7386,19 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		bpf_object__sort_relos(obj);
 	}
 
+	if (obj->arena_map_idx >= 0) {
+		arena_map = &obj->maps[obj->arena_map_idx];
+
+		/*
+		 * Only relocate the globals to the end of the arena
+		 * if the kernel supports it. The field is 0 by default.
+		 */
+		if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF)) {
+			obj->arena_data_off = bpf_map_mmap_sz(arena_map) -
+				roundup(obj->arena_data_sz, sysconf(_SC_PAGE_SIZE));
+		}
+	}
+
 	/* Before relocating calls pre-process relocations and mark
 	 * few ld_imm64 instructions that points to subprogs.
 	 * Otherwise bpf_object__reloc_code() later would have to consider
-- 
2.49.0

