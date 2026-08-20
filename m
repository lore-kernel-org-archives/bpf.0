Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16247481B1;
	Thu, 20 Aug 2026 05:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203224; cv=none; b=WRieLPQ2QyQWhi+SHIvMHbWQR8RCts5GmgHJnCifJJgIBxKiPtMX3/u+fAyHMXvkrj0fErb+KqcjtvcIh/RujYljyE7itxTAtVeVAg0ejM7OJLrmhehxGEEWcaJ8RgjRRthfbFx2Ltz/gvUIFLk2wVzUL9JogRHcBfeBH0wf6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203224; c=relaxed/simple;
	bh=m9D/HmIKu2w3+AnPOjYE0hFdp24SHi9mU4PniPoqmFA=;
	h=Date:Message-ID:From:To:Cc:Subject; b=E93i2N3RsUxKIMOmbAfh1C5XQ9iIUQZKipamtgC6DTraGsnqo6/cx6hrMNBXsJwzzw8fKRC0mlxVYPt0J80PC5pNumNbH+SSr+VBu+7I2h0ijD1zB+Ui8X7hT0YdG9qn6qkDs07WMGou/DYUDa65m+qhsZkk0Dkgvxkub2TK/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTiM0aEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTiM0aEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F6F1F000E9;
	Thu, 20 Aug 2026 05:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787203222;
	bh=DZfBtUsbi/HyiDVjWdSkKSDR9yp2oJWNUC9FSkzF5mo=;
	h=Date:From:To:Cc:Subject;
	b=NTiM0aEdcM8/R/J4BnTPmtRuUkMa2/ZQUSFyRVofJCTVWoa6Hxv1J6CQwgGQkplVe
	 K4w8E+Dua1+ehcw3TFYjgzU/b8sCs15jAhndKdlt0lkduW4iTnfw7catYAWQQ9tu/i
	 srgIdtzEjYYlDw1aO77qwqsP5G8ybYy39cYO8MGDSHjoYWa4Nhju4PoK8gVhwEbmGZ
	 uosFc/uVHg+Z+n4LJCRsUGBap1U4JEDEB0g1BfKnBijkT1fl6c184gf6R4d5KPzmAH
	 L5qSo7SKhwmMe0wnuXMSnE7dWORmAyogUStKZBm33WDzYf47056OAsXjH96kIRm/pz
	 VjzLNDJjkUe5A==
Date: Wed, 19 Aug 2026 19:20:21 -1000
Message-ID: <95d7ccc17681aa3a4a2eeb1b073f00f7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: sched_ext: Mark ops argument container
 pointer fields as trusted
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Walking an unannotated pointer field of a trusted struct yields a bare
PTR_TO_BTF_ID in non-sleepable programs, which kfuncs and helpers accept,
but PTR_UNTRUSTED in sleepable programs, which they reject. This gets in the
way of making ops.init_task() sleepable, which schedulers want for
allocations. For example, passing args->cgroup into bpf_cgrp_storage_get()
then fails verification and the only recourse is round-tripping through the
cgroup ID with bpf_cgroup_from_id().

The pointer fields in the sched_ext ops argument containers are all pinned
by the callers for the duration of the ops calls and are never NULL. Add
them to the verifier's trusted-fields whitelist so that they are PTR_TRUSTED
in both sleepable and non-sleepable programs.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/bpf/verifier.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5661,6 +5661,28 @@ BTF_TYPE_SAFE_TRUSTED(struct file) {
 	struct inode *f_inode;
 };
 
+/*
+ * The pointer fields in the sched_ext ops argument containers are pinned by the
+ * callers for the duration of the ops calls and are never NULL.
+ */
+BTF_TYPE_SAFE_TRUSTED(struct scx_init_task_args) {
+#ifdef CONFIG_EXT_GROUP_SCHED
+	struct cgroup *cgroup;
+#endif
+};
+
+BTF_TYPE_SAFE_TRUSTED(struct scx_cpu_release_args) {
+	struct task_struct *task;
+};
+
+BTF_TYPE_SAFE_TRUSTED(struct scx_sub_attach_args) {
+	struct sched_ext_ops *ops;
+};
+
+BTF_TYPE_SAFE_TRUSTED(struct scx_sub_detach_args) {
+	struct sched_ext_ops *ops;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
@@ -5705,6 +5727,10 @@ static bool type_is_trusted(struct bpf_v
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_init_task_args));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_cpu_release_args));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_sub_attach_args));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_sub_detach_args));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
