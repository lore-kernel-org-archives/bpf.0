Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28753C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 22:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE5C20643
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 22:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551133767;
	bh=jlyqaL5Fl2+K83Q81pHz1DivFyomD/oSWNN1KDeixfA=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=yvltdeyyFReyTXEKnERmtcnkq4Z5+XYhAfnyq1sKehI9MIml5xvgJ3ndr+qTZWvDW
	 6YZnzTpSwAOIwYWD8uspvew4Hz2z7V0VTEOoSYrkj2Jq+3mCcc939UTBF3WKz6WXAB
	 7vM7oZaaMfTrxhb9ODRm1UpUXKww3RS+8HTivYCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfBYW30 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 25 Feb 2019 17:29:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46096 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727437AbfBYW30 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Feb 2019 17:29:26 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PMDRBe028106
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 14:29:25 -0800
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvpqurhyw-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 14:29:25 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 25 Feb 2019 14:28:42 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 0FCC976091F; Mon, 25 Feb 2019 14:28:42 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <edumazet@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 0/4] bpf: per program stats
Date:   Mon, 25 Feb 2019 14:28:38 -0800
Message-ID: <20190225222842.2031962-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce per program stats to monitor the usage BPF

v2->v3:
- rename to run_time_ns/run_cnt everywhere

v1->v2:
- fixed u64 stats on 32-bit archs. Thanks Eric
- use more verbose run_time_ns in json output as suggested by Andrii
- refactored prog_alloc and clarified behavior of stats in subprogs

Alexei Starovoitov (4):
  bpf: enable program stats
  bpf: expose program stats via bpf_prog_info
  tools/bpf: sync bpf.h into tools
  tools/bpftool: recognize bpf_prog_info run_time_ns and run_cnt

 include/linux/bpf.h                           |  9 +++++
 include/linux/filter.h                        | 20 +++++++++-
 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/core.c                             | 31 ++++++++++++++-
 kernel/bpf/syscall.c                          | 39 ++++++++++++++++++-
 kernel/bpf/verifier.c                         |  7 +++-
 kernel/sysctl.c                               | 34 ++++++++++++++++
 .../bpftool/Documentation/bpftool-prog.rst    |  4 +-
 tools/bpf/bpftool/prog.c                      |  7 ++++
 tools/include/uapi/linux/bpf.h                |  2 +
 10 files changed, 148 insertions(+), 7 deletions(-)

-- 
2.20.0

