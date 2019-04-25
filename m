Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCD6C43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF76420717
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JnUb7Nf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfDYWaP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:30:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbfDYWaP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Apr 2019 18:30:15 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3PMRZnE014442
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 15:30:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=facebook;
 bh=hmgR+K17iJJPVc+DqOe+8ldGDoyTwCUiNAYUrqn97R0=;
 b=JnUb7Nf+lo5JqPIm1wbvBV5dq24ZTSclmKWGBzKDDKNcgFDpmxOftV0HP+HclP8Mb5P1
 9lhODuNgm4XPAqhmZZtPPlFCLP3kBQNeWmPVsuYbWCwDN4eewDJaZzOP/vw3wrscLpc7
 tDghh2pfyreBfTpyLCVFI2fOKcDL8H9MLSA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2s3bspjdvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 15:30:13 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 25 Apr 2019 15:30:12 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id EC4748615AE; Thu, 25 Apr 2019 15:30:11 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 0/4] add btf dumping to bpftool
Date:   Thu, 25 Apr 2019 15:30:07 -0700
Message-ID: <20190425223011.284686-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_18:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds a new `bpftool btf dump` sub-command, which allows to dump
BTF contents (only types for now). Currently it only outputs low-level
content, almost 1:1 with binary BTF format, but follow up patches will add
ability to dump BTF types as a compilable C header file. JSON output is
supported as well.

Patch #1 adds `btf` sub-command, dumping BTF types in human-readable format.
It also implements reading .BTF data from ELF file.
Patch #2 adds minimal documentation with output format examples and different
ways to specify source of BTF data.
Patch #3 adds support for btf command in bash-completion/bpftool script.
Patch #4 fixes minor indentation issue in bash-completion script.

Output format is mostly following existing format of BPF verifier log, but
deviates from it in few places. More details are in commit message for patch
#1.

Example of output for all supported BTF kinds are in patch #2 as part of
documentation. Some field names are quite verbose and I'd rather shorten them,
if we don't feel like being very close to BPF verifier names is a necessity,
but in this patch I left them exactly the same as in verifier log.

v3->v4:
  - reverse Christmas tree (Quentin)
  - better docs (Quentin)

v2->v3:
  - make map's key|value|kv|all suggestion more precise (Quentin)
  - fix default case indentations (Quentin)

v1->v2:
  - fix unnecessary trailing whitespaces in bpftool-btf.rst (Yonghong)
  - add btf in main.c for a list of possible OBJECTs
  - handle unknown keyword under `bpftool btf dump` (Yonghong)

Andrii Nakryiko (4):
  bpftool: add ability to dump BTF types
  bpftool/docs: add btf sub-command documentation
  bpftool: add bash completions for btf command
  bpftool: fix indendation in bash-completion/bpftool

 .../bpf/bpftool/Documentation/bpftool-btf.rst | 222 +++++++
 .../bpftool/Documentation/bpftool-cgroup.rst  |   3 +-
 .../bpftool/Documentation/bpftool-feature.rst |   3 +-
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 .../bpf/bpftool/Documentation/bpftool-net.rst |   3 +-
 .../bpftool/Documentation/bpftool-perf.rst    |   3 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   3 +-
 tools/bpf/bpftool/Documentation/bpftool.rst   |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  68 +-
 tools/bpf/bpftool/btf.c                       | 586 ++++++++++++++++++
 tools/bpf/bpftool/main.c                      |   3 +-
 tools/bpf/bpftool/main.h                      |   1 +
 12 files changed, 882 insertions(+), 19 deletions(-)
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-btf.rst
 create mode 100644 tools/bpf/bpftool/btf.c

-- 
2.17.1

