Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C923D7C2
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782074758; cv=none; b=jwaQ3bZj9Al+xaxNa4AC/7msZ+knheWR50UUbhpswqesiTqbzhrNCta5kjktTpgqgymsVKQwOuzcNep1wZ9NTlXFviRhGI9nmbNf/Vtg9IUKgpPkP5qI9N9LMenzyR+Y10S5U6SmJS2MXp9NUUqpVohkNqmPCQ/uFKGgX6kVWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782074758; c=relaxed/simple;
	bh=MUA/K6Jux5JRKlIvzfqHjcCd3qhx4zXvK6REAFuowrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnrxseVAkXzHJ9Ibi9HD2AQFwfFvB6fiEgPgLYLzEUhRHweZTkhJjrTYplSuLYqbM0qAU2lI8Uwn1YJjBXXgMLPTn04VDI4XmPgi3QkYmtfpMQNlXJDFHk3KcP34l2wVMnPDtKbEY3O8tZA7J7+fUZW2i39ZCBDakM5vO1bFIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYcmTgy5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYcmTgy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023F71F000E9;
	Sun, 21 Jun 2026 20:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782074757;
	bh=7Fo4/Tf9g2ztPxzXKPx+hy3N0GIRujiqedZXRR8W1bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kYcmTgy5/VPyOLUGfLn0vPXizJUKcUHcuZ/OhEHWszYGKrYEiYOkIs/j5M3xZ5olv
	 +TMPkrky/TZLGFt2rRc966gr4rMpyy0xU0AmccjzaR4kpXyJI6S5iAA3LS/cA0IZcH
	 xxTGLcWRcbj+70ueX6qZ5zVzVqX8k+LzvBD9VLVcKp9Hnmkrh9NvcFb0YIAJX6mnaF
	 pH/CA6enxtBMa9tlYwFUs8YP2QGFbbAwVL9W7vjWjH5yp7b9T5vvnHuCqJLBWe2v/g
	 Agw9bUOXxm/v7Ejo2c3E6bw0oAIusqmGYkypEiZ48WQ+fANxRKgZTA7pD7VBQDiPy+
	 TA6pLSjD9xbiw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 3/3] bpftool: Add tracing_multi link info output
Date: Sun, 21 Jun 2026 22:45:24 +0200
Message-ID: <20260621204524.61067-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621204524.61067-1-jolsa@kernel.org>
References: <20260621204524.61067-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding bpftool support to show tracing_multi link details,
the new output looks like:

  # bpftool link
  ...
  27: tracing_multi  prog 93
          attach_type trace_fentry_multi  obj_id 1  count 3
          btf_id           addr             cookie           func [module]
          91984            ffffffff824f4a24 a                bpf_fentry_test1
          91986            ffffffff824f6a84 1e               bpf_fentry_test2
          91987            ffffffff824f6a94 14               bpf_fentry_test3
          pids test_progs(1462)

Assisted-by: Codex:GPT-5
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 135 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index bdcd717b0348..58dadee984a0 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -377,6 +377,31 @@ static __u64 *u64_to_arr(__u64 val)
 	return (__u64 *) u64_to_ptr(val);
 }
 
+static __u32 *u64_to_u32_arr(__u64 val)
+{
+	return (__u32 *)u64_to_ptr(val);
+}
+
+static struct kernel_sym *find_kernel_sym_by_addr(__u64 addr, bool is_ibt_enabled)
+{
+	struct kernel_sym *sym;
+
+	if (!addr)
+		return NULL;
+
+	/* Load it once for all. */
+	if (!dd.sym_count)
+		kernel_syms_load(&dd);
+	if (!dd.sym_count)
+		return NULL;
+
+	sym = kernel_syms_search(&dd, addr);
+	if (!sym && is_ibt_enabled && addr >= 4)
+		sym = kernel_syms_search(&dd, addr - 4);
+
+	return sym;
+}
+
 static void
 show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 {
@@ -403,6 +428,43 @@ show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 	jsonw_end_array(json_wtr);
 }
 
+static void
+show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	bool is_ibt_enabled = is_x86_ibt_enabled();
+	__u32 i;
+
+	show_link_attach_type_json(info->tracing_multi.attach_type, wtr);
+	jsonw_uint_field(wtr, "func_cnt", info->tracing_multi.count);
+	jsonw_uint_field(wtr, "obj_id", info->tracing_multi.obj_id);
+	jsonw_name(wtr, "funcs");
+
+	jsonw_start_array(wtr);
+
+	for (i = 0; i < info->tracing_multi.count; i++) {
+		__u64 addr = u64_to_arr(info->tracing_multi.addrs)[i];
+		struct kernel_sym *sym;
+
+		sym = find_kernel_sym_by_addr(addr, is_ibt_enabled);
+
+		jsonw_start_object(wtr);
+		jsonw_uint_field(wtr, "id", u64_to_u32_arr(info->tracing_multi.ids)[i]);
+		jsonw_uint_field(wtr, "addr", addr);
+		if (sym) {
+			jsonw_string_field(wtr, "func", sym->name);
+			if (sym->module[0] == '\0') {
+				jsonw_name(wtr, "module");
+				jsonw_null(wtr);
+			} else {
+				jsonw_string_field(wtr, "module", sym->module);
+			}
+		}
+		jsonw_uint_field(wtr, "cookie", u64_to_arr(info->tracing_multi.cookies)[i]);
+		jsonw_end_object(wtr);
+	}
+	jsonw_end_array(wtr);
+}
+
 static void
 show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
 {
@@ -589,6 +651,9 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_UPROBE_MULTI:
 		show_uprobe_multi_json(info, json_wtr);
 		break;
+	case BPF_LINK_TYPE_TRACING_MULTI:
+		show_tracing_multi_json(info, json_wtr);
+		break;
 	case BPF_LINK_TYPE_PERF_EVENT:
 		switch (info->perf_event.type) {
 		case BPF_PERF_EVENT_EVENT:
@@ -833,6 +898,38 @@ static void show_uprobe_multi_plain(struct bpf_link_info *info)
 	}
 }
 
+static void show_tracing_multi_plain(struct bpf_link_info *info)
+{
+	bool is_ibt_enabled = is_x86_ibt_enabled();
+	__u32 i;
+
+	if (!info->tracing_multi.count)
+		return;
+
+	printf("\n\t");
+	show_link_attach_type_plain(info->tracing_multi.attach_type);
+	printf("obj_id %u  ", info->tracing_multi.obj_id);
+	printf("count %u  ", info->tracing_multi.count);
+
+	printf("\n\t%-16s %-16s %-16s %s",
+	       "btf_id", "addr", "cookie", "func [module]");
+	for (i = 0; i < info->tracing_multi.count; i++) {
+		__u64 addr = u64_to_arr(info->tracing_multi.addrs)[i];
+		struct kernel_sym *sym;
+
+		sym = find_kernel_sym_by_addr(addr, is_ibt_enabled);
+
+		printf("\n\t%-16u %016llx %-16llx",
+		       u64_to_u32_arr(info->tracing_multi.ids)[i],
+		       addr, u64_to_arr(info->tracing_multi.cookies)[i]);
+		if (sym) {
+			printf(" %s", sym->name);
+			if (sym->module[0] != '\0')
+				printf(" [%s]", sym->module);
+		}
+	}
+}
+
 static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
 {
 	const char *buf;
@@ -989,6 +1086,9 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_UPROBE_MULTI:
 		show_uprobe_multi_plain(info);
 		break;
+	case BPF_LINK_TYPE_TRACING_MULTI:
+		show_tracing_multi_plain(info);
+		break;
 	case BPF_LINK_TYPE_PERF_EVENT:
 		switch (info->perf_event.type) {
 		case BPF_PERF_EVENT_EVENT:
@@ -1029,6 +1129,7 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 static int do_show_link(int fd)
 {
 	__u64 *ref_ctr_offsets = NULL, *offsets = NULL, *cookies = NULL;
+	__u32 *ids = NULL;
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
 	char path_buf[PATH_MAX];
@@ -1114,6 +1215,39 @@ static int do_show_link(int fd)
 			goto again;
 		}
 	}
+	if (info.type == BPF_LINK_TYPE_TRACING_MULTI &&
+	    !info.tracing_multi.ids) {
+		count = info.tracing_multi.count;
+		if (count) {
+			ids = calloc(count, sizeof(__u32));
+			if (!ids) {
+				p_err("mem alloc failed");
+				close(fd);
+				return -ENOMEM;
+			}
+			info.tracing_multi.ids = ptr_to_u64(ids);
+
+			addrs = calloc(count, sizeof(__u64));
+			if (!addrs) {
+				p_err("mem alloc failed");
+				free(ids);
+				close(fd);
+				return -ENOMEM;
+			}
+			info.tracing_multi.addrs = ptr_to_u64(addrs);
+
+			cookies = calloc(count, sizeof(__u64));
+			if (!cookies) {
+				p_err("mem alloc failed");
+				free(addrs);
+				free(ids);
+				close(fd);
+				return -ENOMEM;
+			}
+			info.tracing_multi.cookies = ptr_to_u64(cookies);
+			goto again;
+		}
+	}
 	if (info.type == BPF_LINK_TYPE_PERF_EVENT) {
 		switch (info.perf_event.type) {
 		case BPF_PERF_EVENT_TRACEPOINT:
@@ -1153,6 +1287,7 @@ static int do_show_link(int fd)
 	free(cookies);
 	free(offsets);
 	free(addrs);
+	free(ids);
 	close(fd);
 	return 0;
 }
-- 
2.54.0

