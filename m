Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CA38B124
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118780; cv=none; b=U5zrYkMBTvKdwkYLvu3ECmiLU597ZME9RJfMShS4JZyMW4icRbctxTgcPNNEsQCL8zCtlPC/4BPhBsKM8fbBT33tc3869Tk54NrcM5MLQONlCn/f4F1E28MjaNgOrMoHNOQ0AoyWfKvzxi3b78Z+fnDZQ208hOck4x6EPtn9tBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118780; c=relaxed/simple;
	bh=cmUsdo0cEa4D2ca4rxV06bnbDH2n9p8sCW6LgMuQfTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQpXuiCBnQMA1sH4m/HMm4oQRZ1g8GvhDpP73WZMDhM0l5iVkevH/UB5S/W8DmWdaYkzjNOGm/cfPiSRBmAPLpfnkX7HjPSMMTNymB7XYYsZ6J9HvxT9W+QoLeZL9onuVEL7uaCDoEWZ5UK1Ho0Le945KXdTu303f7xRnNVzF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 404AD250AA37A1; Tue, 18 Aug 2026 22:52:44 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 01/10] bpf: Factor check_global_ret_scalar_reg() out of the global return check
Date: Tue, 18 Aug 2026 22:52:44 -0700
Message-ID: <20260819055244.3294700-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819055239.3293449-1-yonghong.song@linux.dev>
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

check_global_subprog_return_code() verifies that a global subprogram
returns void, an arena pointer, or register R0 holding a scalar value.
Later patches in this series add 16-byte aggregate return support, whose
second half is returned in R2 and needs the same validation.

Factor the per-register check into check_global_ret_scalar_reg(env, regno=
)
so that it can be reused for R2. No functional change.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e421ea2b80c3..d8bf897460ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17453,37 +17453,45 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
 	return 0;
 }
=20
-static int check_global_subprog_return_code(struct bpf_verifier_env *env=
)
+static int check_global_ret_scalar_reg(struct bpf_verifier_env *env, u32=
 regno)
 {
-	struct bpf_reg_state *reg =3D reg_state(env, BPF_REG_0);
-	struct bpf_func_state *cur_frame =3D cur_func(env);
+	struct bpf_reg_state *reg;
 	int err;
=20
-	if (subprog_returns_void(env, cur_frame->subprogno))
-		return 0;
-
-	err =3D check_reg_arg(env, BPF_REG_0, SRC_OP);
+	err =3D check_reg_arg(env, regno, SRC_OP);
 	if (err)
 		return err;
=20
 	/* Pointers to arena are safe to pass between subprograms. */
-	if (is_arena_reg(env, BPF_REG_0))
+	if (is_arena_reg(env, regno))
 		return 0;
=20
-	if (is_pointer_value(env, BPF_REG_0)) {
-		verbose(env, "R%d leaks addr as return value\n", BPF_REG_0);
+	if (is_pointer_value(env, regno)) {
+		verbose(env, "R%d leaks addr as return value\n", regno);
 		return -EACCES;
 	}
=20
+	reg =3D reg_state(env, regno);
 	if (reg->type !=3D SCALAR_VALUE) {
-		verbose(env, "At subprogram exit the register R0 is not a scalar value=
 (%s)\n",
-			reg_type_str(env, reg->type));
+		verbose(env, "At subprogram exit the register R%d is not a scalar valu=
e (%s)\n",
+			regno, reg_type_str(env, reg->type));
 		return -EINVAL;
 	}
=20
 	return 0;
 }
=20
+static int check_global_subprog_return_code(struct bpf_verifier_env *env=
)
+{
+	struct bpf_func_state *cur_frame =3D cur_func(env);
+	u32 subprog =3D cur_frame->subprogno;
+
+	if (subprog_returns_void(env, subprog))
+		return 0;
+
+	return check_global_ret_scalar_reg(env, BPF_REG_0);
+}
+
 /* Bitmask with 1s for all caller saved registers */
 #define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
=20
--=20
2.53.0-Meta

