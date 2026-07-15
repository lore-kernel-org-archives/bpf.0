Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC5420476
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120719; cv=none; b=SYno3hsjRr4WCbS9emNWQ+H7Bu2ksy1bU/MX/jRL4WMWbz+YrPtXNXZFDh/q+niP4iDqKTE5y98ypx0w21RZTRwVjTrDZfyrUE7LM/TzIj4s0em1Cch+znp5S30tgeM98hWOuu+Kcguog/eimSbMIRU6nC3p/+DsrHEXKYw905k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120719; c=relaxed/simple;
	bh=c1z+qnx46YrZeXrOZMsmovo51Gwx5+lvyDRAYWmUaXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p78kQqo+iB8JEDdaYJ9velDA9hE/3KxjO9wJj1TD5Pf3AMmFlOcMzYWTC0VERbT+yu9XeG2xDR9blCQIl2K4g/JIg6kUU5nfgrKu19FSgB0/BfiUVGn9pX1rKRRtcgTqugmLG3Q1KPBtImjs3a2JGubCn/7kga8cPfDKH+8X5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC/fW0SV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC/fW0SV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1A01F000E9;
	Wed, 15 Jul 2026 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784120717;
	bh=jnbzwavAzX8d4Dy1mAuBj48yo+P/Qb59BFzPshHbfTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bC/fW0SVJvF0IgQqkGF3fW9HX29qlY9bHsiQ+vEKg9oJpgLZF75nD/PPflM01rhDy
	 Gl1pZXIltTBulS1TSPQ8d7YYbbPuOsI+GTTBTC+i94tweiRjsz6o/eD549BWNKclCu
	 E9RS4aQbyJ0Ql8MARxmQuSEH9oDQ59zOYCLqYxplmZsqmzAytNuVrVLdwaTl+RkuV7
	 PbPslLyDCQzLO1FZFcOF/gZUA1yk/SvD+tP6qxkecFndGw+Zptftyo7I5BZB8/X7D6
	 BRzYDIb7VKK31XUY1aoklShUkorhLCG0qAQhg9tF3/Q1FcG10rFMZesgrrt6aqTPPr
	 gKZFLa2zv8R6w==
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
Subject: [PATCH bpf-next 3/4] bpf: Inline bpf_iter_num_destroy() kfunc
Date: Wed, 15 Jul 2026 06:04:25 -0700
Message-ID: <20260715130430.318421-4-puranjay@kernel.org>
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

bpf_iter_num_destroy() only zeroes the on-stack iterator state, which is
a single 8-byte store. Open-code it in the verifier to drop the call
emitted at the end of every bpf_for() loop.

Inline it in bpf_fixup_kfunc_call() by replacing the call with a store of
zero to the iterator, matching the kfunc which clears both s->cur and
s->end. R1 holds the pointer to the on-stack bpf_iter_num.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e8b66f56598dd..082617adaba5b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19776,6 +19776,18 @@ static int inline_bpf_iter_num_next(struct bpf_insn *insn_buf)
 	return 9;
 }
 
+/*
+ * Inline bpf_iter_num_destroy(). R1 holds the pointer to the iterator. Keep in
+ * sync with the kfunc in kernel/bpf/bpf_iter.c.
+ */
+static int inline_bpf_iter_num_destroy(struct bpf_insn *insn_buf)
+{
+	/* s->cur = s->end = 0; */
+	insn_buf[0] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+
+	return 1;
+}
+
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
@@ -19909,6 +19921,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*cnt = inline_bpf_iter_num_new(insn_buf);
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
 		*cnt = inline_bpf_iter_num_next(insn_buf);
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_destroy]) {
+		*cnt = inline_bpf_iter_num_destroy(insn_buf);
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

