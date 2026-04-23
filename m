Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43946263C7F
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915289; cv=none; b=qtLoCAqLcRFfDwbYG2pMS7B5ykk12QcBJF9WFeEGd4VN8Wg1cXI0kSocFQiHwai+0OtBA81JbEm7FenO7SAxf1dYjvlKGyYhbIOWneDl2F6GeSfzay7BkLlUHXU6NEu/96wfMJ1l1ZN2GWb1Lh7LoPS4jz1h1pb8p09fmm7So/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915289; c=relaxed/simple;
	bh=3CzPbmikq+HAEnn/2ovXyJYOExQlDP6pFZKJuxPK1mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TY6VvGKL37PSJzSsy/gMAHPQT128Bmz0M50UIQ9+8j0SeAEXfQ/t3x+8uCFS7scv7n/qWOn7wAWlXlT0s+d/OgHXUc3OEQwlK3sDGtMQ+SrOEU8NXZaDLAEymOsVTUCXIB/Qj/POycloDsk1gB1lijQKTvAQhEfV2po3b5zBeU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id F093045844AE0; Wed, 22 Apr 2026 20:34:35 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 2/9] bpf: Fix tail_call_reachable leak
Date: Wed, 22 Apr 2026 20:34:35 -0700
Message-ID: <20260423033435.2538013-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423033425.2536883-1-yonghong.song@linux.dev>
References: <20260423033425.2536883-1-yonghong.song@linux.dev>
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
index 6118743d87e6..26b6cdfd8613 100644
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

