Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1A2D63E5
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616469; cv=none; b=D3O8jNky9zmJrDEjZrwzwMjx4xzTsPtMB+tAybtM2M3iJ/jhb5l3fBBC+aTlInLHsQB/aAT7/NV9emszea4ZzxBsnUrn3PoWFOxfquBADics7S/aucRoflGpJtS6bXclFPycp5p/z6fHMCOwRl8QwBSYikQMhWnbCUGhMR4HOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616469; c=relaxed/simple;
	bh=AMeeDMsuO7PPGp1JGbck2kxd7vJ4z4mwNZGUqCkT64A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ7R5CcSRU0STkmT5c9A6zJMi84cqUOr3CcDRKL8tD69wEtwKISgAlNM1oSXFiLGUaIiSaQFKAi96rAoiwaRxMyfbeO3xp0ZFuHi3DqPqncYPGzoJftgAxV6qDFjX6PL/JKsRcjJUNIdNN83AksYv++C3pA6esMvLw7juLcVxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E699742DD4EB3; Sun, 19 Apr 2026 09:34:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 13/17] bpf: Reject stack arguments if tail call reachable
Date: Sun, 19 Apr 2026 09:34:22 -0700
Message-ID: <20260419163422.738397-1-yonghong.song@linux.dev>
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

Tailcalls have been deprecated. So reject stack arguments
if tail call is in the way.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 13f1fd788092..af8975049883 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5519,6 +5519,11 @@ struct bpf_subprog_call_depth_info {
 	int frame; /* # of consecutive static call stack frames on top of stack=
 */
 };
=20
+static bool subprog_has_stack_args(const struct bpf_subprog_info *si)
+{
+	return si->incoming_stack_arg_depth || si->outgoing_stack_arg_depth;
+}
+
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
@@ -5672,14 +5677,23 @@ static int check_max_stack_depth_subprog(struct b=
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
2.52.0

