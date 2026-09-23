Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFB3DDB1D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139577; cv=none; b=gH0XKquOnp6wfkHSaY3F2SRw905AeSnMca4k/lodMfYniX9t14jbwbmBA6pCJ+oGvyLV7/mcxp+W/GBC1pDIjcBGM6N4RjRa0yMGqDBQNcylQz65OHmFsZI78U5VlPd/fRJ3Jytv9Jq9gv7yKC4sYfpBHcY4ex0PtdspRsKdKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139577; c=relaxed/simple;
	bh=XZZn6A0qN0uXeum+fNBsxxS9GBBKFJoe84le8zGTMtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIg6zj3ItRX8zNaeNPpOwGqF8jnrnbruN0xs6ZaiWuAMNVsjmSuWZz1lJ2yatkgLBe2ZfltCfqrFVV/nFv0GLwfGm3SXie0mcj5RPMoowPPAiiXvBVx3XJORLtIwNozim/EJ1T6JSvSY9tNFINSjTtSf+Y5wfTyxlXrqRFZSiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6DC0C2C8DA5A5D; Tue, 22 Sep 2026 21:59:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call site reaches
Date: Tue, 22 Sep 2026 21:59:22 -0700
Message-ID: <20260923045922.2417689-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A cleanup record need not cover a call an exception can unwind out of: a
frontend is free to emit a region around a helper or an ordinary kfunc,
both nounwind here. Nothing marks a call site then, and that record's
landing pad is reached by nothing at all -- leaving bpf_check_cfg() to
refuse the program over code its own frontend had no way not to emit:

   0: call bpf_preempt_disable
   1: call bpf_preempt_enable      record =3D { begin =3D 1, end =3D 2, p=
ad =3D 4 }
   2: r0 =3D 0
   3: exit
   4: r1 =3D pads_ran ll             landing pad
   6: r2 =3D *(u64 *)(r1 + 0)
   7: r2 |=3D RAN_NOUNWIND_REC
   8: *(u64 *)(r1 + 0) =3D r2
   9: call bpf_unwind_resume
  10: exit

The range [1,2) holds one call, and it is a kfunc, so an exception cannot
come out of it. mark_call_sites() marks nothing, nothing pushes an edge t=
o
4, and 4 through 10 are reachable from nothing: "unreachable insn 4". The
pad is dead, which is correct -- no exception can ever arrive at it -- bu=
t
the program is fine and has to load.

Walk every pad the table names that the edges did not reach, the way the
walk is already re-seeded at an exception callback. From there the pad is
code like any other: do_check() never enters it, because no call site
dispatches to it, so the dead code sweep removes it along with everything
else that was not reached.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/cfg.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index aa56d38f2e37..1c3b4165e18c 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -640,6 +640,7 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 	int insn_cnt =3D env->prog->len;
 	int *insn_stack, *insn_state;
 	int ex_insn_beg, i, ret =3D 0;
+	u32 pad_idx =3D 0;
=20
 	insn_state =3D env->cfg.insn_state =3D kvzalloc_objs(int, insn_cnt,
 							 GFP_KERNEL_ACCOUNT);
@@ -695,6 +696,22 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 		goto walk_cfg;
 	}
=20
+	/*
+	 * A landing pad no call site was marked with -- a record whose range
+	 * holds no bpf2bpf call and no bpf_throw() -- is reached by nothing.
+	 * Walk it from here, and let the dead code sweep remove it.
+	 */
+	while (pad_idx < env->cleanup_info_cnt) {
+		u32 pad =3D env->cleanup_info[pad_idx++].landing_pad_off;
+
+		if (insn_state[pad] !=3D EXPLORED) {
+			insn_state[pad] =3D DISCOVERED;
+			insn_stack[0] =3D pad;
+			env->cfg.cur_stack =3D 1;
+			goto walk_cfg;
+		}
+	}
+
 	for (i =3D 0; i < insn_cnt; i++) {
 		struct bpf_insn *insn =3D &env->prog->insnsi[i];
=20
--=20
2.53.0-Meta

