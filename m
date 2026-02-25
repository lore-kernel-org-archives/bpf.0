Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F8392C4E
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016003; cv=none; b=PaVg2i5NOLnBiHncx74ScETLnkoWrYcNBe5hH/v7cFvvw4FwA+cQoD+EXXD566mhjlOCLcigWKpEAPxS2+Bl4e6Hd6ZO2mku7PgW4iGiMnCOQCnlbN0Zknm20homPT7tW6cMc/A4VF5aeHntt1mhy/pHYKZpkHyuNcaNFC8Hvg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016003; c=relaxed/simple;
	bh=i02zKRwEFzS2GoNNvjIM96LN+Mz4mKgI6VqBmHMuSKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvjVeFKx6Oy2BrPe3dTynT7pLH2QNNd7W5StzGnPYa9EykNpQBj+2QaOyGJg0JyP6i+dT5ifSzL/3bnBKHbTPJlWN3Qutg+l8ZDgwUWpuXbE/AFNcFLrNzgxzzBWTA/FUvt0brTgwGpw9nlRAjkxlCuDF0rXohcE5/4EktZxpoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EQeZDU2l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EQeZDU2l"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIfMf92461030;
	Wed, 25 Feb 2026 10:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sL11sx23Rcy5IgZ8B
	9tWiGZp8lNaf1EwggY4I08LQUE=; b=EQeZDU2lzepoFDMBXLJR7Xj/Wag++ZZ0D
	+fp8War+AQl4lwwUNzEE9z2GmhVX6fqk8STybj0YcLP0uaThf0lQCmpOPRmea1mq
	J3FABFZg3xbD3k1hO2S2PA+CvLted51VetVaPRnQm8yi9BfdjHV5XsxxlKZ2qAG4
	WG5+Lg0/Ouw6EDhj+dfFIq7P8NpPvKoCfkSFA4rZhN1oQ7jBt2wqLi67qARVqK9n
	QqUWSEFMEHU9gtOJc6Lt9o5mmytCJ5HYxO/kYfSQFeREYHMQ1K8UTbkCfdxZ7yNz
	/YFVR7PK0TRLimXCPDFUEB6Sx0jmUyxr7oKIRDgDQxxnaidp32BZQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c73ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 10:39:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61P8eqqI030385;
	Wed, 25 Feb 2026 10:39:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhkcuvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 10:39:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PAdeV330474614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 10:39:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96B0A2004D;
	Wed, 25 Feb 2026 10:39:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1668A20043;
	Wed, 25 Feb 2026 10:39:39 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 10:39:38 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v2 2/2] selftests/bpf: Enable private stack tests for powerpc64
Date: Wed, 25 Feb 2026 10:39:50 -0500
Message-ID: <20260225153950.15331-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225153950.15331-1-adubey@linux.ibm.com>
References: <20260225153950.15331-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEwNCBTYWx0ZWRfXxR83Y1wvvITm
 0hPGeZ+1ESt36/n022OZrBuNgv74hI/nLW/lnOtaFC+in+HpWgxpG0qM1i3ZA23Zaez3T0YS2X8
 ZFProcHL3dwKRbEefeFi/JG5Wq6dvCMNWeiP3GW9llGM9iMvl3KDwXIftwXGVlmtxI0HZJBBIzI
 cerr5jSZw/fyN6TgLR1Rjj2cTCBW7gyEZk3Act3x+Csk2V68FxVbX+pCBf+Kg7kfKCI7fYS0xgq
 V+DEUD8/om/KEQezm+SR0rVKp4qNIpEdzXO+ZIQb3GXmnUkw9fF3UaXmCbmmMmJ9P5FwMlPsppc
 o+pd9pS6M0qjyHlkrDXqolYDDbHGs5Db3EbMqQrgN01ED0s3WyflsVpNS/JRmrAV0wlcPO14Qam
 NXDkclYqCWsZzXs6xgGSoFnPoXYOlcYIl9kupyDJWb6QXDVIoXA8fO9Qh3+EdC1wbSBj3fNyTpM
 l+C3yCUSBHjVfQDbabQ==
X-Proofpoint-ORIG-GUID: nYQJL7GUvBs5ndoM5BjXt5AP51Nean3q
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699ed171 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=EpsnbLDfARfeqce_9zcA:9
X-Proofpoint-GUID: nYQJL7GUvBs5ndoM5BjXt5AP51Nean3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250104

From: Abhishek Dubey <adubey@linux.ibm.com>

With support of private stack, relevant tests must pass
on powerpc64.

#./test_progs -t struct_ops_private_stack
#434/1   struct_ops_private_stack/private_stack:OK
#434/2   struct_ops_private_stack/private_stack_fail:OK
#434/3   struct_ops_private_stack/private_stack_recur:OK
#434     struct_ops_private_stack:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/struct_ops_private_stack.c   | 3 ++-
 .../selftests/bpf/progs/struct_ops_private_stack_fail.c        | 3 ++-
 .../selftests/bpf/progs/struct_ops_private_stack_recur.c       | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
index dbe646013811..1df1111cd029 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
@@ -7,7 +7,8 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
+				|| defined(__TARGET_ARCH_powerpc)
 bool skip __attribute((__section__(".data"))) = false;
 #else
 bool skip = true;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
index 3d89ad7cbe2a..e09c1a8782b4 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
@@ -7,7 +7,8 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
+				|| defined(__TARGET_ARCH_powerpc)
 bool skip __attribute((__section__(".data"))) = false;
 #else
 bool skip = true;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
index b1f6d7e5a8e5..791800835673 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
@@ -7,7 +7,8 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
+				|| defined(__TARGET_ARCH_powerpc)
 bool skip __attribute((__section__(".data"))) = false;
 #else
 bool skip = true;
-- 
2.52.0

