Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5533B9D8F
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645635; cv=none; b=NycD5LMxYTJygJ705fLDs7WJEtV+TlIoHy9gi75xILOCpu0HzQ0Y0z2v9P2lqtpHZIcEA8vBCEBUdkLREqTIW+nqnNhXHicqSornos+5P71YS2gLoGSLRukGEfqd3AWEfOpsY5RZbdwJ7lagl/2JSoloaZuPfhTzfZbxIcPKyJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645635; c=relaxed/simple;
	bh=5YEpZROMHbATD/yuItakR5LapubKcCqhhooOe0EAD6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZKVpIUfBqMyTDQflx2hjjHoeu0yq/nzCkkBqXP12OsqK8Qac3cukFweDQNSGmkbGJIvdujQQ7DHpot2oLL2yzoHxUWef41G9f6NXSpXHlV03aCSKL7iQ8L4i5hlUbtU9Q3kMdS/DkV174qpKoCoDeLdzpuRgaulg0J3RoxRaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BA4TtoLC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BA4TtoLC"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6384o2aV3396241;
	Wed, 8 Apr 2026 10:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=FvyJOxgzBW6dmQMprOCW1kDcnu26A
	An+akS0AmFBl+A=; b=BA4TtoLCtKHnCwbjJCTnQXrNANjrxgdpxOE06J8+mALZ1
	xTNCssLfyNc/E6ERl+K0dfaPd3zOryKAyC077jomMKKISFlM1BEDaoZhiolVUdGk
	kr5m2/7XQff1TeJOqtezSlTzKhJED/DPkdel06rPZ43ULj+Lq7o05gyjBhBq59wi
	Mi4UFm6KRQA8vE7NeuJOBkLSuYzX9wt6H34dtfTXZjT7hqqrWgoTcEh/bRFXP0n7
	7SowaCSLivnTtWYJ+nYN2fX8V+vvfNzhCdQdGd7eTbPta79kt9weNnFWnnXk/r2Y
	OeObNjzleh6pwmhyRGcfB+BhEMiHK5Nibse1SPUgA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqa3c1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 10:53:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6388v1it011613;
	Wed, 8 Apr 2026 10:53:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmnrcsme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 10:53:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 638ArW9s039263;
	Wed, 8 Apr 2026 10:53:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-223.vpn.oracle.com [10.154.55.223])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dcmnrcsgj-1;
	Wed, 08 Apr 2026 10:53:32 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 0/2] selftests/bpf: Test BTF sanitization
Date: Wed,  8 Apr 2026 11:53:22 +0100
Message-ID: <20260408105324.663280-1-alan.maguire@oracle.com>
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
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080100
X-Proofpoint-GUID: yHH4hU6jY_iSAlnn8DNqLntCUKke94DN
X-Proofpoint-ORIG-GUID: yHH4hU6jY_iSAlnn8DNqLntCUKke94DN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA5OSBTYWx0ZWRfX7NzEaBf0iLzw
 M371jzfOSDczco3KA9ghDG3iThVHwF6N1GdIZk/UpUZvvEVHcaFZhtD1leUP+7lrPDPj6WiISHA
 PDQDcyXDsOcQ0SKZ4zjwHxM5FMFHCjMiuuWUI8o5tFLaJ0qT9o0Pw7JHLkxkNNk/GVWopJ0W+f9
 DOs0D9C9+1NgDm02OCXL8etRCg3SQud6ISwXVN9clMFXx0hhHCfBND6QTuJcysttZ9hXlwJL1vi
 6u9XxylXmwj/ip6pWFX364Uc5eQ3i/8S64PRbF3OFijRLSqEi6ymkZnAT2B3E0hHP5QLQe/ivYo
 4qZgaei2KqHkG8ChlH/ayVPT++Im5nmd/nRQk9Dzdw2N/tZBqPyXtMAdHeE60JvkpJGXnCNKsB/
 Qts6q76zefGmBy+o+/fUqc502xcDeF6X9oOyS2dpLBNGpe+w6+8v8fLSB+GQLForzptmccrTjuy
 0B6m/R++iqpsqLm6ISw==
X-Authority-Analysis: v=2.4 cv=DLS/JSNb c=1 sm=1 tr=0 ts=69d633ae cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Or9Fqr4EmitJTsuk9qIA:9

Allow simulation of missing BPF features through provision of
a synthetic feature cache set, and use this to simulate case
where FEAT_BTF_LAYOUT is missing.  Ensure sanitization leaves us
with expected BTF (layout info removed, layout header fields
zeroed, strings data adjusted).

Specifying a feature cache with selected missing features will
allow testing of other missing feature codepaths, but for now
add BTF layout sanitization test only.

Changes since v1 [1]:

- renamed to bpf_object_set_feat_cache() (Andrii, patch 1)
- remove __packed, relocate skeleton open/load, fix formatting
  issues (Andrii, patch 2)

[1] https://lore.kernel.org/bpf/20260401164302.3844142-1-alan.maguire@oracle.com/

Alan Maguire (2):
  libbpf: Allow use of feature cache for non-token cases
  selftests/bpf: Add BTF sanitize test covering BTF layout

 tools/lib/bpf/libbpf.c                        |  12 ++-
 tools/lib/bpf/libbpf_internal.h               |   3 +-
 .../selftests/bpf/prog_tests/btf_sanitize.c   | 100 ++++++++++++++++++
 3 files changed, 112 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_sanitize.c

-- 
2.39.3

