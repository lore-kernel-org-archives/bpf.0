Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35137BE9C;
	Wed,  3 Jun 2026 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481093; cv=none; b=cZ4Okip+AtB5NMjAQJmR8Sv89KDH0K1SFGcc3h7WwaSkUXPNdzp8XOX6UKrt0m2Yt9UVpbo8Si51UMLcxMgI3OUjCTNZ0gxg2hXC05wwbS3Xc10BqpOciIhB6Q3ZyORWW+/hIcotSEVp35ZksQLBQfkgvBqWFa6l9WPXLkQlAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481093; c=relaxed/simple;
	bh=75FmPZ4SgrH5dtsS4HbBcKGXJh+WnZD7Nx4gPfkZ3zI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NQ0qJWN/jMpVdwI6PQ2h47DYjzBwLrrobidGHT9OdX+lZf29rZST8Lz/OzKWTM3bBq914c2UG8CMpKixvuhIqbHgakVCL9LREbvArJv1Io1+xrb+hptm3v9GnTJeZ6OcaJBoGkX0Khk2gB7r7S8tjqTkqrHKwK0h05RZq0muTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a49f5c5c5f3311f1aa26b74ffac11d73-20260603
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2620c5eb-c7da-49fa-96c5-f716f9a182d9,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:2620c5eb-c7da-49fa-96c5-f716f9a182d9,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:f3fc05245646d9ccde8d563a31e11098,BulkI
	D:260603180444F4F9Z7IE,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|136
	|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,
	Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a49f5c5c5f3311f1aa26b74ffac11d73-20260603
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.160.128.85)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1172457377; Wed, 03 Jun 2026 18:04:43 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/4] LoongArch bpf kptr xchg inline support
Date: Wed,  3 Jun 2026 18:04:34 +0800
Message-Id: <20260603100438.2177817-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces the single patch "LoongArch: bpf: Support kptr xchg
inline" with four logically separate changes as requested during review.

Patch 1 fixes BPF JIT atomic xchg to use amswap_db.{w,d}, which provide
the full barrier semantics required by LKMM for value-returning atomic RMW.
This is independent of kptr inlining.

Patch 2 advertises bpf_jit_supports_ptr_xchg() so the verifier may inline
bpf_kptr_xchg() to BPF_XCHG on LoongArch.

Patches 3 and 4 extend bpf selftests: functional coverage via
./bench -d 30 -w 5 -p 1 kptr-xchg --nr-loops 256

Chenguang Zhao (4):
  LoongArch: bpf: Use amswap_db for BPF atomic xchg
  LoongArch: bpf: Advertise JIT support for kptr xchg inline
  selftests/bpf: Enable kptr_xchg_inline test on LoongArch
  selftests/bpf: Add kptr-xchg benchmark

 arch/loongarch/include/asm/inst.h             |  2 +
 arch/loongarch/net/bpf_jit.c                  |  9 +-
 tools/testing/selftests/bpf/Makefile          |  2 +
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_kptr_xchg.c    | 96 +++++++++++++++++++
 .../bpf/prog_tests/kptr_xchg_inline.c         |  3 +-
 .../selftests/bpf/progs/kptr_xchg_bench.c     | 48 ++++++++++
 7 files changed, 159 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_bench.c

---
v2:
 - Split the original single patch into four separate commits. 
 - Switch BPF_W/BPF_DW atomic xchg from plain amswap{w,d} to barrier-aware amswapdbw/amswapdbd.

v1:
 - https://lore.kernel.org/all/20260602021515.214560-1-zhaochenguang@kylinos.cn/

-- 
2.25.1

