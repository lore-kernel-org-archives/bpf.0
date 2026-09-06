Received: from out-utut-a199.jellyfish.systems (out-utut-a199.jellyfish.systems [198.177.127.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC835028C
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.177.127.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710791; cv=none; b=ocIKTKPeFWaKPh3IJqvrSoFgVDI5Pm3GkRvHEGbQScGPJxr07LyMt+fRHlEutZNPZoFqYn745s3/UorBVZ7V3+gFWfOzn4A6+z5RNyOq5LVnn8t94IG8y4nrW9k7OIuuAsKcEehRUW7LgaiKFsvz0RXI4fOC0nyAgMuvhSqsKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710791; c=relaxed/simple;
	bh=Xk/T5twe9APHBagxux+9qxudW92rEDzCyri0+m4AMZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJxLWen+OmLTh6eUQ4PBKMec3TER30yoo9wCVjrz9jo4tl3M3o5jiorNzUUbqnzqgz4CqFfg31v0vFPBKGxLEH2F2nv1AkIvAjxO9Z2BXLJH5N/bCLrqRJvKisrDnLe/Fij3FV8vwSXN/Q5xAAUndUsPyV6jzzdsLcRPey1TrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=D8lcLCJw; arc=none smtp.client-ip=198.177.127.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="D8lcLCJw"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdFB54qZFz8sWQ;
	Sun, 06 Sep 2026 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788710051;
	bh=5OKJBtVC4obPW3iHjNbvDpymVhPbjWd0NN1Om/Ze6DA=;
	h=From:To:Cc:Subject:Date:From;
	b=D8lcLCJwcBxgL309PG9bwtQAeGMxcqrTV1FOmjtGHz2qnLpsPrGiCCbuRZWun8ySg
	 K4N8jAUo/rfGpJiyPyB0Wru83rSO+RzRzAwy3FYxlM0f6i61muGdnAIukzKfecNhu+
	 w+Dwt5IwZL6SBBtB4EvovHNhO2oUykzIYvwsLuPmqb1O+YaL76xCKwj2JC6wc3rubx
	 vUxRRGLaebmSEaHKUA5Ub8ChM8liywbJFkSEPozYzXJrcjAeR7ywD2Mjlpr06gqSN3
	 gqXUU4njLv3nmx38R6TUi9iqGzBfvrbwCNHnWp7+UE5MfOvmfIg4r4tFw5gO7+DlLa
	 s+pWHy9lfgc/w==
From: Tianyi Chen <hi@tychen.cc>
To: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: Tianyi Chen <hi@tychen.cc>,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	mason@kernel.org,
	ihor.solodrai@linux.dev
Subject: [PATCH bpf-next v2 1/2] bpftool: Add recursive map dumping
Date: Sun,  6 Sep 2026 23:53:54 +0800
Message-ID: <178870998583.979169.16526173782819097354@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Dumping a map-of-maps currently shows inner map IDs without their
contents. Add -r/--recursive to dump referenced inner maps as well,
leaving the default output unchanged.

Show the selected maps followed by discovered inner maps, with each
map's header and entries. JSON uses an array of these map objects.
Preserve BTF formatting in plain output, including when typed and
untyped maps are encountered in the same traversal.

Keep selected map FDs open and queue distinct inner map IDs. Open,
dump and close each queued map in turn, requiring only one additional
map FD regardless of the number of inner maps. Preserve per-entry
lookup error reporting for maps that do not support element lookups.

Report failure if an inner map cannot be opened and close any JSON
containers before returning. Document deferred ID resolution and the
non-atomic dump behavior, and add option completion.

Link: https://github.com/libbpf/bpftool/issues/58
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
Changes in v2:
- Preserve per-entry lookup error handling for unsupported map types.
- Queue inner IDs and open/dump/close one inner map at a time.
- Document deferred ID resolution and non-atomic traversal.

Validation: all 12 bpftool_map_dump subtests pass in a matching-kernel
VM, with zero skips. The four new regression subtests fail with v1.
Injected ENOENT during inner-map FD lookup returns failure and valid JSON.

v1: https://lore.kernel.org/bpf/20260906143950.848769-1-hi@tychen.cc/

 .../bpf/bpftool/Documentation/bpftool-map.rst |  21 ++-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/main.c                      |   7 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/map.c                       | 130 ++++++++++++++++--
 5 files changed, 150 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 5daf3de5c74..38d1f542bf5 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 
 **bpftool** [*OPTIONS*] **map** *COMMAND*
 
-*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } }
+*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } | { **-r** | **--recursive** } }
 
 *COMMANDS* :=
 { **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
@@ -170,6 +170,25 @@ OPTIONS
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
+    In JSON mode, an error during traversal is included in the output and the
+    enclosing arrays and objects are closed.
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
index c91e1a6e1a1..29021f4dd45 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -26,6 +26,7 @@ static int (*last_do_help)(int argc, char **argv);
 json_writer_t *json_wtr;
 bool pretty_output;
 bool json_output;
+bool recursive;
 bool show_pinned;
 bool block_mount;
 bool verifier_logs;
@@ -452,6 +453,7 @@ int main(int argc, char **argv)
 		{ "json",	no_argument,	NULL,	'j' },
 		{ "help",	no_argument,	NULL,	'h' },
 		{ "pretty",	no_argument,	NULL,	'p' },
+		{ "recursive",	no_argument,	NULL,	'r' },
 		{ "version",	no_argument,	NULL,	'V' },
 		{ "bpffs",	no_argument,	NULL,	'f' },
 		{ "mapcompat",	no_argument,	NULL,	'm' },
@@ -485,7 +487,7 @@ int main(int argc, char **argv)
 	bin_name = "bpftool";
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
+	while ((opt = getopt_long(argc, argv, "VhpjrfLmndSi:k:B:l",
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -507,6 +509,9 @@ int main(int argc, char **argv)
 			}
 			jsonw_pretty(json_wtr, pretty_output);
 			break;
+		case 'r':
+			recursive = true;
+			break;
 		case 'f':
 			show_pinned = true;
 			break;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 78b6e0ebb85..b5dc7960cf6 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -83,6 +83,7 @@ extern const char *bin_name;
 
 extern json_writer_t *json_wtr;
 extern bool json_output;
+extern bool recursive;
 extern bool show_pinned;
 extern bool show_pids;
 extern bool block_mount;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 684a8fb7241..fc06c765973 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -17,6 +17,7 @@
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/hashmap.h>
+#include <bpf/libbpf_internal.h>
 
 #include "json_writer.h"
 #include "main.h"
@@ -826,12 +827,44 @@ static void free_map_kv_btf(struct btf *btf)
 		btf__free(btf);
 }
 
+struct map_dump_ctx {
+	struct hashmap *seen;
+	__u32 *pending_ids;
+	size_t pending_cnt;
+};
+
+static int collect_inner_map(struct map_dump_ctx *ctx, __u32 id)
+{
+	__u32 *ids;
+	int err;
+
+	if (hashmap__find(ctx->seen, id, NULL))
+		return 0;
+
+	ids = libbpf_reallocarray(ctx->pending_ids, ctx->pending_cnt + 1,
+				 sizeof(*ids));
+	if (!ids) {
+		p_err("mem alloc failed");
+		return -1;
+	}
+	ctx->pending_ids = ids;
+
+	err = hashmap__add(ctx->seen, id, 0);
+	if (err) {
+		p_err("failed to record inner map id %u: %s", id, strerror(-err));
+		return -1;
+	}
+	ids[ctx->pending_cnt++] = id;
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
 
@@ -845,6 +878,17 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 
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
@@ -874,10 +918,20 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
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
 
@@ -894,18 +948,25 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
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
+		.open_flags = BPF_F_RDONLY,
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
@@ -919,9 +980,34 @@ static int do_dump(int argc, char **argv)
 	if (nb_fds < 1)
 		goto exit_free;
 
+	if (recursive) {
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
+				goto exit_close;
+			}
+		}
+	}
+
 	if (json_output) {
 		wtr = json_wtr;
-	} else {
+	} else if (!recursive) {
 		int do_plain_btf;
 
 		do_plain_btf = maps_have_btf(fds, nb_fds);
@@ -936,7 +1022,7 @@ static int do_dump(int argc, char **argv)
 		}
 	}
 
-	if (wtr && nb_fds > 1)
+	if (wtr && (nb_fds > 1 || recursive))
 		jsonw_start_array(wtr);	/* root array */
 	for (i = 0; i < nb_fds; i++) {
 		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
@@ -944,22 +1030,50 @@ static int do_dump(int argc, char **argv)
 			err = -1;
 			break;
 		}
-		err = map_dump(fds[i], &info, wtr, nb_fds > 1);
+		err = map_dump(fds[i], &info, wtr, nb_fds > 1 || recursive,
+			       recursive ? &ctx : NULL);
 		if (!wtr && i != nb_fds - 1)
 			printf("\n");
 
 		if (err)
 			break;
-		close(fds[i]);
+		/* Keep selected maps alive while visiting their inner maps. */
+		if (!recursive)
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
+	if (wtr && (nb_fds > 1 || recursive))
 		jsonw_end_array(wtr);	/* root array */
 
 	if (btf_wtr)
 		jsonw_destroy(&btf_wtr);
 exit_close:
+	if (recursive)
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

