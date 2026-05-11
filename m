Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066193750DB
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477651; cv=none; b=Txah/PkZaV0MQFujzNrCBkrOvemCz6aTpqIHM/zo9MlzIl8Fsj8WzljPOeb195NepBhcxgtzt6G2yphe7hq3AC1+vomy0VdgXRf7i4G6MuQXxNm12s6asd8knKLkPN1tRbUiIbysAQb5sL2l3BHreylZdVoPunkKTDBUW6RtsAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477651; c=relaxed/simple;
	bh=ZBBr+9CtXRb4t87+Cq9XfYjwBqvIsTpTaJD0JoeMJx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gms5pBkRGO79wxzgvFmiMvDDzF/Zb/Z3UUgyTsZ4v3mN20WW2d9RDCRmcq/wplFiMmnVkxKYMEeaA7VZmKBBGnrQ6b91xPA/aVIn+mPQ3zyPCr68YEHYUrtHSmG6KYvPP0+w7gw2zH+Eame482YFp8cNjm4/XUcwFIaJMz56oOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7AAE1A59DBF4C; Sun, 10 May 2026 22:34:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 12/24] bpf: Enable r11 based insns
Date: Sun, 10 May 2026 22:34:03 -0700
Message-ID: <20260511053403.1886118-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511053301.1878610-1-yonghong.song@linux.dev>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

BPF_REG_PARAMS (r11) is used for stack argument accesses and
the following are only insns with r11 presence:
    - load incoming stack arg
    - store register to outgoing stack arg
    - store immediate to outgoing stack arg

The detailed insn format can be found in is_stack_arg_ldx/st/stx()
helpers. After this patch, stack arg ldx/st/stx insns become valid
for kernel and these insns can be properly checked by verifier.

The LLVM compiler [1] implemented the above BPF_REG_PARAMS insns.

  [1] https://github.com/llvm/llvm-project/pull/189060

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0a0157b0972a..5c07f54679fe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18001,11 +18001,12 @@ static int check_and_resolve_insns(struct bpf_v=
erifier_env *env)
 		return err;
=20
 	for (i =3D 0; i < insn_cnt; i++, insn++) {
-		if (insn->dst_reg >=3D MAX_BPF_REG) {
+		if (insn->dst_reg >=3D MAX_BPF_REG &&
+		    !is_stack_arg_st(insn) && !is_stack_arg_stx(insn)) {
 			verbose(env, "R%d is invalid\n", insn->dst_reg);
 			return -EINVAL;
 		}
-		if (insn->src_reg >=3D MAX_BPF_REG) {
+		if (insn->src_reg >=3D MAX_BPF_REG && !is_stack_arg_ldx(insn)) {
 			verbose(env, "R%d is invalid\n", insn->src_reg);
 			return -EINVAL;
 		}
--=20
2.53.0-Meta

