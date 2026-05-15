Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A135E1A9
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885465; cv=none; b=XBvohBzLsN9P19g/DJGBnxs7AWpFCMVY3Dkb6VbENNfEY4XdHBGSEWtolHN54c0yhmznKpAcUj+p1Gf2y84Vx9vX+9/tO9l+xtLkvfLZ9gt8Nd0qSojKSELz5n2ufPwVxnfcF5CkgJUfuvee64uWuOfoPGKSarxicLXRBnrBN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885465; c=relaxed/simple;
	bh=sfTxB0fNyL0/4BQcy/vUqvovtFmL+6aHN2GN35XRuc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgLmowmcm3P7qbpBnpaqkcvAyOppCb0GZPq3iFjIq9qHjzLq7COVI/kUF937eqbAn8FnuNP1HkU5PgLzdH/toPRE8EpqdaSgrLMb9T2TxIOWSHAsGUBGEWMBXzFBX9Y+IJZ1wKCpiYpthfwriqW83l1uyKC77MnWm4lH4RFHo08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0DAFBC060B710; Fri, 15 May 2026 15:50:51 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 3/7] selftests/bpf: Log arg_track_join for stack arg slots in liveness analysis
Date: Fri, 15 May 2026 15:50:51 -0700
Message-ID: <20260515225051.822739-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515225035.821178-1-yonghong.song@linux.dev>
References: <20260515225035.821178-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 2af4e792773f ("bpf: Extend liveness analysis to track stack argume=
nt slots")
added stack arg supports. For selftest
  verifier_stack_arg/stack_arg: pruning with different stack arg types
the following are two arg JOIN messages:
  arg JOIN insn 9 -> 10 r1: fp0-8 + _ =3D> fp0-8|fp0+0
  arg JOIN insn 9 -> 10 r11: fp0-8 + _ =3D> fp0-8|fp0+0

Here the "r11:" label for stack arg slot 0 is misleading since r11
is a special register (BPF_REG_PARAMS). The next patch corrects
this to "sa0:", properly representing the 'stack arg slot 0'.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/verifier_stack_arg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_arg.c
index d45339b83795..df0c3438529e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -114,8 +114,10 @@ __naked void stack_arg_gap_at_minus8(void)
=20
 SEC("tc")
 __description("stack_arg: pruning with different stack arg types")
-__failure
+__failure __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
+__msg("arg JOIN insn 9 -> 10 r1: fp0-8 + _ =3D> fp0-8|fp0+0")
+__msg("arg JOIN insn 9 -> 10 r11: fp0-8 + _ =3D> fp0-8|fp0+0")
 __msg("R{{[0-9]}} invalid mem access 'scalar'")
 __naked void stack_arg_pruning_type_mismatch(void)
 {
--=20
2.53.0-Meta

