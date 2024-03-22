Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC7738DDD
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103161; cv=none; b=T/YlPC4RZGgU/LV8H69yyftEIhH+fjCXoZYiIm+eRPJoy0G8eEiyr+2fqZv3ieYvYJDoq9ee1I60saiBervfPSKRFGzbCAhY/zlzDkRG6rPYtw5ZV6NhRF+pkVyQd+V0BPkMgLkS8lBbGdWPzNLZWVKB9r54DVfWMnO50DHaeYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103161; c=relaxed/simple;
	bh=WTKyIE9kzxQrCsqDfUZovMhHtbG6Qlh9I538i44D9i4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZ87XaSlA2JjhfotBQZDxYhwk7Rr247xgQmnpnvALPETKRBWmELjxZe2uTUS0XWXlKcCo/aNSfEhdWUERCovFbY4PiwulfFi/mFoQ/h6b7f48iAPThpHVri5MMqwhMtMBUsETG3hZUd4KN95ig+rSl6lJ/ooIwVzz6CCt33OP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kne8Mt6f; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kne8Mt6f"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YXPG008519;
	Fri, 22 Mar 2024 10:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=dVTLdgupuLj2UdWPTpgSLMn04Pls10YR5cYe2eMWDig=;
 b=Kne8Mt6fqfWiAILGKttWFk5TNGD3jpZbzsf8PxpiYrcYSxFPQ/AY5PAxHJ1DzzPw/Lpb
 5+TKlUlmJwKwbSgXe+w1tugt7PIZtzAwK0BB8eCQHMSU47wl65vb2aXLxwmVXgeHnQcF
 lYhT8E5+VYf4BshHXkeYIllTWpPpBK0x9HMM2NPgRgC9QJPDqRRRKkGSytaYA1FMyh5p
 8E2oYozKvc21BEMKaQ4nTxTEtlTaKBqWJ0uaMEQgqBZsXLJvB4CqStS8MiOpq12UnEMr
 U+A2PbvIa8xkGxY5pmmQMvJwqpj+3ldIAoim1P2X8XEA1rZ8ibsK9aRtVMH6LRONQoOx zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvm8s62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9GraF014999;
	Fri, 22 Mar 2024 10:25:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2hst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kb030399;
	Fri, 22 Mar 2024 10:25:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-8;
	Fri, 22 Mar 2024 10:25:36 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 06/13] kbuild,bpf: switch to using --btf_features for pahole v1.26 and later
Date: Fri, 22 Mar 2024 10:24:48 +0000
Message-Id: <20240322102455.98558-8-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: 4ntLRm3uTJCfLY_ARYXtiq_IndzgfjTm
X-Proofpoint-ORIG-GUID: 4ntLRm3uTJCfLY_ARYXtiq_IndzgfjTm

The btf_features list can be used for pahole v1.26 and later -
it is useful because if a feature is not yet implemented it will
not exit with a failure message.  This will allow us to add feature
requests to the pahole options without having to check pahole versions
in future; if the version of pahole supports the feature it will be
added.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 82377e470aed..9694ca3c5252 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -12,8 +12,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
 
 pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
 
-pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
-
 pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
 
+# Switch to using --btf_features for v1.26 and later.
+pahole-flags-$(call test-ge, $(pahole-ver), 126)	= -j --btf_features=encode_force,var,float,emum64,decl_tag,type_tag,optimized_func,consistent_func
+
+pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
+
 export PAHOLE_FLAGS := $(pahole-flags-y)
-- 
2.39.3

