Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D02DC791;
	Mon, 22 Jun 2026 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782112373; cv=none; b=RUd+0JIGwnNeZYUoONAvb0lj7C7xllxCzTiZAd2Qc4N3acheSpIvH9W+OktmPFSjt5cmvt3oJcrTVebUZgptZUEqWMCj52xSFEv2H0jAPjeOwg+aST9iE3Pk+nEpnz+LvMn6gyN13SQi/cI8FYspIDL1XlUCTeBcyh0AtsE+1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782112373; c=relaxed/simple;
	bh=m6fU1Drq27f9CFNMwhYFuiyH6xgyjeaTE3SFZR+/Uds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GIZf8bhhxjBm5JTv2+YsGRdAYx8HeSEf7C0W4Zqd/EjjueQDnQ/WSrKO9lHR/7rwOKt1gtT3Krao1p/uYDkbBsynmJynMyUVltWW0MclPuacwT4e8SslXSQcuG8u5i0WjOeyVI1Y3/aPWwBK80PsmqgmVxW8crWaRyOEm+sLZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c4d1573e6e0911f1aa26b74ffac11d73-20260622
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:db92eb86-eeed-431b-ad1d-935b37b62a62,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:db92eb86-eeed-431b-ad1d-935b37b62a62,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:175a219c4fbe7abce093c47dc40f8b27,BulkI
	D:260622151247A2N4OL2U,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|136
	|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,
	Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c4d1573e6e0911f1aa26b74ffac11d73-20260622
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1855846249; Mon, 22 Jun 2026 15:12:46 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
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
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH v3 0/4] LoongArch bpf kptr xchg inline support
Date: Mon, 22 Jun 2026 15:12:30 +0800
Message-Id: <20260622071234.1410830-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables the BPF verifier to inline bpf_kptr_xchg() into BPF_XCHG
on LoongArch64, and fixes the underlying JIT atomic ordering that makes such
inlining safe.
The BPF verifier can lower bpf_kptr_xchg() to a single BPF_XCHG atomic when
the JIT advertises ptr xchg support via bpf_jit_supports_ptr_xchg(). This
removes helper-call overhead from the kptr exchange fast path. Inlining is
only correct when the JITed exchange provides the same sequentially consistent
ordering as the bpf_kptr_xchg() helper.
Patch 1 fixes memory ordering for all value-returning BPF atomic RMW operations
emitted by the LoongArch bpf JIT. Per LKMM, value-returning atomic RMW must
provide sequentially consistent ordering. Plain AMO instructions and bare
ll/sc loops on LoongArch do not satisfy this by themselves:
 - BPF_FETCH (ADD/AND/OR/XOR): switch to am*_db.{b,h,w,d}
 - BPF_XCHG: switch to amswap_db.{b,h,w,d}
 - BPF_CMPXCHG: emit dbar 0x700 after the ll/sc loop, matching
   __WEAK_LLSC_MB in cmpxchg.h
Non-value-returning RMW ops (plain BPF_ADD, BPF_AND, etc.) remain weakly
ordered, consistent with LKMM. This fix is independent of kptr inlining and
benefits all BPF programs using value-returning atomics on LoongArch.
Patch 2 implements bpf_jit_supports_ptr_xchg() so the verifier may inline
bpf_kptr_xchg() on LoongArch64.
Patches 3 and 4 extend bpf selftests: functional coverage via kptr_xchg_inline,
and an optional kptr-xchg benchmark to compare helper vs inlined paths.

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
v3:
 - Expand the JIT ordering fix beyond BPF_XCHG w/d to all value-returning
   atomic RMW ops (BPF_FETCH, BPF_XCHG, BPF_CMPXCHG), using barrier-carrying
   AMO variants and dbar after ll/sc as required by LKMM.
 - Add __btf_root() in the benchmark BPF program so bpf_obj_drop() remains
   visible to libbpf's kfunc linker when bpf_kptr_xchg() is inlined.

v2:
 - https://lore.kernel.org/all/20260603100438.2177817-1-zhaochenguang@kylinos.cn/

v1:
 - https://lore.kernel.org/all/20260602021515.214560-1-zhaochenguang@kylinos.cn/

-- 
2.25.1

