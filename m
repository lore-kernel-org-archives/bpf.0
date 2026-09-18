Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068A3E3DAB
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 04:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789706546; cv=none; b=SU2EjXPClvxxO/u/Yciks5IoOS5RupEIXDoHSrimoavQGh5Y3al93vvSEKJgTkXzsaOVSGRuPmF1W1M7++igly368tQ5nyuTviYsOAFKamyEF31cZFkBnywwknJNbnOWRMFbyG9ZaHWx8+/KELAeFbsk5BfNsqpXn9F5QTNNJNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789706546; c=relaxed/simple;
	bh=lSgb5A/kXTfd9r0IzLJOMrsQNX7YJePUBHhW2efB4zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlA4+RDVWppbQxfnAi9khv8+cg6p36oYxxfWsNVx6CKjzrjbQY7WhfO318InlECwhFun0dWxllYOh7B/h0XUFS5DzSfAzVxRtP8HBxzjywV0gZIXy13aJerT0+mcMMivWveKYmMlt1LSFHRbj/63+rNcXEGqlUBPUxCKfmc2mxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 58CE32B7C4C00C; Thu, 17 Sep 2026 21:42:11 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 03/20] bpf: Add lookups for exception cleanup resumes and landing pads
Date: Thu, 17 Sep 2026 21:42:11 -0700
Message-ID: <20260918044211.3286855-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918044156.3283973-1-yonghong.song@linux.dev>
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add two new files, exception.h and exception.c, to host the exception
handling code. Only a few helpers so far: recognising a call to
bpf_unwind_resume(), and asking which landing pad, if any, a call site
unwinds to.

The pad of a call site is kept in insn_aux_data, so the two places that
move instructions around -- bpf_patch_insn_data() and
verifier_remove_insns() -- learn to keep it in step. Nothing sets the mar=
k
yet; the next patch does.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  6 ++++++
 kernel/bpf/Makefile          |  2 +-
 kernel/bpf/exception.c       | 36 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       | 12 ++++++++++++
 kernel/bpf/fixups.c          | 17 +++++++++++++++++
 5 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/exception.c
 create mode 100644 kernel/bpf/exception.h

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c08505b9ba82..f9bccd3e0f4d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -681,6 +681,11 @@ struct bpf_insn_aux_data {
 	bool needs_zext; /* alu op needs to clear upper bits */
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable co=
ntext */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
+	/*
+	 * 1 + the instruction index of the exception cleanup landing pad this
+	 * call site unwinds to, or 0 for none.
+	 */
+	u32 cleanup_pad;
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog perc=
pu alloc */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
@@ -1518,6 +1523,7 @@ u32 btf_func_arg_align(const struct btf *btf, const=
 struct btf_type *t);
=20
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
+bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn);
 int bpf_compute_const_regs(struct bpf_verifier_env *env);
 int bpf_prune_dead_branches(struct bpf_verifier_env *env);
 int bpf_check_cfg(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 9a92c348bbda..af9bc60428ad 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_iter.o map_iter.o ta=
sk_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) +=3D fixups.o cfg.o states.o backtrack.o check=
_btf.o
+obj-$(CONFIG_BPF_SYSCALL) +=3D fixups.o cfg.o states.o backtrack.o check=
_btf.o exception.o
 obj-${CONFIG_BPF_LSM}	  +=3D bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) +=3D trampoline.o
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
new file mode 100644
index 000000000000..3895b9453639
--- /dev/null
+++ b/kernel/bpf/exception.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+#include <linux/slab.h>
+#include "exception.h"
+
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
+
+enum exc_kfunc {
+	EXC_KF_bpf_unwind_resume,
+};
+
+BTF_ID_LIST(exc_kfunc_list)
+BTF_ID(func, bpf_unwind_resume)
+
+static bool insn_is_exc_kfunc(const struct bpf_insn *insn, int kf)
+{
+	return bpf_pseudo_kfunc_call(insn) && insn->off =3D=3D 0 &&
+	       insn->imm =3D=3D exc_kfunc_list[kf];
+}
+
+bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn)
+{
+	return insn_is_exc_kfunc(insn, EXC_KF_bpf_unwind_resume);
+}
+
+int bpf_cleanup_pad_of_call(struct bpf_verifier_env *env, u32 idx)
+{
+	u32 pad =3D env->insn_aux_data[idx].cleanup_pad;
+
+	return pad ? (int)pad - 1 : -1;
+}
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
new file mode 100644
index 000000000000..0f2b9624a2ce
--- /dev/null
+++ b/kernel/bpf/exception.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#ifndef _LINUX_BPF_EXCEPTION_H
+#define _LINUX_BPF_EXCEPTION_H
+
+#include <linux/types.h>
+
+struct bpf_verifier_env;
+
+int bpf_cleanup_pad_of_call(struct bpf_verifier_env *env, u32 idx);
+
+#endif /* _LINUX_BPF_EXCEPTION_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 2add8001c3ec..82b00fac6bd6 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -261,6 +261,11 @@ static void adjust_insn_aux_data(struct bpf_verifier=
_env *env,
 		}
 	}
=20
+	if (env->cleanup_info_cnt)
+		for (i =3D 0; i < prog_len; i++)
+			if (data[i].cleanup_pad > off + 1)
+				data[i].cleanup_pad +=3D cnt - 1;
+
 	/*
 	 * Last slot instruction could be a newly generated
 	 * BPF_ST/BPF_LDX/BPF_STX, systematically mark it for non-stack access
@@ -549,6 +554,7 @@ static int verifier_remove_insns(struct bpf_verifier_=
env *env, u32 off, u32 cnt)
 	struct bpf_insn_aux_data *aux_data =3D env->insn_aux_data;
 	unsigned int orig_prog_len =3D env->prog->len;
 	int err;
+	u32 i;
=20
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		bpf_prog_offload_remove_insns(env, off, cnt);
@@ -573,6 +579,17 @@ static int verifier_remove_insns(struct bpf_verifier=
_env *env, u32 off, u32 cnt)
 		sizeof(*aux_data) * (orig_prog_len - off - cnt));
 	env->insn_aux_data_len -=3D cnt;
=20
+	if (env->cleanup_info_cnt) {
+		for (i =3D 0; i < env->insn_aux_data_len; i++) {
+			u32 pad =3D aux_data[i].cleanup_pad;
+
+			if (pad > off + cnt)
+				aux_data[i].cleanup_pad =3D pad - cnt;
+			else if (pad > off)
+				aux_data[i].cleanup_pad =3D 0;
+		}
+	}
+
 	return 0;
 }
=20
--=20
2.53.0-Meta

