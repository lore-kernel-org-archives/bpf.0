Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B19C433E1
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 09:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7144C20737
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 09:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LEEMGiaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGWJ76 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgGWJ74 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 05:59:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AAAC0619E2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 02:59:56 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id s9so2947462lfs.4
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peNb8+RImxTNVZkyG9ELZ4fhv916Nu+DkwVdstZXkiA=;
        b=LEEMGiaW0nGTr5CFiq3SrGNGE6dboorHG1aLnfiDOl6MgWGLACzz+29+izd56QHWX/
         TFRL7Rl0K3TDZiAD8lfmZ5vGG++cbTMvrnTx09rs142zLnZ0LAj5Mau2JsTfiXaVFDte
         b0cz3XGMizWT0ToH6w7sapzAuv9fTK0JKr4F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peNb8+RImxTNVZkyG9ELZ4fhv916Nu+DkwVdstZXkiA=;
        b=D7srZBNTj6ndmbWjh3dk2+saXTGR7f2tGggd1otWwd206n535sloowzwB5gml+EKWn
         lPP1CkPwLRRd4BINHNxZJl+894uuqnE2FE7HDetvcZZFWtx3PQEQp/R6f1mekPJmazgO
         RmIQ9WRFyUN0B041IDJ4lP0tLMDMOstjlQOn6q3VObWs40A0JJ/LRkKiko6wZ7LN6kRL
         ssLoK6em/N9gc/LaT4lYLH4qBJstGLxyaG2WPr8ea7mOwHacpLL7tQrnD3n8hPB1SRCl
         Hxko1UY4zUzBhp1VRpbO9M7hDePojNq+oEyigSuV/jzuZNixG4/4uW4KjdIcK9N3qfcm
         zQkw==
X-Gm-Message-State: AOAM530/6/moqUQ1n8B6dWzbQXfqdNwNdYDyNOCAm+aOmrXo1+5t32P0
        NcLFhYxi918/xF3K5wwttUkPLD0W4oc=
X-Google-Smtp-Source: ABdhPJxnsRyX1mdKT6YyBQWc6mtmdE+xNqWANhT+eqFjJoSxfc8QSpwXrCh9Oibo8KKdc9Av+fbLIQ==
X-Received: by 2002:ac2:4294:: with SMTP id m20mr1848076lfh.147.1595498394639;
        Thu, 23 Jul 2020 02:59:54 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id h22sm2330598ljg.1.2020.07.23.02.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 02:59:54 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf v2 0/2] Fix narrow loads from an offset outside of target field
Date:   Thu, 23 Jul 2020 11:59:51 +0200
Message-Id: <20200723095953.1003302-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a second attempt at fixing narrow loads from context fields backed
by smaller-in-size target fields, when load offset is beyond the target
field.

Following Yonghong suggestion, verifier now emits an 'wX = 0' or 'rX = 0'
instruction for loads from offsets outside of target field.

Cc: Yonghong Song <yhs@fb.com>

[v1] https://lore.kernel.org/bpf/20200710173123.427983-1-jakub@cloudflare.com/

Jakub Sitnicki (2):
  bpf: Load zeros for narrow loads beyond target field
  selftests/bpf: Add test for narrow loads from context at an offset

 kernel/bpf/verifier.c                         | 23 ++++-
 .../selftests/bpf/prog_tests/narrow_load.c    | 84 +++++++++++++++++++
 .../selftests/bpf/progs/test_narrow_load.c    | 43 ++++++++++
 3 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/narrow_load.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_narrow_load.c

-- 
2.25.4

