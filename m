Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF52379EDC
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769186; cv=none; b=FzDB8LPRfmFT3SQvOJjvaHZCoyy5Dv+YCc1YffCqZfyn6ERGO/lKU73WzRSLhKlb4CZfgm9e+6pFlYPCP7dYNVO7hSOqrj7aHvjCNSq0HnSl6BLgy6tpukV3EnZ3bj1vtdlmJJO9f2BAyFldLuH4WXC+5Yf5wFpSXsv00AFNgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769186; c=relaxed/simple;
	bh=rRw3K0QQfP2YqqtgFRUVVn+DfWNLu48+gZy2n5QeF14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6r0C3plkag01JW16whEeAwjEas8Bc9v6ZoSyjXhT2cafCd8D5KgQXGB/hsK6wTvFEMqOXKZGELKx2GcUvLbSjSwzbr2UMwQmFsP/NGK9vQ8pmimpbr2Iv9iqzK1sOdYayq+a70chyQBZUO+UTpChPdf2zHUxiIGjzax9o1otzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1JleoZD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1JleoZD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so54751345e9.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773769183; x=1774373983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mt/SIRGviY88PEOY5TUusa/n0r6OV3a2afVBarHXJqQ=;
        b=e1JleoZDVPz8dgcyo+3NYgkrlumWAxl55wjhW+ntEhX38+sYOussMCytorRacYge56
         O78Kdo45ia/H69sQJ93pY7IRkEN0xnpIHOq4sEVJLtCVXOgAkdjHyzkGDqo0kIw3LAbd
         U0JEmjxn/UveDZo6sq5bdFGeaQgo923zMMsU7Vr3qXdq3u830YqOvzkTuhXzfVoU/0oZ
         8MFDVtlJWGq99rdlc/GDfIX0QA3NJDFYS/MvsepeBQ4g1nlT/AAUGiCFrFUXaJ98TyQD
         jskIkUzy2MGL6JmYUOhhthtujmJhgW+1wgv9wrjNG3YWzwWRt7bAhma9L3f9Ejiu7ku7
         qlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773769183; x=1774373983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mt/SIRGviY88PEOY5TUusa/n0r6OV3a2afVBarHXJqQ=;
        b=HNWoG8lcbRY4RcOJCw8zOmb5K4WoBpih9viQGvKGIA1b66VMmRpZVymLHIuVmqtvWN
         /bOEiIJR8TzGP9Cmo7KmBDyCtaGNeOq881KA/xM88I2u5Swx1IONIIAHNI7+k3uVADlj
         /6c91OVeMfA4AOPb76pf2t7I70hKNoFRjOgdesgQCqd6Uv05ti9+Ufw51+l2mBS8rwyO
         Pl0+8lcTgEepnMMQ82b7VJnyDlL1HT1wmx0EsLDt4wFAwrCXbONd354RRvwIE0Qoqvr/
         LEpUq+KzbBUbpMTSYNtjwUJ33RyhgvB4Hw6e2NytndedAxMvJ9hwZqqnJD211tuTHlh4
         cfcg==
X-Gm-Message-State: AOJu0YxAfKSOAVY0PPvq1DiGwr3ge3abU9zDMDF47wD7MSvcI9PF+rH9
	mKWCtTxGNj1Crnxgg6LGi6IOjDi/XLQ+cVXO2J9BRlrZpAQ0ElRIrIuo
X-Gm-Gg: ATEYQzzhQY1GrxrmNiu6IZVPW8/2mOcd8YTPpRbMYqFYF2+84fk3st8R5gD+hfOK6EN
	ofGcR29G5Bxp1s0wgmhrgHl+qVQ6BaGr0GTcqilfdChVdeh3wAMdw0JrYcGyNXGVszWd1rXpqfY
	vd/f2wgkcc7ILNw3FjpWvlg81PoXUR2kdTNjHOGaevb/GJBKdchWJZTyeqlitJcOAO2YFbGRaJ1
	EKpmOIX/nb9/NGdXXBsaxHnZn16cR/3ya8wpzFN2Ic5K9IHuyB69ET0UxI2PTM2bHeEq5skCOMW
	YOjtUpAvJeif3KM7pyqgmXY/e7Vb6iaqOTQcX1JFmUbeMWmsafGGHiA0rtnIWv4INon3AFY6kpC
	RhL4WR0qBB9bisrdILiPBZMDCqGLJYiStouVZVe/BSdPIiIwqDoS5+dPSfMXSYqCRooII8R2Uyk
	kdt39/pe1czRFi
X-Received: by 2002:a05:600c:4e56:b0:485:3dfc:569 with SMTP id 5b1f17b1804b1-486f4441067mr6318225e9.16.1773769183227;
        Tue, 17 Mar 2026 10:39:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f421a6f2sm5537065e9.8.2026.03.17.10.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:39:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 17 Mar 2026 10:39:22 -0700
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: Use bpf_program__clone() in
 veristat
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-veristat_prepare-v4-2-74193d4cc9d9@meta.com>
References: <20260317-veristat_prepare-v4-0-74193d4cc9d9@meta.com>
In-Reply-To: <20260317-veristat_prepare-v4-0-74193d4cc9d9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773769179; l=7710;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=7Eln1RimmWzXkmItILioke/E+QAHVVv+loV7BmHzb/Y=;
 b=PXJ8aWiNpiwsSIG1okgU3LyctXs85GJpGKgM7ZXh8Y00ZSGptmDjfIHoLzVYEmZKns9eOkZ/4
 /WHQCFkTGmVC57vNE7Z5Y4NwITKVHrJvmMBsJv/Y7jiP1+uldUijQbE
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 102 ++++++++++++++-------------------
 1 file changed, 42 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 75f85e0362f5..9652649171ce 100644
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
@@ -2222,51 +2234,24 @@ static int process_obj(const char *filename)
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
+	if (err) /* run process_prog() anyway to output per program failures */
+		fprintf(stderr, "Failed to prepare BPF object for loading %d\n", err);
 
-		process_prog(filename, tobj, lprog);
-		bpf_object__close(tobj);
+	bpf_object__for_each_program(prog, obj) {
+		process_prog(filename, obj, prog);
 	}
 
 cleanup:
@@ -3264,17 +3249,14 @@ static int handle_verif_mode(void)
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
2.52.0

