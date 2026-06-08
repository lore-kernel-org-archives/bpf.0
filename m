Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172FA2D738F;
	Mon,  8 Jun 2026 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903550; cv=none; b=aWZ6seP4vrG3/nSkV+i1vPPnXKjpYiz+2/mx4iJu7Ni0314RiKfF5anPBPfPxuXIOKOrAY/yNXx+HpLYdtQzVUkMxvhLmd6U1z36SsS3OgthubFxgWpzWVj3bg6GBOvi2siKrkGdWy21gTOfvuBGpOKPX96pedhtPgskOBrn1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903550; c=relaxed/simple;
	bh=0UjPM8frBifh6/4lW6B6dDRE6A9s1KZ7yCcfVrCsGAk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=KTrS1Y+iSNyieoZ4LV3mN38fB67t0oDv9Aroon0fUdIRSG05PVg6OYbWRuwbWMRgKiegzxU1mhR/q4R8+ZsdRqPkZiNquvUFxGfezf8Gl6naJv4vdmogbM4oBzCO+Pky1C1oYxh5pNfcqFbiO0pHuYP9SuUp0j1C54u1k/hNgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km2IxtHZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km2IxtHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F141F00893;
	Mon,  8 Jun 2026 07:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780903548;
	bh=KTBGi8oCZ29Roe5CgH69uQStkzIgyiOeC35FA5eeDPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=km2IxtHZIktwRU6635g8jlJprIRhl9fSIjqUyOj5lz8NlJoVU7udXLnh9gxiQHqfN
	 Ho8tP98QVDYT7e7M1vtNBaxY3ZqxywP7vPxCLlfSpM5R37nNY4LON6vctCRHBZ9rTJ
	 AOrOiBs+dZ7MEKnAO2NzHFmJsnmNM9zdqPbSrcKfbT8snI4b0mjjwpcfKftahXkR57
	 Amyr1wvgAcMN0xcrfpIud3JS0pAhGC71a0s36Az/truacRX9P6qr3vVc8dGSr6VpIG
	 ibS5OGgaRSMwuZ1n4j6e4QEzUSpG0Bs4StxI4B6M5tp9/dh5M/m70rDA3VfPBW66hF
	 KKSdU8i8BNyAQ==
Date: Sun, 07 Jun 2026 21:25:47 -1000
Message-ID: <7f5f7c94601312c1a401fb18998291cc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
 Andrea Righi <arighi@nvidia.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next] arm64: mm: Complete the PTE store in ptep_try_set()
In-Reply-To: <aiXVFK_qb54is8b1@arm.com>
References: <088f52fd25860ca961449d53f91b214a@kernel.org>
 <5f68f44310d4878185fd5ebc52d66530b99f174c6d04ab1170dc53cefaa54568@mail.kernel.org>
 <1780862659.ccb18e27e916dc4b@kernel.org>
 <aiXVFK_qb54is8b1@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

ptep_try_set() installs a kernel PTE with try_cmpxchg() but, unlike
__set_pte(), skips the barriers that arm64 requires after writing a valid
kernel PTE. Without them a subsequent access can fault instead of seeing
the new mapping.

Issue them with emit_pte_barriers() rather than __set_pte_complete().
ptep_try_set() must finish the store before it returns, but
__set_pte_complete() would defer the barriers when the calling context is in
lazy MMU mode.

v2: Emit the barriers directly instead of __set_pte_complete(). (Catalin)

Fixes: 258df8fce42f ("mm: Add ptep_try_set() for lockless empty-slot installs")
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/all/aiRFcz78QTZdIHHB@arm.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3ce0f2a6cab6..3e579c26b383 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1838,7 +1838,16 @@ static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
 {
 	pteval_t old = 0;
 
-	return try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte));
+	if (!try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte)))
+		return false;
+
+	/*
+	 * The store must be complete by the time this returns, but the caller
+	 * may be in lazy MMU mode, where __set_pte_complete() would defer the
+	 * barriers. Issue them directly.
+	 */
+	emit_pte_barriers();
+	return true;
 }
 #define ptep_try_set ptep_try_set
 
-- 
2.51.1
