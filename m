Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426D450413;
	Mon, 24 Aug 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587551; cv=none; b=dFCiBduXitqFI5mKuDabvZLxi3lkQmO5+IHvIUJMQg6v6ak7iIlbL456zQWIiqxwSO7bDqv3HkREvACrFD9V0cCZUDA7fAgA6GTOci1XFte7IacWqjJ8PzbDrjqJ510FcwT2OC6kHpZHK5QNzUkSJo/dDT19/sPdzJ3lR0i0fBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587551; c=relaxed/simple;
	bh=1MvPs/PV2tLB4HDsvTjKWixuWNV1rCXGW/G3quH+LLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+3epPUZKq20SIbfNl6fHR7Hd+p97ED8uh8HgQkOheoksbBDx4GXtFWpzsLhmIjk+sVp2w0zgFduyScS30AMD97jLdB+RftoajzLa/NfkKuBGHHk4lUbNGmLFbswSw4GPNuAq30ba9yEVojDfv1VU3SoQQDbapu5/DFnzEmKmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vw1mzenU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vw1mzenU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492D816F2;
	Mon, 24 Aug 2026 09:05:43 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD55E3F85F;
	Mon, 24 Aug 2026 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787587547; bh=1MvPs/PV2tLB4HDsvTjKWixuWNV1rCXGW/G3quH+LLs=;
	h=From:To:Cc:Subject:Date:From;
	b=vw1mzenUY8gK8nUmmAxeKjb9a86TCQ0iVEQWg8R7B4POGuzbglchYJbzDSfmmTfv0
	 gXGiOcK9oIuGSjJ3XjCUH6YEhOp7EgFCD0Z04j3UVhXsw8NB6vnhAHCoq6Him6v4/4
	 emWSAony0re2jPv4WqmCIZPzZeU8g/k+ttOmssaA=
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
Subject: [PATCH 0/7] arm64: Batch PSTATE.TCO handling in kernel nofault loops
Date: Mon, 24 Aug 2026 17:04:45 +0100
Message-ID: <20260824160523.3907021-1-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With Hardware Tag-Based KASAN in asynchronous or asymmetric mode, kernel
nofault loops currently set and clear PSTATE.TCO around every access.

Introduce bare nofault accessors, batching hooks, and an internal scope
guard. Convert maccess page-fault cleanup to scoped form. Skip
page-fault setup for zero-sized kernel nofault copies and zero-length
BPF string operations. Then use bare primitives in the maccess and BPF
loops. For non-empty operations, this reduces the code-derived dynamic
MSR TCO execution count from 2N to 2. Two-string BPF comparisons fall
from 4N to 2.

The BPF changes and an earlier maccess implementation with explicit
cleanup were tested with QEMU arm64 using Hardware Tag-Based KASAN in
synchronous, asynchronous, and asymmetric modes. All nine arm64 MTE
kselftests passed in each mode, as did the 138 focused BPF string_kfuncs
and varlen subtests. The focused BPF tests also passed with the default
non-MTE arm64 CPU model. Both final maccess scoped-guard patches were
arm64 cross-built. Runtime tests have not been rerun after that
conversion.

Muhammad Usama Anjum (7):
  arm64: uaccess: Add batched kernel nofault accessors
  uaccess: Add scope guard for bare kernel nofault regions
  maccess: Skip setup for zero-sized kernel nofault copies
  maccess: Use a scoped guard for page faults
  maccess: Batch TCO handling in kernel nofault loops
  bpf: Skip setup for zero-length string kfunc operations
  bpf: Batch TCO handling in string kfuncs

 arch/arm64/include/asm/uaccess.h | 71 ++++++++++++++++++++++++--------
 include/linux/uaccess.h          | 20 +++++++++
 kernel/bpf/helpers.c             | 41 ++++++++++++------
 mm/maccess.c                     | 68 ++++++++++++++++--------------
 4 files changed, 139 insertions(+), 61 deletions(-)

-- 
2.47.3

