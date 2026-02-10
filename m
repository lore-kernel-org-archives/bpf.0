Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80923EBF1D
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749138; cv=none; b=ei6rICnr3+W6L4HW3DatwhWxV9UgxP/w7YLwz/aTCUFNtvuZ2fY8ergjjSNQhf0XgMhVzXlvsXtT00hGnYi3aZypmqB78Ty3FEB0uhy8P1wl0MpOL1mmoif0umhbNU+JjViRhI/VfQimnr4IFtfXvGZwndPU2Kn0NDB8AWiKHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749138; c=relaxed/simple;
	bh=GyKwzNMJijwe0Q0+DhRjpCR9xVJqqY3DYY6X73HRdk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBObiR40Rx+pda+6AKtXfNogKTK/k+/UnWwCHjZZXtCSASq5HCpvx8pIv1vd31EqKK1KDNf32DacOO+ZZoTFcPV4L7q2hxeQbsZhCMSWhQb0MnBN/Fr863S/4uXbP/qsMsPetCiJ+KhQo1bspjbEd4EBLK2uYbQIKqfajVgIgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=RMBVp41z; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="RMBVp41z"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6a50c17fdso450396485a.2
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770749136; x=1771353936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vApVvvYxkpSt/fRCmVg4D4q1J/ls2d30gn4COcKIaLM=;
        b=RMBVp41zpkIbvFatFBI8aw9o/Dxia2fJKt0eu3GzFb0rN4CXJiOUuG4/X0R58ZVgew
         U2kzjO27/Ldp00T3O1+oshH2phVoxhzplNXvWUI75pZ+p4+UR6aplBFq96jS4/c4pkt1
         19RAzCAYiVflAhC6Us44+rZNIu/NzhHmYR0eMsXvyVHb0hKH4tBfk0v0fIViLf4fp4XK
         azxrZsknm6Raks0FbGUDSIEJM0ItTl6082UJpEXFQZQLMzSfPy4sTJaNxq4PGiwkgJG1
         IqbGIgi5+8ulcAPBVHUwTJx1Dw/A2mYD2U6UVkFEzaCnLfpNNgi60sELnoskUjP1d6sW
         iSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770749136; x=1771353936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vApVvvYxkpSt/fRCmVg4D4q1J/ls2d30gn4COcKIaLM=;
        b=PvYSUv+vNAPn+KbQFJ7JA4h2zOB6nJOvFQffnZA42tZ6WyHjFyeaZrRUUi00POFMYc
         UbA+VVnLDQV190YgTPe3z3vOq/VCCyGOsXYzdetrvo3C06wDNrL9aFlVkO++QPIcfOTS
         uK4oktvkBvavH33fWOVDaSfXva12ACPgIyyw+B/e5uhGyAaU5JuF0pH9k52MA+L/rPkI
         bLF6lz5FnHEIdwT2BoM20kRRPBkf5Om89voxbTOijhyDLIUxB/Xt9Mqq1YRrLNJQVxCG
         FrejKlvkmYffHH9LhlSk7FoP0f3xcXIlXFnprDjp/kV1ELJ68YdqyncN/8UZv//KAPps
         udVQ==
X-Gm-Message-State: AOJu0YyZNJK+ExUoyx5yPQD60S9Y0PxcIZLbxzQRNfccsb70gD59uBgj
	Q2hSDQ5cFMO+PmD3SmN8+2SKPAJH6d2PEUxX74bsmmM8OpTRjIPM2JKf5hAoJawm0Xk+QQ54VYa
	Nff6w
X-Gm-Gg: AZuq6aLkX5cnacDcZSfhRXWTcsOrgiQals4DOIUYlBtcR/fsShPFLcbkkvI4EkZSzLk
	iJEtTlAH/X/iV18kzlu/1bmoEJk3yq1gQap3ivP1KeJavHOe0rtuDRGdqS7JXDR2zm9jLaDBSfk
	IXMaCMGSanuMSadTtqY91Z0s8+dIJonIAPx4M1kAPTdaUMus+36T5wxx203YKYqfgecCajleDxu
	1zzmkIR4hlT2VRdn1DG9BnNOcLpvqtEu91huBPSZ6SOZfY8s1HLw3+dwwy3suzJ2b2l5x1HfPwn
	6QhyW1IcIjVkSeH1h1h89WS8ZCN/UCmkHJzPzZAMKQ1p2sZtMxUDelNog3zdIM/59wa3zHbpm8A
	WvIelD4g2NLb5S0ntTUvmYsNN74GM52w1z528kU3msZxYcYvwE/hkL/yhtT56aZkGeNpsP2RH5K
	Aea9zWrp0oaXepQG6mRiU+Rg==
X-Received: by 2002:a05:620a:2943:b0:8c5:c99d:b2c with SMTP id af79cd13be357-8cb27fb7a29mr34724885a.34.1770749135624;
        Tue, 10 Feb 2026 10:45:35 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c057751sm104853076d6.43.2026.02.10.10.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 10:45:35 -0800 (PST)
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
Subject: [PATCH bpf-next v4] libbpf: Add gating for arena globals relocation feature
Date: Tue, 10 Feb 2026 13:45:32 -0500
Message-ID: <20260210184532.255475-1-emil@etsalapatis.com>
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

v3 -> v4 (https://lore.kernel.org/bpf/20260210005508.3642641-1-emil@etsalapatis.com/)

Incorporate feedback from Andrii:
	- Remove BTF and func_info
	- Use TRACEPOINT instead of SYSCALL to avoid using the SLEEPABLE flag
	- Improve string handling sizeof(log_buf) for libbpf buffer

v2 -> v3 (https://lore.kernel.org/bpf/20260209234850.2750149-1-emil@etsalapatis.com/)

- Rename feature to better specify the verifier feature it probes for
  (Andrii)

v1 -> v2 (https://lore.kernel.org/bpf/20260209210240.2051209-1-emil@etsalapatis.com/)

- Reworked test to use simpler array-based program (Andrii)

Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the arena")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/features.c        | 65 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          |  7 +++-
 tools/lib/bpf/libbpf_internal.h |  2 +
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b842b83e2480..9689e408ac58 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -506,6 +506,68 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+static int probe_ldimm64_full_range_off(int token_fd)
+{
+	char log_buf[1024];
+	int prog_fd, map_fd;
+	int ret;
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+		.log_buf = log_buf,
+		.log_size = sizeof(log_buf),
+	);
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1UL << 30),
+		BPF_EXIT_INSN(),
+	};
+	int insn_cnt = ARRAY_SIZE(insns);
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int), 1, 1, &map_opts);
+	if (map_fd < 0) {
+		ret = -errno;
+		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
+			__func__, errstr(ret));
+		return ret;
+	}
+	insns[0].imm = map_fd;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, "global_reloc", "GPL", insns, insn_cnt, &prog_opts);
+	ret = -errno;
+
+	close(map_fd);
+	close(prog_fd);
+
+	if (prog_fd >= 0) {
+		pr_warn("Error in %s(): Program loading unexpectedly succeeded.\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	/*
+	 * Feature is allowed if we're not failing with the error message
+	 * "direct value offset of %u is not allowed" removed in 12a1fe6e12db
+	 * ("bpf/verifier: Do not limit maximum direct offset into arena map").
+	 * We should instead fail with "invalid access to map value pointer".
+	 * Ensure we match with one of the two and we're not failing with a
+	 * different, unexpected message.
+	 */
+	if (strstr(log_buf, "direct value offset of"))
+		return 0;
+
+	if (!strstr(log_buf, "invalid access to map value pointer")) {
+		pr_warn("Error in %s(): Program unexpectedly failed with message: %s.\n",
+			__func__, log_buf);
+		return ret;
+	}
+
+	return 1;
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -581,6 +643,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_QMARK_DATASEC] = {
 		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
 	},
+	[FEAT_LDIMM64_FULL_RANGE_OFF] = {
+		"Full range LDIMM64 support", probe_ldimm64_full_range_off,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce4..93e59ed8d9a1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3009,8 +3009,11 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	memcpy(obj->arena_data, data, data_sz);
 	obj->arena_data_sz = data_sz;
 
-	/* place globals at the end of the arena */
-	obj->arena_data_off = mmap_sz - data_alloc_sz;
+	/* place globals at the end of the arena (if supported) */
+	if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
+		obj->arena_data_off = mmap_sz - data_alloc_sz;
+	else
+		obj->arena_data_off = 0;
 
 	/* make bpf_map__init_value() work for ARENA maps */
 	map->mmaped = obj->arena_data;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fc59b21b51b5..974147e8a8aa 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -392,6 +392,8 @@ enum kern_feature_id {
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
 	FEAT_BTF_QMARK_DATASEC,
+	/* Kernel supports LDIMM64 imm offsets past 512 MiB. */
+	FEAT_LDIMM64_FULL_RANGE_OFF,
 	__FEAT_CNT,
 };
 
-- 
2.49.0

