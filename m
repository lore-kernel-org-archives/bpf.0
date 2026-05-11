Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF8357A25
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477641; cv=none; b=IoIBHOj1Coc/CWBvLLyfZUtLKexaF34NNxS//flpBD5qlvhziYTzAizjp6DT+VfMuay4xr4Uo9hj3JLcS7woJlWjAGCMQBvi79+1tVn5My6rFAoIVDOVs4erMwgpNOStf9cevCmceE/yPzroq7bopyRrbCtk0BI1LAfNTz/cUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477641; c=relaxed/simple;
	bh=nRX7iUGfDGeFXyMBrZVHrVjar7rlcCLouWk3hyTSlqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dswHzC++HdYZgB/UxTUfN3pF5DVr8YnHfeQwc3SAOA9NJQa4dtOj2n1QpwjUnR0XJVv9FKDgB2RnW0Wl7FkXQuqBg2ZUnMl3PxyLzPQ+vr/o1G42mcArJ9RCSHZQREzHKEEHh7pLoLf8TGH/0ySYSATPhrwnHWs0dfq6X2LYTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3C8B5A59DBF05; Sun, 10 May 2026 22:33:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 10/24] bpf: Reject stack arguments in non-JITed programs
Date: Sun, 10 May 2026 22:33:53 -0700
Message-ID: <20260511053353.1885466-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511053301.1878610-1-yonghong.song@linux.dev>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The interpreter does not understand the bpf register r11
(BPF_REG_PARAMS) used for stack arguments. So reject interpreter
usage if stack arguments are used either in the main program or
any subprogram.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/core.c   | 2 +-
 kernel/bpf/fixups.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ae10b9ca018d..958d86f0beac 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2599,7 +2599,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env, struct
 		goto finalize;
=20
 	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-	    bpf_prog_has_kfunc_call(fp))
+	    bpf_prog_has_kfunc_call(fp) || (env && env->subprog_info[0].stack_a=
rg_cnt))
 		jit_needed =3D true;
=20
 	if (!bpf_prog_select_interpreter(fp))
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index ba86039789fd..19056016eed8 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1407,6 +1407,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
nv)
 		verbose(env, "calling kernel functions are not allowed in non-JITed pr=
ograms\n");
 		return -EINVAL;
 	}
+	for (i =3D 1; i < env->subprog_cnt; i++) {
+		if (bpf_in_stack_arg_cnt(&env->subprog_info[i])) {
+			verbose(env, "stack args are not supported in non-JITed programs\n");
+			return -EINVAL;
+		}
+	}
 	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
 		/* When JIT fails the progs with bpf2bpf calls and tail_calls
 		 * have to be rejected, since interpreter doesn't support them yet.
--=20
2.53.0-Meta

