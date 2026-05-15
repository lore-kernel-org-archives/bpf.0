Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B03E92AB
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885474; cv=none; b=qV9yIWEtjClK5J8bWZQ/vzo9nxiMHQTSNMPRJX2lRyi8IwVRPEP2OBDhGlXH483QhL1GPiD3OnEisvscw+xMpNYjmduyCISPO3vvQInBo6I+36BK0eRFZBmbMPE10KTtRB6lZJJ0OgF8uok5It6nTrQO8Ysf3CRju7sdlozd5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885474; c=relaxed/simple;
	bh=JBO5mZQxzLDN1O8BnSuFCbUeh8n460B/+nuuIYZDHv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EocyZ3/T7P1YeA9/a4X692yqCnymQK60N1suE6sim9z656E1kTpKdVQ+4daVBhUcBwOQxZNgi1pZOFkOGE7kwY1LJSLhCv/lQN8MlWwd8kD/Wn1l199jT9SmEmG6cKLDxQMcapC8twwj2Fg+yj/diUJaYP0vzqhiju+fL5EcAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 60581C0611FD5; Fri, 15 May 2026 15:51:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 5/7] bpf: Clean up redundant stack arg checks for non-JITed programs
Date: Fri, 15 May 2026 15:51:01 -0700
Message-ID: <20260515225101.824054-1-yonghong.song@linux.dev>
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

Remove a redundant stack_arg_cnt check in __bpf_prog_select_runtime()
and start the stack arg loop from index 0 in bpf_fixup_call_args().
Both changes are no-ops that simplify the code:

In __bpf_prog_select_runtime(), the subprog_info[0].stack_arg_cnt
check is unreachable:
  - when there is only a main program (no bpf-to-bpf calls),
    subprog_info[0].stack_arg_cnt is always 0 because the main
    program's arg_cnt is forced to 1
  - when bpf-to-bpf calls use stack args and JIT succeeds,
    fp->bpf_func is set and this code is skipped
  - when JIT fails, bpf_fixup_call_args() rejects the program
    before we get to __bpf_prog_select_runtime().

In bpf_fixup_call_args(), starting the loop at i=3D1 skipped subprog 0,
which is safe since the main program always has arg_cnt=3D1 and thus
bpf_in_stack_arg_cnt() returns 0. Starting at i=3D0 removes the need
to reason about this invariant.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/core.c   | 2 +-
 kernel/bpf/fixups.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 427a6d828e01..cdbe9fdf474f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2609,7 +2609,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env, struct
 		goto finalize;
=20
 	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-	    bpf_prog_has_kfunc_call(fp) || (env && env->subprog_info[0].stack_a=
rg_cnt))
+	    bpf_prog_has_kfunc_call(fp))
 		jit_needed =3D true;
=20
 	if (!bpf_prog_select_interpreter(fp))
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 19056016eed8..2cec4e8cd4a0 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1407,7 +1407,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *en=
v)
 		verbose(env, "calling kernel functions are not allowed in non-JITed pr=
ograms\n");
 		return -EINVAL;
 	}
-	for (i =3D 1; i < env->subprog_cnt; i++) {
+	for (i =3D 0; i < env->subprog_cnt; i++) {
 		if (bpf_in_stack_arg_cnt(&env->subprog_info[i])) {
 			verbose(env, "stack args are not supported in non-JITed programs\n");
 			return -EINVAL;
--=20
2.53.0-Meta

