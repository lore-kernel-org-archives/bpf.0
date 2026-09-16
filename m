Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A4459ACB
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544555; cv=none; b=FWvz2EPr/HtA9+egpK9bcm3Wr3BBvsAwxMbBiG6zl9X3EhM4y8ROTsrsLJy6W7fK/8aLx4ML/EAGt5A81Qe9mXZS0Cxl2aQG8ly7X632FF7Z+NEwFD1XB34lceTJl6XUl89oRQlQHuEFM/P3semrOuScbgCcnXmclYkGo6I1IOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544555; c=relaxed/simple;
	bh=uEyLyM7JOIF0L66SkoI0QwRgb7QvQunc1kaTwMsm51w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lawgqd/jSiPDaE2rSnPihz69G1weEfU5XE1++eTfBPMtn8xurCJ4ygDuytqC2aDx7P8ttSUN52F7nH3LgfE9RZ/9WFNKiyz6bm0swStvy9H/biiN39Z1Xl0EYbKb1dQI/cQTuw1mFd3vZ5p/SOWoPMDvgIubczWA8c7KonZQS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TfiJiKlA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TfiJiKlA"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLXlQB525741;
	Wed, 16 Sep 2026 07:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=uGWf2
	TyoYr/+y412y22pBb0/oX79OsWYVNwCZYM5Ntc=; b=TfiJiKlAO1qK+Jw5MDxdY
	rO9GZrK86B/89MvtCDsWAjFUGSOmxkg9FrZib3zNPIo+k4PQkg4FnkQdsGReQ0kT
	3MT1jYxGaaat0dTUlFRI6HmD05R9W76FjXqdyLK5YHOEKEOO7q3CfmNupg4waKwH
	KO2Gfpq27SgH2sYakDgirb/FzMFOJ3+UXgwmBWVTckZ78AREZm7Hy19ElngeSVbD
	by3+lUdwITJIYleGRG3kpnIP0GO148zMQROOi6Cquf8OD/kv03v0kYalatwyIOYF
	DXgHD1Sm6XYpo4F7bxA7yazy2u0QOIFuWaP/ADWcc3hqOyaeh4H0qZf6e6FktFkn
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmy9rw28q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7e20p014696;
	Wed, 16 Sep 2026 07:41:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6au556-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:53 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68G7exPv020284;
	Wed, 16 Sep 2026 07:41:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-86-81.vpn.oracle.com [10.154.86.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gmw6au4u1-9;
	Wed, 16 Sep 2026 07:41:52 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 08/11] bpftool: Document support for multi-split BTF
Date: Wed, 16 Sep 2026 08:41:15 +0100
Message-ID: <20260916074118.1007116-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260916074118.1007116-1-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609160099
X-Proofpoint-ORIG-GUID: n2HAOC8vKbWdjrnrvIu3GN4lPEzbFmDz
X-Authority-Analysis: v=2.4 cv=MuvHeGae c=1 sm=1 tr=0 ts=6aaa4841 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=R5OYlE61gfEZyGkII2oA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX4haWlLPMtaLf
 MICywEMuQpyg01YAQrFhIUJ2AAovfXIYCeIKvlz60d6xW6HvbdypdB/MMFGGJ6YYpmGlMj87jiA
 U2p2abjbYu1gAtEP0ci7DDYRIqkcGk63uFpVbUc8OGU/rFlPSrQ4
X-Proofpoint-GUID: n2HAOC8vKbWdjrnrvIu3GN4lPEzbFmDz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX3Vx7hjKt/BgM
 sgYOrIBRbNJclKEHu47gYr/r79a+4szG8cISRsSyocNoBgbDog6ittMcT9yN8e9brzlO1Lh40Y3
 LWm6zHNakj7ueJZbidFgRCRq4TNlGqyyWqWj+4T8jbsW3BxCL2pVB8IwpboggM78regMJCAuMN8
 5knz2OlzTNKCuAx24GVgWygVgAvI9eynxo59Dpe7IgvmDD4C8iMV+q+PTole35Q/uktmrEB1FgL
 aZJA/XrNercRlDsTz1ClvQUpB+2si331ypq69jTO1N8ORJTN9LuNz3eC9VKomeHTprQMhSPhVNZ
 sc1Ub+MKtzJC8+pO5LeYevv1kI7jLKi439hm+sVQceSCfIJ7vmtxuB4p27RNPbNHuCgTtc0aFCA
 zNwODN+t9S74DWeAeCr1Upc3mtJgEv3aA2VIm3nTWghhnCWAKH09dcLW/m5QQ7rgFWM1kLK0vlA
 uPsMVnOrZdVL9PtfBzw==

Document the ability to pass multiple levels of split BTF, using
"-B base-btf" options.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index cf75a7fa2d6b..c6dc445cd4a1 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 
 **bpftool** [*OPTIONS*] **btf** *COMMAND*
 
-*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } }
+*OPTIONS* := { |COMMON_OPTIONS| | [{ **-B** | **--base-btf**} *FILE*]...  }
 
 *COMMANDS* := { **dump** | **help** }
 
@@ -87,7 +87,10 @@ OPTIONS
     objects for kernel modules. To avoid duplicating all kernel symbols
     required by modules, BTF objects for modules are "split", they are
     built incrementally on top of the kernel (vmlinux) BTF object. So the
-    base BTF reference should usually point to the kernel BTF.
+    base BTF reference should usually point to the kernel BTF.  Multiple
+    base BTF objects can be passed, where the first is assumed to be the
+    root BTF, followed by split BTF based upon it, followed by split
+    BTF based upon the first split BTF and so on.
 
     When the main BTF object to process (for example, the module BTF to
     dump) is passed as a *FILE*, bpftool attempts to autodetect the path
-- 
2.43.5

