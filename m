Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFDE3A2544
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098449; cv=none; b=qtVHcwJuT8kRl8TdxF9n+kqZ8a+3E59GTAN/JJhMOy5wzReLZpYT+OkHPnZvciDot3EgL+2CfbCImgbFG9FAucmElr0irpQGop18SJgMG+jRyo1iK54qy98IBrry77oWg8CQUhq4tJKQGPq9Ac+M/NwGTdRBzhSH7nagw3Bm7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098449; c=relaxed/simple;
	bh=XUtx/U0+1GTFlIBes4MianFxY3hJJqmso2Kxwrk5fWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s74Kq70k+mZIbxiuGQNMvbKm+2NreTzuyUOQ2EBYtfa/NataWI4Ex6yNZUNlauqGHiLTrEchUUiHh9Opk3+5n2pzEU3hzMVidFJSxnNU32Ph4HZ9dfq10M2R0WRo0y473A/gkmlXBKJKRiD+wQa2rAWcxr7za10FH0MaqM2AXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkA7qU6x; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkA7qU6x"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso251656a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 20:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098446; x=1789703246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qNPg5aI78Jq7jQf9hppcwgA2xMxNVlFhIIop9VEnLCE=;
        b=RkA7qU6x1QQx/l9pu/6/Ehbe9ndPosyuXvr6maiy41zuG2liZohqEjS1qPlR9BsbdS
         rrLhlcK1TQezkFpHJ/Bii4dX3a6OttNx7/06ymm6FAjqJbQdOQO4vU/tbEV1hvuftFZY
         OngTDXnwy8K+ARVgpH6bkg7ADkmzk3F02aNdHbPbBICTfIVsikG9Kt1pZV6NgYICymPv
         fgXHiRnWMnMZKq6dHhnDxUWMMDMebvDvEQscKXT62nuUe/v04O6/NQY5I3NfUUEAyxPG
         TRrptEo8aN5tyGJmDh+wziJgNb57dxFcCISReoNBx5lwJOlbFCFFWO8TKsKffX4V3cMo
         1G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098446; x=1789703246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qNPg5aI78Jq7jQf9hppcwgA2xMxNVlFhIIop9VEnLCE=;
        b=Lgjfw4CQOVxzL+yU4dmrF2iQsz7DaIrWqKGRdrRiJNw15Qtk+1BmhYjOQqtSO01WPu
         zAIXKEPuzyA+W5lvAN2iYv3MQmnJgrALtIje4Ike5Ip+ZLcaG5VUZ21/Vj6w0O/CmfQO
         WiR9T0F6+bNzAE7eHeL4UbzMr2qdcpEJ912WQ/n+sH6sQMnoGI4E8Ft6xOLIWhCIVvJA
         0MFRL6+Ph5kYlblZcFnjDCZEsdteFJWP1GJta2wjuxRLvXMmUZELq7PTCGOmzVZ+TvDx
         nOPGT+MGZFqPJTRj2nJoSbDvi2Dz+b3b4veERSQgj9RSdJy/ifUx1Q+WWvhSV7lfCRqw
         Yi1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzr41sMOAtV892OWpAeJTn0yIAl/FIyTDuyTuRufM8sIm3nwhz/M5QO+ubw0ZHXINOrYyI=@vger.kernel.org
X-Gm-Message-State: AFuF++kA0LPcsfBo8yPGq1fsFqGMFHeJVzJPEUq4plFupKN14oVj9t+u
	keLmmPDYgFnrwwehGWlWpU1bREs4NZj88HbItHmzt3pYE2oaam4Zo53g
X-Gm-Gg: AYBFou0UtPk0JTYnTe4ddZLZzL2Ynf4LEnsASokotU0ib90rwUgau/y3PPQNJ6s/6Cd
	p3GOWM6E1WEjUrxTFUx4keKULZ9ZMREJyyE2bZwldw00xTIHR4qiIlOefwGQ3bi2OsbPOoGTXmf
	cpXu6KyYlBtVqfNj3aVjUZ+7NQtoyyfhioRvJGhhjN+cRFa/yL8ELIH0UAlc2IgG/7WvjI1HrEq
	YwgWVj6004wDZswSHQUMWbsvOJ/EI/8Wq8hMIJF8PktcPfYjEK70CXeYZx4l+39Vrxfo87E5021
	JBCAiBihQn73CJsirYveOk1CFqaF0RJVYsghNVL7wvPhR1xV78k5zPMNBT9DCcZcJzmpIBNaCkp
	IbXMN7tHtn8DJgA6r4ZESxPNExnjGECW6y1iSjnqSFk3oPpv+NMNQE2iAZrY4jvHTQ/ZZT+RSk5
	5S8YOMhyKuMmmFG5Bt9thAdm10okcykNrWy7+8b/zXgIsmWcCIQgq/DH6gc/5YhEpW
X-Received: by 2002:a17:90b:582b:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-39d9bc15493mr3745780a91.4.1789098446137;
        Thu, 10 Sep 2026 20:47:26 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2285195a91.14.2026.09.10.20.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:47:25 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 1/2] bpftool: Add recursive map dumping
Date: Fri, 11 Sep 2026 11:47:14 +0800
Message-ID: <20260911034715.219552-2-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911034715.219552-1-diannaaav@gmail.com>
References: <20260911034715.219552-1-diannaaav@gmail.com>
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
 tools/bpf/bpftool/map.c                       | 131 ++++++++++++++++--
 5 files changed, 152 insertions(+), 11 deletions(-)

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
index 684a8fb7241..c0505f50496 100644
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
+				  sizeof(*ids));
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
@@ -919,9 +980,35 @@ static int do_dump(int argc, char **argv)
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
@@ -936,7 +1023,7 @@ static int do_dump(int argc, char **argv)
 		}
 	}
 
-	if (wtr && nb_fds > 1)
+	if (wtr && (nb_fds > 1 || recursive_dump))
 		jsonw_start_array(wtr);	/* root array */
 	for (i = 0; i < nb_fds; i++) {
 		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
@@ -944,22 +1031,50 @@ static int do_dump(int argc, char **argv)
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
@@ -1484,7 +1599,7 @@ static int do_help(int argc, char **argv)
 		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
 		"                 insn_array | rhash }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-		"                    {-f|--bpffs} | {-n|--nomount} }\n"
+		"                    {-f|--bpffs} | {-n|--nomount} | {-r|--recursive} }\n"
 		"",
 		bin_name, argv[-2]);
 
-- 
2.55.0

