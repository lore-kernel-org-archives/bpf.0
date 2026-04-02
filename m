Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724E40DFC5
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093265; cv=none; b=EsMV9+aF7Nw/KoDjhczX01trOR3sxzL2cQIWhK1nqq5Nya6dMg1B3eCSItkGztjSxl4YIexCFqoJvaTtNvbtRhXMB46Ueh/Mj32p00bZVupz3BI3wYJqQuyx1Edy3u1XOmwqA5FfApb7ISs+BiTNclU8t/Qpu4JXAjc7JKIuU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093265; c=relaxed/simple;
	bh=l/bC/wgYy++kM9TY1fU/qQFSUAM26mFHC1X0WijeUDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abYYhSD4/Dwy03Ax4LSMCeibDossI9AlhjATpKyaANWe8nLv0hOtogKyYAizdsK2ahCeQjoZh5DmTo5wwii9tWxqJjmkQoU0dZ340VssQAXdJ4IQvI9Ejic/wxz2an5++KaiRZsNkzup927NdL4QCCl7N77o7I6AbonwUwsdJK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 586A33328047F; Wed,  1 Apr 2026 18:27:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 01/10] bpf: Introduce bpf register BPF_REG_STACK_ARG_BASE
Date: Wed,  1 Apr 2026 18:27:32 -0700
Message-ID: <20260402012732.3917048-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402012727.3916819-1-yonghong.song@linux.dev>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
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
index 1af5fb3f21d9..3520337a1c0e 100644
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

