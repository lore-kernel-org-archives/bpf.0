Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B823AEF37
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356219; cv=none; b=mvgAydInZMrxY3VwdUaS6ve00+LGf9gAZGgXjT+nl8ejAJqejVeoTeuqLXNCOOxmQcYA0V6GDyM8oszNAtWw1dp5PTTMmynCx0oi76twZ7khMOvqbyWLbXMdBgTEhBBhKE47sN5MpDmmop0BcTq1AbAXpHODnPEwoF0LSvMecRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356219; c=relaxed/simple;
	bh=4o3y8sCsBHpRwNPg7eO28FQqfItscrIfFGIOaFxgQx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAcB0nBvYFkcBjQNw/2kgzANgtxidmQuyRgUyKmLaeC8yhQlBYuv0R3MX2J/1NJYWpBmqGjJE+1VQgcQnW3waclDtV2e5ZUJE/X0ORW/fwwna4s/FKuxpcBtNX5tunSQ/lGcUKq47ifeKk9OEOV7S+f4tZmAQ4X18UUJPe0ZNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eN607kWA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eN607kWA"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEC1H22932673;
	Fri, 25 Sep 2026 17:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=OD/XN
	s/wwsoq8tTdETQTqAOMa+hxeKFXvt14XRMOj/A=; b=eN607kWAkgZS+OhT9qFLT
	Lq12wf72bSTN5ZO3qbULa41vUmKDUx6qpIUevXLaCGOi2reWBrVm/AU6dGqIr2Uf
	lBp77bpXHSSAbj8bQqBTlOtKsDyChBe+TWqlMWYVsJS4hk5mDnlx8fOEONiEyoH7
	6ruzG6+fYYVYjTNlP2y104cx43e7XikaXR68ddsr30gpRhBGWSpAdJKp69ocMla4
	CRchmXAaJfV+M1wc5pmPIVHKyYKtlUxaZS8WdATySusJKXiCqnRPQP6y9cSV0UHN
	SRlH5pgnTwrXDxe/WfXGAMdXJMqJ896LMbmWoM38Vd0R5xIgwS2mYVjKC1G/3HxI
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk219qqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 17:09:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PGa2b5023120;
	Fri, 25 Sep 2026 17:09:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepteu09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 17:09:01 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PH8v8k008030;
	Fri, 25 Sep 2026 17:09:00 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gteptetwn-2;
	Fri, 25 Sep 2026 17:09:00 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 1/3] bpf: Verify BTF_KIND_LOC_PARAM vlen, flags
Date: Fri, 25 Sep 2026 18:08:52 +0100
Message-ID: <20260925170854.1240637-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260925170854.1240637-1-alan.maguire@oracle.com>
References: <20260925170854.1240637-1-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=APP6TA4N c=1 sm=1 tr=0 ts=6ab6aaae b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=vD7T2s_g4S--GHFsmLQA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13532
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2OCBTYWx0ZWRfXxOw3rIPDcyPB
 8OAe++QR0Cwzg4LaK6ot3yvRXZQf6GTLKD6Elz1GvqHbRAcDmOBAn847aCCwN69NtJhivpfm/g1
 /Xpi4NtLKhnLLNapfcJUNlkNXAdlczspHED1UN9CggBKyLEiNOvU
X-Proofpoint-ORIG-GUID: KCIgH_l7qpfPp9R-eEqBkgvXWzFpOJi_
X-Proofpoint-GUID: KCIgH_l7qpfPp9R-eEqBkgvXWzFpOJi_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2OCBTYWx0ZWRfX4cpghThZLMnz
 gCudEyajn2XkNmG+XfJ28rWDnt4ePpzJYJyyXPm8qEsmtzCMbqG3diXFeVyi62GSiEXyzgwdH/Q
 oVlawCxlaOF7ACT/jc0n7ig01sk+AQK766C+GiLjalFgbF4Dz0HrccaSeeKmbRLuaBRn15JO0sK
 mKRHOLETqoHX2mW0g6ErCqd81HXnbl+zmN9t0wR1yXV50C9UDsHIFoBsiS/I/GSAEBNlnTmC8fS
 sw4GVEM2eW4sa/FWs5ZC9bcYpNt6ygwdEA0FcXKy5DA0M80WW1mGWFJxA4WbPmALgqifzT/7JEA
 i0ODyO6audk3DfFOU1j6pOGhxDOqLafYOiPbBH7EHBx3xnT3S1RxdALuIfxkC3lMOy88Fr1sgwy
 0Gd2XW9KMqI2uHZ4kYBf8oz9VQc8+j2T4fGigJsfMsFdmU6tfiICsxurSLt53DYxBRQMDJosh7k
 Cik6cAIgIzYeR7AF2s9jBhLMubcb3B0aXiw4HIh0=

Ensure that vlen is at least 1, at most 8 for LOC_PARAMs
and ensure that flags are a combination of expected values.

Fixes: 33c5a3278bdb ("btf: Extend UAPI to support BTF location (inline site) info")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9bcfefdfb734..c4a811a3a650 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4823,6 +4823,18 @@ static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
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

