Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D813FC4360F
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 00:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D76F21873
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 00:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CbEn44mA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfBZAI1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:08:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54676 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbfBZAI1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Feb 2019 19:08:27 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1Q04apq022244
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 16:08:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ReFMZI0mwetGzJqj03s+kjFc9jfvXV5zKKa4mLNQZLI=;
 b=CbEn44mAoCRlOp3t5RbxSuYc2HVSFRxqXN7V72cJ/GfOwJ9fW3yufe6vB1SPVWHJp0Ov
 XP4OObbtmhuYkd9hKAeRgsoikVw91oieXGFQDo9DPraDDaoOiGaiK/e2nu5pF617UNn9
 lbc12/kzJRr+KNpIkOvN+Ka+S8qQK0RBA3o= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvs1y8as1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 16:08:26 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 25 Feb 2019 16:08:24 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id F0CC4BBAF820; Mon, 25 Feb 2019 16:08:22 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <acme@kernel.org>, <yhs@fb.com>, <ast@fb.com>,
        <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>,
        <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole 0/2] fix two more DWARF/BTF discrepancies
Date:   Mon, 25 Feb 2019 16:08:13 -0800
Message-ID: <20190226000815.385229-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset fixes two more issues where DWARF/BTF encoding/loading
produce different result:
  - patch #1 fixes incorrect handling of "unknown" base types;
  - patch #2 fixes incorrect handling of packed enums during encoding.

Andrii Nakryiko (2):
  btf_loader: simplify fixup code by relying on BTF data more
  btf_encoder: don't special case packed enums

 btf_encoder.c |  9 --------
 btf_loader.c  | 59 ++++++++++-----------------------------------------
 2 files changed, 11 insertions(+), 57 deletions(-)

-- 
2.17.1

