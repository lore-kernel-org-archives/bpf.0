Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1A47ACE3
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329990; cv=none; b=rauUWs6Ko5oszY+0iT1Olo3PLSBZhPp6nLCt2NS5G54d6qiB2s6hUuW3wj2mUF/xtonUKXHhzNEKX4cFEQtUZ9H3cC7x2K7lymPTqqfius1j3UEyiaD6IMX5bVIThdgX27YO1wy+MxEtlleFnqDiBd9hyju3mM67ydZdz55w0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329990; c=relaxed/simple;
	bh=0EVgJcJ4uWDdiqc2BVHg4xUt4+0WyDpJUTG8yOFy08A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNOSzKY5Wl9CTcQBuItAm3aO/nhkVqIQ/PHspWc247EYWChUt3B0NEWb7Jb+MFsw4WP3+vPtDWDzAnMECAV5mSUi+k65jx4UArHM0uZ2Db9tHU50tfhB7Soyqa5MBiB9cp7lDwG8IOsubNgXiJoPOCYo8XYNr1GY17TUYtklzMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vs+EikOz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vs+EikOz"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P3Kn2w241730;
	Fri, 25 Sep 2026 09:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=kc++G
	woOT6O27ENDwj8TJFYmcc+dpjBbUVjsVkuLglE=; b=Vs+EikOzeI8Uf/qeLCfax
	V/eK8Ohs0drjouXXIA6HTSc+SCM8FsFqyp7Qf0VT42JC2wTdi7uDELHhttEFblON
	F3smGeiJ9ZEy6GjKHSreC2IQh3GGCcJicvoTWUw2XS4iU/BPiMH1JV6LJPANY6UH
	0+mWjk4lBq4I3AsCPs8/Na51tm3H64D+XX+rWt5yknkQNHSBPFTENGrjtK7u6/KK
	chmtNbinJeUJ49gTl7gZvx1dfopnBPmRo2/4yxw1lZRYleOSEy2pP2VRxCt5gei5
	OxJM3P0cgUVJuyZ+NrNq0PHGD1eCDxjd6Ow9q8/OdDZ3PAwuLidtqxyVac3gpD9S
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsjxb95tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:52:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68P9oPl5004386;
	Fri, 25 Sep 2026 09:52:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtept1dnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:52:37 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68P9mZYf001344;
	Fri, 25 Sep 2026 09:52:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtept1djn-2;
	Fri, 25 Sep 2026 09:52:37 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 1/3] bpf: Verify BTF_KIND_LOC_PARAM vlen, flags
Date: Fri, 25 Sep 2026 10:52:29 +0100
Message-ID: <20260925095231.879708-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260925095231.879708-1-alan.maguire@oracle.com>
References: <20260925095231.879708-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250039
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfXxjLi2DRHSzOr
 oY969JMOIJwQPJN0C8SuEWlORcqugxNMeUErBms0VRZ8A61vbqrL3UaYV+ks/XwF8/qbzYhJKC9
 86MPo0fodPMMReedym9q9pIsB0mTl0UKfR4miGP7ibxJ4ssZ6lo44ulzKkD00r2PJOJgzAeSbmL
 RBAWj+Uh1/9GJNUEWxMmiBZQmTmLEaYFbFNgv5O9WDbRQzHHBP70BfIhnyBi4j15S4H+BS81cvZ
 X7o5hNaN/jnIzQGm4q1n+YaHsFj0DWIjK2rm2wmPFffZyr5NTynrQeLOmruqinA0MmGlYRlkf/L
 wYYPHycTAPggoDSdIcYCxMcXzuDquSSObgxgXIkPaxodqQpyE6RuBFoKUGq33WLuTP1ocdHvPAt
 93fHaU0m0zbjQkqo0F6EXCcMebrxrCUuekW+E4st0K+kRBSSgRxPYoThDYrkmSAWAtExu7TGad1
 Xj7Ho25zHFB5qMrW6hsNWXxyJxxrs8McAgr2SSUM=
X-Proofpoint-ORIG-GUID: q7bZ_qxY6G3oYYFLS8fQX5Nm8HjpBz6E
X-Authority-Analysis: v=2.4 cv=UINIjyfy c=1 sm=1 tr=0 ts=6ab64467 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=vD7T2s_g4S--GHFsmLQA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13532
X-Proofpoint-GUID: q7bZ_qxY6G3oYYFLS8fQX5Nm8HjpBz6E
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX7kOiDYexJJq2
 56iu1UAYOKgnr7kIZPoTdpZUMutbB9nz/vQomR2MSqD3uuTXJfD1AnN74agxKpcrfpfHksQ0NEO
 0jblxJowKRt+CJUq+YhCpn6oSwPiAORNKlid/nLhQv4LLIcvE0Ji

Ensure that vlen is at least 1, at most 8 for LOC_PARAMs
and ensure that flags are a combination of expected values.

Fixes: 33c5a3278bdb ("btf: Extend UAPI to support BTF location (inline site) info")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5a0179cc1676..dd7ac42649b2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4789,6 +4789,18 @@ static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
 		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
 		return -EINVAL;
 	}
+	/* All LOC_PARAMs have vlen of at least 1, none have vlen > 8 */
+	if (vlen < 1 || vlen > 8) {
+		btf_verifier_log_type(env, t, "Invalid vlen");
+		return -EINVAL;
+	}
+	if (p->flags & ~(BTF_LOC_PARAM_SIGNED | BTF_LOC_PARAM_CONST |
+			 BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_REG |
+			 BTF_LOC_PARAM_DEREF | BTF_LOC_PARAM_OFFSET) ||
+	    !p->flags) {
+		btf_verifier_log_type(env, t, "Invalid flags");
+		return -EINVAL;
+	}
 
 	btf_verifier_log_type(env, t, NULL);
 
-- 
2.43.5

