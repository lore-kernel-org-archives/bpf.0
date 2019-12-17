Return-Path: <SRS0=5bl/=2H=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C7C3F68F
	for <bpf@archiver.kernel.org>; Tue, 17 Dec 2019 05:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131C82146E
	for <bpf@archiver.kernel.org>; Tue, 17 Dec 2019 05:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GBIP0L3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfLQFgd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:36:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49928 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbfLQFgd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Dec 2019 00:36:33 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBH5ZsMo009509
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2019 21:36:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=EXJijzeCZmLQdRRgw+cJlOxlJyTcWIUyIsJZiZ18rbE=;
 b=GBIP0L3omfPfNYUfJ5tGZd29mnTV9GaOw3iuvaSPhCOR9RwPF844hPQp0kWrBdz+j9qZ
 0Sdmh62pxgOsxN7mqD+PsE+n7UzpDx3MTKwCunGLFlHGeUsK7lOmdhXByRI6NbtgHd99
 j9B4FTw/8QEcynu8SlcSMjDJ1te/6CjitH4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wwgsmqvdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2019 21:36:32 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Dec 2019 21:36:30 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 4A3342EC1AFA; Mon, 16 Dec 2019 21:36:28 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/3] Skeleton improvements and documnetation
Date:   Mon, 16 Dec 2019 21:36:23 -0800
Message-ID: <20191217053626.2158870-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=8 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170050
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Simplify skeleton usage by embedding source BPF object file inside skeleton
itself. This allows to keep skeleton and object file in sync at all times with
no chance of confusion.

Also, add bpftool-gen.rst manpage, explaining concepts and ideas behind
skeleton. In examples section it also includes a complete small BPF
application utilizing skeleton, as a demonstration of API.

Patch #2 also removes BPF_EMBED_OBJ, as there is currently no use of it.

Andrii Nakryiko (3):
  bpftool, selftests/bpf: embed object file inside skeleton
  libbpf: remove BPF_EMBED_OBJ macro from libbpf.h
  bpftool: add gen subcommand manpage

 .../bpf/bpftool/Documentation/bpftool-gen.rst | 302 ++++++++++++++++++
 tools/bpf/bpftool/Documentation/bpftool.rst   |   3 +-
 tools/bpf/bpftool/gen.c                       | 226 ++++++++-----
 tools/lib/bpf/libbpf.h                        |  35 --
 .../selftests/bpf/prog_tests/attach_probe.c   |   4 +-
 .../selftests/bpf/prog_tests/core_extern.c    |   4 +-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  10 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |   7 +-
 tools/testing/selftests/bpf/prog_tests/mmap.c |   4 +-
 .../selftests/bpf/prog_tests/skeleton.c       |   4 +-
 .../bpf/prog_tests/stacktrace_build_id.c      |   4 +-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  |   4 +-
 12 files changed, 456 insertions(+), 151 deletions(-)
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-gen.rst

-- 
2.17.1

