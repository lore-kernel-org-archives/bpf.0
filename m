Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED67C4360F
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0952133D
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QsfzrwxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbfB1Spf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:45:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48576 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731163AbfB1Spe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 13:45:34 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SISPFD029940
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 10:45:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=uZuDycgbSWTcXYd7s51klFS9UPLxs+lBNHeButsandg=;
 b=QsfzrwxPEio1Wi2xQ3J6w/6gA54jr59ajEiR10DNwO4kW6WyyarNBs/pVOadw1Fr+HTp
 lHboWKt2RLb4bedsliskr2YrFQad0VRB+rEAA2FCn+cgDgHzFRJE8Y4pKRkMUD9di73T
 LJ0GdN738WOfv2QVEtz3csyz7i8KTg5LUXY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxk5k0j0a-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 10:45:34 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 28 Feb 2019 10:45:30 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id B1D93C1290BD; Thu, 28 Feb 2019 10:45:29 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/4] bpf docs and comments typo and formatting fixes
Date:   Thu, 28 Feb 2019 10:45:08 -0800
Message-ID: <20190228184512.198075-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A bunch of BPF-related typo, formatting, and documentation fixes.

Andrii Nakryiko (4):
  docs/btf: fix typos, improve wording
  docs/btf: reflow text to fill up to 78 characters
  bpf: fix formatting, typos, reflow comments in syscall.c, verifier.c
  docs/bpf: minor fixes

 Documentation/bpf/bpf_design_QA.rst |  24 +--
 Documentation/bpf/btf.rst           | 316 +++++++++++++---------------
 Documentation/networking/filter.txt |   2 +-
 kernel/bpf/syscall.c                |   5 +-
 kernel/bpf/verifier.c               | 169 ++++++++-------
 5 files changed, 247 insertions(+), 269 deletions(-)

-- 
2.17.1

