Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADE93EDAC2;
	Fri,  6 Mar 2026 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835220; cv=none; b=aeCLMfdqTcQNIDZ90ScfT49acyjFOQossytP7IQvgx7/TkfDPu2aECNSwhr8/6ekoVwTmyrxCQiEsCFiwnqXN2JJ243x4kZhqYdPAQY0940QdFE2SQoHLl6YYUd5oWgMdRHXpNBSfVwCB3MNxkza24kL5Uz016d4gCuUpRKsK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835220; c=relaxed/simple;
	bh=OVI6t529HegGkECaJr0l/Yz3IVKqy1vR3WWC7mHPbL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcJyKq92gkaIdt5EwfZKr/G+eMnbf+pSix79bH4ZRSeIRCrjtuayDjcg2UB0OA1+GDDemyeWr506LykUBz3dPip+PZWkoo/g9aGBlw+wHztoMk10o1a4zPHwNWs1uqtMd1itthvT/+AtiJ5NfsQsh2t7se7bQWbC7Lnnow2VB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EA581516;
	Fri,  6 Mar 2026 14:13:32 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4FF73F7BD;
	Fri,  6 Mar 2026 14:13:35 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	richardcochran@gmail.com,
	a.s.protopopov@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 1/3] bpf: introduce gotox_point in bpf_insn_aux_data.
Date: Fri,  6 Mar 2026 22:13:28 +0000
Message-Id: <20260306221330.630971-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306221330.630971-1-yeoreum.yun@arm.com>
References: <20260306221330.630971-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is preparation patch to fix BTI exception with gotox.
To make JIT know whether instruction is gotox points,
Add gotox_point field in bpf_insn_aux_data.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/linux/bpf_verifier.h | 3 +++
 kernel/bpf/verifier.c        | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ef8e45a362d9..92f4c252193e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -588,6 +588,9 @@ struct bpf_insn_aux_data {
 	 * accepts callback function as a parameter.
 	 */
 	bool calls_callback;
+	/* true if instruction is destination of gotox.
+	 */
+	bool gotox_point;
 	/*
 	 * CFG strongly connected component this instruction belongs to,
 	 * zero if it is a singleton SCC.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 401d6c4960ec..bf0281fb5db9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3973,6 +3973,11 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].jmp_point;
 }
 
+static void mark_gotox_point(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].gotox_point = true;
+}
+
 #define LR_FRAMENO_BITS	3
 #define LR_SPI_BITS	6
 #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
@@ -18720,6 +18725,7 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 		}
 
 		mark_jmp_point(env, w);
+		mark_gotox_point(env, w);
 
 		/* EXPLORED || DISCOVERED */
 		if (insn_state[w])
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

