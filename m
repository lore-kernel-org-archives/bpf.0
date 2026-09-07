Received: from out-93wp-a21.jellyfish.systems (out-93wp-a21.jellyfish.systems [104.207.68.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D809274670
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744083; cv=none; b=axt+4o5Hxw9nceZyNehYKOc4FH1JPjorFJ28kRce0AwGELWXJnN55y6FvcYAFOJcsf7CnVXpyN5RTIiJ/t6OGvVk0u4XUK0eLy+q/EkebV3IdgGhk9F5w/UkPOOYhqRljj5PINKRFZLg6L/n7gHHxw5IgsnBtaCExseWmzrjYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744083; c=relaxed/simple;
	bh=DS9iwohj+c+XpqsXPIoaYl5JW0FQadBGMTyGtZVVb/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iF6Oy1Q6oKxUWy5tMMPNoRrLhk8EsFJ+5nIYLMDf4kiDMNJBKILCVCHbYETzmbG7vDI3YI3XqNCtMC4DaYpsGzLoG52h3Xp0AhVpyKH66oYC8cBsoKfJf6n2CKWvGYnuuL/x+huP2QBBKMmxOQFcwCnpCrU3eJHRUWY253c/2QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=PZ1+dTpX; arc=none smtp.client-ip=104.207.68.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="PZ1+dTpX"
Received: from 192.168.5.3 (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdTmN2BjJz2x9g;
	Mon, 07 Sep 2026 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788744071;
	bh=2UZ6a0ZXQ/tONmzFl9gXaGavlzhwmEH+J/CxZ37mLwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZ1+dTpXsbVPOi9Nudh0ktXd/xtlF3m/J+QVjI5z7cXZFX/YbsPwr0VlBMW9x15jS
	 Z+kEnHF5y/U5oU+D00O/CKi2qYU3Z1NZF4MhE4wN5NoC09RetF/ZEBGJP5GBlj2aam
	 uhm8Xu9FxWuP0ORGVW7fqCTGsfTGBurQtvPJH1/EvYh02+v4Gn5zatSJIqapqFcn8k
	 5YnGol5tPvVH1rzlrBeMqWLla1AdRUb7ngVoH2zXQCN45JRzyhKhh7vn5zBbkoZVc5
	 T71qTerf19Nhba4gvZ5OiHatngLJbDirggm0A01mMBFN/Q2Ykwm5S0MTiVtzUMUatA
	 oq/qc/ZvXoU8A==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpftool: Read ring buffer maps with event_pipe
Date: Mon,  7 Sep 2026 09:21:02 +0800
Message-ID: <178874362960.1415955.4802953891665661440.ringbuf-v2-1@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178874362960.1415955.14971768495630842802.ringbuf-v2-0@tychen.cc>
References: <20260906170747.1212378-1-hi@tychen.cc> <178874362960.1415955.14971768495630842802.ringbuf-v2-0@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Allow map event_pipe to consume BPF_MAP_TYPE_RINGBUF maps using
libbpf's ring buffer manager. Print each record's size and raw bytes
in plain or JSON output, and flush output as records arrive.

Reject CPU and index selectors for ring buffers and retain the existing
perf event array path. Keep signal handlers limited to setting a stop
flag, reset that flag for each command, and print the stopping message
on stderr from the main path. Close the JSON array on poll errors and
preserve output errors returned by the ring buffer callback.

Document that consuming a ring buffer advances its shared consumer
position and add ring buffer maps to event_pipe completion.

Link: https://github.com/libbpf/bpftool/issues/54

Assisted-by: Codex:GPT-6
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/bpftool/Documentation/bpftool-map.rst | 15 +++-
 tools/bpf/bpftool/bash-completion/bpftool     |  4 +-
 tools/bpf/bpftool/map_perf_ring.c             | 87 ++++++++++++++-----
 3 files changed, 82 insertions(+), 24 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 5daf3de5c74..c44e6f797e5 100644
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
@@ -134,6 +135,18 @@ bpftool map event_pipe *MAP* [cpu *N* index *M*]
     existing ring.  Any other application will stop receiving events if it
     installed its rings earlier.
 
+    For a ring buffer map, consume records submitted by BPF programs, including
+    records already queued before the command starts. **cpu** and **index**
+    are not supported. Each record is printed as raw bytes, including embedded
+    zero bytes. Plain output reports the record size followed by hexadecimal
+    bytes; JSON output contains **size** and **data** fields, with **data** an
+    array of byte values. Ring buffer records have no implicit CPU or timestamp.
+
+    Ring buffers support a single consumer. This command advances the shared
+    consumer position and must not run alongside another consumer of the same
+    map; it does not provide a passive view of events. **BPF_MAP_TYPE_USER_RINGBUF**
+    maps are not supported.
+
 bpftool map peek  *MAP*
     Peek next value in the queue or stack.
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 75cbcb512eb..1750b488c9e 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -878,11 +878,11 @@ _bpftool()
                             return 0
                             ;;
                         id)
-                            _bpftool_get_map_ids_for_type perf_event_array
+                            _bpftool_get_map_ids_for_type '"type": "\(perf_event_array\|ringbuf\)"'
                             return 0
                             ;;
                         name)
-                            _bpftool_get_map_names_for_type perf_event_array
+                            _bpftool_get_map_names_for_type '"type": "\(perf_event_array\|ringbuf\)"'
                             return 0
                             ;;
                         cpu)
diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index bcb767e2d67..7d555331f44 100644
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
@@ -123,18 +143,26 @@ int do_event_pipe(int argc, char **argv)
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
+	if (map_info.type == BPF_MAP_TYPE_RINGBUF && argc) {
+		p_err("ring buffer maps do not support cpu or index arguments");
 		goto err_close_map;
 	}
 
@@ -184,15 +212,24 @@ int do_event_pipe(int argc, char **argv)
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
@@ -202,25 +239,33 @@ int do_event_pipe(int argc, char **argv)
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
+			fprintf(stderr, "Error: %s buffer polling failed: %s (%d)\n",
+				rb ? "ring" : "perf", strerror(-err), -err);
+			break;
 		}
+		err = 0;
 	}
 
+	if (stop)
+		fprintf(stderr, "Stopping...\n");
 	if (json_output)
 		jsonw_end_array(json_wtr);
+	if (fflush(stdout)) {
+		fprintf(stderr, "Error: failed to write events: %s\n", strerror(errno));
+		err = -1;
+	}
 
+	ring_buffer__free(rb);
 	perf_buffer__free(pb);
+	/* Both buffer managers borrow map_fd. */
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

