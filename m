Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147D1862A
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771615101; cv=none; b=DzD1fMsV6uul+u4vWTtE81UzL1x4LuVvW75pWqnTjt2XzO/BvNJVRSsC7CxE17SDtuoUt7bxZn2AJ6Rvn4R6fZ9l1vJ5XiLe2X6r0EvODqc3gVBtKTvbrXGvcPw2YhQEtZUCwYkElKZJ22GAKjgs1eDUiX/nukDMOBbWQViLeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771615101; c=relaxed/simple;
	bh=C1vOiLSrKnU9+xmlRGvJmI/1bCGCaQBHbdTtfVc6e4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4iX5xtDOnqrAlAyvfjs0qcbibnbDEthmbrK/6RRn463cZDszTcuYnFF6adyV0uX3q2A65UmY8By92JxYmdAScpUJCDNIq8YlhYkswAwEVjLCxeHxHwvx3Fiq84NbgXrRVcsANqIKKAM/KCF7bnQU3Ex/m8yAkLZYuuTFwD4Vwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rq7015iq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq7015iq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483770e0b25so24875395e9.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 11:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771615098; x=1772219898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlyCex2d/xQgNUFStbGAJOM5b1o9hCsUV78xyL/PLgw=;
        b=Rq7015iqTOrWtXQFtA714bnmtuLIRWnq6OVxvv3SymIK0LiT3Qkh3/uCA22TAC2j9Z
         vSODooemcHXzO2X5w309C8iFFDOUW9B1+zoOOyIpoPwR1ur/2SAs1ODVdVYsZBKrEOtI
         DohqhNoGYi6IIJa64iWpAaWEmUWTnwx9DuRBqE8zJCEORSp9OGUFIlUHFs78+/z4qnP3
         25Q+E/feoRuMCfm3l7cKJT7S4mQiqwbmmmDTM77UcwRinuvPvP6kWhqzFCN8ritC7tln
         RKtWsckVlDg1ttvErnOsyJmftHJG4Sa1mGBowu2j5V2QeKSsHLPQ8pLUknUBXmTOqZw+
         lquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771615098; x=1772219898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nlyCex2d/xQgNUFStbGAJOM5b1o9hCsUV78xyL/PLgw=;
        b=PXNk1Vaw8i/Jzzvi85+sGMoGVRy+FLVbj7ypO401rYWJZp4Ks73XCcdmPbToyQ81+4
         +vCDsW/K2aIQRLzOyPyeGiulYCg7EY8TKBGl+yq22gaYzW+TgwCcqi8pfj3GGjVXVsqU
         2a/Ul+v3OzCPk/pxhp0l/0GlBKUkB0fdhZkBDBvkTn4BvFNkd8P6AJaRFM425JuIRx80
         ndebkarIkMkrYH9r9uwaQBnse/8lVEe4OqRlyrmLj8DRApcBr+fpirf2vnOeDDN+50G5
         v+kS2gdNNY3lXmgjfLRVVhfy8iPZtIW/mCUFge0TUykEWvWKPkWcnyzcHFXCLfR3WYSb
         YpSg==
X-Gm-Message-State: AOJu0YzytKtkwNxI1J1fO55fSvtkFiAIfk1sLjteq0qtlrNzUYAAL1lt
	lLKkleHALOE2NE+SUlX2RNcsJTAQolF7r5fs1gcqFUBHeN2yLos+hC9n
X-Gm-Gg: AZuq6aL7w0o7uxEOFFvf9J3t1FviRMLOHSuo4qzgJWsK1pSWDQC94FFK3mlHuxqdmlA
	qCVUD8WFUgsHrb7kfl55cgaYg0c4Tb1NklovWM34EeX7L6WlT3JIm4/eRg9kZnW8sbhqvtu1N0U
	R/Jf/HZkBtnEBl5iaiVviIMq0vVduBkHA9Fb7WyG038MoEtEXa7FMZpZX5UdsHncBkP1Xt/EDFG
	bKfxaDc1rgxH7H9cTL2qz8M0kaT6MLP1mEmCttqUuzT2y72xcy82rLFogcVQ+Z2HSNVHiGkVaVv
	a5hxp2QotpdPUvQVYHX55DXJnBWT9PljNlCFK1YM1tcdcqrz2EeDf1wLEG55CNtzv7gdyF2UD7u
	VVHxJvkjklO3uYpHRRTRV4spqyEfOZ0oy2UwDIs3dhMvu9qDJ6ojXBFPRHvTcsuPfnKngm+/vAS
	Pqo75W7oNpmTJvVqtjE3D1Amt0+HI=
X-Received: by 2002:a05:600c:1e09:b0:480:25ae:9993 with SMTP id 5b1f17b1804b1-483a962e3c9mr10777065e9.20.1771615097575;
        Fri, 20 Feb 2026 11:18:17 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31f9af5sm80998205e9.12.2026.02.20.11.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:18:17 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 20 Feb 2026 11:18:05 -0800
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Use bpf_program__clone() in
 veristat
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-veristat_prepare-v2-2-15bff49022a7@meta.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
In-Reply-To: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771615092; l=7619;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=pEPp5uE25nA3S6MrzU4RO+8hL2LQKOW0vLFCqJ5f+Eo=;
 b=lkN1mRbIzeV1G1fJ495riHBszw1IAtK/nmD/QfbMwKCiKSTKLGeZ1/AR20cGTIX9Ix6ewaODJ
 8cvBcMFEHHhAKWxRVVqKuG2s/QaRZRW87SbpjW2y5utzSsvQ3+Wn7Ru
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Replace veristat's per-program object re-opening with
bpf_program__clone().

Previously, veristat opened a separate bpf_object for every program in a
multi-program object file, iterated all programs to enable only the
target one, and then loaded the entire object.

Use bpf_object__prepare() once, then call bpf_program__clone() for each
program individually. This lets veristat load programs one at a time
from a single prepared object.

The caller now owns the returned fd and closes it after collecting stats.
Remove the special single-program fast path and the per-file early exit
in handle_verif_mode() so all files are always processed.

Split fixup_obj() into fixup_obj_maps() for object-wide map fixups that
must run before bpf_object__prepare(), and fixup_obj() for per-program
fixups (struct_ops masking, freplace type guessing) that run before each
bpf_program__clone() call.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 104 ++++++++++++++-------------------
 1 file changed, 44 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 1be1e353d40a..7d7eb56e04d0 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1236,7 +1236,7 @@ static void mask_unrelated_struct_ops_progs(struct bpf_object *obj,
 	}
 }
 
-static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const char *filename)
+static void fixup_obj_maps(struct bpf_object *obj)
 {
 	struct bpf_map *map;
 
@@ -1251,15 +1251,23 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
 		case BPF_MAP_TYPE_INODE_STORAGE:
 		case BPF_MAP_TYPE_CGROUP_STORAGE:
 		case BPF_MAP_TYPE_CGRP_STORAGE:
-			break;
 		case BPF_MAP_TYPE_STRUCT_OPS:
-			mask_unrelated_struct_ops_progs(obj, map, prog);
 			break;
 		default:
 			if (bpf_map__max_entries(map) == 0)
 				bpf_map__set_max_entries(map, 1);
 		}
 	}
+}
+
+static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const char *filename)
+{
+	struct bpf_map *map;
+
+	bpf_object__for_each_map(map, obj) {
+		if (bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS)
+			mask_unrelated_struct_ops_progs(obj, map, prog);
+	}
 
 	/* SEC(freplace) programs can't be loaded with veristat as is,
 	 * but we can try guessing their target program's expected type by
@@ -1608,6 +1616,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	const char *base_filename = basename(strdupa(filename));
 	const char *prog_name = bpf_program__name(prog);
 	long mem_peak_a, mem_peak_b, mem_peak = -1;
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	char *buf;
 	int buf_sz, log_level;
 	struct verif_stats *stats;
@@ -1647,9 +1656,6 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	}
 	verif_log_buf[0] = '\0';
 
-	bpf_program__set_log_buf(prog, buf, buf_sz);
-	bpf_program__set_log_level(prog, log_level);
-
 	/* increase chances of successful BPF object loading */
 	fixup_obj(obj, prog, base_filename);
 
@@ -1658,15 +1664,21 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	if (env.force_reg_invariants)
 		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_REG_INVARIANTS);
 
-	err = bpf_object__prepare(obj);
-	if (!err) {
-		cgroup_err = reset_stat_cgroup();
-		mem_peak_a = cgroup_memory_peak();
-		err = bpf_object__load(obj);
-		mem_peak_b = cgroup_memory_peak();
-		if (!cgroup_err && mem_peak_a >= 0 && mem_peak_b >= 0)
-			mem_peak = mem_peak_b - mem_peak_a;
+	opts.log_buf = buf;
+	opts.log_size = buf_sz;
+	opts.log_level = log_level;
+
+	cgroup_err = reset_stat_cgroup();
+	mem_peak_a = cgroup_memory_peak();
+	fd = bpf_program__clone(prog, &opts);
+	if (fd < 0) {
+		err = fd;
+		fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
 	}
+	mem_peak_b = cgroup_memory_peak();
+	if (!cgroup_err && mem_peak_a >= 0 && mem_peak_b >= 0)
+		mem_peak = mem_peak_b - mem_peak_a;
+
 	env.progs_processed++;
 
 	stats->file_name = strdup(base_filename);
@@ -1678,7 +1690,6 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	stats->stats[MEMORY_PEAK] = mem_peak < 0 ? -1 : mem_peak / (1024 * 1024);
 
 	memset(&info, 0, info_len);
-	fd = bpf_program__fd(prog);
 	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0) {
 		stats->stats[JITED_SIZE] = info.jited_prog_len;
 		if (env.dump_mode & DUMP_JITED)
@@ -1699,7 +1710,8 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 
 	if (verif_log_buf != buf)
 		free(buf);
-
+	if (fd > 0)
+		close(fd);
 	return 0;
 }
 
@@ -2182,8 +2194,8 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 static int process_obj(const char *filename)
 {
 	const char *base_filename = basename(strdupa(filename));
-	struct bpf_object *obj = NULL, *tobj;
-	struct bpf_program *prog, *tprog, *lprog;
+	struct bpf_object *obj = NULL;
+	struct bpf_program *prog;
 	libbpf_print_fn_t old_libbpf_print_fn;
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	int err = 0, prog_cnt = 0;
@@ -2222,51 +2234,26 @@ static int process_obj(const char *filename)
 	env.files_processed++;
 
 	bpf_object__for_each_program(prog, obj) {
+		bpf_program__set_autoload(prog, true);
 		prog_cnt++;
 	}
 
-	if (prog_cnt == 1) {
-		prog = bpf_object__next_program(obj, NULL);
-		bpf_program__set_autoload(prog, true);
-		err = set_global_vars(obj, env.presets, env.npresets);
-		if (err) {
-			fprintf(stderr, "Failed to set global variables %d\n", err);
-			goto cleanup;
-		}
-		process_prog(filename, obj, prog);
+	fixup_obj_maps(obj);
+
+	err = set_global_vars(obj, env.presets, env.npresets);
+	if (err) {
+		fprintf(stderr, "Failed to set global variables %d\n", err);
 		goto cleanup;
 	}
 
-	bpf_object__for_each_program(prog, obj) {
-		const char *prog_name = bpf_program__name(prog);
-
-		tobj = bpf_object__open_file(filename, &opts);
-		if (!tobj) {
-			err = -errno;
-			fprintf(stderr, "Failed to open '%s': %d\n", filename, err);
-			goto cleanup;
-		}
-
-		err = set_global_vars(tobj, env.presets, env.npresets);
-		if (err) {
-			fprintf(stderr, "Failed to set global variables %d\n", err);
-			goto cleanup;
-		}
-
-		lprog = NULL;
-		bpf_object__for_each_program(tprog, tobj) {
-			const char *tprog_name = bpf_program__name(tprog);
-
-			if (strcmp(prog_name, tprog_name) == 0) {
-				bpf_program__set_autoload(tprog, true);
-				lprog = tprog;
-			} else {
-				bpf_program__set_autoload(tprog, false);
-			}
-		}
+	err = bpf_object__prepare(obj);
+	if (err) {
+		fprintf(stderr, "Failed to prepare BPF object for loading %d\n", err);
+		goto cleanup;
+	}
 
-		process_prog(filename, tobj, lprog);
-		bpf_object__close(tobj);
+	bpf_object__for_each_program(prog, obj) {
+		process_prog(filename, obj, prog);
 	}
 
 cleanup:
@@ -3264,17 +3251,14 @@ static int handle_verif_mode(void)
 	create_stat_cgroup();
 	for (i = 0; i < env.filename_cnt; i++) {
 		err = process_obj(env.filenames[i]);
-		if (err) {
+		if (err)
 			fprintf(stderr, "Failed to process '%s': %d\n", env.filenames[i], err);
-			goto out;
-		}
 	}
 
 	qsort(env.prog_stats, env.prog_stat_cnt, sizeof(*env.prog_stats), cmp_prog_stats);
 
 	output_prog_stats();
 
-out:
 	destroy_stat_cgroup();
 	return err;
 }

-- 
2.47.3

