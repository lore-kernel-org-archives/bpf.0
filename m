Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407B3F9F2F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498642; cv=none; b=ML8QLYc+X3gSp25sGcDpgBer8fMneL27ndux8MZn+AYMRj/TtCsCgZ8U4rfYwdas1l2sGInQ2stUjNxcvyj50jFCAn7+m6CJNIhZKNpstFcJ8CH5HuiGaUsprLC0nyiero7v/sVIoSNoVd1z1l7gLCbl7Wvy1BFJ9l+wMt5ar10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498642; c=relaxed/simple;
	bh=kN3Rsx+3SSJ7mv4msiXvIElNdPVUhVl3LNpfmPdiOUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETBS2Ce5hCsTS4ga5mNRK22lrK3T0+g2pp7j0m3fT4MN7dr5ZTKSIVYvZy/2gZowHJZC9FHMVE5CrT/dNeGO5f5a5BG5PM1TbVF8DnibMQFqTXDWPAAhb1DVet1kztmdNea/huq+/mGUCb0sBR/7tJs5ijcwE2YhAWcSszda26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 99160288133E5F; Thu,  3 Sep 2026 22:10:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 08/12] bpf: Record a 16-byte argument alignment in the function model
Date: Thu,  3 Sep 2026 22:10:38 -0700
Message-ID: <20260904051038.3980676-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904050957.3976119-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A calling convention may place an argument aligned to 16 bytes apart from
the rest: AAPCS64 rounds the register number up to an even one for it. Th=
e
function model a JIT works from carries the size of every argument and a
few flags, but not its alignment, so a JIT cannot tell such an argument
from any other one of the same size.

Have btf_distill_func_proto() record it as BTF_FMODEL_ALIGN16_ARG. Only a
128-bit integer, or an aggregate built around one, asks for the alignment=
,
which btf_type_align16() answers by walking the members.

The walk descends a bounded number of levels, and a type nested deeper ha=
s
no answer. Reporting "not aligned" there would have a JIT place the
argument in a register the kernel does not read, so the model is refused
instead and the call is never compiled.

The flag will be used in the next patch.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |  3 +++
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/btf.c             | 11 ++++++++++-
 kernel/bpf/verifier.c        | 25 +++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3a7eb2185c35..5b93aa97f1bc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1193,6 +1193,9 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
=20
+/* Argument aligned to 16 bytes. */
+#define BTF_FMODEL_ALIGN16_ARG		BIT(0)
+
 /* The argument is signed. */
 #define BTF_FMODEL_SIGNED_ARG		BIT(1)
=20
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ae9f606539f4..2c51b0f8b18c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1497,6 +1497,7 @@ enum btf_member_kind {
=20
 bool btf_struct_is_composed_of(struct bpf_verifier_env *env, const struc=
t btf *btf,
 			       const struct btf_type *t, u32 member_kinds);
+int btf_type_align16(const struct btf *btf, const struct btf_type *t, in=
t rec);
=20
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6c391449e298..f933a675b0a8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7576,7 +7576,7 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
 	const struct btf_param *args;
 	const struct btf_type *t;
 	u32 i, nargs;
-	int ret;
+	int align16, ret;
=20
 	if (!func) {
 		/* BTF function prototype doesn't match the verifier types.
@@ -7633,6 +7633,15 @@ int btf_distill_func_proto(struct bpf_verifier_log=
 *log,
 		}
 		m->arg_size[i] =3D ret;
 		m->arg_flags[i] =3D __get_arg_fmodel_flags(btf, &args[i], t);
+
+		align16 =3D btf_type_align16(btf, t, 0);
+		if (align16 < 0) {
+			bpf_log(log, "The function %s arg%d type %s has unknown alignment.\n"=
,
+				tname, i, btf_type_str(t));
+			return -EINVAL;
+		} else if (align16) {
+			m->arg_flags[i] |=3D BTF_FMODEL_ALIGN16_ARG;
+		}
 	}
 	m->nr_args =3D nargs;
 	return 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 030fb37c22ef..461883158ffa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11748,6 +11748,31 @@ bool btf_struct_is_composed_of(struct bpf_verifi=
er_env *env,
 	return btf_struct_member_walk(env, btf, t, member_kinds, 0, NULL);
 }
=20
+int btf_type_align16(const struct btf *btf, const struct btf_type *t, in=
t rec)
+{
+	const struct btf_member *member;
+	int ret;
+	u32 i;
+
+	while (btf_type_is_array(t))
+		t =3D btf_type_skip_modifiers(btf, btf_array(t)->type, NULL);
+
+	if (btf_type_is_int(t))
+		return t->size > 8;
+	if (!btf_type_is_struct(t))
+		return 0;
+	if (rec >=3D BTF_MEMBER_MAX_DEPTH)
+		return -E2BIG;
+
+	for_each_member(i, t, member) {
+		ret =3D btf_type_align16(btf, btf_type_skip_modifiers(btf, member->typ=
e, NULL),
+				       rec + 1);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 				      const struct btf *btf,
 				      const struct btf_type *t)
--=20
2.53.0-Meta

