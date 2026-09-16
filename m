Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5545A295
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544547; cv=none; b=q0x1ao6n43dJ+ODUDd8a87rUkZm9yL+nKYXAGisOPYH40yk34y/x5RxixrkCE3XQdb917zHfvnYAlXOywl+COpGBoma9g+Rwml8feXZqSY6lHYhjHZkeQyPKE0HIEJ/AgFxXti/nNewyXxM3IG8ceLnwz+WefeQl2dDCXbKT+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544547; c=relaxed/simple;
	bh=otoJzBP2TN8/1FzmYkw4SZvq8PkDe2awFeP5lOAPXM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPIU9O02BDNbXGt3vXQ6X4CaGtKNXw67/4ni4z9PLnMUtprEmT3Fp9u8BvRD7Vf/GxSBAR+Smok+h0FEpPnIifMvs+3KXDgdSnFhQtVo3naRIQyJRt8cJhB4ALzUFemVkzE4+nsDNjoC1phR+ilZo2i+YrzppLQ1l/vOWEfJ6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gi7iVIrX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gi7iVIrX"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLYscY1309254;
	Wed, 16 Sep 2026 07:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=CvXxB
	7MXNp+sb+T3Scvcr1RBv60XweKYt3DX6VdTfMM=; b=gi7iVIrXnQcETm+OA83AQ
	S/ww9FGLBO/dg2zdX5MBOzoaXW5CY/o6YFm5YfJM9n/Hcq6wmtFQDwvk/7UcH0/P
	9Z6sv6iZ8BAJIIvPLZ2msodAVJTLZnDXY+0abLmkRC0hLilQ/0s9AkN+wq1X9TLC
	p9z5b5Dn2/7wFBmMuxAWrDCGjZ/pdPdFQ9+CLzs7Xuh6UaouwHKqVFYJXrLZxM5c
	uEqcLZLYbzVfkY/jZFQrH7wG7v586kD9E80dO1HR9XjX6viwtUtmPwr9bWNQEjQj
	iiQwOBWovXRBqJSFa3/3W/Y/q6LCGEKS5gVqTXD6405phb8weeFbGEwJAX5OuiB6
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmwn9550w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7e3iY014913;
	Wed, 16 Sep 2026 07:41:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6au547-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:49 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68G7exPt020284;
	Wed, 16 Sep 2026 07:41:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-86-81.vpn.oracle.com [10.154.86.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gmw6au4u1-8;
	Wed, 16 Sep 2026 07:41:48 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 07/11] bpftool: Handle multi-split BTF by supporting multiple base BTFs
Date: Wed, 16 Sep 2026 08:41:14 +0100
Message-ID: <20260916074118.1007116-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260916074118.1007116-1-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609160099
X-Proofpoint-GUID: wfiYY5VE8pQbKFkqhzaGpHGrbDR0oGXy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX7HhfZMPu9vzb
 cNxZoV6sj2tfCtczcCtdQnYcnNubqU8gkUxzRJqJ5w9Ox2H1Py/wy9a3xlzD7Y6jiHCxXsrJfWV
 iJ8HloTct2VqaloMlP/m/HnOadNkpaWs6EbOAsBdExEngkqlhwwW
X-Proofpoint-ORIG-GUID: wfiYY5VE8pQbKFkqhzaGpHGrbDR0oGXy
X-Authority-Analysis: v=2.4 cv=c9k+0h9l c=1 sm=1 tr=0 ts=6aaa483e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=-wvoJO6U5y_gVNUfi64A:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX/iwPmXxlFK/G
 4UsWtkZhkojZacn6v0NbilxWKVGCkKCc7axH4MRzPPD7nQnzzC8XPwL0e7P+VmnntU22+RVgqa5
 aNfKXSA3rXzkdaFWo9MPwFO7AMXzjmErQ7M+8l/AI1XG8RwM2eY5ftydvvxMKYpm6hCfwZxJQUk
 oaz2G6SPGZEz7/o01lugRh4bbX3wTHy1oZG8KdeFKaby5h2tUWBe98cPeGXyM88Nd5vwQBIRjyn
 F+JS3UfptsbJci3I+Q2ajdkm6+CccxIMKJYryn5bNCY8B1wAI6/AARArhb+ecx1GD27SoXTNhc5
 ziurToqGNh2cnEG+pLKg3yjcE/DB3/k1xYsPsd+pDjC4BitlL9YYkWDZimQGIflec9xbcqeFSjH
 kT3g/WYH3XkRcdLJ1TszLIsYz0Rz6vinMsugWUi8gvkjp0eWaVhiqaTX92Z1Joj8PLQgsqdsU9P
 pWx1AYSFadIC7O2zpvg==

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

Update help text accordingly.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c  |  2 +-
 tools/bpf/bpftool/main.c | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index bca0a3982f09..bbe8f9ea144f 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1545,7 +1545,7 @@ static int do_help(int argc, char **argv)
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-		"                    {-B|--base-btf} }\n"
+		"                    {[{-B|--base-btf} FILE]... }\n"
 		"",
 		bin_name, "btf");
 
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 5ababd8f7d0a..cff76be7d2e8 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -466,6 +466,7 @@ int main(int argc, char **argv)
 		{ "base-btf",	required_argument, NULL, 'B' },
 		{ 0 }
 	};
+	struct btf *new_base_btf = NULL, *root_base_btf = NULL;
 	bool version_requested = false;
 	int opt, ret;
 
@@ -515,12 +516,16 @@ int main(int argc, char **argv)
 			verifier_logs = true;
 			break;
 		case 'B':
-			base_btf = btf__parse(optarg, NULL);
-			if (!base_btf) {
+			/* handle multi-split BTF */
+			new_base_btf = btf__parse_split(optarg, base_btf);
+			if (!new_base_btf) {
 				p_err("failed to parse base BTF at '%s': %d\n",
 				      optarg, -errno);
 				return -1;
 			}
+			base_btf = new_base_btf;
+			if (!root_base_btf)
+				root_base_btf = base_btf;
 			break;
 		case 'L':
 			use_loader = true;
@@ -567,7 +572,18 @@ int main(int argc, char **argv)
 	if (json_output)
 		jsonw_destroy(&json_wtr);
 
-	btf__free(base_btf);
+	while (base_btf) {
+		new_base_btf = (struct btf *)btf__base_btf(base_btf);
+		btf__free(base_btf);
+		/*
+		 * Do not free base BTF that is an owned .BTF.base ; leads
+		 * to a double-free, so only free as far as the root base
+		 * we explicitly read with -B above.
+		 */
+		if (base_btf == root_base_btf)
+			break;
+		base_btf = new_base_btf;
+	}
 
 	return ret;
 }
-- 
2.43.5

