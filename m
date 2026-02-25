Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD2C335064
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963824; cv=none; b=Imfb1x4DbQMUjPda+eLD6I2oCa2ZtMuZnQbOBwHzdKawEJFGCw6FTgSfhpXf7jZElY3dhdQ3mNd3/Rl6RHr3WogpjCC5KGEjtZZS8C3d+FCPrw129ymtLgADA2IGTUHRMcJ3hnPOepacEU/wh5j4jVnGhhIZZRbPbfANwUdntVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963824; c=relaxed/simple;
	bh=LG9E8ltTUY3cRqTay4zkC6849CFuTTPbsAK1X8K9bFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJkNQZFSuUVplh73aeTaGn0HjKTHLM4CO9G9WHHwbNliMNpcDtNwJHV9IcUMQlprRqRvPIZes3mUq83NS41BL5UU0bOPUMZO0GdnjapHMESeMfD/uKccNORMLI7bNaEFM5jzI7swuYFW0W9kdcLsHORR3FvVIGyRDLXlbDJGTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rif28DY+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rif28DY+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAsAp32654887;
	Tue, 24 Feb 2026 20:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tcsQQAWxA3aNGBdZq
	I58IE+fXC4naEzp2MFfxjUJ08s=; b=Rif28DY+Wtl4T8rihgrK7cUnzA0eOxR83
	vCwZ0XnSwPN9sfUIPoxUwXDgqucnB7rxQJEbnKHpiNmUUl11n9ZDM6+PcDxXaEps
	iDnawRIPIac3D9Iyz1KOYun0kkjeuW3ad8IzFCkTXy9sGTaMzDz6cafxrOhDwQfr
	gv3I8Obrn6nlKX4fOqSt/Z1BLgztsE44JRq+2majozE961XS0wn6MLwecC2t7+jp
	cLkuzXpSPuqxZga3Uj/iDvenwVn75eGfb9MqNF1iOf5joMXdSdIz4aRym/n8BLZk
	GKMD8KUQ8KyJ5+uhaN0UVjgE2NvnfXBI8uc/SQ64ZycPSbP+AMyDw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqwbq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:10:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OGUrDc013478;
	Tue, 24 Feb 2026 20:10:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy2je5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:10:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61OKA1je33947904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 20:10:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62CB620043;
	Tue, 24 Feb 2026 20:10:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE83B20040;
	Tue, 24 Feb 2026 20:09:59 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Feb 2026 20:09:59 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 4/4] selftest/bpf: Enable gotox tests for powerpc64
Date: Tue, 24 Feb 2026 20:09:32 -0500
Message-ID: <20260225010950.20218-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225010950.20218-1-adubey@linux.ibm.com>
References: <20260225010950.20218-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 96_P54RKxdpNo7PPm1Cfdo1pp4Neh5xi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE3MyBTYWx0ZWRfX38YKUJMml4HA
 ZlnbBK4U2mZPhBel4vRI5a6tjbOKRJUBanPAbTNvx7iJftU/aryZOTDGxY94UXeMTlUtSSDms9e
 cf/GnLuE9XAZ9ob4QIuLa488mo1a8orQyQSGxYzYrOE/KS8kspa2gfOie2WgvSx4Uj1J9FzM+VR
 V2jjJizaNus61jZlB6quQ0hrYt52tvpRCeTRTZT4NXAMLluSSX2zsANteB1k8arJM6DJnJixIpe
 u9CnKC7W5QQmNZnwA6CT1RbhGgsGZmFZbvdGmo4dJ72XtHjiVS3GsUkMB/qf+LLxD3tYP8voiug
 PNPt6g2MzR2OCKY+pZs2OWgR0ZStIvHbRtJMBcLzA6cQhB5sjZU9vdnnCA3iRQ8IUx6QUfdRpdz
 N9RVUhDww9bNlHZbXKzXQ7grIB/cUSuPnCGbW7qfhaPeGkcWhBP02nYsZhJ0c0aToIBq81EOCWX
 rCV3fko5T1WCaAwmA4A==
X-Proofpoint-GUID: 96_P54RKxdpNo7PPm1Cfdo1pp4Neh5xi
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699e059e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=XIkr_taID0MGvadLvJ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240173

From: Abhishek Dubey <adubey@linux.ibm.com>

With gotox instruction and jumptable now supported,
enable corresponding bpf selftest on powerpc.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/verifier_gotox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 607dad058ca1..c1e5b8529add 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -6,7 +6,7 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_powerpc)
 
 #define DEFINE_SIMPLE_JUMP_TABLE_PROG(NAME, SRC_REG, OFF, IMM, OUTCOME)	\
 									\
-- 
2.52.0

