Return-Path: <SRS0=sv//=Q5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2199BC10F00
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47E62070D
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550878625;
	bh=ip9a0PDCUdtijGr84g2CIr4c2SyOAGkPCt5SjKAZdL4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q9uOyjlF99BogTA4m9EWNXiJfVUk8DisQaLejEk1Dt1CdvBEwm+NQBhFoRtenETE/
	 z3sm2RiZSVIK9z0XpgMRDtR84dNzNKE2tB4DHCFx6/r/6XrU678j6sVjX+4JVKRjHf
	 3vid0Z02JqlVoHuiEdDW0gK0GEslxiwLJyORe9gU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfBVXhE convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 22 Feb 2019 18:37:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35192 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbfBVXhE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Feb 2019 18:37:04 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MNTXZf026023
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 15:37:03 -0800
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qttpmr166-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 15:37:03 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 22 Feb 2019 15:36:54 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 1F436760956; Fri, 22 Feb 2019 15:36:53 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 4/4] tools/bpftool: recognize bpf_prog_info runtime and runcnt
Date:   Fri, 22 Feb 2019 15:36:44 -0800
Message-ID: <20190222233644.1487087-5-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190222233644.1487087-1-ast@kernel.org>
References: <20190222233644.1487087-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

$ bpftool p s
1: kprobe  tag a56587d488d216c9  gpl runtime 79786 runcnt 8
	loaded_at 2019-02-22T12:22:51-0800  uid 0
	xlated 352B  not jited  memlock 4096B

$ bpftool --json --pretty p s
[{
        "id": 1,
        "type": "kprobe",
        "tag": "a56587d488d216c9",
        "gpl_compatible": true,
        "runtime": 79786,
        "runcnt": 8,
        "loaded_at": 1550866971,
        "uid": 0,
        "bytes_xlated": 352,
        "jited": false,
        "bytes_memlock": 4096
    }
]

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 4 +++-
 tools/bpf/bpftool/prog.c                         | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 12bc1e2d4b46..102b180d3add 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -171,7 +171,7 @@ EXAMPLES
 
 ::
 
-    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl
+    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl runtime 81632 runcnt 10
             loaded_at 2017-09-29T20:11:00+0000  uid 0
             xlated 528B  jited 370B  memlock 4096B  map_ids 10
 
@@ -184,6 +184,8 @@ EXAMPLES
             "type": "xdp",
             "tag": "005a3d2123620c8b",
             "gpl_compatible": true,
+            "runtime": 81632,
+            "runcnt": 10,
             "loaded_at": 1506715860,
             "uid": 0,
             "bytes_xlated": 528,
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index db978c8d76a8..8065ba11b9d5 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -214,6 +214,10 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
 		     info->tag[4], info->tag[5], info->tag[6], info->tag[7]);
 
 	jsonw_bool_field(json_wtr, "gpl_compatible", info->gpl_compatible);
+	if (info->runtime) {
+		jsonw_uint_field(json_wtr, "runtime", info->runtime);
+		jsonw_uint_field(json_wtr, "runcnt", info->runcnt);
+	}
 
 	print_dev_json(info->ifindex, info->netns_dev, info->netns_ino);
 
@@ -277,6 +281,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
 	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
 	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
 	printf("%s", info->gpl_compatible ? "  gpl" : "");
+	if (info->runtime)
+		printf(" runtime %lld runcnt %lld",
+		       info->runtime, info->runcnt);
 	printf("\n");
 
 	if (info->load_time) {
-- 
2.20.0

