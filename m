Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E633D282F24
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616436; cv=none; b=WIBHoJEWNQdkN8qfpgYZpwiekN5GBnoo+2ICEStkpx3gJrVdx2t6FtOVS96Lsg10SvyM+Shf1sFmdGz9Xm7LOuo6zDVKXR2Rm5LtYKewZM6nRHt6A6+2c5Qanrx7LQKOsZx14gtkLq4x8VxFqO+/cSoPkkhkJh3jh1O9NDovX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616436; c=relaxed/simple;
	bh=sUMlpfc8OhC4xrUWn/Zj/2pPRrUwbtR8u7sadOx1TGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AX2b10slD7AEV4tlQGnLuENMb572gUIGAy12oJ8dQVr1CxiNXJmahntgC2722/PaTUPQKn6ZjkdQn5iVt7CQtJGYZZNmDht+h7yYfW+AdWwNr+8NNPazUPEYrpv15TAnSckb4Gw8dN2WhcHgQDX/b5iSFhKb7VfWWgrqJh2Yxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0B92D42DD4DA1; Sun, 19 Apr 2026 09:33:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 05/17] bpf: Introduce bpf register BPF_REG_PARAMS
Date: Sun, 19 Apr 2026 09:33:42 -0700
Message-ID: <20260419163342.733840-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260419163316.731019-1-yonghong.song@linux.dev>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce BPF_REG_PARAMS as a dedicated BPF register for stack
argument accesses. It occupies the BPF register number 11 (R11),
which is used as the base pointer for the stack argument area,
keeping it separate from the R10-based (BPF_REG_FP) program stack.

The kernel-internal hidden register BPF_REG_AX previously occupied
slot 11 (MAX_BPF_REG). With BPF_REG_PARAMS taking that slot,
BPF_REG_AX moves to slot 12 and MAX_BPF_EXT_REG increases
accordingly.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/filter.h                        |  5 +-
 kernel/bpf/core.c                             |  4 +-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 14 ++--
 .../bpf/progs/verifier_bpf_fastcall.c         | 24 +++----
 .../selftests/bpf/progs/verifier_may_goto_1.c | 12 ++--
 .../selftests/bpf/progs/verifier_sdiv.c       | 64 +++++++++----------
 6 files changed, 62 insertions(+), 61 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1ec6d5ba64cc..b77d0b06db6e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -58,8 +58,9 @@ struct ctl_table_header;
 #define BPF_REG_H	BPF_REG_9	/* hlen, callee-saved */
=20
 /* Kernel hidden auxiliary/helper register. */
-#define BPF_REG_AX		MAX_BPF_REG
-#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
+#define BPF_REG_PARAMS		MAX_BPF_REG
+#define BPF_REG_AX		(MAX_BPF_REG + 1)
+#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 2)
 #define MAX_BPF_JIT_REG		MAX_BPF_EXT_REG
=20
 /* unused opcode to mark special call to bpf_tail_call() helper */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8b018ff48875..ae10b9ca018d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1299,8 +1299,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn=
 *from,
 	u32 imm_rnd =3D get_random_u32();
 	s16 off;
=20
-	BUILD_BUG_ON(BPF_REG_AX  + 1 !=3D MAX_BPF_JIT_REG);
-	BUILD_BUG_ON(MAX_BPF_REG + 1 !=3D MAX_BPF_JIT_REG);
+	BUILD_BUG_ON(BPF_REG_PARAMS + 2 !=3D MAX_BPF_JIT_REG);
+	BUILD_BUG_ON(BPF_REG_AX + 1 !=3D MAX_BPF_JIT_REG);
=20
 	/* Constraints on AX register:
 	 *
diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools=
/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index 469e92869523..83d870e32239 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -69,19 +69,19 @@ static struct test_case test_cases[] =3D {
 #if defined(__x86_64__) || defined(__aarch64__)
 	{
 		N(SCHED_CLS, struct __sk_buff, tstamp),
-		.read  =3D "r11 =3D *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
-			 "if w11 & 0x4 goto pc+1;"
+		.read  =3D "r12 =3D *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
+			 "if w12 & 0x4 goto pc+1;"
 			 "goto pc+4;"
-			 "if w11 & 0x3 goto pc+1;"
+			 "if w12 & 0x3 goto pc+1;"
 			 "goto pc+2;"
 			 "$dst =3D 0;"
 			 "goto pc+1;"
 			 "$dst =3D *(u64 *)($ctx + sk_buff::tstamp);",
-		.write =3D "r11 =3D *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
-			 "if w11 & 0x4 goto pc+1;"
+		.write =3D "r12 =3D *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
+			 "if w12 & 0x4 goto pc+1;"
 			 "goto pc+2;"
-			 "w11 &=3D -4;"
-			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) =3D r11;"
+			 "w12 &=3D -4;"
+			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) =3D r12;"
 			 "*(u64 *)($ctx + sk_buff::tstamp) =3D $src;",
 	},
 #endif
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/=
tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index fb4fa465d67c..0d9e167555b5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -630,13 +630,13 @@ __xlated("...")
 __xlated("4: r0 =3D &(void __percpu *)(r0)")
 __xlated("...")
 /* may_goto expansion starts */
-__xlated("6: r11 =3D *(u64 *)(r10 -24)")
-__xlated("7: if r11 =3D=3D 0x0 goto pc+6")
-__xlated("8: r11 -=3D 1")
-__xlated("9: if r11 !=3D 0x0 goto pc+2")
-__xlated("10: r11 =3D -24")
+__xlated("6: r12 =3D *(u64 *)(r10 -24)")
+__xlated("7: if r12 =3D=3D 0x0 goto pc+6")
+__xlated("8: r12 -=3D 1")
+__xlated("9: if r12 !=3D 0x0 goto pc+2")
+__xlated("10: r12 =3D -24")
 __xlated("11: call unknown")
-__xlated("12: *(u64 *)(r10 -24) =3D r11")
+__xlated("12: *(u64 *)(r10 -24) =3D r12")
 /* may_goto expansion ends */
 __xlated("13: *(u64 *)(r10 -8) =3D r1")
 __xlated("14: exit")
@@ -668,13 +668,13 @@ __xlated("1: *(u64 *)(r10 -16) =3D")
 __xlated("2: r1 =3D 1")
 __xlated("3: call bpf_get_smp_processor_id")
 /* may_goto expansion starts */
-__xlated("4: r11 =3D *(u64 *)(r10 -24)")
-__xlated("5: if r11 =3D=3D 0x0 goto pc+6")
-__xlated("6: r11 -=3D 1")
-__xlated("7: if r11 !=3D 0x0 goto pc+2")
-__xlated("8: r11 =3D -24")
+__xlated("4: r12 =3D *(u64 *)(r10 -24)")
+__xlated("5: if r12 =3D=3D 0x0 goto pc+6")
+__xlated("6: r12 -=3D 1")
+__xlated("7: if r12 !=3D 0x0 goto pc+2")
+__xlated("8: r12 =3D -24")
 __xlated("9: call unknown")
-__xlated("10: *(u64 *)(r10 -24) =3D r11")
+__xlated("10: *(u64 *)(r10 -24) =3D r12")
 /* may_goto expansion ends */
 __xlated("11: *(u64 *)(r10 -8) =3D r1")
 __xlated("12: exit")
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/to=
ols/testing/selftests/bpf/progs/verifier_may_goto_1.c
index 6d1edaef9213..4bdf4256a41e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -81,13 +81,13 @@ __arch_s390x
 __arch_arm64
 __xlated("0: *(u64 *)(r10 -16) =3D 65535")
 __xlated("1: *(u64 *)(r10 -8) =3D 0")
-__xlated("2: r11 =3D *(u64 *)(r10 -16)")
-__xlated("3: if r11 =3D=3D 0x0 goto pc+6")
-__xlated("4: r11 -=3D 1")
-__xlated("5: if r11 !=3D 0x0 goto pc+2")
-__xlated("6: r11 =3D -16")
+__xlated("2: r12 =3D *(u64 *)(r10 -16)")
+__xlated("3: if r12 =3D=3D 0x0 goto pc+6")
+__xlated("4: r12 -=3D 1")
+__xlated("5: if r12 !=3D 0x0 goto pc+2")
+__xlated("6: r12 =3D -16")
 __xlated("7: call unknown")
-__xlated("8: *(u64 *)(r10 -16) =3D r11")
+__xlated("8: *(u64 *)(r10 -16) =3D r12")
 __xlated("9: r0 =3D 1")
 __xlated("10: r0 =3D 2")
 __xlated("11: exit")
diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/te=
sting/selftests/bpf/progs/verifier_sdiv.c
index fd59d57e8e37..95f3239ce228 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -778,10 +778,10 @@ __arch_x86_64
 __xlated("0: r2 =3D 0x8000000000000000")
 __xlated("2: r3 =3D -1")
 __xlated("3: r4 =3D r2")
-__xlated("4: r11 =3D r3")
-__xlated("5: r11 +=3D 1")
-__xlated("6: if r11 > 0x1 goto pc+4")
-__xlated("7: if r11 =3D=3D 0x0 goto pc+1")
+__xlated("4: r12 =3D r3")
+__xlated("5: r12 +=3D 1")
+__xlated("6: if r12 > 0x1 goto pc+4")
+__xlated("7: if r12 =3D=3D 0x0 goto pc+1")
 __xlated("8: r2 =3D 0")
 __xlated("9: r2 =3D -r2")
 __xlated("10: goto pc+1")
@@ -812,10 +812,10 @@ __success __retval(-5)
 __arch_x86_64
 __xlated("0: r2 =3D 5")
 __xlated("1: r3 =3D -1")
-__xlated("2: r11 =3D r3")
-__xlated("3: r11 +=3D 1")
-__xlated("4: if r11 > 0x1 goto pc+4")
-__xlated("5: if r11 =3D=3D 0x0 goto pc+1")
+__xlated("2: r12 =3D r3")
+__xlated("3: r12 +=3D 1")
+__xlated("4: if r12 > 0x1 goto pc+4")
+__xlated("5: if r12 =3D=3D 0x0 goto pc+1")
 __xlated("6: r2 =3D 0")
 __xlated("7: r2 =3D -r2")
 __xlated("8: goto pc+1")
@@ -890,10 +890,10 @@ __arch_x86_64
 __xlated("0: w2 =3D -2147483648")
 __xlated("1: w3 =3D -1")
 __xlated("2: w4 =3D w2")
-__xlated("3: r11 =3D r3")
-__xlated("4: w11 +=3D 1")
-__xlated("5: if w11 > 0x1 goto pc+4")
-__xlated("6: if w11 =3D=3D 0x0 goto pc+1")
+__xlated("3: r12 =3D r3")
+__xlated("4: w12 +=3D 1")
+__xlated("5: if w12 > 0x1 goto pc+4")
+__xlated("6: if w12 =3D=3D 0x0 goto pc+1")
 __xlated("7: w2 =3D 0")
 __xlated("8: w2 =3D -w2")
 __xlated("9: goto pc+1")
@@ -925,10 +925,10 @@ __arch_x86_64
 __xlated("0: w2 =3D -5")
 __xlated("1: w3 =3D -1")
 __xlated("2: w4 =3D w2")
-__xlated("3: r11 =3D r3")
-__xlated("4: w11 +=3D 1")
-__xlated("5: if w11 > 0x1 goto pc+4")
-__xlated("6: if w11 =3D=3D 0x0 goto pc+1")
+__xlated("3: r12 =3D r3")
+__xlated("4: w12 +=3D 1")
+__xlated("5: if w12 > 0x1 goto pc+4")
+__xlated("6: if w12 =3D=3D 0x0 goto pc+1")
 __xlated("7: w2 =3D 0")
 __xlated("8: w2 =3D -w2")
 __xlated("9: goto pc+1")
@@ -1004,10 +1004,10 @@ __arch_x86_64
 __xlated("0: r2 =3D 0x8000000000000000")
 __xlated("2: r3 =3D -1")
 __xlated("3: r4 =3D r2")
-__xlated("4: r11 =3D r3")
-__xlated("5: r11 +=3D 1")
-__xlated("6: if r11 > 0x1 goto pc+3")
-__xlated("7: if r11 =3D=3D 0x1 goto pc+3")
+__xlated("4: r12 =3D r3")
+__xlated("5: r12 +=3D 1")
+__xlated("6: if r12 > 0x1 goto pc+3")
+__xlated("7: if r12 =3D=3D 0x1 goto pc+3")
 __xlated("8: w2 =3D 0")
 __xlated("9: goto pc+1")
 __xlated("10: r2 s%=3D r3")
@@ -1034,10 +1034,10 @@ __arch_x86_64
 __xlated("0: r2 =3D 5")
 __xlated("1: r3 =3D -1")
 __xlated("2: r4 =3D r2")
-__xlated("3: r11 =3D r3")
-__xlated("4: r11 +=3D 1")
-__xlated("5: if r11 > 0x1 goto pc+3")
-__xlated("6: if r11 =3D=3D 0x1 goto pc+3")
+__xlated("3: r12 =3D r3")
+__xlated("4: r12 +=3D 1")
+__xlated("5: if r12 > 0x1 goto pc+3")
+__xlated("6: if r12 =3D=3D 0x1 goto pc+3")
 __xlated("7: w2 =3D 0")
 __xlated("8: goto pc+1")
 __xlated("9: r2 s%=3D r3")
@@ -1108,10 +1108,10 @@ __arch_x86_64
 __xlated("0: w2 =3D -2147483648")
 __xlated("1: w3 =3D -1")
 __xlated("2: w4 =3D w2")
-__xlated("3: r11 =3D r3")
-__xlated("4: w11 +=3D 1")
-__xlated("5: if w11 > 0x1 goto pc+3")
-__xlated("6: if w11 =3D=3D 0x1 goto pc+4")
+__xlated("3: r12 =3D r3")
+__xlated("4: w12 +=3D 1")
+__xlated("5: if w12 > 0x1 goto pc+3")
+__xlated("6: if w12 =3D=3D 0x1 goto pc+4")
 __xlated("7: w2 =3D 0")
 __xlated("8: goto pc+1")
 __xlated("9: w2 s%=3D w3")
@@ -1140,10 +1140,10 @@ __arch_x86_64
 __xlated("0: w2 =3D -5")
 __xlated("1: w3 =3D -1")
 __xlated("2: w4 =3D w2")
-__xlated("3: r11 =3D r3")
-__xlated("4: w11 +=3D 1")
-__xlated("5: if w11 > 0x1 goto pc+3")
-__xlated("6: if w11 =3D=3D 0x1 goto pc+4")
+__xlated("3: r12 =3D r3")
+__xlated("4: w12 +=3D 1")
+__xlated("5: if w12 > 0x1 goto pc+3")
+__xlated("6: if w12 =3D=3D 0x1 goto pc+4")
 __xlated("7: w2 =3D 0")
 __xlated("8: goto pc+1")
 __xlated("9: w2 s%=3D w3")
--=20
2.52.0

