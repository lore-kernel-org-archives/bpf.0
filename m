Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAF23EFFC7
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885468; cv=none; b=lzywfJtEHpCQy/UBEleycgiv4hDQdghK4UcVZeo+Jxy+oXP8liXLoHbyivwRrJoAL+ivDCUYgQTV9Bd9ZA7jj0XfNFqiIzu3c9S/v9jHE76WrB8LELrSl6j8JWs4fFEVg3UpgGLdMVrsvXNL4QLGAR8Tc2b/n/1WM7mwy5SAw9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885468; c=relaxed/simple;
	bh=OU4sN1cMpZ/SOlNH1vjQUHibXyeXko1wpI2PBI9K8Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWY8Eunxm0oe6j969eR9QbUSYlbKpj1VRBANHst36HY5iv8kL5WQJ/8UXIwU7FDJ6y00E+gCrk39luCFpibHMLAlIslGdd+ar+M9q14jA2YsNhUVbxcUEGkSoQtah1mb/VcGpwXjvWM1ieeDCxGqA4cb6caJpHQ8pzUHv+yD20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 425FAC060ED25; Fri, 15 May 2026 15:50:56 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 4/7] bpf: Fix arg_track_join log to use sa prefix for stack arg slots
Date: Fri, 15 May 2026 15:50:56 -0700
Message-ID: <20260515225056.823086-1-yonghong.song@linux.dev>
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

arg_track_join() logs state transitions at CFG merge points. For
stack arg slots (r >=3D MAX_BPF_REG), it printed "r11:", "r12:", etc.,
which is misleading since r11 is a special register (BPF_REG_PARAMS)
not meaningful to the user.

Fix it to print "sa0:", "sa1:", etc., matching the per-instruction
transition log in arg_track_log() which already uses the "sa" prefix.

Update the existing stack_arg_pruning_type_mismatch selftest to expect
the corrected format.

Fixes: 2af4e792773f ("bpf: Extend liveness analysis to track stack argume=
nt slots")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/liveness.c                                  | 4 +++-
 tools/testing/selftests/bpf/progs/verifier_stack_arg.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 7f4a0e4c2c49..0aadfbae0acc 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -806,7 +806,9 @@ static bool arg_track_join(struct bpf_verifier_env *e=
nv, int idx, int target, in
 		return true;
=20
 	verbose(env, "arg JOIN insn %d -> %d ", idx, target);
-	if (r >=3D 0)
+	if (r >=3D MAX_BPF_REG)
+		verbose(env, "sa%d: ", r - MAX_BPF_REG);
+	else if (r >=3D 0)
 		verbose(env, "r%d: ", r);
 	else
 		verbose(env, "fp%+d: ", r * 8);
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_arg.c
index df0c3438529e..7e0ce5db28a0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -117,7 +117,7 @@ __description("stack_arg: pruning with different stac=
k arg types")
 __failure __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 __msg("arg JOIN insn 9 -> 10 r1: fp0-8 + _ =3D> fp0-8|fp0+0")
-__msg("arg JOIN insn 9 -> 10 r11: fp0-8 + _ =3D> fp0-8|fp0+0")
+__msg("arg JOIN insn 9 -> 10 sa0: fp0-8 + _ =3D> fp0-8|fp0+0")
 __msg("R{{[0-9]}} invalid mem access 'scalar'")
 __naked void stack_arg_pruning_type_mismatch(void)
 {
--=20
2.53.0-Meta

