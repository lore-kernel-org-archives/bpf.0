Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6463033D2
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770680937; cv=none; b=tRR4luSYOH09Ru3CZNVfwm6NgBsu/PrwRKlIrdaNihMz0ur2tmoOo5d9E24ePWGGLadOJD/iqEVvLTe0PeRpccDvb38Z2lNGzeV/zHDVf90ypOsqjuHud+s7ivn3kECK4+FAe3QJJUU4syLCSkaO42+suc9KpVwGK3e1Wb70vpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770680937; c=relaxed/simple;
	bh=QePd1Eqc+Sp7MgQVdyqueY5+nEFK+yDl1H+aJCgsDQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/490gDuWWML4ugkkLI8n58qYPipkc5zpYVA08DrkT2FGZaZq2V3ErxsSWa7h6MA0hXt/P0ACk4Zzj8k98FYFt4OVBajvb8vUF6UclUWrA4wS+cZhESHyw8Xc7KVJdHZb7pKe7q9VbvlvBY75SMPtL2UZdDJtDMgBRluzr2ID/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=uOwChjso; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="uOwChjso"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89545bd3324so42528026d6.1
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 15:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770680934; x=1771285734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JNJVWAQ/4CFATDd1H4RYHWv/L1yQYlVKdOyTwjROvwo=;
        b=uOwChjsogr52GQ59snzhtRu90P1AiUQlTRpEvDDl/DeeGtQ0QZELSgbGHVxHLVeQA3
         nYk+dXyodWnlHtNq5yCzwgxoJM5JQxtjhjPVDwlI3GdXdoG0GXnHqa+f8xI7iysd+AND
         qNJ/5tP4HXumNJVUV9c5wM3DTcvaLuVdQsJwv1+9B7K/oJOYleIxwDjvyjFlgjFbBOHx
         sH5n/GC+zN4brG9Cwq5x8vL80FHr5d3UGhd9enNjR1gXx+7aqKI1qmfwLGLgFVhVrHxB
         b4HEbXETpKitXvxiuAUI3oDRatvEVR4KBTm9mlJRJfdx3Eso9wPqp1BNIvS19ZIfQYrK
         ZX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770680934; x=1771285734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNJVWAQ/4CFATDd1H4RYHWv/L1yQYlVKdOyTwjROvwo=;
        b=WmUCGAW+2lTHW3FUS7EYvVwkskOyZxseuFGSCakox99jINJTkqUogyELl0J4tuzJH1
         JG7kUZM7r88clujsdy8h8xZQEZ+T9qCbzFqaK2wGOGnazCdNjd75iLUdOF1uRWpE8bbd
         vfJlOS3pIlCoH+4y7wvNoR2PzX/CS6qv/dVIThkX228ZETr/ub+2XmbnxZEC4xKzYTaq
         1dV30K+7yBNRf3JR5xZKBbBzFbGrx3uCtITv8jd/u5R7b56HMVky0rQ8P6z9d/P2MNVt
         IhK7wiSEWPiZ4TEOB0K0Qj2wl9w6Y79pWUMK0fMn+9SBUfa3pJl6CTpGPLi9+RrUMY56
         +CRA==
X-Gm-Message-State: AOJu0Yy5xChkKP7pDMOlvsb7XyGQcbtzn2WfN2z2PYFeol0R4hrY7tGS
	ROLb1Bq5R+hEvwfj0GPw4v16q1T8PntmjphxFvUspD1VNqTkE1GBsjCOUPZhvrDatXeIQd5Xhz5
	t/zNkCWQ=
X-Gm-Gg: AZuq6aKKgRzPj1I9pd4dxr498hIJ6Z+waj94HBShvj1YilvK6+pdRNWIZXRDuXh5We5
	CNYAOGtPFe88HxkRljKKcNgOR8VlRF8VT+7gP+ESsyPdjsIT4o4FKaKeoa3k5eoDmDBW44NJT2R
	VUWLPJtIXm8I6xyxjY475DDN9ZIpD96Cq0LnNkp6ZR5Yci68GjQHqFHLSVTSANQr08asKsmK+qa
	lZ3p0e5UwzvY94KkJZyoiGKqTNUd8xBX+mMSzpkikJhdPYaySAxjheVS1KYf95QHqXIVxiTiffD
	cXxWzeF/vACHJLvUeKl+vzT67fFrCaRhLtUEe1bhSpbwzb1xBUa8NRJhsi0bmFONQxX/MtdCb+c
	u10V88NFHu5K8EujAbVX/dBUhQNyulUDGW+/7mOPJ3Re0tTY50SXMM1n/anQi48Qa4LqauBDCBJ
	Z2XDj8a7WavdFq63426kW09A==
X-Received: by 2002:a05:6214:21a8:b0:895:7864:f69b with SMTP id 6a1803df08f44-8957864f8a4mr126103556d6.64.1770680934100;
        Mon, 09 Feb 2026 15:48:54 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-896f79d34bcsm45172916d6.0.2026.02.09.15.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 15:48:53 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2] libbpf: Add gating for arena globals relocation feature
Date: Mon,  9 Feb 2026 18:48:50 -0500
Message-ID: <20260209234850.2750149-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add feature gating for the arena globals relocation introduced in
commit c1f61171d44b. The commit depends on a previous commit in the
same patchset that is absent from older kernels (12a1fe6e12db,
"bpf/verifier: Do not limit maximum direct offset into arena map").
Without this commit, arena globals relocation with arenas >= 512MiB
fails to load and breaks libbpf's backwards compatibility.

Introduce a libbpf feature to check whether the running kernel includes
patch 12a1fe6e12db, and only relocate arena globals if it does.

CHANGELOG
---------

v1 -> v2 (https://lore.kernel.org/bpf/20260209210240.2051209-1-emil@etsalapatis.com/)

- Reworked test to use simpler array-based program (Andrii)

Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the arena")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/features.c        | 92 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          |  7 ++-
 tools/lib/bpf/libbpf_internal.h |  2 +
 3 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b842b83e2480..b1a088dd83ac 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -506,6 +506,95 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+static int probe_kern_arena_global_reloc(int token_fd)
+{
+	const size_t bufsz = 1024;
+	int btf_fd, prog_fd, map;
+	char log_buf[bufsz];
+	int ret;
+	static const char strs[] = "\0f\0";
+	const __u32 types[] = {
+		/* [1] FUNC_PROTO `void(void)` */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 0), 0),
+		/* [2] FUNC 'f' -> FUNC_PROTO (main prog) */
+		BTF_TYPE_ENC(1 /* "f" */, BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 1),
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
+		.token_fd = token_fd,
+		.prog_flags = BPF_F_SLEEPABLE | (token_fd ? BPF_F_TOKEN_FD : 0),
+		.log_buf = log_buf,
+		.log_size = bufsz,
+	);
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1UL << 30),
+		BPF_EXIT_INSN(),
+	};
+	const struct bpf_func_info_min func_infos[] = {
+		{ 0, 2 }, /* main prog -> FUNC 'f' */
+	};
+	int insn_cnt = ARRAY_SIZE(insns);
+
+	btf_fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs), token_fd);
+	if (btf_fd < 0)
+		return 0; /* BTF not supported at all */
+
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int), 1, 1, &map_opts);
+	if (map < 0) {
+		ret = -errno;
+		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
+			__func__, errstr(ret));
+		close(btf_fd);
+		return ret;
+	}
+	insns[0].imm = map;
+
+	prog_opts.prog_btf_fd = btf_fd;
+	prog_opts.func_info = &func_infos;
+	prog_opts.func_info_cnt = ARRAY_SIZE(func_infos);
+	prog_opts.func_info_rec_size = sizeof(func_infos[0]);
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SYSCALL, "global_reloc", "GPL", insns, insn_cnt, &prog_opts);
+
+	ret = -errno;
+	close(map);
+	close(btf_fd);
+
+	if (prog_fd >= 0) {
+		pr_warn("Error in %s(): Program loading unexpectedly succeeded.\n",
+			__func__);
+		close(prog_fd);
+		return -EINVAL;
+	}
+
+	/* Be conservative and NULL terminate the buffer to ensure strstr terminates. */
+	log_buf[bufsz - 1] = '\0';
+
+	/*
+	 * Feature is allowed if we're not failing with the error message "direct value
+	 * offset of %u is not allowed that was removed in 12a1fe6e12db
+	 * ("bpf/verifier: Do not limit maximum direct offset into arena map").
+	 * Instead, we should be failing with the message "invalid access to map value
+	 * pointer". Ensure we match with one of the two and we're not failing with a
+	 * different, unexpected message.
+	 */
+	if (strstr(log_buf, "direct value offset of"))
+		return 0;
+
+	if (strstr(log_buf, "invalid access to map value pointer") == NULL) {
+		pr_warn("Error in %s(): Program unexpectedly failed with message: %s.\n",
+			__func__, log_buf);
+		return ret;
+	}
+
+	/* Feature is on. */
+
+	return 1;
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -581,6 +670,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_QMARK_DATASEC] = {
 		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
 	},
+	[FEAT_ARENA_GLOBAL_RELOC] = {
+		"Relocatable arena globals support", probe_kern_arena_global_reloc,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce4..0aeb740a5f47 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3009,8 +3009,11 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	memcpy(obj->arena_data, data, data_sz);
 	obj->arena_data_sz = data_sz;
 
-	/* place globals at the end of the arena */
-	obj->arena_data_off = mmap_sz - data_alloc_sz;
+	/* place globals at the end of the arena (if supported) */
+	if (kernel_supports(obj, FEAT_ARENA_GLOBAL_RELOC))
+		obj->arena_data_off = mmap_sz - data_alloc_sz;
+	else
+		obj->arena_data_off = 0;
 
 	/* make bpf_map__init_value() work for ARENA maps */
 	map->mmaped = obj->arena_data;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fc59b21b51b5..e0223a6e4c95 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -392,6 +392,8 @@ enum kern_feature_id {
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
 	FEAT_BTF_QMARK_DATASEC,
+	/* Kernel supports relocating arena globals to end of the arena */
+	FEAT_ARENA_GLOBAL_RELOC,
 	__FEAT_CNT,
 };
 
-- 
2.49.0

