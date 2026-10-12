Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35A42586F
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814044; cv=none; b=Wbco1TT3sUQm81IGbWMycexzm07vr7FnkGM+zJKmFNTdF+Vy5ToZ9BIGAAI+qcl2/xCEV2EVIJI/2c7UvCqvqdkOnQmFzX2w6L6EZHi7qrkYjPkhiNoqmESO+WuC5KCkpgfMkjBm9/cXvEe9MlsLpAFdxCduZCjRABu0+f/+5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814044; c=relaxed/simple;
	bh=5sVfIdKCIWVcrcOKRs5t6HcN6Byw4w3c/K+sXpEwl4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7HgzO3hyGZhsPO5T318dmu7LMahnRsdKGjwTN4tgsbLr6Y7PDVZIx5I+X2DdLQG7HKPPZz7EDJ0DnXqDOVk8ckUv1VMrLmq9v5qZzZCIsELD9hRa4hQp1QC0QydIlrRe9sUv15BV76BX36NiP1mYiDKT1LM3iyqciV2bfvcswg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CU8SEM69; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CU8SEM69"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCieKI1832792;
	Mon, 12 Oct 2026 14:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=iZLQd
	HeC3wChB7qjMRwzKRJZ0nMxXKDxssI5t53aGKA=; b=CU8SEM69K4btYH5wCujV/
	6f+aYJTfH+srDv2300xJOajZipI8f05OCWm39OXabovsl11mdUk9u/GTJ8eaXrk9
	qoVp3OBtSHz/ntcH+s7Kw/f0ZJEvjHHqLBfGb1gLh9J2rjD1oCqYDMvmQFCIXV/b
	bHMDWBGLHbijphwmvg4Ga9uD+93gVSOHQevRFVlqrzOZSvyJh0bwL6YrWCykjvu1
	iowTWWln2lZXZGhbx304wmurO2H+Jn2Cm2BxIk4cBrMOOoOvUrDyctoXN+/9HTSH
	kygX7YJdjxERd64sFedPK6NIAPsFO5/bB5H3CH3xS3HyDbBCJvd+l/Ce9jAS2xr0
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dcsacq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:07:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CE6gaL035046;
	Mon, 12 Oct 2026 14:07:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btn9qdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:07:00 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CE6vgg036955;
	Mon, 12 Oct 2026 14:07:00 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-240.vpn.oracle.com [10.154.85.240])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btn9q4d-2;
	Mon, 12 Oct 2026 14:06:59 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        puranjay@kernel.org, yatsenko@meta.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 1/3] btf: Fix size/vlen validation for BTF_KIND_LOC_PARAM
Date: Mon, 12 Oct 2026 15:06:38 +0100
Message-ID: <20261012140640.2932195-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261012140640.2932195-1-alan.maguire@oracle.com>
References: <20261012140640.2932195-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120056
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfXzqaloDJnzxli
 utMVYNMpGESlUWHNrw9sRd7TS269MTDN8y5eVgLsJhyUP/L39elSa5Bk8yx2xEFPl3vPGfzoaC+
 sTmUyWaj2wcFzKOHc8I0zLKFMrTBx5cBUnFqWYLumrm9NEIzoLgF
X-Proofpoint-GUID: 420xfzkQthq9X22S62l6o7R_zYr69xLf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfX0lPMHO/r2Wl2
 KV3vqsSWDEuNP2TiihqKYa4Ob7MI4uyrPJD6tv0V4NOK/PFeqoOphXe1WucJZCyQwKSEQSAlWsc
 hD8Im05wEnHmscTpXDmN+t7j2Q5208I20IOvpdiZev2JE789d9hYBrzJMte07eQXFaWgChHqIH6
 RMh1/H5mgA0X7iqWXHZmdQ/WoTRpQGCTXR6iB9cdKVehTZAxd0gAFWv5IueDEFTM6ySZg7RF7xO
 maAVv4h/hbCS/gTPTZfJbThUKLsJS3qQWm3OBBo2Z41QfjWpQmrmM358ITRKH3tmTy28k1JYpDL
 emMvzyb8zpX3MnFvfPRVbNA84SwB1tMtgzRR/IRR5q/9OBvncRO7XWOaSoTDMSQVaRKLGWEj0iK
 dVcCbAGJj+hMpXykeFYvS/O+ojW1wre1BMq32ERsqO+2mBdkELFD9UD6KHmkQCg7iVeLhwHNgMY
 XC8P51a5QJ6LROZiOzvQdCKkRF9iEp9y5zAElX+k=
X-Proofpoint-ORIG-GUID: 420xfzkQthq9X22S62l6o7R_zYr69xLf
X-Authority-Analysis: v=2.4 cv=EdZd0/mC c=1 sm=1 tr=0 ts=6acce985 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=8ic-eLmDZP-ZVhi08vQA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12107

Validation logic allowed a BTF_KIND_LOC_PARAM with size <= 4
and vlen == 2, an inconsistent representation.

Fixes: a3df11403e8c8 ("bpf: Verify BTF_KIND_LOC_PARAM vlen, flags")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b09c04ccdc6d..64c78434fa05 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4827,12 +4827,12 @@ static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
 	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_SIGNED:
 	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_ADDR:
 	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_SIGNED:
-		if (vlen > 2)
+		if (vlen < 1 || vlen > 2)
 			goto invalid_vlen;
-		/* Ensure size/vlen are consistent */
-		if (size > sizeof(__u32) && vlen != 2)
+		if (!size || size > sizeof(__u64))
 			goto invalid_vlen;
-		if (size > sizeof(__u64))
+		/* Ensure size/vlen are consistent */
+		if (vlen != (size > sizeof(__u32) ? 2 : 1))
 			goto invalid_vlen;
 		break;
 	case BTF_LOC_PARAM_REG:
-- 
2.43.5

