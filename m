Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A162AD20
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770857114; cv=none; b=o+k/ZY5XHOKf8GueicuwNrN8xHOY8tKZUwyWED+QRMlRWhO8omHctk1a4QfM6uyfwTqoBgGPCLM8mq5bumGEqoGpwHNOr8rnacMnvkfP+Mj3Fy1SiakOsUR3Meij8o/IrxAm3s/GsIZke2XiCOAdAoJG/+w6RVsoWMHll5iRK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770857114; c=relaxed/simple;
	bh=hakJ0Fre4nb2xumqX0qnqlCxypWX1Z5V5IZdCQqLZUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GuePAR5Rkooa0s0eTCwmCSfuG5AvGzGLCyh+f6l/cRJQhWcJjg0ifLYkqp+Up9ajQvwV2RRO8HmTn8KR9v67HFQrPSiNJoUpu2XZYu6+6fslpGTyFBBUEN35V8kQ84etLUqx46i5RlMcbUmeCxR4fhu115/i4NzVUSz5QoyKaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2dgQgRf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2dgQgRf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4834826e555so36027455e9.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 16:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770857111; x=1771461911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9oLOhqxfojIQFydKNrpOK6vbjXkVo+a63OLCAk63CE=;
        b=J2dgQgRfcTD9j0NlhvMyLqqTOPu/SWq5q2SkylCoKzHXWgmW+UhuWwVCbbE7UaWRlC
         0LxGWpAYL/Zl7St81EE4N+fJNrTDYiBrsva5lzrT+J6iHE8ZNuMdTvpDoXf7fU9Ngsip
         vHo69IT+KJlF9wiSiKj7PuccIBZa0Ze9/heH5DJOvZYwJPma3pkz6THsd55GJAHLOze7
         vWSZH0N91KElK6wrm3LrLPAjKuX1QhGDAoSF4lq/OVY/GIXyokOVzuLZ26AWlczuISuF
         rj54iFf6eC9hKTWnINErybuOWkkxoDeiM86tIzrvlpchw21U3vORUkZ92S50Iyf7KWDi
         RGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770857112; x=1771461912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x9oLOhqxfojIQFydKNrpOK6vbjXkVo+a63OLCAk63CE=;
        b=E62k54dpt85JcpOJzHXsmtL4id8oTpXq12BQXAO6rEVpmX0R2es5756+U8iVWDJfUM
         5CD4b7428KBC/qKxE55ExGVCIhNcbLldW9MaXfNBoqGqvRrACKzjvYucz32QqPKCtF3z
         UMy2fO71qpVPGuw7cOf+v+dBvkrY/hgQx/nOezvh2u65m8J4D98IIfkGMWf6Go7cTair
         BbICu1ebOmMgHvdgdjG2vDWgkZDm5OCH9JXr6CdnTle0NOaGScu2p3aKXkodsmdKZCh4
         zmFuADmQt3xGocbs6/6bLEn87IRODFoifMJx545QzangF8qNOqWxbBlRona9p2AhM5G/
         Za9Q==
X-Gm-Message-State: AOJu0Ywc+5pgwMAIakrT9qM5qCOAuYqVvblqy0adY7uFUCgNbrkZgrlk
	dFM/c21y+7npXz+431wRnvJMgZcHMW9Y20LCkJjhA5xoohcP6TWdstlc
X-Gm-Gg: AZuq6aL1gw2y/B5toEhzQLQYYsW/OkO2uWyASKw6hq+tDD6q54AiWLC1jFV3YziOidt
	hTDYugo9Ekr7WR2IXfiPNSCiqxXI4VB8BGCMQRXaq+Lp2KqUmzGFYpFGxCo26/5iSVjAy0XV6vv
	mFaYZzEGGJuv9T9UnB2ZFS8XLEEqUU1RBqccP9OEanfO+xrEaWzHPrWonrboN+KhHsJdc4mqMP9
	1i7CpKvzpTUKpLgHO5gk8zjDRzuqXeKWzmYZufNqD+q4aqtCrcFgey7hS4NPhBrkNATLiCjBILJ
	ZCfMar9Sfwa5dJVkUabrMMWV9JulCDd+NcoLUddJJNuh0znWHsqadxKZxmJCCMHfpNitCmvu+cP
	KU6OJxWZRWcDemqKF2pO8Go3CpcrLApEeLx1HMAVCVEyOsP+qauyTsK9lriXCxgEyqf8LtDhU8F
	5Z9xQmQl9KCydXOT13QOXEX/swuw==
X-Received: by 2002:a05:600c:4694:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-483656c5578mr13443595e9.10.1770857111364;
        Wed, 11 Feb 2026 16:45:11 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d994670sm61467685e9.4.2026.02.11.16.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 16:45:11 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 12 Feb 2026 00:44:37 +0000
Subject: [PATCH bpf-next 2/2] selftests/bpf: Use bpf_prog_clone() in
 veristat
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-veristat_prepare-v1-2-c351023fb0db@meta.com>
References: <20260212-veristat_prepare-v1-0-c351023fb0db@meta.com>
In-Reply-To: <20260212-veristat_prepare-v1-0-c351023fb0db@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770857108; l=7658;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=QE3BcWPt0gUaTYreTSAbzsocBIk90H1rWY1XCI8B498=;
 b=RT6duvfwou415cuWc3mMf2ZePhPf3/S1IanuxLKyiL67NMUAriBcguD7xKoHxfDN0JuDnXpIY
 2xROeYKcwH5CvmmGv8xWTqi8HBFqfd3pgZor0sTEXoHubp6tUzzsgGs
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Replace veristat's per-program object re-opening with bpf_prog_clone().

Previously, veristat opened a separate bpf_object for every program in a
multi-program object file, iterated all programs to enable only the
target one, and then loaded the entire object.

Use bpf_object__prepare() once, then call bpf_prog_clone() for each
program individually. This lets veristat load programs one at a time from
a single prepared object.

The caller now owns the returned fd and closes it after collecting stats.
Remove the special single-program fast path and the per-file early exit
in handle_verif_mode() so all files are always processed.

Split fixup_obj() into fixup_obj_maps() for object-wide map fixups that
must run before bpf_object__prepare(), and fixup_obj() for per-program
fixups (struct_ops masking, freplace type guessing) that run before each
bpf_prog_clone() call.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 104 ++++++++++++++-------------------
 1 file changed, 44 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 1be1e353d40a7b988d84539ec75b7f1666b0bc76..a172957171669d657a394ba04a9f6e9a8ddb22fe 100644
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
+	fd = bpf_prog_clone(prog, &opts);
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
2.53.0

