Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91398364023
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853956; cv=none; b=o/o9wbjc6wyyEPlA5/hwVeUG21AojTS2iTsajVZ5zS0deXKoRNXRuxwH+clARhQlg+SbZdbld/hd/sKvz0b7FMSezi9baP5xeGQiLM9xSt/8ifX7QCe1+laPBHt+gU89utNY9qD5l1aKKMNWGPzL2ylkdruBM/ozz8N3qEZaUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853956; c=relaxed/simple;
	bh=rPyltYtdFtSXabiO3D+4FDsHFvbhzaKsIQrLl13Y0lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVXuEkhohdvxTc0BAOJYNZM0c/HPHOJDY5xtMJGTT53qe7onKA8WhIwAIsuBLdwiPexqIpdoJmIlOpHIBUgLoGSuZnW96PjHM0Sv9gUmvBnhfE+c/okiv1lC0wmUscAP3Z6WT7FVbSOdissF1AsHy+ncjiJ6kmCaGyXLriRZD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PzK0NjZf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PzK0NjZf"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M9IZi73475151;
	Wed, 22 Apr 2026 10:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=KUPEiUFaAM7rTzTAYydUFNrzYliWP
	zPO+4bgD3jiSqU=; b=PzK0NjZfwJzeZRioVPdSuwqJsuRUQ357Q565kgZZLcGkY
	TsHL2k2lEHnMq7EgYQ03RqAvmqtrI5jMVSVFUa4/Ma4BKWgeaFND7cKtG+qU6wDh
	OxvWB2rdu8DrkvUoSngb7+Jqj+4R1LwHBVbIcM21/aXkMa3UyeYNS/vQo6e085l/
	Sr3ZNpjDMGw9hsJInvekRvLiUuG7KCAMuWKf7/uGrvUb6hxm/4hKmCItypjnck6C
	x/3NQ4SaijQUXAVwCPDhyn/8cifDH/z+lluNAaruN7O06XujxslRFffPuTMLrZ8Z
	Rq6NlL0Sr9Kk1bb5cquzsklLHAJOsh9Ole/7/4+iw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenm13kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 10:32:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63MAVGRH008423;
	Wed, 22 Apr 2026 10:32:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dpjjq2de0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 10:32:09 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63MAW9wk012468;
	Wed, 22 Apr 2026 10:32:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-237.vpn.oracle.com [10.154.55.237])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dpjjq2dce-1;
	Wed, 22 Apr 2026 10:32:09 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        sashiko <sashiko-bot@kernel.org>
Subject: [PATCH bpf] libbpf: Fix type size overflow in btf_type_size_unknown
Date: Wed, 22 Apr 2026 11:32:06 +0100
Message-ID: <20260422103206.533695-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604220100
X-Authority-Analysis: v=2.4 cv=Xbu5Co55 c=1 sm=1 tr=0 ts=69e8a3ab b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=FmWz4CEXBMvvugAi-Q0A:9 cc=ntf awl=host:12291
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEwMCBTYWx0ZWRfX46wOrheY5Uyi
 d/cqlqex1MteZ8+SeGlocfpTV9QQZOWm5jRgimwwRknLpsmdRZyQULTRzlFQr8S8vToxt4vPEPH
 QbFBIEhT7IoO5pA0ba0FWOXvEeA1vMbvp5kbQyXWp2woyvcEjRgaHC3Hx6FkOagGg0Tdi4ZbsEw
 LJXdoc3QgPbImbIQXipHmiKhHMtXdr2rVDX89kYVvuW90sW3fCKBgCCM3jiithUEu3sLX9At+RX
 SOxwV+qkGg7MtZ2DTolq1wGAKpvvMDUikiCBSH6BrXvSTm3iUmDD/p7O8vnP32FoGEJ7xYlRKD2
 A/q3iNJS5Y6xi+a2nYACVhL2g8b98CvM/i5V0X6ckWH3fHJnAg8romSXMzXYz8XQ8IzXObGGU8d
 drVizJbosDFpipCjs6TQxa/ToEi2zMH3i7jfSaWeyjoUsaguH6EGivRwcsmdmUAcuvIw/eKdkiQ
 WC2jkbaaKvg4XG3tc/M4uEltabQyjbR+xBMmPPvo=
X-Proofpoint-GUID: EpcvorCuUrEjIj1Ep2VKQMjQZQabsgP7
X-Proofpoint-ORIG-GUID: EpcvorCuUrEjIj1Ep2VKQMjQZQabsgP7

A layout section with a large elem_sz/vlen can lead to a 32-bit
overflow in btf_parse_type_sec() at the point where a large
type_size is added to the next_type [1]; a sufficiently large type_size
on a 32-bit system could lead to the bounds check

	if (next_type + type_size > end_type)

not triggering (since next_type + type_size wraps to a value low
in the 32-bit address space).  This would lead to a bad value for
next_type when we add the type size.  Avoid this by ensuring that
the type_size we return from btf_type_size_unknown() falls within
the range of <current type, end_type>.

[1] https://lore.kernel.org/bpf/20260417170712.74E77C19425@smtp.kernel.org/

Reported-by: sashiko <sashiko-bot@kernel.org>
Fixes: 2ecbe53e0e991 ("libbpf: Use layout to compute an unknown kind size")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ceb57b46a878..d48ac5460d1d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -420,9 +420,11 @@ static int btf_parse_layout_sec(struct btf *btf)
 static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
 {
 	__u32 l_cnt = btf->hdr.layout_len / sizeof(struct btf_layout);
+	const void *end_type = btf->types_data + btf->hdr.type_len;
 	struct btf_layout *l = btf->layout;
 	__u16 vlen = btf_vlen(t);
 	__u32 kind = btf_kind(t);
+	int type_size;
 
 	/* Fall back to base BTF if needed as they share layout information */
 	if (!l) {
@@ -448,7 +450,13 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
 		return -EINVAL;
 	}
 
-	return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
+	type_size = sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
+	if ((size_t)type_size > (size_t)(end_type - (const void *)t)) {
+		pr_debug("Overflow in type size %d for kind %u\n",
+			 type_size, kind);
+		return -EINVAL;
+	}
+	return type_size;
 }
 
 static int btf_type_size(const struct btf *btf, const struct btf_type *t)
-- 
2.39.3

