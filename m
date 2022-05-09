Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A66C4321E
	for <bpf@archiver.kernel.org>; Mon,  9 May 2022 01:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiEIBax convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sun, 8 May 2022 21:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiEIApq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:45:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF36430
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:41:53 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248NgoZi005110
        for <bpf@vger.kernel.org>; Sun, 8 May 2022 17:41:53 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwpgw5pkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 17:41:52 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 17:41:52 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3706419A4AC55; Sun,  8 May 2022 17:41:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/9] Misc libbpf fixes and small improvements
Date:   Sun, 8 May 2022 17:41:39 -0700
Message-ID: <20220509004148.1801791-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Vvd5-a-6U1LwgwXgW5DRgt6b0vD7yQG_
X-Proofpoint-GUID: Vvd5-a-6U1LwgwXgW5DRgt6b0vD7yQG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set is a mix of mostly mutually unrelated libbpf and selftests
fixes and improvements. Individual patches provide details on each one.

Andrii Nakryiko (9):
  selftests/bpf: prevent skeleton generation race
  libbpf: make __kptr and __kptr_ref unconditionally use btf_type_tag()
    attr
  libbpf: improve usability of field-based CO-RE helpers
  selftests/bpf: use both syntaxes for field-based CO-RE helpers
  libbpf: complete field-based CO-RE helpers with field offset helper
  selftests/bpf: add bpf_core_field_offset() tests
  libbpf: provide barrier() and barrier_var() in bpf_helpers.h
  libbpf: automatically fix up BPF_MAP_TYPE_RINGBUF size, if necessary
  selftests/bpf: test libbpf's ringbuf size fix up logic

 tools/lib/bpf/bpf_core_read.h                 | 37 ++++++++++++++--
 tools/lib/bpf/bpf_helpers.h                   | 29 ++++++++++---
 tools/lib/bpf/libbpf.c                        | 42 ++++++++++++++++++-
 tools/testing/selftests/bpf/Makefile          | 10 ++---
 .../selftests/bpf/prog_tests/core_reloc.c     | 13 +++++-
 .../selftests/bpf/prog_tests/ringbuf_multi.c  | 12 ------
 .../progs/btf__core_reloc_size___diff_offs.c  |  3 ++
 .../selftests/bpf/progs/core_reloc_types.h    | 18 ++++++++
 .../selftests/bpf/progs/exhandler_kern.c      |  2 -
 tools/testing/selftests/bpf/progs/loop5.c     |  1 -
 tools/testing/selftests/bpf/progs/profiler1.c |  1 -
 tools/testing/selftests/bpf/progs/pyperf.h    |  2 -
 .../bpf/progs/test_core_reloc_existence.c     | 11 +++--
 .../bpf/progs/test_core_reloc_size.c          | 31 ++++++++++++--
 .../selftests/bpf/progs/test_pkt_access.c     |  2 -
 .../selftests/bpf/progs/test_ringbuf_multi.c  |  2 +
 16 files changed, 169 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_size___diff_offs.c

-- 
2.30.2

