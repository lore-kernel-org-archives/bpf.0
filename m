Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DAF3EAC8B
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356180; cv=none; b=IMGqkmPwNGLHCR/dyOngbEyg8j59s9Je0boQeJI6IF/yVzMWQZBH9pJ8SL0ypCk6XXE/1oLsrllU38tCe5BnNttzCMCgcqalV9JfMvrEyTRaQYdSipx55ZSqk+a6/T+II9ssQmLozV4ff0yebELvqnXBba2Gmi09nkYO+Y0WdSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356180; c=relaxed/simple;
	bh=6MY0OlFBwJa7KIJ0TbBIHToHsWd80ykp5iG5n8xY2Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2FlWek55y4A8/d5fdAIeeyl/gW8LLyQIgZFZOQG62jWt2Nv+cUp9V+DhhZXsQds7q7gKHY+Z+CR6pS4WJvgT03XzLGmc/KTYD1E37jTrOO8Piz0x5FyuJKZekxoVQ8M4qNC6FjZvBbyR673lwAEQH0+oHaMw31JKDluSOGGl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kcWXS2we; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kcWXS2we"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PECB343838108;
	Fri, 25 Sep 2026 17:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=eTCt0RVxKFk0I1Siwn9NuMm/YELMs
	ohoREA1CeghcSA=; b=kcWXS2weKeUNG5RSmdW5wV2LiNkuyIvbFQSO7LiMWy/SJ
	vwlkM/AZ3klgezaj9yBhb541PZ+o6XkQa4yl4y0D2JldIz+B+Z4aCyR7NvLiIoIm
	ftPQuctSgQUzsooLegPts7w9jveirmusNKtHm2I4epX0Gc5NQUvof3+KpfiXkpTz
	i9tDshbc/Fslz9BY+Z4CSn7a7YW0CiEGMQRTYEddeCW5cZAlPxW4yWX2mllic+F5
	V0/R7073GhwZyt3cp+VsOkmIXtPXDHvIg/aKS8nwI/zoXnd8Ab9yBjsFyVn5pyBK
	0W3gKkGcQHg/vet0pY/PBahxHQ2s820ZMh7JQwKmg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1qhs8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 17:08:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PGa2b2023120;
	Fri, 25 Sep 2026 17:08:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gteptetxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 17:08:58 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PH8v8i008030;
	Fri, 25 Sep 2026 17:08:57 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gteptetwn-1;
	Fri, 25 Sep 2026 17:08:57 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 0/3] BTF inline functionality followups
Date: Fri, 25 Sep 2026 18:08:51 +0100
Message-ID: <20260925170854.1240637-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250066
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2OCBTYWx0ZWRfX7530wWRV/wIq
 yi3vZ3p1nsZurwWyz5Hz6/NppEDTL9Ot5o7Fvl2SDE9ZvNH1oBa7OyhUThfPkCtUxvNS6SIgeRx
 MAfnaKAQg39ZA0nMbylgnqW7i9FVnmR6ATuhvVxMNgZJPAo0knE8
X-Proofpoint-ORIG-GUID: ix0Vx6aYlBXmlwkEaXPKDBjaEo3ADYqr
X-Proofpoint-GUID: ix0Vx6aYlBXmlwkEaXPKDBjaEo3ADYqr
X-Authority-Analysis: v=2.4 cv=LIzz05W9 c=1 sm=1 tr=0 ts=6ab6aaab b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=JyK6LxnfyLyjze5ABqcA:9 a=zZCYzV9kfG8A:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2OCBTYWx0ZWRfX5ye1XOGv7MzR
 rwUqurX2lUab9dHNUAQqp6Ql82B6YpPY52YJrKMhpr+mvuYQPNdnRbabofUoZ47MdfddoWfndQm
 Y6N7/U8C/dfCJ8l3PQgI8dWPvKDtGW55tpbvhYCjsk8kf1QMzB9javgTM3eQJivJSGHHavNf3M3
 OJ3maJxIKgFmzomRDIx7t0d3FcshuKxWeUz4i3Bd5fHdWt/oMNDGt/U+VlVpNkZsKh52Iv90BI1
 F79RrmL1XkO6rH3Rc/0ErEju9mCw3ABNz2vCkO3iySfnUkh4rSau6A0pj8cRZK1ENdGk9nEee8y
 9yQ+2FBoCtQw7zQ/l8gq+yw/vdkOfXnis9WHErzKnljvPhkmB9jU4DYn6kN3kQXJTuf7JB8PjS/
 l+1PSsH669+Mq7P4Gu/gN6eYRDXrAEk5QqQzREM/XlSe1vytmMylTKWBVW91hYi2AZ5ljgDvtBW
 4cM4wpLkMUP5pKg+Vi+W1taPFWSRSa4E3JAJyMGg=

Include additional vlen/flags verification for BTF_KIND_LOC_PARAM
(patch 1), and add function signatures to LOCSEC entries (patch 2),
adjusting test to cover these (patch 3).

Changes since v1 [1]

- Fixed sign to appear after const (bots, patch 2)
- Simplified loc printing to remove vsnprintf() logic, updated
  to retain name in json (Quentin, patch 2)
- For oversized signature strings, append "..." (Quentin, patch 2)

[1] https://lore.kernel.org/bpf/20260925095231.879708-1-alan.maguire@oracle.com/

Alan Maguire (3):
  bpf: Verify BTF_KIND_LOC_PARAM vlen, flags
  bpftool: Update func representation to include function signature
  selftests/bpf: Fix up bpftool btf dump test for signatures

 kernel/bpf/btf.c                              |  12 ++
 tools/bpf/bpftool/btf.c                       | 118 ++++++++++++++++--
 .../bpf/prog_tests/bpftool_btf_dump.c         |  14 ++-
 3 files changed, 129 insertions(+), 15 deletions(-)

-- 
2.43.5

