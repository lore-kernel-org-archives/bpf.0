Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6A238C36
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397693; cv=none; b=bONgDLJWSLouqyWMxeExfpLbcBoLk+sh41qjRmArf64+Sa0lTBRBcDrzcC5rTWPhe03H0bhqqjeELodMXmXTOdAg+jLXcxP0ZdDKiXwrel169frC15M+okyuNy/vtCBOCUEo3rnOTTfZgJn8J+wznpfXaa13T6yrvP/LdVG5Ljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397693; c=relaxed/simple;
	bh=OEx8vPHBO4IIonXxN3YNQ4KA0cPikNdAeXAt6QNd64o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALNiw9D2Ff7xo6VVYEPvLDhg7PJ4JNdV26H2337JUEFwsO/O9J+u4QKBlzh4fBfA0358FQ2GD9WPmgF0NX/WyeP+8dVRwp870St79jRR25RXyYzRw9cNfkq4kCSC6ktgFMwpwJIW3MUVh0RTxG60z8itJRgA7WXUbSSzuEqUTHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 05C5C403C2480; Thu, 16 Apr 2026 20:48:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 12/16] bpf: Enable stack argument support for x86_64
Date: Thu, 16 Apr 2026 20:47:59 -0700
Message-ID: <20260417034800.2631277-1-yonghong.song@linux.dev>
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

Add stack argument support for x86_64.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 5 +++++
 include/linux/filter.h      | 1 +
 kernel/bpf/btf.c            | 8 +++++++-
 kernel/bpf/core.c           | 5 +++++
 kernel/bpf/verifier.c       | 5 +++++
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e9b78040d703..32864dbc2c4e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3937,6 +3937,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
=20
+bool bpf_jit_supports_stack_args(void)
+{
+	return true;
+}
+
 void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	if (text_poke_copy(dst, src, len) =3D=3D NULL)
diff --git a/include/linux/filter.h b/include/linux/filter.h
index ae094328d973..e00348c50ac7 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1161,6 +1161,7 @@ bool bpf_jit_inlines_helper_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
+bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c5f3aa05d5a3..3497e218c02d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7897,8 +7897,14 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
-	if (nargs > MAX_BPF_FUNC_REG_ARGS)
+	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		if (!bpf_jit_supports_stack_args()) {
+			bpf_log(log, "JIT does not support function %s() with %d args\n",
+				tname, nargs);
+			return -ENOTSUPP;
+		}
 		sub->incoming_stack_arg_depth =3D (nargs - MAX_BPF_FUNC_REG_ARGS) * BP=
F_REG_SIZE;
+	}
=20
 	/* check that function is void or returns int, exception cb also requir=
es this */
 	t =3D btf_type_by_id(btf, t->type);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 10c36a74431d..49ab4470cc20 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3157,6 +3157,11 @@ bool __weak bpf_jit_supports_kfunc_call(void)
 	return false;
 }
=20
+bool __weak bpf_jit_supports_stack_args(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_far_kfunc_call(void)
 {
 	return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a3f307909e40..4d538fa11b01 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12366,6 +12366,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 			MAX_BPF_FUNC_ARGS);
 		return -EINVAL;
 	}
+	if (nargs > MAX_BPF_FUNC_REG_ARGS && !bpf_jit_supports_stack_args()) {
+		verbose(env, "JIT does not support kfunc %s() with %d args\n",
+			func_name, nargs);
+		return -ENOTSUPP;
+	}
=20
 	/* Check that BTF function arguments match actual types that the
 	 * verifier sees.
--=20
2.52.0

