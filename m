Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625242046C
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120711; cv=none; b=nsRYMD/kM+p2sb7irVAji3SAdL4UeTsmItqLk2xVHBtGVe6ouLMtIYjrp6L+sEftcSkbpOA47PggvRsRwHRglHR3+lh7PCNSXHaWlpLtLRTbjC+t6ZLR08M5wLbLDfE3tCR/xkwJ/x59HEoo2rp/TprcGc9JlqoHKkXKPbtO4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120711; c=relaxed/simple;
	bh=QygjsND6l65ysZQlA3+KD7oC9JBMKKiS+jkvRb2qFEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kq20WD77a05ilDXDe+9pJCvZoC5XGY/tDYWtpoAlDfmiqv49JTCQC55ea/09/T3DcprtBrJOr10mkcbdh87tI313CDWP6712jcMKU6FyV3xAByIyr4a0/YT17N9/RDhv5Wqbx1Jgjn/HksinU06vhWHQOf4OFG8Fn4WC9cE3D18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQuAy20K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQuAy20K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAB61F000E9;
	Wed, 15 Jul 2026 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784120710;
	bh=if27uywKL5vRMrDn+r7z9C4Lnq+G/Skdb4jAZOIJv/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQuAy20KL6CyYFxD4f9/RtSMMZsBWNM5kOZy26Rsg+a1PpKk/D18QQD8RmxsTgCrN
	 DSC/l8hKCgLoJia3YVduTXM4zaSh4E9glhuA2VEJjCi7ncr3q0G7JAqJVDior2Bxpe
	 N+wNrXDhWs+ps8vdKLk//5kbXMgwb+D4dcyGlJclbbzrBgkg1I20YkPtvlDtER2r+M
	 VzFF8QI6ajXpxhGYnj+SOEyLgsEnp45nWSlYDfb8/wi8z/ynpWPDPYV4wyWIio7UHu
	 WUniMYJCai/LBkWOv20dwGvK9Mxa+W0QHPENlymK0yWGuDPznt08p3LIP/FCsiO+MV
	 Hj5d/+Y2TZGUQ==
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
Subject: [PATCH bpf-next 2/4] bpf: Inline bpf_iter_num_next() kfunc
Date: Wed, 15 Jul 2026 06:04:24 -0700
Message-ID: <20260715130430.318421-3-puranjay@kernel.org>
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

bpf_iter_num_next() is called on every iteration of a bpf_for() loop and
is the hot path of the numeric open-coded iterator. It only advances the
on-stack iterator state and returns a pointer to it, so open-coding it in
the verifier removes a function call from each loop iteration.

Inline it in bpf_fixup_kfunc_call() by replacing the call with an
equivalent instruction sequence. R1 holds the pointer to the on-stack
bpf_iter_num; the returned pointer to s->cur is R1 itself since s->cur is
the first member.

s->cur and s->end are int, so the kfunc's (s64)(s->cur + 1) >= s->end
test is equivalent to a signed 32-bit comparison of (s->cur + 1) against
s->end: s->cur + 1 is computed as a 32-bit int in the kfunc as well, and
sign-extending both sides of a comparison of two int values does not
change its result. The inlined code therefore uses a 32-bit compare and
needs no sign extension.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f578cebbade4f..e8b66f56598dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19749,6 +19749,33 @@ static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
 	return 15;
 }
 
+/*
+ * Inline bpf_iter_num_next(). R1 holds the pointer to the iterator. Keep in
+ * sync with the kfunc in kernel/bpf/bpf_iter.c.
+ */
+static int inline_bpf_iter_num_next(struct bpf_insn *insn_buf)
+{
+	/*
+	 * s->cur and s->end are int, so the (s64)(s->cur + 1) >= s->end check
+	 * is equivalent to a signed 32-bit comparison of (s->cur + 1) against
+	 * s->end and needs no sign extension.
+	 */
+	insn_buf[0] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0);
+	insn_buf[1] = BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1);
+	insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 4);
+	/* if ((s32)(s->cur + 1) >= (s32)s->end) goto done; */
+	insn_buf[3] = BPF_JMP32_REG(BPF_JSGE, BPF_REG_0, BPF_REG_2, 3);
+	/* s->cur++; return &s->cur; */
+	insn_buf[4] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0);
+	insn_buf[5] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+	insn_buf[6] = BPF_JMP_A(2);
+	/* done: s->cur = s->end = 0; return NULL; */
+	insn_buf[7] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+	insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, 0);
+
+	return 9;
+}
+
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
@@ -19880,6 +19907,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*cnt = 6;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_new]) {
 		*cnt = inline_bpf_iter_num_new(insn_buf);
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
+		*cnt = inline_bpf_iter_num_next(insn_buf);
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

