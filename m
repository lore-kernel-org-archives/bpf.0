Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B32F60B2
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861475; cv=none; b=ccjWGF7QLvLPSc9AH7GqDt7KYmQYTz7XwDSqqOSPuTcpF6cXDHDfNkjUghqrXqsHqPlYp7kD70S4Pzj5Ff/Djzr9gl9KJQf/wL6H5ao5RQ8IccA3TddWbY6+H2kMaO56hZmugGuVeKl2BCPu/eRW+jIJYkm4171hKlKA2+/iivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861475; c=relaxed/simple;
	bh=7xf7viwDnqg46b4CsRYOIpB+DsClnKp1Oc97xcBoeME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6xujFaexzbQXHmT0tM4jQsKZOz4IeeAMV6gdeV9WKCRSbZiv82mFsstxi6T6lnn5Z1WBqlmV6BRUe0rtbR6L+zQ52VRM2AIjXY9TbhfkgvgUJuRIOQW54YlbV1WpLQNoqsOfVyvM4gLatX+vEjVqrX+mzNI3yK+hK7gSoccDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 074042E6E0BC7F; Thu,  1 Oct 2026 06:30:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 10/22] bpf: Do not use a private stack for a program that can unwind
Date: Thu,  1 Oct 2026 06:30:57 -0700
Message-ID: <20261001133058.1340406-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001133006.1335369-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A private stack keeps its frame pointer in %r9 on x86-64, and the JIT
brackets every call in push_r9/pop_r9. An unwind skips the pop: a frame
resumed at its landing pad addresses its stack through a stale pointer,
and one sent to its epilogue pops its callee-saved registers one slot off=
.

So no private stack for a program that can unwind, on every architecture
rather than just that one. A table is not the only condition: a
bpf_unwind() with no record over it sends its callers to their epilogues
just the same. In check_max_stack_depth(), force NO_PRIV_STACK so the JIT
does not use a private stack.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f3ed68960d70..488ceb9dae1b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5769,6 +5769,17 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 		}
 	}
=20
+	/*
+	 * A private stack keeps its frame pointer in %r9 on x86-64, restored
+	 * by a pop after the call that an unwind skips. A frame resumed at a
+	 * pad then addresses its stack through a stale pointer, and a frame
+	 * sent to its epilogue instead pops its callee-saved registers one
+	 * slot off. Refuse a private stack for any program that can unwind,
+	 * on every arch for now.
+	 */
+	if (env->cleanup_info_cnt || bpf_prog_may_unwind(env))
+		priv_stack_mode =3D NO_PRIV_STACK;
+
 	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
 		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
=20
--=20
2.53.0-Meta

