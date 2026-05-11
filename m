Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE12236FD
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477664; cv=none; b=F9Sntecc2kZcAjPzSlYgrcoYJaAMDc7OU1Rns4O7ahzdC/FDhrmPtZ/TaFReHSqCvGwa0fp/10MHnskpZyXf+VVnPmn/zhhRqSp53/wddMEgRQl61mcH78aE6WsHFxnwjGEc+4kxc6XQczyWA48bAa+6nytc7dSCgw1n7NuobN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477664; c=relaxed/simple;
	bh=UfyZKpKRJbT8JLRUdkWoKAwK2JmK3ACSv3pOmSrVbis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SI6JWxCaF2V2SejfBebU7SKazORMxMqjMwWzT8jijV6BUBfCHDAiDqsZ+4RhNk4UdxveTp5FPKMwXegtoWwa/ewwy6hAs3if+0RnspIPIQbeQ+fUHTRYTkC82Q2ne76e66yz5AWAL89TGFmbKoE9Rf/kjrutjP4wiYy1pSp5zwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B5C3CA59DC69D; Sun, 10 May 2026 22:34:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 14/24] bpf: Reject stack arguments if tail call reachable
Date: Sun, 10 May 2026 22:34:13 -0700
Message-ID: <20260511053413.1888514-1-yonghong.song@linux.dev>
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

Tail calls are deprecated and will be replaced by indirect calls
in the future. Reject programs that combine tail calls with stack
arguments rather than adding complexity for a deprecated feature.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d596e6bd9a81..2f2814035f37 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5267,14 +5267,23 @@ static int check_max_stack_depth_subprog(struct b=
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
+			if (bpf_in_stack_arg_cnt(&subprog[tmp])) {
+				verbose(env, "tail_calls are not allowed in programs with stack args=
\n");
+				return -EINVAL;
+			}
 			subprog[tmp].tail_call_reachable =3D true;
 		}
+	} else if (!idx && subprog[0].has_tail_call && bpf_in_stack_arg_cnt(&su=
bprog[0])) {
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

