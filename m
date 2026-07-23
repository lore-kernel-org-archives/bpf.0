Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700BD33D6D7
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806869; cv=none; b=k94aatiChclWBxifr5SB9+TjYsOKR7EB8ypU3t41K06nXVxlgNy6WzvJG9n5Kl7rnmqdFrQgilhQrPneYAsSpYEGm0OZt0g5KTMCpNuW7+I8PREMofKSx1E6dDkCwgp46mwAoSGN8N6bhOQ/YIEHSJwcMbp7Cm8qBFAhgC42H3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806869; c=relaxed/simple;
	bh=lRW5c1FUOg7ZdMivKrIcDOJhkg1bACMBDJWpv+EvGo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9GWycu9m8hioewfI3TB75I05SVY9yKEBujMMiGLyZMydh0pl28xofeDl0qMVyESqq/OO1iNNFpEqT+e8E3LC/4eaxbKei8B3lDxL0yi/tcfCGf/sw1h6KZdRRKM4BWRJdKh9p6b/3LIHkZFAH0kLi/uTsrGpG7Cu8EKqn+AncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ETAZTWem; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ETAZTWem"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9BpdJ2505478;
	Thu, 23 Jul 2026 11:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1ljAUyPKYykWpdunReJQDq1rgIQnZPEtM3qFt9J3m
	qc=; b=ETAZTWemGgDuSnexMNsaI2vzXa2+VJG1hsJV7FptbMdHp7U7wbAWK02BW
	1fsXDOK76iR2P88Ow5ZSHzzZ8ITETshObAAoT6eCzwWthJQe3911czwxfYuSK58Q
	6JPVOKrMmLkKLSRkS3L2SQ8W13FevuvNz+I3DqyHYubEMwAyAwxjiAbLOePY5OWi
	FbyBfTtkI5ypSyfLuVbvsJmQMirqypGwudPT9vk8osWZHCEr5PGx2F2v8LZDNlnf
	kw8HO91RZ4fSc1a6AE6FriF5+h106GMTlX5nHHIQn4irEYrEmYEB2+0Ywjyw143u
	dwkEKW6DlUtKRmAzyZ8HBBmcN9icg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kepup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 11:40:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NBYbrp007807;
	Thu, 23 Jul 2026 11:40:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk3xeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 11:40:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NBeqcI20644600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 11:40:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F201858052;
	Thu, 23 Jul 2026 11:40:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFEC858045;
	Thu, 23 Jul 2026 11:40:49 +0000 (GMT)
Received: from thinkpad-p1.ehn-de.ibm.com (unknown [9.224.75.254])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 11:40:49 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix flaky refcount asserts in map_kptr_race
Date: Thu, 23 Jul 2026 13:40:25 +0200
Message-ID: <20260723114042.559926-2-max@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a61fdc6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=3fKn4_laJ8boR7l1sO4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDExMCBTYWx0ZWRfX8RALLAL7OxE2
 x7VwGTGHDH6uj6CveJtubAaDg6Tkc3xxv3G2fbKlwPpNY+MkYQgSdOTFVAJvr47QPK1/pwhbFgm
 LSi+feP87Pnkbm1XZf8TBtegbHCIGD3kQQRu5XLA+myn9x8DutBGgebOZ+VMU0U/E8daXirXJWL
 aIcnIxLpEaTJ7TwKnU3fkuZAQYY5U9GkopLMoQz9uO93vhxlK/FJSRiPROwdgTbwRW13XBCgHNU
 mTEDmCCC85GSHTvSSW7dyS21ialnpiXw+u+NzVzXixWuYXX529oZUYvMtsJ8tiJy3w2f3kw4i2U
 WaqaQXxjXNjWv7sFzyQxWP2AQ+UQe1QxBV16Tts5RI+oSzbihTl0+klyslAGpNwh8NIqp3HyfGm
 jvmUrhXy9IvPvcL7hrpMf+emcfkdxdIoAIAaUveu5QHQ5zxoymcthtzPi4Td9KdMFuJR5OoTKW7
 AmsAsJQ6esCiFXuf1uw==
X-Proofpoint-ORIG-GUID: lrUGbAbZT792bwxjXX8GXaAJW1qL2V8c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDExMCBTYWx0ZWRfXz4y4JNshyKAl
 mSFsNZCG0f20vCdyo3uXKtfnUPQNtPkjv2z9A+tkF4EEUZcI2F/6w/86zeHSJHFwq598X0Hj+a9
 TkfuvUisHHtrKN6HX+5TR+OJ5SblZQQ=
X-Proofpoint-GUID: lrUGbAbZT792bwxjXX8GXaAJW1qL2V8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230110

bpf_testmod shares objects across tests; prog_test_struct that holds
cnt.refs.counter is one of them. Refcounter release is deferred behind
an RCU grace period, so it may still be pending when this test asserts.
wait_for_refs prevents flaky failures when other tests have contaminated
the refcount.

Fixed tests:
 - test_htab_leak
 - test_percpu_htab_leak
 - test_sk_ls_leak

Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
---
 .../testing/selftests/bpf/prog_tests/map_kptr_race.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
index 506ed55e8528..5a543b3465a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
@@ -28,6 +28,15 @@ static int read_refs(struct map_kptr_race *skel)
 	return skel->bss->num_of_refs;
 }
 
+static void wait_for_refs(struct map_kptr_race *skel)
+{
+	for (int i = 0; i < 500; i++) {
+		if (read_refs(skel) == 2)
+			return;
+		usleep(10 * 1000);
+	}
+}
+
 static void test_htab_leak(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts,
@@ -73,6 +82,7 @@ static void test_htab_leak(void)
 		sched_yield();
 
 	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
+	wait_for_refs(watcher);
 	ASSERT_EQ(read_refs(watcher), 2, "htab refcount");
 
 out_watcher:
@@ -134,6 +144,7 @@ static void test_percpu_htab_leak(void)
 		sched_yield();
 
 	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
+	wait_for_refs(watcher);
 	ASSERT_EQ(read_refs(watcher), 2, "percpu_htab refcount");
 
 out_watcher:
@@ -195,6 +206,7 @@ static void test_sk_ls_leak(void)
 		sched_yield();
 
 	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
+	wait_for_refs(watcher);
 	ASSERT_EQ(read_refs(watcher), 2, "sk_ls refcount");
 
 out_watcher:
-- 
2.54.0

