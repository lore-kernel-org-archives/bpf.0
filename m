Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6863DDDAC
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350415; cv=none; b=XGT+Df3ccNW2n8Sk5kGGHcSKFOYkF1CfGpW3XNYIswQx5yo3WGb/naH5ew1aJWDjHtMQiv4dF3hLLES58csghjHF3NZkKEn0oDGWBRu3rtB3DdyW4U2ruNZof/ISswsJTU/d4a0kF5qnDTbgLyeMdGiyRTyxZUOeaxkikZoEOnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350415; c=relaxed/simple;
	bh=mVu5sKyqyVYbXM7q5eqenarKr0KCf6+dz2LRy32z7IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOzgoVIApy2jgftfpdP092RLrtACebzWXYuPId5p8FXacZ7KO4YV2fN/4Giub7Gyz/2tCOEOtcwvVSni11bR+/YCyIUZUa5EKI/+vbP+enYtOSxsPnipYMci4Lu2Qmr6IkX/uNPwSJ78a5dBrR9qiBcjv3rX6qtF2Tv1V2snQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fqw1bT7i; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fqw1bT7i"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G5TVoc583005;
	Thu, 16 Apr 2026 14:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=FG/R3
	cDl5GfTyckajt4skgw88Lye8f+IWpL/CK8Dc58=; b=fqw1bT7ir7XBUE8z5cnHv
	6WzvA38VnigFVH0dcojb95hYDQZPcHBgLFThCVjJJqqafTzVKCWQqPBWWigmAUEu
	cjZ+l1qMj4aih1WvKFF+oNv7FSvUIatyTv7u37exe30HVRGz81/nugP9q+cWFDne
	A74w53x4Z1EpwVXPuHxiJBI2Gtqx40fnF7fJZVFJ4eLnIEqGshwaNOM+Ss81cWWL
	Nu0h1aSj6Xd5mWSbPdFlX/BwWoUnU3SKQHsjLlLFmf1mDK1YIphjfRF0Vwuh76xi
	il7Y75OKj1YM1d3asRQ3BifsAGuGgBM59L3QyiINihS7kk/n8AS3ttnnwEzg+ycc
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qfpq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63GEdQsv017663;
	Thu, 16 Apr 2026 14:39:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nqkmq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:47 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63GEdXaf018534;
	Thu, 16 Apr 2026 14:39:46 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-74.vpn.oracle.com [10.154.52.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nqkm1k-7;
	Thu, 16 Apr 2026 14:39:46 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 6/8] selftests/bpf: Fix up btf/invalid test for extended kind
Date: Thu, 16 Apr 2026 15:39:02 +0100
Message-ID: <20260416143904.1220662-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260416143904.1220662-1-alan.maguire@oracle.com>
References: <20260416143904.1220662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604070000
 definitions=main-2604160141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0MCBTYWx0ZWRfX1mN2EA4AcB4k
 QsZ1NBG+GJMZLS+18jcmBuWDO5sMDzJq8ZnHM2XFh8U2a4XnzRg9pMTQaiYxNerPJvycu/5YtJQ
 750cr/eKLfSrk5AscsA09hBM6wN4du1jEwpeJZCd9U85vxAV4Pe2y4QHvgPsBmx/W9a++u85/bt
 EvryeKRIUTDQ/ufYSOzAx9re9xSKv0zQPW7+nZ/Ipulm2Et9TSFcItxKMsdPrxI2Xf8+h347n4f
 YA3xRzUfgjpADsmg3wVrYVe6PDmah4n2gvQTRoeD1PfxNypobb0jpVCCsX2LrjBL1VsALFR0+4j
 iddN0Yjf5EmWFiFKbYJvkxPHrqQtJQSkKRk0Uryu8PP/4+Oie3RCPF6fcn+03QLhlv+nTt0NQwp
 0tVGAn+pcsAMZ3bFMchJNyqsYq1setANc82IzEFfSCfRnVQ8wYdycHyGrLwbijalgHIpSqNJzPp
 EbRwwFd1ScD5ihiTrMXh5m3uxPiIdxWrDA79cJTA=
X-Proofpoint-GUID: BgLhL7ve6yE-1nsbb8DCT1NRwM-P0PtH
X-Authority-Analysis: v=2.4 cv=V49NF+ni c=1 sm=1 tr=0 ts=69e0f4b4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=vz9nfY1adzvwEb3K4J4A:9 cc=ntf
 awl=host:13825
X-Proofpoint-ORIG-GUID: BgLhL7ve6yE-1nsbb8DCT1NRwM-P0PtH

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

