Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907A34028D
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397676; cv=none; b=p9TXaWBYmHXjlHslkb8bEET0VDlHz52fn6JXeAZZdidgXSfjUrtaCK+1hMmpBP6QIssLCIsavxfoIR1Gc534cBu6ovthz8CDOdYGDZvMKB5QdukCXkNdFje9wzyWse22Om+GEUaq/9a31Wu8KHyyzpIR358ZBA92hJtiQuZT8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397676; c=relaxed/simple;
	bh=udu+XzG5V0JQaWZc04bDJZ6CCk7kRYAr1u9RYYz77Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+Er0oHeObLGJI151b5lnTSvEhw+vOxziTH+jYKUmh7+4lFTuxKbJhqSCoSOlT4BcBKK0GtswQCZEmCN+84e6blllFozt4LC+qJQmdqJa6UdFG6PnBo7xr+s5tzvdXsZuNtbQqGYEFwnsWGgQXqIzDzWQgRm/psxiys7iXRPP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A95D6403C2429; Thu, 16 Apr 2026 20:47:44 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 09/16] bpf: Reject stack arguments in non-JITed programs
Date: Thu, 16 Apr 2026 20:47:44 -0700
Message-ID: <20260417034744.2630316-1-yonghong.song@linux.dev>
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
index e7e97ffa2a8b..10c36a74431d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2555,7 +2555,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf=
_prog *fp, int *err)
 		goto finalize;
=20
 	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-	    bpf_prog_has_kfunc_call(fp))
+	    bpf_prog_has_kfunc_call(fp) || fp->aux->stack_arg_depth)
 		jit_needed =3D true;
=20
 	if (!bpf_prog_select_interpreter(fp))
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index f9233945b0f2..179e17007240 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1302,6 +1302,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
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

