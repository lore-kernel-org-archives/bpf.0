Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE215478D
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616466; cv=none; b=D9vt2/fzUsQLxUCy/GyqpJqoo9QwibW47t+56UTbnPAiVqpkufLtuCHD9YY54iFmTLF/TJwIcSoM/zkyJuV7lum7yBxTlGxcqfs15oY/zFd4W+crCqw0DOEIp+4ix041etY5qRR/oXzm5wuMzHVNSSsMfGCYutPcNiolsMU/nq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616466; c=relaxed/simple;
	bh=4i3ETf6klcceIXjBahAHK1XVwU6hAzyYZf3k1R5UwYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qL4xCtv7gzYClWfTwlzT8MGQobb/NUeDhQENArtOiUIJV0utaGcyTNUQMxBsr7BrzVSR+FB0ktSuxDwbvMy5aiwMoQ2KVHJ4FLITs7ccVu4/o7mjnPslUlIfPrxahzOm2xAC9DpaV6sifzzj5Uk/xaPUPzCex29gTWkYGtJxfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B078442DD4E65; Sun, 19 Apr 2026 09:34:12 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 11/17] bpf: Enable r11 based insns
Date: Sun, 19 Apr 2026 09:34:12 -0700
Message-ID: <20260419163412.736133-1-yonghong.song@linux.dev>
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

BPF_REG_PARAMS (r11) is used for stack argument accesses and
the following are the only insns with r11 presence:
    - BPF_LDX | BPF_MEM | BPF_DW (load incoming stack arg)
    - BPF_STX | BPF_MEM | BPF_DW (store register to outgoing stack arg)
    - BPF_ST  | BPF_MEM | BPF_DW (store immediate to outgoing stack arg)

The LLVM compiler [1] implemented the above BPF_REG_PARAMS
insns.

  [1] https://github.com/llvm/llvm-project/pull/189060

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e952ebcc2f8f..2a346e4f28e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18791,13 +18791,24 @@ static int check_and_resolve_insns(struct bpf_v=
erifier_env *env)
 		return err;
=20
 	for (i =3D 0; i < insn_cnt; i++, insn++) {
+		u8 class =3D BPF_CLASS(insn->code);
+		u8 mode =3D BPF_MODE(insn->code);
+		u8 size =3D BPF_SIZE(insn->code);
+
 		if (insn->dst_reg >=3D MAX_BPF_REG) {
-			verbose(env, "R%d is invalid\n", insn->dst_reg);
-			return -EINVAL;
+			if (insn->dst_reg !=3D BPF_REG_PARAMS ||
+			    (class !=3D BPF_ST  && class !=3D BPF_STX) ||
+			     mode !=3D BPF_MEM || size !=3D BPF_DW) {
+				verbose(env, "R%d is invalid\n", insn->dst_reg);
+				return -EINVAL;
+			}
 		}
 		if (insn->src_reg >=3D MAX_BPF_REG) {
-			verbose(env, "R%d is invalid\n", insn->src_reg);
-			return -EINVAL;
+			if (insn->src_reg !=3D BPF_REG_PARAMS ||
+			    insn->code !=3D (BPF_LDX | BPF_MEM | BPF_DW)) {
+				verbose(env, "R%d is invalid\n", insn->src_reg);
+				return -EINVAL;
+			}
 		}
 		if (insn[0].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
 			struct bpf_insn_aux_data *aux;
--=20
2.52.0

