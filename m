Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819BE3F23BE
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588363; cv=none; b=e/pW8/utpbdhX3rqU1b4JlLkZbcJvdh6gjYJ2yTl3BK9crAWh5qO00GzcR0489LOXAB23/HkAtUAtk9UPcuUK5wr2y2VCADVDnB0nvhpvHnzjp33b3jWcyg1gzT2k1zksbk1P672JDUq29bCR3mLSTERn6QHfzWdyylHIWI+f6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588363; c=relaxed/simple;
	bh=Cv6+EnHKlYEyrsTw5T5FznzsOfb6ghBGEkt+na9dBSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lpcf312HGuKm4hZbinLB6Sbfy+rub88ua7ZK91abZlOKIFLuv3AKxWlAO46wwmk+O+3sQvOg1K/HawEiKVXMOgO1eK4ZYi0HqGDg63JVQFWdBgXOJ9wr3aueOuD52bfVagVo2BWHSYXxMw+i1Z8N5xFuuPAO2GA1Jv4fkiDSlKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XMppVooG; arc=none smtp.client-ip=91.218.175.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XMppVooG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Cv6+EnHKlYEyrsTw5T5FznzsOfb6ghBGEkt+na9dBSs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789588338; v=1; x=1790193138;
 b=XMppVooGzETU8jB9YgblebsaikTyq9/mfrvN1CpRFTHD/1I4m7ceHY5qDGIRkRlGrgIuA1OI
 YfSORek/3tA26COB9UmrBfsW7XU8Qq5jOyy+KqHtLjoqOT16ndtjzUv7yfFN1Xzrf8sX7WHCKWI
 mFq48q1kCyoKsGvkTDM4nQKQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id a27f0a83e7a07625;
	Wed, 16 Sep 2026 19:52:18 +0000
X-Mizu-Trace-ID: a27f0a83e7a07625
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v3 0/5] x86/cpu: Refactor identify_cpu()
Date: Wed, 16 Sep 2026 12:51:58 -0700
Message-ID: <20260916195203.1099646-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor identify_cpu() machinery on x86 and then implement a fix for
a bug when cpu capabilities are temporarily cleared within an
interruptable window. For more details and discussion see the relevant
bug report [1] and patch #5 ("x86/cpu: Don't transiently clear the
boot CPU's capabilities").

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

[1] https://lore.kernel.org/bpf/20260610175651.647515-1-ihor.solodrai@linux.dev/

---

v2->v3:
  * Commit message edits on patches #1, #2, #5

v2: https://lore.kernel.org/bpf/20260814235134.3461435-1-ihor.solodrai@linux.dev/

v1->v2:
  * Rewrite commit messages to fit more conventional structure (Boris)
  * Drop identify_cpu_32() helper, it's unnecessary (Boris)
  * New patch (#2): now early_identify_cpu() resets boot_cpu_data
    through init_cpu_info() as well
  * The boot CPU reset is now skipped on 32-bit too (sashiko)

v1: https://lore.kernel.org/bpf/20260704002046.3859585-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (5):
  x86/cpu: Factor init_cpu_info() out of identify_cpu()
  x86/cpu: Initialize boot CPU cpuinfo defaults early
  x86/cpu: Inline generic_identify() into identify_cpu()
  x86/cpu: Move 32-bit SEP setup into identify_cpu()
  x86/cpu: Don't transiently clear the boot CPU's capabilities

 arch/x86/kernel/cpu/common.c | 92 +++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 48 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.55.0

