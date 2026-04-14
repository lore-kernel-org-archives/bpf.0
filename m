Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21063ECBDC;
	Tue, 14 Apr 2026 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176662; cv=none; b=Pn6SM+rhlhmLrWqGFwKAyNYtfOBt+leyZkWbfx4kzP5Y4UgAlwHWaNyV5KgNoArfAjZS3yzqzJiTF11GJYqBKsvmNXo7ilkm2peKcaKaCmAbLXVkTdzPccOoTd+vX1mvIqWY9K4lIoq0ZDw4QFTL/DSvzgkBfc1YQBveKHBduFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176662; c=relaxed/simple;
	bh=JOrKkTDm1XzgTTaELyjAW2UoqQARrYaRgnDxMrWX3CU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N0llUwFA6B9AzDj4X4WR4e9b8ZqqIWJnF0/fe7m1RBsgu6uSn7GG7JlhgbIlfr5RVxJANruwHhAsqxG31VmI3fOjAvm6isJKDJtNsaFDvoYOQIHdAY/QMebxHMK85DgXoxEZKEY1MNIGmjB2CHZOJID33rEo4El2TFLO+pWZP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fm6WRvaC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fm6WRvaC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EDdDLY1843301;
	Tue, 14 Apr 2026 14:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ZNJzfHIy1flRiox+Cj0xOPKmjQyx
	791M6XLeQQKnW8Q=; b=Fm6WRvaC8aUGGI2q3l20RW2RyWuxTDY3Dxyci8Zec4/A
	rDyjUAzOcnHX0eWDo83vlRIsqFBZbGn0xKPWjsIdzXHn7uXzS+ZceNqcVSX23l3M
	YKFTqYE911/Wd+/XRPMqqYxsAoDp7UzjynKNQ+QaLGia+IVHh7nuR8jxCCtZJcfl
	qffqaPDf4u9qRb7n/HPzH56zZclF306VOlob95+GSbbJbE/xIH88jaFmsWqfBnPt
	geXEncCKOybadwoP79OalyvdR9a9qJ3PKQTIxgMvKgIHCA0lcHu9PHFtjb72ivEu
	O0Pzs+R+/ypetC/4xeAg9NsyjdH293jT8Bl0kbZbag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mk503-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 14:24:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63EE114X003557;
	Tue, 14 Apr 2026 14:24:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn9tbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 14:24:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63EENwjB61800822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 14:23:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A162020040;
	Tue, 14 Apr 2026 14:23:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7954B20043;
	Tue, 14 Apr 2026 14:23:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 14:23:58 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: zaslonko@linux.ibm.com, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH] tools/headers: Sync stddef.h  with include/uapi to fix BPF
Date: Tue, 14 Apr 2026 16:23:56 +0200
Message-ID: <20260414142358.3090333-1-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEzNCBTYWx0ZWRfX4d6rM9YEPyT/
 8fays1TFveSaphs0NhwqI5xBSSzBPhpmuXXpxiAQR5xYS6bBn3C1Opb60s/Wrm2v+m2C2aeT0gv
 AL4Jfijjf3+khhOYangQgBKNmdbqFNXVpXEZSjcbr7uB523+D/6K2JLRnNwH37464JX43RuRXTE
 YbUWO4whaJi/qHwf4aUrBRaO22dmN2MSQDkYzOCfShlYdZKUM45ytAKidw4gyd9VR2ZiYiRwasB
 pMqIUQe3osVujZihViouSAsN/jHBY5/OqcrKjvaI+Pf+DgVT92v86iKfWmVFY/68jDvi0oSTwry
 3QICaJAJh63t16pNqNeBfVFH2/tGBDPPqk+sgQ8psNwERclA6ZMXMc8f6FE8PSwv8msezEMTHN6
 JPUtWjkf2ZcNrNq/Ui+Mq/1poZKk4xll1qc91Pboq6T2J0WKPhnlzIujE+KjPXeQ0Mh84GVas8r
 d2xaLcpS+eYPNKOf2yg==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69de4e03 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ol3PeIhsCAbECCkJWCcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9xiH3teEbnQ8nvCux1aTUCRKLj1x8TUm
X-Proofpoint-ORIG-GUID: 9xiH3teEbnQ8nvCux1aTUCRKLj1x8TUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140134

tools/include/uapi/linux/stddef.h is a copy of include/uapi/linux/stddef.h
used by the tools build. But it occurred to be an older snapshot, what
causes the BPF selftests build failures in manual selftests builds:
  In file included from test_tag.c:18:
  /usr/include/linux/if_alg.h:45:22: error: expected ‘:’, ‘,’, ‘;’, ‘}’ or ‘__attribute__’ before ‘__counted_by’
     45 |         __u8    iv[] __counted_by(ivlen);
        |                      ^~~~~~~~~~~~

Commit dacbfc167808 ("crypto: af_alg - Annotate struct af_alg_iv
with __counted_by") added __counted_by() to a uapi header
(include/uapi/linux/if_alg.h), but tools/include/uapi/linux/stddef.h
was not updated.

Sync tools/include/uapi/linux/stddef.h with include/uapi/linux/stddef.h
to fix selftests/bpf build.

Fixes: dacbfc167808 ("crypto: af_alg - Annotate struct af_alg_iv with __counted_by")
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 tools/include/uapi/linux/stddef.h | 39 +++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/linux/stddef.h b/tools/include/uapi/linux/stddef.h
index c53cde425406..111b097ec00b 100644
--- a/tools/include/uapi/linux/stddef.h
+++ b/tools/include/uapi/linux/stddef.h
@@ -1,11 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _LINUX_STDDEF_H
-#define _LINUX_STDDEF_H
-
+#ifndef _UAPI_LINUX_STDDEF_H
+#define _UAPI_LINUX_STDDEF_H
 
+#ifdef __KERNEL__
+#include <linux/compiler_types.h>
+#endif
 
 #ifndef __always_inline
-#define __always_inline __inline__
+#define __always_inline inline
 #endif
 
 /* Not all C++ standards support type declarations inside an anonymous union */
@@ -36,6 +38,11 @@
 		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
 	} ATTRS
 
+#ifdef __cplusplus
+/* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
+#define __DECLARE_FLEX_ARRAY(T, member)	\
+	T member[0]
+#else
 /**
  * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
  *
@@ -52,3 +59,27 @@
 		TYPE NAME[]; \
 	}
 #endif
+
+#ifndef __counted_by
+#define __counted_by(m)
+#endif
+
+#ifndef __counted_by_le
+#define __counted_by_le(m)
+#endif
+
+#ifndef __counted_by_be
+#define __counted_by_be(m)
+#endif
+
+#ifndef __counted_by_ptr
+#define __counted_by_ptr(m)
+#endif
+
+#ifdef __KERNEL__
+#define __kernel_nonstring	__nonstring
+#else
+#define __kernel_nonstring
+#endif
+
+#endif /* _UAPI_LINUX_STDDEF_H */
-- 
2.53.0

