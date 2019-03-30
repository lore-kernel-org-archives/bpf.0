Return-Path: <SRS0=8uh4=SB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC7CC43381
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 00:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799E821773
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 00:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553904977;
	bh=XhioONOWds2O47ZkIndCsbQkZz+KJllW55+x2aFliC0=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=qGp1xpXMsgmHXJcmmMzwTuKR+nZHXDrfMBsmN9Qnj6K/jpEJ0sx6ocHoXdpEYONTk
	 vZDJfO6T8JwqksKRSK9gxLmt3iRUnl9nOC/mi7QbYWJYY5hMaxj2OwaHQU5ENKuNEZ
	 4nEk8dy8hayosYfc/qd85pE5uRFk619Piw30dnPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfC3AQR convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 29 Mar 2019 20:16:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49462 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729771AbfC3AQR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Mar 2019 20:16:17 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U0F1TU024981
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 17:16:15 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rhwcr02b6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 17:16:15 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 29 Mar 2019 17:16:14 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 8FB24760BC0; Fri, 29 Mar 2019 17:16:12 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/7] bpf: improve verifier scalability
Date:   Fri, 29 Mar 2019 17:16:05 -0700
Message-ID: <20190330001612.2354959-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Realize two key ideas to speed up verification speed by ~20 times
1. every 'branching' instructions records all verifier states.
   not all of them are useful for search pruning.
   add a simple heuristic to keep states that were successful in search pruning
   and remove those that were not
2. mark_reg_read walks parentage chain of registers to mark parents as LIVE_READ.
   Once the register is marked there is no need to remark it again in the future.
   Hence stop walking the chain once first LIVE_READ is seen.

1st optimization gives 10x speed up on large programs
and 2nd optimization reduces the cost of mark_reg_read from ~40% of cpu to <1%.
Combined the deliver ~20x speedup on large programs.

Faster and bounded verification time allows to increase insn_processed
limit to 1 million from 130k.
Worst case it takes 1/10 of a second to process that many instructions
and peak memory consumption is peak_states * sizeof(struct bpf_verifier_state)
which is around ~5Mbyte.

Increase insn_per_program limit for root to insn_processed limit.

Add verification stats and stress tests for verifier scalability.

This patch set is the first step to be able to accept large programs.
The verifier still suffers from its brute force algorithm and
large programs can easily hit 1M insn_processed limit.
A lot more work is necessary to be able to verify large programs.

Alexei Starovoitov (7):
  bpf: add verifier stats and log_level bit 2
  bpf: improve verification speed by droping states
  bpf: improve verification speed by not remarking live_read
  bpf: increase complexity limit and maximum program size
  bpf: increase verifier log limit
  libbpf: teach libbpf about log_level bit 2
  selftests/bpf: add few verifier scale tests

 include/linux/bpf.h                           |   1 +
 include/linux/bpf_verifier.h                  |  23 +++
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         | 132 ++++++++++++++----
 tools/lib/bpf/bpf.c                           |   2 +-
 tools/lib/bpf/bpf.h                           |   2 +-
 tools/lib/bpf/libbpf.c                        |  16 ++-
 tools/lib/bpf/libbpf.h                        |   1 +
 .../bpf/prog_tests/bpf_verif_scale.c          |  49 +++++++
 .../testing/selftests/bpf/progs/test_jhash.h  |  70 ++++++++++
 .../selftests/bpf/progs/test_verif_scale1.c   |  30 ++++
 .../selftests/bpf/progs/test_verif_scale2.c   |  30 ++++
 .../selftests/bpf/progs/test_verif_scale3.c   |  30 ++++
 tools/testing/selftests/bpf/test_progs.c      |   6 +-
 tools/testing/selftests/bpf/test_progs.h      |   1 +
 15 files changed, 361 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_jhash.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale1.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale3.c

-- 
2.20.0

