Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A6377007
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647872; cv=none; b=OGFZ5nDyGniemjyUKe6lijUZHioqUJ3E2jea0WAf9GgnwsfZwEsX6sJh/jd3t/V8IphwSiqNfKD6A8BpVW2BBrjSNXsPLhf1KyyBdbLn1fzsgZAbCfbOJKFRiZQQp01Fudf+jazxvaEvIwl0unBvURYLwUBqhyDIutwhN1sYcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647872; c=relaxed/simple;
	bh=aZ8oAiSHWCxsCidzR9AdGWEi2iA5t9G8/rWx4JVSfKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W05iRXTKZaolJMWiaVZCEc9Za+HbjM24UGajl7atstKgWhk/XVA4p0QYnyNv2vw+kyTOIYM3XsCDkwGJb6ECK7+FkXkqvfUH7Zzrw74wHD5R3xTYO0G6Mwq2y5IA5pMIGSPjDioFQuOhLT3gHAplWNyqrAM16AL2IP9DpotCwxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 81DEDB1981D2B; Tue, 12 May 2026 21:51:09 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 15/25] bpf: Reject stack arguments if tail call reachable
Date: Tue, 12 May 2026 21:51:09 -0700
Message-ID: <20260513045109.2392108-1-yonghong.song@linux.dev>
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

Tail calls are deprecated and will be replaced by indirect calls
in the future. Reject programs that combine tail calls with stack
arguments rather than adding complexity for a deprecated feature.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a363811aec7a..47df3f40a71c 100644
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
+			if (subprog[tmp].stack_arg_cnt) {
+				verbose(env, "tail_calls are not allowed in programs with stack args=
\n");
+				return -EINVAL;
+			}
 			subprog[tmp].tail_call_reachable =3D true;
 		}
+	} else if (!idx && subprog[0].has_tail_call && subprog[0].stack_arg_cnt=
) {
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

