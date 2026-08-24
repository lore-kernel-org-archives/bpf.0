Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0446C45FFBD;
	Mon, 24 Aug 2026 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587569; cv=none; b=NJ9Ywgh0mzwXJu/d+/2dk8QaGGBLVpGCHWWYGpqoO3OicsYdXnwfRjOei7kQsTgF7NQEcEX+oZY3OqJppTLTzgRkCVjtOjNXL2M1H6Fr0Es6/Y78Ol4bgKnpqSdKycS9h6YIownIO0gX3ClXfCL552pT10i5mpswO4tWdDI3YXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587569; c=relaxed/simple;
	bh=nodn3/K9trBK+2wWrkLJGeFqd0INql6u2EHBqnLbWuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVH8phTNaGNlC2L6NklNkDKKHY4PuJD3d9csZ7HtRfzVoBP8TIbwzyBPTHVe2WtZXyvggz3PPR+ghyB0hfiUCgg1sG8B4Iu2HVxHUkyToV9nltCzKGvTsdO3fdHhUrM98d98zEOB66sTCfLLdDr3ERlj2pGVKKemE1BDHXfNLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cM4OF4zK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cM4OF4zK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2D1F16F2;
	Mon, 24 Aug 2026 09:06:00 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 846553F85F;
	Mon, 24 Aug 2026 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787587564; bh=nodn3/K9trBK+2wWrkLJGeFqd0INql6u2EHBqnLbWuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cM4OF4zKGJ1P/SjzDr6eXMRdqUQP3re7P3X9242MP8mexIfZldlzw0sfMcbAUSh1L
	 1a49U9Gw7XBFBsIGu7em0nv2/uib4e3xK/sCEUzr4sS4BhFi9PqpXz8JGLANNTKTay
	 tyBid6SLPtTSmY70IX5SC9k9RdCKMRCJUje9FtAk=
From: Muhammad Usama Anjum <usama.anjum@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - CORE)
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
Subject: [PATCH 4/7] maccess: Use a scoped guard to re-enable page faults
Date: Mon, 24 Aug 2026 17:04:50 +0100
Message-ID: <20260824160523.3907021-6-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824160523.3907021-1-usama.anjum@arm.com>
References: <20260824160523.3907021-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel nofault copy and string paths open-code page-fault disable and
enable around label-based loops, duplicating cleanup on success and
failure.

Use a page-fault scope guard instead. Leaving the scope now re-enables
page faults on both paths without separate cleanup at the fault label.

No functional change.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 mm/maccess.c | 53 +++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index c59a0e092d24a..f695ceefe6fcc 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -38,18 +38,17 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!size)
 		return 0;
 
-	pagefault_disable();
-	if (!(align & 7))
-		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
-	if (!(align & 3))
-		copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
-	if (!(align & 1))
-		copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
-	copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
-	pagefault_enable();
+	scoped_guard(pagefault) {
+		if (!(align & 7))
+			copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
+		if (!(align & 3))
+			copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
+		if (!(align & 1))
+			copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
+		copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
+	}
 	return 0;
 Efault:
-	pagefault_enable();
 	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
@@ -73,18 +72,17 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
 		align = (unsigned long)dst | (unsigned long)src;
 
-	pagefault_disable();
-	if (!(align & 7))
-		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
-	if (!(align & 3))
-		copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
-	if (!(align & 1))
-		copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
-	copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
-	pagefault_enable();
+	scoped_guard(pagefault) {
+		if (!(align & 7))
+			copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
+		if (!(align & 3))
+			copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
+		if (!(align & 1))
+			copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
+		copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
+	}
 	return 0;
 Efault:
-	pagefault_enable();
 	return -EFAULT;
 }
 
@@ -97,18 +95,17 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 	if (!copy_from_kernel_nofault_allowed(unsafe_addr, count))
 		return -ERANGE;
 
-	pagefault_disable();
-	do {
-		__get_kernel_nofault(dst, src, u8, Efault);
-		dst++;
-		src++;
-	} while (dst[-1] && src - unsafe_addr < count);
-	pagefault_enable();
+	scoped_guard(pagefault) {
+		do {
+			__get_kernel_nofault(dst, src, u8, Efault);
+			dst++;
+			src++;
+		} while (dst[-1] && src - unsafe_addr < count);
+	}
 
 	dst[-1] = '\0';
 	return src - unsafe_addr;
 Efault:
-	pagefault_enable();
 	dst[0] = '\0';
 	return -EFAULT;
 }
-- 
2.47.3

