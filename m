Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B951D5AD4
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050925; cv=none; b=JLP9aeDhyPLojfbv+Kp6eZ0Gd6X8UXVqdZLxIfy009sR98oNeGpau9WbWx0txsXuk8UsEvOCN0wSpcRVXbeN1jsaU473dO8JJ9FSmM9SJ3psg1pcYJ6bFrmWqdz15TLQHEP8yMaHIDsXm6Vxvf93LxMFFf1LodlNES516q0cT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050925; c=relaxed/simple;
	bh=udRPt9fojCh88gtjtNZMS35OFwiMAVV7G4DwERNgHx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfMgGqFzjOArCnYm2ON/QwkG11VyOYdNKG/Wo07zUcADhunUreNz6PuuZj71j2Szbe5Jo0D/6DNdcEVytfaj9Pz35nOJlaNGRlMhpxxNpIxvb698RbNOReanmW8e/Ml1OZstTHzxzDKWx9L0U4YuNctOsHZzenB2Bm5T3aB/CKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B72AE474A655C; Fri, 24 Apr 2026 10:15:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 09/18] bpf: Reject stack arguments if tail call reachable
Date: Fri, 24 Apr 2026 10:15:19 -0700
Message-ID: <20260424171519.2042600-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424171433.2034470-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
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
index 43aeb04f488a..3a15c5c19db0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5487,6 +5487,11 @@ struct bpf_subprog_call_depth_info {
 	int frame; /* # of consecutive static call stack frames on top of stack=
 */
 };
=20
+static bool subprog_has_stack_args(const struct bpf_subprog_info *si)
+{
+	return si->stack_arg_depth;
+}
+
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
@@ -5640,14 +5645,23 @@ static int check_max_stack_depth_subprog(struct b=
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

