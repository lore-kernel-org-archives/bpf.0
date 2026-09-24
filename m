Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E6472079
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248528; cv=none; b=GOzpvUDm/ZYcgFRyXF9QBICN42BvSZ4kBnU/ZXuxsyG/Rq0ASLe5a6EZujaxMl5lvDii6K7W7px7KKJxx2H0Wg58SSUqktnYKLZIkfiFMXy5hrL1atg6eboOwcFEv7PFqwOvHXJgQlBD9TbrashKHjMHobTJyMfkwbTXpYbVzOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248528; c=relaxed/simple;
	bh=naOLguWCM4glbvGfiNa6XDqp0RNqrctKQtIox4lWtbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIYQDamcUNz8oGH2eh5Uhw9g992oC+doqOyT4BpiPnMx0dLCwK6V1ldhoraKG1dK/VgQ4IoKRfkBniLH4qsr9B2Yxo/mOnJqJdj8LVMb/+t2HIySj7Ws8iV9eO+roIVQYlma26eGLt5HTzx++BrdVtGkE6tWMak6RvWxv6vZJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=clbpk3cD; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="clbpk3cD"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6CVEi4017063;
	Thu, 24 Sep 2026 11:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=L0Rtb
	UC3nTeYjOKjRkAVOHncQ5IhCCOvmXuWYI305ew=; b=clbpk3cD+AMP3NkW6ghPS
	642uTh+BBpWc1lhP0b9itSI6coKZWi6OR+OWm+ZEXmt/xRcb4FvySZgsOEyikm9+
	ZYKAurcjJHHsV0wogm0lWY4H/OsI6Tea+FIs6YsOWWn6oKQPypbELZJKQFLLh871
	jrgk2uN+TfdILg8I81onAKOHYFWQyI8pRurWFoaPFXtlfFZxn3XQVnpoGIVwwe9Q
	veREH2JO7AbeFdLN/1kz16S+RJN+UAqJ7JMgmg/Li+90+Yz/h7OW50zR7kPO7UWz
	2by4bS0If63j1RV26XP2zHJUdzWEcqz5i3IGg4KtRONhjODxJIdiTnhRf3LXGOL5
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0xqcbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5WXj013030;
	Thu, 24 Sep 2026 11:14:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119m4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:57 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVuJ002821;
	Thu, 24 Sep 2026 11:14:56 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-8;
	Thu, 24 Sep 2026 11:14:56 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 07/11] bpftool: Handle multi-split BTF by supporting multiple base BTFs
Date: Thu, 24 Sep 2026 12:14:24 +0100
Message-ID: <20260924111428.75957-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260924111428.75957-1-alan.maguire@oracle.com>
References: <20260924111428.75957-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609240046
X-Authority-Analysis: v=2.4 cv=F/bC5ahN c=1 sm=1 tr=0 ts=6ab50631 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=-wvoJO6U5y_gVNUfi64A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX1yT1XvpGcURB
 0/pWkSAp0jKa/9OoPcnQxZUbqlAXWjdU4nmeYhFdv7jQMMVzU3N1xgy/+9wQ1vE2V3MiZGlctlc
 fmPcXgpr78OW1h+1E6wakr+SgccgCfXZ/o8SuQBmvoSjf2co7+Ed
X-Proofpoint-ORIG-GUID: KXQLY980kLLNEBkHdECa-MJGAccHq8pN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX4UKJRU+zaeJY
 nL2m+RUN3CvDeE9MIyEKBSuqj0jnJVD78qdO1O0yTIIHKOzJotyJAx3vJeJ4xtjWBc/PHXZuxVo
 L2Xxlet7hZmhghOOj+Svk+536KN2bSqaiAhQArR/yX/Saqgjt+CHJexQo6190+fj5LWEmCQ0wBW
 Wto4y/yNwzuBRtigfPflr4x74e7uhmN9zArlXKAZHtHzWa+NZlPNAXslvZAyzRWYGNmD/ZZyCgT
 iofPsU7xdVsf2dnXjFO48KKIRsEic9MuaFvZdZ+8Fv7sH5wAkEoQt6cKZd/HNcBp5m/CaubLJH3
 YEEX2G0DbdJIdsFgW83OGQs9uxsJo8M/FNjlTxQztUhtq9kKev6REYD2+yQZTxBDBiyoTkL1quf
 fp/avBkntZzNaKrgKFJy4/Bd9M49bdhDm3LB8u1mENR5Hh+d3w06Dry8UHu23P2NGr8S3aQ0Ffa
 FllqtDARqA1luJeHRl4l24oJQhko/8ZFb/u+3kCk=
X-Proofpoint-GUID: KXQLY980kLLNEBkHdECa-MJGAccHq8pN

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
followed by the xfs BTF (child), and finally the XFS BTF inline info.

Update help text accordingly to reflect the ability to specify multiple
in-order root-to-branch bases.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c  |  2 +-
 tools/bpf/bpftool/main.c | 24 +++++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index bca0a3982f09..65e8a29277e6 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1545,7 +1545,7 @@ static int do_help(int argc, char **argv)
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-		"                    {-B|--base-btf} }\n"
+		"                    {[{-B|--base-btf} FILE]... }}\n"
 		"",
 		bin_name, "btf");
 
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 5ababd8f7d0a..83884b21e708 100644
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
@@ -567,7 +572,20 @@ int main(int argc, char **argv)
 	if (json_output)
 		jsonw_destroy(&json_wtr);
 
-	btf__free(base_btf);
+	while (base_btf) {
+		bool is_root = base_btf == root_base_btf;
+
+		new_base_btf = (struct btf *)btf__base_btf(base_btf);
+		btf__free(base_btf);
+		/*
+		 * Do not free base BTF that is an owned .BTF.base ; leads
+		 * to a double-free, so only free as far as the root base
+		 * we explicitly read with -B above.
+		 */
+		if (is_root)
+			break;
+		base_btf = new_base_btf;
+	}
 
 	return ret;
 }
-- 
2.43.5

