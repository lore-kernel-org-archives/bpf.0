Return-Path: <SRS0=LLXA=UM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4C8C31E4A
	for <bpf@archiver.kernel.org>; Thu, 13 Jun 2019 16:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150E22082C
	for <bpf@archiver.kernel.org>; Thu, 13 Jun 2019 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560444603;
	bh=qIFmbdVhSizIQhcghdq4vGZjt9EfF77QhmVXEBdX5UQ=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=lc/QVDv0xYDHiTjm8a3aLwBPJPNyWiPo6XgUC6PklWOPR0EWM8wFKlkzMvZqaF/m9
	 SURNIIzl49kla9uSenO5IVLS1kW2NFYsbC9pUwudkjsW29Sk0IaZ/z9AwyKT/9BSIe
	 28oBH2gHmqAV8H0yblNyavynUkE15abf+Xl9xVpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFMQt7 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 13 Jun 2019 12:49:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbfFMEUL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jun 2019 00:20:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5D4HIHg010663
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2019 21:20:10 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2t3562209t-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2019 21:20:10 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 12 Jun 2019 21:20:07 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 53E23760CD6; Wed, 12 Jun 2019 21:20:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <ecree@solarflare.com>, <john.fastabend@gmail.com>,
        <andriin@fb.com>, <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/9] bpf: bounded loops and other features
Date:   Wed, 12 Jun 2019 21:19:54 -0700
Message-ID: <20190613042003.3791852-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=815 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130033
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

this patch set introduces verifier support for bounded loops and
adds several other improvements.
Ideally they would be introduced one at a time,
but to support bounded loop the verifier needs to 'step back'
in the patch 1. That patch introduces tracking of spill/fill
of constants through the stack. Though it's a useful feature
it hurts cilium tests.
Patch 3 introduces another feature by extending is_branch_taken
logic to 'if rX op rY' conditions. This feature is also
necessary to support bounded loops.
Then patch 4 adds support for the loops while adding
key heuristics with jmp_processed.
Introduction of parentage chain of verifier states in patch 4
allows patch 9 to add backtracking of precise scalar registers
which finally resolves degradation from patch 1.

The end result is much faster verifier for existing programs
and new support for loops.
See patch 8 for many kinds of loops that are now validated.
Patch 9 is the most tricky one and could be rewritten with
a different algorithm in the future.

Alexei Starovoitov (9):
  bpf: track spill/fill of constants
  selftests/bpf: fix tests due to const spill/fill
  bpf: extend is_branch_taken to registers
  bpf: introduce bounded loops
  bpf: fix callees pruning callers
  selftests/bpf: fix tests
  selftests/bpf: add basic verifier tests for loops
  selftests/bpf: add realistic loop tests
  bpf: precise scalar_value tracking

 include/linux/bpf_verifier.h                  |  69 +-
 kernel/bpf/verifier.c                         | 688 ++++++++++++++++--
 .../bpf/prog_tests/bpf_verif_scale.c          |  67 +-
 tools/testing/selftests/bpf/progs/loop1.c     |  28 +
 tools/testing/selftests/bpf/progs/loop2.c     |  28 +
 tools/testing/selftests/bpf/progs/loop3.c     |  22 +
 tools/testing/selftests/bpf/progs/pyperf.h    |   6 +-
 tools/testing/selftests/bpf/progs/pyperf600.c |   9 +
 .../selftests/bpf/progs/pyperf600_nounroll.c  |   8 +
 .../testing/selftests/bpf/progs/strobemeta.c  |  10 +
 .../testing/selftests/bpf/progs/strobemeta.h  | 528 ++++++++++++++
 .../bpf/progs/strobemeta_nounroll1.c          |   9 +
 .../bpf/progs/strobemeta_nounroll2.c          |   9 +
 .../selftests/bpf/progs/test_seg6_loop.c      | 261 +++++++
 .../selftests/bpf/progs/test_sysctl_loop1.c   |  68 ++
 .../selftests/bpf/progs/test_sysctl_loop2.c   |  69 ++
 .../selftests/bpf/progs/test_xdp_loop.c       | 231 ++++++
 tools/testing/selftests/bpf/test_verifier.c   |  11 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  22 +-
 tools/testing/selftests/bpf/verifier/cfg.c    |  11 +-
 .../bpf/verifier/direct_packet_access.c       |   3 +-
 .../bpf/verifier/helper_access_var_len.c      |  28 +-
 tools/testing/selftests/bpf/verifier/loops1.c | 161 ++++
 23 files changed, 2258 insertions(+), 88 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/loop1.c
 create mode 100644 tools/testing/selftests/bpf/progs/loop2.c
 create mode 100644 tools/testing/selftests/bpf/progs/loop3.c
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf600.c
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_nounroll.c
 create mode 100644 tools/testing/selftests/bpf/progs/strobemeta.c
 create mode 100644 tools/testing/selftests/bpf/progs/strobemeta.h
 create mode 100644 tools/testing/selftests/bpf/progs/strobemeta_nounroll1.c
 create mode 100644 tools/testing/selftests/bpf/progs/strobemeta_nounroll2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_seg6_loop.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_loop.c
 create mode 100644 tools/testing/selftests/bpf/verifier/loops1.c

-- 
2.20.0

