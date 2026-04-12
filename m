Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755928D8DB
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775970013; cv=none; b=Vmxl5YDyZCPbi6RewxqrbSj9xkPN5ThgStI3ulBfksF7MNy8D+nrBqqEmMxTtpEi4EglY/cVRjdo3+q5Yz6lLZK8m3pyjbvpuQLLEye7b3SWf2LW+UoSdmybV4lL+/48yuAcd/P9LYG4gccPsjJVyvqYi1gw5dpbaSKoJbSB4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775970013; c=relaxed/simple;
	bh=NjH3i6VRWsHzXrq8rkEX7F+xcP5a1I9aKopT7yQrWXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlitO3niiz6mPNF99YImrAZ1aeKxc9wBdY1yD45UBAik2Czcdj/ZLhiaOtQS9I/qthbVLZEMfC1TwaKn0l64XiGDZbZQCK8lLu3HLgSotcWkU/QoTo/aW+0+JSVgjGMwCrtQDMytmTajPHIY+BShzRf/3bZGLDIlVa0/fbeVfUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8591C3B021BA6; Sat, 11 Apr 2026 22:00:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 10/18] bpf: Fix interaction between stack argument PTR_TO_STACK and dead slot poisoning
Date: Sat, 11 Apr 2026 22:00:00 -0700
Message-ID: <20260412050000.262030-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412045826.254200-1-yonghong.song@linux.dev>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The "poison dead stack slots" mechanism (commit 2cb27158adb3) uses
static liveness analysis to identify dead stack slots and poisons them
as a safety check. However, the static liveness pass cannot track
indirect stack references through pointers passed via stack arguments.

For register-passed PTR_TO_STACK (e.g., R1 =3D fp-8 passed to a static
subprog), the liveness abstract tracker carries frame/offset info
through registers. When the callee dereferences R1, the tracker
attributes the read to the parent frame's stack slot, correctly marking
it alive. So no poisoning issue arises.

For stack-argument-passed PTR_TO_STACK (e.g., fp-8 stored via
*(r12-8) =3D r1), the value goes through BPF_REG_STACK_ARG_BASE (r12)
which the liveness pass does not track. When the callee loads the
pointer from its incoming stack arg and dereferences it, the liveness
pass cannot attribute the read back to the parent frame. The parent's
stack slot is determined dead and poisoned before the callee even
starts. The callee's subsequent dereference then fails with "slot
poisoned by dead code elimination".

Fix this by allowing STACK_POISON reads in check_stack_read_fixed_off()
when the read targets a parent frame's stack (reg_state !=3D state).
Same-frame STACK_POISON reads remain rejected to preserve the safety
check for real liveness bugs. Cross-frame reads are safe to allow
because:
  - The pointer to the parent's stack was already validated by the
    verifier.
  - The slot contained valid data before being (incorrectly) poisoned.
  - The read returns an unknown scalar, which is conservative.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e664d924e8d4..bfeecd73e66e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5764,6 +5764,13 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
 					}
 					if (type =3D=3D STACK_INVALID && env->allow_uninit_stack)
 						continue;
+					/*
+					 * Cross-frame reads may hit slots poisoned by dead code eliminatio=
n.
+					 * Static liveness can't track indirect references through pointers=
,
+					 * so allow the read conservatively.
+					 */
+					if (type =3D=3D STACK_POISON && reg_state !=3D state)
+						continue;
 					if (type =3D=3D STACK_POISON) {
 						verbose(env, "reading from stack off %d+%d size %d, slot poisoned =
by dead code elimination\n",
 							off, i, size);
@@ -5819,6 +5826,8 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 				continue;
 			if (type =3D=3D STACK_INVALID && env->allow_uninit_stack)
 				continue;
+			if (type =3D=3D STACK_POISON && reg_state !=3D state)
+				continue;
 			if (type =3D=3D STACK_POISON) {
 				verbose(env, "reading from stack off %d+%d size %d, slot poisoned by=
 dead code elimination\n",
 					off, i, size);
--=20
2.52.0

