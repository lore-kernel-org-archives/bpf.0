Return-Path: <SRS0=TB1Z=WW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC899C41514
	for <bpf@archiver.kernel.org>; Mon, 26 Aug 2019 22:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76D3217F5
	for <bpf@archiver.kernel.org>; Mon, 26 Aug 2019 22:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnUTkHGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfHZW1Q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:27:16 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:39278 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfHZW1Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Aug 2019 18:27:16 -0400
Received: by mail-ua1-f74.google.com with SMTP id 43so1585669uaj.6
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2019 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kHR55eOf2d03mqaPFCc0rnz+Hpv6KeB+AOucyBkzha4=;
        b=fnUTkHGnRSymR3vzZa7b5WoOXGW9mVI5oxj5Zz89LSP2Tn8pHQeFdmzS4lFMeUYJ+B
         MagpHvLCuPnAuw7+mRU8UVKbDkk60DAt1tH4vusMl7O6DpJw55Oe0eXkp7bZfU79vdgd
         CynwLtcN6zd/vu4g9jwj0jENABlVWG4IJAA/rmXM9NisNu8HkFYzLQtijtWFlBMqGtnN
         okWhgPLJN6k6xPgaB1dzjSYZVBfd39Xmebw5gOa+iIEu3SA8Mkj66t08u3S1bALMvdkE
         5XxAiGDIdxhP2EsfGfOsuK4bbCTWuBvIZB0j3f7/7VUofYLvYA4q52GaOdcZzDZ+1hwt
         XN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kHR55eOf2d03mqaPFCc0rnz+Hpv6KeB+AOucyBkzha4=;
        b=kWaEZlvBd4wxVc4TLmFY/MaEh9C4x5QG4Q3/rFonNiwuXfjfY9YnXLD2vxVqWlDf2R
         nyJ2YwgnaHARm51xGeBBhELeKwnSKvV5a642e0HKl4sUAQxTbBwukePzl2QzlgaOYKLF
         j9WPd2MfhcHliu8mMnHc7fmukwmJ2Njpkeiv2SmXrOLqWVS+uSB72O2wEz10XsdLslem
         czVVJzjiCIyJou3M450ipKtLXVu9v4lMzSFKBMFLj3tuBi8h5TIhWDtGWS649z7sR0JX
         M4FYEHg31cejIa/DCt46Uo6y6wWr6kYUABmXyiuEZmFaKhLpwpsmLjImWqHv4LMjDmtm
         T+7w==
X-Gm-Message-State: APjAAAXlH/K8oKU6It52VrhV/+J5EEQuGH0hag5baaBYJbO6uCIzWAa+
        Psn3wJ5/LXo9CHqgwFLdRUurM1c=
X-Google-Smtp-Source: APXvYqzlk5hQ/C4oVbFOLotxGHC2FlX9UkN9t9Nf1WvGovaoktoAZKeqeF/DzADFpjbM2cMOi8EqX38=
X-Received: by 2002:ab0:630e:: with SMTP id a14mr2036205uap.37.1566858434673;
 Mon, 26 Aug 2019 15:27:14 -0700 (PDT)
Date:   Mon, 26 Aug 2019 15:27:12 -0700
Message-Id: <20190826222712.171177-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next] selftests/bpf: remove wrong nhoff in flow dissector test
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

.nhoff = 0 is (correctly) reset to ETH_HLEN on the next line so let's
drop it.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 6892b88ae065..d2f4a8262200 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -344,7 +344,6 @@ struct test tests[] = {
 			.tcp.dest = 8080,
 		},
 		.keys = {
-			.nhoff = 0,
 			.nhoff = ETH_HLEN,
 			.thoff = ETH_HLEN + sizeof(struct iphdr) +
 				sizeof(struct iphdr),
-- 
2.23.0.187.g17f5b7556c-goog

