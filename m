Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CB2C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B03205F4
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcyqkQik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfDBRIi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:08:38 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48352 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDBRIi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 13:08:38 -0400
Received: by mail-pf1-f201.google.com with SMTP id b11so10261501pfo.15
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2019 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ok8tqO09VYkMJaRcx6c3as5JF1ZGOu2RV5iNoMh9K4c=;
        b=FcyqkQiktFfl1mt51M097vh+ScIgZ/vJY/P8KV0vcg9cYSjeAyTn85O6QhSD6n5oIX
         O77pRzNZat+5sMTVvRiAOoeZsqQNRe5ECTFd91rB/XP7cmWk9h/m4kMaiwGJuVEg0N0W
         mpNqhRflLx01pAAH9NBW7N4m7sjEc0JYGVj64ur3rVt3lAmAW09KPN4CNef8ZzecVCAt
         +dTOcf8iDSDGVeXrLekiVjck4OUi2zhfaD1OCxQUWfRi1py41y9NuYCSMw9UPZ0fMjPn
         hcEYSfWF0bKln7nl516d+jnAIuyheEH8nHz87KN08Ueo9r7hCQBuqSVV77782fy+0kwb
         ertQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ok8tqO09VYkMJaRcx6c3as5JF1ZGOu2RV5iNoMh9K4c=;
        b=VdaLYeHJasuxT8Mxbn3ROBH7k02m029lFKnK3Nkz4GrAReAD+xLUpUqea/A5WTovov
         S1iDupMBTpiyl5cp1m7f5fBADyMJdlM+n76uA66nHB0vrRoCl3MWOXnITDZlom6BiHVZ
         cSyGp1WOmqD9h4h6g6SJaTVvuCnJ5bRWHumfMzAzyzsh9haTncCmQhpPpV7y+dO/GK+M
         k19/QaAOq6hwPC9F/Ce0EInZqWU4FEEd8Gr/mMuxfAseN5DGXpdEVu3gnxNxXxw26KlH
         /Et9O9I1kh9OZUvPd1/KU/0mU7vbHDnl09vTisSI6qGrYJC66jcn72LCvLtSI6cujQKH
         65dQ==
X-Gm-Message-State: APjAAAWisybGqNjH4lINMrHTb4UJWXnT9tgjxT7ygqB6iJARDhSVYNkT
        4TVnl7q5bBn05/npid9TbeXepyQ=
X-Google-Smtp-Source: APXvYqxhmgGlp4p3YkUKamGAr2dPuB0/k6xwbgITgkQLK83Q39gJi/gom9o4R68DbNssJY8i0vAIVWM=
X-Received: by 2002:a17:902:1e6:: with SMTP id b93mr2225900plb.71.1554224917845;
 Tue, 02 Apr 2019 10:08:37 -0700 (PDT)
Date:   Tue,  2 Apr 2019 10:08:31 -0700
Message-Id: <20190402170835.30732-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next 0/4] selftests: bpf: support building selftests with
 clang and fix warnings
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series contains small fixes to make bpf selftests compile cleanly
with clangs. All of them are not real problems, but it's nice to have
an option to use clang for the tests themselves.

Stanislav Fomichev (4):
  selftests: bpf: tests.h should depend on .c files, not the output
  selftests: bpf: fix -Wformat-security warning for
    flow_dissector_load.c
  selftests: bpf: fix -Wformat-invalid-specifier for bpf_obj_id.c
  selftests: bpf: remove duplicate .flags initialization in ctx_skb.c

 tools/testing/selftests/bpf/Makefile                | 4 ++--
 tools/testing/selftests/bpf/flow_dissector_load.c   | 2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c | 8 ++++----
 tools/testing/selftests/bpf/verifier/ctx_skb.c      | 1 -
 4 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog
