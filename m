Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AF46AF24
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138606; cv=none; b=XabtK2242E1JkwmN9nLY2Fbtw//wpo2GQGbSvc1wmttLtiyzBmZHAT/MVc2pAOd4ZQ+mgMgkRzizJIzFZKWyS4J18IPVlXdhaxgjEQmfuxtxY0S0YiI9znK3LVNIOR0NF5cgVNJ05d/C5t6IFhjk8FJsRxm2wsDJ6X9QpPqExPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138606; c=relaxed/simple;
	bh=CWgfBuppmQhhP/B3tzr1Ku70P20q7zXz5/zx2hEX7Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjpW/oAwFqDf6osqC223m1Mm2sqVIq6IS/C+OGEsRkIy6dDuXFga8o7y8XK25NS+O/C+NcpsaRXPd3+MswjaL5CWolYhlyF1CegHYWI9cZqKFfg92I/QDRb67PStZkFAfjhw5AhSDxllKL+PTEQXij/HAlxA2qGjN2eBY1cZGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BghV9TJU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BghV9TJU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QFRpix1887407;
	Thu, 26 Feb 2026 20:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kC8H0PEdfXYyKnAPH
	iJszHn1jKV1YYA3ikR0P5y6cHQ=; b=BghV9TJUk3F16MoGbqXBe6zhBu29IH7Pu
	E1Ut4uHnHT97oFmYB22LYSffR0HRvMvm7TzV3GAlaPEd8Mdd6bQVMfU61tzGj7dT
	mDDK9M/NQ7PWrN7TvXvsVANY6otc7ZEz2yaVLHMwVJusI9W6J092tNoZ5FiItnvF
	h3kiWxk4r/cgf68DqDPjT3gWq2KkFgxIkh5WVT97FhCAk5CbdbDVdoZ83XNqWGC8
	wEdRr8WEazhonXghAnOvIWBdYZVtGXSmaNFcfRpee2Np+w8ROmF+6eI6Nj6QYggO
	IPgQelIVnckxuMbemY8UD+SjzvlbiMSLfm8OwOjY47bIPLnBGjlLw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gr9ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 20:43:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QJ4HZg027776;
	Thu, 26 Feb 2026 20:43:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr25t48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 20:43:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QKh2XN41615846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 20:43:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 989C12004D;
	Thu, 26 Feb 2026 20:43:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED6EF20040;
	Thu, 26 Feb 2026 20:43:00 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 20:43:00 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v2 2/4] selftest/bpf: Enable instruction array test for powerpc64
Date: Thu, 26 Feb 2026 20:43:09 -0500
Message-ID: <20260227014315.39980-3-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227014315.39980-1-adubey@linux.ibm.com>
References: <20260227014315.39980-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=69a0b05b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=Dg5FhV6KW9bU0H1UeMMA:9
X-Proofpoint-GUID: coz_Tx1xZaP3w4xexRNj4UYUYKNbubX3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4NCBTYWx0ZWRfX7ejLYmd1CMh2
 Tsioggy96FvUX+6GXidUsKT6PIpEXqxa2B30f6zOTOorTAckmcd/TY06lcEB5KZxsxr4tpHd8n9
 3Gcah4luEumbTKgCGKWhMfXF5SlyoJrd6VhwjtWnxDyePKU7ruhy+Ftn22AxiDdWfFwcJ3buGr6
 jhlGs55/t11qhbi4OUq5CYdI0SyDBE5qjqKGrk2YtYTIcdaSBbj23fDFlWLPR45njGPS8ekT5Ir
 /sI8rC/oqrFpp/B7N0ReIOuem97Zqn0cyRdmqf4ZUHzZva/TyrIS7QeOY89qBI0jLJVCaoRMVBs
 4ZhqbH5KpGqnQchTTOwb+JPmXto0SbGsvJps0gS/NwvRIDHKjD1+lT5r0j7rjtgc8wVh1pj6371
 kbiNCA0jg1hWebsJq0avdKElNuFtA4JrI4G7EBSBCoGQDltrjJX50Yv3n0McwuT1j6ttaa+spFD
 H8TPaNR53UG8e5E/o9w==
X-Proofpoint-ORIG-GUID: coz_Tx1xZaP3w4xexRNj4UYUYKNbubX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260184

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

