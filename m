Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED8EC43218
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 23:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A607C206C1
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 23:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Y1WKNgHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfDZXjm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 19:39:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39056 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727131AbfDZXjm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 19:39:42 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QNZI3A030708
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 16:39:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=t4hMaLwKYijOLUQTrpSXG4oy3L9TjXvmBqMlCDN+UCY=;
 b=Y1WKNgHspJFa0DvQwKnbUP6AlukHn1I6033lz8fm5lUHPOkWuYfCau08L+GTbDfoWJkc
 pQODyKfYXUVSfaXqGBn/GEYiK0wmnaj1XTyM3nyCELMDLYbhNKiPc/jNd5IjOrpjuT1g
 5ra2UD6GY+ohxdJd5pS8EdNEwdmSIuN3XzA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s48c9rmxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 16:39:41 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Apr 2019 16:39:39 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 24CD629425A9; Fri, 26 Apr 2019 16:39:38 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Stanislav Fomichev <sdf@fomichev.me>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 0/7] BPF sk local storage
Date:   Fri, 26 Apr 2019 16:39:38 -0700
Message-ID: <20190426233938.1330361-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=604 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v4:
- Move checks to map_alloc_check in patch 1 (Stanislav Fomichev)
- Refactor BTF encoding macros to test_btf.h at
  a new patch 4 (Stanislav Fomichev)
- Refactor getenv and add print PASS message at the
  end of the test in patch 6 (Yonghong Song)

v3:
- Replace spinlock_types.h with spinlock.h in patch 1
  (kbuild test robot <lkp@intel.com>)

v2:
- Add the "test_maps.h" file in patch 5

This series introduces the BPF sk local storage.  The
details is in the patch 1 commit message.

Martin KaFai Lau (7):
  bpf: Introduce bpf sk local storage
  bpf: Sync bpf.h to tools
  bpf: Support BPF_MAP_TYPE_SK_STORAGE in bpf map probing
  bpf: Refactor BTF encoding macro to test_btf.h
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
 net/core/bpf_sk_storage.c                     | 804 ++++++++++++++++++
 net/core/filter.c                             |  12 +
 net/core/sock.c                               |   5 +
 tools/bpf/bpftool/map.c                       |   1 +
 tools/include/uapi/linux/bpf.h                |  44 +-
 tools/lib/bpf/libbpf_probes.c                 |  74 +-
 tools/testing/selftests/bpf/Makefile          |  25 +-
 tools/testing/selftests/bpf/bpf_helpers.h     |   5 +
 .../selftests/bpf/map_tests/sk_storage_map.c  | 629 ++++++++++++++
 .../bpf/progs/test_sock_fields_kern.c         |  53 ++
 tools/testing/selftests/bpf/test_btf.c        |  63 +-
 tools/testing/selftests/bpf/test_btf.h        |  69 ++
 tools/testing/selftests/bpf/test_maps.c       |  18 +-
 tools/testing/selftests/bpf/test_maps.h       |  17 +
 .../testing/selftests/bpf/test_sock_fields.c  | 115 ++-
 tools/testing/selftests/bpf/test_verifier.c   |  55 +-
 tools/testing/selftests/bpf/verifier/sock.c   | 116 +++
 26 files changed, 2089 insertions(+), 114 deletions(-)
 create mode 100644 include/net/bpf_sk_storage.h
 create mode 100644 net/core/bpf_sk_storage.c
 create mode 100644 tools/testing/selftests/bpf/map_tests/sk_storage_map.=
c
 create mode 100644 tools/testing/selftests/bpf/test_btf.h
 create mode 100644 tools/testing/selftests/bpf/test_maps.h

--=20
2.17.1

