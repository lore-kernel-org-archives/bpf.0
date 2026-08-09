Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81F3CEB8F
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287742; cv=none; b=HrQfLaT+cORDA2iV3k68DNPD/AuT1n2Kf52E2zaXbG2e39/jA674eDzEyVTYaym6bxCsAst4Eb9ynxjWJQs38QPDQgzSvpZJZQ6V3cM/fWbk+/3n135Y3IY2V5dSgOoLJCryMmcZfw73+H3QafX4JqazCKi5Up03ZxAoe8MO85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287742; c=relaxed/simple;
	bh=7FOSTniZwjPrQT60YlmJvMFPrfJzIvlQebiOf9s+Bzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnBSaFY80eyFLgkrNuHHtr8QMqbOEFs0s/I2TyIfzRmr4VnKvrSNRwBX+MIDTiudr1ngnJcjACCkemV/8sH79JFRxpX28DTgwiFnvPgSnl4/GOlJApirbFgl8STeQOmiBFAlJHF+81yPMYnllGksULAc4cd/0cK4S5RqSFzreho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vsLkRGwY; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vsLkRGwY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhJ08LZoEnuY9C/qeiI0H3GIXG/a0BicPUcIztOIMk0=;
	b=vsLkRGwYb4zueDrRx4owZyraboZ0fkrOVs1FDxZ6IZSGUmL4d6n0J5JKCfCDyntrUTPfzu
	8YoU34vK/qjEtSBSLOsFzKYqGvc36GFWIkC1nAFhXTtv6n0dZzx+Ae8MLh5EJNjnj7Vomq
	iAVGX1sFor60U90Cwj8hxmj17YaEbeA=
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
Subject: [PATCH bpf-next 04/13] bpf: Add tracing_multi link support for bpf progs
Date: Sun,  9 Aug 2026 23:01:02 +0800
Message-ID: <20260809150111.45000-5-leon.hwang@linux.dev>
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

Similar to the tracing_multi link support for kernel functions, add
support for bpf progs by reusing the 'ids' fields as BTF ids, and adding
fds array to indicate the target bpf prog. Then, for each pair of fd+id,
they will be the attach targets of tracing_multi link.

When attaching bpf prog, it must attaches to the target by text poke way.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h            |   3 +
 include/uapi/linux/bpf.h       |   2 +
 kernel/bpf/trampoline.c        |  45 ++++++++--
 kernel/bpf/verifier.c          |  22 ++---
 kernel/trace/bpf_trace.c       | 157 ++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h |   2 +
 6 files changed, 189 insertions(+), 42 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4a10c9878cf..9962228bca41 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1517,6 +1517,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr);
 int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs);
 
 int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
+				u64 *keys, struct bpf_prog **progs,
 				struct bpf_tracing_multi_link *link);
 int bpf_trampoline_multi_detach(struct bpf_prog *prog,
 				struct bpf_tracing_multi_link *link);
@@ -1635,6 +1636,7 @@ static inline bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 	return false;
 }
 static inline int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
+					      u64 *keys, struct bpf_prog **progs,
 					      struct bpf_tracing_multi_link *link)
 {
 	return -ENOTSUPP;
@@ -2002,6 +2004,7 @@ struct bpf_tracing_multi_link {
 	struct bpf_tracing_multi_data data;
 	u64 *cookies;
 	struct bpf_tramp_node *fexits;
+	struct bpf_prog **progs;
 	int nodes_cnt;
 	struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ffd96e8b920b..6fa93a6ff54f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1888,6 +1888,8 @@ union bpf_attr {
 				__aligned_u64	ids;
 				__aligned_u64	cookies;
 				__u32		cnt;
+				__u32		:32;
+				__aligned_u64	fds;
 			} tracing_multi;
 		};
 	} link_create;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index eddd259d3776..fc51ea2428be 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1572,12 +1572,23 @@ static int update_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags,
 			       struct bpf_tramp_image *im, struct ftrace_hash *hash,
 			       struct bpf_tracing_multi_data *data)
 {
-	unsigned long addr = (unsigned long)(im ? im->image : tr->cur_image->image);
+	if (tr->func.ftrace_managed) {
+		unsigned long addr = (unsigned long)(im ? im->image : tr->cur_image->image);
 
-	if (bpf_trampoline_use_jmp(tr->flags))
-		addr = ftrace_jmp_set(addr);
+		if (bpf_trampoline_use_jmp(tr->flags))
+			addr = ftrace_jmp_set(addr);
+
+		ftrace_hash_add(hash, data->entry, tr->ip, addr);
+	} else {
+		void *old_addr = tr->cur_image ? tr->cur_image->image : NULL;
+		void *new_addr = im ? im->image : NULL;
+		int ret;
+
+		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, new_addr);
+		if (ret)
+			return ret;
+	}
 
-	ftrace_hash_add(hash, data->entry, tr->ip, addr);
 	tr->cur_image = im;
 	return 0;
 }
@@ -1627,6 +1638,18 @@ static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
 
 static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
 {
+	if (!tr->func.ftrace_managed) {
+		void *failed_addr = tr->cur_image ? tr->cur_image->image : NULL;
+		void *old_addr = tr->multi_attach.old_image ?
+				 tr->multi_attach.old_image->image : NULL;
+		u32 orig_flags = tr->flags;
+		int ret;
+
+		tr->flags = tr->multi_attach.old_flags;
+		ret = bpf_trampoline_update_fentry(tr, orig_flags, failed_addr, old_addr);
+		WARN_ONCE(ret, "bpf_trampoline_update_fentry failed: %d\n", ret);
+	}
+
 	if (tr->cur_image)
 		bpf_tramp_image_put(tr->cur_image);
 	tr->cur_image = tr->multi_attach.old_image;
@@ -1643,6 +1666,7 @@ static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
 	for_each_mnode_cnt(mnode, link, link->nodes_cnt)
 
 int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
+				u64 *keys, struct bpf_prog **progs,
 				struct bpf_tracing_multi_link *link)
 {
 	struct bpf_tracing_multi_data *data = &link->data;
@@ -1651,18 +1675,18 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	struct bpf_tracing_multi_node *mnode;
 	struct bpf_trampoline *tr;
 	int i, err, rollback_cnt;
-	u64 key;
 
 	for_each_mnode(mnode, link) {
 		rollback_cnt = i;
 
-		err = bpf_check_attach_btf_id_multi(btf, prog, ids[i], &tgt_info);
+		if (progs)
+			err = bpf_check_attach_target(NULL, prog, progs[i], ids[i], &tgt_info);
+		else
+			err = bpf_check_attach_btf_id_multi(btf, prog, ids[i], &tgt_info);
 		if (err)
 			goto rollback_put;
 
-		key = bpf_trampoline_compute_key(NULL, btf, ids[i]);
-
-		tr = bpf_trampoline_get(key, &tgt_info);
+		tr = bpf_trampoline_get(keys[i], &tgt_info);
 		if (!tr) {
 			err = -ENOMEM;
 			goto rollback_put;
@@ -1691,6 +1715,9 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
 	for_each_mnode(mnode, link) {
 		bpf_trampoline_multi_attach_init(mnode->trampoline);
 
+		if (progs && progs[i]->aux->tail_call_reachable)
+			mnode->trampoline->flags |= BPF_TRAMP_F_TAIL_CALL_CTX;
+
 		data->entry = &mnode->entry;
 		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
 						 &trampoline_multi_ops, data);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index add3affc5703..887d5f654a3a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19291,22 +19291,24 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			return -EOPNOTSUPP;
 		}
 
-		/*
-		 * *.multi programs don't need an address during program
-		 * verification, we just take the module ref if needed.
-		 */
-		if (is_tracing_multi_id(prog, btf_id)) {
+		if (tgt_prog) {
+			if (subprog == 0)
+				addr = (long) tgt_prog->bpf_func;
+			else
+				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
+		} else if (is_tracing_multi_id(prog, btf_id)) {
+			/*
+			 * *.multi programs don't need an address during program
+			 * verification, we just take the module ref if needed.
+			 * *.multi programs don't have tgt_prog during program
+			 * verification.
+			 */
 			if (btf_is_module(btf)) {
 				mod = btf_try_get_module(btf);
 				if (!mod)
 					return -ENOENT;
 			}
 			addr = 0;
-		} else if (tgt_prog) {
-			if (subprog == 0)
-				addr = (long) tgt_prog->bpf_func;
-			else
-				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
 		} else {
 			if (btf_is_module(btf)) {
 				mod = btf_try_get_module(btf);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 891897f8a1b3..a805a5b73303 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3682,12 +3682,15 @@ __bpf_kfunc_end_defs();
 #if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
     defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)
 
+static void bpf_put_progs(struct bpf_prog **progs, int cnt);
+
 static void bpf_tracing_multi_link_release(struct bpf_link *link)
 {
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
 	WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
+	bpf_put_progs(tr_link->progs, tr_link->nodes_cnt);
 }
 
 static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
@@ -3695,6 +3698,7 @@ static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_tracing_multi_link *tr_link =
 		container_of(link, struct bpf_tracing_multi_link, link);
 
+	kvfree(tr_link->progs);
 	kvfree(tr_link->fexits);
 	kvfree(tr_link->cookies);
 	kvfree(tr_link);
@@ -3790,64 +3794,128 @@ static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
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
 
-	ids     = data[0];
-	cookies = data[1];
+	keys    = data->keys;
+	ids     = data->ids;
+	cookies = data->cookies;
+	id_a    = ids + (key_a - keys);
+	id_b    = ids + (key_b - keys);
+
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
+
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
 
-	for (int i = 1; i < cnt; i++) {
-		if (ids[i] == ids[i - 1]) {
+		if (is_tracing_multi(prog->expected_attach_type)) {
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
 
@@ -3867,6 +3935,32 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
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
+
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
+	}
+
 	ucookies = u64_to_user_ptr(attr->link_create.tracing_multi.cookies);
 	if (ucookies) {
 		cookies = kvmalloc_objs(*cookies, cnt);
@@ -3880,7 +3974,16 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
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
 
@@ -3908,19 +4011,27 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	link->nodes_cnt = cnt;
 	link->cookies = cookies;
 	link->fexits = fexits;
+	link->progs = progs;
 
-	err = bpf_trampoline_multi_attach(prog, ids, link);
+	err = bpf_trampoline_multi_attach(prog, ids, keys, progs, link);
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
 	kvfree(link);
 	return err;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ffd96e8b920b..6fa93a6ff54f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1888,6 +1888,8 @@ union bpf_attr {
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

