Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056E2D97A6
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357439; cv=none; b=EcH0em8dOQQmgxmkXKAmhKrzCvsygMQy/pRwZNiF6kYXppdzmN6QjCBV2KTSwpfAYpGsBJ6/RkqanRS9laucgXeAmPZiFdAPsPXJbQXRoUKWMLELxvEu4F0CzYbKGBds8KkiltJ3C/0nxVF4Q6vpsS7g0NcdsTPYSvABGc7UPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357439; c=relaxed/simple;
	bh=jZUrZe41kgSQgUVC80U4oVNsu9gg/ZY8Ms5CkXRBZEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMGbdni/choR8lnPR/1U46uDqzuVgapFx9fay85GSncBdWmYngnCw5FZss5TjoiPEVH7tNXkyurw1ox6H2b2md2FbenRLWhnE/4X3skE0ZOQwUMvD0GgjCJfsNIz26WO7axVoQqcFWnEYGS9v4IPZYOgGXFk0sCydbLgsQFkY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt1RSpBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt1RSpBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB8B1F00A3E;
	Wed, 29 Jul 2026 20:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785357420;
	bh=LVXYiXfm48dV4vPQH3biW9WfmYq0XJAQk/XFUNe5erc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yt1RSpBKBwcTo9bNJxSJEZzrRZ0eUoVUilBVUWW0rDIY7d0ViPZLXxeyCaffKDUSz
	 GdLepsE1anorxhzSGkcgzcvDz2HSjWh58gAKY/s5OWTMpbSZwA9vDtRtvcVtmzcY9g
	 jMrhC6SncdToN89EfQW0mxsFlXApAADAtXTpyDKECFMNDsdMN2JP8yF8w6tWiRjdaa
	 ACuoYE/TaeiWjNQMLl4FN+wB1eoqN2qh79+RxJZA7k939DH28XELyC3ige9Q9gUIsF
	 lgIIBppMYoNTM1RkZfqutDa9FnpNYegJ8n4Gv1qP6brM2sI9cGV7YL5B9LWijXkdcn
	 TvqTMVPZ1kxmw==
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
Subject: [PATCH bpf-next v4 3/6] bpf: Inline bpf_iter_num_next() kfunc
Date: Wed, 29 Jul 2026 13:36:23 -0700
Message-ID: <20260729203633.213973-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729203633.213973-1-puranjay@kernel.org>
References: <20260729203633.213973-1-puranjay@kernel.org>
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

s->cur and s->end are int, so the kfunc's s->cur + 1 >= s->end test is a
signed 32-bit comparison of (s->cur + 1) against s->end, with s->cur + 1
computed as a 32-bit int. Sign-extending both sides of a comparison of
two int values does not change its result, so the inlined code uses a
32-bit compare and needs no sign extension.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7400515ae1296..3a3d096f3966e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19810,6 +19810,34 @@ static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
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
+	 * s->cur and s->end are int, so the kfunc's s->cur + 1 >= s->end check is a signed 32-bit
+	 * comparison of (s->cur + 1) against s->end and needs no sign extension.
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
@@ -19941,6 +19969,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*cnt = 6;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_new]) {
 		*cnt = inline_bpf_iter_num_new(insn_buf);
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
+		*cnt = inline_bpf_iter_num_next(insn_buf);
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

