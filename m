Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344512E3FE
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 05:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103477; cv=none; b=PSnLPl1pVpRqc2tEsj9GiaYCiHDHcrAXFpuB/wQSz6BHUUlJFl5koizwgplvKhmKGea1pj35lpB55t+ghvbTxpVecPNNhhYaJddG60mpdhuYYQfCv8t6RRnNsnciCY4QXvy/3c047bOn1d6bjxYK0uOVCeEIlD7ThilebQ0YGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103477; c=relaxed/simple;
	bh=mE9nXy1EsWAQiVaelKvMXVfBjfHm/6o41fkRcHQE2us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1p/Mn+O1Ipg2OCRdEzX/N31OFlnRShgvnRb2zZNREYAsxhd79SR6Kv1Nh769Iep4ccp66oduUrGD0k6WOh40bK07lPsI6c0DOy8i9gmrpU5M5Dl17mVMjWPpTpDmhcYrGwtN6a794FVcWmqjxEe54H4/lbTKDYe1AFQisSNeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqfdaYzT; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqfdaYzT"
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2d313798bf8so2202745ad.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 22:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789103474; x=1789708274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yV/3JlFuKZZU7SYL3yycxNgwI867G9app2RTXTp4BZk=;
        b=fqfdaYzT3OnQSCXARnz7TMqg21hU15tWYtI/YasSwLv8ObMP1jJycdDHBJBlUHdc7x
         qPJoHS/ab9MTS6RA9z+ZK2dZ6sOAJoce1O4Sw1IV/z4tgpviVvhco+R9kghJplfHt0Kd
         lW5R0RayN0tdFt9ahQK3Iw7q6tqQFZ2XGDZ3c2nUI5DW/lXIZYG1OnibJgX2ZsuNLbsZ
         Rd88D9K2Xa8cI+emW3lt6gCGXqLbx5JBbML+sll/QA65YVwZkfIUh6kev3Ql4nX0hm4E
         sGewH/IYn2sPYFqQBSBDL6bV6Je4dUUB4UCFGMW9x3SaODjy9TFxCfbB4tNTr3wHlF6P
         XC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103474; x=1789708274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yV/3JlFuKZZU7SYL3yycxNgwI867G9app2RTXTp4BZk=;
        b=BAehowucpLAU2Um1uVUI6UT4uYhmB5403Im/3FgHoMcl8QCPjMDePTLIINHkJHJDaG
         kT225zm8EBUwDpIWz9MeIfIA7reJD0ZXhDDyNZMLpuS+P5hEK0dMVoHD2UNSFWOQBNrb
         S7iORIS4FcJFsKGiY1NJFqTrJeea6aGugwjuhSfmG/px5GXlIhr1AoFXovFrmDn5Kssw
         PGEh2v+6qZFcHkGhGCfxvbA6SqTwLq2ls+g2TZXSejPKnByBXS9ewdlcu5ycGPtuhgxz
         Chf0+4SGyJhdEdl1Rfedswb9EpXywWdP2HZRvUW1FU5iYKSMVb0n2glujUvSQtH80VXF
         4xjA==
X-Forwarded-Encrypted: i=1; AKwUvByqHZjm926FeubrcGSIAOJO9RhI0hRt+3Z8EdZX1elZK0iqioe8zrq377yLYR0vZWksK14=@vger.kernel.org
X-Gm-Message-State: AFuF++mLA87HYqzVKhJj+UTrPZNlaYnxKxd99TuVhqiSbUzpcOIFki47
	hpjVipcdRMMm+AyG4W01aSdfzLPY7aS3FbBQEf8TlCZpLQCKJiSMOINc
X-Gm-Gg: AYBFou0BjQ1B9u2xxxrMwa7YaTxy0YPppvoXFs4NkVWCNzFzOPLr4a69oIDexB69xNZ
	mc0VbMFBvddfo+dmCjplsblrcDu3x3y4oUCqjJBofWpwIEz3OdUjvcD8nZ7P0sYK6L7vt8+GEjQ
	Ako+WWn4+c16KfjM5EuKnjIsqZvM0jSw8vav2Ao+0WZ+KksiXdou8Z/wjoKDpD0LT4o9v3nFBmt
	/X3PVbZyaa5ppC4WOq49p6Dk8rRnOD9LYtFC8yvHiyzzzsag8ar/6xhBvww+2wnm2KTIiLI4hWw
	+PUljci/kURDkZWmL4AjS30DkaSARSCbzTYat/Oa4rBpO83HscIUWHnzRMP7q65rwXrLBM3swJ9
	9CvKCDEsjObfcoFI8NpZAomdefdUnFMRmOWrwmDuC/y1TopjpmxwNNx5m9UuPvjdWaqMa7uGfsd
	3usoGI19Oq4yU5TtiXJaLl/e+LZSEIZcwbQ3T92R6X
X-Received: by 2002:a05:6a21:6f88:b0:3da:755f:a031 with SMTP id adf61e73a8af0-3daed20b238mr4672782637.12.1789103474191;
        Thu, 10 Sep 2026 22:11:14 -0700 (PDT)
Received: from fedora ([2602:f921:f20:17::a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e5182fsm3018993eec.9.2026.09.10.22.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 22:11:13 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v6 1/2] bpftool: Add recursive map dumping
Date: Fri, 11 Sep 2026 13:10:52 +0800
Message-ID: <20260911051053.283421-2-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911051053.283421-1-diannaaav@gmail.com>
References: <20260911051053.283421-1-diannaaav@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyi Chen <hi@tychen.cc>

Dumping a map-of-maps currently shows inner map IDs without their
contents. Add -r/--recursive to dump referenced inner maps as well,
leaving the default output unchanged. Show the selected maps followed
by distinct discovered inner maps, preserving plain and BTF formatting
and using an array of map objects for JSON output.

Holding every discovered inner-map FD open would make descriptor use
grow with the number of maps and could exhaust RLIMIT_NOFILE. Keep the
selected map FDs open, queue distinct inner map IDs, and open, dump and
close each queued map in turn. This needs only one additional map FD.
The tradeoff is deferred ID resolution: concurrently removed inner
maps can disappear before they are opened, so the dump is not atomic.

Report failure when an inner map cannot be opened, retain per-entry
lookup errors, and close JSON containers before returning.

Link: https://github.com/libbpf/bpftool/issues/58
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/bpftool/Documentation/bpftool-map.rst |  22 ++-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/main.c                      |   7 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/map.c                       | 130 ++++++++++++++++--
 5 files changed, 151 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 5daf3de5c74..23faa672685 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -16,7 +16,8 @@ SYNOPSIS
 
 **bpftool** [*OPTIONS*] **map** *COMMAND*
 
-*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } }
+*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } |
+{ **-n** | **--nomount** } | { **-r** | **--recursive** } }
 
 *COMMANDS* :=
 { **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
@@ -170,6 +171,25 @@ OPTIONS
     Do not automatically attempt to mount any virtual file system (such as
     tracefs or BPF virtual file system) when necessary.
 
+-r, --recursive
+    Also dump the inner maps referenced by **array_of_maps** and **hash_of_maps**
+    entries when running **map dump**. Each map ID is visited once, even if
+    several entries refer to it. Selected maps are followed by their inner maps.
+
+    Plain output includes a header identifying each map. On success, JSON output
+    is always an array of map objects, each containing an **id** and an
+    **elements** array, including when only one map is dumped. Outer map entries
+    retain their **inner_map_id** field, which identifies the corresponding inner
+    map object.
+
+    Inner map IDs are resolved when the maps are visited. The dump is not an
+    atomic snapshot: concurrent updates can change map contents or remove a
+    referenced inner map before it is visited. Failure to open a referenced
+    inner map stops the dump and returns a nonzero exit status. Output may
+    contain maps or entries printed before the error.
+
+    In JSON mode, the enclosing arrays and objects are closed before returning.
+
 EXAMPLES
 ========
 **# bpftool map show**
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 75cbcb512eb..45c336d63be 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -261,7 +261,7 @@ _bpftool()
 
     # Deal with options
     if [[ ${words[cword]} == -* ]]; then
-        local c='--version --json --pretty --bpffs --mapcompat --debug \
+        local c='--version --json --pretty --recursive --bpffs --mapcompat --debug \
             --use-loader --base-btf --sign -i -k'
         COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
         return 0
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 5ababd8f7d0..c0f4df10102 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -26,6 +26,7 @@ static int (*last_do_help)(int argc, char **argv);
 json_writer_t *json_wtr;
 bool pretty_output;
 bool json_output;
+bool recursive_dump;
 bool show_pinned;
 bool block_mount;
 bool verifier_logs;
@@ -456,6 +457,7 @@ int main(int argc, char **argv)
 		{ "json",	no_argument,	NULL,	'j' },
 		{ "help",	no_argument,	NULL,	'h' },
 		{ "pretty",	no_argument,	NULL,	'p' },
+		{ "recursive",	no_argument,	NULL,	'r' },
 		{ "version",	no_argument,	NULL,	'V' },
 		{ "bpffs",	no_argument,	NULL,	'f' },
 		{ "mapcompat",	no_argument,	NULL,	'm' },
@@ -479,7 +481,7 @@ int main(int argc, char **argv)
 	bin_name = "bpftool";
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
+	while ((opt = getopt_long(argc, argv, "VhpjrfLmndSi:k:B:l",
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -501,6 +503,9 @@ int main(int argc, char **argv)
 			}
 			jsonw_pretty(json_wtr, pretty_output);
 			break;
+		case 'r':
+			recursive_dump = true;
+			break;
 		case 'f':
 			show_pinned = true;
 			break;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 9315a1db1f7..43ef0aa592d 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -83,6 +83,7 @@ extern const char *bin_name;
 
 extern json_writer_t *json_wtr;
 extern bool json_output;
+extern bool recursive_dump;
 extern bool show_pinned;
 extern bool show_pids;
 extern bool block_mount;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 684a8fb7241..a23a5f55f65 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -17,6 +17,7 @@
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/hashmap.h>
+#include <bpf/libbpf_internal.h>
 
 #include "json_writer.h"
 #include "main.h"
@@ -826,12 +827,43 @@ static void free_map_kv_btf(struct btf *btf)
 		btf__free(btf);
 }
 
+struct map_dump_ctx {
+	struct hashmap *seen;
+	__u32 *pending_ids;
+	size_t pending_cnt;
+	size_t pending_cap;
+};
+
+static int collect_inner_map(struct map_dump_ctx *ctx, __u32 id)
+{
+	int err;
+
+	if (hashmap__find(ctx->seen, id, NULL))
+		return 0;
+
+	err = libbpf_ensure_mem((void **)&ctx->pending_ids, &ctx->pending_cap,
+				 sizeof(*ctx->pending_ids), ctx->pending_cnt + 1);
+	if (err) {
+		p_err("mem alloc failed");
+		return -1;
+	}
+
+	err = hashmap__add(ctx->seen, id, 0);
+	if (err) {
+		p_err("failed to record inner map id %u: %s", id, strerror(-err));
+		return -1;
+	}
+	ctx->pending_ids[ctx->pending_cnt++] = id;
+	return 0;
+}
+
 static int
 map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
-	 bool show_header)
+	 bool show_header, struct map_dump_ctx *ctx)
 {
 	void *key, *value, *prev_key;
 	unsigned int num_elems = 0;
+	json_writer_t *plain_btf_wtr = NULL;
 	struct btf *btf = NULL;
 	int err;
 
@@ -845,6 +877,17 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 
 	prev_key = NULL;
 
+	if (ctx && !wtr && (info->btf_value_type_id ||
+			    info->btf_vmlinux_value_type_id)) {
+		plain_btf_wtr = get_btf_writer();
+		if (plain_btf_wtr) {
+			if (show_header)
+				show_map_header_plain(info);
+			show_header = false;
+			wtr = plain_btf_wtr;
+		}
+	}
+
 	if (wtr) {
 		err = get_map_kv_btf(info, &btf);
 		if (err) {
@@ -874,10 +917,20 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		if (err) {
 			if (errno == ENOENT)
 				err = 0;
+			else if (ctx)
+				p_err("can't get next key for map id %u: %s",
+				      info->id, strerror(errno));
 			break;
 		}
-		if (!dump_map_elem(fd, key, value, info, btf, wtr))
+		err = dump_map_elem(fd, key, value, info, btf, wtr);
+		if (!err) {
 			num_elems++;
+			if (ctx && map_is_map_of_maps(info->type)) {
+				err = collect_inner_map(ctx, *(__u32 *)value);
+				if (err)
+					break;
+			}
+		}
 		prev_key = key;
 	}
 
@@ -894,18 +947,25 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	free(key);
 	free(value);
 	free_map_kv_btf(btf);
+	if (plain_btf_wtr)
+		jsonw_destroy(&plain_btf_wtr);
 
 	return err;
 }
 
 static int do_dump(int argc, char **argv)
 {
+	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts,
+		    .open_flags = BPF_F_RDONLY,
+	);
 	json_writer_t *wtr = NULL, *btf_wtr = NULL;
 	struct bpf_map_info info = {};
+	struct map_dump_ctx ctx = {};
 	int nb_fds, i = 0;
 	__u32 len = sizeof(info);
 	int *fds = NULL;
 	int err = -1;
+	size_t j;
 
 	if (argc != 2)
 		usage();
@@ -919,9 +979,35 @@ static int do_dump(int argc, char **argv)
 	if (nb_fds < 1)
 		goto exit_free;
 
+	if (recursive_dump) {
+		ctx.seen = hashmap__new(hash_fn_for_key_as_id,
+					equal_fn_for_key_as_id, NULL);
+		if (IS_ERR(ctx.seen)) {
+			ctx.seen = NULL;
+			p_err("failed to create hashmap for recursive dump");
+			goto exit_close;
+		}
+		/* Record the selected maps before discovering any inner maps. */
+		for (i = 0; i < nb_fds; i++) {
+			len = sizeof(info);
+			if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
+				p_err("can't get map info: %s", strerror(errno));
+				err = -1;
+				goto exit_close;
+			}
+			err = hashmap__add(ctx.seen, info.id, 0);
+			if (err) {
+				p_err("failed to record map id %u: %s", info.id,
+				      strerror(-err));
+				err = -1;
+				goto exit_close;
+			}
+		}
+	}
+
 	if (json_output) {
 		wtr = json_wtr;
-	} else {
+	} else if (!recursive_dump) {
 		int do_plain_btf;
 
 		do_plain_btf = maps_have_btf(fds, nb_fds);
@@ -936,7 +1022,7 @@ static int do_dump(int argc, char **argv)
 		}
 	}
 
-	if (wtr && nb_fds > 1)
+	if (wtr && (nb_fds > 1 || recursive_dump))
 		jsonw_start_array(wtr);	/* root array */
 	for (i = 0; i < nb_fds; i++) {
 		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
@@ -944,22 +1030,50 @@ static int do_dump(int argc, char **argv)
 			err = -1;
 			break;
 		}
-		err = map_dump(fds[i], &info, wtr, nb_fds > 1);
+		err = map_dump(fds[i], &info, wtr, nb_fds > 1 || recursive_dump,
+			       recursive_dump ? &ctx : NULL);
 		if (!wtr && i != nb_fds - 1)
 			printf("\n");
 
 		if (err)
 			break;
-		close(fds[i]);
+		/* Keep selected maps alive while visiting their inner maps. */
+		if (!recursive_dump)
+			close(fds[i]);
+	}
+	for (j = 0; !err && j < ctx.pending_cnt; j++) {
+		int fd;
+
+		fd = bpf_map_get_fd_by_id_opts(ctx.pending_ids[j], &opts);
+		if (fd < 0) {
+			p_err("can't open inner map id %u: %s",
+			      ctx.pending_ids[j], strerror(errno));
+			err = -1;
+			break;
+		}
+		len = sizeof(info);
+		if (bpf_map_get_info_by_fd(fd, &info, &len)) {
+			p_err("can't get map info: %s", strerror(errno));
+			err = -1;
+		} else {
+			if (!wtr)
+				printf("\n");
+			err = map_dump(fd, &info, wtr, true, &ctx);
+		}
+		close(fd);
 	}
-	if (wtr && nb_fds > 1)
+	if (wtr && (nb_fds > 1 || recursive_dump))
 		jsonw_end_array(wtr);	/* root array */
 
 	if (btf_wtr)
 		jsonw_destroy(&btf_wtr);
 exit_close:
+	if (recursive_dump)
+		i = 0;
 	for (; i < nb_fds; i++)
 		close(fds[i]);
+	hashmap__free(ctx.seen);
+	free(ctx.pending_ids);
 exit_free:
 	free(fds);
 	free_btf_vmlinux();
@@ -1484,7 +1598,7 @@ static int do_help(int argc, char **argv)
 		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
 		"                 insn_array | rhash }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-		"                    {-f|--bpffs} | {-n|--nomount} }\n"
+		"                    {-f|--bpffs} | {-n|--nomount} | {-r|--recursive} }\n"
 		"",
 		bin_name, argv[-2]);
 
-- 
2.55.0

