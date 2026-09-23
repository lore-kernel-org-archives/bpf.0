Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E7403E97
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139549; cv=none; b=pFQY6/N5UmR63+zXBWpKdtsEdZJ5LuLueoU+oKGeil5S3IU9BVQDbl9450FAopR/mblKjwpkmiqrQH3Qoi0i91CTS0sxQf5WMBQPmJW50Z8jtEpgLdSg664mv7Yo4PqTVs2en+UOxgMhn4Rxof/2IlgE166PLiJHJ8hCT7ZWmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139549; c=relaxed/simple;
	bh=xViHSPQx/yc/Seq/NQFcVJ8dUY3CfKDQ2FjwUcKytwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqMLGVZY8yO5+alY9bOZbDOTmwaTNeRpzgjjnFuZ5n1JECCNnP5LwZI69Ir2fmv6iPrparOUQqBnOHUu0m+EJUK8wmzIvBSfbCt+YDGb5zkiqwErtLqEO5xnfU7Ys4dcpJLa2WwZKyGeknja0bczaWejkjh1Ws/DtBZyiWmiBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BA8722C8DA1670; Tue, 22 Sep 2026 21:58:56 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 02/21] bpf: Accept the compiler's exception cleanup table at program load
Date: Tue, 22 Sep 2026 21:58:56 -0700
Message-ID: <20260923045856.2415318-1-yonghong.song@linux.dev>
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

LLVM 23 added exception handling support for BPF with the .bpf_cleanup
section ([1]). Rust code compiled with panic=3Dunwind runs cleanup code
(Drop glue) when bpf_throw() fires, and the LLVM BPF backend emits that
section from the landing pads the frontend produced. Plain C cannot
generate .bpf_cleanup unless inline asm is used. The Rust compiler does n=
ot
*properly* support BPF exception handling yet, but the kernel can support
the table today, and inline assembly is enough to test it.

Add the UAPI to carry the .bpf_cleanup table into the kernel. BPF_PROG_LO=
AD
grows cleanup_info, cleanup_info_cnt and cleanup_info_rec_size, and struc=
t
bpf_cleanup_info describes one record as a triple of instruction indices:
the half-open call-site range [begin_off, end_off) and the landing_pad_of=
f
the frame resumes at. The table arrives sorted by begin_off, with disjoin=
t
ranges and each record's three offsets inside one subprogram;
check_cleanup_info() holds it to that at load time. Nothing reads it yet;
the patches that follow -- the CFG walk, the unwind walk and the JITs --
are its consumers.

Link: https://github.com/llvm/llvm-project/pull/192164 [1]
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h   |   2 +
 include/uapi/linux/bpf.h       |   9 +++
 kernel/bpf/check_btf.c         | 134 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |   2 +-
 kernel/bpf/verifier.c          |   1 +
 tools/include/uapi/linux/bpf.h |   9 +++
 6 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 15bc61de61ef..2b6b480c059e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -988,6 +988,8 @@ struct bpf_verifier_env {
 	struct arg_track **callsite_at_stack;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
+	struct bpf_cleanup_info *cleanup_info;
+	u32 cleanup_info_cnt;
 	/* number of instructions analyzed by the verifier */
 	u32 prev_insn_processed, insn_processed;
 	/* number of jmps, calls, exits analyzed so far */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0aaa54359aeb..646aa8758d48 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1669,6 +1669,9 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
+		__aligned_u64	cleanup_info;	/* exception cleanup table */
+		__u32		cleanup_info_rec_size; /* userspace bpf_cleanup_info size */
+		__u32		cleanup_info_cnt; /* number of bpf_cleanup_info records */
 	};
=20
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -7599,6 +7602,12 @@ struct bpf_line_info {
 	__u32	line_col;
 };
=20
+struct bpf_cleanup_info {
+	__u32	begin_off;
+	__u32	end_off;
+	__u32	landing_pad_off;
+};
+
 struct bpf_spin_lock {
 	__u32	val;
 };
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 0e8b3ccc7a5b..bc569fa5f97f 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -407,6 +407,136 @@ static int check_core_relo(struct bpf_verifier_env =
*env,
 	return err;
 }
=20
+#define MIN_BPF_CLEANUP_INFO_SIZE	12
+#define MAX_CLEANUP_INFO_REC_SIZE	MAX_FUNCINFO_REC_SIZE
+
+static int check_cleanup_info(struct bpf_verifier_env *env,
+			      const union bpf_attr *attr,
+			      bpfptr_t uattr)
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
+		ret =3D bpf_check_uarg_tail_zero(urecord, krec_size, urec_size);
+		if (ret) {
+			if (ret =3D=3D -E2BIG) {
+				verbose(env, "nonzero tailing record in cleanup info\n");
+				if (copy_to_bpfptr_offset(uattr,
+							  offsetof(union bpf_attr,
+								   cleanup_info_rec_size),
+							  &min_size, sizeof(min_size)))
+					ret =3D -EFAULT;
+			}
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
+		if (i && rec->begin_off < prev_end) {
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
+
 int bpf_prepare_btf_info(struct bpf_verifier_env *env,
 			 const union bpf_attr *attr,
 			 bpfptr_t uattr)
@@ -441,6 +571,10 @@ int bpf_check_btf_info(struct bpf_verifier_env *env,
 {
 	int err;
=20
+	err =3D check_cleanup_info(env, attr, uattr);
+	if (err)
+		return err;
+
 	if (!attr->func_info_cnt && !attr->line_info_cnt) {
 		if (check_abnormal_return(env))
 			return -EINVAL;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 74496fd716d3..63c84a60c1b7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2924,7 +2924,7 @@ int __init __used bpf_multi_func(void) { return 0; =
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
index a7c9e2d8965d..c65103152320 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21999,6 +21999,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
 	bpf_diag_free(env);
+	kvfree(env->cleanup_info);
 	kvfree(env);
 	return ret;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 0aaa54359aeb..646aa8758d48 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1669,6 +1669,9 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
+		__aligned_u64	cleanup_info;	/* exception cleanup table */
+		__u32		cleanup_info_rec_size; /* userspace bpf_cleanup_info size */
+		__u32		cleanup_info_cnt; /* number of bpf_cleanup_info records */
 	};
=20
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -7599,6 +7602,12 @@ struct bpf_line_info {
 	__u32	line_col;
 };
=20
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

