Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BDF42464B;
	Wed, 19 Aug 2026 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129614; cv=none; b=chPo9NkwNKpJ3q+Bz/FWOT3HgXIN9baT0dlsVamE3OjbACgJg4MH5A5bkqfyTlF4K747N6X7lgQgkEG6nQRkuufZDS39Pu1GnQ2vaR86j3lMMfn1bjTIitlF2JFAPKv1NTdgiXjBSw73O/S1TwoXanIlRUWdyJRoMAwmVrTmDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129614; c=relaxed/simple;
	bh=WOD923Dhazb9uAy3pozQpj2/Rcs9+czR2+/3XG/ST5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQ242yLVO2i+j9gYSl53NSL5KQ6zyu5nTb49QuvKHbdgxfWaA6TzSKBz8criryTSi/+LboyIXzB0Dg97Gxtf71qVXeOzyy8LBgpx2zQm/Mhv93c+vvaOG+VoTnOcZQSjMvI6bq2RR/f7r6Y+Q7v/rMY0BH3hr0yiHPERRs2YQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SBAH3+Cj; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SBAH3+Cj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787129603; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MWpf0VeTCBhwFwAftU7whr2vA1ztFY19iNzKSTGqoHg=;
	b=SBAH3+CjF0nZBPIvHMpy+4fRRgUrymtMvfJn7AyE3Zqmily7yP6NMdsYu0l5lCO0lD7ADaJOruoBHVH+09Eg9vPs/uWe4LxajMP+zIUnOOP4w1+1B/I7fkEzwNHNolDcvq9s3gpsTbTuVfR2KudWwpDJsKVa2LnFw1IgFi1YeFM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X9G1fzf_1787129602;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9G1fzf_1787129602 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 16:53:23 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	shuah@kernel.org,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf, riscv: Add support for signed arena loads
Date: Wed, 19 Aug 2026 16:53:15 +0800
Message-ID: <a78cd29b238aa1aba87efeb2fc09d25a56c22f69.1787128322.git.cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787128322.git.cp0613@linux.alibaba.com>
References: <cover.1787128322.git.cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed loads from arena memory are currently rejected on riscv64, as
bpf_jit_supports_insn() refuses BPF_MEMSX loads when in_arena is set,
while x86 and arm64 gained support for them in v6.18. Compilers such
as GCC-14 are free to generate signed loads into arena memory, which
breaks loading of otherwise valid BPF programs on riscv64.

Implement BPF_PROBE_MEM32SX support in the RV64 JIT by reusing the
existing arena handling: the arena base (RV_REG_ARENA) is added to
the source register and the load is emitted with sign extension
(lb/lh/lw). Add BPF_PROBE_MEM32SX to the add_exception_handler()
mode gate so that faulting loads get an exception table entry which
clears the destination register and resumes execution. Since
BPF_PROBE_MEM32SX shares its mode value (0xc0) with BPF_ATOMIC, the
gate accepts it only for LDX class instructions so that plain atomic
instructions do not register exception table entries.

Verified by running the arena LDSX selftests (arena_ldsx_disasm,
arena_ldsx_exception, arena_ldsx_s8/s16/s32) and the full
arena_atomics test suite on riscv64 QEMU, all passing.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---

Changes in v2:
- Fix extable entry overflow breaking arena_atomics load

 arch/riscv/net/bpf_jit_comp64.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index f9d5347ba966..acc1b16d2e2f 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -777,6 +777,8 @@ static int add_exception_handler(const struct bpf_insn *insn, int dst_reg,
 	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
 	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
 	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
+	    !(BPF_MODE(insn->code) == BPF_PROBE_MEM32SX &&
+	      BPF_CLASS(insn->code) == BPF_LDX) &&
 	    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
 		return 0;
 
@@ -1902,13 +1904,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
+	/* LDX | PROBE_MEM32SX: sign-extending arena load */
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
 	{
 		bool sign_ext;
 
 		sign_ext = BPF_MODE(insn->code) == BPF_MEMSX ||
-			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
+			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
+			   BPF_MODE(insn->code) == BPF_PROBE_MEM32SX;
 
-		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
+		    BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) {
 			emit_add(RV_REG_T2, rs, RV_REG_ARENA, ctx);
 			rs = RV_REG_T2;
 		}
@@ -2126,10 +2134,6 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 			if (insn->imm == BPF_CMPXCHG)
 				return rv_ext_enabled(ZACAS);
 			break;
-		case BPF_LDX | BPF_MEMSX | BPF_B:
-		case BPF_LDX | BPF_MEMSX | BPF_H:
-		case BPF_LDX | BPF_MEMSX | BPF_W:
-			return false;
 		}
 	}
 
-- 
2.50.1

