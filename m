Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B46230BB9B
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196261; cv=none; b=KoNjKb1tdp54eETa3yRGerB8bGk9sDIb+VdMCYnkrCIAEqIf2HVcXnRpMoDhNni9Pk5ednc1BwurIZYImjcMY/XtrBU1ErYGWhOxGS7eKWS20tNq9Dck7IHth7HStyvfcxnk9Og/aYbTB0Xk/on+Gs9ToQUr9OaGrCEjImIA5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196261; c=relaxed/simple;
	bh=G2CPiygX77mjpsRgCfiV4yECqJa0rtlycjjx7UPpZw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzZZmDllL/VOt3AQgQf1vt+X+RBJ0YjXIKnJMSPDnVdc2AMxZcGdHz5w+uEyErs/6828rUhTYLkc239KAG1/cvBD23KxwAZAfxvx+sCHWLP8RNIaxdaBb5BHPTTJ1ePWk4lNAIeZ/c3UoX+EGm6+eQxzjoYjBRts7k920ClmmvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LHGN72G7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LHGN72G7"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EI7xxn1734453;
	Tue, 14 Apr 2026 19:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=1oRf0
	nAtGhF6IW1pQejGyaGcrmaUEw9nRtioaBh4K8o=; b=LHGN72G7Dh9mvJF43ImP9
	2xrf5uhOePl/nXRcKkRR7P5jTR/rBMBuM6qm6GGpT8vg/ki0iymP62MjmPX9VSkj
	bIyJktCbT2iEZkoEc7Phs1VvudXuLWKgcbfXK7ZtRgDmsIma0YSuslDWA+K37s7T
	ozjEQDJ9BExh/5wcvRnjaeG4D6xtUeLITvl6yrpawYxJpJp6AGGB8E3sDWmIyx+R
	lF3vXf1kDfJt7AJE9zmb8aJ54gaXsbH4rG6joEY8+KGPHpzb+hV56wm4PsUKdm2N
	vOJSjaZVcEp+aipSpyh8oz+wggBZvQpKvCeTqEVrmLEyaHgYyPriUduoaYqjhZus
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qbqv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63EJnOX3025431;
	Tue, 14 Apr 2026 19:50:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nkpgm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:42 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63EJoP5Z030710;
	Tue, 14 Apr 2026 19:50:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-225.vpn.oracle.com [10.154.50.225])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nkpg37-7;
	Tue, 14 Apr 2026 19:50:41 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 6/6] selftests/bpf: Fix up btf/invalid test for extended kind
Date: Tue, 14 Apr 2026 20:50:19 +0100
Message-ID: <20260414195019.684531-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260414195019.684531-1-alan.maguire@oracle.com>
References: <20260414195019.684531-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604140185
X-Authority-Analysis: v=2.4 cv=d77FDxjE c=1 sm=1 tr=0 ts=69de9a93 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=iQ62adC8NFII33V96qcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE4NSBTYWx0ZWRfXxHAWcFv2w82l
 aeNtUlFIFZu2gkw2IeiyKmueHwpQtig0hmJrCs/MCwLXF67z0Po2TzZjpZZnzWvzTDIvsKUwEZ0
 5Tr3160xr0xVneUPxOTbWBXivXn2Vv+PrLX4QshZU7f/F7Ut2WmZD9aHunsf92gpjJLQ8BUG0fV
 EnNfvyzxW8H1BG3WTy+5/xACHEKoFhLMpBTZOmtf6TAbI6MANOLkCcrw+eL5/rj/6r6w0fm94UB
 WTYjBcPyXUbQDqfdHRKiSAvl0JOjmUle5PR/SHFVLkhAuYidbj1PxkduzdX1JCfmCt7hut3oxRJ
 k2BN2uslGLtun5+ClK/RCD1e+5L5XoKfoPEHLj+bDqy3i5dMMVBDXWYovE56qWEGAKp3gdLN1rz
 8Ynrudf+VIFQ+NgfJLw5pIGftjYfGAPaUT0F1hRRtJH4B8KM0SugqjJymriduVffbNV2/TFSf2t
 fgK8LZVUn5sAv80xAow==
X-Proofpoint-ORIG-GUID: KAS1XkCVeAsMFz2G7ma5loJKe0llSqoI
X-Proofpoint-GUID: KAS1XkCVeAsMFz2G7ma5loJKe0llSqoI

With extended kinds, 32 becomes a valid (but not used)
BTF info kind value; fix up the test to check for the
"Invalid kind" rather than "Invalid btf_info" message.
Since all bits are used in BTF info, it is no longer
possible to craft an invalid BTF info value.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 054ecb6b1e9f..07b1ee0eba37 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -1924,7 +1924,7 @@ static struct btf_raw_test raw_tests[] = {
 },
 
 {
-	.descr = "invalid BTF_INFO",
+	.descr = "invalid BTF kind",
 	.raw_types = {
 		/* int */				/* [1] */
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),
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

