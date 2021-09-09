Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F5FC433EF
	for <bpf@archiver.kernel.org>; Thu,  9 Sep 2021 22:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405A861186
	for <bpf@archiver.kernel.org>; Thu,  9 Sep 2021 22:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhIIWFm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 9 Sep 2021 18:05:42 -0400
Received: from novek.ru ([213.148.174.62]:36502 "EHLO novek.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233941AbhIIWFm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 18:05:42 -0400
Received: from nat1.ooonet.ru (gw.zelenaya.net [91.207.137.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by novek.ru (Postfix) with ESMTPSA id D6537501DE0;
        Fri, 10 Sep 2021 01:01:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 novek.ru D6537501DE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novek.ru; s=mail;
        t=1631224876; bh=knI9zL7DHmbbRa50b0ja/vn66zhetdcKtlmDiBTy9bg=;
        h=From:To:Cc:Subject:Date:From;
        b=r1dTqGZw+egwE0jTgz1YvNcdaOk8J2xQZQmiaqWOQs3vcs3vB3trlfl8+wbyX2cFB
         nTXSmMz/IrkSpSemB4GdFxl0SzJBwgk0NerRvgWnO4v7yCP/BsKnJea4T1LCBRwosD
         D8NdET8dDHbbEKeE8xYiHoeeQ7SrxuN1DL6ZLLJk=
From:   Vadim Fedorenko <vfedorenko@novek.ru>
To:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Vadim Fedorenko <vfedorenko@novek.ru>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] add hwtstamp to __sk_buff
Date:   Fri, 10 Sep 2021 01:04:07 +0300
Message-Id: <20210909220409.8804-1-vfedorenko@novek.ru>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds hardware timestamps to __sk_buff. The first patch
implements feature, the second one adds a selftest.

v2 -> v3:
* rebase on bpf-next

v1 -> v2:

* Fixed bpf_skb_is_valid_access() to provide correct access to field
* Added explicit test to deny access to padding area
* Added verifier selftest to check for denied access to padding area

Acked-by: Martin KaFai Lau <kafai@fb.com>

Vadim Fedorenko (2):
  bpf: add hardware timestamp field to __sk_buff
  selftests/bpf: test new __sk_buff field hwtstamp

 include/uapi/linux/bpf.h                      |  2 +
 lib/test_bpf.c                                |  1 +
 net/bpf/test_run.c                            |  8 +++
 net/core/filter.c                             | 21 +++++++
 tools/include/uapi/linux/bpf.h                |  2 +
 .../selftests/bpf/prog_tests/skb_ctx.c        |  1 +
 .../selftests/bpf/progs/test_skb_ctx.c        |  2 +
 .../testing/selftests/bpf/verifier/ctx_skb.c  | 60 +++++++++++++++++++
 8 files changed, 97 insertions(+)

-- 
2.18.4

