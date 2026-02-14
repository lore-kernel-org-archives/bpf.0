Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A95239567
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771035104; cv=none; b=MDVSPA7I9OFxhaNVVouDSulkvX8h5sBHWg2jQFL72QOqo5eLymljNxEAkw1vLAt9FMpWoVjqTdl8sPYYuYHHLABz440wHqhF3+Spr6qgT0CiaEwHfh139mwyadmFoVmZ8MZGrk1kZciUUsh8qaT1LjaScNYjoiWCDRLJmtf1pMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771035104; c=relaxed/simple;
	bh=Y8fie53piYCj7rsCh0CQhUjH3/cB/QRHpFlb+0hcc0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4idThDVkLxdrz5m31TYKjabed9fKCfc5muPD8Nk4O6Zq0jJ46/Q83zlepilF9zib0Q1bcI1Tg+l0fuuaq/zEXAZ4pzdBHG+hemkJjao7vO4+j3YshShXHVuJlHyN6aoMCODVJKoQ7xoQ4z2OS8j7qfvKViM/lEBUYQspvIpkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=FAASGZf+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="FAASGZf+"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a1b23c05so18828381cf.0
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771035102; x=1771639902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrnXMsKTUyjpPdiSJlUyq4gke8OPYe4gkr4yWaLvAIw=;
        b=FAASGZf+nr1oaKnoarOzKJRwCqzs8CAKvRnFB17QZJ+6HiJkt9d/W7IIOhuyN4B6Jp
         OSwgRLpJRCKsvqLtMr/oL6ekDvuJwJyzJ3MIWi9wJMUa74eRi6deoRHctzdVr3jeX3Qg
         UFZLSulJ/vXAXSf/IqeKgE6W8UrCI1ENmcgfU0L+ZV7gBhHNI7glxfU8xriwsQXk19ZX
         S88Vw1uOc4Mwu2FLHVgJapd1u5XR8rEHs7ORK9HQdarMN1CAgjFY4U3kcKkLpSE6rvBF
         HuQue7PIEYb8vAfggbIyPOfNsP40fKc4NH4rE+IosC+ukJbCYQ8Usx797fnk81vPph1Q
         d7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771035102; x=1771639902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lrnXMsKTUyjpPdiSJlUyq4gke8OPYe4gkr4yWaLvAIw=;
        b=pY8Lloj5bSTig7CnnN6YTlRJwnA2Sp+Gk7b39pbhr71EpLQQPWwQth3mL+zJ6NIdpu
         aJ92KlBgby6010RcVshCOlVcBnutIbLlOzypPnd3gQonwIeSNsmw0pxMPD/t7nHPECEk
         0AElMcvgk0XlA9n7Q/7IlutfEwRwfkxPmoK9ZLNR12tT8jG9sGSZXJFQ2SZXjW2+fRaF
         6E76Lw8DMnxD/aJxoX9kJmul8Tk33V/hbAcrQlAI9WowFmn4BpFqasfALj/GYFctNIqM
         muW7wzsWXxs5vOsN31uKV0EjDYKJprcNGX46tGonNHMg9wlDrklpeC39u5uvBwBcz30F
         mjhA==
X-Gm-Message-State: AOJu0YwFVzEXBxJ+bMuucZIhbL6kAzchz3kxiCC8grgTkJm1FaAMuTtj
	sgtTnBYInRJAXQB+tmAhfTCRJoI8heFSTQyo469ixCm/a7SdXBRniDrCWn6KGjU5XBVTw14v/hU
	0JsyT8T8=
X-Gm-Gg: AZuq6aIWwcD+2vXOhB5DdAVSqyCPmHHehifDn1mOSMHZJfKxV9JfsDSunGKEFXXFCI4
	ljyl9eMEg5XFwVc0ZObmFv2JZtJdP0Ris5NEtExq/PURa6kW7DwHqZPF8Q1tRd7CRojmMCtxVZa
	HRcZt5k71Fnxb/xuL8W/csolwo2q8fGI+puFtg+0foF29cPlaZhYk0Ccgi25XzYoRozNeF7H0N3
	Jcno8ecghcCeUTQQa5ToAV1zDuEU8QAsVErmHvusN+S1jHp92xG6177j1kyDRy8hBVTlhDVvB2V
	Fzdnokjt/SYqb6D6eE6ZNubx8jQAVdTwlZm6vmnGCSmix17PzRGfULMhzF3aosd821l2mXCoXs9
	YDgTOkU9O5GdYVmuIX+XNcoS4biMBoE7uwSnQbjZRp3Uxx1UVEYVzV29SIMhQQOw9kjLxnqpJlC
	lC/w6aaqYVMRiKbZfncK+u4Q==
X-Received: by 2002:ac8:5acb:0:b0:4ed:bad6:9fa9 with SMTP id d75a77b69052e-506b3f8497emr20065671cf.6.1771035101987;
        Fri, 13 Feb 2026 18:11:41 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdc050esm94582006d6.45.2026.02.13.18.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 18:11:41 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 2/2] libbpf: Delay feature gate check until object prepare time
Date: Fri, 13 Feb 2026 21:10:13 -0500
Message-ID: <20260214021014.15670-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260214021014.15670-1-emil@etsalapatis.com>
References: <20260214021014.15670-1-emil@etsalapatis.com>
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

Avoid this by moving all uses of the FEAT_LDIMM64_FULL_RANGE_OFF feature gate
to BPF object preparation time instead.

Fixes: 728ff167910e ("libbpf: Add gating for arena globals relocation feature")
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

