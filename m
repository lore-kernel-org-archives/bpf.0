Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5A37F8DD
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061847; cv=none; b=S12XgM+X3EIOFfYQTip8RcuAzxMarz4I+T1mwu3rlgayHvSjRAs+tuadHpZr3MvD6xnvY9Yk+xGZL25MZAoCJjU7E7xZUBccD1/b4n3nuZJwQVDsf35LT3w54zrEbuIDnt9Ay6QM0PYb+yxnEVED5NBcdg47AJoAOY5+WfOy0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061847; c=relaxed/simple;
	bh=6hA21pDoQVvhVbUahWGKheEhpABs3d3tP2t/DS5rQ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJPwnkZ6dDzAbJ8yNBqktk7qeR6yn1K74oIFF9JiqV1s+bYWICzjfDlfywFklEFyuKGoiwyNmM3vJBb7DZXFxb+65aBmlvGkxMmGTXXZiOLyVUAXPXwsy0Rk9GQ7GP9+VLAnFG2CJi6O5SKb9PqqMjQJjr1d+Ifwr6mhQ4dSEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cbwjvXw5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cbwjvXw5"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631ExRx61648241;
	Wed, 1 Apr 2026 16:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=0KiH+7M3ShNvAmvIIaECu7cqeWdsB
	qeCkPSPlXFPzy4=; b=cbwjvXw5e1wjk+MdsBu4AOV0CiYV4XxQy49Pi74C5csRK
	ViynKY6T50YEZ/rmldOBjYPl3NikP+Iwa5tVu2ugbCbmqEIwrDf7jtu4R/9ZIAxc
	ifqFQ2Z9fwW9a8IhKcv53Kuxp3/xXmMRCd+H9MB4FOvLy82De3YlefXi2S48P/M/
	LU8QzXLB/+lIxyOdH8xqA9b6puWA33onGgjPlK+2IP4mF3FrWHx7gJEAg0yNMW9x
	kyxLYmg7wyfX9Z53/ImaXoy1tqnoGNJWkiVQPCspVTMDYg07y9U2uQRk1MUvAAzs
	4sq9G629wq7t6r2o8yoEIz2nxyKV6gyCBZCJVXtLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65jwf0xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 16:43:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 631GMkvc027502;
	Wed, 1 Apr 2026 16:43:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65ebmfxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 16:43:24 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 631GhO19001782;
	Wed, 1 Apr 2026 16:43:24 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-129.vpn.oracle.com [10.154.55.129])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d65ebmfqd-1;
	Wed, 01 Apr 2026 16:43:24 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: Test BTF sanitization
Date: Wed,  1 Apr 2026 17:43:00 +0100
Message-ID: <20260401164302.3844142-1-alan.maguire@oracle.com>
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
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604010157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE1NiBTYWx0ZWRfX5idy68Wfn7Qk
 CAqMqDFpTjUUXKm5hlSUXBeSrRJrtSA2klTkA2454+Wv+oEUq+qhROFMFkwB7lTWsGzH82L2Ixx
 /P3VkhsGZODUOoikFRLLQRDN5bzZFbPsY4+qV2j0zeH+5i0sDQExIhPhMfQ844EfVLKy/N2ggLb
 EtAVhHCQG0iPrl691IcmctCtmX6OvqGYYQ4NxM/jqnkFHLzieonEvyH7p+cYjjqJMZ87Gj9cd0w
 i3+hloT32hS0REeY4SNhSx8mfCi6//8/Xp+777uTpHk+rYt7BByCIl7Ku72CEhMD0NLOMYIbHms
 3NmgzgPgC3VfS27r2coxoe1F2ZzYplIj3dWCnxdzTyZibiVYwe/xNPLCXCcEuHwjQ5meShb0R4i
 N0Feati2CHLynuwFEe5jPEpc6asgnrZ1NZP2VkavimgF9TCRYs2uCjdGxVEqgIgWTwf8aD+GlEj
 nYtzBqaZH+QerT6WK9g==
X-Authority-Analysis: v=2.4 cv=CJEnnBrD c=1 sm=1 tr=0 ts=69cd4b2d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=5tMHzNcg7o1aBuuBXRAA:9
X-Proofpoint-ORIG-GUID: IF0mwCnQxyDPRnaefJnjPmKfRK-BcLa6
X-Proofpoint-GUID: IF0mwCnQxyDPRnaefJnjPmKfRK-BcLa6

Allow simulation of missing BPF features through provision of
a synthetic feature cache set, and use this to simulate case
where FEAT_BTF_LAYOUT is missing.  Ensure sanitization leaves us
with expected BTF (layout info removed, layout header fields
zeroed, strings data adjusted).

Specifying a feature cache with selected missing features will
allow testing of other missing feature codepaths, but for now
add BTF layout sanitization test only.

Alan Maguire (2):
  libbpf: Allow use of feature cache for non-token cases
  selftests/bpf: Add BTF sanitize test covering BTF layout

 tools/lib/bpf/libbpf.c                        |  12 +-
 tools/lib/bpf/libbpf_internal.h               |   3 +-
 .../selftests/bpf/prog_tests/btf_sanitize.c   | 103 ++++++++++++++++++
 3 files changed, 115 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_sanitize.c

-- 
2.39.3

