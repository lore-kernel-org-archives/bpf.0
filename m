Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6888EC43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3707F2146E
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCTM5k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:57:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54431 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfCTM5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 08:57:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so20642747wmj.4;
        Wed, 20 Mar 2019 05:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DkbW7FRTPNZ/PdSKI8YlOSpOifsIFu2GCByHuB54Pvw=;
        b=K5S5JOO+ZbfDtlIjsPK0tJgc/sJL1f6LAmczfwnFoBvY0e4cJEVQQpFvSyLFoZIn40
         Q9jlminy3n9LcomrSuMT40La85+WS74gHlkH6WCcvdv+5FK4G/WW7Z6+Upr/cFlWGJVw
         ks0hlZMh8tluxoCd07NVxCcqBtKI365FXHrEfdiYFzQb2ePgsrpZlyw3155gE8yHhruJ
         /9sXlqETycPDzerp7ciEJc9YP28kRMwbsc/fHG+uullidx3HdvaksXxxjdoBHqYw0Uwq
         D+R+FYvSxZLqwejIRt+JGB3cJxDfGSh6nvJhl3KFeMz5xhL+oKdFQoidtP/x6yOVzSQk
         Oc+Q==
X-Gm-Message-State: APjAAAXPV23v7aV4p8D0P0CjNyAKonMo0Vz5EuF5pykhtvItBKI/HtO/
        kXhW4wD6y9GTsl80NCmon/g=
X-Google-Smtp-Source: APXvYqy1od5X4bQJYZV+VJ99FGbAFnomBIC9RVAt0NciQLJFtFosMH5XhrhuYK4DeVqSvLqV3SoXng==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr8621348wmc.70.1553086657998;
        Wed, 20 Mar 2019 05:57:37 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id 132sm3558198wmd.27.2019.03.20.05.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 05:57:37 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:57:40 +0100
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     xiao.han@orange.com, paul.chaignon@gmail.com,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 0/2] bpf: remove incorrect 'verifier bug' warning
Message-ID: <cover.1553085539.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF verifier checks the maximum number of call stack frames twice,
first in the main CFG traversal (do_check) and then in a subsequent
traversal (check_max_stack_depth).  If the second check fails, it logs a
'verifier bug' warning and errors out, as the number of call stack frames
should have been verified already.

However, the second check may fail without indicating a verifier bug: if
the excessive function calls reside in dead code, the main CFG traversal
may not visit them; the subsequent traversal visits all instructions,
including dead code.

This case raises the question of how invalid dead code should be treated.
The first patch implements the conservative option and rejects such code;
the second adds a test case.

Paul Chaignon (2):
  bpf: remove incorrect 'verifier bug' warning
  selftests/bpf: test case for invalid call stack in dead code

 kernel/bpf/verifier.c                        |  5 +--
 tools/testing/selftests/bpf/verifier/calls.c | 38 ++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.17.1

