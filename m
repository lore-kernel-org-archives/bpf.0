Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7A3AAF60
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205519; cv=none; b=gFfIlQ8UQ4uu7Nhqshx5ZvaZP+R8wMwOQD8fnpvWfDHACssfkV8myN4Peho+Byo0q9xheF+uGnXUMe1xSrxDw1qI86YZEvn4IdqVRHB3C+NlodwEWJMnH6MqjGQBEJFW+EwHWzPeJYBRG51cp5dpgOXmsEgV0WkNfvzjyD9aLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205519; c=relaxed/simple;
	bh=sspiSUujILls2oJXteNJCOtuCbS4LbT6sAQq1AzIf2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBj/1M2l0kOfYvMxNr0S+zrTNg9uhaSsZyatVGMKoGp0BAyDLHpBTQJVO+BHDaDazeL1Wbp+v1iAnGURBFDwXW//EXXy5NXETXvCIRFYh2aOosHVxx54ac58m0afosdZgggTqewG2qJnvNHXdYGg6YJlX2A/+Fp1WpkKxd9jHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6D4DE31B3AFC88; Fri, 16 Oct 2026 19:51:45 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 03/25] bpf: Keep a call site's landing pad in insn_aux_data, add lookups
Date: Fri, 16 Oct 2026 19:51:45 -0700
Message-ID: <20261017025145.1917061-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A call site's landing pad, if any, is kept in insn_aux_data as
cleanup_pad. adjust_insn_aux_data(), which every instruction patch goes
through, and verifier_remove_insns() keep it in step, and
bpf_opt_remove_nops() moves a pad off a nop to the next instruction
before removing the nop. Add lookups for it and for calls to
bpf_unwind() and bpf_unwind_resume(); their users come in later patches.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  5 +++++
 kernel/bpf/exception.c       | 24 ++++++++++++++++++++++++
 kernel/bpf/exception.h       |  4 ++++
 kernel/bpf/fixups.c          | 26 +++++++++++++++++++++++++-
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 11cd90d85bad..89a714057820 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -806,6 +806,11 @@ struct bpf_insn_aux_data {
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
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index ac3b575f935e..9ab29c73c44b 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
 #include <linux/slab.h>
 #include "exception.h"
=20
@@ -135,3 +137,25 @@ int bpf_exc_check_info(struct bpf_verifier_env *env,=
 const union bpf_attr *attr,
 	kvfree(krecord);
 	return ret;
 }
+
+BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
+BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
+
+bool bpf_is_unwind_kfunc(const struct bpf_insn *insn)
+{
+	return bpf_pseudo_kfunc_call(insn) && insn->off =3D=3D 0 &&
+	       insn->imm =3D=3D bpf_unwind_id[0];
+}
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
index cf099dcc5b74..d5c6ac459870 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -8,8 +8,12 @@
=20
 union bpf_attr;
 struct bpf_verifier_env;
+struct bpf_insn;
=20
 int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_att=
r *attr,
 		       bpfptr_t uattr);
+int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
+bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
+bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn);
=20
 #endif /* __BPF_EXCEPTION_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 608621d7f225..feb3b079dfbb 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -244,11 +244,18 @@ static void adjust_insn_aux_data(struct bpf_verifie=
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
@@ -604,6 +611,7 @@ static int verifier_remove_insns(struct bpf_verifier_=
env *env, u32 off, u32 cnt)
 	struct bpf_insn_aux_data *aux_data =3D env->insn_aux_data;
 	unsigned int orig_prog_len =3D env->prog->len;
 	int err;
+	u32 i;
=20
 	if (bpf_rewrite_must_abort())
 		return -EINTR;
@@ -634,6 +642,17 @@ static int verifier_remove_insns(struct bpf_verifier=
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
@@ -739,7 +758,7 @@ int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 	struct bpf_insn *insn =3D env->prog->insnsi;
 	int insn_cnt =3D env->prog->len;
 	bool is_may_goto_0, is_ja;
-	int i, err;
+	int i, j, err;
=20
 	for (i =3D 0; i < insn_cnt; i++) {
 		is_may_goto_0 =3D !memcmp(&insn[i], &MAY_GOTO_0, sizeof(MAY_GOTO_0));
@@ -750,6 +769,11 @@ int bpf_opt_remove_nops(struct bpf_verifier_env *env=
)
 		if (aux[i].indirect_target)
 			continue;
=20
+		if (env->cleanup_info_cnt)
+			for (j =3D 0; j < insn_cnt; j++)
+				if (aux[j].cleanup_pad =3D=3D i + 1)
+					aux[j].cleanup_pad =3D i + 2;
+
 		err =3D verifier_remove_insns(env, i, 1);
 		if (err)
 			return err;
--=20
2.53.0-Meta

