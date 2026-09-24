Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645402F6586
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248525; cv=none; b=WwlKqyOZkOIZ4z8deroDqanYXuV9CbSdjXYfF8L8R0X2wQSmYE2Gq8tjpjYtIgHH5PjkIPDg6YQqAeBddd92uBz7lSQHcACv1ul0ETqzULJgjegJti9UdhwBUWjekDy0sKKeYV30/XfWdXSx9sZ5+rkUV5TLHgAp0i9mRV3nVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248525; c=relaxed/simple;
	bh=uEyLyM7JOIF0L66SkoI0QwRgb7QvQunc1kaTwMsm51w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ia2PX9S+3QMLVIpTAZu851UMz8eE57TD4xd7cz8JfMxG9OgvhHUGjg+O+A4JIgio3Y8Nl9bIjztvJtL6RG1SZBXDGCpbyrEAIUObFYHu1ijCaQL6+7lFKyq/BqomvcE0vAN9sG5pJTi5xt+ilGu4aBR+gS5VS3/CZHZpu8axKqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qHn10R7/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qHn10R7/"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6CWxH1403713;
	Thu, 24 Sep 2026 11:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=uGWf2
	TyoYr/+y412y22pBb0/oX79OsWYVNwCZYM5Ntc=; b=qHn10R7/NfGM2HZo42H7G
	uJUPXRZ5qr9QV5FQVFLiaMybd8jrlKbnvypKiG6CYxjiUaBzM0i8xVT2uKoP0+9s
	z0uSFxhrdWXtEMM433aLxpMsIVQlGcI32C0md2xmZhyTUu1s49KkjTLw/QAsTgc/
	BnxjI155BTOmqcdv4QW5jD6ktQlryt58FqUrYbwew0RCzDazyH4iqJs0oJ/thrUq
	U6gQZVt/9qD8tEkdRhzsG0uBnRRi4eDCqvHO+mJgvBpcBYLiUBuyE4ndCRBaJ28e
	GIj7e3hEBzJlaO7HYvzE4wzNhAdL6TSmkGHsxCBe1NSbvnU6kd4fvV7/94M67l4v
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0h7fe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:15:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5ZeF013184;
	Thu, 24 Sep 2026 11:15:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119m66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:15:00 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVuL002821;
	Thu, 24 Sep 2026 11:14:59 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-9;
	Thu, 24 Sep 2026 11:14:59 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 08/11] bpftool: Document support for multi-split BTF
Date: Thu, 24 Sep 2026 12:14:25 +0100
Message-ID: <20260924111428.75957-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260924111428.75957-1-alan.maguire@oracle.com>
References: <20260924111428.75957-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609240046
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX+kYu/rLY7a+k
 f42XZI90fxschhTTci5PpITUb8AG9K2Gx4TCBdEPkK+ntfjI5n9Y+wcULoeMjuVbSDsirf8Gg0g
 8UKsOyDq/SUiT4+gWzovb1auPq7+wnQwyzuMhh5q2g4D9p4/Hj1K
X-Proofpoint-GUID: dhGt7mcwuDlytt2WzOYDLsEFl4-r0Uhh
X-Authority-Analysis: v=2.4 cv=CNa/zhrD c=1 sm=1 tr=0 ts=6ab50635 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=R5OYlE61gfEZyGkII2oA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX+mtLD+Gzvs3w
 0hbP44zwzCd22gYKrhN3atdTQoVro5Bq+ZShAMdFxaXZIc2dKF/zvDk+dvlzmHwn1zQNmRvyJuz
 zYXEZyz8QuYPTVlzZm8RK0SK4byboodtqIO7pL+V3gmeAFeflD2VctsTD1FlHV69SIuFuGAWF0X
 pceDzpi2irxtSIkUMbMupQNZ1UJq8kOHrbH5UBPsm2thRmWOnWG2cHchye+dVS2sE0u3HuTA/+B
 poZ/WV4DeUjuIl7ZDZGCBvMzWOynrF6tV6om9yu/MIadEVINLaZnICCDGivGVKUGqh8YqZaD/uW
 YZiJtvC2NGNgjK3E+hIqVP/bRwtxUXAXaGei4OIQ06v6xy53CSk4NTpSAT7radTRM+v8gCHoTNq
 eK3TQeTvcsojCj34M14dEeaBtjMPC9hFyePSQMxa3vDxBxEhAMXdpHi3in3ZM02Y6PZlEZRv8rZ
 YKzyraEMhw9hbBHzqHYMBQRJul8AxlD5hsyycbr4=
X-Proofpoint-ORIG-GUID: dhGt7mcwuDlytt2WzOYDLsEFl4-r0Uhh

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

