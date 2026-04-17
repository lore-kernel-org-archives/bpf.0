Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7343B47C0
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436262; cv=none; b=Xey3goaiVKAZTn9PlAMiNRtQPcMnWNsOSZ3TKyXJJTl9Qq80C+I+25xTw7l1DMVCqEAHd80V5XgBt1mKiWFszfLYTIch2qaNUivQsqvnhzpw2l/U0aFkB7WIKXwYHwucOe6BhdtM23agk2UwVrYxiO4wNq/nDEMsxumbk20wPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436262; c=relaxed/simple;
	bh=xs7ve6hl9+KsZZE7vItnWBg28v3mczQPY3BzdVl/3oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCVjtmO/yCVCkqJB4MmcGFcQOAZDPOcLRu4AveMX/QlrGs6gJmSpf7QKJP7VB73XOX40juVwaVuBYjoCubC/09bMGE1ALqf/5+vxSEQuoVUW26qnhx+S6mLN5hFrfDoK7kYiiVx8+7TC8/Bj4lkC0JtjzPIAyekDuGKUXNXoTX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ie7x28Ua; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ie7x28Ua"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HEEw3M3412536;
	Fri, 17 Apr 2026 14:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=7XaEQ
	qqMhadI6s9Ni8JK3JD9n2BbKdgZHQ/zpcwOWPE=; b=ie7x28UabSzmRkdGF7LTu
	fjbuepsTMa5Y0OvkPCK1tto4AfEn0FhB8v68ddGIiy9S04c7Xe5DJyYfdTshT0dl
	8HLBJfk9XM7p0TqjDRXiOQ5Vd2BvOi3cVA7esStoqoTdfTg61NSaZrtmOFl5AN49
	oGYuR4Yi7kOhZkWovJYSjhKjNT9UcHixfZ9O/c+P5aPLOC8hkzzrlbNDc2E3E/PC
	JJlsQWtQqLwbCqjk+zQAc5i6lDt593NiWgGOw2rwQxlV49Mao8sgUw4LuUTam+mf
	wKmIG2wjsCCcjOJQ2T0k9dewQTqY3r0Lr+XewbDy/sMSFNGrVGJ0TpcIdQ0IWpya
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh87mj05u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63HETQPu027250;
	Fri, 17 Apr 2026 14:30:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nrw8su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:41 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63HEUSt7033610;
	Fri, 17 Apr 2026 14:30:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-148.vpn.oracle.com [10.154.53.148])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nrw8f6-7;
	Fri, 17 Apr 2026 14:30:40 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 6/6] Documentation/bpf: Update btf doc with updated vlen, kind sizes
Date: Fri, 17 Apr 2026 15:30:23 +0100
Message-ID: <20260417143023.1551481-7-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=JKYLdcKb c=1 sm=1 tr=0 ts=69e24413 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=CkG-BbOUcEc6fDT2sdEA:9 cc=ntf
 awl=host:13825
X-Proofpoint-ORIG-GUID: e_xn8kDjBSoyyTHLiXveCqylNKns4_rG
X-Proofpoint-GUID: e_xn8kDjBSoyyTHLiXveCqylNKns4_rG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0NSBTYWx0ZWRfX44n5js9szfiz
 x+DFi8ThjZeqczB0LBlbHADYsSbge4I+uIWrkc+PaV27tjSUba2mI4lDq19wGqGoTzZCDKBNTX4
 Eg/dM4GS/KX0mMtDaK8PP97cbDiWcck11ZkBHeizqNPsUrTfTlkYUyU+MkBQmPojRwHJNEeEqx9
 ZcLBQtKeEd3L89mUx/FEp1i/S3bccIbSnfaTZw1vVDAF4NKmddxRmEngFsRB+0KwRIq36PPodh1
 AC8yHaHbxefL43GC2A5lTQNsutRcUDFIJsorW6WJrM6CjMON6cc1mQgaMXfWNpSMlikPkO+TNgP
 IWMxxUzpEdsVND4fUaQJ12t0yoaXRDc+nil8f2mnsSNZ8TCG6Z/UlDDSGVt+l6xxBzo+hMsBMD+
 +/ThzuILHTDzU3sratyELbXOc6F9rUGC1pdl2Sv6drbGmbEZYZGZJG/jUqv2U9MTcsIgaJlHs8p
 0QAbekxj5DXSQDvX4D+t8GmYsBLpiwP3PGRjTi/c=

Sync doc with updated UAPI changes utilizing unused bts for
extended vlen, kind values.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/bpf/btf.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 3b60583f5db2..3f05f17990ad 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -97,10 +97,8 @@ Each type contains the following common data::
     struct btf_type {
         __u32 name_off;
         /* "info" bits arrangement
-         * bits  0-15: vlen (e.g. # of struct's members)
-         * bits 16-23: unused
-         * bits 24-28: kind (e.g. int, ptr, array...etc)
-         * bits 29-30: unused
+         * bits  0-23: vlen (e.g. # of struct's members)
+         * bits 24-30: kind (e.g. int, ptr, array...etc)
          * bit     31: kind_flag, currently used by
          *             struct, union, enum, fwd, enum64,
          *             decl_tag and type_tag
-- 
2.39.3

