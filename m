Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1ED383B9
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103168; cv=none; b=MeyrN4y5JvMc8Jqd66rxDK149TQ3VDjesuDPFUbfvyZkQjADOLLMRAUtsrd0bx7OXIecNRWuMWWjHGLoQKP42UkdKmmP1wHVONNI6oFaplA4bC217TpCnaVZFUBM+eEKV4V0Tk9k+Pkymug7cPzuZI9yM+SOAkTPxCuyJKPIMfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103168; c=relaxed/simple;
	bh=OZ0KlOA6YCa7qe9OL4CFMpAcf2rpXU/iLIZD8+RD3nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sPP6XiwxJi9+lxiZMVFiwrkz2Fy/QrIG8xPr/uAFglvfj+UWQUkEQGfRoWZbeZXb7nRw2rDCKZuHO3bO75WdRSvcXFOxPFMM9/j1mhZxFc6/u0R8nGHipHHgmi2XgRP/tXA9FPPHyU3mjfkZoNoli2aqzC0+Ev24sFCOC6UJvmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G6ZEJyxL; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G6ZEJyxL"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YWUD017166;
	Fri, 22 Mar 2024 10:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=nnIhHGK9qejFkRvmS5F3XcUu80vwhIX4RoZx/mOsuAo=;
 b=G6ZEJyxLM8Xu1aZHLd/j212bJ/pJmqqDA55yPWDfcu4W7RQ9mP97KvBU4OmwVa462bpa
 RZ+z7DdgeluPJX7Cx2Us5GfRhfbtdUVgnU57RtBG39V7COuzfRva57OK0KJj/un03xHK
 4BN2w4bcRCojefFU/4P0/f33BfyPm9cD4wU6i4SsBzUfqHsQc9S7wRs6K9j5VLm81kz3
 b7F0hk559V9kIUATvJK+InbYBc7hlOPuQqHbhPoeCcQyaA2SdQUmE4FbRocObFWZtred
 AYz/ndBV/DQR5ZZ66hiXPPfxaDvbYys50PAx5CgNePf7Q18tCSCZD6L9bwcoi0fty4RT 5A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvp8s6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9GraM014999;
	Fri, 22 Mar 2024 10:25:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2hwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kd030399;
	Fri, 22 Mar 2024 10:25:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-9;
	Fri, 22 Mar 2024 10:25:41 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 07/13] resolve_btfids: use .BTF.base_ref BTF as base BTF if -r option is used
Date: Fri, 22 Mar 2024 10:24:49 +0000
Message-Id: <20240322102455.98558-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240322102455.98558-1-alan.maguire@oracle.com>
References: <20240322102455.98558-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220074
X-Proofpoint-GUID: IxO6b6Ya1WWJ0HvcQjY2zrAvDCo-Z5A3
X-Proofpoint-ORIG-GUID: IxO6b6Ya1WWJ0HvcQjY2zrAvDCo-Z5A3

When resolving BTF ids, use the base reference BTF in the module
when passed the -r option.  Both references to base BTF from split
BTF and BTF ids will be reconciled with base vmlinux on module
load.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/resolve_btfids/main.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d9520cb826b3..cdab366bd4d6 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -115,6 +115,7 @@ struct object {
 	const char *path;
 	const char *btf;
 	const char *base_btf_path;
+	int base_ref;
 
 	struct {
 		int		 fd;
@@ -532,11 +533,21 @@ static int symbols_resolve(struct object *obj)
 	__u32 nr_types;
 
 	if (obj->base_btf_path) {
-		base_btf = btf__parse(obj->base_btf_path, NULL);
+		LIBBPF_OPTS(btf_parse_opts, optp);
+		const char *path;
+
+		if (obj->base_ref) {
+			optp.btf_sec = BTF_BASE_REF_ELF_SEC;
+			path = obj->path;
+		} else {
+			optp.btf_sec = BTF_ELF_SEC;
+			path = obj->base_btf_path;
+		}
+		base_btf = btf__parse_opts(path, &optp);
 		err = libbpf_get_error(base_btf);
 		if (err) {
 			pr_err("FAILED: load base BTF from %s: %s\n",
-			       obj->base_btf_path, strerror(-err));
+			       path, strerror(-err));
 			return -1;
 		}
 	}
@@ -781,6 +792,8 @@ int main(int argc, const char **argv)
 			   "BTF data"),
 		OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
 			   "path of file providing base BTF"),
+		OPT_INCR('r', "base_ref", &obj.base_ref,
+			 "use base reference BTF as base"),
 		OPT_END()
 	};
 	int err = -1;
-- 
2.39.3

