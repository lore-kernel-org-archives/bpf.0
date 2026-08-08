Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D22DECDF
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215820; cv=none; b=aCq9VKYFSxwT744cma07D7VTDfOszoB6SEM1VIohMU84+CBMlU7rMTuT2wqEVdp17q0CBHH/nWg5Mv3A3U3yyoazFOoGj12eHNQSUIXWqgaG+RDI+Doj7I2al3Df/CH8lZE8UguHMUE1OKBxSl7s7SsqpvQZUJ9GYke8SfmmzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215820; c=relaxed/simple;
	bh=u5HsKLF9zysokbesUwOfsK1gQ3wGQt8cEDyYt+ks1dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bchuzhRCrj8gI9DdIlQA7Ur096+6+OFfbWn7kMbPVgemH2vKcfeY1YbKRXjfk2WGq8um1Y4AHy8L3XZfAs0KJOE5uikcQqwDhYRZt30KtDeFNmeFf/PVeqQyF2fpMzqfMtgBuGpmgCYxpOIqty5p5EJsuitrdf881SAYWOVfenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6A50522CA31AC1; Sat,  8 Aug 2026 12:03:27 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 01/13] bpf: Factor check_global_ret_scalar_reg() out of the global return check
Date: Sat,  8 Aug 2026 12:03:27 -0700
Message-ID: <20260808190327.1897492-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808190322.1896580-1-yonghong.song@linux.dev>
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
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
so that it can be reused for R2.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index add3affc5703..40150390dd50 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16617,37 +16617,45 @@ static int check_return_code(struct bpf_verifie=
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

