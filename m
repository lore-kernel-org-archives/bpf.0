Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E234572F
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189470; cv=none; b=OHEnGetI6/m+26x2yYffu41/jhAHy6BdW4414qRmpg6pOb+WgzAGE4MCUy17opmE9WOkPVAnS74WBUE49lIx/Z1yt6u4T911C0STRipGdIB/zB+0B3/PxCmB0vBqPkaCiAz2zM9TRp28R+Nt/9Z0ZH/PmwPK9XnvoDpALEOjH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189470; c=relaxed/simple;
	bh=aP3gwMVmDC1a9aQgNsFnwBPyDJQl0IYAUNn021e9KJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vc334qM2PaSf6zeqVb41B2kuj5ARSybM1Na5c0AsSnhVk8DjDfpb4OlKQjQ2sYskH0J2YFQPxSRZuewo0AY9/go1WsyjoTxQha+M2QYtukI4968K3gDMSYuy6qBTPsJW1aLQMO9MnFDups9CyUj2+a3N8o2/kfKa4LnmXG2qdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BCBE892BAA676; Thu,  7 May 2026 14:30:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 14/23] bpf: Reject stack arguments if tail call reachable
Date: Thu,  7 May 2026 14:30:54 -0700
Message-ID: <20260507213054.1131645-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507212942.1122000-1-yonghong.song@linux.dev>
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tail calls are deprecated and will be replaced by indirect calls
in the future. Reject programs that combine tail calls with stack
arguments rather than adding complexity for a deprecated feature.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6d07f7a52cd..95fe21d05c10 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5117,6 +5117,11 @@ struct bpf_subprog_call_depth_info {
 	int frame; /* # of consecutive static call stack frames on top of stack=
 */
 };
=20
+static bool subprog_has_stack_args(const struct bpf_subprog_info *si)
+{
+	return si->stack_arg_cnt;
+}
+
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
@@ -5270,14 +5275,23 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
 	 * this info will be utilized by JIT so that we will be preserving the
 	 * tail call counter throughout bpf2bpf calls combined with tailcalls
 	 */
-	if (tail_call_reachable)
+	if (tail_call_reachable) {
 		for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller) {
 			if (subprog[tmp].is_exception_cb) {
 				verbose(env, "cannot tail call within exception cb\n");
 				return -EINVAL;
 			}
+			if (subprog_has_stack_args(&subprog[tmp])) {
+				verbose(env, "tail_calls are not allowed in programs with stack args=
\n");
+				return -EINVAL;
+			}
 			subprog[tmp].tail_call_reachable =3D true;
 		}
+	} else if (!idx && subprog[0].has_tail_call && subprog_has_stack_args(&=
subprog[0])) {
+		verbose(env, "tail_calls are not allowed in programs with stack args\n=
");
+		return -EINVAL;
+	}
+
 	if (subprog[0].tail_call_reachable)
 		env->prog->aux->tail_call_reachable =3D true;
=20
--=20
2.53.0-Meta

