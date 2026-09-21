Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC5F5172CD
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024463; cv=none; b=lM3pfK2xM016ehsmVUjXE8JSloNRmV5rnTF3Y+GqIPVAMQ8YTQzx8yzkH+R9+QJSbjNX+Q+dpi/serP5E60Y4QEZtmov8vK2f69CXQOQAf2ZIx+q3Jz0SVXthVqg0LfKHbhtRdxa7dCVJlF3Rma7gZG17K6/tmwsJa7JfPUHUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024463; c=relaxed/simple;
	bh=zDr7EBz7emOscjCtQREB5iDuWHPpRDWZN4dJ5Y/efNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3KEkJlApwyrJmlzOahxEFwe12uNK3pA0r/egCxNyJU2UOqeLRNVnYU6IxlCNc7HdlhcZAEJaPuvWnUKBQu87T41iMnxOTI/MwPVMy58hpkQItvIF9TG04N2NXJfO1uLMlR7dWLWYW38As2Qus1JKLDFQToiuGYU+4vXIB4TLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9F8722C448A2C8; Mon, 21 Sep 2026 14:00:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 03/20] bpf: Add lookups for exception cleanup resumes and landing pads
Date: Mon, 21 Sep 2026 14:00:48 -0700
Message-ID: <20260921210048.1717268-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921210033.1715000-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
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
 kernel/bpf/exception.c       | 31 +++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       | 12 ++++++++++++
 kernel/bpf/fixups.c          | 26 +++++++++++++++++++++++---
 5 files changed, 73 insertions(+), 4 deletions(-)
 create mode 100644 kernel/bpf/exception.c
 create mode 100644 kernel/bpf/exception.h

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index de2cff5e3eca..325a80ffcbe2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -675,6 +675,11 @@ struct bpf_insn_aux_data {
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt *=
/
+	/*
+	 * 1 + the instruction index of the exception cleanup landing pad this
+	 * call site unwinds to, or 0 for none.
+	 */
+	u32 cleanup_pad;
 	bool nospec; /* do not execute this instruction speculatively */
 	bool nospec_result; /* result is unsafe under speculation, nospec must =
follow */
 	bool zext_dst; /* this insn zero extends dst reg */
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
index 000000000000..4b3ac93e98c1
--- /dev/null
+++ b/kernel/bpf/exception.c
@@ -0,0 +1,31 @@
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
+BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
+
+static bool insn_is_unwind_resume(const struct bpf_insn *insn)
+{
+	return bpf_pseudo_kfunc_call(insn) && insn->off =3D=3D 0 &&
+	       insn->imm =3D=3D bpf_unwind_resume_id[0];
+}
+
+bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn)
+{
+	return insn_is_unwind_resume(insn);
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
index 2add8001c3ec..5e257d5fc0ef 100644
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
@@ -544,11 +551,13 @@ void bpf_clear_insn_aux_data(struct bpf_verifier_en=
v *env, int start, int len)
 	}
 }
=20
-static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, =
u32 cnt)
+static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, =
u32 cnt,
+				 bool falls_through)
 {
 	struct bpf_insn_aux_data *aux_data =3D env->insn_aux_data;
 	unsigned int orig_prog_len =3D env->prog->len;
 	int err;
+	u32 i;
=20
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		bpf_prog_offload_remove_insns(env, off, cnt);
@@ -573,6 +582,17 @@ static int verifier_remove_insns(struct bpf_verifier=
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
+				aux_data[i].cleanup_pad =3D falls_through ? off + 1 : 0;
+		}
+	}
+
 	return 0;
 }
=20
@@ -634,7 +654,7 @@ int bpf_opt_remove_dead_code(struct bpf_verifier_env =
*env)
 		if (!j)
 			continue;
=20
-		err =3D verifier_remove_insns(env, i, j);
+		err =3D verifier_remove_insns(env, i, j, false);
 		if (err)
 			return err;
 		insn_cnt =3D env->prog->len;
@@ -657,7 +677,7 @@ int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 		if (!is_may_goto_0 && !is_ja)
 			continue;
=20
-		err =3D verifier_remove_insns(env, i, 1);
+		err =3D verifier_remove_insns(env, i, 1, true);
 		if (err)
 			return err;
 		insn_cnt--;
--=20
2.53.0-Meta

