Received: from out-2uec-a117.jellyfish.systems (out-2uec-a117.jellyfish.systems [63.250.43.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B1215F42
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790387273; cv=none; b=MqxBDAlVT9Duy90nlu9jvPa8x1SpIwHbNNV/2qYv0QC4kS0CAWCQ1rspF2muEipBYefAL8SLdOt32R5sNgHJlGdtalDZj3qhdIgARzNLfHJmcBF9mQJ5LWhHDhQR3E7hBdKqaD3wbN61xTnFNOFILV19z4Nz1ilN80bSMvRFlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790387273; c=relaxed/simple;
	bh=l9vEeeTNz83YFQGcC4p3T4ZG3TLc7VLdBMG5jCWD/D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRw15HLKXWGmL8yUxhWseQ2JmAhiCjgFDskoho9da+xtrBBGPzg+r9LcGLNZDCfCi2vpouJnBNVRL1eB4NjZeR5WDhHmECmFHLXJT4jVKP3P2YKpe3MgrGIJv/p0ninIHhSux2Qe9bZivYapfnXrJzl6Q6LBVndFv9Befo/kg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=ckowzgbK; arc=none smtp.client-ip=63.250.43.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="ckowzgbK"
Received: from 192.168.50.46 (unknown [114.92.81.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hs9Kz2yWwz8sZ7;
	Sat, 26 Sep 2026 01:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790386937;
	bh=JMQH1/lNfMjrvq4dzBufwPZG3c3rykBjXUMtWOCCXw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckowzgbK8LbFjlIBvRBRgrGW3yMdeIZCiEHfkrPqmD/jd9012Zw7ImhnSceyubr2j
	 ESliorHM/dVF7fp5LpNjnyaRbdQhaDFT9dsxbnlMX5fYFKt9QDLagoNcAQf4Bn/2Al
	 qUkZjArtGBUo4V/8g0Ht0njaYi8qzN1aCPKOyZX66uDLNU/KCZtbndNGACDBp1vioq
	 QCj89NmoixnB/tyoqKBBrXq8RH3kivRBx2c2vdMZfG2wGAuevnFL4V9QP2IQ5HA0aX
	 StFYSIIOkS6ap37C0VpOK1k+E30EGRLQz9phvx96PUx8uWzjvDNrra1KWBorzWOoLi
	 PPaM6MRhfw75A==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org,
	skokovmaksimevg@gmail.com
Subject: [PATCH bpf-next v9 1/2] bpftool: Add recursive map dumping
Date: Sat, 26 Sep 2026 10:42:07 +0900
Message-ID: <20260926014208.24773-2-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926014208.24773-1-hi@tychen.cc>
References: <20260926014208.24773-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Dumping a map-of-maps currently shows inner map IDs without their
contents. Add a recursive keyword to map dump to include referenced
inner maps, leaving the default output unchanged. Show selected maps
followed by distinct inner maps, preserving plain and BTF formatting
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
 .../bpf/bpftool/Documentation/bpftool-map.rst |  12 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +
 tools/bpf/bpftool/map.c                       | 148 ++++++++++++++++--
 3 files changed, 150 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index e4ed7e701c9e..e407d20749df 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -29,7 +29,7 @@ MAP COMMANDS
 | **bpftool** **map create**     *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE* \
 |     **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] \
 |     [**offload_dev** *NAME*]
-| **bpftool** **map dump**       *MAP*
+| **bpftool** **map dump**       *MAP* [**recursive**]
 | **bpftool** **map update**     *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
 | **bpftool** **map lookup**     *MAP* [**key** *DATA*]
 | **bpftool** **map getnext**    *MAP* [**key** *DATA*]
@@ -87,10 +87,18 @@ bpftool map create *FILE* type *TYPE* key *KEY_SIZE* value *VALUE_SIZE*  entries
     Keyword **offload_dev** expects a network interface name, and is used to
     request hardware offload for the map.
 
-bpftool map dump    *MAP*
+bpftool map dump    *MAP* [recursive]
     Dump all entries in a given *MAP*.  In case of **name**, *MAP* may match
     several maps which will all be dumped.
 
+    With **recursive**, also dump the inner maps referenced by **array_of_maps**
+    and **hash_of_maps** entries. Each map ID is visited once, even if several
+    entries refer to it. Selected maps are followed by their inner maps.
+
+    Inner map IDs are resolved when the maps are visited. The dump is not an
+    atomic snapshot: concurrent updates can change map contents or remove a
+    referenced inner map before it is visited.
+
 bpftool map update  *MAP* [key *DATA*] [value *VALUE*] [*UPDATE_FLAGS*]
     Update map entry for a given *KEY*.
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 9d9ced270685..1c2febb08254 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -718,6 +718,9 @@ _bpftool()
                             return 0
                             ;;
                         *)
+                            if [[ $command == dump && $cword -eq 5 ]]; then
+                                COMPREPLY=( $( compgen -W 'recursive' -- "$cur" ) )
+                            fi
                             return 0
                             ;;
                     esac
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 626882f2079e..015910a493db 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -17,6 +17,7 @@
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/hashmap.h>
+#include <bpf/libbpf_internal.h>
 
 #include "json_writer.h"
 #include "main.h"
@@ -827,12 +828,43 @@ static void free_map_kv_btf(struct btf *btf)
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
 	int *cpu_ids = NULL;
 	int cpu_cnt = 0;
@@ -875,6 +907,17 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		goto exit_free;
 	}
 
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
@@ -909,9 +952,16 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 			p_err("can't get next key: %s", strerror(errno));
 			break;
 		}
-		if (!dump_map_elem(fd, key, value, info, btf, wtr,
-				   cpu_ids, cpu_cnt))
+		err = dump_map_elem(fd, key, value, info, btf, wtr,
+				    cpu_ids, cpu_cnt);
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
 
@@ -929,21 +979,29 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	free(value);
 	free(cpu_ids);
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
+	bool recursive_dump = false;
 	int nb_fds, i = 0;
 	__u32 len = sizeof(info);
 	int *fds = NULL;
 	int err = -1;
+	size_t j;
 
-	if (argc != 2)
-		usage();
+	if (!REQ_ARGS(2))
+		return -1;
 
 	fds = malloc(sizeof(int));
 	if (!fds) {
@@ -954,9 +1012,46 @@ static int do_dump(int argc, char **argv)
 	if (nb_fds < 1)
 		goto exit_free;
 
+	while (argc > 0) {
+		if (**argv && is_prefix(*argv, "recursive")) {
+			NEXT_ARG();
+			recursive_dump = true;
+		} else {
+			p_err("expected 'recursive', got: '%s'", *argv);
+			goto exit_close;
+		}
+	}
+
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
+			memset(&info, 0, sizeof(info));
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
@@ -971,30 +1066,61 @@ static int do_dump(int argc, char **argv)
 		}
 	}
 
-	if (wtr && nb_fds > 1)
+	if (wtr && (nb_fds > 1 || recursive_dump))
 		jsonw_start_array(wtr);	/* root array */
 	for (i = 0; i < nb_fds; i++) {
+		memset(&info, 0, sizeof(info));
+		len = sizeof(info);
 		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
 			p_err("can't get map info: %s", strerror(errno));
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
+		memset(&info, 0, sizeof(info));
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
@@ -1506,7 +1632,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s create     FILE type TYPE key KEY_SIZE value VALUE_SIZE \\\n"
 		"                                  entries MAX_ENTRIES name NAME [flags FLAGS] \\\n"
 		"                                  [inner_map MAP] [offload_dev NAME]\n"
-		"       %1$s %2$s dump       MAP\n"
+		"       %1$s %2$s dump       MAP [recursive]\n"
 		"       %1$s %2$s update     MAP [key DATA] [value VALUE] [UPDATE_FLAGS]\n"
 		"       %1$s %2$s lookup     MAP [key DATA]\n"
 		"       %1$s %2$s getnext    MAP [key DATA]\n"
-- 
2.55.0


