Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC163B7744
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288954; cv=none; b=EPDnSASOPBZv7qpYG7Xnr7wAyHrxvaAQWDVbnfF1ZPGEzLNMr5WO/zCNJ+cAVYB81EH2jzXVHVtJiCQzbq+ZnxvfOrEbn936FmSSBe9fvkUjy7DGss1hyj8a9B2VEs51tnfRDwnpFM91frKyi9wbaEH3xdzRKLSnzCUJaJj2MwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288954; c=relaxed/simple;
	bh=e5BDjBkk6hN+wS2wyPlAXexkWE/LqRl0Q7K5R3SlZVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2bVGOczjg631bLwUMKIqq8eyY7msDWSplNXfpHzQ2JvFxnyOlEkHdoj8BQsSbUEy+O+KQVbpjBmvotu5LEQS7YHeifuce050Cn6J0SoX2hLhwyhmg/9n7QaY8mrvnSN7QGPPtvr5sRxKXWWLI21KKfXhK8S8HLc2VqFwRZqUnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yc2GBfpO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yc2GBfpO"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QN1gHW3976211;
	Mon, 27 Apr 2026 11:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=kraTfu+hNhPMXHZCR6NAIJxqsm3kw
	UJfShBfduEStzU=; b=Yc2GBfpOaYxBeo09H9DA0diex4m5CxfVG58UkWou7rkq2
	9lD/0FdezsJ06W15kpEOT1aVbx84kwH5HrjNmWRZX0XMQygQyou/hxf9P+mXhnvQ
	wnCYFzVyCci6A22JZxvkc56RYHHzDPe49Tlrx9oCIU9xldy3S6ooLujmA6dE8CJn
	+TittJqu8uCyM2nsSFrYKXTLWHUxRsgp1LTDBgpf5/NBIfVHY3n6IIOxnFKB0a4S
	FMrmKUsZCeJ46FKKejh1s6681Jy4QGK3xoYdG206bzs/u4j8lkdEB+ZMkAcvluxo
	9FnZ2cxQJqW0YnLzrWbFHU5KZjQTKeh4Ud82nW/+Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drmha3026-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 11:22:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63RBGCik000309;
	Mon, 27 Apr 2026 11:22:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4drm2ba0w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 11:22:08 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63RBM8Rs017402;
	Mon, 27 Apr 2026 11:22:08 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-253.vpn.oracle.com [10.154.55.253])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4drm2ba0uc-1;
	Mon, 27 Apr 2026 11:22:08 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, eddyz87@gmail.com
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH bpf-next] Fix undefined symbol references for module build post cnum changes
Date: Mon, 27 Apr 2026 12:22:05 +0100
Message-ID: <20260427112205.1346733-1-alan.maguire@oracle.com>
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
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604270120
X-Proofpoint-GUID: BNdkXCY5DUi8XIjNG0kbCKhxMKUWmdLY
X-Proofpoint-ORIG-GUID: BNdkXCY5DUi8XIjNG0kbCKhxMKUWmdLY
X-Authority-Analysis: v=2.4 cv=CrOPtH4D c=1 sm=1 tr=0 ts=69ef46e1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=E8BEIxguf8JJoQZKz2gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyMCBTYWx0ZWRfX3xWNmkJFOUCs
 OAXcVEIkKduqgOhpPL4d6bszv3G4pTwd5Vnh+Zlu3JpZKB6Q2r4HCJespcC+1rrhVkGr4qUoTit
 UP5IjeHQedmCMHS/FeElQ0dVVtxglei51l4gteNKkwJZa2GBFLKX2aFgOUMvTSPYtFcIm7dgocL
 00fsE/tWTBTP2V6vtfveIzKEFyvOEjAvU1rbu+03q9SCfS/+1DR8R5sliohrmDEP9UQ82Oa/r1n
 FoiQA/WIe2PaDbFrlEq92dY2t5yuuuLen5X0odw4BcZWuZE4IlUsUeiabW9aPSwGLCc99MK3ftV
 aDkyMbWwMPd0wahYbnoSBN6dzQ9ULjy9FBRhkL2O0EnyDwBe9gCM//s75BTLkNp3AvZSOLYGUYV
 thjffVAEN3fjzhPnwJcOYk4WOIwMcODyqAftUreM4f/R97m5H1W8gRiUq9OWukVD21egIVhTc13
 W3zb2BRENnZLMG/oLWw==

Seeing the following on bpf-next:

 DESCEND objtool
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
  INSTALL libsubcmd_headers
  MODPOST Module.symvers
ERROR: modpost: "cnum64_umin" [drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!
ERROR: modpost: "cnum64_umax" [drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [bpf-next/Makefile:2089: modpost] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Further investigation suggests nfp indeed does pull in those symbols,
likely due to references in include/linux/bpf_verifier.h:

static inline s64 reg_smax(const struct bpf_reg_state *reg)
{
        return cnum64_smax(reg->r64);
}

static inline u64 reg_umin(const struct bpf_reg_state *reg)
{
        return cnum64_umin(reg->r64);
}

...

Export symbols for these references.

Reported-by: Kaitao Cheng <pilgrimtao@gmail.com>
Fixes: bbc631085503 ("bpf: replace min/max fields with struct cnum{32,64}")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/cnum_defs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
index 3ebd8f723dbb..7d992ee6a8a4 100644
--- a/kernel/bpf/cnum_defs.h
+++ b/kernel/bpf/cnum_defs.h
@@ -6,6 +6,7 @@
 #endif
 
 #include <linux/cnum.h>
+#include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/minmax.h>
 #include <linux/compiler_types.h>
@@ -23,6 +24,7 @@ struct cnum_t FN(from_urange)(ut min, ut max)
 {
 	return (struct cnum_t){ .base = min, .size = (ut)max - min };
 }
+EXPORT_SYMBOL_GPL(FN(from_urange));
 
 struct cnum_t FN(from_srange)(st min, st max)
 {
@@ -31,6 +33,7 @@ struct cnum_t FN(from_srange)(st min, st max)
 
 	return (struct cnum_t){ .base = base, .size = size };
 }
+EXPORT_SYMBOL_GPL(FN(from_srange));
 
 /* True if this cnum represents two unsigned ranges. */
 static inline bool FN(urange_overflow)(struct cnum_t cnum)
@@ -48,11 +51,13 @@ ut FN(umin)(struct cnum_t cnum)
 {
 	return FN(urange_overflow)(cnum) ? 0 : cnum.base;
 }
+EXPORT_SYMBOL_GPL(FN(umin));
 
 ut FN(umax)(struct cnum_t cnum)
 {
 	return FN(urange_overflow)(cnum) ? UT_MAX : cnum.base + cnum.size;
 }
+EXPORT_SYMBOL_GPL(FN(umax));
 
 /* True if this cnum represents two signed ranges. */
 static inline bool FN(srange_overflow)(struct cnum_t cnum)
@@ -71,6 +76,7 @@ st FN(smin)(struct cnum_t cnum)
 	       ? ST_MIN
 	       : min((st)cnum.base, (st)(cnum.base + cnum.size));
 }
+EXPORT_SYMBOL_GPL(FN(smin));
 
 st FN(smax)(struct cnum_t cnum)
 {
@@ -78,6 +84,7 @@ st FN(smax)(struct cnum_t cnum)
 	       ? ST_MAX
 	       : max((st)cnum.base, (st)(cnum.base + cnum.size));
 }
+EXPORT_SYMBOL_GPL(FN(smax));
 
 /*
  * Returns a possibly empty intersection of cnums 'a' and 'b'.
-- 
2.39.3

