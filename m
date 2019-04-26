Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FF6C43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 17:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EC421479
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 17:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gl6YqLx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfDZRLH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:11:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39362 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726170AbfDZRLH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 13:11:07 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QH3OHu002170
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 10:11:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=eolrUtjttQLdmQLUbYVmlKc0ar3pgQwRUJEVk7nGgLU=;
 b=gl6YqLx37fNXxuoqi5oOTL5V49KvCqTAOIoL4xLvjjAo4Qyzph5KgWso5zSgT9WkqEA1
 wL2kUR9XUvtL3UgKOqnRRp3RxmNmrUXOCc3THJOnnTwVlIZ4nswneG2n8dnfRKBz9/ux
 +p0+GeYh5fyaovo9Kus3PSsvDUW+kQI360g= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s3mcc35er-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 10:11:06 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 26 Apr 2019 10:11:04 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 4FD6229421AA; Fri, 26 Apr 2019 10:11:02 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 0/6] BPF sk local storage
Date:   Fri, 26 Apr 2019 10:11:02 -0700
Message-ID: <20190426171102.61757-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v3:
- Replace spinlock_types.h with spinlock.h in patch 1
  (kbuild test robot <lkp@intel.com>)

v2:
- Add the "test_maps.h" file in patch 5

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
 tools/testing/selftests/bpf/test_maps.h       |  17 +
 .../testing/selftests/bpf/test_sock_fields.c  | 115 ++-
 tools/testing/selftests/bpf/test_verifier.c   |  42 +-
 tools/testing/selftests/bpf/verifier/sock.c   | 116 +++
 24 files changed, 2015 insertions(+), 40 deletions(-)
 create mode 100644 include/net/bpf_sk_storage.h
 create mode 100644 net/core/bpf_sk_storage.c
 create mode 100644 tools/testing/selftests/bpf/map_tests/sk_storage_map.=
c
 create mode 100644 tools/testing/selftests/bpf/test_maps.h

--=20
2.17.1

