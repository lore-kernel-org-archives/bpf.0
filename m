Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144E3AEB2B;
	Fri, 17 Jul 2026 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270867; cv=none; b=hDIncYXjjKJiQlcUoOyw5TKik2jYytl67a5S0KsdtGqIvaKljtsX/vlwXerlXJXiinaxXVMIFPsrw3Q/8opjNes0fqfaKXRgLIjj5Nw0hzjBXEbPg35RM8CC9qJwv30GbhFFF2gFT0M214it9jhCLgqEWBl58GbHc+TESMRJEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270867; c=relaxed/simple;
	bh=fOFQhIeYpSGz1gdjOadiq9kqiR9t1kkS9wVHQJoeIn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aanCoFzIis1R95jmg5/kY/4IWVWDho1lTgIAiJA5jNV4SJ8KL+NUfKLF1u3jcRnreH28dbFFhQ51nllI5btSAJ1ipAK56b/ssm9a/7af+08BDPIYaROgUw/xl6CShc0HP1eigeAcxIYbm7SLATPsbhm+YyIg+2bd7tv8lN/vvLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6462ab3681ab11f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:71484f9b-9529-477f-82e7-f8def91eaa32,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:58a5985be35c12dda518903384f02405,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6462ab3681ab11f1aa26b74ffac11d73-20260717
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1220787653; Fri, 17 Jul 2026 14:47:34 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] libarena: use ARRAY_SIZE macro in test_rbtree.bpf.c
Date: Fri, 17 Jul 2026 14:47:19 +0800
Message-ID: <20260717064719.1032-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARRAY_SIZE macro is more compact and more formal in linux source.

Fixes: 6c3e8a4d4765 ("selftests/bpf: libarena: Add rbtree data structure")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 .../selftests/bpf/libarena/selftests/test_rbtree.bpf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
index 856c484a009a..f6e15f77cdf5 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
@@ -275,7 +275,7 @@ clean_up_noalloc_tree(struct rbtree __arena *rbtree)
 
 int insert_many(enum rbtree_alloc alloc, enum rbtree_insert_mode insert)
 {
-	const size_t numkeys = sizeof(keys) / sizeof(keys[0]);
+	const size_t numkeys = ARRAY_SIZE(keys);
 	node_ctx nodec;
 	u64 key, value;
 	int ret;
@@ -373,7 +373,7 @@ __weak int test_rbtree_remove_one(void)
 
 static __always_inline int remove_many_verify_all_present(struct rbtree __arena *rbtree)
 {
-	const size_t numkeys = sizeof(morekeys) / sizeof(morekeys[0]);
+	const size_t numkeys = ARRAY_SIZE(morekeys);
 	u64 value;
 	int ret;
 	int i;
@@ -394,7 +394,7 @@ static __always_inline int remove_many_verify_all_present(struct rbtree __arena
 
 static __always_inline int remove_many_verify_remaining(struct rbtree __arena *rbtree)
 {
-	const size_t numkeys = sizeof(morekeys) / sizeof(morekeys[0]);
+	const size_t numkeys = ARRAY_SIZE(morekeys);
 	u64 value;
 	int ret;
 	int i;
@@ -434,7 +434,7 @@ static __always_inline int remove_many_verify_remaining(struct rbtree __arena *r
 
 static __noinline int remove_many_alloc(struct rbtree __arena *rbtree)
 {
-	const size_t numkeys = sizeof(morekeys) / sizeof(morekeys[0]);
+	const size_t numkeys = ARRAY_SIZE(morekeys);
 	u64 value;
 	int ret;
 	int i;
@@ -482,7 +482,7 @@ static __noinline int remove_many_alloc(struct rbtree __arena *rbtree)
 
 static __noinline int remove_many_noalloc(struct rbtree __arena *rbtree)
 {
-	const size_t numkeys = sizeof(morekeys) / sizeof(morekeys[0]);
+	const size_t numkeys = ARRAY_SIZE(morekeys);
 	node_ctx first = NULL, last = NULL;
 	u64 value;
 	int ret;
-- 
2.43.0

