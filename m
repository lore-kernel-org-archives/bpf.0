Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFD4418CB;
	Wed,  3 Jun 2026 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481102; cv=none; b=pnlVBiJU3dPcFX/hUrSF0cILol9yYHyZtI5YF+G9qw0cvj0abgkLu7YOArz6Laz6Iz+Pk8c8d74vKWgrgpLGj+tK/vIHVDo13kD5jFbDPSY86FM2XChThbMfkMgIWTLrQukJAAphxSSW2CpSYFCxhn/VWxmD06LN07yOrwHLuDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481102; c=relaxed/simple;
	bh=tL41712LfAtPfnNeOd2ROB5gyiHIP0CHY+UK3uxzBQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XHUxKSTlmMSiqX7eVAQ6O2YWb22QNAarL7wcCR5NBopWjPdrL/otnkz1ZyPEtcH0rlcfvfalSKPeENN6mO/12gBxnjiZF1HbnsS+3kdm7DyAaPS1WZzhrTx5ZW2JmoCZDaTfZTt49Gzd+M+6AXEfFXZnf9WF/tds3l7TqsquVzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: abc4ffaa5f3311f1aa26b74ffac11d73-20260603
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a6108fb0-68ec-4fff-b734-6e10be1227dc,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:a6108fb0-68ec-4fff-b734-6e10be1227dc,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:6329171bdfba5aa1b448262fb33c85da,BulkI
	D:260603180456RSCRRQPR,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: abc4ffaa5f3311f1aa26b74ffac11d73-20260603
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.160.128.85)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 189097230; Wed, 03 Jun 2026 18:04:55 +0800
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
Subject: [PATCH v2 3/4] selftests/bpf: Enable kptr_xchg_inline test on LoongArch
Date: Wed,  3 Jun 2026 18:04:37 +0800
Message-Id: <20260603100438.2177817-4-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260603100438.2177817-1-zhaochenguang@kylinos.cn>
References: <20260603100438.2177817-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run the kptr_xchg_inline functional test on LoongArch64 now that the bpf
JIT can inline bpf_kptr_xchg() with correct memory ordering.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c b/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
index 7def158da9eb..8f7b58727416 100644
--- a/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
+++ b/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
@@ -14,7 +14,8 @@ void test_kptr_xchg_inline(void)
 	int err;
 
 #if !(defined(__x86_64__) || defined(__aarch64__) || \
-      (defined(__riscv) && __riscv_xlen == 64))
+      (defined(__riscv) && __riscv_xlen == 64) || \
+      (defined(__loongarch__) && __loongarch_grlen == 64))
 	test__skip();
 	return;
 #endif
-- 
2.25.1

