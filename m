Received: from mta0.migadu.com (out-105.mta0.migadu.com [91.218.175.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795C49D5A0
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819837; cv=none; b=HfD4Ur6pgp2rPwSIm82HsxLuxwRaUwICT9Vkqpxra2Z0Xu1nSV3oA4jBLqrDqQFgaX6wjSTwSc9HYUVF3d/TsGd9MMKK5igJctTxcBYRjgKW6xiuCaoSf5R+5bzm4rCZm1k73s891yXcvFAnvfTIp/0orIqa2Kq/ZgYioYA+syg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819837; c=relaxed/simple;
	bh=DSlbh00kEc9npLKJzQdsWytCT0gFDqSkr4BOgUTwBOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNV+rB8wr5Uems9apC/RideBRA4360V13DF3AepHqBB3/We7SQv68lsB5BfIhmLvDfY7pLe3uUTIv/40GSVZfUKzjP3we5uPtIHjBoplw7BmVPZL8Dk7R67BUB08/ImHRjpSlLWkAAVOPmH9SwUopcAmqJalnv/IVCFQ0a0JFBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cqqigYa7; arc=none smtp.client-ip=91.218.175.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cqqigYa7"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DSlbh00kEc9npLKJzQdsWytCT0gFDqSkr4BOgUTwBOk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819832; v=1; x=1792424632;
 b=cqqigYa7CAU+Uz9eJmaO+50Ld9+4jchu6JyfR1JrrCaKKXmsowSmt+lSR3AHG/ZqG+bgYJfh
 eoxPUbtd7hFCFMCsIWrr7YEp6d+TlP99LjNSZioFcaGwrJVsMdmgXUgYC50N/tlXp+QROYcMSgu
 QKPL5ThI+UR/Dkr5F+vIci08=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 408b62b324e49571;
	Mon, 12 Oct 2026 15:43:52 +0000
X-Mizu-Trace-ID: 408b62b324e49571
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
Subject: [PATCH bpf-next v2 11/21] bpf: Add tracing_multi link support for bpf progs
Date: Mon, 12 Oct 2026 23:40:13 +0800
Message-ID: <20261012154024.29423-12-leon.hwang@linux.dev>
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

Similar to the tracing_multi link support for kernel functions, add
support for bpf progs by reusing the 'ids' fields as BTF ids, and adding
fds array to indicate the target bpf prog. Then, for each pair of fd+id,
they will be the attach targets of tracing_multi link.

When attaching bpf prog, it attaches to the targets via
bpf_trampoline_multi_prog_attach(), that would work on all
trampoline-supported archs.

Since tracing_multi prog cannot recognize its targets at load time, reject
attaching to any other tracing prog to avoid two-levels nested tracing
attachment: e.g. fentry <- fentry.multi <- another fentry.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/uapi/linux/bpf.h       |   2 +
 kernel/trace/bpf_trace.c       | 177 ++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h |   2 +
 3 files changed, 156 insertions(+), 25 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6f70db7515dd..94302a3b680c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1927,6 +1927,8 @@ union bpf_attr {
 				__aligned_u64	ids;
 				__aligned_u64	cookies;
 				__u32		cnt;
+				__u32		:32;
+				__aligned_u64	fds;
 			} tracing_multi;
 		};
 	} link_create;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 69559158ab0b..d4af42e25fe5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3679,12 +3679,19 @@ __bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dynptr *dptr
 
 __bpf_kfunc_end_defs();
 
+static void bpf_put_progs(struct bpf_prog **progs, int cnt);
+
 static void bpf_tracing_multi_link_release(struct bpf_link *link)
 {
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
-	bpf_trampoline_multi_detach(link->prog, tr_link);
+	if (tr_link->tgt_progs) {
+		bpf_trampoline_multi_prog_detach(tr_link);
+		bpf_put_progs(tr_link->tgt_progs, tr_link->nodes_cnt);
+	} else {
+		bpf_trampoline_multi_detach(link->prog, tr_link);
+	}
 }
 
 static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
@@ -3692,6 +3699,8 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
+	kvfree(tr_link->pokes);
+	kvfree(tr_link->tgt_progs);
 	kvfree(tr_link->fexits);
 	kvfree(tr_link->cookies);
 	kvfree(tr_link);
@@ -3787,64 +3796,129 @@ static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
 #endif
 };
 
-static int ids_cmp_r(const void *pa, const void *pb, const void *priv __maybe_unused)
+struct tracing_multi_sort_data {
+	u64 *keys;
+	struct bpf_prog **progs;
+	u32 *ids;
+	u64 *cookies;
+};
+
+static int keys_cmp_r(const void *pa, const void *pb, const void *priv __maybe_unused)
 {
-	u32 a = *(u32 *) pa;
-	u32 b = *(u32 *) pb;
+	const u64 *key_a = pa, *key_b = pb;
 
-	return (a > b) - (a < b);
+	return (*key_a > *key_b) - (*key_a < *key_b);
 }
 
-static void ids_swap_r(void *a, void *b, int size __maybe_unused,
-		       const void *priv __maybe_unused)
+static void keys_swap_r(void *a, void *b, int size __maybe_unused,
+			const void *priv __maybe_unused)
 {
+	const struct tracing_multi_sort_data *data = priv;
+	struct bpf_prog **prog_a, **prog_b;
 	u64 *cookie_a, *cookie_b, *cookies;
-	u32 *id_a = a, *id_b = b, *ids;
-	void **data = (void **) priv;
+	u64 *key_a = a, *key_b = b, *keys;
+	u32 *id_a, *id_b, *ids;
+
+	keys    = data->keys;
+	ids     = data->ids;
+	cookies = data->cookies;
+	id_a    = ids + (key_a - keys);
+	id_b    = ids + (key_b - keys);
 
-	ids     = data[0];
-	cookies = data[1];
+	if (data->progs) {
+		prog_a = data->progs + (key_a - keys);
+		prog_b = data->progs + (key_b - keys);
+		swap(*prog_a, *prog_b);
+	}
 
 	if (cookies) {
 		cookie_a = cookies + (id_a - ids);
 		cookie_b = cookies + (id_b - ids);
 		swap(*cookie_a, *cookie_b);
 	}
+
 	swap(*id_a, *id_b);
+	swap(*key_a, *key_b);
 }
 
-static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt)
+static int check_dup_keys(u64 *keys, struct bpf_prog **progs, u32 *ids,
+			  u64 *cookies, u32 cnt)
 {
-	void *data[2] = { ids, cookies };
-	int err = 0;
+	struct tracing_multi_sort_data data = {
+		.keys = keys,
+		.progs = progs,
+		.ids = ids,
+		.cookies = cookies,
+	};
 
 	/*
-	 * Sort ids array (together with cookies array if defined)
-	 * and check it for duplicates. The ids and cookies arrays
-	 * are left sorted.
+	 * Sort trampoline keys together with target programs, ids, and cookies,
+	 * then check for duplicates. The arrays are left sorted.
 	 */
-	sort_r_nonatomic(ids, cnt, sizeof(ids[0]), ids_cmp_r, ids_swap_r, data);
+	sort_r_nonatomic(keys, cnt, sizeof(keys[0]), keys_cmp_r, keys_swap_r, &data);
+
+	for (int i = 1; i < cnt; i++)
+		if (keys[i] == keys[i - 1])
+			return -EINVAL;
 
-	for (int i = 1; i < cnt; i++) {
-		if (ids[i] == ids[i - 1]) {
+	return 0;
+}
+
+static void bpf_put_progs(struct bpf_prog **progs, int cnt)
+{
+	int i;
+
+	if (!progs)
+		return;
+
+	for (i = 0; i < cnt; i++)
+		bpf_prog_put(progs[i]);
+}
+
+static int bpf_get_progs(struct bpf_prog **progs, int *fds, int cnt)
+{
+	int err, i, put_cnt = 0;
+	struct bpf_prog *prog;
+
+	for (i = 0; i < cnt; i++) {
+		prog = bpf_prog_get(fds[i]);
+		if (IS_ERR(prog)) {
+			err = PTR_ERR(prog);
+			goto error;
+		}
+
+		progs[i] = prog;
+		put_cnt++;
+
+		if (prog->type == BPF_PROG_TYPE_TRACING) {
 			err = -EINVAL;
-			break;
+			goto error;
 		}
 	}
+	return 0;
+
+error:
+	bpf_put_progs(progs, put_cnt);
 	return err;
 }
 
 int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 {
 	struct bpf_tracing_multi_link *link = NULL;
+	struct btf *btf = prog->aux->attach_btf;
 	struct bpf_tramp_node *fexits = NULL;
 	struct bpf_link_primer link_primer;
+	struct bpf_text_poke **pokes = NULL;
+	u64 *cookies = NULL, *keys = NULL;
+	struct bpf_prog **progs = NULL;
 	u32 cnt, *ids = NULL;
 	u64 __user *ucookies;
-	u64 *cookies = NULL;
 	u32 __user *uids;
+	int __user *ufds;
+	int *fds = NULL;
 	int err;
 
+	ufds = u64_to_user_ptr(attr->link_create.tracing_multi.fds);
 	uids = u64_to_user_ptr(attr->link_create.tracing_multi.ids);
 	cnt = attr->link_create.tracing_multi.cnt;
 
@@ -3855,7 +3929,7 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	if (attr->link_create.flags || attr->link_create.target_fd)
 		return -EINVAL;
 
-	if (!IS_ENABLED(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS))
+	if (!ufds && !IS_ENABLED(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS))
 		return -EOPNOTSUPP;
 
 	ids = kvmalloc_objs(*ids, cnt);
@@ -3867,6 +3941,37 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		goto error;
 	}
 
+	if (ufds) {
+		fds = kvmalloc_objs(*fds, cnt);
+		if (!fds) {
+			err = -ENOMEM;
+			goto error;
+		}
+
+		if (copy_from_user(fds, ufds, cnt * sizeof(*fds))) {
+			err = -EFAULT;
+			goto error;
+		}
+
+		progs = kvmalloc_objs(*progs, cnt);
+		if (!progs) {
+			err = -ENOMEM;
+			goto error;
+		}
+
+		err = bpf_get_progs(progs, fds, cnt);
+		if (err) {
+			cnt = 0;
+			goto error;
+		}
+
+		pokes = kvmalloc_objs(*pokes, cnt);
+		if (!pokes) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
 	ucookies = u64_to_user_ptr(attr->link_create.tracing_multi.cookies);
 	if (ucookies) {
 		cookies = kvmalloc_objs(*cookies, cnt);
@@ -3880,7 +3985,16 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 		}
 	}
 
-	err = check_dup_ids(ids, cookies, cnt);
+	keys = kvmalloc_objs(*keys, cnt);
+	if (!keys) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	for (int i = 0; i < cnt; i++)
+		keys[i] = bpf_trampoline_compute_key(progs ? progs[i] : NULL, btf, ids[i]);
+
+	err = check_dup_keys(keys, progs, ids, cookies, cnt);
 	if (err)
 		goto error;
 
@@ -3908,19 +4022,32 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	link->nodes_cnt = cnt;
 	link->cookies = cookies;
 	link->fexits = fexits;
+	link->tgt_progs = progs;
+	link->pokes = pokes;
 
-	err = bpf_trampoline_multi_attach(prog, ids, link);
+	if (progs)
+		err = bpf_trampoline_multi_prog_attach(prog, ids, keys, link);
+	else
+		err = bpf_trampoline_multi_attach(prog, ids, link);
 	kvfree(ids);
+	kvfree(keys);
+	kvfree(fds);
 	if (err) {
+		bpf_put_progs(progs, cnt);
 		bpf_link_cleanup(&link_primer);
 		return err;
 	}
 	return bpf_link_settle(&link_primer);
 
 error:
+	bpf_put_progs(progs, cnt);
 	kvfree(fexits);
 	kvfree(cookies);
 	kvfree(ids);
+	kvfree(keys);
+	kvfree(fds);
+	kvfree(progs);
+	kvfree(pokes);
 	kvfree(link);
 	return err;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6f70db7515dd..94302a3b680c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1927,6 +1927,8 @@ union bpf_attr {
 				__aligned_u64	ids;
 				__aligned_u64	cookies;
 				__u32		cnt;
+				__u32		:32;
+				__aligned_u64	fds;
 			} tracing_multi;
 		};
 	} link_create;
-- 
2.55.0

