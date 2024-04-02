Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1D22625
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712098223; cv=none; b=iN5RxL8G3TY0Ms3rEgWcZaqBazsq1WmSgYmx5EnkCa7dRrF44tvYip9MD0+S2Z+c2hiwfUDOGhioo1DKwYJ0pY+h0MX5TtwStRSY5ef+2lBM3aCS3yNnp3Xro7ZafK+cSvVIQyi0XxlDnKd5xuLqKbXgQamBrfoVlVRBc+hHgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712098223; c=relaxed/simple;
	bh=NZ232OgPTMstbnp4qCSMDoVERFr6ZQUW3jQ7Qp7mjNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfN+6tHBHbOTr5k8Qup7PWYcwl/fJws01w9/GyDOSJqvdXw+KVUQpVy1iohzhKCUUDmoO5eQsq6uWosKcCkMnWABQrmmjpm5z+vipAL/OQQDr0gCWsYg8mnA2Pp6WxAMltKqi5qSD3c4ndFwz4nXpVDwZXXZpamRsgDeImyhSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6G11k8l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6G11k8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4618C433C7;
	Tue,  2 Apr 2024 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712098222;
	bh=NZ232OgPTMstbnp4qCSMDoVERFr6ZQUW3jQ7Qp7mjNE=;
	h=From:To:Cc:Subject:Date:From;
	b=A6G11k8lW66MayMZNYtbu33iXh2PgqmLFUulIDvxn9F7k0/WxrX/VOxc65oolpRCH
	 ePKb+8j1a0GZnZu2sX5PLiZLS512NHp+RuZLYt0QYaWF+ei0Xnk2jI2OE202izWC5V
	 0KDs5JM1P2FQoV1Ed9foS/ZpvSK0HqUFrTbl3O8eI5FJlRIFgecPeNW4WGVr7ZHUbd
	 WdxSFsRjNqFB4ZMXlUuWqci430ZpaWVkMjuR63c8h+/npUUH4r8oY7oVcpMGO944qn
	 EPfAtEpqyByiLZ18YsYkdGlhbVL3yU0/Q+63jmyiec7EvPcYD5G935QhmUNlJ0Jr9c
	 m+CKmV65f1vdA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
Subject: [PATCH bpf-next 1/2] bpf: prevent r10 register from being marked as precise
Date: Tue,  2 Apr 2024 15:50:19 -0700
Message-ID: <20240402225020.2582397-1-andrii@kernel.org>
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
index fcb62300f407..02361e2a2f4e 100644
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

