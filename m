Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B57D1DE8BB;
	Sun,  7 Jun 2026 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780819179; cv=none; b=R/kBeF/u33w9p+FS/FRRgxLsZpvFNGG9eTLWy+bU6jsFjDS9rf6FSWB8Aio3gSL/k1M3gQOP2G9DLCaDODwFy16xaPtKwy96ccJ3WVnqe5t4AKYS+c54t2Yxpc4XJXYGgBFeU0b/khEnJVTIR9Y/pMh7hrInIuCVjrtG0+70+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780819179; c=relaxed/simple;
	bh=DeCd1uXKnhosZM1z2ioX7aP175elzL3SZkxDyr0jMeY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=mduYvD+153lWt34usQEo+mEoC5rvVWH9Lu7LdYs3wlGGkSMU+TKxemTEVxP3XyJ1rp4MXro0beibH66eZ88ixDAlWImpiigDLtAwN4ETxFTYkQhPG4XMhz+3hkcE/4r1CW5e6E6DRP+aCNHBwz1bxifXLVg6Xu/LZykTASezghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcNguZiA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcNguZiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B795E1F00893;
	Sun,  7 Jun 2026 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780819177;
	bh=pY3Syi9J71kcCpYa/qDSw//aIWzv401LmWCaxGFOX9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WcNguZiAzEWDEiH6QF9WQwB9orcSb7cwktW/oFZ6a9Om5GynxANuGWzBpCaQ6qYeY
	 PIWx+wgsTgIKl16Y9WwYkW8A275bQ1+k8RmayN3INi2ACrqoUVRM4OFv7QLBl+XF4A
	 vPuOOLoJjVds2WtqNYHRBjx4j/GNtN3UaNZLul2ATHmilucG2njfuTzVDEZsikgjES
	 Nf73jqA49B7A2rNdFIVx3OOIKevWDllJO3anpTyCTmsNfbWX2L1IwuDC/Xn74EGSLQ
	 Sjw4jW+WSIP3b75W4/dPrxVe7jVlY2QVA4rakQDeFQ5Xy5g7cQUJfh60k7rOWpO511
	 FetRX9bgJHlrg==
Date: Sat, 06 Jun 2026 21:59:36 -1000
Message-ID: <088f52fd25860ca961449d53f91b214a@kernel.org>
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
Subject: [PATCH bpf-next] arm64: mm: Complete the PTE store in ptep_try_set()
In-Reply-To: <aiRFcz78QTZdIHHB@arm.com>
References: <20260601183728.1800490-1-tj@kernel.org>
	<f45f02410d23c99d14f3577da9b27a327816b5a0904bdeefc8e229eac760d1cf@mail.kernel.org>
	<8f133924fbf8d259340f3057e505f663@kernel.org>
	<aiRFcz78QTZdIHHB@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

ptep_try_set() installs the new entry with try_cmpxchg() but, unlike
__set_pte(), never calls __set_pte_complete(). On arm64, installing a valid
kernel PTE requires barriers afterward so a subsequent access observes it.
Without them the access can fault instead of reaching the freshly installed
page.

Call __set_pte_complete() after a successful cmpxchg, mirroring
__set_pte().

Fixes: 258df8fce42f ("mm: Add ptep_try_set() for lockless empty-slot installs")
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/all/aiRFcz78QTZdIHHB@arm.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3ce0f2a6cab6..dc8525431273 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1838,7 +1838,11 @@ static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
 {
 	pteval_t old = 0;
 
-	return try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte));
+	if (!try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte)))
+		return false;
+
+	__set_pte_complete(new_pte);
+	return true;
 }
 #define ptep_try_set ptep_try_set
 
-- 
2.51.1

