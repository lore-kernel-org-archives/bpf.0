Return-Path: <SRS0=/Hy+=DC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6050CC4346E
	for <bpf@archiver.kernel.org>; Fri, 25 Sep 2020 00:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A6F238D6
	for <bpf@archiver.kernel.org>; Fri, 25 Sep 2020 00:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aBdhQnME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgIYADm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 24 Sep 2020 20:03:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39238 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726662AbgIYADm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Sep 2020 20:03:42 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08P010w3003713
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 17:03:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=MdpMhWSetFEv4AchIr5Cz7nxpVjbpFsq13ZAiiiGwBQ=;
 b=aBdhQnMEfX/dUt+6gfTR6i4LcPiXS2imyoHUl8fJ/hziQNTl1iRCjGwEpGdONFeqS0C2
 JWvh7DLvHMN7qj06oLtR6ysfHailRou5bOYhMMrHYU9Sp9ku1rUvUutu3dv3H+VX7YP8
 mVIFPxBHn0RC/SdcqvqsYi3erDaCKnuQOdU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp7cukm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 17:03:42 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Sep 2020 17:03:40 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id CE99529465FF; Thu, 24 Sep 2020 17:03:37 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 bpf-next 00/13] bpf: Enable bpf_skc_to_* sock casting helper to networking prog type
Date:   Thu, 24 Sep 2020 17:03:37 -0700
Message-ID: <20200925000337.3853598-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_18:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=691 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=13
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009240174
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set allows networking prog type to directly read fields from
the in-kernel socket type, e.g. "struct tcp_sock".

Patch 2 has the details on the use case.

v3:
- Pass arg_btf_id instead of fn into check_reg_type() in Patch 1 (Lorenz)
- Move arg_btf_id from func_proto to struct bpf_reg_types in Patch 2 (Lor=
enz)
- Remove test_sock_fields from .gitignore in Patch 8 (Andrii)
- Add tests to have better coverage on the modified helpers (Alexei)
  Patch 13 is added.
- Use "void *sk" as the helper argument in UAPI bpf.h
 =20
v3:
- ARG_PTR_TO_SOCK_COMMON_OR_NULL was attempted in v2.  The _OR_NULL was
  needed because the PTR_TO_BTF_ID could be NULL but note that a could be=
 NULL
  PTR_TO_BTF_ID is not a scalar NULL to the verifier.  "_OR_NULL" implici=
tly
  gives an expectation that the helper can take a scalar NULL which does
  not make sense in most (except one) helpers.  Passing scalar NULL
  should be rejected at the verification time.

  Thus, this patch uses ARG_PTR_TO_BTF_ID_SOCK_COMMON to specify that the
  helper can take both the btf-id ptr or the legacy PTR_TO_SOCK_COMMON bu=
t
  not scalar NULL.  It requires the func_proto to explicitly specify the
  arg_btf_id such that there is a very clear expectation that the helper
  can handle a NULL PTR_TO_BTF_ID.

v2:
- Add ARG_PTR_TO_SOCK_COMMON_OR_NULL (Lorenz)

Martin KaFai Lau (13):
  bpf: Move the PTR_TO_BTF_ID check to check_reg_type()
  bpf: Enable bpf_skc_to_* sock casting helper to networking prog type
  bpf: Change bpf_sk_release and bpf_sk_*cgroup_id to accept
    ARG_PTR_TO_BTF_ID_SOCK_COMMON
  bpf: Change bpf_sk_storage_*() to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON
  bpf: Change bpf_tcp_*_syncookie to accept
    ARG_PTR_TO_BTF_ID_SOCK_COMMON
  bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON
  bpf: selftest: Add ref_tracking verifier test for bpf_skc casting
  bpf: selftest: Move sock_fields test into test_progs
  bpf: selftest: Adapt sock_fields test to use skel and global variables
  bpf: selftest: Use network_helpers in the sock_fields test
  bpf: selftest: Use bpf_skc_to_tcp_sock() in the sock_fields test
  bpf: selftest: Remove enum tcp_ca_state from bpf_tcp_helpers.h
  bpf: selftest: Add test_btf_skc_cls_ingress

 include/linux/bpf.h                           |   1 +
 include/net/bpf_sk_storage.h                  |   2 -
 include/uapi/linux/bpf.h                      |  15 +-
 kernel/bpf/bpf_lsm.c                          |   4 +-
 kernel/bpf/verifier.c                         |  94 ++--
 net/core/bpf_sk_storage.c                     |  29 +-
 net/core/filter.c                             | 111 ++--
 net/ipv4/bpf_tcp_ca.c                         |  23 +-
 tools/include/uapi/linux/bpf.h                |  15 +-
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  13 +-
 .../bpf/prog_tests/btf_skc_cls_ingress.c      | 234 +++++++++
 .../selftests/bpf/prog_tests/sock_fields.c    | 382 ++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_cubic.c |   2 +
 tools/testing/selftests/bpf/progs/bpf_dctcp.c |   2 +
 .../bpf/progs/test_btf_skc_cls_ingress.c      | 174 +++++++
 ..._sock_fields_kern.c =3D> test_sock_fields.c} | 176 ++++---
 .../testing/selftests/bpf/test_sock_fields.c  | 482 ------------------
 .../selftests/bpf/verifier/ref_tracking.c     |  47 ++
 20 files changed, 1093 insertions(+), 716 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_skc_cls_in=
gress.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_fields.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_btf_skc_cls_in=
gress.c
 rename tools/testing/selftests/bpf/progs/{test_sock_fields_kern.c =3D> t=
est_sock_fields.c} (61%)
 delete mode 100644 tools/testing/selftests/bpf/test_sock_fields.c

--=20
2.24.1

