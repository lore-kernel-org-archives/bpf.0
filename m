Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334034389F
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292197; cv=none; b=AizA01rn+UnvZhJGE3/8yQWSKJdGljfK8MVT2tqA0ECSfaIe8vpi/COh7ZGiaWyKTqecqlhlPSS6ye90LhZD11oHUw2hjV3bH3GWU0ban+wLz981uy5h3bEP92M3hV+pvvaXWVFUiJW4tBhZmfBlITl/iSXGhfmMm7RNhN51oIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292197; c=relaxed/simple;
	bh=S/5a3tZKaG1DhHr+vr7kXCnj7Webr6UiI9jqlWXgH/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u4kpDc5zIUxXQ4DhuK9J8XKPrMDfnHnE0eAu2+vlVjZ5K6VasBR3eXEpOnKwITgXaaqRNHYolcIn2QBzdUtws9V5/TpAOY5gNC1cz3F06C4yQxKSA7oXulSX9dWTQqMm/XXCVQFY8v6iIKSOAdGMx4PpgjLH9TRB5YIHW4BdgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uIsOq2l6; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uIsOq2l6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785292192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bgK4DkmBX3WByoHXl7Q/Ih8jzCTq/qOCycXaOJxX9Qs=;
	b=uIsOq2l6e8igoM1RmPvodxi5IDAu9uX8uvK5vKuHWUPdf8QiDo59TEQCfKe/KZ2xaIs5tc
	4l90xgNtZIaxeMOqjnfVLTG1BLFPZA90eKKieTpZLfqeu2AU4vhe0/WTsmfueCExAdVed+
	0qak5n1me/BSuTKP7Y7Tpr5AGgXKwj4=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH v4 0/4] LoongArch bpf kptr xchg inline support
Date: Wed, 29 Jul 2026 10:28:33 +0800
Message-Id: <20260729022837.355549-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

This series enables the BPF verifier to inline bpf_kptr_xchg()
into BPF_XCHG on LoongArch64, and fixes the underlying JIT
atomic ordering that makes such inlining safe.

The BPF verifier can lower bpf_kptr_xchg() to a single BPF_XCHG
atomic when the JIT advertises ptr xchg support via
bpf_jit_supports_ptr_xchg(). This removes helper-call overhead
from the kptr exchange fast path. Inlining is only correct when
the JITed exchange provides the same sequentially consistent
ordering as the bpf_kptr_xchg() helper.

Patch 1 fixes memory ordering for all value-returning BPF atomic
RMW operations emitted by the LoongArch bpf JIT. Per LKMM,
value-returning atomic RMW must provide sequentially consistent
ordering. Plain AMO instructions and bare ll/sc loops on LoongArch
do not satisfy this by themselves:
 - BPF_FETCH (ADD/AND/OR/XOR): switch to am*_db.{b,h,w,d}
 - BPF_XCHG: switch to amswap_db.{b,h,w,d}
 - BPF_CMPXCHG: emit dbar 0x700 after the ll/sc loop, matching
   __WEAK_LLSC_MB in cmpxchg.h
Non-value-returning RMW ops (plain BPF_ADD, BPF_AND, etc.)
remain weakly ordered, consistent with LKMM. This fix is independent
of kptr inlining and benefits all BPF programs using value-returning
atomics on LoongArch.

Patch 2 implements bpf_jit_supports_ptr_xchg() so the verifier
may inline bpf_kptr_xchg() on LoongArch64.

Patches 3 and 4 extend bpf selftests: functional coverage via
kptr_xchg_inline, and an optional kptr-xchg benchmark to compare
helper vs inlined paths.

Chenguang Zhao (4):
  LoongArch: bpf: Fix memory ordering for value-returning atomics
  LoongArch: bpf: Advertise JIT support for kptr xchg inline
  selftests/bpf: Enable kptr_xchg_inline test on LoongArch
  selftests/bpf: Add kptr-xchg benchmark

 arch/loongarch/include/asm/inst.h             | 18 ++++
 arch/loongarch/net/bpf_jit.c                  | 37 ++++---
 tools/testing/selftests/bpf/Makefile          |  2 +
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_kptr_xchg.c    | 96 +++++++++++++++++++
 .../bpf/prog_tests/kptr_xchg_inline.c         |  3 +-
 .../selftests/bpf/progs/kptr_xchg_bench.c     | 49 ++++++++++
 7 files changed, 192 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_bench.c

---
v4:
 - Resend patches against new kernel.

v3:
 - https://lore.kernel.org/all/1782119051687451.15056.seg@mailgw.kylinos.cn/

v2:
 - https://lore.kernel.org/all/20260603100438.2177817-1-zhaochenguang@kylinos.cn/

v1:
 - https://lore.kernel.org/all/20260602021515.214560-1-zhaochenguang@kylinos.cn/

-- 
2.25.1

