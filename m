Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA0427FD44
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616452; cv=none; b=cUjAxV2FbzXFNHHqA8lJMPAV3b8tpvCDDi7pYGMyxUWl4vPQXD07HWg3f+MgwWHQuS/GvsyyHxesAdbdGc4SfKbpTviqnEHJ3nRBTXBmKMXJU6+ZI/I6goTK3FVuxVvjR+OduzxaL08KUoHmcDWH/uGa+hAhHz1ANAn7N+jiybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616452; c=relaxed/simple;
	bh=yclkMf5CkDhmC1LIGSDEQx9B5XvRElmZrZAOyJcejwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKOLMQc4GOKVEhBXJsNTTamvH1Y8c+1hVGKZVoZ5sNqjZRKDcKnUWnL17t2Uqt4A6bFGn+dSN3pqCoL1Qy2X+LoC6SaYZnDlWrVd31OIt2KKIqiXpdDZ3fl7GxcJJFICUQ0N9rBAtWbqcWTJ/yrjeNw8ngik5av3rSHghFJD+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 79E2A42DD4E18; Sun, 19 Apr 2026 09:34:02 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 09/17] bpf: Track r11 registers in const_fold and liveness
Date: Sun, 19 Apr 2026 09:34:02 -0700
Message-ID: <20260419163402.734987-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260419163316.731019-1-yonghong.song@linux.dev>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since BPF_REG_PARAMS (r11) is beyond MAX_BPF_REG (r11), using it as an
array index into the register tracking arrays in const_fold.c and
liveness.c could cause out-of-bounds accesses.

When dst_reg is BPF_REG_PARAMS (BPF_ST/BPF_STX storing to the stack
arg area), no tracked register state changes, so an early return is
sufficient.

When src_reg is BPF_REG_PARAMS (BPF_LDX loading from the stack arg
area), dst_reg is a normal register that gets overwritten. Simply
returning early would leave dst_reg with stale state from a prior
path, which could cause incorrect constant folding or liveness
analysis. Mark dst_reg as unknown/none before returning to prevent
this.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/const_fold.c | 14 ++++++++++++--
 kernel/bpf/liveness.c   | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index db73c4740b1e..41e5a406432c 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -51,13 +51,23 @@ static void const_reg_xfer(struct bpf_verifier_env *e=
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
+	if (insn->dst_reg >=3D MAX_BPF_REG)
+		return;
+	if (insn->src_reg >=3D MAX_BPF_REG) {
+		if (class =3D=3D BPF_LDX)
+			ci_out[insn->dst_reg] =3D unknown;
+		return;
+	}
+
+	dst =3D &ci_out[insn->dst_reg];
+	src =3D &ci_out[insn->src_reg];
 	switch (class) {
 	case BPF_ALU:
 	case BPF_ALU64:
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 332e6e003f27..87022da94f3a 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1068,11 +1068,21 @@ static void arg_track_xfer(struct bpf_verifier_en=
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
+	if (insn->dst_reg >=3D MAX_BPF_REG)
+		return;
+	if (insn->src_reg >=3D MAX_BPF_REG) {
+		if (class =3D=3D BPF_LDX)
+			at_out[insn->dst_reg] =3D none;
+		return;
+	}
+
+	dst =3D &at_out[insn->dst_reg];
+	src =3D &at_out[insn->src_reg];
 	if (class =3D=3D BPF_ALU64 && BPF_SRC(insn->code) =3D=3D BPF_K) {
 		if (code =3D=3D BPF_MOV) {
 			*dst =3D none;
--=20
2.52.0

