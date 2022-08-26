Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE1ECAAD5
	for <bpf@archiver.kernel.org>; Fri, 26 Aug 2022 23:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbiHZXPr convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 26 Aug 2022 19:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345467AbiHZXPq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 19:15:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A7ED51D5
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 16:15:45 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIP7xZ003863
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 16:15:44 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6yw0bc51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 16:15:44 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 16:15:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CF06B1E283E33; Fri, 26 Aug 2022 16:15:33 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/3] BPF mass-verification veristat tool
Date:   Fri, 26 Aug 2022 16:15:28 -0700
Message-ID: <20220826231531.1031943-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ERtAK2DX90SG2T1s_jEESZYaazTjoJqA
X-Proofpoint-ORIG-GUID: ERtAK2DX90SG2T1s_jEESZYaazTjoJqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a simple mass-verification and stats collection tool, veristat, to
selftests/bpf for use by everyone. See patch #3 for some more details.

Patch #1 fixes two BPF objects to be more usable with veristat.

Patch #2 fixes libbpf bug which also was discovered trying to mass-verify
a bunch of internal Meta BPF object files.

Andrii Nakryiko (3):
  selftests/bpf: fix test_verif_scale{1,3} SEC() annotations
  libbpf: fix crash if SEC("freplace") programs don't have
    attach_prog_fd set
  selftests/bpf: add veristat tool for mass-verifying BPF object files

 tools/lib/bpf/libbpf.c                        |  13 +-
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   6 +-
 .../selftests/bpf/progs/test_verif_scale1.c   |   2 +-
 .../selftests/bpf/progs/test_verif_scale3.c   |   2 +-
 tools/testing/selftests/bpf/veristat.c        | 541 ++++++++++++++++++
 6 files changed, 558 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/veristat.c

-- 
2.30.2

