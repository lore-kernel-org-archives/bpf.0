Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205E26158B;
	Wed,  8 Apr 2026 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775613195; cv=none; b=Jy6l74oNsakRpM3H425d6yXjCntwWN1AgGQd/EVCcDJcQtwNV9AifpZbIPKx9anG9n7cMXrnc642EeCuOBQ13lNvWleZIgBP7MS8MfLnzg64RimYw90nurthNjBHMQ1S8a4m+Wx+UJfy4oO/RY3gMJxbR7WJo72BvEjHWPiUQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775613195; c=relaxed/simple;
	bh=oot1CW3zYRijoApmfAfQNt+TN7eXzXttwWjkQW8Dj+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iu9kHWH0V3wXt5KFoCJMlQ0gCnO3X3VZLs32XfLPffnbjYXkhcBiGz88cs1x00++63FMwcnW/6KtxWirP9SMLA70DZ3kiCr9PuJGJ7K+4knFrRKcJmaQjWcTXTf5q/iMHvpSvVklMEsPMXE8qzwO3Sfv/JaPyPNhjb8phk3+NRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DBcuVhjV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DBcuVhjV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637E2T4H2318761;
	Wed, 8 Apr 2026 01:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=g6rj0ALg0UDdA6CH9K1KA8uNXSHO7JVCsZ60bnU6T
	Ls=; b=DBcuVhjVQiucartfFEhvrV/7K6GhneHZMIpm/sFwhx+sLlFIu39ZyWCoa
	JnC4G8gIdUv2L7GhI2vXRfnwJu0Wr21vC5P8c6ZoHI9kvyndWeIyrrfn+igLZoyp
	5BBJW5GTXVdLyxWYFFNUjxZNgkoL6JHpHFzAMaBIvj9EaW0KAaNwQIl1Uf3uCR9a
	DBgGDDZuv+N5wMH9ll94Yu6pTwU/jQSkA7Cgvw+aYoVrolMQDh+4IOkySKKmbE9p
	O4VwrXRKDoucAjlUKUk5Hqm49tJuetDBb7aIk5+Qmue4b6cq2JmuujXdMd6mlYNd
	vTg26xjJSk+9sD9FkGkPTXmshRYxQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fwv1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 01:52:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63804vvj013827;
	Wed, 8 Apr 2026 01:52:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf45mw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 01:52:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6381qlbC50594170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 01:52:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FC1F20043;
	Wed,  8 Apr 2026 01:52:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7395D20040;
	Wed,  8 Apr 2026 01:52:45 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 01:52:45 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc32/bpf: fix loading fsession func metadata using PPC_LI32
Date: Wed,  8 Apr 2026 01:53:01 -0400
Message-ID: <20260408055301.232745-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d5b4f4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=6s7t5AJM6jSuhkjG0HUA:9
X-Proofpoint-ORIG-GUID: OiNXJKwsFEvqySt0UQE1_8rzYoeh0oOf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAxNCBTYWx0ZWRfX3fbnrFmako0t
 UyNKPX+solfhugp8ZoDS2xUWb8ZxkZRDb2YMrVg4Wz96sKT+YIfG58Pv7w6RbzvCpD5HJ2ZQbzN
 bNTlxoLu9qF24BLJSDujtM+/SftRr3y3gufK0Rx8q5OMCvmmUqVCcE/jCjN3ofP4bmnEB9nDx+d
 KI65UhEljcYpFjBZ7OrRcFysrDbH/DtQIHWOaSPV3+uFtSvx/vWRf1s6rJZasLr87RsUGMOZYrE
 IMK3s7QzA7zMt1t2SI0GOIQl8vX9fBofKRnpxZFEkrU7+4Y9Ja2PQRdHgtQxjiC8RdgcdvnIFFs
 nkJiXnWn4kCdVEv/Ggsu9/TWITJ2/R1MG+q5XwjstA9rwTRzICmulpUDrz5Bc5dksiTHYqoXUs/
 zV6UcHDA7+Okg06smAbNTrfpPI1ly/B3XVsE0eUiNPXKz2Hk2Cg6GC/TQaukG49g6+Cf9sxQPbj
 EHkETcZGCDHXkgi2Eng==
X-Proofpoint-GUID: OiNXJKwsFEvqySt0UQE1_8rzYoeh0oOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_01,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080014

From: Abhishek Dubey <adubey@linux.ibm.com>

PPC_RAW_LI32 is not a valid macro in the PowerPC BPF JIT. Use PPC_LI32,
which correctly handles immediate loads for large values.
Fixes the build error introduced when adding fsession support on ppc32.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604040212.jIxEd2DW-lkp@intel.com/
Fixes: 92258b5bf1ec ("powerpc32/bpf: Add fsession support")
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
Need to apply on tp of powerpc -next, as this fixes a build error reported on that branch

 arch/powerpc/net/bpf_jit_comp32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index f3ae89e1d1d0..bfdc50740da8 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -150,11 +150,11 @@ void store_func_meta(u32 *image, struct codegen_context *ctx,
 	 * func_meta := argument count in first byte + cookie value
 	 */
 	/* Store lower word */
-	EMIT(PPC_RAW_LI32(bpf_to_ppc(TMP_REG), (u32)func_meta));
+	PPC_LI32(bpf_to_ppc(TMP_REG), (u32)func_meta);
 	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, func_meta_off));
 
 	/* Store upper word */
-	EMIT(PPC_RAW_LI32(bpf_to_ppc(TMP_REG), (u32)(func_meta >> 32)));
+	PPC_LI32(bpf_to_ppc(TMP_REG), (u32)(func_meta >> 32));
 	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, func_meta_off + 4));
 }
 
-- 
2.52.0

