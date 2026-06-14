Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397D2236F0;
	Sun, 14 Jun 2026 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470932; cv=none; b=DDa9SX9SGCdmZu8aQvoQv4FHq4ozzEqtISYrSAOD5UPh3cmZWa29OzV6TNhKGZzGe8crzWxIig3mZ/5LZ/Nn/hn0DgM+qEXU+2PWLCGVpBoeUvDzLSD5Iq40JCMs3/jE9GYeXnptE0giCCXiLSK4CHymbMBD3bJ1nl1CiM2fVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470932; c=relaxed/simple;
	bh=vy60lnxBaMNG6ZMIagHF2qCo5rN52Fipdr2dOCZOJTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivMBP+EoDICKNQoROFC8XIsuLVLNjjFjZ2YPAVOCBZSkeGk7Qo6JjLaFIjMpP9ozfT0S2O0DQANmfWksb4IKgIR5oyfywbx224gjw5EbUxf8gln0A8JpMHaz08rphLQWEknDQEHi9oDlFbsqFJ+3kGbe1heQsYHd7+xxIDyQDEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnL97brA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnL97brA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00EE1F000E9;
	Sun, 14 Jun 2026 21:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781470930;
	bh=x5PL9ea68ETMoE/me7VchVD3ZaplPIV6ryZDRpLN4uU=;
	h=From:To:Cc:Subject:Date;
	b=DnL97brAJwWsRnbft2pAvI6LhC44L+A+or5qP9u5r5vret8j3fO/knh/Payo1LFUi
	 ciEFh4xbJHSSzl+SrYmvlwaF0hCP2j5rNZJc3wTNMaMWbCVwM1P2f6K0fEvp3y6Wk+
	 qjNgktpemBXnmDOcOkEZd0qmq9x31Ammny8roA1Hg35bAMO7hEm17lGbIOAHUTNruE
	 X3wAhWdTRMRwToz7jU0zLKAYr/TY4xHB0M93FKFg6FiGwwqmUi9DJgF61LsWm0SXeM
	 K8Qa0dRUWC+zyEvRL/jibWjjFgvrEVQ5db03zFnV/ltJfv3j9FXFG7TtT1tI8eFszF
	 +n7kxmpgPpj4w==
From: Tejun Heo <tj@kernel.org>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	rppt@kernel.org,
	arighi@nvidia.com,
	emil@etsalapatis.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] arm64: mm: Remove misleading pte_none() comment from ptep_try_set()
Date: Sun, 14 Jun 2026 11:02:09 -1000
Message-ID: <20260614210209.2371030-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This comment was thoughtlessly copied from the x86 version and doesn't
apply to arm64. Remove it.

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3ce0f2a6cab6..b0213799ebc4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1830,10 +1830,6 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 	return __ptep_get_and_clear(mm, addr, ptep);
 }
 
-/*
- * Note: strictly-zero compare is narrower than pte_none(), but the gap is
- * harmless: a fresh kernel PTE has no software bits set.
- */
 static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
 {
 	pteval_t old = 0;
-- 
2.51.0
