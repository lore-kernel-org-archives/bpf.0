Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB993AC0F6;
	Sat,  6 Jun 2026 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749733; cv=none; b=p/CCObEAMUcZAs0fc59vD0u35bf7O2QnrR+4KwQOZ78oLwY+FBaR9xQXoMy8ZFTYSj/0P1u0uUDNfGHVw675317p/vhcHVuBLctbBh9PryZPKzgzf0pdrDE9aOt7mEoc55GZslpB1VoiwbFFMYAocCqi5HUcXEj4LAvILRdfsX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749733; c=relaxed/simple;
	bh=S4MdqjSQVrN/KYW26CluK4ATWxJawjq3wL6HidsrL84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyKmjDRBFLQGV6YHcyzyyl5oLCjXBp8+Yn+24KEMR8HDe2L70f3fvyr96t02MGjUkg4NIjf+fGkmVJqOVRUBGe7Y81G0EobPCUGy4qDApeYKSN1iqAdBaMmY9hyUu8KoAA14zztniE0futxLpTg30431uVcs4XXeU8hl6dcl02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNM6zfcB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNM6zfcB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C06D1F00893;
	Sat,  6 Jun 2026 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749732;
	bh=S95kpBcBqgLIwh2v3mHRxHeD1gyAU+e8TCiT39+aBP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GNM6zfcBQUhMLcxMwRGeV4xC6tf5cJa6YkJc2tfPSP1+DIHvwA1b0GbKr4Stb6fhI
	 Dw2OWdBA3Yz7XRrTQceRGPzzunLG8IhHhqt7jfxtHagZEy/K3WwYMjc9tcx4zpuywv
	 CfTlTJm6iWQk1zB2XSGWD9cYA8S5/e+dMFqp0/8f+Y8TMMiQk18c6TzaUDqUOvB/eA
	 QT9H7l8aIMFlhCznTFWr0Qbp+Xh24EwXKf9HYCCVfTnboZSsEgCbw0Y6E4mMHnqc+L
	 c5JFOfvu0ibL+dl1deRSWqxPYjp76/qhIfFMLczw+7JjgdRHty9GzsCPv4o0kGhXwd
	 l/McqJJDqivoQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 13/29] bpf: Add support for tracing multi link
Date: Sat,  6 Jun 2026 14:39:38 +0200
Message-ID: <20260606123955.345967-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding new link to allow to attach program to multiple function
BTF IDs. The link is represented by struct bpf_tracing_multi_link.

To configure the link, new fields are added to bpf_attr::link_create
to pass array of BTF IDs;

  struct {
    __aligned_u64 ids;
    __u32         cnt;
  } tracing_multi;

Each BTF ID represents function (BTF_KIND_FUNC) that the link will
attach bpf program to.

We use previously added bpf_trampoline_multi_attach/detach functions
to attach/detach the link.

The linkinfo/fdinfo callbacks will be implemented in following changes.

Note this is supported only for archs (x86_64) with ftrace direct and
have single ops support.

  CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS &&
  CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS

Note using sort_r (instead of plain sort) in check_dup_ids, because we
will use the swap callback in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf_types.h      |   1 +
 include/linux/trace_events.h   |   6 ++
 include/uapi/linux/bpf.h       |   5 ++
 kernel/bpf/syscall.c           |   2 +
 kernel/trace/bpf_trace.c       | 130 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |   6 ++
 tools/lib/bpf/libbpf.c         |   1 +
 7 files changed, 151 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 56e4c3f983d3..e5906829aa6f 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -156,3 +156,4 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
 BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
 BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
 BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
+BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING_MULTI, tracing_multi)
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d49338c44014..308c76b57d13 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -787,6 +787,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    unsigned long *missed);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -844,6 +845,11 @@ bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
 }
+static inline int
+bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 enum {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 28d127e5040a..9f603731d267 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1182,6 +1182,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_UPROBE_MULTI = 12,
 	BPF_LINK_TYPE_NETKIT = 13,
 	BPF_LINK_TYPE_SOCKMAP = 14,
+	BPF_LINK_TYPE_TRACING_MULTI = 15,
 	__MAX_BPF_LINK_TYPE,
 };
 
@@ -1877,6 +1878,10 @@ union bpf_attr {
 				};
 				__u64		expected_revision;
 			} cgroup;
+			struct {
+				__aligned_u64	ids;
+				__u32		cnt;
+			} tracing_multi;
 		};
 	} link_create;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index efdd6639a598..d551b9da0cfb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5885,6 +5885,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_iter_link_attach(attr, uattr, prog);
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
 			ret = cgroup_bpf_link_attach(attr, prog);
+		else if (is_tracing_multi(prog->expected_attach_type))
+			ret = bpf_tracing_multi_attach(prog, attr);
 		else
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d853f97bd154..9e3cb547651e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -42,6 +42,7 @@
 
 #define MAX_UPROBE_MULTI_CNT (1U << 20)
 #define MAX_KPROBE_MULTI_CNT (1U << 20)
+#define MAX_TRACING_MULTI_CNT (1U << 20)
 
 #ifdef CONFIG_MODULES
 struct bpf_trace_module {
@@ -3641,3 +3642,132 @@ __bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dynptr *dptr
 }
 
 __bpf_kfunc_end_defs();
+
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
+    defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)
+
+static void bpf_tracing_multi_link_release(struct bpf_link *link)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+
+	WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
+}
+
+static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+
+	kvfree(tr_link);
+}
+
+static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
+	.release = bpf_tracing_multi_link_release,
+	.dealloc_deferred = bpf_tracing_multi_link_dealloc,
+};
+
+static int ids_cmp_r(const void *pa, const void *pb, const void *priv __maybe_unused)
+{
+	u32 a = *(u32 *) pa;
+	u32 b = *(u32 *) pb;
+
+	return (a > b) - (a < b);
+}
+
+static void ids_swap_r(void *a, void *b, int size __maybe_unused,
+		       const void *priv __maybe_unused)
+{
+	u32 *id_a = a, *id_b = b;
+
+	swap(*id_a, *id_b);
+}
+
+static int check_dup_ids(u32 *ids, u32 cnt)
+{
+	int err = 0;
+
+	/*
+	 * Sort ids array (together with cookies array if defined)
+	 * and check it for duplicates. The ids and cookies arrays
+	 * are left sorted.
+	 */
+	sort_r_nonatomic(ids, cnt, sizeof(ids[0]), ids_cmp_r, ids_swap_r, NULL);
+
+	for (int i = 1; i < cnt; i++) {
+		if (ids[i] == ids[i - 1]) {
+			err = -EINVAL;
+			break;
+		}
+	}
+	return err;
+}
+
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+{
+	struct bpf_tracing_multi_link *link = NULL;
+	struct bpf_link_primer link_primer;
+	u32 cnt, *ids = NULL;
+	u32 __user *uids;
+	int err;
+
+	uids = u64_to_user_ptr(attr->link_create.tracing_multi.ids);
+	cnt = attr->link_create.tracing_multi.cnt;
+
+	if (!cnt || !uids)
+		return -EINVAL;
+	if (cnt > MAX_TRACING_MULTI_CNT)
+		return -E2BIG;
+	if (attr->link_create.flags || attr->link_create.target_fd)
+		return -EINVAL;
+
+	ids = kvmalloc_objs(*ids, cnt);
+	if (!ids)
+		return -ENOMEM;
+
+	if (copy_from_user(ids, uids, cnt * sizeof(*ids))) {
+		err = -EFAULT;
+		goto error;
+	}
+
+	err = check_dup_ids(ids, cnt);
+	if (err)
+		goto error;
+
+	link = kvzalloc_flex(*link, nodes, cnt);
+	if (!link) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING_MULTI,
+		      &bpf_tracing_multi_link_lops, prog, prog->expected_attach_type);
+
+	err = bpf_link_prime(&link->link, &link_primer);
+	if (err)
+		goto error;
+
+	link->nodes_cnt = cnt;
+
+	err = bpf_trampoline_multi_attach(prog, ids, link);
+	kvfree(ids);
+	if (err) {
+		bpf_link_cleanup(&link_primer);
+		return err;
+	}
+	return bpf_link_settle(&link_primer);
+
+error:
+	kvfree(ids);
+	kvfree(link);
+	return err;
+}
+
+#else
+
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS && CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1b9aacf468e5..9f603731d267 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1182,6 +1182,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_UPROBE_MULTI = 12,
 	BPF_LINK_TYPE_NETKIT = 13,
 	BPF_LINK_TYPE_SOCKMAP = 14,
+	BPF_LINK_TYPE_TRACING_MULTI = 15,
 	__MAX_BPF_LINK_TYPE,
 };
 
@@ -1877,6 +1878,10 @@ union bpf_attr {
 				};
 				__u64		expected_revision;
 			} cgroup;
+			struct {
+				__aligned_u64	ids;
+				__u32		cnt;
+			} tracing_multi;
 		};
 	} link_create;
 
@@ -7254,6 +7259,7 @@ enum {
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
 	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
 	SK_BPF_BYPASS_PROT_MEM	= 1010, /* Get or Set sk->sk_bypass_prot_mem */
+
 };
 
 enum {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1b09381d16ff..59405d318624 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -156,6 +156,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_UPROBE_MULTI]		= "uprobe_multi",
 	[BPF_LINK_TYPE_NETKIT]			= "netkit",
 	[BPF_LINK_TYPE_SOCKMAP]			= "sockmap",
+	[BPF_LINK_TYPE_TRACING_MULTI]		= "tracing_multi",
 };
 
 static const char * const map_type_name[] = {
-- 
2.54.0

