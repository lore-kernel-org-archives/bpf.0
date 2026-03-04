Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EF372661;
	Wed,  4 Mar 2026 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663006; cv=none; b=FAF6FhTxaL3tVynEMGycl5EouwE4c4ALT1SsgtFO4wRQPpuGAP1IjIuVOnRqv6WxygbCSWjfdTo8hu5jGZ+N0EZci5LmkZFkdGRAiaT5Ieytwc5CkpR8ZBLHRwRVLsMsKN6Dt0msZnl4cP/7SWFe2xW4VcAESjOO7HogWaXjNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663006; c=relaxed/simple;
	bh=jSNutvuy3gJCiN3hxksnhaXJGd2BRC4KOPVdTTDdc5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxS25Wx9lgplRYv/NhA8UJA/tkfO7qbW9zYcLDn52nK6ttqkX9nR5XxMtgbVWRNqq7vnEpfXb8o15/cGLsizGqdFZBawDs92M/X/iW3MeFb1GxFWTfqNqgOvrmhlrZIIFbEmYoEP7QGjBn06OQslENyZwHpxpYMZiDYKq0ase9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmBGvGQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmBGvGQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FDEC4CEF7;
	Wed,  4 Mar 2026 22:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663005;
	bh=jSNutvuy3gJCiN3hxksnhaXJGd2BRC4KOPVdTTDdc5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HmBGvGQsYL1G892CVc3O/4f9uH9jacqINBSfInMv/bFaZShSiUEEUpYeNWcZCSQ53
	 fuCWWtp3BZQm8v9Gs0TkdWH1XoAMAz4WEXrIV3Ym1hGOiG0BAsBGRNWSyHHLU+9dGT
	 NGwBDoBD66VGPnTjECwphV25eDvnWqwdoqZYz/DA0lmT8i34VzcqSMa7MkamDH6cY5
	 W/R5YfndIm0ouzW4pBYX2EeR62g88lhCwNiakjixsA5N64cyVeQnr+7TQB9GVPJ9AC
	 oHba9U6s5zF+BFp7C49kW8SvRd3QW1+EN8i+CnXXyizZvr4aBxZQraa/Eu2EclJoNx
	 BmAg7mQl28IZw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv2 bpf-next 09/23] bpf: Add support for tracing multi link
Date: Wed,  4 Mar 2026 23:21:27 +0100
Message-ID: <20260304222141.497203-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf_types.h      |  1 +
 include/linux/trace_events.h   |  6 +++
 include/uapi/linux/bpf.h       |  5 ++
 kernel/bpf/syscall.c           |  2 +
 kernel/trace/bpf_trace.c       | 88 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  6 +++
 tools/lib/bpf/libbpf.c         |  1 +
 7 files changed, 109 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index b13de31e163f..96575b5b563e 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -155,3 +155,4 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
 BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
 BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
 BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
+BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING_MULTI, tracing_multi)
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 37eb2f0f3dd8..b6d4c745bdac 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -783,6 +783,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    unsigned long *missed);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -835,6 +836,11 @@ bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
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
index 68600972a778..7f5c51f27a36 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1180,6 +1180,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_UPROBE_MULTI = 12,
 	BPF_LINK_TYPE_NETKIT = 13,
 	BPF_LINK_TYPE_SOCKMAP = 14,
+	BPF_LINK_TYPE_TRACING_MULTI = 15,
 	__MAX_BPF_LINK_TYPE,
 };
 
@@ -1863,6 +1864,10 @@ union bpf_attr {
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
index 2680740e9c09..94c6a9c81ef0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5749,6 +5749,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_iter_link_attach(attr, uattr, prog);
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
 			ret = cgroup_bpf_link_attach(attr, prog);
+		else if (is_tracing_multi(prog->expected_attach_type))
+			ret = bpf_tracing_multi_attach(prog, attr);
 		else
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b040a417442..a18aef19c3b5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -42,6 +42,7 @@
 
 #define MAX_UPROBE_MULTI_CNT (1U << 20)
 #define MAX_KPROBE_MULTI_CNT (1U << 20)
+#define MAX_TRACING_MULTI_CNT (1U << 20)
 
 #ifdef CONFIG_MODULES
 struct bpf_trace_module {
@@ -3594,3 +3595,90 @@ __bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, u64
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
+
+	ids = kvmalloc_array(cnt, sizeof(*ids), GFP_KERNEL);
+	if (!ids)
+		return -ENOMEM;
+
+	if (copy_from_user(ids, uids, cnt * sizeof(*ids))) {
+		err = -EFAULT;
+		goto error;
+	}
+
+	link = kvzalloc(struct_size(link, nodes, cnt), GFP_KERNEL);
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
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 61f0fe5bc0aa..7f5c51f27a36 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1180,6 +1180,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_UPROBE_MULTI = 12,
 	BPF_LINK_TYPE_NETKIT = 13,
 	BPF_LINK_TYPE_SOCKMAP = 14,
+	BPF_LINK_TYPE_TRACING_MULTI = 15,
 	__MAX_BPF_LINK_TYPE,
 };
 
@@ -1863,6 +1864,10 @@ union bpf_attr {
 				};
 				__u64		expected_revision;
 			} cgroup;
+			struct {
+				__aligned_u64	ids;
+				__u32		cnt;
+			} tracing_multi;
 		};
 	} link_create;
 
@@ -7236,6 +7241,7 @@ enum {
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
 	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
 	SK_BPF_BYPASS_PROT_MEM	= 1010, /* Get or Set sk->sk_bypass_prot_mem */
+
 };
 
 enum {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1e19c7b861ec..74e579d7f310 100644
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
2.53.0

