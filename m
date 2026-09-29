Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CECE30EF9A
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641025; cv=none; b=hqMFGoZb2goT43tmns28f6ugf9bOwYT++nMMOKyE9pWyyGDAJxySkjMtmmvakt7xZ4M/o+i0qnLjF65ni/mtHsRZ0lqwR0W5ovHeyFnFhKZNdwTffVIar7IWsvsaShh/FVQiKDaGIxkjUfdZ7U+Zabw/aWeFVOZz9K6QlAzCSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641025; c=relaxed/simple;
	bh=WQYNFZdOkdqadZgf/LyWkr3lCwyKROa4vBHkAbwf1+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCRYNmqIr1LMs9712a556/tR8K4iB4yqrkFtxQ/z/4wUgZKDpNZI6fBlg+WMqLr/dFyOIfilggRNdCOCtpBr/2m2SGB8HogRQz9q+xWTSqIHn12hsAtBHjY+9eJ25cnleAPOiAUyVwucZy9m2cMPnZZVosqWa+pICpWAla3pcwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C1D0D2DE06BEF5; Mon, 28 Sep 2026 17:16:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 10/22] bpf: Refuse a private stack for a program that can unwind
Date: Mon, 28 Sep 2026 17:16:53 -0700
Message-ID: <20260929001653.3250454-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929001601.3242665-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

x86-64 has no register to spare for this. A private stack keeps its frame
pointer in r9 and the JIT brackets every call in push_r9/pop_r9, but an
unwind resumes a frame at its landing pad rather than at the instruction
after the call, so the pad is reached before the pop runs and would addre=
ss
its frame through a stale pointer.

So no private stack for a program that can unwind, on every architecture
rather than just that one. A table is not the condition: a bpf_unwind()
with no record over it sends its callers to their epilogues just the same=
.
In check_max_stack_depth(), force NO_PRIV_STACK so the JIT does not use a
private stack.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 49aa76c1ea9f..0419609beb67 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5751,6 +5751,17 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 		}
 	}
=20
+	/*
+	 * x86-64 has no register to spare for this: a private stack keeps its
+	 * frame pointer in r9, restored by a pop after the call that an unwind
+	 * skips. A frame resumed at a pad then addresses its stack through a
+	 * stale pointer, and a frame sent to its epilogue instead pops its
+	 * callee-saved registers one slot off. Refuse a private stack for any
+	 * program that can unwind, on every arch for now.
+	 */
+	if (env->cleanup_info_cnt || bpf_prog_may_unwind(env))
+		priv_stack_mode =3D NO_PRIV_STACK;
+
 	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
 		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
=20
--=20
2.53.0-Meta

