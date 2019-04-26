Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9D3C43218
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 00:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DED020878
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 00:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556238466;
	bh=Wqnk4oLsRyTScs9xtvymh571oWjBhUgwVKpTOLxSimQ=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=hpqTBPKtfdY5LT76yiYLJmge7RLAd5RejKxyZhL4rwFxtaCWV2inWL6XkJuI7iGna
	 wx3p3Ba+sPXlBuUKPeph15Bw0jv1ont93226udGJE/7sdJ6tIBA1VQk5UFgkkVtKPP
	 r3cZ7eFbBUOCQ/rWNs7NiBtnrRIgzCzfUqLk/F88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfDZA1q convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 25 Apr 2019 20:27:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44844 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726086AbfDZA1p (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Apr 2019 20:27:45 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3Q0E7x3001148
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 17:27:44 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2s3jrt92bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 17:27:44 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Apr 2019 17:27:43 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 84FB6760BB5; Thu, 25 Apr 2019 17:27:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: pull-request: bpf 2019-04-25
Date:   Thu, 25 Apr 2019 17:27:39 -0700
Message-ID: <20190426002739.1101826-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=759 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260001
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

The main changes are:

1) the bpf verifier fix to properly mark registers in all stack frames, from Paul.

2) preempt_enable_no_resched->preempt_enable fix, from Peter.

3) other misc fixes.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit c5b493ce192bd7a4e7bd073b5685aad121eeef82:

  net: bridge: multicast: use rcu to access port list from br_multicast_start_querier (2019-04-11 11:13:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to 0edd6b64d1939e9e9168ff27947995bb7751db5d:

  bpf: Fix preempt_enable_no_resched() abuse (2019-04-25 17:20:06 -0700)

----------------------------------------------------------------
Alban Crequy (1):
      tools: bpftool: fix infinite loop in map create

Matteo Croce (1):
      libbpf: add binary to gitignore

Paul Chaignon (2):
      bpf: mark registers in all frames after pkt/null checks
      selftests/bpf: test cases for pkt/null checks in subprogs

Peter Zijlstra (1):
      bpf: Fix preempt_enable_no_resched() abuse

YueHaibing (1):
      MIPS: eBPF: Make ebpf_to_mips_reg() static

 arch/mips/net/ebpf_jit.c                           |  5 +-
 include/linux/bpf.h                                |  2 +-
 kernel/bpf/verifier.c                              | 76 +++++++++++++---------
 tools/bpf/bpftool/map.c                            |  3 +
 tools/lib/bpf/.gitignore                           |  1 +
 tools/testing/selftests/bpf/verifier/calls.c       | 25 +++++++
 .../selftests/bpf/verifier/direct_packet_access.c  | 22 +++++++
 7 files changed, 101 insertions(+), 33 deletions(-)
