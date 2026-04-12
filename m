Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438DA3644CC
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 04:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775969951; cv=none; b=pCzDJNWRFwL5gjEsUfcVhJjj8sQ2j1TEv236wnuzPcMjiNpPQTvRAeA1i9E7jXVGOMw5D8KZLp7jZ+IFtSNycE/sisHmA450CzJDJB6H8RxOdj6VWMV6uYqmFjGkpHCfRIdMEeMv71GB5HyBbngWhnXsCGbDEGabbCkStfZejl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775969951; c=relaxed/simple;
	bh=mpzT6+UIodYLsQl4vudprqgEVRfSOPYznGh6Tw8IDqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8nwyjOEHv2yvOzeCgNKcnD2JUiBwfpI5cXFt2cVQEVK2QAggEPbXDpMIaoAkifSuLOXvXVbHd/WQAuLsNBcDEupmmaF1u5f/Yz5yBLcdPGPniSEh0NKS+GVKXdgTpY6fnZeVecP/yNoWWpHZ1r2j+R878dMfdHuCRSGVKsLiSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 75C543B021A27; Sat, 11 Apr 2026 21:59:02 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 07/18] bpf: Introduce bpf register BPF_REG_STACK_ARG_BASE
Date: Sat, 11 Apr 2026 21:59:02 -0700
Message-ID: <20260412045902.256704-1-yonghong.song@linux.dev>
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

The newly-added register BPF_REG_STACK_ARG_BASE corresponds to bpf
register R12 added by [1]. R12 is used as the base for stack arguments
so it won't mess out R10 based stacks.

  [1] https://github.com/llvm/llvm-project/pull/189060

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/filter.h | 3 ++-
 kernel/bpf/core.c      | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index e40d4071a345..68f018dd4b9c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -59,7 +59,8 @@ struct ctl_table_header;
=20
 /* Kernel hidden auxiliary/helper register. */
 #define BPF_REG_AX		MAX_BPF_REG
-#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
+#define BPF_REG_STACK_ARG_BASE	(MAX_BPF_REG + 1)
+#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 2)
 #define MAX_BPF_JIT_REG		MAX_BPF_EXT_REG
=20
 /* unused opcode to mark special call to bpf_tail_call() helper */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 066b86e7233c..76a4e208f34e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1299,8 +1299,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn=
 *from,
 	u32 imm_rnd =3D get_random_u32();
 	s16 off;
=20
-	BUILD_BUG_ON(BPF_REG_AX  + 1 !=3D MAX_BPF_JIT_REG);
-	BUILD_BUG_ON(MAX_BPF_REG + 1 !=3D MAX_BPF_JIT_REG);
+	BUILD_BUG_ON(BPF_REG_AX + 2 !=3D MAX_BPF_JIT_REG);
+	BUILD_BUG_ON(BPF_REG_STACK_ARG_BASE + 1 !=3D MAX_BPF_JIT_REG);
=20
 	/* Constraints on AX register:
 	 *
--=20
2.52.0

