Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145DA3793DF;
	Mon, 22 Jun 2026 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119057; cv=none; b=J+j9o0kB0knxELgYk8zwCRJ+EWJeK3tOLAL76XBMi6BznJSC/Bey2sJovpVmYGcNoUibZgIF0tyPKcRcA3gI9xmUCvlf8oMG9akYaFRtp5SDfTrNvExCIVQFC3Cy+Fw9X+Ix4YQN2VTcXuYpcjTP4wqMNbsydbBhR76tCr0Ul/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119057; c=relaxed/simple;
	bh=tL41712LfAtPfnNeOd2ROB5gyiHIP0CHY+UK3uxzBQ4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dcdOPZf+UDKnOGFJ2Lk51KNw6wG/ra1B9f1aGNdSsuHQLd5C4Mbj2zbwveHBVOOAk3H46M0kOJoTlw5NcgP/DNU/WqFYIKCH6FzfelsWxjhs9qhPTsw7OD/8NZ76l2N61ZGAks78R8HOpKHZlnHlmrMQXtI8VNvmdp2P9RdI5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=none smtp.helo=mailgw.kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mailgw.kylinos.cn
X-UUID: c9830ade6e0911f1aa26b74ffac11d73-20260622
Message-ID:<1782119051683811.15050.seg@mailgw.kylinos.cn>
X-Spam-Fingerprint: 0
X-GW-Reason: 11109
X-Content-Feature:
	ica/max.line-size 130
	audit/email.address 1
	dict/adv 1
	dict/software 1
	meta/cnt.alert 1
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
X-CID-O-INFO: VERSION:1.3.12,REQID:bcbdda8e-1d67-4936-9879-da8c74dad94a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:bcbdda8e-1d67-4936-9879-da8c74dad94a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:d09ad6ce005592b90eef446c4c4c8719,BulkI
	D:260603180456RSCRRQPR,BulkQuantity:1,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c9830ade6e0911f1aa26b74ffac11d73-20260622
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 439748463; Mon, 22 Jun 2026 15:12:53 +0800
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
Subject: [PATCH v3 3/4] selftests/bpf: Enable kptr_xchg_inline test on LoongArch
Date: Mon, 22 Jun 2026 15:12:33 +0800
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260622071234.1410830-1-zhaochenguang@kylinos.cn>
References: <20260622071234.1410830-1-zhaochenguang@kylinos.cn>
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

