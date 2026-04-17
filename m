Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3690E344020
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397681; cv=none; b=l973X+6DqGhx3BnUkkyUGuaV0Q7PsK7D+FqBeE/CFEkGlYdFlRJRXQiIprsutzNgiwGZn/uuaRnmMpDDZYjFgkjg1sSRDrW6Jemjw8Y2kQwngv0mkk7/9jYIhbC1HQUd0qysT2ax//GYtKPW0Xx6JALBjcSJ6yAp0sLu0+q78gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397681; c=relaxed/simple;
	bh=ALmXRnufhmrEdy27vJqyzRSBQCBU8LZ2L+enQvI7tjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6jo2pYE4PVqHW+vRGllm8rX448OAUEjmxR/hJHUe36TyS1GtD/D0LKtZCs5cc6od/U/FCY80UoPCkvs7+S2U/0qn2aSgvZbKycJBndfZJNHEFX0tIt2YdPIPTV2R7+DfgfXTzDgA0/sROf0AelQnYTlNUTDQKKVRId3OReHcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C46E9403C2445; Thu, 16 Apr 2026 20:47:49 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 10/16] bpf: Reject stack arguments if tail call reachable
Date: Thu, 16 Apr 2026 20:47:49 -0700
Message-ID: <20260417034749.2630580-1-yonghong.song@linux.dev>
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

Tailcalls are been deprecated. So reject stack arguments
if tail call is in the way.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7a65b532e84a..739c3127520c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5662,6 +5662,11 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
 				verbose(env, "cannot tail call within exception cb\n");
 				return -EINVAL;
 			}
+			if (subprog[tmp].incoming_stack_arg_depth ||
+			    subprog[tmp].outgoing_stack_arg_depth) {
+				verbose(env, "tail_calls are not allowed in programs with stack args=
\n");
+				return -EINVAL;
+			}
 			subprog[tmp].tail_call_reachable =3D true;
 		}
 	if (subprog[0].tail_call_reachable)
--=20
2.52.0

