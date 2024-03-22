Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EFD38FBC
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103194; cv=none; b=TGSZYsWZR23SLCwxaE7eN6ZN9xEioaB217xKsKzB4IAkb91bfxA7SkEIk7/0mmyGWKSc3/+IYStQExA3WNoCdJ3pJMMDmoS9BsEEqPUzJbkk4XckyW6yhPmv23Ei+fw9WlvueE0m9IgfAgGAHb9wk6vxSPUQ24VVzMIbEA3Tyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103194; c=relaxed/simple;
	bh=cYNHsIxBpyGk33Yk//eyC3pq7k2Gb4YMUNnG3TsALJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iu6dHHc4XfBqSxg+n8Ea558dIsjKIit/+QCapmje38MquxKuOFTIfhcDVdp5ZMeI/9xX2+qc5ynuVc5O7nh2zTrmnW4JnPn7Dmc5qI4gRh4QEp57zCp3oELhODvemuhvHuRH80gk9eICAZ0CbQEKJ6TiIeeIY9AEUQ8xZWzdoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RaeMtUr5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RaeMtUr5"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YWRI017154;
	Fri, 22 Mar 2024 10:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=/RHaNJNvC9rOXkKXMef3hgJgxhmmloTO0JJ30Zuyr3A=;
 b=RaeMtUr5rAxMrVL93Rq6Gz2e4bc4OepuWqqid0D+lQ9lHldxQZvuN7J7HgriLkvpydrR
 5eMYByfXCGk6q9V/y0t37187hkw7mzhOdLJ+soqK7tY8XkE9QqnaQbjRP+wvbl7dd5MQ
 mcM2MUJekDiGEs3dnZOM0qfQolS4z3ct7DWxd1X6frV2HS5+xuCFPBsBY7e1okVrSHql
 AOPbtWhKmI2ANFz/LdF5NQ7M9xHCTqU59pPEhMStdhiYgtYoOVIyE3y3gexdJmbfB8CN
 b6CGspMjWx7X9/1cVb0jFU60VdgxJYXgfVU9diRUHF0Wvqv/zdYayYeyIeapTI30hAlq 4w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvp8sah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:26:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9AG9V014958;
	Fri, 22 Mar 2024 10:26:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2jj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:26:11 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kp030399;
	Fri, 22 Mar 2024 10:26:10 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-15;
	Fri, 22 Mar 2024 10:26:10 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 13/13] bpftool: support displaying reconciled-with-base split BTF
Date: Fri, 22 Mar 2024 10:24:55 +0000
Message-Id: <20240322102455.98558-15-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: WxXW7xR1NEOM8oghuDo4wgM2IV-1m7Qd
X-Proofpoint-ORIG-GUID: WxXW7xR1NEOM8oghuDo4wgM2IV-1m7Qd

If the -R <base_btf> option is used, we can display BTF
that has been generated with base reference BTF in its
reconciled form.  For example if we build a module with
base reference BTF:

BTF_BASE_REF=1 make -C. M=path/2/module

...we can display its content relative to that base
reference BTF via

bpftool btf dump file path/2/module

Alternatively, we can display content reconciled with
(a possibly changed) base BTF via

bpftool btf dump -R vmlinux path/2/module

The latter mirrors how the kernel will handle such split
BTF; it reconciles its representation with the running
kernel, and if successful, renumbers BTF ids to reference
the current vmlinux BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst | 17 +++++++++++++++++
 tools/bpf/bpftool/btf.c                         | 14 ++++++++++++--
 tools/bpf/bpftool/main.c                        | 14 +++++++++++++-
 tools/bpf/bpftool/main.h                        |  2 ++
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 342716f74ec4..97b6426367e6 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -90,6 +90,23 @@ OPTIONS
 		  to autodetect the path for the base object, and passing
 		  this option is optional. When the main BTF object is passed
 		  through other handles, this option becomes necessary.
+        -R, --reconcile-base-btf *FILE*
+                  When split BTF is generated with base reference BTF,
+                  the latter is stored in a .BTF.base_ref section and allows
+                  us to later reconcile split BTF and a potentially-changed
+                  base BTF by noting that type ids in the split BTF that
+                  refer to base BTF refer to specific integers, structs etc.
+                  By passing base BTF via the -R option, we can carry out
+                  that reconciliation operation between split/base reference
+                  BTF and base BTF.  If successful, the split BTF will then
+                  refer to the base BTF types from *reconcile-base-btf*.
+
+                  If this argument is not used, split BTF is shown relative
+                  to .BTF.base_ref data as a base; however in this mode
+                  it is not possible to generate "C" output, since the
+                  information retained in .BTF.base_ref is just enough to
+                  clarify what a type id refers to, but does not contain
+                  full type details for all types.
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index f1e0ea06f05f..355b56eff9f2 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -644,8 +644,17 @@ static int do_dump(int argc, char **argv)
 			base_btf = btf__parse_opts(*argv, &optp);
 			if (base_btf)
 				btf = btf__parse_split(*argv, base_btf);
-			if (btf)
+			if (btf && reconcile_base_btf) {
+				err = btf__reconcile(btf, reconcile_base_btf);
+				if (err) {
+					p_err("coud not reconcile BTF from '%s' with base BTF '%s': %s\n",
+					      *argv, reconcile_base_btf_path,
+					      strerror(-err));
+					goto done;
+				}
+			} else {
 				c_compat = false;
+			}
 		}
 		if (!btf) {
 			err = -errno;
@@ -1088,7 +1097,8 @@ static int do_help(int argc, char **argv)
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-		"                    {-B|--base-btf} }\n"
+		"                    {-B|--base-btf}\n"
+		"                    {-R|--reconcile-base-btf}}\n"
 		"",
 		bin_name, "btf");
 
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 08d0ac543c67..33ac0ca77162 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -32,6 +32,8 @@ bool verifier_logs;
 bool relaxed_maps;
 bool use_loader;
 struct btf *base_btf;
+struct btf *reconcile_base_btf;
+const char *reconcile_base_btf_path;
 struct hashmap *refs_table;
 
 static void __noreturn clean_and_exit(int i)
@@ -448,6 +450,7 @@ int main(int argc, char **argv)
 		{ "debug",	no_argument,	NULL,	'd' },
 		{ "use-loader",	no_argument,	NULL,	'L' },
 		{ "base-btf",	required_argument, NULL, 'B' },
+		{ "reconcile-base-btf", required_argument, NULL, 'R' },
 		{ 0 }
 	};
 	bool version_requested = false;
@@ -473,7 +476,7 @@ int main(int argc, char **argv)
 	bin_name = "bpftool";
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:l",
+	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:lR:",
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -516,6 +519,15 @@ int main(int argc, char **argv)
 				return -1;
 			}
 			break;
+		case 'R':
+			reconcile_base_btf_path = optarg;
+			reconcile_base_btf = btf__parse(optarg, NULL);
+			if (!reconcile_base_btf) {
+				p_err("failed to parse base BTF for reconciliation at '%s': %d\n",
+				      optarg, -errno);
+				return -1;
+			}
+			break;
 		case 'L':
 			use_loader = true;
 			break;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index b8bb08d10dec..c84bfc1d9135 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -83,6 +83,8 @@ extern bool verifier_logs;
 extern bool relaxed_maps;
 extern bool use_loader;
 extern struct btf *base_btf;
+extern struct btf *reconcile_base_btf;
+extern const char *reconcile_base_btf_path;
 extern struct hashmap *refs_table;
 
 void __printf(1, 2) p_err(const char *fmt, ...);
-- 
2.39.3

