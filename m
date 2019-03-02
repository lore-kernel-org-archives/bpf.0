Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65EBC4360F
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 05:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9092085A
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 05:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551504943;
	bh=+5VHo6L1/Qb8MG7Dpjf+ZwqRt2owjxbfbA9hJKn5aXM=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=RS0l+XgaortJzZC0TrxgfVeCS0vV9ZIoCooVPocUFErydpELAHHwdXWPvs5MwfhAH
	 /gUN78nqWj5USMM+FJ5yIiauqWGK470NM5uErslSRZTCtxtg6vTi6gAaZPQE6VYYpd
	 Z+lpLZQVQESI0q1d4eez1LxxMhEyQRn+TZGmQnRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfCBFfm convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 2 Mar 2019 00:35:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46560 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727470AbfCBFfm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 2 Mar 2019 00:35:42 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x225ZF2U032562
        for <bpf@vger.kernel.org>; Fri, 1 Mar 2019 21:35:41 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qyj0br9xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 21:35:41 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 1 Mar 2019 21:35:39 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 8EAB0760E00; Fri,  1 Mar 2019 21:35:38 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: pull-request: bpf 2019-03-01
Date:   Fri, 1 Mar 2019 21:35:38 -0800
Message-ID: <20190302053538.642410-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-02_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

The main changes are:

1) fix sanitation rewrite, from Daniel.

2) fix error path on map_new_fd, from Peng.

3) fix icache flush address, from Paul.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit 3da1ed7ac398f34fff1694017a07054d69c5f5c5:

  net: avoid use IPCB in cipso_v4_error (2019-02-25 14:32:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to 3612af783cf52c74a031a2f11b82247b2599d3cd:

  bpf: fix sanitation rewrite in case of non-pointers (2019-03-01 21:24:08 -0800)

----------------------------------------------------------------
Daniel Borkmann (1):
      bpf: fix sanitation rewrite in case of non-pointers

Paul Burton (1):
      MIPS: eBPF: Fix icache flush end address

Peng Sun (2):
      bpf: decrease usercnt if bpf_map_new_fd() fails in bpf_map_get_fd_by_id()
      bpf: drop refcount if bpf_map_new_fd() fails in map_create()

 arch/mips/net/ebpf_jit.c | 2 +-
 kernel/bpf/syscall.c     | 6 +++---
 kernel/bpf/verifier.c    | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)
