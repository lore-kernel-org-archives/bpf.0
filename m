Return-Path: <SRS0=sv//=Q5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50264C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113222070D
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550878612;
	bh=WKn1pty6HzRUUY+dkbd6HqiB0G9uH3HciSrya+j46/Q=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=yfgHbgvFEk8pLti5q8qqqRzqa458uuugwXL586DYQTTC2vUVb5w3JuF/5OUmwPhUw
	 JNQFq4h5BVQv8zQrJIgwbgRFUki138IlYhFyTmaWAQdRFo++f2FC0iH4+nbvxc+zQl
	 lkjLrqpD/pdX6cmS6LFAXQULd647lYdF2rLRp6zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfBVXgv convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 22 Feb 2019 18:36:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39038 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfBVXgv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Feb 2019 18:36:51 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MNWx1q029495
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 15:36:50 -0800
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qttft02eq-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 15:36:50 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 22 Feb 2019 15:36:47 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id F39C8760956; Fri, 22 Feb 2019 15:36:44 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/4] bpf: per program stats
Date:   Fri, 22 Feb 2019 15:36:40 -0800
Message-ID: <20190222233644.1487087-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce per program stats to monitor the usage BPF

Alexei Starovoitov (4):
  bpf: enable program stats
  bpf: expose program stats via bpf_prog_info
  tools/bpf: sync bpf.h into tools
  tools/bpftool: recognize bpf_prog_info runtime and runcnt

 include/linux/bpf.h                           |  7 ++++
 include/linux/filter.h                        | 16 ++++++++-
 include/uapi/linux/bpf.h                      |  2 ++
 kernel/bpf/core.c                             | 13 +++++++
 kernel/bpf/syscall.c                          | 29 ++++++++++++++--
 kernel/bpf/verifier.c                         |  5 +++
 kernel/sysctl.c                               | 34 +++++++++++++++++++
 .../bpftool/Documentation/bpftool-prog.rst    |  4 ++-
 tools/bpf/bpftool/prog.c                      |  7 ++++
 tools/include/uapi/linux/bpf.h                |  2 ++
 10 files changed, 115 insertions(+), 4 deletions(-)

-- 
2.20.0

