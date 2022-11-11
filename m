Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE898C4332F
	for <bpf@archiver.kernel.org>; Fri, 11 Nov 2022 14:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiKKOd6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Nov 2022 09:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbiKKOdy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 09:33:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7014AF0D
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 06:33:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D14F5CE254D
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 14:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B248C433C1;
        Fri, 11 Nov 2022 14:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668177226;
        bh=/ypLMjrNZsotjNwidPZtqfazLm1h17jgTEWxHLkMVUk=;
        h=From:To:Cc:Subject:Date:From;
        b=jsiB7yd50OHtzygDRjWop4Q2Q/RGO8ZU7bLLRITN1ORJ928mGXuGWzaZauOZUqAXe
         tuP83aikwF8ILmB+2tuswKaYKPF8JQ7DPZK/kN17w90AWRuAKRV7KV94kzsKzO9kn4
         20x6+e1qNrs5zN7JBclnNyF6FaNNF4+qW3Ad4Ra0fH4yltpCE54/mgMdaXKUc5M9G7
         su6+pC+9l69NLvYRIVEf9Z0cHv/cA46xYDUoXjzHnu8MAV++1MpEhkj8S41pFkp5GV
         Yk6NeZLoOv1DC1I3etW8JnRdsiDrJ1HFJuXsxkdnnCPFGtCuinMfbbuUowoHppF8t7
         jGSs0C/d4LX/Q==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next 0/2] bpf: Add bpf_vma_build_id_parse kfunc
Date:   Fri, 11 Nov 2022 15:33:39 +0100
Message-Id: <20221111143341.508022-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
first version of this patchset added helper for this functionality,
but based Alexei's feedback [1], changing it to kfunc.

With the current build_id_parse function as kfunc we can't effectively
check buffer size provided by user. Therefore adding new function as
bpf kfunc:

  int bpf_vma_build_id_parse(struct vm_area_struct *vma,
                             unsigned char *build_id,
                             size_t build_id__sz);

that triggers kfunc's verifier check for build_id/build_id__sz buffer
size and calls build_id_parse.

thanks,
jirka


[1] https://lore.kernel.org/bpf/CAADnVQKyT4Mm4EdTCYK8c070E-BwPZS_FOkWKLJC80riSGmLTg@mail.gmail.com/
---
Jiri Olsa (2):
      bpf: Add bpf_vma_build_id_parse function and kfunc
      selftests/bpf: Add bpf_vma_build_id_parse kfunc test

 include/linux/bpf.h                                             |  5 +++++
 kernel/bpf/helpers.c                                            | 16 ++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_vma_build_id_parse.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c
