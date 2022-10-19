Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5A6C433FE
	for <bpf@archiver.kernel.org>; Wed, 19 Oct 2022 00:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJSAcN convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 18 Oct 2022 20:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJSAcM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 20:32:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74CED73F1
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:32:11 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29J03x8j024405
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:32:11 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3k92jvwvc2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:32:10 -0700
Received: from twshared58292.03.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 17:32:09 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 15B272051286F; Tue, 18 Oct 2022 17:32:04 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/3] libbpf: support non-mmap()'able data sections
Date:   Tue, 18 Oct 2022 17:28:13 -0700
Message-ID: <20221019002816.359650-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6YihklH1BtaoOuQecDH1eFz1zKhjKOv5
X-Proofpoint-GUID: 6YihklH1BtaoOuQecDH1eFz1zKhjKOv5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_09,2022-10-18_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf more conservative in using BPF_F_MMAPABLE flag with internal BPF
array maps that are backing global data sections. See patch #2 for full
description and justification.

Changes in this dataset support having bpf_spinlock, kptr, rb_tree nodes and
other "special" variables as global variables. Combining this with libbpf's
existing support for multiple custom .data.* sections allows BPF programs to
utilize multiple spinlock/rbtree_node/kptr variables in a pretty natural way
by just putting all such variables into separate data sections (and thus ARRAY
maps).

v1->v2:
  - address Stanislav's feedback, adds acks.

Andrii Nakryiko (3):
  libbpf: clean up and refactor BTF fixup step
  libbpf: only add BPF_F_MMAPABLE flag for data maps with global vars
  libbpf: add non-mmapable data section selftest

 tools/lib/bpf/libbpf.c                        | 177 +++++++++++-------
 .../selftests/bpf/prog_tests/skeleton.c       |  11 +-
 .../selftests/bpf/progs/test_skeleton.c       |  17 ++
 3 files changed, 139 insertions(+), 66 deletions(-)

-- 
2.30.2

