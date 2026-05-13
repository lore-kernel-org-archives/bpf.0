Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8910391E5B
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647862; cv=none; b=ccZwlzWvTpXmzqX2xq2Ale0pSL6DRg85a7bx/nyRPF0L/1B0JLWU5Sts9fHEysOeicmbMoq6FaBAfN5dX9Rdpe2WG5SyW4jgtFeHCAE7anUbCs6aDpu0kCtHmgIrccGKr81Fd367Y3nMxUEfcCrAESQOiWlnOqXFNkQFnRgkqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647862; c=relaxed/simple;
	bh=nOWPrbbGc//LCwTeP4x5OU9Z3rN14cBrRwRFeqw+rYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klRwu1EVmVjNRJL1oSn6hQ2R9nMXjF6TSkPUFvK3rBV4nX5fdelF/5iGgS1DaTzlv5XTL5WlTKlJVzXVHfCinewccabmEXTN6PYfEPFoWDoHbBxkn8btdoVU5yRmwxsy6947DZmvcTR0d9bZ+Na3d5L6kLEoGgWdd9TDZdS3vV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 49416B196E98C; Tue, 12 May 2026 21:50:59 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 13/25] bpf: Enable r11 based insns
Date: Tue, 12 May 2026 21:50:59 -0700
Message-ID: <20260513045059.2391192-1-yonghong.song@linux.dev>
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
index 30143bea6a86..18bbc5b6c2d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18006,11 +18006,12 @@ static int check_and_resolve_insns(struct bpf_v=
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

