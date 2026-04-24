Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA22D780E
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050911; cv=none; b=tLangJM8mfKEXUekHJMDG/BzvR268dLfkyTyYAY3lasuLmbu55dYPXiQNVwKfPIHBW1zybk9zYCZzazHse2iWXNYXbkhkufozYok5O6HrzvmZRh1V6qF/23TFiJlFN0FxmGj+XLaGlkfit5VcSBB/l4PafhXodhFtdjFyd+VSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050911; c=relaxed/simple;
	bh=y7keRLSVa9GvrfTuWU+Nu4yz0eA0Ezdn9VBCCvdZvmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBZVAGCEvB0zQvMUdRJM5h65HWUxDSYZ7HBaSPoQkJdNbLsjeG8IEZg66MWhfHCk/qI3itHdikZh9JEJ6bR4KgC81uy5kV+i5b/8rI3GUqRfS4wiC7xkPGqnKFwlpq7neQks/kWKOChD+WJ32XkQHsgUdbZ62WAfdDpTHJc3HKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 62DF4474A64C1; Fri, 24 Apr 2026 10:15:04 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next 06/18] bpf: Prepare architecture JIT support for stack arguments
Date: Fri, 24 Apr 2026 10:15:04 -0700
Message-ID: <20260424171504.2039094-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424171433.2034470-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
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

Acked-by: Puranjay Mohan <puranjay@kernel.org>
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
index cfb35a2decf6..fa4b971c5289 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7890,8 +7890,14 @@ int btf_prepare_func_args(struct bpf_verifier_env =
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
index e041c182c614..0ba140dabe93 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12254,6 +12254,11 @@ static int check_kfunc_args(struct bpf_verifier_=
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

