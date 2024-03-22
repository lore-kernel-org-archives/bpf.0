Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1B35894
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103159; cv=none; b=g/I3Wfcg/8orflo4EiXSt9QbGQaZiyHelVeJ17nirSXO/qdFBD3scu8K7OJAxGFe5dLrQCcqwuUJwLGbLPaqLkewmIXese0/VeZI9kN82IfsfKOh0C5SYH7WDhSH+T32uG+kGa4ca6SLeYbEYvsHGVZNUiC6/lW2NtCJrbqPy4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103159; c=relaxed/simple;
	bh=xxAOviqpRIRbN/Cc7ki59O5XFiLSfILoC4pQRMu7j24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j78vVbtykQxIydRndAUDREuygItXAs8qSw3FAZx+e7KNZjxhFSzxmrUuy6p1JGpfJOphE/E1Xa/HXyy8A9ngshJKX+7cZSYSIweBPy0xqWePjK7TVszT4Pjqg6cvDqY01AnW1tQdx6I/QtRCZZcahGfnc+jIgqUiulsH6q46gdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lEThPbJV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lEThPbJV"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YfeI000995;
	Fri, 22 Mar 2024 10:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=UvxdTX8mL+xfDMWIr73kW6vFFWcIT7KCGwolwUK6/mA=;
 b=lEThPbJVC0CEa4ILFnjs55tgsciJ+Mq5pzfpVTrs5V/ow/aF2JEYgsW5GF6jAd3OdLH4
 Z6RbbWcD8WQPPpPIUYtnjjznLr+mGMiclLnRxy3/vPZf6Eb0VQUFLiEi/9psW3K43WZp
 yyRwCoCn1uK9upnAj8vLYkLZ8uO7p0dySNAbie/cSC8sIxxYxI/mz63TWV94bC6B5t/R
 A0PVqeHRDu7DpBhnvkoPyHEmN+7Nn6+J4zCoe6uTyOrfXexMo1xgtaW1k0HKQc3sAJgq
 s3fA4ePF7JV5/8rUnXVZeZ+Kzi4GV+9O8S6O1mtjjTUehM6aG06yO8Js6ByytOEcET3w eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvpgs6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9KQpa014859;
	Fri, 22 Mar 2024 10:25:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2hp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:32 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kZ030399;
	Fri, 22 Mar 2024 10:25:31 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-7;
	Fri, 22 Mar 2024 10:25:31 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 05/13] bpftool: support displaying raw split BTF using base reference BTF as base
Date: Fri, 22 Mar 2024 10:24:47 +0000
Message-Id: <20240322102455.98558-7-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: -3bPNmLBm0xqczddyX9Co_iZRRTg8kIi
X-Proofpoint-ORIG-GUID: -3bPNmLBm0xqczddyX9Co_iZRRTg8kIi

If no base BTF can be found, fall back to checking for the .BTF.base_ref
section and use it to display raw split BTF.  Note that C format output
is not supported for base reference BTF as structs and unions are generally
represented as FWDs.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..f1e0ea06f05f 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -552,6 +552,7 @@ static int do_dump(int argc, char **argv)
 	struct btf *btf = NULL, *base = NULL;
 	__u32 root_type_ids[2];
 	int root_type_cnt = 0;
+	bool c_compat = true;
 	bool dump_c = false;
 	__u32 btf_id = -1;
 	const char *src;
@@ -631,6 +632,21 @@ static int do_dump(int argc, char **argv)
 			base = get_vmlinux_btf_from_sysfs();
 
 		btf = btf__parse_split(*argv, base ?: base_btf);
+		/* Finally check for presence of "base reference" base BTF -
+		 * this will allow dumping in raw but not C format, since
+		 * base reference BTF will not contain fully-described
+		 * structs/unions.
+		 */
+		if (!btf && !base && !base_btf) {
+			LIBBPF_OPTS(btf_parse_opts, optp);
+
+			optp.btf_sec = BTF_BASE_REF_ELF_SEC;
+			base_btf = btf__parse_opts(*argv, &optp);
+			if (base_btf)
+				btf = btf__parse_split(*argv, base_btf);
+			if (btf)
+				c_compat = false;
+		}
 		if (!btf) {
 			err = -errno;
 			p_err("failed to load BTF from %s: %s",
@@ -686,6 +702,11 @@ static int do_dump(int argc, char **argv)
 	}
 
 	if (dump_c) {
+		if (!c_compat) {
+			p_err("Cannot represent split BTF with base reference BTF in C format");
+			err = -ENOTSUP;
+			goto done;
+		}
 		if (json_output) {
 			p_err("JSON output for C-syntax dump is not supported");
 			err = -ENOTSUP;
-- 
2.39.3

