Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71215EA6
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712267138; cv=none; b=ZRW4P2gEhSezXt1GDWixjYNLWJArJcr/me1lxpbodxcNJolhd96LmWr/MnBnxiTIpnf+hvJxw95G85edj/IK1muHUJwolJuc9JuW+Jh7zL8CmgFvpt2jLpKYl1MKnNRtgRlEwMrodW737lqSnJuYSZcIQPpNw/yPpXG9FdlK1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712267138; c=relaxed/simple;
	bh=A0HT0xszcrXeJvEi3LkjldnZGrFTZuzIfsRxBCheOTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYBMF0KDTGxpWxj9L7kzOb2keYS/PuUYIXztVLZi6T1ROF6XWmkyf8BdawBVUWJqOs6RU7yJRGevwSHn29+ACjdZU4j9dYBflapOm1zfqe/I6kM/U128HUHuvzKsC1/2BiQLnxmwSl5zLb+GGYtTV/FoWKJFwNP4PeONN62TMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTuGA4OM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTuGA4OM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38595C433F1;
	Thu,  4 Apr 2024 21:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712267138;
	bh=A0HT0xszcrXeJvEi3LkjldnZGrFTZuzIfsRxBCheOTg=;
	h=From:To:Cc:Subject:Date:From;
	b=MTuGA4OMHtYTwVKhfOyMAKM8U7OMZhCoYWWNrakxIF/iPb2MhsNaz2XRIJaOqUxOK
	 v7WrwHFB6Yne2/0LjhiczJc39EB4yqEjJnB//oB7/JJ6KtlOVXig8MtNc3qmW6Omhp
	 tOpAsx+e/p84BKSepX0Jl+Mb/ljkEdx7WDhJMhgy1qpV3sooBjjISoH1i1+z57js90
	 qyUnfXDKr+9fLNLvZ+OuhXagsNkh7Q82sqjJMqx39IuhLdogaCxtr+ctvHaL6iLiTf
	 NqGG18IlUlsKNedZZvXphphRULV5RHfjFSw/+IWy69fIfaifaadxfPrT/R4loTS1qN
	 jBnzn70g1+TLQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
Subject: [PATCH v2 bpf-next 1/2] bpf: prevent r10 register from being marked as precise
Date: Thu,  4 Apr 2024 14:45:35 -0700
Message-ID: <20240404214536.3551295-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

r10 is a special register that is not under BPF program's control and is
always effectively precise. The rest of precision logic assumes that
only r0-r9 SCALAR registers are marked as precise, so prevent r10 from
being marked precise.

This can happen due to signed cast instruction allowing to do something
like `r0 = (s8)r10;`, which later, if r0 needs to be precise, would lead
to an attempt to mark r10 as precise.

Prevent this with an extra check during instruction backtracking.

Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
Reported-by: syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ffaa9f7f153c..41446bea8fab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3615,7 +3615,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * sreg needs precision before this insn
 				 */
 				bt_clear_reg(bt, dreg);
-				bt_set_reg(bt, sreg);
+				if (sreg != BPF_REG_FP)
+					bt_set_reg(bt, sreg);
 			} else {
 				/* dreg = K
 				 * dreg needs precision after this insn.
@@ -3631,7 +3632,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * both dreg and sreg need precision
 				 * before this insn
 				 */
-				bt_set_reg(bt, sreg);
+				if (sreg != BPF_REG_FP)
+					bt_set_reg(bt, sreg);
 			} /* else dreg += K
 			   * dreg still needs precision before this insn
 			   */
-- 
2.43.0

