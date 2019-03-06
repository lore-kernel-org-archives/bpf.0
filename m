Return-Path: <SRS0=uow0=RJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B027C43381
	for <bpf@archiver.kernel.org>; Wed,  6 Mar 2019 23:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C7120663
	for <bpf@archiver.kernel.org>; Wed,  6 Mar 2019 23:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6hynBW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfCFXZa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:25:30 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:44734 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFXZa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Mar 2019 18:25:30 -0500
Received: by mail-io1-f74.google.com with SMTP id k24so10986705ioh.11
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2019 15:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6KErEvSBw0PEwVcEifi6uvE73meoxphMWhj7RdocEaE=;
        b=R6hynBW95aMcYrbAlRKrA5Nr15QKB70jGjuvqE2Im7EDUFfny3HcsimUOH+nkY85OK
         ysBJpX1qg/C4uOhvLK8eng/b5r6CWBLZX8mdz6xoS9BgiAwINJxiCAcKdKQaaSW63SWX
         rygu5OTL7h5ccnG+Zy3m90nqKWCIabGXsZogySN4BTuugv8K2aXLwDMRXhHgiI3jkJlM
         /mpk1eInt4y9yDoyXsb8HPKAq7wFOpwj0bvGJvFmauODssPLugf4oh1GmqB3wDyTHtu4
         qYIc898U/nAsvt0cQ+kS5zIjX/+mqzSayLYN9UHEjTPEaMYqlbS+S6f9oKcHaawiP0fe
         zCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6KErEvSBw0PEwVcEifi6uvE73meoxphMWhj7RdocEaE=;
        b=dwbNscqcXT1bE2epw4qbGiUQuQSYW8ojx72hRUVIr51MBxuQJydvREj51wENPJGWxj
         9OIM3CZO2dveswwruppGAX+HAtlxarwYZQVVOK1o9vKEQt505Ez4raXmEWpadaSf/xRj
         0qDAqoCDj1RdN7lOoxBLCRJohqQD4/xH8t69zVe07lZPy7Bf0JhT26GWZW7Z3nBQACYd
         RQjfCxtR/95STXCxGk2uyVwOu4Hzi/+VM1pRiR2lyGuOzj87dB6uQ2NCgc1+BVuE3tBy
         K/ku6nDOeoSKM1OjyEkBtgXtQF1B9kQu5TMOFjf9fe4TDaZSNcIFdnjUwZQWInvAMYnq
         pZDw==
X-Gm-Message-State: APjAAAV1u2kiSgZUB2xlmxYNxCLJwtogalWOw+hn4XlOF1wx9ieYFJgU
        zhY9PVV5U10JIAe/glbAml/i8qA=
X-Google-Smtp-Source: APXvYqwj1pGRMIrdRRABvL8nmW/qI/sah6Ugf11KywAye3k8Oeb68Xs/8VREhnRr3I+gKy9L+z8b7ac=
X-Received: by 2002:a24:1708:: with SMTP id 8mr7711183ith.0.1551914729941;
 Wed, 06 Mar 2019 15:25:29 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:25:26 -0800
Message-Id: <20190306232526.219483-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH bpf] selftests: bpf: test_progs: initialize duration in
 singal_pending test
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

CHECK macro implicitly uses duration. We call CHECK() a couple of times
before duration is initialized from bpf_prog_test_run().
Explicitly set duration to 0 to avoid compiler warnings.

Fixes: 740f8a657221 ("selftests/bpf: make sure signal interrupts BPF_PROG_TEST_RUN")

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/signal_pending.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/signal_pending.c b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
index f2a37bbf91ab..996e808f43a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/signal_pending.c
+++ b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
@@ -12,7 +12,7 @@ static void test_signal_pending_by_type(enum bpf_prog_type prog_type)
 	struct itimerval timeo = {
 		.it_value.tv_usec = 100000, /* 100ms */
 	};
-	__u32 duration, retval;
+	__u32 duration = 0, retval;
 	int prog_fd;
 	int err;
 	int i;
-- 
2.21.0.352.gf09ad66450-goog

