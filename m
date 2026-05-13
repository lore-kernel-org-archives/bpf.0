Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA62D5436
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647882; cv=none; b=Z/4TFP3/y7cd+PJ2thGCgA5TS41JDoextssc3I9mclfYMDYdCQyWJX9ZFvrKh+u+4bhMvTmMryWScFmlDux5BHBd7VB22EmcZVdUxp+A54OCmKQQrPH9fZDNzLoVsp7ilsPLrC09YNrhDtd8ILFS0vISHQEjWVjbM/QgQIaHLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647882; c=relaxed/simple;
	bh=2RDAlx1faX/H8e46f2YdTHFYeFjWcBfN4FejGE4UyZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMAxZEHRyhtOaFf/UiJeOrtFmdCPxBHXUNXwEsfRhqTwC/1TVwmQlGQv+SzD6MZVF47OQNrLJL8QE7W52FkWPX3nCfbwLa59dNiLbXEz7yH4IweaM4RHrJuGQeTtMzAbH3eypvjwH+EkRSgJ1I9QntAWY2+eT/ecqtuA0Oyz7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9DA55B1981D4D; Tue, 12 May 2026 21:51:14 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 16/25] bpf: Disable private stack for x86_64 if stack arguments used
Date: Tue, 12 May 2026 21:51:14 -0700
Message-ID: <20260513045114.2392291-1-yonghong.song@linux.dev>
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

Other architectures like arm64, riscv, etc. have enough register
and for them private stack can be used together with
stack arguments.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 47df3f40a71c..745e13cfb54d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5163,7 +5163,10 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
 	}
=20
 	subprog_depth =3D round_up_stack_depth(env, subprog[idx].stack_depth);
-	if (priv_stack_supported) {
+	if (IS_ENABLED(CONFIG_X86_64) && subprog[idx].stack_arg_cnt) {
+		/* x86-64 uses R9 for both private stack frame pointer and arg6. */
+		subprog[idx].priv_stack_mode =3D NO_PRIV_STACK;
+	} else if (priv_stack_supported) {
 		/* Request private stack support only if the subprog stack
 		 * depth is no less than BPF_PRIV_STACK_MIN_SIZE. This is to
 		 * avoid jit penalty if the stack usage is small.
--=20
2.53.0-Meta

