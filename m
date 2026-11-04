Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=104.207.68.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817242;
	b=JE55RTJ1DEAB+hJkmlr658eHZNKN0mN21iTU5hMmHqB6xii5Z6qHJsyV9vrvp+DsDcfB
	 gYJKsbk5J4moegbsM+mUUDaVWznI6PADbN4z7S94m9MyPy1v/GFOQmod/MvAic262QOI4
	 rJi8igwdPIoq8kzV4mkQqC8zU+zDbcZT7TOVrPHbjRujPn/uiqyPRBxzzhnqDctEKixBO
	 71i4ZLnerFaJxlDj+WymS3TFPSum66Mkpv+DhJk9IrjlaeXY8rHk92frPJpdoTmR/Jvom
	 sGIWg20arpGME9iRbmzD75y+jukybLx6yLimv+N0f7kqZRttJLV58GATZTdX/k1VffA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817242;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Envelope-From;
	bh=Xgai1G4OTIWdkpPHAVPKrNN9CkdFO7yMfOuATYz1nZA=;
	b=eSeTN6f6Y+UbhN3hkEIbQyTDvSHvB8MXOgf7jdNLHu3LWctQbXIlcD8HpvOldzPrRXdC
	 +iNJHEkQNb3WnvSYsnED9z0maOCHpmIjl3kW4BuOLGgoS72LDRRYXUmfyZtSXPd1YX94N
	 j8lQ1Xe+MMbymSxpZLudbXLgcQw7E1VnGtQ182SlwODdT2s6SuYYf+U+0ayC8jCfayFmh
	 6RDBwj+7rlnB3L1ALdWuCLlhfBc9VNHE3R+wPOagZvzbZfp2bFKo7mBGG3COejMR2IOSC
	 DXsVW0zB2n3kRlc9XetyhRdNHacWXMWuOEQftw4K4X/qRWQEFnrGmyqPZvROhrfvNdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=c2x6iZxD;
	arc=none smtp.remote-ip=104.207.68.39
Received: from out-93wp-a39.jellyfish.systems (out-93wp-a39.jellyfish.systems [104.207.68.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AAD606A32E
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 18:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96AAD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=c2x6iZxD
Received: from fedora (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jKYwr53Znz2x9C;
	Wed, 04 Nov 2026 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793817215;
	bh=Xgai1G4OTIWdkpPHAVPKrNN9CkdFO7yMfOuATYz1nZA=;
	h=From:To:Cc:Subject:Date:From;
	b=c2x6iZxDJCJcOpuC2yxPuxPaa9ztC6rOJxy9VJ6+nToD8PHfv+HyslfB+oaU/9gOv
	 qSylU4EajjvgYer3gQT8R7Ika4DMeWFtfL5f5dFbtgQ4ku7WLGrlljfE/Hp+YMStuu
	 yoCFZUMDsC2ayfZ8SPFiD1oTiRADlge6Ven7VssueOUmOs+oJQwAiD5qYikGBhHSbD
	 TCDWsbDgjvRht1cvd22EZCmMaAXiS945etQ7EL0M4hp+Wb2egrBKhLjNJ19+SAXY0G
	 j8tdSio0ReXL3c0qho6UuWOTrZ+q1TXMYxad1qYkHDrD76gMy4J4/dDIiRAarps/QF
	 cNdoChBRg1twQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf] selftests/bpf: Look up unpinned maps by ID in bpftool_maps_access
Date: Thu,  5 Nov 2026 03:33:23 +0900
Message-ID: <20261104183323.409412-1-hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

The unpinned subtests pass "name prot_map" or "name not_prot_map" to
bpftool. Both maps are used by programs attached through trampolines,
which are freed only after RCU grace periods and hold their map
references until then. A run's maps therefore stay in the map ID table
after its skeleton is destroyed, for about 300 ms in an x86-64 VM.

If the test runs again within that window, the name matches maps from
both runs, bpftool fails with "several maps match this handle", and
the unpinned subtests fail.

Look up these maps by ID instead and drop the now unused map names.

Fixes: 2d96bbdfd3b5 ("selftests/bpf: convert test_bpftool_map_access.sh into test_progs framework")
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
Tested in an x86-64 VM with unmodified bpftool. Back-to-back runs of
this test fail before the fix; with the fix, all six subtests pass in
ten consecutive runs, including ID lookups while stale same-name maps
are still present.

 .../bpf/prog_tests/bpftool_maps_access.c      | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_maps_access.c b/tools/testing/selftests/bpf/prog_tests/bpftool_maps_access.c
index e0eb869cb1b47..5763cb19236a6 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_maps_access.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_maps_access.c
@@ -13,8 +13,6 @@
 #include <bpf/bpf.h>
 #include "security_bpf_map.skel.h"
 
-#define PROTECTED_MAP_NAME	"prot_map"
-#define UNPROTECTED_MAP_NAME	"not_prot_map"
 #define BPF_ITER_FILE		"bpf_iter_map_elem.bpf.o"
 #define BPFFS_PIN_DIR		"/sys/fs/bpf/test_bpftool_map"
 #define INNER_MAP_NAME		"inner_map_tt"
@@ -32,7 +30,6 @@ struct test_desc {
 	char *name;
 	enum map_protection protection;
 	struct bpf_map *map;
-	char *map_name;
 	bool pinned;
 	char pin_path[PATH_MAX_LEN];
 	bool write_must_fail;
@@ -93,13 +90,10 @@ static void update_test_desc(struct security_bpf_map *skel,
 	/* Now that the skeleton is loaded, update all missing fields to
 	 * have the subtest properly configured
 	 */
-	if (test->protection == PROTECTED) {
+	if (test->protection == PROTECTED)
 		test->map = skel->maps.prot_map;
-		test->map_name = PROTECTED_MAP_NAME;
-	} else {
+	else
 		test->map = skel->maps.not_prot_map;
-		test->map_name = UNPROTECTED_MAP_NAME;
-	}
 }
 
 static int test_setup(struct security_bpf_map *skel, struct test_desc *desc)
@@ -253,16 +247,25 @@ static int add_outer_map_entry(int key)
 
 static void test_basic_access(struct test_desc *desc)
 {
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
 	char map_handle[MAP_NAME_MAX_LEN];
 	char iter_pin_path[PATH_MAX_LEN];
 	int ret;
 
-	if (desc->pinned)
+	if (desc->pinned) {
 		ret = snprintf(map_handle, MAP_NAME_MAX_LEN, "pinned %s",
 			       desc->pin_path);
-	else
-		ret = snprintf(map_handle, MAP_NAME_MAX_LEN, "name %s",
-			       desc->map_name);
+	} else {
+		/*
+		 * Maps from an earlier run stay visible until its trampoline
+		 * programs are freed, so a name can match more than one map.
+		 */
+		ret = bpf_map_get_info_by_fd(bpf_map__fd(desc->map), &info, &len);
+		if (!ASSERT_OK(ret, "get map info"))
+			return;
+		ret = snprintf(map_handle, MAP_NAME_MAX_LEN, "id %u", info.id);
+	}
 	if (!ASSERT_GT(ret, 0, "format map handle"))
 		return;
 
@@ -312,28 +315,24 @@ static struct test_desc tests[] = {
 	{
 		.name = "unprotected_unpinned",
 		.protection = UNPROTECTED,
-		.map_name = UNPROTECTED_MAP_NAME,
 		.pinned = false,
 		.write_must_fail = false,
 	},
 	{
 		.name = "unprotected_pinned",
 		.protection = UNPROTECTED,
-		.map_name = UNPROTECTED_MAP_NAME,
 		.pinned = true,
 		.write_must_fail = false,
 	},
 	{
 		.name = "protected_unpinned",
 		.protection = PROTECTED,
-		.map_name = UNPROTECTED_MAP_NAME,
 		.pinned = false,
 		.write_must_fail = true,
 	},
 	{
 		.name = "protected_pinned",
 		.protection = PROTECTED,
-		.map_name = UNPROTECTED_MAP_NAME,
 		.pinned = true,
 		.write_must_fail = true,
 	}

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.56.0

