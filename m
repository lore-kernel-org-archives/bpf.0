Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.148.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708355;
	b=EiX5VDHWhKUP+XZLfSlKjl3tKGg9U7SDxex2ArCDbyE/7NWFOagJ4yfPkVKU6KLnTFA0
	 3Vz4CkGns5CMCNfDaC9idQqsyHwCzGhZFlqjKl4oAZGZt9m+T4mwnYIoQ+KPTZhJuO6FA
	 CX0uYP4iG0Diw1tCnVvCl8Ldf10es2s8TjXnw6uuSkjZFuH5br/1gXqIiWVQ2MCTTyC8O
	 wVcSVumEjtMjrui2Cn8Gx6sS5Dm8UYoscp6AAMVsYL9pYHRf9CPTFQZdpx46fzQ5hyphE
	 JPOsYNvzKJPGBA5LwaEVIeMspWDE0PRBCHUEMEIkb1jM6yMZLF0WWFPrdlALsYL7Yyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708355;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NEeV9ZegWvY9vzjKDeCAoxGWkuaJKVNG78z3Nz2UL40=;
	b=WcNywPrvOGwGCX1KLtINPhLRSg41yDmJkic8EsyWw/StLehBL0pFk7Fi0UgA730DXUK8
	 p6dExMdHic/VQOhecLj+vk9kXTylAbE9BtjF2m13ZGcZp+uGPUod8Fk0DI27PhZI2w6UH
	 waMtDzDmszqvbff8qs94V90pF9z1WaJOIcH92nDIIohsbg4L5YcZ3wf+UU8/OeH177uUS
	 s4ofD2fRpDVrH8Kl5UVY61zuXJp7iART2AEzAPM07JJ7rQ4e9bX+Q5ePG2558yd2vFbbT
	 9ctsy8kz0S2InSv/dwNXseq3IFgImUV+ACk+NuPfniw2+hjSjj6KRBLa9av3U9FH7ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=eFt8CIGN;
	arc=none smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A55606A31D
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 22:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A55606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=eFt8CIGN
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MHMLZD796650;
	Thu, 22 Oct 2026 22:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=NEeV9ZegWvY9vzjKDeCAoxGWkuaJKVNG78z3Nz2UL40=; b=eFt8
	CIGNEUQJPu0ZCs8ifHOcijjL+zcsvX3naitKJ4upqEr/5Wkij8Eaf6ExxRjNAg/f
	9iqW2sQvpb0FHJ6R7PpeCODRzhlwGJJztqh+4VUOBLA/7nVv2oUhUVP08nbn2zHI
	CQL0Hxe8ie4Diz5V7XP1YN0f4OLtNTaQgXQemvczleT/nHzfvl+qVwRWi0syXA/i
	90M3mZfxqhEVj0pltrca7o6tdfQLLB2nLviZeyR91jJrKZH8P29/XsHgNOBn2AjV
	it1Nokj7yXZM+W8FCp8zfFtw+nP3CN35yS+VbobhUcu5v4qhBQJ4wYpvblZxPmue
	JTVxFYaX1dxiO/cS6g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hf97jmr3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 22:32:20 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 22 Oct 2026 22:32:18 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v7 5/7] selftests/bpf: Cover BPF program load strategy transitions
Date: Thu, 22 Oct 2026 18:32:10 -0400
Message-ID: <20261022223212.1217849-6-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022223212.1217849-1-andrey.grodzovsky@crowdstrike.com>
References: <20261022223212.1217849-1-andrey.grodzovsky@crowdstrike.com>
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
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH015.crowdstrike.sys (10.100.11.67) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfXzqnPl96qudD4
 uVSIieLwuTM8s7/jqhc+EHkyijMW0v57vRdmEwCvwOCeIBUr0ulJ0My1vmj5s56DP12GENhRFOD
 KVE+Od68xXFm8kaHLvYvlf9oICpWoSrDzxOdah6vFQAuyHHGf01S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfX7dmjghCd0nc+
 IBEQw7JUJvDlSR8IEHuMhoZAKTP/T95uZMfnptuU96IdZ6Z4EzzrKSfpdVLaFc86xHqZTQTYYdf
 a7UXuIL+oSY6MmghevHNx5NoSwLC6LvcRQED0XxhWHDq3imM+ZWWoP0jAJA50Lj5bmA+NB8zEn5
 HPHZb7D1CldGth4coPbhMFn3LyHRVIA5uG9CK1IE/G12sAkAMPlRYQEEK/S96akLEU8kgPeanDw
 rv3b/v9ZtS4hwBXoasmGSycI+04bdbibDeNIPV4hDFz2Sn9wsHQddNC96u4v5JPJKzCpKvQybxY
 XvdN51wd7ad/Yha4ux1yWEfw6n+TLvpnMl9bUqUl2riX5wLke+IBsvZFw5tvM66c33fHxhPtqtC
 UhqCI/IgdvsibMS9fzXQmDZjXZU4eQq5OhlW0yvbi6TrmFS5xH+SX8Muwv971A9H/e11egS2Ipp
 x9fPcrfBAkvZmGKOcwQ==
X-Proofpoint-GUID: HqG4pDwgDfWuk19y5RoPbfim692qdYBn
X-Proofpoint-ORIG-GUID: HqG4pDwgDfWuk19y5RoPbfim692qdYBn
X-Authority-Analysis: v=2.4 cv=EYFd0/mC c=1 sm=1 tr=0 ts=6ada8ef4 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=pl6vuDidAAAA:8
 a=zLuxJhxpLnNjXD2GACUA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11943
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220089

From: Slava Imameev <slava.imameev@crowdstrike.com>

Add load_type test covering load strategy transitions
(DISABLED/AUTO/MANUAL), set_autoload() bool/enum compatibility
and the manual load/attach cycle after the object is loaded.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/load_type.c      | 154 ++++++++++++++++++
 .../selftests/bpf/progs/test_load_type.c      |  31 ++++
 2 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c

diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/testing/selftests/bpf/prog_tests/load_type.c
new file mode 100644
index 000000000000..7e344c0b0445
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_load_type.skel.h"
+
+void test_load_type(void)
+{
+	struct bpf_link *link = NULL;
+	struct test_load_type *skel;
+	int err;
+
+	skel = test_load_type__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	/* don't load prog1 */
+	err = bpf_program__set_load_strategy(skel->progs.prog1, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	if (!ASSERT_OK(err, "set_load_strategy_disabled_prog1"))
+		goto cleanup;
+
+	/* load and attach prog2 */
+	err = bpf_program__set_load_strategy(skel->progs.prog2, BPF_PROG_LOAD_STRATEGY_AUTO);
+	if (!ASSERT_OK(err, "set_load_strategy_auto_prog2"))
+		goto cleanup;
+	if (!ASSERT_TRUE(bpf_program__autoload(skel->progs.prog2), "prog2_autoload"))
+		goto cleanup;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual"))
+		goto cleanup;
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_MANUAL,
+		       "prog3_load_strategy"))
+		goto cleanup;
+
+	/*
+	 * bpf_program__set_autoload() is a thin forwarder to
+	 * set_load_strategy(), restricted to AUTO/DISABLED to preserve its
+	 * original bool on/off meaning;
+	 */
+	err = bpf_program__set_autoload(skel->progs.prog3, false);
+	if (!ASSERT_OK(err, "set_autoload_false"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3),
+		       BPF_PROG_LOAD_STRATEGY_DISABLED, "prog3_load_strategy_after_false"))
+		goto cleanup;
+
+	err = bpf_program__set_autoload(skel->progs.prog3, true);
+	if (!ASSERT_OK(err, "set_autoload_true"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_AUTO,
+		       "prog3_load_strategy_after_true"))
+		goto cleanup;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual_enum"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_MANUAL,
+		       "prog3_load_strategy_after_manual_enum"))
+		goto cleanup;
+
+	/* changing the load strategy leaves autoattach alone */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_AUTO);
+	if (!ASSERT_OK(err, "set_load_strategy_auto"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_AUTO,
+		       "prog3_load_strategy_auto"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(bpf_program__autoattach(skel->progs.prog3), "prog3_autoattach_default"))
+		goto cleanup;
+
+	bpf_program__set_autoattach(skel->progs.prog3, false);
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual_again"))
+		goto cleanup;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_AUTO);
+	if (!ASSERT_OK(err, "set_load_strategy_auto_again"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(bpf_program__autoattach(skel->progs.prog3), "prog3_autoattach_kept"))
+		goto cleanup;
+
+	/* restore autoattach to true for the rest of the test */
+	bpf_program__set_autoattach(skel->progs.prog3, true);
+
+	/* an out-of-range load strategy is rejected */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, (enum bpf_prog_load_strategy)999);
+	if (!ASSERT_EQ(err, -EINVAL, "set_load_strategy_invalid"))
+		goto cleanup;
+
+	/* change the strategy back to BPF_PROG_LOAD_STRATEGY_MANUAL for the rest of the test */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual_final"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_MANUAL,
+		       "prog3_load_strategy_final"))
+		goto cleanup;
+
+	/* Test post loaded behaviors */
+	err = test_load_type__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	/* Post load we cannot update a program's strategy */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	ASSERT_EQ(err, -EINVAL, "set_load_strategy_after_load");
+
+	err = test_load_type__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	usleep(1);
+
+	/* Post load only AUTOLOAD program is expected to run */
+	ASSERT_FALSE(skel->bss->prog1_called, "prog1_called");
+	ASSERT_TRUE(skel->bss->prog2_called, "prog2_called");
+	ASSERT_FALSE(skel->bss->prog3_called, "prog3_called");
+
+	err = bpf_program__load(skel->progs.prog3);
+	if (!ASSERT_OK(err, "load_manually"))
+		goto cleanup;
+
+	/* attach prog3 */
+	link = bpf_program__attach(skel->progs.prog3);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		goto cleanup;
+
+	usleep(1);
+
+	/* Post explicit load and attach, MANUAL program is also expected to run */
+	if (!ASSERT_TRUE(skel->bss->prog3_called, "prog3_called_again"))
+		goto cleanup;
+
+	/*
+	 * detach prog3 explicitly: its link is kept in a local variable, not in
+	 * skel->links, so test_load_type__destroy() has nothing to detach
+	 */
+	err = bpf_link__destroy(link);
+	ASSERT_OK(err, "link_destroy");
+	link = NULL;
+
+cleanup:
+	if (link)
+		bpf_link__destroy(link);
+	test_load_type__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_load_type.c b/tools/testing/selftests/bpf/progs/test_load_type.c
new file mode 100644
index 000000000000..3d9b81691d7a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_load_type.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+bool prog1_called = false;
+bool prog2_called = false;
+bool prog3_called = false;
+
+SEC("raw_tp/sys_enter")
+int prog1(const void *ctx)
+{
+	prog1_called = true;
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+int prog2(const void *ctx)
+{
+	prog2_called = true;
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+int prog3(const void *ctx)
+{
+	prog3_called = true;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

