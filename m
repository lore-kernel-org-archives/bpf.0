Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732EBC43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 17:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA34206B6
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 17:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550943867;
	bh=JwfBIFLVMjQTHsJeGc3mOgVWMK2HNupv6a/K4IUmZ9w=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=RMInrw7gw40vjd+ECrV7OLZrhXsh2bg+ky/6cW1Mw1njs1/tujexwV5f5a5nqlrwW
	 J0732p7LJ9+VQSOVw28tS/MY7cJIJUvC3yqMdg5BfzAdDIkpmVKCZ0SHk2EBAFt5tS
	 Vdbi94xsda9sZbyu5MSAYGQq81IHaAcNlpfwVDq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfBWRo0 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 23 Feb 2019 12:44:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbfBWRo0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 23 Feb 2019 12:44:26 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1NHcTnS010337
        for <bpf@vger.kernel.org>; Sat, 23 Feb 2019 09:44:25 -0800
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qu69w0jb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 23 Feb 2019 09:44:25 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Sat, 23 Feb 2019 09:44:23 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id E4166760812; Sat, 23 Feb 2019 09:44:22 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <edumazet@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 0/4] bpf: per program stats
Date:   Sat, 23 Feb 2019 09:44:18 -0800
Message-ID: <20190223174422.663270-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-23_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce per program stats to monitor the usage BPF

v1->v2:
- fixed u64 stats on 32-bit archs. Thanks Eric
- use more verbose run_time_ns in json output as suggested by Andrii
- refactored prog_alloc and clarified behavior of stats in subprogs

Alexei Starovoitov (4):
  bpf: enable program stats
  bpf: expose program stats via bpf_prog_info
  tools/bpf: sync bpf.h into tools
  tools/bpftool: recognize bpf_prog_info runtime and runcnt

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

