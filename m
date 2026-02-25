Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66098330646
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771965401; cv=none; b=Kn2xbhTLMqKIU7Lt2BlrB7Nw9VT+d+iC2d18xJPknpcDIwA5ZUpsuRCxP6IXoOZQubSNIB49uwkDxkOcU9SL6Dr/dygeMH/SrDlFL5U3nvMzoxtvkwBpC+SNUSMr+sz7ccGzhNYQKaxYBHO7Q7HzBauw6J0WgGQXawE4YaMYt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771965401; c=relaxed/simple;
	bh=7c5AA2Yup/45KAKktxiiuE8bDS1sAavBaEVzZxm/LI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agchQoxo9dndtAEgRcoQuwIbgZOX/vhV3FgxncPvMY1f+4OTlsgtqXt2VoeE9VhX/hD3gEhFE8Q5EsaCCricmPLF3P02/+w90tcDno0RzSM120nsAKaWFSmeEeGjLzNbPN/jJJ33lF3SWD/E2vRjn9Fm0pEY4FOHVInBvt7iE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c2eG/gnf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c2eG/gnf"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O9mmER2866998;
	Tue, 24 Feb 2026 20:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B1/Neq2m/CTKiuUiX
	s1KrqxKRjM7xfwfRTx73tLTlgE=; b=c2eG/gnf248ADggHvIPTktNUWKbZzxJAL
	ctuborFtdez2qgXnaPeSKB8qYsau7fqApLZznTqvBrQ5VHEX7dpQhpaTcRibPG6S
	rWEZoVkkDlnbWGNJnyxIiUHfO+EPidzZgxWTmi94M7Yj1WWO4VPNG9UEqFSUACP2
	Ld4nnd6R+kviIE7bbNlc+3rNnyo0QoKBU44eDsg/Yhm2Oj3ONxIlbRA2UCJP2Zye
	Z7eXcJFWBs4aTYx8VtMLhTX0iX1vkbiN1uJPTlpHts5MbWJfede8mbGgb0RBouj3
	vUf17rAdobZgklHQsapklKk6KtwrMuM80UYQovicVojAax+dgjZmg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4brvt1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:36:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OHD2fM001674;
	Tue, 24 Feb 2026 20:36:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1n2j6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:36:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61OKaK5k23593372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 20:36:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 009C820040;
	Tue, 24 Feb 2026 20:36:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7544C20043;
	Tue, 24 Feb 2026 20:36:18 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Feb 2026 20:36:18 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 3/4] selftest/bpf: Enable verifier selftest for powerpc64
Date: Tue, 24 Feb 2026 20:36:26 -0500
Message-ID: <20260225013627.22098-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225013627.22098-1-adubey@linux.ibm.com>
References: <20260225013627.22098-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tmAUYl38FaJWd43P8bIuEn23_54T1yw-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE3MyBTYWx0ZWRfX4S7HZECsin7I
 WV3RU4WsHjQ8nUTiBCr8vQKMz/ml/5QStGRICppxCKRBcYip8t9aC3wnzI2g65aTwuZrag0l1OI
 d6S9PWUffrDm0auCMvmfeQnF7XAbQOyK8Ftori8ZI8DDrV2esnW1Ov7ZwSsXcmnqdSkzBZIIEMw
 iChkui7NAFv4aFKW0N4O30A7L4VPxaQKOT7FcmpbXpLhgBPkYL/bj1SA4Ibq9905Vs6VPIwasui
 x5EJgmYlG+Tk9Vd8tXGSl+PSChjPf4fw1x0squAZOD7DR6Tgy2pGQpacVzJXSbQT3W8RzuhjUYA
 Y2LWCacPsnAxKCpbRs8Nq6cEJ/gBof6mw4fom6nQn7aZPLQWfutprMkB13MLo75Jab1B/vWkF59
 wJ+I+mhOxw5ZthUP0xFHGLqcmrdWemfMgqu+VJ68kEHzxN2JyhVmJF0znj2u1bvgxJ8utyfSJnj
 SPay2xCVfHNlbkfHNDA==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699e0bc8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=LqUW6rLYXr1P-t3EVGcA:9
X-Proofpoint-GUID: tmAUYl38FaJWd43P8bIuEn23_54T1yw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240173

From: Abhishek Dubey <adubey@linux.ibm.com>

This patch enables arch specifier "__powerpc64" in verifier
selftest for ppc64. Power 32-bit would require separate
handling. Changes tested for ppc64 only.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c9bfbe1bafc1..dee284c3ddba 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -155,6 +155,7 @@
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
+#define __arch_powerpc64	__arch("POWERPC64")
 #define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" EXPAND_QUOTE(caps))))
 #define __load_if_JITed()	__attribute__((btf_decl_tag("comment:load_mode=jited")))
 #define __load_if_no_JITed()	__attribute__((btf_decl_tag("comment:load_mode=no_jited")))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 338c035c3688..fc8b95316379 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -378,6 +378,7 @@ enum arch {
 	ARCH_ARM64	= 0x4,
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
+	ARCH_POWERPC64	= 0x20,
 };
 
 static int get_current_arch(void)
@@ -390,6 +391,8 @@ static int get_current_arch(void)
 	return ARCH_RISCV64;
 #elif defined(__s390x__)
 	return ARCH_S390X;
+#elif defined(__powerpc64__)
+	return ARCH_POWERPC64;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -587,6 +590,8 @@ static int parse_test_spec(struct test_loader *tester,
 				arch = ARCH_RISCV64;
 			} else if (strcmp(val, "s390x") == 0) {
 				arch = ARCH_S390X;
+			} else if (strcmp(val, "POWERPC64") == 0) {
+				arch = ARCH_POWERPC64;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'\n", val);
 				err = -EINVAL;
-- 
2.52.0

