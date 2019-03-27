Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F0AC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 02:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C942420811
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 02:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553653667;
	bh=q19yY20sLcqOGeAFZPBdUhGWqTR1ZqM5Been7b3Q7qg=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=nzV+C8+GeExYctoPOzRJcgA0YhRh6UM/KY0ClAIm2la6nnkpXjqnWAmip/f5t7rE7
	 DjE/rksPx4ahLdVE2bxn1i+x1IclYfat89vnKsdELPjC8uCwiX29Aquy5p5tB/oyHa
	 Rpf9EwQyN7dhPzMZ50UldUHRkbYxkmavjtEdenxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfC0C1r convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 26 Mar 2019 22:27:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37436 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731754AbfC0C1r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Mar 2019 22:27:47 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2R2IG3N017795
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 19:27:45 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2rfx6n8gd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 19:27:45 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 26 Mar 2019 19:27:44 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id F368B760BAD; Tue, 26 Mar 2019 19:27:43 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: pull-request: bpf-next 2019-03-26
Date:   Tue, 26 Mar 2019 19:27:43 -0700
Message-ID: <20190327022743.2128471-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net-next* tree.

The main changes are:

1) introduce bpf_tcp_check_syncookie() helper for XDP and tc, from Lorenz.

2) allow bpf_skb_ecn_set_ce() in tc, from Peter.

3) numerous bpf tc tunneling improvements, from Willem.

4) and other miscellaneous improvements from Adrian, Alan, Daniel, Ivan, Stanislav.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit a534ea30e70fc51c4cef31c0683955dd8a568a11:

  net: isdn: Make isdn_ppp_mp_discard and isdn_ppp_mp_reassembly static (2019-03-20 12:25:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 

for you to fetch changes up to b4b6aa83433ea4675d4ba1be56774623db81f14f:

  selftests: bpf: don't depend on hardcoded perf sample_freq (2019-03-26 12:47:41 -0700)

----------------------------------------------------------------
Adrian Ratiu (1):
      selftests/bpf: Add arm target register definitions

Alan Maguire (1):
      bpf: test_tc_tunnel.sh needs reverse path filtering disabled

Alexei Starovoitov (2):
      Merge branch 'bpf_tcp_check_syncookie'
      Merge branch 'bpf-tc-tunneling'

Daniel T. Lee (1):
      samples: bpf: add xdp_sample_pkts to .gitignore

Ivan Vecera (1):
      selftests: bpf: modify urandom_read and link it non-statically

Lorenz Bauer (8):
      bpf: track references based on is_acquire_func
      bpf: allow helpers to return PTR_TO_SOCK_COMMON
      bpf: add skc_lookup_tcp helper
      bpf: add helper to check for a valid SYN cookie
      tools: update include/uapi/linux/bpf.h
      selftests/bpf: allow specifying helper for BPF_SK_LOOKUP
      selftests/bpf: test references to sock_common
      selftests/bpf: add tests for bpf_tcp_check_syncookie and bpf_skc_lookup_tcp

Peter Oskolkov (2):
      bpf: make bpf_skb_ecn_set_ce callable from BPF_PROG_TYPE_SCHED_ACT
      selftests: bpf: tc-bpf flow shaping with EDT

Stanislav Fomichev (1):
      selftests: bpf: don't depend on hardcoded perf sample_freq

Willem de Bruijn (14):
      bpf: in bpf_skb_adjust_room avoid copy in tx fast path
      selftests/bpf: bpf tunnel encap test
      selftests/bpf: expand bpf tunnel test with decap
      selftests/bpf: expand bpf tunnel test to ipv6
      selftests/bpf: extend bpf tunnel test with gre
      selftests/bpf: extend bpf tunnel test with tso
      bpf: add bpf_skb_adjust_room mode BPF_ADJ_ROOM_MAC
      bpf: add bpf_skb_adjust_room flag BPF_F_ADJ_ROOM_FIXED_GSO
      bpf: add bpf_skb_adjust_room encap flags
      bpf: Sync bpf.h to tools
      selftests/bpf: convert bpf tunnel test to BPF_ADJ_ROOM_MAC
      selftests/bpf: convert bpf tunnel test to BPF_F_ADJ_ROOM_FIXED_GSO
      selftests/bpf: convert bpf tunnel test to encap modes
      bpf: silence uninitialized var warning in bpf_skb_net_grow

 include/linux/bpf.h                                |   1 +
 include/uapi/linux/bpf.h                           |  65 +++-
 kernel/bpf/verifier.c                              |  33 +-
 net/core/filter.c                                  | 350 ++++++++++++++++++---
 samples/bpf/.gitignore                             |   1 +
 tools/include/uapi/linux/bpf.h                     |  65 +++-
 tools/testing/selftests/bpf/.gitignore             |   1 +
 tools/testing/selftests/bpf/Makefile               |   9 +-
 tools/testing/selftests/bpf/bpf_helpers.h          |  26 ++
 tools/testing/selftests/bpf/config                 |   2 +
 .../bpf/prog_tests/stacktrace_build_id_nmi.c       |  16 +-
 tools/testing/selftests/bpf/progs/test_tc_edt.c    | 109 +++++++
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 261 +++++++++++++++
 .../bpf/progs/test_tcp_check_syncookie_kern.c      | 129 ++++++++
 tools/testing/selftests/bpf/test_tc_edt.sh         |  99 ++++++
 tools/testing/selftests/bpf/test_tc_tunnel.sh      | 186 +++++++++++
 .../selftests/bpf/test_tcp_check_syncookie.sh      |  81 +++++
 .../selftests/bpf/test_tcp_check_syncookie_user.c  | 212 +++++++++++++
 tools/testing/selftests/bpf/test_verifier.c        |   6 +-
 tools/testing/selftests/bpf/urandom_read.c         |  15 +-
 .../testing/selftests/bpf/verifier/ref_tracking.c  | 126 +++++---
 tools/testing/selftests/bpf/verifier/unpriv.c      |   8 +-
 22 files changed, 1673 insertions(+), 128 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_edt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_tunnel.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
 create mode 100755 tools/testing/selftests/bpf/test_tc_edt.sh
 create mode 100755 tools/testing/selftests/bpf/test_tc_tunnel.sh
 create mode 100755 tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
 create mode 100644 tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
