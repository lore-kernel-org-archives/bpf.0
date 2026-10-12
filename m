Received: from mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE834A6CF6
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819867; cv=none; b=aD7MxvEpL+QEB+XERL8ZX2tdi5BoJzzveMgRd8RsGzsj1SIWDFha1h0tcGKPwHK2fdiz3QgPC2hc1hhYyBA0EiKPGZkzKkvBWS83/YF5k4jIwf4g6nMaYQI8H/t69UZJ+RImgdQDPc6EPK/rqjZh8ht5t5ug/It7oXDsecBnbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819867; c=relaxed/simple;
	bh=pCel36zqQQ5h5kB32+yCjitXi6Wul951Mg3KJZ5ltwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdt8rYGlFfJVi0P8tXnteAASCLoJpVFOiIDC3dvseMwY2cBuDhScgZjZX01Pf3MsnBSpCe/aLLzm/sTDLqomnd+AkqgzJAGfToBeQiIEWmRQkv7XJLsi3CZKSL9OxhGFYa7fJ+qTMKzsoOE47wz9NXamKaMQ3k4Pk9esjWdXgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vgBIDT36; arc=none smtp.client-ip=95.215.58.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vgBIDT36"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pCel36zqQQ5h5kB32+yCjitXi6Wul951Mg3KJZ5ltwk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819863; v=1; x=1792424663;
 b=vgBIDT36/zGfTRpg8HTyjy+zjvlJWCekG6mN2LGlxaVPgmW+a0C6TsDsR/L6V/HtVG9tpKW2
 Jv9sagkmjbAmlwd0yW0DkvofOoJQzVbbuMH9jAl9OhwP1l19tudl8MEROngsDnSEashzjk+e53s
 kX2Ygvdv2Qugufqwtc6+RtKI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c9eccac7c8fcb3c4;
	Mon, 12 Oct 2026 15:44:23 +0000
X-Mizu-Trace-ID: c9eccac7c8fcb3c4
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 14/21] bpf: Add tracing_multi link info support for bpf progs
Date: Mon, 12 Oct 2026 23:40:16 +0800
Message-ID: <20261012154024.29423-15-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Show bpf prog info in the link info.

$ bpftool link
9: tracing_multi  prog 25
	attach_type trace_fsession_multi  btf_obj_id 1  count 2
	prog_id          func_btf_id      addr             cookie           func [module]
	21               4                ffffffffc080064c 16706819         target_1 [bpf]
	22               5                ffffffffc08006d4 16706819         target_2 [bpf]
	pids test_progs(98)

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/uapi/linux/bpf.h       |  7 +++-
 kernel/trace/bpf_trace.c       | 26 ++++++++++----
 tools/bpf/bpftool/link.c       | 63 +++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h |  7 +++-
 4 files changed, 82 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 94302a3b680c..df66206af3cf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6891,6 +6891,10 @@ struct bpf_btf_info {
 	__u32 kernel_btf;
 } __attribute__((aligned(8)));
 
+enum {
+	BPF_F_TRACING_MULTI_TGT_PROGS = (1U << 0),
+};
+
 struct bpf_link_info {
 	__u32 type;
 	__u32 id;
@@ -6976,10 +6980,11 @@ struct bpf_link_info {
 			__u32 attach_type;
 			__u32 count; /* in/out: tracing_multi target count */
 			__u32 btf_obj_id;
-			__u32 :32;
+			__u32 flags;
 			__aligned_u64 ids;
 			__aligned_u64 addrs;
 			__aligned_u64 cookies;
+			__aligned_u64 func_btf_ids;
 		} tracing_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8b1a52350cfd..39c911917ae2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3709,15 +3709,16 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
 						 struct bpf_link_info *info)
 {
+	u32 __user *fids = u64_to_user_ptr(info->tracing_multi.func_btf_ids);
 	u64 __user *ucookies = u64_to_user_ptr(info->tracing_multi.cookies);
 	u64 __user *uaddrs = u64_to_user_ptr(info->tracing_multi.addrs);
 	u32 __user *uids = u64_to_user_ptr(info->tracing_multi.ids);
 	struct bpf_tracing_multi_link *tr_link;
 	u32 ucount = info->tracing_multi.count;
-	bool has_cookies, show_addrs;
+	bool has_cookies, show_addrs, has_progs;
 	int err = 0;
 
-	if ((uids || ucookies || uaddrs) && !ucount)
+	if ((uids || ucookies || uaddrs || fids) && !ucount)
 		return -EINVAL;
 
 	tr_link = container_of(link, struct bpf_tracing_multi_link, link);
@@ -3725,9 +3726,13 @@ static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
 	info->tracing_multi.attach_type = tr_link->link.attach_type;
 	info->tracing_multi.count = tr_link->nodes_cnt;
 	info->tracing_multi.btf_obj_id = btf_obj_id(tr_link->link.prog->aux->attach_btf);
+	has_progs = !!tr_link->tgt_progs;
+	info->tracing_multi.flags = has_progs ? BPF_F_TRACING_MULTI_TGT_PROGS : 0;
 
-	if (!uids && !ucookies && !uaddrs)
+	if (!uids && !ucookies && !uaddrs && !fids)
 		return 0;
+	if (has_progs != !!fids)
+		return -EINVAL;
 
 	if (ucount < tr_link->nodes_cnt)
 		err = -ENOSPC;
@@ -3739,20 +3744,27 @@ static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
 
 	for (int i = 0; i < ucount; i++) {
 		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
+		u32 prog_id, btf_id;
 		u64 addr, cookie;
-		u32 id;
 
-		bpf_trampoline_unpack_key(mnode->trampoline->key, NULL, &id);
+		bpf_trampoline_unpack_key(mnode->trampoline->key, &prog_id, &btf_id);
 
-		addr = show_addrs ? mnode->trampoline->ip : 0;
+		if (!show_addrs)
+			addr = 0;
+		else if (has_progs)
+			addr = (u64) mnode->trampoline->func.addr;
+		else
+			addr = mnode->trampoline->ip;
 		cookie = has_cookies ? tr_link->cookies[i] : 0;
 
-		if (uids && put_user(id, uids + i))
+		if (uids && put_user(has_progs ? prog_id : btf_id, uids + i))
 			return -EFAULT;
 		if (uaddrs && put_user(addr, uaddrs + i))
 			return -EFAULT;
 		if (ucookies && put_user(cookie, ucookies + i))
 			return -EFAULT;
+		if (has_progs && put_user((u32) mnode->trampoline->key, fids + i))
+			return -EFAULT;
 
 		cond_resched();
 	}
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 5cffa2d283b4..da7e430b14c8 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -422,12 +422,31 @@ show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 	jsonw_end_array(json_wtr);
 }
 
+#define BPF_PROG_PREFIX		"bpf_prog_"
+#define BPF_PROG_PREFIX_LEN	(sizeof(BPF_PROG_PREFIX) - 1)
+
+static const char *
+sym_name_trim_prefix(struct kernel_sym *sym, bool is_prog)
+{
+	int prefix_len;
+
+	if (!is_prog)
+		return sym->name;
+
+	/* Ref kernel/bpf/core.c::bpf_prog_ksym_set_name() */
+	prefix_len  = BPF_PROG_PREFIX_LEN;
+	prefix_len += BPF_TAG_SIZE * 2;
+	if (sym->name[prefix_len] != '\0')
+		prefix_len += 1;		/* skip the '_' */
+	return sym->name + prefix_len;
+}
+
 static void
 show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 {
-	bool is_ibt_enabled = is_x86_ibt_enabled(), show_symbol;
+	bool is_ibt_enabled = is_x86_ibt_enabled(), show_symbol, tgt_progs;
 	__u64 *addrs, *cookies;
-	__u32 i, *ids;
+	__u32 i, *ids, *fids;
 
 	if (!dd.sym_count)
 		kernel_syms_load(&dd);
@@ -443,6 +462,8 @@ show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 	ids = u64_to_u32_arr(info->tracing_multi.ids);
 	addrs = u64_to_arr(info->tracing_multi.addrs);
 	cookies = u64_to_arr(info->tracing_multi.cookies);
+	fids = u64_to_u32_arr(info->tracing_multi.func_btf_ids);
+	tgt_progs = info->tracing_multi.flags & BPF_F_TRACING_MULTI_TGT_PROGS;
 
 	for (i = 0; i < info->tracing_multi.count; i++) {
 		struct kernel_sym *sym;
@@ -451,10 +472,12 @@ show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 		sym = show_symbol ? find_kernel_sym_by_addr(addr, is_ibt_enabled) : NULL;
 
 		jsonw_start_object(wtr);
-		jsonw_uint_field(wtr, "id", ids[i]);
+		jsonw_uint_field(wtr, tgt_progs ? "prog_id" : "id", ids[i]);
+		if (tgt_progs)
+			jsonw_uint_field(wtr, "func_btf_id", fids[i]);
 		jsonw_uint_field(wtr, "addr", addr);
 		if (sym) {
-			jsonw_string_field(wtr, "func", sym->name);
+			jsonw_string_field(wtr, "func", sym_name_trim_prefix(sym, tgt_progs));
 			if (sym->module[0] == '\0') {
 				jsonw_name(wtr, "module");
 				jsonw_null(wtr);
@@ -903,9 +926,9 @@ static void show_uprobe_multi_plain(struct bpf_link_info *info)
 
 static void show_tracing_multi_plain(struct bpf_link_info *info)
 {
-	bool is_ibt_enabled = is_x86_ibt_enabled(), show_symbol;
+	bool is_ibt_enabled = is_x86_ibt_enabled(), show_symbol, tgt_progs;
 	__u64 *addrs, *cookies;
-	__u32 i, *ids;
+	__u32 i, *ids, *fids;
 
 	if (!info->tracing_multi.count)
 		return;
@@ -919,12 +942,18 @@ static void show_tracing_multi_plain(struct bpf_link_info *info)
 	printf("btf_obj_id %u  ", info->tracing_multi.btf_obj_id);
 	printf("count %u  ", info->tracing_multi.count);
 
-	printf("\n\t%-16s %-16s %-16s %s",
-	       "btf_id", "addr", "cookie", "func [module]");
+	tgt_progs = info->tracing_multi.flags & BPF_F_TRACING_MULTI_TGT_PROGS;
+	if (tgt_progs)
+		printf("\n\t%-16s %-16s %-16s %-16s %s",
+		       "prog_id", "func_btf_id", "addr", "cookie", "func [module]");
+	else
+		printf("\n\t%-16s %-16s %-16s %s",
+		       "btf_id", "addr", "cookie", "func [module]");
 
 	ids = u64_to_u32_arr(info->tracing_multi.ids);
 	addrs = u64_to_arr(info->tracing_multi.addrs);
 	cookies = u64_to_arr(info->tracing_multi.cookies);
+	fids = u64_to_u32_arr(info->tracing_multi.func_btf_ids);
 
 	for (i = 0; i < info->tracing_multi.count; i++) {
 		__u64 addr = addrs[i];
@@ -932,9 +961,13 @@ static void show_tracing_multi_plain(struct bpf_link_info *info)
 
 		sym = show_symbol ? find_kernel_sym_by_addr(addr, is_ibt_enabled) : NULL;
 
-		printf("\n\t%-16u %016llx %-16llu", ids[i], addr, cookies[i]);
+		if (tgt_progs)
+			printf("\n\t%-16u %-16u %016llx %-16llu",
+			       ids[i], fids[i], addr, cookies[i]);
+		else
+			printf("\n\t%-16u %016llx %-16llu", ids[i], addr, cookies[i]);
 		if (sym) {
-			printf(" %s", sym->name);
+			printf(" %s", sym_name_trim_prefix(sym, tgt_progs));
 			if (sym->module[0] != '\0')
 				printf(" [%s]", sym->module);
 		}
@@ -1140,7 +1173,7 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 static int do_show_link(int fd)
 {
 	__u64 *ref_ctr_offsets = NULL, *offsets = NULL, *cookies = NULL;
-	__u32 *ids = NULL;
+	__u32 *ids = NULL, *func_btf_ids = NULL;
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
 	char path_buf[PATH_MAX];
@@ -1229,12 +1262,16 @@ static int do_show_link(int fd)
 	if (info.type == BPF_LINK_TYPE_TRACING_MULTI && !info.tracing_multi.ids) {
 		count = info.tracing_multi.count;
 		if (count) {
+			bool tgt_progs = info.tracing_multi.flags & BPF_F_TRACING_MULTI_TGT_PROGS;
+
 			ids = calloc(count, sizeof(__u32));
 			addrs = calloc(count, sizeof(__u64));
 			cookies = calloc(count, sizeof(__u64));
-			if (!ids || !addrs || !cookies) {
+			func_btf_ids = tgt_progs ? calloc(count, sizeof(__u32)) : NULL;
+			if (!ids || !addrs || !cookies || (tgt_progs && !func_btf_ids)) {
 				p_err("mem alloc failed");
 				close(fd);
+				free(func_btf_ids);
 				free(cookies);
 				free(addrs);
 				free(ids);
@@ -1243,6 +1280,7 @@ static int do_show_link(int fd)
 			info.tracing_multi.ids = ptr_to_u64(ids);
 			info.tracing_multi.addrs = ptr_to_u64(addrs);
 			info.tracing_multi.cookies = ptr_to_u64(cookies);
+			info.tracing_multi.func_btf_ids = ptr_to_u64(func_btf_ids);
 			goto again;
 		}
 	}
@@ -1282,6 +1320,7 @@ static int do_show_link(int fd)
 		show_link_close_plain(fd, &info);
 
 	free(ref_ctr_offsets);
+	free(func_btf_ids);
 	free(cookies);
 	free(offsets);
 	free(addrs);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 94302a3b680c..60998ea1381c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6817,6 +6817,10 @@ struct sk_reuseport_md {
 
 #define BPF_TAG_SIZE	8
 
+enum {
+	BPF_F_TRACING_MULTI_TGT_PROGS = (1U << 0),
+};
+
 struct bpf_prog_info {
 	__u32 type;
 	__u32 id;
@@ -6976,10 +6980,11 @@ struct bpf_link_info {
 			__u32 attach_type;
 			__u32 count; /* in/out: tracing_multi target count */
 			__u32 btf_obj_id;
-			__u32 :32;
+			__u32 flags;
 			__aligned_u64 ids;
 			__aligned_u64 addrs;
 			__aligned_u64 cookies;
+			__aligned_u64 func_btf_ids;
 		} tracing_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
-- 
2.55.0

