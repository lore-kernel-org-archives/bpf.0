Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259F72EB87F
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776836531; cv=none; b=uFELLY7lpIYKCl0A9yIyjNF7r+vRxkoLXTv6Y6mHEtijZyCWdQgGDSrxgLlllV/8d16mytvyHcNVTLhlT/iMkWhR+Ji/eY9kyjDTjelo9TnaZ5y2YRrShSvWDE7n13vvLN2oo1f3XmJvHgoq+fzkJU9rAgBAcxFgWJi0KnqQESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776836531; c=relaxed/simple;
	bh=t+fxCP3SlN9IoaVd8+jplaaqGlsrzp4LqS+SX6xJeAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mw+Sq7skJd29d2SRDKrYi7KMpxnuJRu1HbiWPNhRF1Cv8Dy35KjMdCeaOC8KDjrC84OJLcOKnAen8PcvZjFnqtyr+mDkS8BpREBfI9cIfZ2hrGEx3r/zQk1IYFITHkG4f5KKfw586ZRJK7DFhLmsK/S6Sudb4ivLRou30zXx1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5617444D083B9; Tue, 21 Apr 2026 22:41:59 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 2/9] bpf: Fix tail_call_reachable leak
Date: Tue, 21 Apr 2026 22:41:59 -0700
Message-ID: <20260422054159.3124694-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260422054149.3124342-1-yonghong.song@linux.dev>
References: <20260422054149.3124342-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In check_max_stack_depth_subprog(), the local variable
tail_call_reachable is set when entering a callee that has a tail
call, but never reset when popping back to the parent. This causes
the flag to leak across sibling subprogs in the DFS traversal.

This results in unnecessary JIT overhead: the JIT emits tail call
counter preservation code for subprogs that can never be reached
via a tail call path.

Fix this by resetting tail_call_reachable to the parent's actual
per-subprog flag when popping a frame. If the parent was already
marked tail_call_reachable by a previous sibling's traversal, the
local variable stays true. Otherwise it resets to false, so
subsequent siblings start with a clean state.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a768359b22cb..34696af96b3e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5490,6 +5490,9 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
 	frame =3D dinfo[idx].frame;
 	i =3D dinfo[idx].ret_insn;
=20
+	/* reset tail_call_reachable to the parent's actual state */
+	tail_call_reachable =3D subprog[idx].tail_call_reachable;
+
 	goto continue_func;
 }
=20
--=20
2.52.0

