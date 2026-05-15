Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FA35E1DF
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885458; cv=none; b=HhKhFoNV4dQDqPy3jWopYNDed9uS+GdGEU/s79cFij8c5fEoz8Wpo0/8ftvA78M1vh6V5yROq3kcvprYicr9CmX2RI0Ur+R4Tj7WGqJFnoPTYTU49kZyg8FucJv12tpJfMOctn8cXNU6Jw2qWU6HpnCcYmJ0gclMbiDnpYGty5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885458; c=relaxed/simple;
	bh=5Iqtr43CHuB8Vt3G2cJSUJwrHTfYPoUFADc1Fgg+oaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkQippRKUH2axGRsXe4uo5b2LH0BclU5zLbtWqhFHVaR+El2GVt6k0XfkzKR08fJS2RaAsnt338pMrUVPJgkOBp3mVhTCOxhiVXLVuubprRin0SQMq+ND5tc82QfoS4tPtP3nAY2uDDfUDCELIMbaGdhnFMpQxChq9eUjrLp438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CA83DC060B63D; Fri, 15 May 2026 15:50:40 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 1/7] bpf: Validate outgoing stack args when btf_prepare_func_args fails
Date: Fri, 15 May 2026 15:50:40 -0700
Message-ID: <20260515225040.821515-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515225035.821178-1-yonghong.song@linux.dev>
References: <20260515225035.821178-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

btf_prepare_func_args() sets sub->arg_cnt before validating arg types.
If validation fails (e.g. unsupported pointer type in a static subprog),
check_outgoing_stack_args() is skipped because btf_check_func_arg_match()
returns early. For static subprogs, check_func_call() ignores non-EFAULT
errors and proceeds with the call.

This causes the callee to read stack arg slots that the caller never
stored or not initialized, potentially dereferencing NULL caller->stack_a=
rg_regs
or getting no-initialized value.

To fix the issue, when btf_prepare_func_args() fails and the subprog expe=
cts
stack args, call check_outgoing_stack_args() to verify the caller initial=
ized
the slots. Return -EFAULT on failure so the error is not ignored.

Fixes: 3ab5bd317ee2 ("bpf: Set sub->arg_cnt earlier in btf_prepare_func_a=
rgs()")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 76a07f09ab64..8dd79b735a69 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9118,11 +9118,17 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
 	struct bpf_func_state *caller =3D cur_func(env);
 	struct bpf_verifier_log *log =3D &env->log;
 	u32 i;
-	int ret;
+	int ret, err;
=20
 	ret =3D btf_prepare_func_args(env, subprog);
-	if (ret)
+	if (ret) {
+		if (bpf_in_stack_arg_cnt(sub) > 0) {
+			err =3D check_outgoing_stack_args(env, caller, sub->arg_cnt);
+			if (err)
+				return err;
+		}
 		return ret;
+	}
=20
 	ret =3D check_outgoing_stack_args(env, caller, sub->arg_cnt);
 	if (ret)
--=20
2.53.0-Meta

