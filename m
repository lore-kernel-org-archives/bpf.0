Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B748420472
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120708; cv=none; b=eK62xYEE3MJCPyGVVljSVSgIDz0DX39x+Gg8DjSMXiHVIl7C6XJZGH+WclLvOq2B3kMiQQ04wgkUAn+yDHmaRdayK/O9XCJy3nvaqENaUAHOzJXccomPITO0m1Dk5iy531TZ3gZdclhfZ0q0FD7nan0Dkjmy4X50JvpxUwNgwVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120708; c=relaxed/simple;
	bh=j5mOpGVXDRhobujNIhkcPmTAHX00MVYZzAmf8Ip09j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lweRSQXA/f8tP/c2bF7LqpW/k++fImu3VhP4AJMA99r0ZJauOhokJv83elG6s2oyHpF4AWwyRIqpAN/iSLdSrvvn/mwIZLOnqyW62mAKGj0HQhBpMj2pPb5Cxwv7/RQGnwxty19tBKtuufEmm0ZRvlzB8yGWTLsIa+Lj4Pk3pxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBE7zeOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBE7zeOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0681F000E9;
	Wed, 15 Jul 2026 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784120706;
	bh=5HNuaZf5tSjl+NJ3XEQY0Q8K0m8OBoLUeNWCbN0hB9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NBE7zeOw3cl0kN5Vgyt9yFMxPaKk1pceowKUHNeGOTJCF0KAVhqtOnxVEEifF5LT8
	 8Chj7a5qyPpruujtEFuIDhxWf7qX4V4YNc/gmBItVXQayx2iXgYPs0f3tKITlzVpuU
	 QIeZGrzjvl3qUlieLfmyzI5vikxKL2g3XK3u5eXkmdSO5e742qdIAaYnferYFA+x87
	 z0aE+aJlBvU9/KgsE2eemr5GmqPiHb7cv3SAZTXsuh8BVusl5GN4dgbTH/Fb/8MJe8
	 JkNfgCTVZhp+ENa/qae8qpQ5MMjlUX1CVsZFWzGpGWPaAf8jHq7bvnVJQCpFryUO5c
	 zE8DM93WB970w==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 1/4] bpf: Inline bpf_iter_num_new() kfunc
Date: Wed, 15 Jul 2026 06:04:23 -0700
Message-ID: <20260715130430.318421-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715130430.318421-1-puranjay@kernel.org>
References: <20260715130430.318421-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The numeric iterator kfuncs bpf_iter_num_{new,next,destroy}() back the
open-coded iterator macro bpf_for() and are emitted as regular kfunc
calls by the verifier. bpf_iter_num_new() is small and only touches the
on-stack iterator state, so the verifier can open-code it and avoid the
call overhead of setting up an iterator.

Inline it in bpf_fixup_kfunc_call() by replacing the call with an
equivalent instruction sequence. R1 holds the pointer to the on-stack
bpf_iter_num, while R2 and R3 hold the start and end arguments. The
(s64)end - (s64)start overflow check is emitted with sign-extending
moves; the rest of the arithmetic and the error paths mirror the kfunc
exactly, so a program that inspects the return value keeps observing the
same -EINVAL / -E2BIG / 0 results.

The emitted instructions are plain BPF and are handled by the
interpreter, so interpreter fallback stays correct and no jit_required
marking is needed.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de816063ae63d..f578cebbade4f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19715,6 +19715,40 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 	*cnt = 4;
 }
 
+/*
+ * Inline bpf_iter_num_new(). R1 holds the pointer to the iterator, R2 and R3
+ * hold the (int) start and end arguments. Keep in sync with the kfunc in
+ * kernel/bpf/bpf_iter.c.
+ */
+static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
+{
+	/* if (start > end) goto einval; */
+	insn_buf[0] = BPF_JMP32_REG(BPF_JSGT, BPF_REG_2, BPF_REG_3, 9);
+	/* r0 = (s64)end - (s64)start; */
+	insn_buf[1] = BPF_MOVSX64_REG(BPF_REG_0, BPF_REG_3, 32);
+	insn_buf[2] = BPF_MOVSX64_REG(BPF_REG_4, BPF_REG_2, 32);
+	insn_buf[3] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_4);
+	/* if (r0 > BPF_MAX_LOOPS) goto e2big; */
+	insn_buf[4] = BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, BPF_MAX_LOOPS, 8);
+	/* s->cur = start - 1; */
+	insn_buf[5] = BPF_ALU32_IMM(BPF_ADD, BPF_REG_2, -1);
+	insn_buf[6] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2, 0);
+	/* s->end = end; */
+	insn_buf[7] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3, 4);
+	/* return 0; */
+	insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insn_buf[9] = BPF_JMP_A(5);
+	/* einval: s->cur = s->end = 0; return -EINVAL; */
+	insn_buf[10] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+	insn_buf[11] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+	insn_buf[12] = BPF_JMP_A(2);
+	/* e2big: s->cur = s->end = 0; return -E2BIG; */
+	insn_buf[13] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+	insn_buf[14] = BPF_MOV64_IMM(BPF_REG_0, -E2BIG);
+
+	return 15;
+}
+
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
@@ -19844,6 +19878,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
 		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
 		*cnt = 6;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_new]) {
+		*cnt = inline_bpf_iter_num_new(insn_buf);
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

