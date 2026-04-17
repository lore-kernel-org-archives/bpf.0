Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E23B3BF9
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436315; cv=none; b=iHksUIJ8RiPpwoJW17ps2zhAlhUe4rI4sA/eys3Bo9KZJFwaxzfJjoRvTpmSMTHHih9uAEjPWbdbSWSoZNjBHySFGgFLf963hstYWK99EMeOQQWvP6GRw5ugNmPUoNrr8biJK9/xSA8uL1J55J2U0xPJzSi2gvQXyr787//RtSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436315; c=relaxed/simple;
	bh=mVu5sKyqyVYbXM7q5eqenarKr0KCf6+dz2LRy32z7IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGZlBwjZIENrdXJOOEJ0scURw2VkgGq3Q8AXFtimjGQ3wlNbkunnKIvpvQgCG/VuveN46khD9HQno5+CMvI4gNMCIxP+H4RvdKPzL/353J45hx8Y91/bt0J7W4A1y1UJMctHCgGLMVedzavmKt8mwQVD1EtoBnnHb6fF75anAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qlqezPc/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qlqezPc/"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HCbcnH4110712;
	Fri, 17 Apr 2026 14:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=FG/R3
	cDl5GfTyckajt4skgw88Lye8f+IWpL/CK8Dc58=; b=qlqezPc/ybjutPextwRnF
	YuHW8STZbQF9wsDP6DZLP41yoFAE6QKAW9DHazZpu8i7OIzMuGHmht+lbrseZak6
	eB1xS7SIV5Hb6ifDRDJfoEz4wIMZCsCvTeR5x7LLOHG1iPAUhSbEs93LnpjcnM7+
	vzfRtRFHPhUVwiMFX3G2aMBZn+Vdzzs6Cf0eIwCwJz9GWV++lFnaLdC0TsCQfQwe
	DElA3xTBNeDhrs/JvlXm7+Cz+MbYETKprxLMShkYvOkbWvZeRtX0QEpP8D+ZUXZe
	72iFbEFVVptdoQGXmwnVU770GVjvXglkpM8Lf8RijkSrqOdU76tVnH3vf2jnHoqy
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh87h9um3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63HETQLg027263;
	Fri, 17 Apr 2026 14:30:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nrw8py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:37 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63HEUSt3033610;
	Fri, 17 Apr 2026 14:30:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-148.vpn.oracle.com [10.154.53.148])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nrw8f6-5;
	Fri, 17 Apr 2026 14:30:36 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 4/6] selftests/bpf: Fix up btf/invalid test for extended kind
Date: Fri, 17 Apr 2026 15:30:21 +0100
Message-ID: <20260417143023.1551481-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260417143023.1551481-1-alan.maguire@oracle.com>
References: <20260417143023.1551481-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604070000
 definitions=main-2604170146
X-Authority-Analysis: v=2.4 cv=eJUjSnp1 c=1 sm=1 tr=0 ts=69e2440e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=vz9nfY1adzvwEb3K4J4A:9 cc=ntf
 awl=host:13825
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0NSBTYWx0ZWRfX/RRlv1wSrX23
 OOw4pZ2jGD5uyJmuRB60Fv/HRvq7sXDKopwl3kspKibaGQ8Kn/QkXqOlDlPhi9JN5KCjNh/OTmP
 fwKIFboRmNhlSvlqhOHTqDj9Ylp21YPaXgwkTfjgXhf1Rj1Nw71lQrGYEL34xWJO46nBLD5hJG9
 ZFyDSDTQ830qgBvEfhjyifn7AYKC1M/qZxSgmF3mslXEOTOcCfV3yXMsiS/eAOnoeJ7umt0sNi8
 AI5AuJSyxwpi6yEwHFV3uQNt2Bg1s/kWDoJczaZd8hf/uPWJNgos5w1/XEitxOdlcLQkHZdTg4D
 t7hbe0vrXSZdaiNHY7bW8DriEPP2BwoQFQiLDW27VgG/VSGZCpUBwkDb2CNYD4EF5uZw/vzH2Kw
 hqxCcj+pY2Kua3Zb4W9vk2CloOZ1LdX3erMGtYRuouQFTbi8XX6OeDXIMqsV6fdyg1x5qFWgRSk
 KaaHCMWRjV8grrqFjZC3oUirYZv7RMetKh5Ot9Vo=
X-Proofpoint-ORIG-GUID: -IavV1C0D4FCDFdFfF4VbAOUugHVxDh0
X-Proofpoint-GUID: -IavV1C0D4FCDFdFfF4VbAOUugHVxDh0

With extended kinds, 32 becomes a valid (but not used)
BTF info kind value; fix up the test to check for the
"Invalid kind" rather than "Invalid btf_info" message.
Since all bits are used in BTF info, it is no longer
possible to craft an invalid BTF info value.  Use
127 (new maximum possible kind value).

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 054ecb6b1e9f..0cc347e32db3 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -1924,11 +1924,11 @@ static struct btf_raw_test raw_tests[] = {
 },
 
 {
-	.descr = "invalid BTF_INFO",
+	.descr = "invalid BTF kind",
 	.raw_types = {
 		/* int */				/* [1] */
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),
-		BTF_TYPE_ENC(0, 0x20000000, 4),
+		BTF_TYPE_ENC(0, 0x7f000000, 4),
 		BTF_END_RAW,
 	},
 	.str_sec = "",
@@ -1941,7 +1941,7 @@ static struct btf_raw_test raw_tests[] = {
 	.value_type_id = 1,
 	.max_entries = 4,
 	.btf_load_err = true,
-	.err_str = "Invalid btf_info",
+	.err_str = "Invalid kind",
 },
 
 {
-- 
2.39.3

