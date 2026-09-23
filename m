Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179E3DDB1D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139566; cv=none; b=ZNCfjXpF85PQcbaEzFL6BIeKrhxIX+q2Frmub6AnHjHmOXuUUWTm/oJtD7jiXOLoSmAejjgUCkX+ua2vSWffVEj9srkRLonsZdHsn7ftLfAQiSyGfB1pU652srrAmTkzWILC3V3MEaSwj51HSz8GAOZqXHmOI9N3+tRZEshZD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139566; c=relaxed/simple;
	bh=i1j5Bq25zMkpOkxmXeJ9Ua/lVkOueT/sOSuudbJlEg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxPUFHoq5sJtz9Y4FfGbc0w1G2mpvAUTAEoZxYwvpTW3M7CkzRWEzIHFbJpgSkUcs9xWwqIv+2ODULdozUajti3B+FXvt3/kJJxTt+ohQnqcMyar89e2G0Q+zCPHfGy+DtScYoLgLxVlQqfRpYuWpt8xXtRUoFXy+NJyidVV7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id F36DA2C8DA16D2; Tue, 22 Sep 2026 21:59:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 04/21] bpf: Add lookups for exception cleanup resumes and landing pads
Date: Tue, 22 Sep 2026 21:59:06 -0700
Message-ID: <20260923045906.2416312-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
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
verifier_remove_insns() -- learn to keep it in step.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  6 ++++++
 kernel/bpf/Makefile          |  2 +-
 kernel/bpf/exception.c       | 23 +++++++++++++++++++++++
 kernel/bpf/exception.h       | 12 ++++++++++++
 kernel/bpf/fixups.c          | 26 +++++++++++++++++++++++++-
 5 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 kernel/bpf/exception.c
 create mode 100644 kernel/bpf/exception.h

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2b6b480c059e..666c73308b32 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -710,6 +710,11 @@ struct bpf_insn_aux_data {
 	u64 jump_target:1;
=20
 	unsigned int orig_idx; /* original instruction index, initialized once =
*/
+	/*
+	 * 1 + the instruction index of the exception cleanup landing pad
+	 * this call site unwinds to, or 0 for none.
+	 */
+	u32 cleanup_pad;
 	/*
 	 * CFG strongly connected component this instruction belongs to,
 	 * zero if it is a singleton SCC.
@@ -1519,6 +1524,7 @@ u32 btf_func_arg_align(const struct btf *btf, const=
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
index 000000000000..6989f31aa6c9
--- /dev/null
+++ b/kernel/bpf/exception.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+#include "exception.h"
+
+BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
+
+bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn)
+{
+	return bpf_pseudo_kfunc_call(insn) && insn->off =3D=3D 0 &&
+	       insn->imm =3D=3D bpf_unwind_resume_id[0];
+}
+
+int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx)
+{
+	u32 pad =3D env->insn_aux_data[idx].cleanup_pad;
+
+	return pad ? (int)pad - 1 : -1;
+}
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
new file mode 100644
index 000000000000..634cb2c15ffc
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
+int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
+
+#endif /* _LINUX_BPF_EXCEPTION_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 2add8001c3ec..e3459123803c 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -256,11 +256,18 @@ static void adjust_insn_aux_data(struct bpf_verifie=
r_env *env,
 			data[i].non_stack_access =3D
 				data[off + cnt - 1].non_stack_access;
 			data[off + cnt - 1].non_stack_access =3D false;
+			data[i].cleanup_pad =3D data[off + cnt - 1].cleanup_pad;
+			data[off + cnt - 1].cleanup_pad =3D 0;
 		} else if (bpf_is_mem_insn(insn + i)) {
 			data[i].non_stack_access =3D true;
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
@@ -549,6 +556,7 @@ static int verifier_remove_insns(struct bpf_verifier_=
env *env, u32 off, u32 cnt)
 	struct bpf_insn_aux_data *aux_data =3D env->insn_aux_data;
 	unsigned int orig_prog_len =3D env->prog->len;
 	int err;
+	u32 i;
=20
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		bpf_prog_offload_remove_insns(env, off, cnt);
@@ -573,6 +581,17 @@ static int verifier_remove_insns(struct bpf_verifier=
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
@@ -648,7 +667,7 @@ int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 	struct bpf_insn *insn =3D env->prog->insnsi;
 	int insn_cnt =3D env->prog->len;
 	bool is_may_goto_0, is_ja;
-	int i, err;
+	int i, j, err;
=20
 	for (i =3D 0; i < insn_cnt; i++) {
 		is_may_goto_0 =3D !memcmp(&insn[i], &MAY_GOTO_0, sizeof(MAY_GOTO_0));
@@ -657,6 +676,11 @@ int bpf_opt_remove_nops(struct bpf_verifier_env *env=
)
 		if (!is_may_goto_0 && !is_ja)
 			continue;
=20
+		if (env->cleanup_info_cnt)
+			for (j =3D 0; j < insn_cnt; j++)
+				if (env->insn_aux_data[j].cleanup_pad =3D=3D i + 1)
+					env->insn_aux_data[j].cleanup_pad =3D i + 2;
+
 		err =3D verifier_remove_insns(env, i, 1);
 		if (err)
 			return err;
--=20
2.53.0-Meta

