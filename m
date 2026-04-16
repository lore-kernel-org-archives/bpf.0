Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77FA3CFF44
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350408; cv=none; b=sty8pM3dvlWVxtW6/s8gMf4x3YXiSghIQMR1/9Av+0u4uXDBQHUynjpytS/4NnWAENUQ9pBo3gOvEJoFgGvkssBOdvYMWiYKve+TnUv2SLCrvNtgLgkXSWkz3Bq5o4+cjuyoajpcNqijsUB2wFFoUR/TCMoxygcaIHJ2QeA5PhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350408; c=relaxed/simple;
	bh=xs7ve6hl9+KsZZE7vItnWBg28v3mczQPY3BzdVl/3oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AowRX7veuURxOy/e3q+IBio3BS2qdlRzMaIpoF0+4pyplG1+sxjabWjBG9qxvEjEOrO/QMPiMPRiJaUZtVttBfzAyzRO9YHrjDRn3Y5Jsk6q8dzGbSZC7KMVOkZ5JTKyzmCPGErIiaH41D8sud1dKuW/jF1EYMqc89LhC/pLrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NeSzOaWD; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NeSzOaWD"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6bHxw4004966;
	Thu, 16 Apr 2026 14:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=7XaEQ
	qqMhadI6s9Ni8JK3JD9n2BbKdgZHQ/zpcwOWPE=; b=NeSzOaWDK7gHB3AY6vT4l
	Gn02FEaZ/LHvTgAkbmFAIolgAMza7Qf8NTMSQO7H0i6yJ2lyUQQ9BXAlM/H9XB8U
	vQNFRj1hW01LpQ0wgy9OY7FGnsAp0M7jSX5htqZDspTmvuxQGoAdZlTqBjibMfOm
	fWqfvFFzV7SbnLtSyOWGm8VSgGvQj10XWFJLd0SVdtzD3/egZieP/pVTlCG7IdxT
	0TxcgvhJbmMohJRkXYx5BKpVghWqDzVQon+jDRVUViyLt1QXOaPVgx45QlUccUrz
	Hdabp5IbumoYnGeBALOGAAcGn3Dlad/pHAW+r1M9VlGQ7wqLzfgeSnVobOiTWXhK
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh867fwta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63GEdRlf017791;
	Thu, 16 Apr 2026 14:39:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nqkmsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:51 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63GEdXaj018534;
	Thu, 16 Apr 2026 14:39:51 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-74.vpn.oracle.com [10.154.52.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nqkm1k-9;
	Thu, 16 Apr 2026 14:39:50 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 8/8] Documentation/bpf: Update btf doc with updated vlen, kind sizes
Date: Thu, 16 Apr 2026 15:39:04 +0100
Message-ID: <20260416143904.1220662-9-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0MCBTYWx0ZWRfXyAa8qOJTPQ7e
 XloMGuYTEzccnW8WEdrKO66vm7rBu3Q566vE0Fal8KYnauXa+m1pIxPS6+TMjWWueuWHPl9IYhl
 i1yS1h16vi5qLOlVBdiTTwtpgSWiSC7S0auXn/VpqVnVDOKlAAGiDZwkN/XC0O5ImygW2WhQ0oc
 7Jir0o/hU+TTZKt0LHiJ4sWv1bjtLo+qY3p/SL36wED+7wSheTvZ3miXZyptXsoDzAAsujdPXum
 7T3hxJ9G0lsrf0zoaQ91ziakfM23uige1A/H7/fESbvc+WLsJu49YlINKTt0Tf2lTyX/+P3k1t4
 DG9Ik+go6NXNsbCnvJOe4Utkpe5VQevX3dstxttTGKgE90eWt4Ly1r+5nFGI3UC8Lki80g7/kYx
 7rh/xsQULXt3ikT4t+nbCXLnG/WtzlgVtw1E8CoNzbxiM8j7kfKr52ZZKFWNKa9wzlrrrwbhG8/
 0HwR95OMiIUPzLBV6lxQT/5ikqt3h36d2KSxFVsg=
X-Authority-Analysis: v=2.4 cv=cbjiaHDM c=1 sm=1 tr=0 ts=69e0f4b8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=CkG-BbOUcEc6fDT2sdEA:9 cc=ntf
 awl=host:13825
X-Proofpoint-GUID: BMydZEXXyNkNEzpevNYxHeQbOqprUb6E
X-Proofpoint-ORIG-GUID: BMydZEXXyNkNEzpevNYxHeQbOqprUb6E

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

