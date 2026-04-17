Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238681EB9E3
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397659; cv=none; b=nLGCPt6ifLskLWHqwqYPKaygznshuoogmGcrea+vM283pJ3fOn5HffscpdhN7nfhQ69y7qwqut66q4ldYtXWwk0CX6bzmagpxKSH2zb3iebDZGWlc5rX5aznLetG3FZ+Nt8B9hZiLXd7VbEPnn3i8IGFAVzDrS3wuFLYIJH76Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397659; c=relaxed/simple;
	bh=8wVaixJdj2I72jwE690Da8WOsM8CB1ShqciVQusQ9KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUahNz6Q2rztvmcQlGhJIBMqjOXx8FONlLjljtkMaghwoGkK41kJJDtJFzhiSfAFnO3I7/4M8IxB1wICK6NQg5rxugQeyhEaIO7dJOsqrUTFMuvPd3dTCi7s29KTyJWLoOBcSHBp/ey9Jl0dLDfCyYYJcc8CGe4FAwFP9pEaMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 587A7403C23D0; Thu, 16 Apr 2026 20:47:29 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 06/16] bpf: Limit the scope of BPF_REG_PARAMS usage
Date: Thu, 16 Apr 2026 20:47:29 -0700
Message-ID: <20260417034729.2629367-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417034658.2625353-1-yonghong.song@linux.dev>
References: <20260417034658.2625353-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

BPF_REG_PARAMS (r11) is used for stack argument accesses. The LLVM
compiler [1] only emits BPF_REG_PARAMS in the following instruction
forms:
  - BPF_LDX | BPF_MEM  (load incoming stack arg)
  - BPF_ST  | BPF_MEM  (store immediate to outgoing stack arg)
  - BPF_STX | BPF_MEM  (store register to outgoing stack arg)

Reject any other use of BPF_REG_PARAMS in check_and_resolve_insns()
to prevent misuse.

Since BPF_REG_PARAMS is beyond MAX_BPF_REG, array-based register
tracking indexed by register number would cause out-of-bounds
accesses. So do early return if needed.

  [1] https://github.com/llvm/llvm-project/pull/189060

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/const_fold.c |  9 +++++++--
 kernel/bpf/liveness.c   |  9 +++++++--
 kernel/bpf/verifier.c   | 17 +++++++++++++----
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index db73c4740b1e..09db7fdb370f 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -51,13 +51,18 @@ static void const_reg_xfer(struct bpf_verifier_env *e=
nv, struct const_arg_info *
 			   struct bpf_insn *insn, struct bpf_insn *insns, int idx)
 {
 	struct const_arg_info unknown =3D { .state =3D CONST_ARG_UNKNOWN, .val =
=3D 0 };
-	struct const_arg_info *dst =3D &ci_out[insn->dst_reg];
-	struct const_arg_info *src =3D &ci_out[insn->src_reg];
+	struct const_arg_info *dst, *src;
 	u8 class =3D BPF_CLASS(insn->code);
 	u8 mode =3D BPF_MODE(insn->code);
 	u8 opcode =3D BPF_OP(insn->code) | BPF_SRC(insn->code);
 	int r;
=20
+	/* Stack arguments using BPF_REG_PARAMS are outside the tracked registe=
r set. */
+	if (insn->dst_reg >=3D MAX_BPF_REG || insn->src_reg >=3D MAX_BPF_REG)
+		return;
+
+	dst =3D &ci_out[insn->dst_reg];
+	src =3D &ci_out[insn->src_reg];
 	switch (class) {
 	case BPF_ALU:
 	case BPF_ALU64:
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 1fb4c511db5a..993d7e543e9f 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1056,11 +1056,16 @@ static void arg_track_xfer(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 	int depth =3D instance->depth;
 	u8 class =3D BPF_CLASS(insn->code);
 	u8 code =3D BPF_OP(insn->code);
-	struct arg_track *dst =3D &at_out[insn->dst_reg];
-	struct arg_track *src =3D &at_out[insn->src_reg];
+	struct arg_track *dst, *src;
 	struct arg_track none =3D { .frame =3D ARG_NONE };
 	int r;
=20
+	/* Stack arguments using BPF_REG_PARAMS are outside the tracked registe=
r set. */
+	if (insn->dst_reg >=3D MAX_BPF_REG || insn->src_reg >=3D MAX_BPF_REG)
+		return;
+
+	dst =3D &at_out[insn->dst_reg];
+	src =3D &at_out[insn->src_reg];
 	if (class =3D=3D BPF_ALU64 && BPF_SRC(insn->code) =3D=3D BPF_K) {
 		if (code =3D=3D BPF_MOV) {
 			*dst =3D none;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff0c55d80311..f25a56cfabac 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18487,13 +18487,22 @@ static int check_and_resolve_insns(struct bpf_v=
erifier_env *env)
 		return err;
=20
 	for (i =3D 0; i < insn_cnt; i++, insn++) {
+		u8 class =3D BPF_CLASS(insn->code);
+		u8 mode =3D BPF_MODE(insn->code);
+
 		if (insn->dst_reg >=3D MAX_BPF_REG) {
-			verbose(env, "R%d is invalid\n", insn->dst_reg);
-			return -EINVAL;
+			if (insn->dst_reg !=3D BPF_REG_PARAMS ||
+			    !((class =3D=3D BPF_ST  || class =3D=3D BPF_STX) && mode =3D=3D B=
PF_MEM)) {
+				verbose(env, "R%d is invalid\n", insn->dst_reg);
+				return -EINVAL;
+			}
 		}
 		if (insn->src_reg >=3D MAX_BPF_REG) {
-			verbose(env, "R%d is invalid\n", insn->src_reg);
-			return -EINVAL;
+			if (insn->src_reg !=3D BPF_REG_PARAMS || class !=3D BPF_LDX ||
+			    mode !=3D BPF_MEM) {
+				verbose(env, "R%d is invalid\n", insn->src_reg);
+				return -EINVAL;
+			}
 		}
 		if (insn[0].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
 			struct bpf_insn_aux_data *aux;
--=20
2.52.0

