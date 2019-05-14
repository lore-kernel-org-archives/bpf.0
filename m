Return-Path: <SRS0=CEAn=TO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3845C04AB4
	for <bpf@archiver.kernel.org>; Tue, 14 May 2019 21:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45CB20873
	for <bpf@archiver.kernel.org>; Tue, 14 May 2019 21:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3ALmlol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfENVMi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 May 2019 17:12:38 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:34587 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfENVMi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 May 2019 17:12:38 -0400
Received: by mail-oi1-f202.google.com with SMTP id x193so193789oix.1
        for <bpf@vger.kernel.org>; Tue, 14 May 2019 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ST8fThbwHB7FPyg/UYGhE320wSCcxJdrKK/TrBgEs88=;
        b=R3ALmlolgf8qQenjhtDTatJx1C6YLXjJj/KPwFTnaTz8tOuYLjlYjTrtuGSqYsUynU
         sGUT7dP60mO/doCNlzhHTh+BpSUNbuobTFFl96UJJwUa4QtEUEbCR3De6edSnrMgzL04
         bmYuHdafYOVGhqxz/UFT942qYt5fFgbWxKrU8AfJG0oPI/VGenN60h4Z+/9qfDdeEWlw
         9fdaC2cy08y8nuBFqLcUCtr4CM5SQl209NIFXXKHKoI8EkiKsUH9f8V//Ew8GgMezma0
         cbSdI7gXVVwBpBzOcAzU8ule6nnNV+cjnRJO41KzZVWfJIxShedPh0Ks5e5RRSA9VNDx
         BacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ST8fThbwHB7FPyg/UYGhE320wSCcxJdrKK/TrBgEs88=;
        b=aGdwkxz5gg9GCBfIYVlvA/TbRAEQAaZ4MQTUOziy2mZM5uBgBQKAZsALWOXII9w2ni
         /sFuJVZHydGvl5fjKvZkYfx/O181j00wOMaprCRe/Rj7+f28Je7Ry5tzz3xJ5HPwKnMu
         T3cWdx1gQK65qFSaDhZ/BWh/ts3NINqxcZeFqYWu8lTHUUL2u9dZKDtYODG5guPdkQkj
         8X2M1AXcFE9rBJc67b7r3DswlNtyix46RKkOftoYkZXS/rq9mvb4YrYjRp2e8PUALove
         fCUt/DKpWi7CiTKHhFaQKyDmvZZFGqcopHaARsRGKyiWl1pb3zDflD7Ghv3Owf97C2DM
         +Syw==
X-Gm-Message-State: APjAAAVnswhIAz39w9brkKb4ehD5xwgRC2giaTfMZRiH5q7eZR+Mo5k1
        hl+Mxv1OeA7jethoSjqMRGkE8Ug=
X-Google-Smtp-Source: APXvYqwSR5YBY5Hae3ywGuyWpPCY8+qie2boxw8IZcOirVPvEt+vVISriL7y0U7Wie5c7e5OHS5+OtI=
X-Received: by 2002:aca:f444:: with SMTP id s65mr4191410oih.115.1557868357209;
 Tue, 14 May 2019 14:12:37 -0700 (PDT)
Date:   Tue, 14 May 2019 14:12:33 -0700
Message-Id: <20190514211234.25097-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH bpf 1/2] selftests/bpf: add missing \n to flow_dissector CHECK errors
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Otherwise, in case of an error, everything gets mushed together.

Fixes: a5cb33464e53 ("selftests/bpf: make flow dissector tests more extensible")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 8b54adfd6264..d40cee07a224 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -242,12 +242,12 @@ void test_flow_dissector(void)
 	 */
 
 	err = bpf_prog_attach(prog_fd, 0, BPF_FLOW_DISSECTOR, 0);
-	CHECK(err, "bpf_prog_attach", "err %d errno %d", err, errno);
+	CHECK(err, "bpf_prog_attach", "err %d errno %d\n", err, errno);
 
 	tap_fd = create_tap("tap0");
-	CHECK(tap_fd < 0, "create_tap", "tap_fd %d errno %d", tap_fd, errno);
+	CHECK(tap_fd < 0, "create_tap", "tap_fd %d errno %d\n", tap_fd, errno);
 	err = ifup("tap0");
-	CHECK(err, "ifup", "err %d errno %d", err, errno);
+	CHECK(err, "ifup", "err %d errno %d\n", err, errno);
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		struct bpf_flow_keys flow_keys = {};
@@ -255,7 +255,7 @@ void test_flow_dissector(void)
 		__u32 key = 0;
 
 		err = tx_tap(tap_fd, &tests[i].pkt, sizeof(tests[i].pkt));
-		CHECK(err < 0, "tx_tap", "err %d errno %d", err, errno);
+		CHECK(err < 0, "tx_tap", "err %d errno %d\n", err, errno);
 
 		err = bpf_map_lookup_elem(keys_fd, &key, &flow_keys);
 		CHECK_ATTR(err, tests[i].name, "bpf_map_lookup_elem %d\n", err);
-- 
2.21.0.1020.gf2820cf01a-goog

