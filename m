Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249E3921C1;
	Thu, 16 Jul 2026 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185905; cv=none; b=jdyI88wpb3Qu6649QTZrONAnN7RWe60U5Mm+nFDR2QAQYJ6Hh5Xisw7u1lrxIf+VH46y01Fcq00gCSLt5JbjHHBu+Y3p/Jtz3vzbhvOOK9DbUted7DU8p9dsOtjgHaYCzNYx3prDfLP5k0a8vbEj327jJX5aAhbEktPgVuRmhkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185905; c=relaxed/simple;
	bh=aS2bF7JXIvXAdqO20F+cjGFoz/Y6EroxP/9mvB7AHe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S8nuL2GHyHXkk04OP+YiA9mRFNHD7g4MHbULtVCSQtHyG0p/+7dCheEQzDJU44h2e5iRVv+VQI9RRZCn+HoCdFA0+PmYf+F08EQDDCbqkn1bjHBzHk6YcQwQlGw+Vy1Vgjvj20ge+ctNu5L4rzaUpWGUeeNKtlywq2pyy/hKbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 930e891c80e511f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:81d341cf-fd8f-4195-a676-1b9fe840c9fc,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:4baa61b44576ff9aae434c065c0f6f05,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 930e891c80e511f1aa26b74ffac11d73-20260716
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 45499455; Thu, 16 Jul 2026 15:11:32 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev
Cc: longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] libarena/selftests: use ARRAY_SIZE macro in st_asan_buddy.bpf.c
Date: Thu, 16 Jul 2026 15:11:10 +0800
Message-ID: <20260716071110.560-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARRAY_SIZE macro is more compact and more formal in linux source.

Fixes: b1487dc1b181 ("selftests/bpf: Add selftests for libarena buddy allocator")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 .../selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
index 3266a28f53d7..9c94a5167a50 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
@@ -163,7 +163,7 @@ __weak int asan_test_buddy_oob(void)
 		return ret;
 	}
 
-	for (i = zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++) {
+	for (i = zero; i < ARRAY_SIZE(sizes) && can_loop; i++) {
 		barrier_var(i);
 		ret = asan_test_buddy_oob_single(sizes[i]);
 		if (ret) {
@@ -201,7 +201,7 @@ __weak int asan_test_buddy_uaf(void)
 		return ret;
 	}
 
-	for (i = zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++) {
+	for (i = zero; i < ARRAY_SIZE(sizes) && can_loop; i++) {
 		barrier_var(i);
 		ret = asan_test_buddy_uaf_single(sizes[i]);
 		if (ret) {
-- 
2.43.0

