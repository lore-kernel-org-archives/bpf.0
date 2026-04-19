Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25F282F24
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616445; cv=none; b=uxO6oA/IEKWC3sujHZw8E2GOiG74IPUswEv+8Jj1oLHlGOC3FlTYkxg8mytdlZj2Z0hVVXb3iV2DAbzHS8mFmrfDCBmlCUVjOq/7poazCHUG8nXH+khbkU57EIYHVDWnehgwZ+f0OWy9QXOWD0PU9mVx6/ICwIFg7sl5NCRX89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616445; c=relaxed/simple;
	bh=D7cWQ9Ou0x3hmNrxsVMXzc/BI1fz2L3ImtxHqMYZGEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxAGohdvCQi44pvasDKZ6OA9+s8wq6yxDOD3AveUReiMA09MtEpv8KeZ9hhNicEJMSFgs05MmAP8T9KDOht/v7ynq5RoF2MyYR13nU7e2L6WAk7VwVpm+3PFzRY62qcE1gIdY5oubAPAKUkw+g3lJ5BPt0rtZqXH+53ye3C/Ur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5E55B42DD4DF7; Sun, 19 Apr 2026 09:33:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 08/17] bpf: Reject stack arguments in non-JITed programs
Date: Sun, 19 Apr 2026 09:33:57 -0700
Message-ID: <20260419163357.734345-1-yonghong.song@linux.dev>
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

The interpreter does not understand the bpf register r11
(BPF_REG_PARAMS) used for stack argument addressing. So
reject interpreter usage if stack arguments are used either
in the main program or any subprogram.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/core.c   | 2 +-
 kernel/bpf/fixups.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ae10b9ca018d..ec8523e6e4eb 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2599,7 +2599,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env, struct
 		goto finalize;
=20
 	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-	    bpf_prog_has_kfunc_call(fp))
+	    bpf_prog_has_kfunc_call(fp) || fp->aux->stack_arg_depth)
 		jit_needed =3D true;
=20
 	if (!bpf_prog_select_interpreter(fp))
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index c4e0224ad2f2..3c9a82823913 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1411,6 +1411,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
nv)
 		verbose(env, "calling kernel functions are not allowed in non-JITed pr=
ograms\n");
 		return -EINVAL;
 	}
+	for (i =3D 0; i < env->subprog_cnt; i++) {
+		if (env->subprog_info[i].incoming_stack_arg_depth) {
+			verbose(env, "stack args are not supported in non-JITed programs\n");
+			return -EINVAL;
+		}
+	}
 	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
 		/* When JIT fails the progs with bpf2bpf calls and tail_calls
 		 * have to be rejected, since interpreter doesn't support them yet.
--=20
2.52.0

