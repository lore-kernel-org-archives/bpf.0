Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11EBC6FD1D
	for <bpf@archiver.kernel.org>; Mon, 27 Mar 2023 18:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjC0SwT convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 27 Mar 2023 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjC0SwS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:52:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFAC2D52
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:52:15 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32REKovt004731
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:52:15 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3phxnuu6m0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:52:15 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 11:52:12 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 46F752C1D3DB0; Mon, 27 Mar 2023 11:52:03 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 0/3] veristat: add better support of freplace programs
Date:   Mon, 27 Mar 2023 11:51:59 -0700
Message-ID: <20230327185202.1929145-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: r4VM8piAIT8f6bY76DRecm1jtpEmBmi8
X-Proofpoint-ORIG-GUID: r4VM8piAIT8f6bY76DRecm1jtpEmBmi8
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Teach veristat how to deal with freplace BPF programs. As they can't be
directly loaded by veristat without custom user-space part that sets correct
target program FD, veristat always fails freplace programs. This patch set
teaches veristat to guess target program type that will be inherited by
freplace program itself, and subtitute it for BPF_PROG_TYPE_EXT (freplace) one
for the purposes of BPF verification.

Patch #1 fixes bug in libbpf preventing overriding freplace with specific
program type.

Patch #2 adds convenient -d flag to request veristat to emit libbpf debug
logs. It help debugging why a specific BPF program fails to load, if the
problem is not due to BPF verification itself.

v3->v4:
  - fix optional kern_name check when guessing prog type (Alexei);
v2->v3:
  - fix bpf_obj_id selftest that uses legacy bpf_prog_test_load() helper,
    which always sets program type programmatically; teach the helper to do it
    only if actually necessary (Stanislav);
v1->v2:
  - fix compilation error reported by old GCC (my GCC v11 doesn't produce even
    a warning) and Clang (see CI failure at [0]):

GCC version:

  veristat.c: In function ‘fixup_obj’:
  veristat.c:908:1: error: label at end of compound statement
    908 | skip_freplace_fixup:
        | ^~~~~~~~~~~~~~~~~~~

Clang version:

  veristat.c:909:1: error: label at end of compound statement is a C2x extension [-Werror,-Wc2x-extensions]
  }
  ^
  1 error generated.

  [0] https://github.com/kernel-patches/bpf/actions/runs/4515972059/jobs/7953845335

Andrii Nakryiko (3):
  libbpf: disassociate section handler on explicit
    bpf_program__set_type() call
  veristat: add -d debug mode option to see debug libbpf log
  veristat: guess and substitue underlying program type for freplace
    (EXT) progs

 tools/lib/bpf/libbpf.c                        |   1 +
 tools/testing/selftests/bpf/testing_helpers.c |   2 +-
 tools/testing/selftests/bpf/veristat.c        | 129 +++++++++++++++++-
 3 files changed, 126 insertions(+), 6 deletions(-)

-- 
2.34.1

