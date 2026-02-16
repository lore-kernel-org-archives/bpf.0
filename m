Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C63016EE
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239208; cv=none; b=bYP4Y6Z6r2tgpWMTxscikyUh4bq/A3KZLFOKEU64ip1RVRGdDzclDfjcpKKgTBi8fx9PIZuzI8/Ta1uFwp6fwEqkedy+8fCWFkDSRYIcjIcz5T6PRvKYTaMLnjCGwz8Djj9r1XTwG0pY7soWARGkZ5RVNdriICbp91nT5gOVTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239208; c=relaxed/simple;
	bh=Ht+KqubKflb/px2yY9QU8LZYZn3miQJrXYVXG9Muw/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLwZktv4iCkBM6BS1OTlzd1A/UJe38Vx+DPPSW8gb+eQJ3Z+rU2wI3wiGToXD8gpOkZrcYHPTOBSBL6PnG1RE3Oi/yVdGv97B9L84Hiime+qGp0kTTF4rtaXeHx4bV91n5AgR/kPX9QmVU6t97rueSXf15RSiVUoExJqG5enWks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MnLZPRqD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MnLZPRqD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FM1J5G3669128;
	Mon, 16 Feb 2026 10:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XKAe0UdH4VvYka3ce
	gfu01NSGhxdoMyut4g2Su5xT9s=; b=MnLZPRqDWVPfyibT+uwAEBWUzOS7S1xKw
	io+TbwUZlyAQfgYhOU2syis6+ANyTg4qu+8db6W4IKrfaxXgT6iZfjzZDTT1tV+T
	RCeAcqah360ggy93Uw3tnfgHwGGnVwcF6tJseAXupntO0nxygiCYl266cyJe036B
	Bln5ZhsQEIVWT/Nxqnq0P3krOOPloerfdWxO9IU50NGopLMUGu77g7Wm2+HlENbV
	XXoeZj+NjDmHls1tKEUR2I2FvimHm13q9/6rJtRmOflf6RJ7BPoxnCB47bNit57O
	+cexBMSEgbRfrPRVG1qurnNWBIk896bABD3SDntnhC0MlcRwbmdvg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj6tnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:53:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G8ehZS029078;
	Mon, 16 Feb 2026 10:52:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb6314s4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:52:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GAquJu54395200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 10:52:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5CE32004B;
	Mon, 16 Feb 2026 10:52:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BAD720043;
	Mon, 16 Feb 2026 10:52:53 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 10:52:53 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
        ihor.solodrai@linux.dev, chleroy@kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 2/3] selftest/bpf: Enable get_func_args and get_func_ip tests on powerpc64
Date: Mon, 16 Feb 2026 10:53:09 -0500
Message-ID: <20260216155310.38457-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216155310.38457-1-adubey@linux.ibm.com>
References: <20260216155310.38457-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FFv_YSACmUjl7w-XBH3SiS-oniKgljEB
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6992f70c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=DqXwyqWM9aSI_JVwGXwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA5MCBTYWx0ZWRfX0LiVAHaFcwZM
 qqOzTL5L0jKYXwGc3BJoW6pf65y6JgouqRW7rxVllR70sw1R+K0pyLP0WmpWArmeP9iFF3eID+4
 RugzfE7/vxdAWU9ozci3zPLdhM9EvInq+s0jhGTq4ia9blQUrsQSAmi8Lb8U1QivTr/QFnO7aEM
 BQ4ttLaZsK+sNhBpDL9Nec5mYKudZAO6weQq5HMfhK4P//yIz6yRQJVYw+mQ4zQgaTX8B1yDk1g
 KnWpsoQzBTvo0Ju3lJIFHObLMmEeLSXJWwlPdGw38W6evXe/vzc7LJlqemVf7CjhLaxz2OzuiuF
 hh3q2OqMVORGjsFL3plhkxQ9Dy6Eb54va4TdN66EgUAvWMw6MJJKXb+HOjfk/uCflWf52mfSGAe
 piWaTQGb6Vx7MQ+THPI3nlD4JQKn6cEyuT9CDSLenpPJhpWrhDwMdlEDzeZLTJ9DL4peKsHrtrF
 FVIes3yGEGSBV3UtnXg==
X-Proofpoint-GUID: l6LAAxqDsgQDuBuDyPk6V2EOYmOiGqj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160090

From: Abhishek Dubey <adubey@linux.ibm.com>

Allow get_func_args, and get_func_ip fsession selftests to run on powerpc64.

# ./test_progs -t fsession
#135/1   fsession_test/fsession_test:OK
#135/2   fsession_test/fsession_reattach:OK
#135/3   fsession_test/fsession_cookie:OK
#135     fsession_test:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

# ./test_progs -t get_func
#138     get_func_args_test:OK
#139     get_func_ip_test:OK
Summary: 2/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/get_func_args_test.c | 2 +-
 tools/testing/selftests/bpf/progs/get_func_ip_test.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 180ba5098ca1..5579141ea45e 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -167,7 +167,7 @@ int BPF_PROG(tp_test2)
 }
 
 __u64 test7_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64)
+#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_powerpc64)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test7)
 {
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 43ff836a8ed8..2558dda4d82c 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -106,7 +106,7 @@ int BPF_URETPROBE(test8, int ret)
 
 __u64 test9_entry_result = 0;
 __u64 test9_exit_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64)
+#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_powerpc64)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test9, int a)
 {
-- 
2.52.0

