Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CEF3358B8
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963815; cv=none; b=hC2aXlRHyfD1gym03fk3lvIodN/o2RzQd2ZAo0HhS908m+xtVp3XuawcMjC14H1ljOQFurW57XinV1Y8YOWbN+Huw44dQcaBMhF5dyX9V3fEMBQdrnWfKUsVRNdcNz5T1Do0XlHPh0OE0/IeeqNNywHJY6N1U497frNnPlDE/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963815; c=relaxed/simple;
	bh=CWgfBuppmQhhP/B3tzr1Ku70P20q7zXz5/zx2hEX7Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpCCKoaWF3ooeaurQzEACdIqw5O81bckQVkjbEWavSsInbzZj04dexzRmVLZM0ZCH90Q01mglou2n2J4gYzP8w+43FydTM9uCKijHgOPofDmDe6XRGpYTqw/oAj9tVYDDUYZBYR/M673YjcUoI/eO93TliWpupkVkCBjGyuQgPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OddVm8Cl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OddVm8Cl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O9XIDm2648089;
	Tue, 24 Feb 2026 20:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kC8H0PEdfXYyKnAPH
	iJszHn1jKV1YYA3ikR0P5y6cHQ=; b=OddVm8ClqYmp4W/eom8FteSTXwYMXwvUb
	uCy2/vi4fAxrU+HRIV5JzYdn/VEZ+tTTsbHLXN7HtT/CKHB01Em/syO68RM4vvm8
	8OliflQL778dAD9Vz/vELTpTmdK+tSTSebabR7Pd+Ge909ch6BNqkK3xQcezYm8x
	JL92NaFdP8MSmio+no3Quzcn/0NnMedOx0+KiuUDn2KhGgWhInrN4em5TsyuCUAM
	PV9DYL942gn2IDT9Absg+uqhGEuRNjsNytfE/36aSc4cH5J/jY1la5N25AlDPpgK
	g4xC8alYuRY4AoA8hoMyaPD1smwkTNLPw6M/Oux+8PN+RFGdP7JXg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c4t6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:09:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OI2MIK027887;
	Tue, 24 Feb 2026 20:09:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1t70c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:09:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61OK9r3G55771610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 20:09:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8148020040;
	Tue, 24 Feb 2026 20:09:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC44120043;
	Tue, 24 Feb 2026 20:09:51 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Feb 2026 20:09:51 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 2/4] selftest/bpf: Enable instruction array test for powerpc64
Date: Tue, 24 Feb 2026 20:09:30 -0500
Message-ID: <20260225010950.20218-3-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE3MyBTYWx0ZWRfX+Tyo5BDmryxG
 we2lBeWMRdN0rPIQUgR/5/fW3BOuG0CVij8u1FoysflftoE9TnREt3ZI8KUcRebKAWdYSgtA2eR
 tro084MCt/J0PG+JgDaGvJ0+8JY4fKKstFeTpL4qFj/kHmesKG/gwFsKRUd5usnvME4oBGwN//6
 qMxS33wzkB+Rw0WQ/R78Gfa3Ch51EqsMl2EN0Ob2z1UrQfzswpLxarvcZAZZPKh6/c/mKlPdHHu
 Zd2334G29KiNqjgXSosY+FjRsw7mYzZWe7iE5z9yKZ+6Yxj/dmjae+5RLXOGTIRNmphpDp7qYw7
 gE55W/Vb9WfHNKLdmojlyceShEoBzg9Jl+one77SuhDVuCdd0hjeCV//a//dptHxC9NszaL9Uy3
 c0LNWtTco3pU4whMFcf908g6iic/7NPLo+yGwdwJ7nTTXMQQ1Zv0djmINTw3zFhqqF0Dmpk/84w
 68Lg302r8etp95e9wwA==
X-Proofpoint-ORIG-GUID: Wsp6EfrkJ9V3zDf6krm32ch0PnrlsN3J
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699e0596 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=Dg5FhV6KW9bU0H1UeMMA:9
X-Proofpoint-GUID: Wsp6EfrkJ9V3zDf6krm32ch0PnrlsN3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602240173

From: Abhishek Dubey <adubey@linux.ibm.com>

With instruction array now supported, enable corresponding bpf
selftest for powerpc.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 93166c2da8e7..57ce6943fcfd 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -3,7 +3,7 @@
 #include <bpf/bpf.h>
 #include <test_progs.h>
 
-#if defined(__x86_64__) || defined(__aarch64__)
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
 static int map_create(__u32 map_type, __u32 max_entries)
 {
 	const char *map_name = "insn_array";
-- 
2.52.0

