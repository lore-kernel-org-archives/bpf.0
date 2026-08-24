Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AEE439913;
	Mon, 24 Aug 2026 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587561; cv=none; b=sb71T+6WTpMNG+rVUDMY617sFD9A5I2i6ZHapcp6GkiKyPeHvlRs2inQdGT/x+McSjd1s88kkIBEwmsNLx6YMNt6sSeSbKHhPGB+MtsdiMohwFd5xxdkhkREeM6fh7Yoc4+5LJAcgYx2r+vNuT+pKo6pk/kOepwMpFCcG6M98YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587561; c=relaxed/simple;
	bh=m2SBTQpkWSQqtHWMxAh9TvwsKocaEw70262S7IijE4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvWvY7qgUNJSX8xm+j/l/P0I89hQL7X9rN3SMhRYxuDyc9BY3YGyrneymQocC4bFAf4R4ZReNDxLEeIdHfsH8YEbzIS7GH1OErff+2civZcokBZA+jqPhfrFpvk4Ov0RGF1QxmVqNxvHf5hz6jTgiV019KQ4R2SJrv01poB9mGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IJ4nzVeh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IJ4nzVeh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC93A1AC1;
	Mon, 24 Aug 2026 09:05:53 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 769D03F85F;
	Mon, 24 Aug 2026 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787587557; bh=m2SBTQpkWSQqtHWMxAh9TvwsKocaEw70262S7IijE4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJ4nzVehS8Hj4+HT2oldjrWLZfDgo41bmtZTUlst4kclYjz6JGUKaYe6MBCCvzi8t
	 7KG05+LCjlzm0mxwo5U1+zEPCt1LJnfci69d5G/n9XN09VbrmnvKqGB7eAhMcCqd+S
	 ZBYO+C1F8Knznuik3pACO1Cht3v7ezOhwpBKTvfg=
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
Subject: [PATCH 3/7] maccess: Skip setup for zero-sized kernel nofault copies
Date: Mon, 24 Aug 2026 17:04:48 +0100
Message-ID: <20260824160523.3907021-4-usama.anjum@arm.com>
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

A zero-sized kernel nofault copy does not enter an access loop, but it
still disables and re-enables page faults.

Zero sizes are valid. BPF probe-read helpers accept them, and KGDB memory
packets may carry a zero length.

Return before changing page-fault state when there is nothing to copy.
For reads, keep architecture-specific address validation before the fast
path so its behavior is unchanged.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 mm/maccess.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/maccess.c b/mm/maccess.c
index 486559d688583..c59a0e092d24a 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -35,6 +35,8 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 
 	if (!copy_from_kernel_nofault_allowed(src, size))
 		return -ERANGE;
+	if (!size)
+		return 0;
 
 	pagefault_disable();
 	if (!(align & 7))
@@ -65,6 +67,9 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 {
 	unsigned long align = 0;
 
+	if (!size)
+		return 0;
+
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
 		align = (unsigned long)dst | (unsigned long)src;
 
-- 
2.47.3

