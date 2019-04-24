Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61DDC10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FBF208E4
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="I7EEZd+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDXWjv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:39:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42054 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbfDXWjv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Apr 2019 18:39:51 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OMTc6V007995
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 15:39:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=pHepKY4GCNLbbYi6FdFKYqlRN717r7RaoQzeJpuqygg=;
 b=I7EEZd+Gs5jRdvKuzfZeanOFR0IcxYeJTMCzgtPB9itdlBmAQavWeyQobFBF0/MO5rbU
 xllnqMXQ97KF4oo2NzCie24mlQubYIMx5fxNzb473g9BhA5NvSBOINuiD5JMhEcvvRHQ
 qtbm+BKUE7Q3TA+1hvO91n7RNtGwTwxoe20= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2wr9923y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 15:39:49 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 24 Apr 2019 15:39:49 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id B81C529421BD; Wed, 24 Apr 2019 15:39:48 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/6] BPF sk local storage
Date:   Wed, 24 Apr 2019 15:39:48 -0700
Message-ID: <20190424223948.516788-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series introduces the BPF sk local storage.  The
details is in the patch 1 commit message.

Martin KaFai Lau (6):
  bpf: Introduce bpf sk local storage
  bpf: Sync bpf.h to tools
  bpf: Support BPF_MAP_TYPE_SK_STORAGE in bpf map probing
  bpf: Add verifier tests for the bpf_sk_storage
  bpf: Add BPF_MAP_TYPE_SK_STORAGE test to test_maps
  bpf: Add ene-to-end test for bpf_sk_storage_* helpers

 include/linux/bpf.h                           |   2 +
 include/linux/bpf_types.h                     |   1 +
 include/net/bpf_sk_storage.h                  |  13 +
 include/net/sock.h                            |   5 +
 include/uapi/linux/bpf.h                      |  44 +-
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  27 +-
 net/bpf/test_run.c                            |   2 +
 net/core/Makefile                             |   1 +
 net/core/bpf_sk_storage.c                     | 796 ++++++++++++++++++
 net/core/filter.c                             |  12 +
 net/core/sock.c                               |   5 +
 tools/bpf/bpftool/map.c                       |   1 +
 tools/include/uapi/linux/bpf.h                |  44 +-
 tools/lib/bpf/libbpf_probes.c                 |  74 +-
 tools/testing/selftests/bpf/Makefile          |  25 +-
 tools/testing/selftests/bpf/bpf_helpers.h     |   5 +
 .../selftests/bpf/map_tests/sk_storage_map.c  | 638 ++++++++++++++
 .../bpf/progs/test_sock_fields_kern.c         |  49 ++
 tools/testing/selftests/bpf/test_maps.c       |  18 +-
 .../testing/selftests/bpf/test_sock_fields.c  | 115 ++-
 tools/testing/selftests/bpf/test_verifier.c   |  42 +-
 tools/testing/selftests/bpf/verifier/sock.c   | 116 +++
 23 files changed, 1998 insertions(+), 40 deletions(-)
 create mode 100644 include/net/bpf_sk_storage.h
 create mode 100644 net/core/bpf_sk_storage.c
 create mode 100644 tools/testing/selftests/bpf/map_tests/sk_storage_map.=
c

--=20
2.17.1

