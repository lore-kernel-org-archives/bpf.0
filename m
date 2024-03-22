Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9424383AD
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103136; cv=none; b=qrV1VtQiw0OqWvRtWqBJPYcgAQaoA9mMlDK0zVb6gDTavOuH/hTBe5S4R09JYJUNWvpZjNGwdLJv2XIW/RJomi3QLWgNXEkapJUfnsmWHtoFPP4t/mP7BSQtG2owO8hSDvN0sTfiWftrrgQ4QyBMVIYlApDipsUiVNkQmHzqpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103136; c=relaxed/simple;
	bh=qqP91XSh51BIJrqdIi4Pog3U9DsRqugq1R8Q0S13fmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+yHiBAUa3mXQjQT2jbhEtwG5tqStGrVULDeDgVYEOKGePEGl94W9kiM6jj0I6KRw5DRRR6WMVvfzO2jtgG7v6vOH60nSoIRXsf9ldGz9fGCkSejtbwA8drorHM2pGw6u3ELuuu0yc1HXPoCEBTCV8h5egKUuJNRy8X6Y0aToLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lzRZnPjy; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lzRZnPjy"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7Y7f0004098;
	Fri, 22 Mar 2024 10:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=95kFR1ZDAcCdth+OSoUTGekUCF2mugjaHHE1ba+5V/4=;
 b=lzRZnPjy8Y2AvBvS4a89ACdMV3EpFR1TpxYinGodkRhTegzEH+m/syYOUTcQF/RnyxQ/
 rDpV0iBwWsQiK6QEIk9XWzw35Zp6DC3bm1WVGududpLTRaG/WlUrHP/bauqCTspY+YGM
 ovVIVABHqwiHzCaZF16g9I69vSQiGFtYSNzIyqKV5HpQxBnUaEhR7LIu2CQt0DjggOwg
 WSJtzFxt7vNVN4hMUG+GP4LA2NT3ewg88iLijtuzJFhnpF1w1kfCrrEG7rWeFB/pUG4E
 EBV0Ln74wvKRlQYyETDzVOTR1BNzF9OgIDyaZvgmiEcYJniNr74pmOoejrreJPz8Sgdi Jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvk8tam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M90GOg014972;
	Fri, 22 Mar 2024 10:25:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2hd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:12 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kR030399;
	Fri, 22 Mar 2024 10:25:11 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-3;
	Fri, 22 Mar 2024 10:25:11 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 01/13] libbpf: add support to btf__add_fwd() for ENUM64
Date: Fri, 22 Mar 2024 10:24:43 +0000
Message-Id: <20240322102455.98558-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240322102455.98558-1-alan.maguire@oracle.com>
References: <20240322102455.98558-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220074
X-Proofpoint-GUID: ZHdoaxcG0hpI4G_z8nYnCE_C5d5ydpMB
X-Proofpoint-ORIG-GUID: ZHdoaxcG0hpI4G_z8nYnCE_C5d5ydpMB

Forward declaration of BTF_KIND_ENUM64 is added by supporting BTF_FWD_ENUM64
as an enumerated value for btf_fwd_kind; an ENUM64 forward is an 8-byte
signed enum64 with no values.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 7 ++++++-
 tools/lib/bpf/btf.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d0840ef599a..dcff6c29c851 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2418,7 +2418,7 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
  * Append new BTF_KIND_FWD type with:
  *   - *name*, non-empty/non-NULL name;
  *   - *fwd_kind*, kind of forward declaration, one of BTF_FWD_STRUCT,
- *     BTF_FWD_UNION, or BTF_FWD_ENUM;
+ *     BTF_FWD_UNION, BTF_FWD_ENUM or BTF_FWD_ENUM64;
  * Returns:
  *   - >0, type ID of newly added BTF type;
  *   - <0, on error.
@@ -2446,6 +2446,11 @@ int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind)
 		 * values; we also assume a standard 4-byte size for it
 		 */
 		return btf__add_enum(btf, name, sizeof(int));
+	case BTF_FWD_ENUM64:
+		/* enum64 forward is similarly just an enum64 with no enum
+		 * values; assume 8 byte size, signed.
+		 */
+		return btf__add_enum64(btf, name, 8, true);
 	default:
 		return libbpf_err(-EINVAL);
 	}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..47d3e00b25c7 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -194,6 +194,7 @@ enum btf_fwd_kind {
 	BTF_FWD_STRUCT = 0,
 	BTF_FWD_UNION = 1,
 	BTF_FWD_ENUM = 2,
+	BTF_FWD_ENUM64 = 3,
 };
 
 LIBBPF_API int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind);
-- 
2.39.3

