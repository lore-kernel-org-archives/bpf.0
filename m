Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD97EC10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 05:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A51218D2
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 05:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfDXFYZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:24:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33532 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728726AbfDXFYZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Apr 2019 01:24:25 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O5O3hP010365
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 22:24:23 -0700
Authentication-Results: fb.com;
        spf=pass smtp.mailfrom=andriin@fb.com
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s24kek6t2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 22:24:23 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 23 Apr 2019 22:24:22 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 637DC8615F5; Tue, 23 Apr 2019 22:22:03 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   <andrii.nakryiko@gmail.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <yhs@fb.com>, <songliubraving@fb.com>,
        <kafai@fb.com>, <acme@kernel.org>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/2] add btf dumping to bpftool
Date:   Tue, 23 Apr 2019 22:21:58 -0700
Message-ID: <20190424052200.1625142-1-andrii.nakryiko@gmail.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=851 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240046
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

This patch set adds a new `bpftool btf dump` sub-command, which allows to dump
BTF contents (only types for now). Currently it only outputs low-level
content, almost 1:1 with binary BTF format, but follow up patches will add
ability to dump BTF types as a compilable C header file. JSON output is
supported as well.

Patch #1 adds `btf` sub-command, dumping BTF types in human-readable format.
It also implements reading .BTF data from ELF file.
Patch #2 adds minimal documentation with output format examples and different
ways to specify source of BTF data.

Output format is mostly following existing format of BPF verifier log, but
deviates from it in few places. More details are in commit message for patch
#1.

Example of output for all supported BTF kinds are in patch #2 as part of
documentation. Some field names are quite verbose and I'd rather shorten them,
if we don't feel like being very close to BPF verifier names is a necessity,
but in this patch I left them exactly the same as in verifier log.

Andrii Nakryiko (2):
  bpftool: add ability to dump BTF types
  bpftool/docs: add btf sub-command documentation

 .../bpf/bpftool/Documentation/bpftool-btf.rst | 205 +++++++
 .../bpftool/Documentation/bpftool-cgroup.rst  |   3 +-
 .../bpftool/Documentation/bpftool-feature.rst |   3 +-
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 .../bpf/bpftool/Documentation/bpftool-net.rst |   3 +-
 .../bpftool/Documentation/bpftool-perf.rst    |   3 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   3 +-
 tools/bpf/bpftool/Documentation/bpftool.rst   |   3 +-
 tools/bpf/bpftool/btf.c                       | 576 ++++++++++++++++++
 tools/bpf/bpftool/main.c                      |   1 +
 tools/bpf/bpftool/main.h                      |   1 +
 11 files changed, 797 insertions(+), 7 deletions(-)
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-btf.rst
 create mode 100644 tools/bpf/bpftool/btf.c

-- 
2.17.1

