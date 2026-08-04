Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870E463B83
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851193; cv=none; b=ibDJ5lXR5oqcJb5C6Eu1i2e5ztcBpKxT+hMCmPm1SPod7Gnxew9Ip6+59+I2VifF2Nu4Yuq6B4XY2EMD64nuk4dtnpQzBVla4ftK6NJxBCh9rHjjiYUzksOtCBimLkmIXvz4DcYOexY/gdMgTAD7uPrl9gfKS7TZAIx/oLjbTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851193; c=relaxed/simple;
	bh=L1Pakl2FgMMlFwWq9tm/DGNN/QvUyCNeCMiwTuMPQ6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxwUD1kEAEDoX+GXcISZNT+5PE/xvbFGnyRXsd8PIP1vGMc+HvvbCINF+9oZwAAZDHplSXSo538ntkCxkg+hlEtln3JZtj3epJqd7m3bzsigx7/o/jlKJgJKKneQMRyaXPBAzh+KLJWuAWkkPYtXiWj3WeEAXwFihTfbviWznqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyIv5HM7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyIv5HM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28B11F000E9;
	Tue,  4 Aug 2026 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785851192;
	bh=2MZiUnLZdA0MHxE7oKThCXWe4AzHF7JSoVT3D98WNpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MyIv5HM7On3T/jv4SrBCz678R3PuekPyASJgKmDXHxEksCqblsV+qURiiXCEOP1/b
	 AvKYlqZmskJtsTP8xhWDi+PDSCi7OZpld3VXIc32aBGozS0zTtlCbxLF8srMUOMKvd
	 jgeJ88MXSDgw7uNyemvqEk4DA42Gut/21o0kL6YQ/fopDWbVUkI1iQ+Przy+NCFyeI
	 eZntXgrJwelLfeAJywK5bItbuR5HxuRRwa+9ifsZWfDEsKD4i4PkAb0IoS/CD2BvEw
	 1gLVja/TTovRyBVOrORpWOFTCOS6h4FeQB2OKs9IfMcVU6WGgNp4D52p97/SsPksgh
	 WvYbFVJ/U9IOw==
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
Subject: [PATCH bpf-next v5 3/6] bpf: Inline bpf_iter_num_next() kfunc
Date: Tue,  4 Aug 2026 06:45:55 -0700
Message-ID: <20260804134601.2305303-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804134601.2305303-1-puranjay@kernel.org>
References: <20260804134601.2305303-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_iter_num_next() runs on every bpf_for() iteration, so inlining it
drops a call from the loop body. R1 points to the iterator; the returned
pointer to s->cur is R1 itself, since s->cur is first.

s->cur and s->end are int, so the kfunc's s->cur + 1 >= s->end is a
signed 32-bit compare and the inlined code needs no sign extension.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e0c91f6412228..6bfd715aaa379 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20030,6 +20030,23 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
 		insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, -E2BIG);
 		*cnt = i;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
+		/* inline bpf_iter_num_next(&it); R1=&it, returns &s->cur or NULL */
+		int i = 0;
+
+		/* r0 = s->cur + 1; if ((s32)r0 >= s->end) goto done; */
+		insn_buf[i++] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0);
+		insn_buf[i++] = BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1);
+		insn_buf[i++] = BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 4);
+		insn_buf[i++] = BPF_JMP32_REG(BPF_JSGE, BPF_REG_0, BPF_REG_2, 3);
+		/* s->cur = r0; return &s->cur; */
+		insn_buf[i++] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0);
+		insn_buf[i++] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+		insn_buf[i++] = BPF_JMP_A(2);
+		/* done: s->cur = s->end = 0; return NULL; */
+		insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+		insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+		*cnt = i;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

