Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB58C4360F
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 00:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2702207E0
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 00:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ALswcTfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfCKAoU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 10 Mar 2019 20:44:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36196 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbfCKAoT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 10 Mar 2019 20:44:19 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2B0cV14022252
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2019 17:44:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=tfRD+comb/TbDh5iY2nxaPZTcPwMgLHSqGffZsxf94o=;
 b=ALswcTfUd2G/rMVl1sZVV7h4enhC7urwTUINlYPSj53qQEPppT3bkby03tqr+L3bYPCv
 CJUe+V2X90Yoj4SLZ4YT+xaOcgfJwQAYoAnxZvsJuisnlqhUW1/RC8IwSTKd5XR6ZvA5
 0PeIP03RMb4G7naiUnzHNwcpOq1/z8uhOgs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r59f80d8y-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2019 17:44:19 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sun, 10 Mar 2019 17:44:17 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id C8AC3861444; Sun, 10 Mar 2019 17:44:16 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/2] Add fwd enum resolution for btf_dedup()
Date:   Sun, 10 Mar 2019 17:44:08 -0700
Message-ID: <20190311004410.3896503-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-10_20:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds ability to resolve forward-declared enums into their
corresponding full enum definition types during type deduplication,
eliminating one of the reasons for having duplicated graphs of types.

Andrii Nakryiko (2):
  btf: resolve enum fwds in btf_dedup
  selftests/bpf: add fwd enum resolution test for btf_dedup

 tools/lib/bpf/btf.c                    | 51 +++++++++++++++++++-------
 tools/testing/selftests/bpf/test_btf.c | 44 ++++++++++++++++++++++
 2 files changed, 82 insertions(+), 13 deletions(-)

-- 
2.17.1

