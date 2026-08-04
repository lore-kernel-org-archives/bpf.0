Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600E3002A9
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851197; cv=none; b=rfJiOu2rIqxYQ8MM8T0nNvF7FMf5H4iBU074G7IyCu8b9QoNtsJbJP7UCiLy3elfn2hQ15yy2jPQ7uijA6ERIYCvxXnbbYD4YM5mPoRPskDTA2fIxW71dCU1FzpZX6sWuSln/mLSl0elssLIbv3IzcUdW9ZMx+pZBs6iL1fwyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851197; c=relaxed/simple;
	bh=8k46cHq37tV4aRIh9kF8VVn+HZEtaBFkagpsHhXU9dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5T18YzOoSj6UZm37WBcfrNGgbPEzwIP3XfbuaoGl5BNRzoa7ffxZTcACzN4cOOeIhzrEZQgF2f4BI75bkDI9UueXvvAp2eMRU10gkv7p9bW+Aa4t7vmW99rlpw4imN3YXc667geqSfB2Pf/2c1cmF54uG9oaFMfZzKi6B9yrWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbPsr6dF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbPsr6dF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4E01F000E9;
	Tue,  4 Aug 2026 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785851196;
	bh=d2drfI+CF46FnSPXHhlAmGOQh/pUOnrvktlNvCuWLqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LbPsr6dFpKviL1gYQLBKZqAwiX0F3i46sn2sK96u6zIi58smfiUtFFiEQkbOyJsaH
	 NYL1+j5BC0YWNWUgUIy6OXdbXbHMZlB16RRmIdMRWKtzxXg1UGz/AzJ5PYJZ4+/9mD
	 ZaHzjnhXNc9sgiKJZjr9jUKaxlqNZrUGDvCyUKISM4NQFvkGIXcpCZSTUBsF1odz75
	 Wj3E9NeA8BTwIwdwBMMx7ol40ZTR/H69CkwewazhWtQiMWvIjodl7d2VGCPr97voUa
	 6KFgJfD5xHQksL31SPIPuTkKf6tSroVnqmhnSecwgDsQMnLei0csy1PH7oTlUnXhtZ
	 JoFHRyzCXtMdA==
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
Subject: [PATCH bpf-next v5 4/6] bpf: Inline bpf_iter_num_destroy() as a no-op
Date: Tue,  4 Aug 2026 06:45:56 -0700
Message-ID: <20260804134601.2305303-5-puranjay@kernel.org>
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

Once destroy() returns the stack slot is no longer tracked as iterator
state, so zeroing it is dead work. Make the kfunc a no-op and inline the
call to a single BPF_JA 0 (the fixup can't drop the instruction outright,
so emit a nop; the JITs elide it).

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/bpf_iter.c | 4 +---
 kernel/bpf/verifier.c | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index d19f1b2861d22..14a5fdfa04214 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -818,9 +818,7 @@ __bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_num* it)
 
 __bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter_num *it)
 {
-	struct bpf_iter_num_kern *s = (void *)it;
-
-	s->cur = s->end = 0;
+	/* no-op */
 }
 
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6bfd715aaa379..64a142870e5b8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20047,6 +20047,10 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
 		insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, 0);
 		*cnt = i;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_destroy]) {
+		/* bpf_iter_num_destroy() is a no-op; emit a nop to drop the call */
+		insn_buf[0] = BPF_JMP_A(0);
+		*cnt = 1;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

