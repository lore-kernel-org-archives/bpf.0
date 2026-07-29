Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54843470E81;
	Wed, 29 Jul 2026 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338331; cv=none; b=omoFL5xociEg9h2/9sdsImmWjwbh3GhV5+J+F3Oxs4OmJnd7+7+DrdHEGhiOJbKQxk+T/qYwA3rCqEFJn6vkOABJ95wqxVpWxbAzm/UQ6RLmBHYlxHDdvIM7ve9hmU4wtctZ7SgZ4jzoZ6sA8BcfqfitrCEhTE/CTgFBYRx2wCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338331; c=relaxed/simple;
	bh=aD4Hbtom5MOAH35ySEYsz1DL3AXhqHBUqIL5hyZ/2Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMQz3hWBgjI3wl/idRQKN5xkGXmY7r0ClxM4Xx9MgMNjDzUikakaPVHvCEaDghnKV+cfv15pDEx4qjlxbxBF+q6dHvmy5aQyojAryKsed0PKGFinLs8lEp09Oey0KHS9VLm4jaPIMYzhzW9WBeqlsIBVj00b5WMGdpWXud3y+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suikRgjG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suikRgjG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AF4CC2BCF4;
	Wed, 29 Jul 2026 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785338330;
	bh=aD4Hbtom5MOAH35ySEYsz1DL3AXhqHBUqIL5hyZ/2Ls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=suikRgjGDHr9evZz7ctbHmG4bJED1UiHkd42LRNLCSlK//RyS3fI3d3ia4J7Gy5K3
	 QJI9DDRrCNAw7Jv4PKZs4y9RKJ7oyzwewLSX0uLStMavmVltVthS1jFrcT/i6cngus
	 tF7sesISkRnwE1wMop6D6RmPpFyVBACAnmkMpNvEtYT0s8/p/3FVbrSWsVnOINRspw
	 cps2JNFnvo2McgA9LahjhRVsJFrwIas+DcfCsDxL5cBGaJ37BYuPilkYFO4Z+PCFV6
	 +ctT/J2wxlu/7iGnMxUk6f6i9IS5BRkfkoABd3VVtXtF4/KgvEPwunggHz6a3NjgPo
	 J9pYuf/pyfL+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3ABC54F51;
	Wed, 29 Jul 2026 15:18:50 +0000 (UTC)
From: Yiyang Chen via B4 Relay <devnull+chenyy23.mails.tsinghua.edu.cn@kernel.org>
Date: Wed, 29 Jul 2026 15:18:27 +0000
Subject: [PATCH bpf v4 1/4] bpf: simplify sanitize_err() signature
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-c3-035-public-bpf-v4-v4-1-8ee297e2346b@mails.tsinghua.edu.cn>
References: <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
In-Reply-To: <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Wade <danjwade95@gmail.com>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785338329; l=2912;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=GVQU8AnKSNW9owP8OxZQ3/UbDFKuSBhgGQANm+vY8V8=;
 b=S7JpiM+T54LdGYo0bXqvB5yR6ZU7IPIwWWjaqVy3nUBaysIxF93v/lV2pkm3U881VicJrYfsY
 miMuoOq3h9CDoHWU31m7iWZ1O42d3JMkqh9C7aYR7dnSC2XPQiloH+T
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-Endpoint-Received: by B4 Relay for chenyy23@mails.tsinghua.edu.cn/kernel
 with auth_id=900
X-Original-From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Reply-To: chenyy23@mails.tsinghua.edu.cn

From: Eduard Zingerman <eddyz87@gmail.com>

The sanitize_err() function is called when:
- ptr += scalar
- scalar += ptr
- scalar += scalar
ALU operations are processed.

This commit drops offset and pointer registers parameters from its
signature to simplify the follow-up changes for 'scalar += ptr' case.
regs[src].type is safe to access, as it is not mutated by the callers.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7aa47342dc659..9792d6622ffd6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13557,23 +13557,21 @@ static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
 		env->insn_aux_data[env->insn_idx].seen = env->pass_cnt;
 }
 
-static int sanitize_err(struct bpf_verifier_env *env,
-			const struct bpf_insn *insn, int reason,
-			const struct bpf_reg_state *off_reg,
-			const struct bpf_reg_state *dst_reg)
+static int sanitize_err(struct bpf_verifier_env *env, const struct bpf_insn *insn, int reason)
 {
 	static const char *err = "pointer arithmetic with it prohibited for !root";
 	const char *op = BPF_OP(insn->code) == BPF_ADD ? "add" : "sub";
 	u32 dst = insn->dst_reg, src = insn->src_reg;
+	struct bpf_reg_state *regs = cur_regs(env);
 
 	switch (reason) {
 	case REASON_BOUNDS:
 		verbose(env, "R%d has unknown scalar with mixed signed bounds, %s\n",
-			off_reg == dst_reg ? dst : src, err);
+			regs[src].type == SCALAR_VALUE ? src : dst, err);
 		break;
 	case REASON_TYPE:
 		verbose(env, "R%d has pointer with unsupported alu operation, %s\n",
-			off_reg == dst_reg ? src : dst, err);
+			regs[src].type == SCALAR_VALUE ? dst : src, err);
 		break;
 	case REASON_PATHS:
 		verbose(env, "R%d tried to %s from different maps, paths or scalars, %s\n",
@@ -13762,7 +13760,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		ret = sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
 				       &info, false);
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, off_reg, dst_reg);
+			return sanitize_err(env, insn, ret);
 	}
 
 	switch (opcode) {
@@ -13855,7 +13853,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			return -EFAULT;
 		}
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, off_reg, dst_reg);
+			return sanitize_err(env, insn, ret);
 	}
 
 	return 0;
@@ -14607,7 +14605,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	if (sanitize_needed(opcode)) {
 		ret = sanitize_val_alu(env, insn);
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, NULL, NULL);
+			return sanitize_err(env, insn, ret);
 	}
 
 	/* Calculate sign/unsigned bounds and tnum for alu32 and alu64 bit ops.

-- 
2.43.0


