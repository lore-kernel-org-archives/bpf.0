Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46A36F433
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647857; cv=none; b=RX3hAXr32e3UL3plO70TzuIZazNcPoJpLiVzJ4DQBCnzVUBv7ToAaSfBCs+biP/R+5PRKhEwHq8kv8SharhLITpQyOOoChF5kcMhS3LWJSy8L8VpuAt2q0OLtRCRkGuohlMyNn7XRIZsbJtq5Gto8ULmnbzeV9VYTj8xZoNHomo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647857; c=relaxed/simple;
	bh=4t35/7wwwF+obDL7lngkhIJd/L1soTPPTjqufa0U+34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Es9cUYq95KiHtG3HHoyoehRXpdSj8j5h7/Pij229JF98Q9sNbG+XUaCkfx7N7s2+S9yUH+YMa3fjrUelrzUGoZlxF6O5pUYRgmX/B2S4xECoDPEOcYAhP8na5RVmK1T28XyvnIgnjt3FpE1sPGBgDsltepw9c+o2IdquV1ZPLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2D294B195EED2; Tue, 12 May 2026 21:50:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v4 12/25] bpf: Prepare architecture JIT support for stack arguments
Date: Tue, 12 May 2026 21:50:54 -0700
Message-ID: <20260513045054.2390945-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513044949.2382019-1-yonghong.song@linux.dev>
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
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

Reject BPF functions with more than 5 parameters at verification
time if the architecture does not support stack arguments.

Acked-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/filter.h | 1 +
 kernel/bpf/btf.c       | 8 +++++++-
 kernel/bpf/core.c      | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 918d9b34eac6..a515a9769078 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1184,6 +1184,7 @@ bool bpf_jit_inlines_helper_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
+bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ec3fb8c8f4ee..3d8080eba544 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7886,8 +7886,14 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
 			MAX_BPF_FUNC_ARGS, tname, nargs);
 		return -EFAULT;
 	}
-	if (nargs > MAX_BPF_FUNC_REG_ARGS)
+	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		if (!bpf_jit_supports_stack_args()) {
+			bpf_log(log, "JIT does not support function %s() with %d args\n",
+				tname, nargs);
+			return -EFAULT;
+		}
 		sub->stack_arg_cnt =3D nargs - MAX_BPF_FUNC_REG_ARGS;
+	}
=20
 	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
 		bpf_log(log, "global function %s has %d > %d args, stack args not supp=
orted\n",
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 958d86f0beac..e6b836f846eb 100644
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
--=20
2.53.0-Meta

