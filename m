Return-Path: <SRS0=ogH5=QY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D79C10F06
	for <bpf@archiver.kernel.org>; Sun, 17 Feb 2019 08:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653982192D
	for <bpf@archiver.kernel.org>; Sun, 17 Feb 2019 08:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N+XsosXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfBQIU2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 17 Feb 2019 03:20:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59252 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbfBQIU2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 17 Feb 2019 03:20:28 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1H8BjW4005650
        for <bpf@vger.kernel.org>; Sun, 17 Feb 2019 00:20:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ascpInR4w/FZLXjmCHAYPmARgdoGMbPB6CGJlNdRT/o=;
 b=N+XsosXEw+k67QuH2BxRX7xyOvCX/nUznyBBLLVuHIEbpLnS8H3jQJVqMbaFS7OIE6qU
 E2iKOosZcdn99U+szAApebU6C6tDTnBeo0yqtiRzoYfnlrbuPujNvK/l8ZleNbVoLua+
 WUQagmANrDcFnQ1a/5BzVTbguD/+b3gxTOE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2qpmdd9uwv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 17 Feb 2019 00:20:27 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Sun, 17 Feb 2019 00:20:25 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 41052B10C283; Sun, 17 Feb 2019 00:20:25 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <acme@kernel.org>, <ast@fb.com>, <dwarves@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole 0/2] Add support for BTF deduplication
Date:   Sun, 17 Feb 2019 00:20:16 -0800
Message-ID: <20190217082018.1008069-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-17_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds btf_dedup() support during DWARF to BTF conversion.

Andrii Nakryiko (2):
  libbpf: pull latest libbpf and build libbpf as shared lib
  btf_encoder: run BTF deduplication before writing out to ELF

 CMakeLists.txt | 13 +++++++++----
 lib/bpf        |  2 +-
 libbtf.c       | 44 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 44 insertions(+), 15 deletions(-)

-- 
2.17.1

