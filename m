Return-Path: <SRS0=w44S=Q3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050DFC43381
	for <bpf@archiver.kernel.org>; Wed, 20 Feb 2019 20:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE842146E
	for <bpf@archiver.kernel.org>; Wed, 20 Feb 2019 20:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZqfbYpfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfBTU5k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:57:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59774 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbfBTU5k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Feb 2019 15:57:40 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KKuGjb029970
        for <bpf@vger.kernel.org>; Wed, 20 Feb 2019 12:57:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=qhjqh+vNiSi9hbpBka0/IdTd3X+ytXuX+TIJTZuTv5E=;
 b=ZqfbYpfQ6u5JR8H71jToKCYacqIBKeyW+NYQo0z5V9Ol1jgT+IuraBh3/cckRHXIi/Md
 ZQPvlR9CIDTcqaUFunOFCaENU3iQ3S+MfAaGyE7YiG1W3/jMm+LFic5/ZYDwKOMhldoB
 fTfkutBYo8Pk2LF0z2iPzY3T4z7or684qEE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qsd7e08qa-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Feb 2019 12:57:39 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 20 Feb 2019 12:57:35 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 2D0F9B3AA4B9; Wed, 20 Feb 2019 12:57:34 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <acme@kernel.org>,
        <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>, <ast@fb.com>,
        <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole 0/3] fix handling of bitfields in btf_loader
Date:   Wed, 20 Feb 2019 12:57:29 -0800
Message-ID: <20190220205732.2514975-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset fixes the logic of determining bitfield_offsets and 
initial bit_offset when using BTF type information. It eliminates all
the remaining discrepancies, when doing btfdiff on vmlinux image, module
two instances of incorrectly reporting struct member type name when
bitfield is the very first field in a struct, which is only happening 
when using DWARF data.

Patch #1 makes btfdiff script easier to use during local development.

Patch #2 fixes list of known base type names to handle clang-generated
type descriptions better.

Patch #3 fixes bitfield handling logic in btf_loader.

Andrii Nakryiko (3):
  btfdiff: support specifying custom pahole location
  pahole: complete list of base type names
  btf_loader: fix bitfield fixup code

 btf_loader.c | 21 ++++++++++++++-------
 btfdiff      |  5 +++--
 dwarves.c    |  3 +++
 3 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.17.1

