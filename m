Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84E2D9EFF
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791992; cv=none; b=YE6qSR0VIm/75WDspI4lTmpZnIcE++IqAKUGSE8DBJPN29KNOG+xcSOjgFvtHalvB0TOOe36BqHNHwGUZqms/3s8DW0gBn9DvA8GxKP/S9wK2dt/e665DqTnglC69suGelIoErl4x2V+zTZIrW3POQ5iYQ8vJDiZZAOXUqzD77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791992; c=relaxed/simple;
	bh=+LrcLTx9KKYW2KBkwBOlSK7/MpiuBMqJiLEbzwATJB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9YhMOs9YMyrQJkYGu7CSESju0PV/YKjBj9N9h4jFMbYi0dSZzApHIgSH0c9prb9d+dseCh4mUPQoEC8Pcr87fwpKCmj9QNNJgD7aUSwvBZzWYuOXHVek6een5ZcovQduQaY7/QZ691xLOAfgC5k5vH74eKsG893EyYi+5NNMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5456F44B2794D; Tue, 21 Apr 2026 10:19:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/9] bpf: Fix tail_call_reachable leak
Date: Tue, 21 Apr 2026 10:19:37 -0700
Message-ID: <20260421171937.3508679-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421171927.3507554-1-yonghong.song@linux.dev>
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
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

