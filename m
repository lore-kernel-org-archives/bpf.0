Return-Path: <SRS0=4a0o=B5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A61BC433E3
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 05:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2360F206DA
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 05:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eLm+pGAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgHSF3B (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Aug 2020 01:29:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37846 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgHSF27 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 01:28:59 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07J5S4bu020283
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 22:28:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=+vs54gea/gmsTyOx4BEJ97vL+Tnoif+hN6edKA0W7Yw=;
 b=eLm+pGAiVg1tsn60wwGUTnXya4eZiMoZ4DsO+3Ub00UW0g1Vcl5ebHh0pe6NdqZzxzDO
 Gcqk0Ca5FRuRKR61rwqdZczRqbHc/yPFwOUhdbR+xhOuC5mBMB5gSmNrlejlT8qjssse
 6xIbdsb7enwZDRo9jrimt8EDfvsKhgk4tAE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3304jj6rnd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 22:28:58 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 18 Aug 2020 22:28:56 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 43C342EC5C14; Tue, 18 Aug 2020 22:28:52 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 0/5] Add support for type-based and enum value-based CO-RE relocations
Date:   Tue, 18 Aug 2020 22:28:44 -0700
Message-ID: <20200819052849.336700-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_03:2020-08-18,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=825 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190046
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds libbpf support for two new classes of CO-RE relocatio=
ns:
type-based (TYPE_EXISTS/TYPE_SIZE/TYPE_ID_LOCAL/TYPE_ID_TARGET) and enum
value-vased (ENUMVAL_EXISTS/ENUMVAL_VALUE):
  - TYPE_EXISTS allows to detect presence in kernel BTF of a locally-reco=
rded
    BTF type. Useful for feature detection (new functionality often comes=
 with
    new internal kernel types), as well as handling type renames and bigg=
er
    refactorings.
  - TYPE_SIZE allows to get the real size (in bytes) of a specified kerne=
l
    type. Useful for dumping internal structure as-is through perfbuf or
    ringbuf.
  - TYPE_ID_LOCAL/TYPE_ID_TARGET allow to capture BTF type ID of a BTF ty=
pe in
    program's BTF or kernel BTF, respectively. These could be used for
    high-performance and space-efficient generic data dumping/logging by
    relying on small and cheap BTF type ID as a data layout descriptor, f=
or
    post-processing on user-space side.
  - ENUMVAL_EXISTS can be used for detecting the presence of enumerator v=
alue
    in kernel's enum type. Most direct application is to detect BPF helpe=
r
    support in kernel.
  - ENUMVAL_VALUE allows to relocate real integer value of kernel enumera=
tor
    value, which is subject to change (e.g., always a potential issue for
    internal, non-UAPI, kernel enums).

I've indicated potential applications for these relocations, but relocati=
ons
themselves are generic and unassuming and are designed to work correctly =
even
in unintended applications. Furthermore, relocated values become constant=
s,
known to the verifier and could and would be used for dead branch code
detection and elimination. This makes them ideal to do all sorts of featu=
re
detection and guarding functionality that's not available on some older (=
but
still supported by BPF program) kernels, while having to compile and main=
tain
one unified source code.

Selftests are added for all the new features. Selftests utilizing new Cla=
ng
built-ins are designed such that they will compile with older Clangs and =
will
be skipped during test runs. So this shouldn't cause any build and test
failures on systems with slightly outdated Clang compiler.

LLVM patches adding these relocation in Clang:
  - __builtin_btf_type_id() ([0], [1], [2]);
  - __builtin_preserve_type_info(), __builtin_preserve_enum_value() ([3],=
 [4]).

  [0] https://reviews.llvm.org/D74572
  [1] https://reviews.llvm.org/D74668
  [2] https://reviews.llvm.org/D85174
  [3] https://reviews.llvm.org/D83878
  [4] https://reviews.llvm.org/D83242

v1->v2:
  - selftests detect built-in support and are skipped if not found (Alexe=
i).

Andrii Nakryiko (5):
  libbpf: implement type-based CO-RE relocations support
  selftests/bpf: test TYPE_EXISTS and TYPE_SIZE CO-RE relocations
  selftests/bpf: add CO-RE relo test for TYPE_ID_LOCAL/TYPE_ID_TARGET
  libbpf: implement enum value-based CO-RE relocations
  selftests/bpf: add tests for ENUMVAL_EXISTS/ENUMVAL_VALUE relocations

 tools/lib/bpf/bpf_core_read.h                 |  80 +++-
 tools/lib/bpf/libbpf.c                        | 376 ++++++++++++++++--
 tools/lib/bpf/libbpf_internal.h               |   6 +
 .../selftests/bpf/prog_tests/core_reloc.c     | 349 ++++++++++++++--
 .../bpf/progs/btf__core_reloc_enumval.c       |   3 +
 .../progs/btf__core_reloc_enumval___diff.c    |   3 +
 .../btf__core_reloc_enumval___err_missing.c   |   3 +
 .../btf__core_reloc_enumval___val3_missing.c  |   3 +
 .../bpf/progs/btf__core_reloc_type_based.c    |   3 +
 ...btf__core_reloc_type_based___all_missing.c |   3 +
 .../btf__core_reloc_type_based___diff_sz.c    |   3 +
 ...f__core_reloc_type_based___fn_wrong_args.c |   3 +
 .../btf__core_reloc_type_based___incompat.c   |   3 +
 .../bpf/progs/btf__core_reloc_type_id.c       |   3 +
 ...tf__core_reloc_type_id___missing_targets.c |   3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 327 ++++++++++++++-
 .../bpf/progs/test_core_reloc_enumval.c       |  73 ++++
 .../bpf/progs/test_core_reloc_kernel.c        |   2 +
 .../bpf/progs/test_core_reloc_type_based.c    | 111 ++++++
 .../bpf/progs/test_core_reloc_type_id.c       | 107 +++++
 20 files changed, 1408 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___diff.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___err_missing.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___val3_missing.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_typ=
e_based.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_typ=
e_based___all_missing.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_typ=
e_based___diff_sz.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_typ=
e_based___fn_wrong_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_typ=
e_based___incompat.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_typ=
e_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_typ=
e_id___missing_targets.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_enu=
mval.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_typ=
e_based.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_typ=
e_id.c

--=20
2.24.1

