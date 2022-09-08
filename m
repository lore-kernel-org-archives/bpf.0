Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26377C38145
	for <bpf@archiver.kernel.org>; Thu,  8 Sep 2022 00:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiIHAHf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIHAHf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:07:35 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ECAB5A48
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:07:34 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 764961170375C; Wed,  7 Sep 2022 17:07:22 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 0/8] Dynptr convenience helpers
Date:   Wed,  7 Sep 2022 17:02:46 -0700
Message-Id: <20220908000254.3079129-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset is the 3rd in the dynptr series. The 1st can be found here =
[0]
and the 2nd can be found here [1].

In this patchset, the following convenience helpers are added for interac=
ting
with bpf dynamic pointers:

    * bpf_dynptr_data_rdonly
    * bpf_dynptr_trim
    * bpf_dynptr_advance
    * bpf_dynptr_is_null
    * bpf_dynptr_is_rdonly
    * bpf_dynptr_get_size
    * bpf_dynptr_get_offset
    * bpf_dynptr_clone
    * bpf_dynptr_iterator

[0] https://lore.kernel.org/bpf/20220523210712.3641569-1-joannelkoong@gma=
il.com/
[1] https://lore.kernel.org/bpf/20220907183129.745846-1-joannelkoong@gmai=
l.com/

Joanne Koong (8):
  bpf: Add bpf_dynptr_data_rdonly
  bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
  bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
  bpf: Add bpf_dynptr_get_size and bpf_dynptr_get_offset
  bpf: Add bpf_dynptr_clone
  bpf: Add verifier support for custom callback return range
  bpf: Add bpf_dynptr_iterator
  selftests/bpf: Tests for dynptr convenience helpers

 include/linux/bpf_verifier.h                  |   1 +
 include/uapi/linux/bpf.h                      | 120 ++++
 kernel/bpf/helpers.c                          | 231 +++++++-
 kernel/bpf/verifier.c                         | 155 +++--
 scripts/bpf_doc.py                            |   3 +
 tools/include/uapi/linux/bpf.h                | 120 ++++
 .../testing/selftests/bpf/prog_tests/dynptr.c |  30 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 462 +++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 551 +++++++++++++++++-
 9 files changed, 1617 insertions(+), 56 deletions(-)

--=20
2.30.2

