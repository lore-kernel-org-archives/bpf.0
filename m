Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76668325491
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775409979; cv=none; b=mnzODnIf1lZqCllRQD2ml2GVrDSZ8n+1wwYDAEqasoIvPwmUi1q9MIW2POxDurc3EFjkLks0NGuo5t3jE+4DEFZRbbWSVTwEN9isqFalFAGXx6Gybv9u14D+HnNe55uXbI47W9QtmaxRhn4LbN+dQs5s8mFPh1uA15l9YrOnah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775409979; c=relaxed/simple;
	bh=0EVa3HpqFJLzxg1ur2A4xkucndD6Ujulf7CHcBgchvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9ektEGfgYztS8drEUmwbH2aXHLuqVA6/5IvHOuUgEx4x93g5gsSkZasunerDQM1lH770MKq9ynWhB4iZnIScpsYRnKh6hNJiv2ehDj61gPH1ezgEYqZvmU5eejQvDEF5nCw9LDN0gcS8nEIFrbhG9EuMH2LumKfVgYYcfd8eRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8BCE7361E5E44; Sun,  5 Apr 2026 10:26:16 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 06/11] bpf: Reject stack arguments in non-JITed programs
Date: Sun,  5 Apr 2026 10:26:16 -0700
Message-ID: <20260405172616.1336445-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405172505.1329392-1-yonghong.song@linux.dev>
References: <20260405172505.1329392-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The interpreter does not understand the bpf register r12
(BPF_REG_STACK_ARG_BASE) used for stack argument addressing. So
reject interpreter usage if stack arguments are used either
in the main program or any subprogram.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/core.c     | 3 ++-
 kernel/bpf/verifier.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3520337a1c0e..a04b31eb4c49 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2553,7 +2553,8 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf=
_prog *fp, int *err)
 		goto finalize;
=20
 	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-	    bpf_prog_has_kfunc_call(fp))
+	    bpf_prog_has_kfunc_call(fp) ||
+	    fp->aux->stack_arg_depth)
 		jit_needed =3D true;
=20
 	if (!bpf_prog_select_interpreter(fp))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dba889cece1c..019840010b43 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23944,6 +23944,12 @@ static int fixup_call_args(struct bpf_verifier_e=
nv *env)
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

