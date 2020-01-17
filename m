Return-Path: <SRS0=dKsF=3G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2765C33CB1
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 06:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8A12072B
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 06:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rpkz3eON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAQGIM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 17 Jan 2020 01:08:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18562 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgAQGIL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jan 2020 01:08:11 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00H651NA026226
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 22:08:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=7Dw7HIpmKvtHofKmBr8afkFIByJRi7dgdSnP8XhdMm4=;
 b=rpkz3eON2N0Kbk8S/GnuFbs8L61qvbcbB2iAv8rwH+kjC0aOI0wT3CDI1fqvpg6Unxv6
 0MraDjNRAxpydKXzBjoJCuaAeod2d7H698dytwc2iYxSAhV9NhuxB15k4lToXZ9h4589
 ytZOz/Tgq7aHXqbPvQf4tgFOaFrpo/89mBA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xk0s1hc7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 22:08:10 -0800
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jan 2020 22:08:09 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id C2C3B2EC1745; Thu, 16 Jan 2020 22:08:03 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/4] Fix few unrelated small bugs and issues
Date:   Thu, 16 Jan 2020 22:07:57 -0800
Message-ID: <20200117060801.1311525-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_06:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=597 suspectscore=8 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001170047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix few unrelated issues, found by static analysis tools (performed against
libbpf's Github repo). Also fix compilation warning in bpftool polluting
selftests Makefile output.

Andrii Nakryiko (4):
  libbpf: fix error handling bug in btf_dump__new
  libbpf: simplify BTF initialization logic
  libbpf: fix potential multiplication overflow in mmap() size
    calculation
  bpftool: avoid const discard compilation warning

 tools/bpf/bpftool/jit_disasm.c |  2 +-
 tools/lib/bpf/btf_dump.c       |  1 +
 tools/lib/bpf/libbpf.c         | 21 +++++++--------------
 3 files changed, 9 insertions(+), 15 deletions(-)

-- 
2.17.1

