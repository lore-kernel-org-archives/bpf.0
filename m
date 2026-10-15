Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619B3E92BB
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036931; cv=none; b=AbqCB1vq03CE4aDjlH67uwNsefkJ/i5FhtpBPd0l47Plx0G8aMq0FU2yN9815naDPBB8kohU6h7tTgtaDdo+jo3brtHnL3hupn8EugQZ8mW/acA4tYv/3kQtlpFVIQ9O1MH/yV5PV6iZFNtXNDuiuRElPtk12UfOtg5zOXqWL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036931; c=relaxed/simple;
	bh=cvA4In2JSWRXz5Ot4X9dh2GaQ0gTfMX0Io15lST8GEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRDpTOcNInyGE4brWyPf9pvyH4dqj2VH8GxsxEsWpONqE0IB9zbxL+BEewmUX3tZRw/lH+oEZnvinQAn0ZIX8dqDbMJ6baa8oo9tsDSkASvihTl9LdAmbnF2xb72vZi7/qPLcBNqYshCbC6J0Kx8pgy5O+L4pi/5Ri49Q0nodVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0A5E731498D96E; Wed, 14 Oct 2026 21:01:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v11 02/26] bpf: Accept the compiler's exception cleanup table at program load
Date: Wed, 14 Oct 2026 21:01:54 -0700
Message-ID: <20261015040154.855130-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015040143.854070-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM 23 added exception handling for BPF with the .bpf_cleanup section
[1]: Rust code compiled with panic=3Dunwind runs cleanup code (Drop glue)
when an unwind passes through, and the BPF backend emits the section
from the landing pads. rustc does not fully support BPF exception
handling yet, and C can produce the section only with inline asm, which
is enough to test it.

Add the UAPI to carry the table to BPF_PROG_LOAD: cleanup_info,
cleanup_info_cnt and cleanup_info_rec_size. A record, struct
bpf_cleanup_info, says that calls in [begin_off, end_off) that unwind
resume at landing_pad_off, all instruction indices.

bpf_exc_check_info() checks the table at load time: records sorted by
begin_off, with non-empty and disjoint ranges, each inside one subprog,
no landing pad inside any range, and no offset naming the second half of
an ld_imm64. A record longer than the kernel's is taken only if the rest
is zero, and, unlike func_info, no size is written back for the loader
to zero the rest and retry: a field the kernel does not know could change
what a pad does. Nothing reads the table yet.

Link: https://github.com/llvm/llvm-project/pull/192164 [1]
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h   |   2 +
 include/uapi/linux/bpf.h       |  14 ++++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/exception.c         | 137 +++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h         |  15 ++++
 kernel/bpf/syscall.c           |   2 +-
 kernel/bpf/verifier.c          |   6 ++
 tools/include/uapi/linux/bpf.h |  14 ++++
 8 files changed, 190 insertions(+), 2 deletions(-)
 create mode 100644 kernel/bpf/exception.c
 create mode 100644 kernel/bpf/exception.h

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 112ca1511da4..11cd90d85bad 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1135,6 +1135,8 @@ struct bpf_verifier_env {
 	struct spill_snapshot **callsite_at_stack;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
+	struct bpf_cleanup_info *cleanup_info;
+	u32 cleanup_info_cnt;
 	/* number of instructions analyzed by the verifier */
 	u32 prev_insn_processed, insn_processed;
 	/* number of jmps, calls, exits analyzed so far */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6f70db7515dd..9d7439c96e52 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1708,6 +1708,9 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
+		__aligned_u64	cleanup_info;	/* exception cleanup table */
+		__u32		cleanup_info_rec_size; /* userspace bpf_cleanup_info size */
+		__u32		cleanup_info_cnt; /* number of bpf_cleanup_info records */
 	};
=20
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -7669,6 +7672,17 @@ struct bpf_line_info {
 	__u32	line_col;
 };
=20
+/*
+ * One record of an exception cleanup table: calls in [begin_off, end_of=
f)
+ * that unwind resume at landing_pad_off. All three are instruction offs=
ets
+ * in the program as loaded.
+ */
+struct bpf_cleanup_info {
+	__u32	begin_off;
+	__u32	end_off;
+	__u32	landing_pad_off;
+};
+
 struct bpf_spin_lock {
 	__u32	val;
 };
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 269810b128c4..df71ec19d0a0 100644
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
index 000000000000..ac3b575f935e
--- /dev/null
+++ b/kernel/bpf/exception.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/slab.h>
+#include "exception.h"
+
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
+
+#define MIN_BPF_CLEANUP_INFO_SIZE	12
+#define MAX_CLEANUP_INFO_REC_SIZE	252	/* as MAX_FUNCINFO_REC_SIZE */
+
+int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_att=
r *attr,
+		       bpfptr_t uattr)
+{
+	u32 krec_size =3D sizeof(struct bpf_cleanup_info);
+	u32 i, nrec, urec_size, min_size, prev_end =3D 0;
+	struct bpf_cleanup_info *krecord;
+	bpfptr_t urecord;
+	int ret =3D -EINVAL;
+
+	nrec =3D attr->cleanup_info_cnt;
+	if (!nrec)
+		return 0;
+	if (nrec > env->prog->len) {
+		verbose(env, "cleanup info has %u records for %u instructions\n",
+			nrec, env->prog->len);
+		return -EINVAL;
+	}
+
+	urec_size =3D attr->cleanup_info_rec_size;
+	if (urec_size < MIN_BPF_CLEANUP_INFO_SIZE ||
+	    urec_size > MAX_CLEANUP_INFO_REC_SIZE ||
+	    urec_size % sizeof(u32)) {
+		verbose(env, "invalid cleanup info rec size %u\n", urec_size);
+		return -EINVAL;
+	}
+
+	krecord =3D kvcalloc(nrec, krec_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN=
);
+	if (!krecord)
+		return -ENOMEM;
+
+	min_size =3D min_t(u32, krec_size, urec_size);
+	urecord =3D make_bpfptr(attr->cleanup_info, uattr.is_kernel);
+	for (i =3D 0; i < nrec; i++) {
+		struct bpf_subprog_info *sb, *se, *sl;
+		struct bpf_cleanup_info *rec =3D &krecord[i];
+
+		/*
+		 * A record longer than the kernel's is taken only if the rest
+		 * is zero. Unlike func_info, no size is handed back for the
+		 * loader to zero the rest and retry: a field this kernel does
+		 * not know could change what a pad does.
+		 */
+		ret =3D bpf_check_uarg_tail_zero(urecord, krec_size, urec_size);
+		if (ret) {
+			if (ret =3D=3D -E2BIG)
+				verbose(env, "nonzero tailing record in cleanup info\n");
+			goto err_free;
+		}
+
+		if (copy_from_bpfptr(rec, urecord, min_size)) {
+			ret =3D -EFAULT;
+			goto err_free;
+		}
+		bpfptr_add(&urecord, urec_size);
+
+		ret =3D -EINVAL;
+		if (rec->begin_off >=3D rec->end_off) {
+			verbose(env, "cleanup_info[%u]: begin %u >=3D end %u\n",
+				i, rec->begin_off, rec->end_off);
+			goto err_free;
+		}
+		if (rec->begin_off < prev_end) {
+			verbose(env,
+				"cleanup_info[%u]: range [%u,%u) is unsorted or overlaps the previou=
s record\n",
+				i, rec->begin_off, rec->end_off);
+			goto err_free;
+		}
+		prev_end =3D rec->end_off;
+
+		sb =3D bpf_find_containing_subprog(env, rec->begin_off);
+		se =3D bpf_find_containing_subprog(env, rec->end_off - 1);
+		sl =3D bpf_find_containing_subprog(env, rec->landing_pad_off);
+		if (!sb || !se || !sl) {
+			verbose(env, "cleanup_info[%u]: offset out of range\n", i);
+			goto err_free;
+		}
+		if (sb !=3D se || sb !=3D sl) {
+			verbose(env,
+				"cleanup_info[%u]: range/landing pad span multiple subprogs\n",
+				i);
+			goto err_free;
+		}
+		/*
+		 * A zero opcode is the second half of a 16-byte insn, not an
+		 * insn. end_off is exclusive, so it may be one past the last.
+		 */
+		if (!env->prog->insnsi[rec->begin_off].code ||
+		    !env->prog->insnsi[rec->landing_pad_off].code ||
+		    (rec->end_off < env->prog->len &&
+		     !env->prog->insnsi[rec->end_off].code)) {
+			verbose(env, "cleanup_info[%u]: points at invalid insn\n", i);
+			goto err_free;
+		}
+	}
+
+	/* Reject a landing pad inside any call-site range, its own included. *=
/
+	ret =3D -EINVAL;
+	for (i =3D 0; i < nrec; i++) {
+		u32 pad =3D krecord[i].landing_pad_off;
+		u32 l =3D 0, r =3D nrec;
+
+		while (l < r) {
+			u32 m =3D l + (r - l) / 2;
+
+			if (pad < krecord[m].begin_off) {
+				r =3D m;
+			} else if (pad >=3D krecord[m].end_off) {
+				l =3D m + 1;
+			} else {
+				verbose(env,
+					"cleanup_info[%u]: landing pad %u is inside the call-site range of =
cleanup_info[%u]\n",
+					i, pad, m);
+				goto err_free;
+			}
+		}
+	}
+
+	env->cleanup_info =3D krecord;
+	env->cleanup_info_cnt =3D nrec;
+	return 0;
+
+err_free:
+	kvfree(krecord);
+	return ret;
+}
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
new file mode 100644
index 000000000000..cf099dcc5b74
--- /dev/null
+++ b/kernel/bpf/exception.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#ifndef __BPF_EXCEPTION_H
+#define __BPF_EXCEPTION_H
+
+#include <linux/bpfptr.h>
+#include <linux/types.h>
+
+union bpf_attr;
+struct bpf_verifier_env;
+
+int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_att=
r *attr,
+		       bpfptr_t uattr);
+
+#endif /* __BPF_EXCEPTION_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 654f896af265..10e0a693a06d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2948,7 +2948,7 @@ int __init __used bpf_multi_func(void) { return 0; =
}
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
=20
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_PROG_LOAD_LAST_FIELD keyring_id
+#define BPF_PROG_LOAD_LAST_FIELD cleanup_info_cnt
=20
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bp=
f_log_attr *attr_log)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec136cf377c1..b568f5b29cc6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -39,6 +39,7 @@
=20
 #include "diagnostics.h"
 #include "disasm.h"
+#include "exception.h"
=20
 static const struct bpf_verifier_ops * const bpf_verifier_ops[] =3D {
 #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type) \
@@ -23404,6 +23405,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
=20
+	ret =3D bpf_exc_check_info(env, attr, uattr);
+	if (ret < 0)
+		goto skip_full_check;
+
 	/* Validate instructions and resolve the program's referenced resources=
. */
 	ret =3D check_and_resolve_insns(env);
 	if (ret < 0)
@@ -23647,6 +23652,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
 	kvfree(env->func_ptrs);
 	bpf_diag_free(env);
 	kvfree(env->idoms);
+	kvfree(env->cleanup_info);
 	kvfree(env);
 	return ret;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 6f70db7515dd..9d7439c96e52 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1708,6 +1708,9 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
+		__aligned_u64	cleanup_info;	/* exception cleanup table */
+		__u32		cleanup_info_rec_size; /* userspace bpf_cleanup_info size */
+		__u32		cleanup_info_cnt; /* number of bpf_cleanup_info records */
 	};
=20
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -7669,6 +7672,17 @@ struct bpf_line_info {
 	__u32	line_col;
 };
=20
+/*
+ * One record of an exception cleanup table: calls in [begin_off, end_of=
f)
+ * that unwind resume at landing_pad_off. All three are instruction offs=
ets
+ * in the program as loaded.
+ */
+struct bpf_cleanup_info {
+	__u32	begin_off;
+	__u32	end_off;
+	__u32	landing_pad_off;
+};
+
 struct bpf_spin_lock {
 	__u32	val;
 };
--=20
2.53.0-Meta

