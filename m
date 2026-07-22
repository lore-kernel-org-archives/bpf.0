Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A34307AE3
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726681; cv=none; b=FCQ1A3iiLNJ0IO9kq22DJ260oT6BNWkGAOCOUIsriM5+aiatcqa8D6uOUFG396rzVPd168ucTLpTSjO2DXPXQYfQzNTwtkRlISZWr0SA6FthVcucaoH2QPxgnkdr7FtfAUQrsa5IGvQcJy9YDhgC/xJAPgQ+LwZ7rkYYTVvriwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726681; c=relaxed/simple;
	bh=TsuCUSTHRsXRsUq4+zja5rxj/5l6Kl8bvtItRCvEZu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXpou+Ure7+aUxi9VG3CCasReRcQRY3x+JFlxMJOhgxnosgXXOqI+uJqDhSLPfhU4JMZrXWFi/ur1GQlCrKBvsV9kUd6uMyJchy81EDMQ3iO3QHb60lgsh2dEtRwd2fm1TMBiwUDi2fja7hESdlkF3yi6xnsu0340+8NCY63nT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKsc0/I3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKsc0/I3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59781F000E9;
	Wed, 22 Jul 2026 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726680;
	bh=z4Sd4jSSIzHtBhFTF7eVM7/lFk5F9hBReu4EnrOWsBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WKsc0/I3JwdUa6vZwaQU0lMwsGLrRnVsZIuLg4iqjc0zt6gkIO5elHJU3EGefPh/E
	 5w01UiP1rn71yBWsbIKyl6Ko1b/W0tF39lOuMygFNNvvH5WWhc6DGIrFvIZsURF21c
	 vHqcQmoXgf6IxGaX6IvmH7o2cVJNx5KeXvrxsTqDqVdmSXXGdCutjymB8ZwWj4sGlK
	 4HkX4frgkbaRRRPdkItHfzMjtDS0vGqC1gdL8YP064nIgEn653uGfXcIDamrXesYHR
	 JrUUjG9gg32OowfD+eaxp0q1DAIVwCG06haA0dn9BfGMbN1Rf3i0ph+buPkPAKlzwk
	 zNXOLGzHbjC0w==
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
Subject: [PATCH bpf-next v3 2/6] bpf: Inline bpf_iter_num_next() kfunc
Date: Wed, 22 Jul 2026 06:24:17 -0700
Message-ID: <20260722132424.450230-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722132424.450230-1-puranjay@kernel.org>
References: <20260722132424.450230-1-puranjay@kernel.org>
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
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff76a1ed04556..6fb8fdd5d5b21 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19807,6 +19807,34 @@ static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
 	return i;
 }
 
+/*
+ * Inline bpf_iter_num_next(). R1 holds the pointer to the iterator. Keep in sync with the
+ * kfunc in kernel/bpf/bpf_iter.c.
+ */
+static int inline_bpf_iter_num_next(struct bpf_insn *insn_buf)
+{
+	int i = 0;
+
+	/*
+	 * s->cur and s->end are int, so the (s64)(s->cur + 1) >= s->end check is equivalent to a
+	 * signed 32-bit comparison of (s->cur + 1) against s->end and needs no sign extension.
+	 */
+	insn_buf[i++] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0);
+	insn_buf[i++] = BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1);
+	insn_buf[i++] = BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 4);
+	/* if ((s32)(s->cur + 1) >= (s32)s->end) goto done; */
+	insn_buf[i++] = BPF_JMP32_REG(BPF_JSGE, BPF_REG_0, BPF_REG_2, 3);
+	/* s->cur++; return &s->cur; */
+	insn_buf[i++] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0);
+	insn_buf[i++] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+	insn_buf[i++] = BPF_JMP_A(2);
+	/* done: s->cur = s->end = 0; return NULL; */
+	insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+	insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+
+	return i;
+}
+
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
@@ -19938,6 +19966,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*cnt = 6;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_new]) {
 		*cnt = inline_bpf_iter_num_new(insn_buf);
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
+		*cnt = inline_bpf_iter_num_next(insn_buf);
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

