Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292A3CF1F5;
	Sun,  9 Aug 2026 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287783; cv=none; b=r0hT7Ajx9h8rAnXxNrI90sZ4TJBrAMVVLZeMhUOtdueToACQU9jWNy4izBsOgg7OPEsIoE2n9pJqbbRVZLMNyUf8Cig793KoPgujfOqqvKy0yRVc3WK9OM/lv7qix3XyXSJdMwIUc1wq2HognzWVnKZf4Tv66bvoap1NDuu9HGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287783; c=relaxed/simple;
	bh=3/IN5wnJnEt5cI0QjVc3/5Pf29pwFGxdMq4On/UPNyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRsEAQ4xNudU0wQSc2vEmyOAsq+nqqBOj0LmOo7t6dMPoB5zrOn/494lBODHlFUnMfSvVIcwy3N2LRTKWOqaI5/GklmrMsQaBHOS6PPp/2Q15h0UiX5OT0BMIu1mG/icc+8zcpKlDWjGagxOmkSixxuxd/cvUmHY4EHDpwbAsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mIa9O170; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mIa9O170"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18gWgexAqBcbw9foGzmRcScDxWxgQFtJ1Mv18hB9TDc=;
	b=mIa9O1705R0HQKSMIgQylNB89rq1gUSmRH7UUeQxUhugPCndj8yXW9hIE0ORbN1MqKuNh2
	YXG575xe/7BuwBOuIhkX18G+6zBprO/CJpfsXFtlqBA1+moswwgIT2NIhiMA7NZdfKqN8k
	5F+HyO26/jllts2R4RWYN8IreddAxhg=
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
Subject: [PATCH bpf-next 07/13] bpf: Add tracing_multi link info support for bpf progs
Date: Sun,  9 Aug 2026 23:01:05 +0800
Message-ID: <20260809150111.45000-8-leon.hwang@linux.dev>
In-Reply-To: <20260809150111.45000-1-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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
 include/uapi/linux/bpf.h       |  4 ++-
 kernel/trace/bpf_trace.c       | 25 ++++++++++----
 tools/bpf/bpftool/link.c       | 59 +++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h |  4 ++-
 4 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6fa93a6ff54f..e0c8ea5ed2c8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6890,10 +6890,12 @@ struct bpf_link_info {
 			__u32 attach_type;
 			__u32 count; /* in/out: tracing_multi target count */
 			__u32 btf_obj_id;
-			__u32 :32;
+			__u32 tgt_progs:1;
+			__u32 :31;
 			__aligned_u64 ids;
 			__aligned_u64 addrs;
 			__aligned_u64 cookies;
+			__aligned_u64 func_btf_ids;
 		} tracing_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 80928401830c..d998e7ea563d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3707,15 +3707,16 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
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
@@ -3723,9 +3724,12 @@ static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
 	info->tracing_multi.attach_type = tr_link->link.attach_type;
 	info->tracing_multi.count = tr_link->nodes_cnt;
 	info->tracing_multi.btf_obj_id = btf_obj_id(tr_link->link.prog->aux->attach_btf);
+	info->tracing_multi.tgt_progs = has_progs = !!tr_link->progs;
 
-	if (!uids && !ucookies && !uaddrs)
+	if (!uids && !ucookies && !uaddrs && !fids)
 		return 0;
+	if (has_progs != !!fids)
+		return -EINVAL;
 
 	if (ucount < tr_link->nodes_cnt)
 		err = -ENOSPC;
@@ -3737,20 +3741,27 @@ static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
 
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
index 088d1d206065..d5c5ec433350 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -422,12 +422,30 @@ show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
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
+	prefix_len += 1;			/* skip the '_' */
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
@@ -443,6 +461,8 @@ show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 	ids = u64_to_u32_arr(info->tracing_multi.ids);
 	addrs = u64_to_arr(info->tracing_multi.addrs);
 	cookies = u64_to_arr(info->tracing_multi.cookies);
+	fids = u64_to_u32_arr(info->tracing_multi.func_btf_ids);
+	tgt_progs = info->tracing_multi.tgt_progs;
 
 	for (i = 0; i < info->tracing_multi.count; i++) {
 		struct kernel_sym *sym;
@@ -451,10 +471,12 @@ show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
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
@@ -903,9 +925,9 @@ static void show_uprobe_multi_plain(struct bpf_link_info *info)
 
 static void show_tracing_multi_plain(struct bpf_link_info *info)
 {
-	bool is_ibt_enabled = is_x86_ibt_enabled(), show_symbol;
+	bool is_ibt_enabled = is_x86_ibt_enabled(), show_symbol, tgt_progs;
 	__u64 *addrs, *cookies;
-	__u32 i, *ids;
+	__u32 i, *ids, *fids;
 
 	if (!info->tracing_multi.count)
 		return;
@@ -919,12 +941,18 @@ static void show_tracing_multi_plain(struct bpf_link_info *info)
 	printf("btf_obj_id %u  ", info->tracing_multi.btf_obj_id);
 	printf("count %u  ", info->tracing_multi.count);
 
-	printf("\n\t%-16s %-16s %-16s %s",
-	       "btf_id", "addr", "cookie", "func [module]");
+	tgt_progs = info->tracing_multi.tgt_progs;
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
@@ -932,9 +960,12 @@ static void show_tracing_multi_plain(struct bpf_link_info *info)
 
 		sym = show_symbol ? find_kernel_sym_by_addr(addr, is_ibt_enabled) : NULL;
 
-		printf("\n\t%-16u %016llx %-16llu", ids[i], addr, cookies[i]);
+		if (tgt_progs)
+			printf("\n\t%-16u %-16u %016llx %-16llu", ids[i], fids[i], addr, cookies[i]);
+		else
+			printf("\n\t%-16u %016llx %-16llu", ids[i], addr, cookies[i]);
 		if (sym) {
-			printf(" %s", sym->name);
+			printf(" %s", sym_name_trim_prefix(sym, tgt_progs));
 			if (sym->module[0] != '\0')
 				printf(" [%s]", sym->module);
 		}
@@ -1140,7 +1171,7 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 static int do_show_link(int fd)
 {
 	__u64 *ref_ctr_offsets = NULL, *offsets = NULL, *cookies = NULL;
-	__u32 *ids = NULL;
+	__u32 *ids = NULL, *func_btf_ids = NULL;
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
 	char path_buf[PATH_MAX];
@@ -1232,9 +1263,11 @@ static int do_show_link(int fd)
 			ids = calloc(count, sizeof(__u32));
 			addrs = calloc(count, sizeof(__u64));
 			cookies = calloc(count, sizeof(__u64));
-			if (!ids || !addrs || !cookies) {
+			func_btf_ids = info.tracing_multi.tgt_progs ? calloc(count, sizeof(__u32)) : NULL;
+			if (!ids || !addrs || !cookies || (info.tracing_multi.tgt_progs && !func_btf_ids)) {
 				p_err("mem alloc failed");
 				close(fd);
+				free(func_btf_ids);
 				free(cookies);
 				free(addrs);
 				free(ids);
@@ -1243,6 +1276,7 @@ static int do_show_link(int fd)
 			info.tracing_multi.ids = ptr_to_u64(ids);
 			info.tracing_multi.addrs = ptr_to_u64(addrs);
 			info.tracing_multi.cookies = ptr_to_u64(cookies);
+			info.tracing_multi.func_btf_ids = ptr_to_u64(func_btf_ids);
 			goto again;
 		}
 	}
@@ -1282,6 +1316,7 @@ static int do_show_link(int fd)
 		show_link_close_plain(fd, &info);
 
 	free(ref_ctr_offsets);
+	free(func_btf_ids);
 	free(cookies);
 	free(offsets);
 	free(addrs);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6fa93a6ff54f..e0c8ea5ed2c8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6890,10 +6890,12 @@ struct bpf_link_info {
 			__u32 attach_type;
 			__u32 count; /* in/out: tracing_multi target count */
 			__u32 btf_obj_id;
-			__u32 :32;
+			__u32 tgt_progs:1;
+			__u32 :31;
 			__aligned_u64 ids;
 			__aligned_u64 addrs;
 			__aligned_u64 cookies;
+			__aligned_u64 func_btf_ids;
 		} tracing_multi;
 		struct {
 			__u32 type; /* enum bpf_perf_event_type */
-- 
2.55.0

