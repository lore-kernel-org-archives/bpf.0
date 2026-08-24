Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB9F4611E1;
	Mon, 24 Aug 2026 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587574; cv=none; b=oi5bRNotO2xhAgnCqL6PKeZI5umkiWnTrdke9wLCx77K6AOC/VpqrZ1Zdy3fEyjcUvHvAEwx9+orYsqIXCafqHeEmZd+pd0IxI0twLcpdIcyWqjvKoTw9Ax73e6KQqwRA7yQ7Ojr583t8S1uV28VYgjqxZT6NwAVsW13Rt69rDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587574; c=relaxed/simple;
	bh=RrebhXATXwELFIUm3sfpDdh92ACD3QNlTwQzpg9AkNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYsER3GCw3PRI/SDcYgJfsnrilb8btt3LZwmq22RHt+8rntGbsS+/z4XYFqTFeY27pkcJcEO8HY/aaCIh3Cnngbdie+VGecdTF7GjJDVJrylEgphVI9IZ2IzW8+WivJarGEVznmg7j9iWbzXpljedx/mBpbIcoVHG4cW3GmIomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Jc91idwU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Jc91idwU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 684411756;
	Mon, 24 Aug 2026 09:06:04 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C5DE3F85F;
	Mon, 24 Aug 2026 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787587568; bh=RrebhXATXwELFIUm3sfpDdh92ACD3QNlTwQzpg9AkNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jc91idwUPeyzoMBCcMqqcJfBY/NipSip+nx0Vu2SSHMLt0GB1cy1vcJ0XIHfHuDVt
	 ZfysIhqHXV5A+RsGPMQs5ObrYLtPAo5PLdYurj6y9VDAQ+21gPimS5kpua6pOqy5p/
	 cu3IO/eY89jF1Cl+5pzRLPOStBWlPPk/3hQnsiX0=
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
Subject: [PATCH 5/7] maccess: Batch TCO handling in kernel nofault loops
Date: Mon, 24 Aug 2026 17:04:51 +0100
Message-ID: <20260824160523.3907021-7-usama.anjum@arm.com>
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

With Hardware Tag-Based KASAN in asynchronous or asymmetric mode, every
arm64 kernel nofault access sets and clears PSTATE.TCO. Copy and string
loops repeat that pair even though tag checking can stay disabled for the
whole operation.

Cover each non-empty operation with one bare nofault region and use bare
accessors in the loop. Leaving the region restores TCO before page faults
are enabled again, including after an access fault. Existing empty-work
checks ensure that every new region performs at least one access.

The number of dynamic MSR TCO executions therefore changes as follows:

    Work                         Before    After
    N nofault accesses          2N        2
    4 KiB nofault copy          1,024     2
    N-byte strncpy              2N        2

The 4 KiB case assumes 512 64-bit accesses. These figures come from the
control flow rather than a runtime measurement, so the time saved depends
on the CPU and workload. Generic fallbacks leave other architectures
unchanged.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 mm/maccess.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index f695ceefe6fcc..87486bf98d15a 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -19,7 +19,7 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
  */
 #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
-		__get_kernel_nofault(dst, src, type, err_label);	\
+		__get_kernel_nofault_bare(dst, src, type, err_label);	\
 		kmsan_check_memory(src, sizeof(type));			\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
@@ -39,13 +39,15 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 		return 0;
 
 	scoped_guard(pagefault) {
-		if (!(align & 7))
-			copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
-		if (!(align & 3))
-			copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
-		if (!(align & 1))
-			copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
-		copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
+		scoped_guard(__kernel_nofault_bare) {
+			if (!(align & 7))
+				copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
+			if (!(align & 3))
+				copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
+			if (!(align & 1))
+				copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
+			copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
+		}
 	}
 	return 0;
 Efault:
@@ -55,7 +57,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
 
 #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
-		__put_kernel_nofault(dst, src, type, err_label);	\
+		__put_kernel_nofault_bare(dst, src, type, err_label);	\
 		instrument_write(dst, sizeof(type));			\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
@@ -73,13 +75,15 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 		align = (unsigned long)dst | (unsigned long)src;
 
 	scoped_guard(pagefault) {
-		if (!(align & 7))
-			copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
-		if (!(align & 3))
-			copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
-		if (!(align & 1))
-			copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
-		copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
+		scoped_guard(__kernel_nofault_bare) {
+			if (!(align & 7))
+				copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
+			if (!(align & 3))
+				copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
+			if (!(align & 1))
+				copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
+			copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
+		}
 	}
 	return 0;
 Efault:
@@ -96,11 +100,13 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 		return -ERANGE;
 
 	scoped_guard(pagefault) {
-		do {
-			__get_kernel_nofault(dst, src, u8, Efault);
-			dst++;
-			src++;
-		} while (dst[-1] && src - unsafe_addr < count);
+		scoped_guard(__kernel_nofault_bare) {
+			do {
+				__get_kernel_nofault_bare(dst, src, u8, Efault);
+				dst++;
+				src++;
+			} while (dst[-1] && src - unsafe_addr < count);
+		}
 	}
 
 	dst[-1] = '\0';
-- 
2.47.3

