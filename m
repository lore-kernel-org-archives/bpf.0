Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB32C4332F
	for <bpf@archiver.kernel.org>; Wed,  2 Nov 2022 06:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKBGWn convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 2 Nov 2022 02:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiKBGWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 02:22:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8442D25E86
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 23:22:37 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A25BQsL007258
        for <bpf@vger.kernel.org>; Tue, 1 Nov 2022 23:22:36 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kjvgscc53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 23:22:36 -0700
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 23:22:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 62C3A20F58A14; Tue,  1 Nov 2022 23:22:23 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/6] BPF verifier precision tracking improvements
Date:   Tue, 1 Nov 2022 23:22:15 -0700
Message-ID: <20221102062221.2019833-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZKer9n_9JA1YO1DjLm-LAbrz6XlMFzYH
X-Proofpoint-GUID: ZKer9n_9JA1YO1DjLm-LAbrz6XlMFzYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_02,2022-11-01_02,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set fixes and improves BPF verifier's precision tracking logic for
SCALAR registers.

Patches #1 and #2 are bug fixes discovered while working on these changes.

Patch #3 enables precision tracking for BPF programs that contain subprograms.
This was disabled before and prevent any modern BPF programs that use
subprograms from enjoying the benefits of SCALAR (im)precise logic.

Patch #4 is few lines of code changes and many lines of explaining why those
changes are correct. We establish why ignoring precise markings in current
state is OK.

Patch #5 build on explanation in patch #4 and pushes it to the limit by
forcefully forgetting inherited precise markins. Patch #4 by itself doesn't
prevent current state from having precise=true SCALARs, so patch #5 is
necessary to prevent such stray precise=true registers from creeping in.

Patch #6 adjusts test_align selftests to work around BPF verifier log's
limitations when it comes to interactions between state output and precision
backtracking output.

Overall, the goal of this patch set is to make BPF verifier's state tracking
a bit more efficient by trying to preserve as much generality in checkpointed
states as possible.

Andrii Nakryiko (6):
  bpf: propagate precision in ALU/ALU64 operations
  bpf: propagate precision across all frames, not just the last one
  bpf: allow precision tracking for programs with subprogs
  bpf: stop setting precise in current state
  bpf: aggressively forget precise markings during state checkpointing
  selftests/bpf: make test_align selftest more robust

 kernel/bpf/verifier.c                         | 277 +++++++++++++++---
 .../testing/selftests/bpf/prog_tests/align.c  |  38 ++-
 2 files changed, 256 insertions(+), 59 deletions(-)

-- 
2.30.2

