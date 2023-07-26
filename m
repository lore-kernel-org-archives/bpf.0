Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBD198AC
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 22:24:40 +0000 (UTC)
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B681BFF
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 15:24:38 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D930B23B79CBD; Wed, 26 Jul 2023 15:07:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: David Faust <david.faust@oracle.com>,
	Fangrui Song <maskray@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 04/17] bpf: Support new unconditional bswap instruction
Date: Wed, 26 Jul 2023 15:07:47 -0700
Message-Id: <20230726220747.1092893-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726220726.1089817-1-yonghong.song@linux.dev>
References: <20230726220726.1089817-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
	SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The existing 'be' and 'le' insns will do conditional bswap
depends on host endianness. This patch implements
unconditional bswap insns.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c |  1 +
 kernel/bpf/core.c           | 14 ++++++++++++++
 kernel/bpf/verifier.c       |  7 +++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 031ef3c4185d..4942a4c188b9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1322,6 +1322,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 			break;
=20
 		case BPF_ALU | BPF_END | BPF_FROM_BE:
+		case BPF_ALU64 | BPF_END | BPF_FROM_LE:
 			switch (imm32) {
 			case 16:
 				/* Emit 'ror %ax, 8' to swap lower 2 bytes */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c37c454b09eb..ad58697cec4b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1524,6 +1524,7 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
 	INSN_3(ALU64, DIV,  X),			\
 	INSN_3(ALU64, MOD,  X),			\
 	INSN_2(ALU64, NEG),			\
+	INSN_3(ALU64, END, TO_LE),		\
 	/*   Immediate based. */		\
 	INSN_3(ALU64, ADD,  K),			\
 	INSN_3(ALU64, SUB,  K),			\
@@ -1848,6 +1849,19 @@ static u64 ___bpf_prog_run(u64 *regs, const struct=
 bpf_insn *insn)
 			break;
 		}
 		CONT;
+	ALU64_END_TO_LE:
+		switch (IMM) {
+		case 16:
+			DST =3D (__force u16) __swab16(DST);
+			break;
+		case 32:
+			DST =3D (__force u32) __swab32(DST);
+			break;
+		case 64:
+			DST =3D (__force u64) __swab64(DST);
+			break;
+		}
+		CONT;
=20
 	/* CALL */
 	JMP_CALL:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7a6945be07e3..a3dcaeed8217 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3012,8 +3012,10 @@ static bool is_reg64(struct bpf_verifier_env *env,=
 struct bpf_insn *insn,
 		}
 	}
=20
+	if (class =3D=3D BPF_ALU64 && op =3D=3D BPF_END && (insn->imm =3D=3D 16=
 || insn->imm =3D=3D 32))
+		return false;
+
 	if (class =3D=3D BPF_ALU64 || class =3D=3D BPF_JMP ||
-	    /* BPF_END always use BPF_ALU class. */
 	    (class =3D=3D BPF_ALU && op =3D=3D BPF_END && insn->imm =3D=3D 64))
 		return true;
=20
@@ -13076,7 +13078,8 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 		} else {
 			if (insn->src_reg !=3D BPF_REG_0 || insn->off !=3D 0 ||
 			    (insn->imm !=3D 16 && insn->imm !=3D 32 && insn->imm !=3D 64) ||
-			    BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
+			    (BPF_CLASS(insn->code) =3D=3D BPF_ALU64 &&
+			     BPF_SRC(insn->code) !=3D BPF_TO_LE)) {
 				verbose(env, "BPF_END uses reserved fields\n");
 				return -EINVAL;
 			}
--=20
2.34.1

