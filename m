Return-Path: <SRS0=z+Sy=3C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BBCC33CAC
	for <bpf@archiver.kernel.org>; Mon, 13 Jan 2020 07:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EBC2073D
	for <bpf@archiver.kernel.org>; Mon, 13 Jan 2020 07:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Aw5zmwHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgAMHcJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:32:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45768 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728803AbgAMHcG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Jan 2020 02:32:06 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00D7PXqX017966
        for <bpf@vger.kernel.org>; Sun, 12 Jan 2020 23:32:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=VOv5yxIpXWG79Eq0PMK8I/MoB73HGMIorU8xUd2gg7Q=;
 b=Aw5zmwHot2hsgWRSg0/sT2+tYRCgDGsvKuMGvMoTXu8EcPF+qLCkpn5PThprMimtAeuT
 DYwRECd/nGFG/a827liUYE8AI3tijgaYBflL8FznCVScTgWcoM2mz8V1Hrnkfymx7nrY
 d53xpXlar70dTvWAWBQ5yFq4EpeB6ohmpPI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xfcyupgcb-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 12 Jan 2020 23:32:04 -0800
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sun, 12 Jan 2020 23:31:58 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 30B7D2EC2329; Sun, 12 Jan 2020 23:31:57 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 4/6] bpftool: apply preserve_access_index attribute to all types in BTF dump
Date:   Sun, 12 Jan 2020 23:31:41 -0800
Message-ID: <20200113073143.1779940-5-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113073143.1779940-1-andriin@fb.com>
References: <20200113073143.1779940-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_01:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=25
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130062
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch makes structs and unions, emitted through BTF dump, automatically
CO-RE-relocatable (unless disabled with `#define BPF_NO_PRESERVE_ACCESS_INDEX`,
specified before including generated header file).

This effectivaly turns usual bpf_probe_read() call into equivalent of
bpf_core_read(), by automatically applying builtin_preserve_access_index to
any field accesses of types in generated C types header.

This is especially useful for tp_btf/fentry/fexit BPF program types. They
allow direct memory access, so BPF C code just uses straightfoward a->b->c
access pattern to read data from kernel. But without kernel structs marked as
CO-RE relocatable through preserve_access_index attribute, one has to enclose
all the data reads into a special __builtin_preserve_access_index code block,
like so:

__builtin_preserve_access_index(({
    x = p->pid; /* where p is struct task_struct *, for example */
}));

This is very inconvenient and obscures the logic quite a bit. By marking all
auto-generated types with preserve_access_index attribute the above code is
reduced to just a clean and natural `x = p->pid;`.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/btf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index e5bc97b71ceb..60c75be0666d 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -370,6 +370,10 @@ static int dump_btf_c(const struct btf *btf,
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 
+	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
+	printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
+	printf("#endif\n\n");
+
 	if (root_type_cnt) {
 		for (i = 0; i < root_type_cnt; i++) {
 			err = btf_dump__dump_type(d, root_type_ids[i]);
@@ -386,6 +390,10 @@ static int dump_btf_c(const struct btf *btf,
 		}
 	}
 
+	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
+	printf("#pragma clang attribute pop\n");
+	printf("#endif\n");
+
 done:
 	btf_dump__free(d);
 	return err;
-- 
2.17.1

