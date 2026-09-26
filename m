Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D42381EBC
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445112; cv=none; b=DzQ+n/RRN3XbFx1zbv2vsHl/ac8Lb2ofsgr56gvrHcKSFmORAH4m8Na/ZosDpkSIVffRFL33UIiHkPpgvVkAbJOS0c+p3ql5/DZ0e6Xia0h4LbCSkmEiIuhT6O9mQ1kqU1y9nleEzVcCL68zG98GMdf6VjjCmT48OGLSSKZrwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445112; c=relaxed/simple;
	bh=PyvHPT+g3S9iGH0pT1A+Xw218WtDI/xcTArD4TrcLio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLDdlm7Ax8chh+Jp9RhRXxD+3eMLWcP48OrDYiWit6QtrXiyk6Tt99P70a/FvgjEgW6uFbEzgjH80KSxYDxkQ4ZhLXagpHE0koSriYJ2QGF1iUVWLhadJLLoDGtyVvi6nCA+ZR3sG+tREbRbQFGzr34VMUH7HARnoNqlFPTbZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WkwEXh9t; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WkwEXh9t"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QHZjS92317899;
	Sat, 26 Sep 2026 17:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=7LjhX
	6hUArHsBmXAQCrtHqykvgnv12fFMdhPYNpvCA0=; b=WkwEXh9tqICj9y/BlypbM
	axmh9qKzwT6Qne88VXA+liePb30SrstvLrwPmryCf8kQ1Ei+kNzN1Jor/4VevL4j
	TczzY8nucQQOlQeDNX7m6ZhSwOvFAqlA81qJtCWN0UarsBEq7IaalydydYv+I+Dx
	7J+VEPdm2b3R8pVara7qc5d3KqzCF4W3LNvqFtYsfQ9SZherpTXkcHRblh6ytn7/
	3Ml8jyskpFpjdrt0ETYKo2xSbSf2mb0+aAQYln7djxaXc/Nas7aQfPa/v/GKjIJf
	R7RCrgGgZot4xA+i2u0U0hrrhfhuFlwcmlh/hcUb9/t+9wR/OEamaDhPFOF0I5Xn
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4y98cc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 17:51:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68QHo2Ax017856;
	Sat, 26 Sep 2026 17:51:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4g8nbea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 17:51:21 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68QHpHsX020485;
	Sat, 26 Sep 2026 17:51:21 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-123.vpn.oracle.com [10.154.81.123])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gx4g8nbb1-2;
	Sat, 26 Sep 2026 17:51:21 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 1/3] bpf: Verify BTF_KIND_LOC_PARAM vlen, flags
Date: Sat, 26 Sep 2026 18:51:11 +0100
Message-ID: <20260926175113.2368566-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260926175113.2368566-1-alan.maguire@oracle.com>
References: <20260926175113.2368566-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609260071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MSBTYWx0ZWRfX8A72m6zzV1pn
 2UBqZ9koS1+ZuA0Sjas9hw7RlNMo47yBXrrK9183sVpif8GvckdJoiTVWgn6hrheq/JsgkWNEEN
 AURcH7gskIwDaZOgmZv9yvRUlTpAE82YJog27c0tdQpK86THWWq2G4Lkmpb0AV/8b4lTPaLnTxK
 w0Caey9ZYNVW2bJroqca2nuyBm7Pxwv6IDd9/1mg+58OgGkjzC/YPO6bw/u3l3yl59o01Ozds8/
 cReF+/9H+Hqx0YoGEA7MQKwaeM/YO0PuOL9tihnfFvMFfIDWfKcSAh+0OrGsfOg2+hJQGbWL57t
 HiRXBua3fQYfhjSNeonLV7HCl0lspwX9/tgFXReMhF1/zy7FyyZHXFykjb+3VFwi+wtC19VpnSN
 tVizslzAaWI94slMNKOqwAkboFSBk+CeV4ifImyBgEm/gs2XN7z0QEkaxKP7Pdx2UIl+UvsFVEp
 YvzaUbiHE7SYBeiIWoQ==
X-Proofpoint-GUID: wBAkosqFRquh536tLpLkT8k1TN0vOHZQ
X-Proofpoint-ORIG-GUID: wBAkosqFRquh536tLpLkT8k1TN0vOHZQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MSBTYWx0ZWRfX8GZal8pfWkqH
 wz/F2oahvNnL/C297l98lC/ZQSVFYR5r9sg9E0YGQNle2Guq7iav3KlrUMW6RCru5rVOD1y/kdK
 rr3Els6UVdT2axyfP+Q0FzCt7lOjdbd/2uzlFOfQAQ5HMPfk4jPE
X-Authority-Analysis: v=2.4 cv=IuyL47/g c=1 sm=1 tr=0 ts=6ab8061a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=z8lHZeWSVM0VDOMPmbQA:9 a=WmVTiCyuxqgg3mnwYu6p:22

Ensure that vlen and flags combinations are consistent for
BTF_KIND_LOC_PARAMs.

Fixes: 33c5a3278bdb ("btf: Extend UAPI to support BTF location (inline site) info")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9bcfefdfb734..8cc17a1cd25c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4823,10 +4823,53 @@ static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
 		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
 		return -EINVAL;
 	}
+	/* All LOC_PARAMs have vlen of at least 1 */
+	if (vlen < 1)
+		goto invalid_vlen;
+
+	switch (p->flags) {
+	case BTF_LOC_PARAM_CONST:
+	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_SIGNED:
+	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_ADDR:
+	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_SIGNED:
+		if (vlen > 2)
+			goto invalid_vlen;
+		/* Ensure size/vlen are consistent */
+		if (size > sizeof(__u32) && vlen != 2)
+			goto invalid_vlen;
+		if (size > sizeof(__u64))
+			goto invalid_vlen;
+		break;
+	case BTF_LOC_PARAM_REG:
+		/* Reg or reg/reg pair */
+		if (vlen > 2)
+			goto invalid_vlen;
+		break;
+	case BTF_LOC_PARAM_REG | BTF_LOC_PARAM_DEREF:
+		/* A reg deref without offset can only have vlen 1 */
+		if (vlen != 1)
+			goto invalid_vlen;
+		break;
+	case BTF_LOC_PARAM_REG | BTF_LOC_PARAM_OFFSET:
+	case BTF_LOC_PARAM_REG | BTF_LOC_PARAM_OFFSET | BTF_LOC_PARAM_SIGNED:
+	case BTF_LOC_PARAM_REG | BTF_LOC_PARAM_DEREF | BTF_LOC_PARAM_OFFSET:
+	case BTF_LOC_PARAM_REG | BTF_LOC_PARAM_DEREF | BTF_LOC_PARAM_OFFSET |
+	     BTF_LOC_PARAM_SIGNED:
+		if (vlen < 2 || vlen > 3)
+			goto invalid_vlen;
+		break;
+	default:
+		btf_verifier_log_type(env, t, "Invalid flags");
+		return -EINVAL;
+	}
 
 	btf_verifier_log_type(env, t, NULL);
 
 	return meta_needed;
+
+invalid_vlen:
+	btf_verifier_log_type(env, t, "Invalid vlen");
+	return -EINVAL;
 }
 
 static void btf_loc_param_log(struct btf_verifier_env *env,
-- 
2.43.5

