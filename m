Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D17488222;
	Tue,  1 Sep 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281944; cv=none; b=VCuSM9ICTUSgZy0btnPImaWlyt1uB7RaTjvXGpsSUv/Y4SGM14qz300rKYkPzUQH1AvxoKrxuYt9EVtQLvrC2d8InkgUID+8Ru2fpslcl9lsmwYo094hlvIbFUUpvb9DKEyRSe0PdrJQ9W8uGxvw2ltrmFPPKXLNrcLgEXCV/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281944; c=relaxed/simple;
	bh=l90VP/MlyjMcqm97wm0C5Q/v9PtSewwJh0mTgUuHI4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9PXEGySM74mapc3CaMh6L17eETsS8xtZsSOB4hnCSqiNkzT8JqOH6nR8X4pSJYFeKu1cnrZKi+4xPaAVJJzCn8QtwmeEPgbdls5TVx4OguEopT+2wMoXHlnGIsOEkzQeLtatEIFdp1FYp8PS2ieXE3eI37rlKGB6+UEr/xhlQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cIFCsg0P; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cIFCsg0P"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQshx3964158;
	Tue, 1 Sep 2026 16:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=GEzCc
	J3rSfV80m4VVqAGNlWOJeuvUQ0Ftcba+3Ir+KQ=; b=cIFCsg0PijfIHxvAUJjtD
	yozTFs3Eq+hETU+Y9qF1+d8rFLDtrt9bhwUMzZ0ddICIDI/x3gG/M+JEpt+xuLKv
	wgAyoyrBK3RIBCBM8TPtVXimC6imcb2vmSE8d6JVgmkbzmN4taszRo8CtfXLlYHy
	nqeIQBJTA+Qpc7G9uK0elGOfp8RlJ2Ex7LbMF6TwRky+hj4VNWOZ2L1Rs4VC0IUg
	jim2dYDDQasZ5cqOmXUB9FxTW6mzfqhbqekkUKE+dfANb7tUtDLzwx7aTBszToV4
	w9DGyH4Q1qes6yhRxDhtvRPtYARpqwnuuxtiXmyB2Yiegbsb+0kcTy/QtphkUB+j
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqyrw3te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjZGQ002270;
	Tue, 1 Sep 2026 16:58:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg8yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:34 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1W9011129;
	Tue, 1 Sep 2026 16:58:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-10;
	Tue, 01 Sep 2026 16:58:34 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
        nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 09/18] bpftool: Handle multi-split BTF by supporting multiple base BTFs
Date: Tue,  1 Sep 2026 17:57:48 +0100
Message-ID: <20260901165757.801449-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260901165757.801449-1-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX7dZg3i+fHkg4
 bKGxIDkRk8xVj8s9Z02KDB5KFKhNit7BDMLAdPCD6gwKLvsM2CIpEK5WFN7w+qnqe0m8k8RKj54
 /U9acq72NEHKd/TTRBmyo79MOE41aBv5mEG7mIvPYhnWB2moYOlMBLKmeca26CfaxWenAZa2iI0
 RNRrbF7f4tiu/t5ERfhcOL67xN+YJsZGWEvkE7SFFzEJorAmHHZn6Z2O9CJ1AS1pjTN/cvphhJG
 c2KbbZPLTQEmNVXA2lWSflcKTw/W2+aQGrd6iHAnd9GN9Pg/KyWi6PaA6X6VVdazN2Gs0dO2bFx
 PtWR2rqv5r64GESKEoMZ2XhsjHIUnQv35qHVSNPdjI2pAgegT83caE4eVdST2tsVTQwyXtXW/lN
 oO6NrWUvJH8Hx4JzzjYCrRLikI7ThgRSFkxtwBcKXRvy1WgOMRhNfCU2GniR7ugY4ApTcEIOIHE
 mjPf4yavl8+I48y8LaURhv2CTgLyQusNkhRkz92A=
X-Proofpoint-ORIG-GUID: iwPTqt0-wcvR1AAuPlG3NEpfCqk-qn-x
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a97043c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=4YfVQ4h2uSxuqXr8a9IA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: iwPTqt0-wcvR1AAuPlG3NEpfCqk-qn-x
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX/Dthvuf08BFi
 1ikrwb+qDmaw3iqiEs1pmmKPJG+4AR217i5t1/VvoULIcwcawPScdH12J1RzL2PePXqHErfAKuN
 e/U/T7oPwiT74LLgEgG33JcWdXKb6aV9W9Oos1Gg22mxEe7nq1Nm

For bpftool to be able to dump .BTF.inline data in
/sys/kernel/btf/foo.inline for module foo, it needs to support
multi-split BTF because the parent-child relationship of BTF
inline data for modules is

vmlinux BTF data
	module BTF data
		module BTF inline data

So for example to dump BTF inline info for xfs we would run

$ bpftool btf dump -B /sys/kernel/btf/vmlinux -B /sys/kernel/btf/xfs file /sys/kernel/btf/xfs.inline

Multiple bases are specified with the vmlinux base BTF first (parent)
followed by the xfs BTF (child), and finally the XFS BTF extra.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 5ababd8f7d0a..9329f140b700 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -515,7 +515,8 @@ int main(int argc, char **argv)
 			verifier_logs = true;
 			break;
 		case 'B':
-			base_btf = btf__parse(optarg, NULL);
+			/* handle multi-split BTF */
+			base_btf = btf__parse_split(optarg, base_btf);
 			if (!base_btf) {
 				p_err("failed to parse base BTF at '%s': %d\n",
 				      optarg, -errno);
-- 
2.43.5

