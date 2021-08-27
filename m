Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5224BC432BE
	for <bpf@archiver.kernel.org>; Fri, 27 Aug 2021 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3104D608FE
	for <bpf@archiver.kernel.org>; Fri, 27 Aug 2021 13:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhH0N4k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 27 Aug 2021 09:56:40 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:41286
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232257AbhH0N4j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Aug 2021 09:56:39 -0400
Received: from mussarela.. (201-69-234-220.dial-up.telesp.net.br [201.69.234.220])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 21AC13F09E;
        Fri, 27 Aug 2021 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630072549;
        bh=PRGL0EPf9abZ4WcNEhCxIbhw3vzaqaiKAPjxmzfRtG4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ireyzJTO1v3ELwwCuI8JLVVuFWHjfwPniH5j57fXED/k330EZ8+q1wbPMQbJRAv+T
         nhFxXmofkr8/iqCMXLvQ7DtyEz2FURwDlnhSeluWdGtxp6QDQNFhCngQIymzLlTnlz
         Y6+klTfs734MfVlESol7Y+YuW/B+aVBv7thECJ668GbCR7ekNvxEu02A7a1kFuVojw
         fFgxyb0uW4vv4+TkxdYOJJR4ZcoO7v4xcpkA6TZNgFP/cU7gY5WCLPyEUCdwhcQNy9
         7WF10Gg5DT//M08B9hpKZRjFXxzexL5peDpdKLGSz9lQJHfi3G7Hpvu9r7wtSvXkbA
         La7ahb47ysdbQ==
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     stable@vger.kernel.org
Cc:     bpf@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Pavel Machek <pavel@denx.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [PATCH 4.19 0/3] BPF fixes for CVE-2021-3444 and CVE-2021-3600
Date:   Fri, 27 Aug 2021 10:55:30 -0300
Message-Id: <20210827135533.146070-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The upstream changes necessary to fix these CVEs rely on the presence of JMP32,
which is not a small backport and brings its own potential set of necessary
follow-ups.

Daniel Borkmann, John Fastabend and Alexei Starovoitov came up with a fix
involving the use of the AX register.

This has been tested against the test_verifier in 4.19.y tree and some tests
specific to the two referred CVEs.

Daniel Borkmann (3):
  bpf: Do not use ax register in interpreter on div/mod
  bpf: Fix 32 bit src register truncation on div/mod
  bpf: Fix truncation handling for mod32 dst reg wrt zero

 include/linux/filter.h | 24 ++++++++++++++++++++++++
 kernel/bpf/core.c      | 32 +++++++++++++++-----------------
 kernel/bpf/verifier.c  | 27 ++++++++++++++-------------
 3 files changed, 53 insertions(+), 30 deletions(-)

-- 
2.30.2

