Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB72D1F44
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616460; cv=none; b=oolcPwcFgEmD7EvjeO3wwEP7ZdOVZjms4xuGj+yMTOx/zkY0JJ2pBaeogASL4wZDv5UMQaNp5t9cgYshofddXGzNLaKZKsrFh1PMAgi32XY0Sk9K/9lSZP3K9vELROCnJwOi0AE8IbIM7qB9NO5uLcqqr6KHbeYVTTgKONCRhes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616460; c=relaxed/simple;
	bh=mKGTbyVgpqP2Db9XLmaBT8g3SdHZYf9RAPksKKTMxxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVMt6xNOvrLgud+GwRwiO/JBv4FDDtULzZeXoeJgORWBWG8b4jEA83iu/EZZAExwU7xTtZ/LLiRCH0xNFXoxRakHCkw6eGg+GHRttWACe+eqRntTBQc8SD0nhek6+HJ1uKdgwmiRWBwqSuuBiGodd3xTn2pgAtWARhhW9lAqfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 958CB42DD4E47; Sun, 19 Apr 2026 09:34:07 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 10/17] bpf: Prepare architecture JIT support for stack arguments
Date: Sun, 19 Apr 2026 09:34:07 -0700
Message-ID: <20260419163407.735796-1-yonghong.song@linux.dev>
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

Add bpf_jit_supports_stack_args() as a weak function defaulting to
false. Architectures that implement JIT support for stack arguments
override it to return true.

Reject BPF functions and kfuncs with more than 5 parameters at
verification time if the architecture does not support stack
arguments.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/filter.h | 1 +
 kernel/bpf/btf.c       | 8 +++++++-
 kernel/bpf/core.c      | 5 +++++
 kernel/bpf/verifier.c  | 5 +++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index b77d0b06db6e..911205dd670e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1163,6 +1163,7 @@ bool bpf_jit_inlines_helper_call(s32 imm);
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
index ec8523e6e4eb..7522b3d7b267 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3217,6 +3217,11 @@ bool __weak bpf_jit_supports_kfunc_call(void)
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
index 78c9322870a5..e952ebcc2f8f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12363,6 +12363,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
 			MAX_BPF_FUNC_REG_ARGS);
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

