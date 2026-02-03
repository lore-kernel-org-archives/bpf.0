Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CB3396D1A;
	Tue,  3 Feb 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111580; cv=none; b=PuxpYEcA7RaIzFBqyFy/regHWevffzVTJu6AzuoftFlibxyKNbgUnPB9JFGNBJQwqZnaDDphGdmwr/vlEVi+NtUaox9hOii+eN0zUX/Sa6MtTK2LySrW/Y7DvSUGcYt9xqPQq/jzyDFRu2JMwGqPJtkJwO1HKmGpsZiiPgEMe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111580; c=relaxed/simple;
	bh=FtoeEcteVNzDJvyYgxX2Yo8pZa69Lzz4VqoIcietf4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvRhyx49PbStaGsXEYmVKUpCwn6bX9q1ps+tL76Ulkdyp+va6rnT1ZBVNI0Shi6gU+m1Al3uEfC2rrMCXPRghQKqdk09Ii/uEAjuHEcx17XiACHWJyMvAopDvP6Ma/vAe8T0ijBvWOWqQe9d/AKW6sVWSQ/ZnAG49zDE8fxN0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/N9Z8hR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/N9Z8hR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AAEC116D0;
	Tue,  3 Feb 2026 09:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111580;
	bh=FtoeEcteVNzDJvyYgxX2Yo8pZa69Lzz4VqoIcietf4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/N9Z8hRSPlBC9nInybGPvtCUJsvVsje8e2uCOnwmxfuogsMcXpr/LLbn+RrUoL6A
	 KnQT1I9VPqM6hOVLKlqJNn3IDPljiB6z8g9HSjh3bogNXwvFCQ+Obbxc2xbM4n4Rt0
	 guE5dFuqj62lcG6hD0UJvJ5SwGMGjhSDZ5V3U/lPVlOmvec9y+WatdmN93J5Y7DKDh
	 zowtLXlBu5NbgaWOPIEIT8XIpvwN1jxrQxjgT20fGMhp69DA6/oQ4mPDla/gXEeDCH
	 7fddsgYngPth1Y9Do0f79VzUEBtoSY0BqZTlb6SNvIKK0COoFCwrT/TRiP+OyVlB6V
	 ww8LO6SMXuviQ==
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
Subject: [RFC bpf-next 07/12] bpf: Add support to create tracing multi link
Date: Tue,  3 Feb 2026 10:38:14 +0100
Message-ID: <20260203093819.2105105-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203093819.2105105-1-jolsa@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
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
      __aligned_u64   btf_ids;        /* addresses to attach */
      __u32           btf_ids_cnt;    /* addresses count */
  } tracing_multi;

Each BTF ID represents function (BTF_KIND_FUNC) that the link will
attach bpf program to.

We use previously added bpf_trampoline_multi_attach/detach functions
to attach/detach the link.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/trace_events.h   |   6 ++
 include/uapi/linux/bpf.h       |   5 ++
 kernel/bpf/syscall.c           |   2 +
 kernel/trace/bpf_trace.c       | 105 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |   5 ++
 5 files changed, 123 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3690221ba3d8..6ea2f30728de 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -778,6 +778,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    unsigned long *missed);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -830,6 +831,11 @@ bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
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
index 68600972a778..010785246576 100644
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
+				__aligned_u64	btf_ids;	/* addresses to attach */
+				__u32		btf_ids_cnt;	/* addresses count */
+			} tracing_multi;
 		};
 	} link_create;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2f8932addf96..39217c96e1df 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5743,6 +5743,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_iter_link_attach(attr, uattr, prog);
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
 			ret = cgroup_bpf_link_attach(attr, prog);
+		else if (is_tracing_multi(prog->expected_attach_type))
+			ret = bpf_tracing_multi_attach(prog, attr);
 		else
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f7baeb8278ca..82e625aa04e8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3593,3 +3593,108 @@ __bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, u64
 }
 
 __bpf_kfunc_end_defs();
+
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)
+
+static void bpf_tracing_multi_link_release(struct bpf_link *link)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+
+	bpf_trampoline_multi_detach(link->prog, tr_link);
+}
+
+static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+
+	kfree(tr_link);
+}
+
+static void bpf_tracing_multi_link_show_fdinfo(const struct bpf_link *link,
+					       struct seq_file *seq)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+
+	seq_printf(seq, "attach_type:\t%d\n", tr_link->attach_type);
+}
+
+static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
+						 struct bpf_link_info *info)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link);
+
+	info->tracing.attach_type = tr_link->attach_type;
+	return 0;
+}
+
+static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
+	.release = bpf_tracing_multi_link_release,
+	.dealloc = bpf_tracing_multi_link_dealloc,
+	.show_fdinfo = bpf_tracing_multi_link_show_fdinfo,
+	.fill_link_info = bpf_tracing_multi_link_fill_link_info,
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
+	uids = u64_to_user_ptr(attr->link_create.tracing_multi.btf_ids);
+	cnt = attr->link_create.tracing_multi.btf_ids_cnt;
+
+	if (!cnt || !uids)
+		return -EINVAL;
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
+	link = kzalloc(struct_size(link, nodes, cnt), GFP_KERNEL);
+	if (!link) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	link->nodes_cnt = cnt;
+
+	bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING_MULTI,
+		      &bpf_tracing_multi_link_lops, prog, prog->expected_attach_type);
+
+	err = bpf_link_prime(&link->link, &link_primer);
+	if (err)
+		goto error;
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
+	kfree(link);
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
index 61f0fe5bc0aa..f54e830d9aae 100644
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
+				__aligned_u64	btf_ids;	/* addresses to attach */
+				__u32		btf_ids_cnt;	/* addresses count */
+			} tracing_multi;
 		};
 	} link_create;
 
-- 
2.52.0

