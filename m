Received: from out-zbxj-a71.jellyfish.systems (out-zbxj-a71.jellyfish.systems [198.54.127.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839083839AC
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976193; cv=none; b=jj+vKkMk3aNbhC47tG3f8Buhl9yYgSGu3WHII8CVxzQaczBKyx/+baIADsuoSllIudhX6Kp72rBQy7nrOC22mf35JiW8NCY4VNV1k7uQM+TydyvmG9nwDq6CIo8J0N2lKs9HGKDYkVVQQZqHKUeScLfPjR9GILmHr0c7Rcpwlx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976193; c=relaxed/simple;
	bh=KY3tzMiyIDtjZvNlPdgEUP92jFtKGlIx6rymtcgGrpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjY06bYXAHocXam3on5Zz6Wg8ftqqkXWVFdqX04lhqyfOKERQUeQlxG9cOodtyauX1FYU2hXPeoWYqn4RBcD07wWDG1ip+rkKJkw+Jrynlx4f+nJsnSY85Np+0BklX13zi1VnKP1Q+voIxtA0ZWO7WTMknX7xUYQ74rSyfA9MNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=Lei6v6oz; arc=none smtp.client-ip=198.54.127.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="Lei6v6oz"
Received: from fedora (unknown [117.136.111.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hpFQY6gP7z8sXv;
	Mon, 21 Sep 2026 07:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1789976169;
	bh=3KDumt9Styr8jrYn6vz8SVwtSh8xvLu7KtrsiU7nKdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lei6v6ozuAkTYtw3xWcJtvyc+wGyGRGQcuB3GgTf1k+jPMA3/JZLEw4e9mxUAE43n
	 Qjs/aYyRZf2g+MJysuG4VE+1Dt65R3Pb0fHjyTEpTfkObJ8WJfGVbLnGUXkQiSCqIM
	 3CHwnVN4h251Q/LovOclTvVGT2BAcLKnkLZrAItxkDQp2wLYkiNLRbeVKcC7Jc2xQ+
	 NDd+2McYijXPJshM6Wu3sgVmEbz8kv6KebKucnEvvu++d5HKryqhgwrvuFdaAMnmjB
	 P9BWsPyvlSjTfSnnJForWH3h9lMOhAmD1L0p/Xetj8S+HLix5CKk+iFZ5pOm+Q7rKT
	 iN8OTuh2vZ/sA==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 1/2] bpftool: Read ring buffer maps with event_pipe
Date: Mon, 21 Sep 2026 16:35:55 +0900
Message-ID: <20260921073556.99421-2-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921073556.99421-1-hi@tychen.cc>
References: <20260921073556.99421-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

map event_pipe only accepts perf event arrays, leaving no built-in way
to inspect records produced through the BPF ring buffer API. Extend it
to consume queued and live BPF_MAP_TYPE_RINGBUF records in plain or
JSON output, retaining the existing perf event array path.

Ring buffers have a shared consumer position and no implicit CPU or
timestamp. Document that this command consumes records rather than
observing them passively, and reject perf-only CPU/index selectors.

A producer can keep ring_buffer__poll() busy after a stop signal, so
return -EINTR from the record callback when stopping. Keep stdio out of
the shared signal handler and preserve callback output errors.

Link: https://github.com/libbpf/bpftool/issues/54

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/bpftool/Documentation/bpftool-map.rst | 14 ++-
 tools/bpf/bpftool/bash-completion/bpftool     | 59 +++++++------
 tools/bpf/bpftool/map_perf_ring.c             | 87 ++++++++++++++-----
 3 files changed, 112 insertions(+), 48 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 5daf3de5c744..e4ed7e701c9e 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -120,7 +120,8 @@ bpftool map pin     *MAP*  *FILE*
     character ('.'), which is reserved for future extensions of *bpffs*.
 
 bpftool map event_pipe *MAP* [cpu *N* index *M*]
-    Read events from a **BPF_MAP_TYPE_PERF_EVENT_ARRAY** map.
+    Read events from a **BPF_MAP_TYPE_PERF_EVENT_ARRAY** or
+    **BPF_MAP_TYPE_RINGBUF** map.
 
     Install perf rings into a perf event array map and dump output of any
     **bpf_perf_event_output**\ () call in the kernel. By default read the
@@ -134,6 +135,17 @@ bpftool map event_pipe *MAP* [cpu *N* index *M*]
     existing ring.  Any other application will stop receiving events if it
     installed its rings earlier.
 
+    For a ring buffer map, consume records submitted by BPF programs, including
+    records already queued before the command starts. **cpu** and **index**
+    are not supported. Each record is printed in full, including embedded zero
+    bytes. Plain output reports the record size followed by hexadecimal
+    bytes; JSON output contains **size** and **data** fields, with **data** an
+    array of byte values. Ring buffer records have no implicit CPU or timestamp.
+
+    Consuming a ring buffer advances its shared consumer position, so this
+    command must not run alongside another consumer of the same map.
+    **BPF_MAP_TYPE_USER_RINGBUF** maps are not supported.
+
 bpftool map peek  *MAP*
     Peek next value in the queue or stack.
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 75cbcb512eba..c9e8761e4ef2 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -50,12 +50,19 @@ _bpftool_get_map_ids()
         command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
-# Takes map type and adds matching map ids to the list of suggestions.
-_bpftool_get_map_ids_for_type()
+# Takes map types and prints a pattern matching their JSON type fields.
+_bpftool_build_type_pattern()
 {
-    local type="$1"
+    local IFS='|'
+    printf '"type": "(%s)"\n' "$*"
+}
+
+# Takes map types and adds matching map ids to the list of suggestions.
+_bpftool_get_map_ids_for_types()
+{
+    local types=$(_bpftool_build_type_pattern "$@")
     COMPREPLY+=( $( compgen -W "$( bpftool -jp map  2>&1 | \
-        command grep -C2 "$type" | \
+        command grep -C2 -E "$types" | \
         command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
@@ -65,12 +72,12 @@ _bpftool_get_map_names()
         command sed -n 's/.*"name": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
-# Takes map type and adds matching map names to the list of suggestions.
-_bpftool_get_map_names_for_type()
+# Takes map types and adds matching map names to the list of suggestions.
+_bpftool_get_map_names_for_types()
 {
-    local type="$1"
+    local types=$(_bpftool_build_type_pattern "$@")
     COMPREPLY+=( $( compgen -W "$( bpftool -jp map  2>&1 | \
-        command grep -C2 "$type" | \
+        command grep -C2 -E "$types" | \
         command sed -n 's/.*"name": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
@@ -139,7 +146,7 @@ _bpftool_map_guess_map_type()
     local keyword idx ref=""
     for (( idx=3; idx < ${#words[@]}-1; idx++ )); do
         case "${words[$((idx-2))]}" in
-            lookup|update)
+            lookup|update|event_pipe)
                 keyword=${words[$((idx-1))]}
                 ref=${words[$((idx))]}
                 ;;
@@ -177,10 +184,10 @@ _bpftool_map_update_get_id()
     if [[ $value -eq 0 ]]; then
         case "$command" in
             push)
-                _bpftool_get_map_ids_for_type stack
+                _bpftool_get_map_ids_for_types stack
                 ;;
             enqueue)
-                _bpftool_get_map_ids_for_type queue
+                _bpftool_get_map_ids_for_types queue
                 ;;
             *)
                 _bpftool_get_map_ids
@@ -223,10 +230,10 @@ _bpftool_map_update_get_name()
     if [[ $value -eq 0 ]]; then
         case "$command" in
             push)
-                _bpftool_get_map_names_for_type stack
+                _bpftool_get_map_names_for_types stack
                 ;;
             enqueue)
-                _bpftool_get_map_names_for_type queue
+                _bpftool_get_map_names_for_types queue
                 ;;
             *)
                 _bpftool_get_map_names
@@ -617,10 +624,10 @@ _bpftool()
                             COMPREPLY=( $( compgen -W "$STRUCT_OPS_TYPE" -- "$cur" ) )
                             ;;
                         id)
-                            _bpftool_get_map_ids_for_type struct_ops
+                            _bpftool_get_map_ids_for_types struct_ops
                             ;;
                         name)
-                            _bpftool_get_map_names_for_type struct_ops
+                            _bpftool_get_map_names_for_types struct_ops
                             ;;
                     esac
                     return 0
@@ -679,14 +686,13 @@ _bpftool()
                         id)
                             case "$command" in
                                 peek)
-                                    _bpftool_get_map_ids_for_type stack
-                                    _bpftool_get_map_ids_for_type queue
+                                    _bpftool_get_map_ids_for_types stack queue
                                     ;;
                                 pop)
-                                    _bpftool_get_map_ids_for_type stack
+                                    _bpftool_get_map_ids_for_types stack
                                     ;;
                                 dequeue)
-                                    _bpftool_get_map_ids_for_type queue
+                                    _bpftool_get_map_ids_for_types queue
                                     ;;
                                 *)
                                     _bpftool_get_map_ids
@@ -697,14 +703,13 @@ _bpftool()
                         name)
                             case "$command" in
                                 peek)
-                                    _bpftool_get_map_names_for_type stack
-                                    _bpftool_get_map_names_for_type queue
+                                    _bpftool_get_map_names_for_types stack queue
                                     ;;
                                 pop)
-                                    _bpftool_get_map_names_for_type stack
+                                    _bpftool_get_map_names_for_types stack
                                     ;;
                                 dequeue)
-                                    _bpftool_get_map_names_for_type queue
+                                    _bpftool_get_map_names_for_types queue
                                     ;;
                                 *)
                                     _bpftool_get_map_names
@@ -878,11 +883,11 @@ _bpftool()
                             return 0
                             ;;
                         id)
-                            _bpftool_get_map_ids_for_type perf_event_array
+                            _bpftool_get_map_ids_for_types perf_event_array ringbuf
                             return 0
                             ;;
                         name)
-                            _bpftool_get_map_names_for_type perf_event_array
+                            _bpftool_get_map_names_for_types perf_event_array ringbuf
                             return 0
                             ;;
                         cpu)
@@ -892,7 +897,9 @@ _bpftool()
                             return 0
                             ;;
                         *)
-                            _bpftool_once_attr 'cpu index'
+                            if [[ $(_bpftool_map_guess_map_type) != ringbuf ]]; then
+                                _bpftool_once_attr 'cpu index'
+                            fi
                             return 0
                             ;;
                     esac
diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index bcb767e2d673..5878938cf8d9 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -27,7 +27,7 @@
 
 #define MMAP_PAGE_CNT	16
 
-static volatile bool stop;
+static volatile sig_atomic_t stop;
 
 struct perf_event_sample {
 	struct perf_event_header header;
@@ -44,7 +44,6 @@ struct perf_event_lost {
 
 static void int_exit(int signo)
 {
-	fprintf(stderr, "Stopping...\n");
 	stop = true;
 }
 
@@ -107,6 +106,27 @@ print_bpf_output(void *private_data, int cpu, struct perf_event_header *event)
 	return LIBBPF_PERF_EVENT_CONT;
 }
 
+static int print_ringbuf_output(void *ctx, void *data, size_t size)
+{
+	if (json_output) {
+		jsonw_start_object(json_wtr);
+		jsonw_uint_field(json_wtr, "size", size);
+		jsonw_name(json_wtr, "data");
+		print_data_json(data, size);
+		jsonw_end_object(json_wtr);
+	} else {
+		printf("== size: %zu =====\n", size);
+		fprint_hex(stdout, data, size, " ");
+		printf("\n");
+	}
+
+	if (fflush(stdout))
+		return errno ? -errno : -EIO;
+
+	/* A producer can keep poll() busy even after a signal arrives. */
+	return stop ? -EINTR : 0;
+}
+
 int do_event_pipe(int argc, char **argv)
 {
 	struct perf_event_attr perf_attr = {
@@ -123,18 +143,27 @@ int do_event_pipe(int argc, char **argv)
 		.cpu = -1,
 		.idx = -1,
 	};
-	struct perf_buffer *pb;
+	struct perf_buffer *pb = NULL;
+	struct ring_buffer *rb = NULL;
 	__u32 map_info_len;
 	int err, map_fd;
 
+	stop = false;
 	map_info_len = sizeof(map_info);
 	map_fd = map_parse_fd_and_info(&argc, &argv, &map_info, &map_info_len,
 				       0);
 	if (map_fd < 0)
 		return -1;
 
-	if (map_info.type != BPF_MAP_TYPE_PERF_EVENT_ARRAY) {
-		p_err("map is not a perf event array");
+	if (map_info.type != BPF_MAP_TYPE_PERF_EVENT_ARRAY &&
+	    map_info.type != BPF_MAP_TYPE_RINGBUF) {
+		p_err("map is not a perf event array or ring buffer");
+		goto err_close_map;
+	}
+
+	if (map_info.type == BPF_MAP_TYPE_RINGBUF && argc &&
+	    (is_prefix(*argv, "cpu") || is_prefix(*argv, "index"))) {
+		p_err("ring buffer maps do not support cpu or index arguments");
 		goto err_close_map;
 	}
 
@@ -184,15 +213,24 @@ int do_event_pipe(int argc, char **argv)
 		ctx.idx = 0;
 	}
 
-	opts.cpu_cnt = ctx.all_cpus ? 0 : 1;
-	opts.cpus = &ctx.cpu;
-	opts.map_keys = &ctx.idx;
-	pb = perf_buffer__new_raw(map_fd, MMAP_PAGE_CNT, &perf_attr,
-				  print_bpf_output, &ctx, &opts);
-	if (!pb) {
-		p_err("failed to create perf buffer: %s (%d)",
-		      strerror(errno), errno);
-		goto err_close_map;
+	if (map_info.type == BPF_MAP_TYPE_RINGBUF) {
+		rb = ring_buffer__new(map_fd, print_ringbuf_output, NULL, NULL);
+		if (!rb) {
+			p_err("failed to create ring buffer: %s (%d)",
+			      strerror(errno), errno);
+			goto err_close_map;
+		}
+	} else {
+		opts.cpu_cnt = ctx.all_cpus ? 0 : 1;
+		opts.cpus = &ctx.cpu;
+		opts.map_keys = &ctx.idx;
+		pb = perf_buffer__new_raw(map_fd, MMAP_PAGE_CNT, &perf_attr,
+					  print_bpf_output, &ctx, &opts);
+		if (!pb) {
+			p_err("failed to create perf buffer: %s (%d)",
+			      strerror(errno), errno);
+			goto err_close_map;
+		}
 	}
 
 	signal(SIGINT, int_exit);
@@ -202,25 +240,32 @@ int do_event_pipe(int argc, char **argv)
 	if (json_output)
 		jsonw_start_array(json_wtr);
 
+	err = 0;
 	while (!stop) {
-		err = perf_buffer__poll(pb, 200);
+		err = rb ? ring_buffer__poll(rb, 200) : perf_buffer__poll(pb, 200);
 		if (err < 0 && err != -EINTR) {
-			p_err("perf buffer polling failed: %s (%d)",
-			      strerror(errno), errno);
-			goto err_close_pb;
+			p_err("%s buffer polling failed: %s (%d)",
+			      rb ? "ring" : "perf", strerror(-err), -err);
+			break;
 		}
+		err = 0;
 	}
 
+	if (stop)
+		fprintf(stderr, "Stopping...\n");
 	if (json_output)
 		jsonw_end_array(json_wtr);
+	if (fflush(stdout)) {
+		p_err("failed to write events: %s", strerror(errno));
+		err = -1;
+	}
 
+	ring_buffer__free(rb);
 	perf_buffer__free(pb);
 	close(map_fd);
 
-	return 0;
+	return err < 0 ? -1 : 0;
 
-err_close_pb:
-	perf_buffer__free(pb);
 err_close_map:
 	close(map_fd);
 	return -1;
-- 
2.55.0

