Return-Path: <SRS0=zD4z=YI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31462C10F14
	for <bpf@archiver.kernel.org>; Tue, 15 Oct 2019 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C4120873
	for <bpf@archiver.kernel.org>; Tue, 15 Oct 2019 18:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGBifvcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfJOSb3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:31:29 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:49005 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfJOSb3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Oct 2019 14:31:29 -0400
Received: by mail-ua1-f74.google.com with SMTP id p17so4888600uam.15
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CmKa1agNJrPbYf7wPjFa61AdTdkKzngqPFR94jGBSQo=;
        b=lGBifvcuX1cVexaA5gZeOPCnRsCalHgm2qQisbsa0dHr3aedYyrsUnNUBHWZoNeTRD
         WQYNEKanf5y+qnqLraviO6anBsvYHr1pkVVAD1o0Rg/lbky8a+e+VhbWrhdp1z4i0fn0
         NqOcPc5nFQYY+4DoccufQTECeEHuJMUknxF0OBdJK45KLs1btsCRZ46L15pEnT1Vyx5u
         aGNsukzP+FMvxatv2FyNJ+BU0JFm0a72aswjLKcyMMTIZOd8us3QRvRSvi60RY9gJqEg
         lDrQmJZ69noIRgmZhydKG3X2uXYyj5Onc01FCkaQkvBnojPcAMAPvtj5ULC/+b1L2BM2
         UnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CmKa1agNJrPbYf7wPjFa61AdTdkKzngqPFR94jGBSQo=;
        b=ki+sZeT4GMaHTxCcq/QQJBI+pnbrDnLNG7AWGdSPoTihsntTHe/NA8+inEncwPRgno
         G+LxvIsw1Eg3P3K75qjSMgk/LKFnK5ZQZkEik8cDF3GVT2AXqAonbwcOsm1kXVFfhDBu
         OkpFwFT45xPGF+JOKdlfPg5UsHipDgr0vkJZpZDkspZ7+THiQ6J9IVjJzO5Dr/cgqWf1
         PEY8z+oDcQWL8bZCUuklu6N3qkWM6nwSTdUmLtNtWmUa/HWNoBaTkDYEr1QApNjnk+EY
         F1KQKPlsfvoBcqpxfDVWJLup+D9euWMXnV9JjnpMFWnw2qKKs/5/wqN4YAvt53rBoIwi
         tcmQ==
X-Gm-Message-State: APjAAAVykacWCepm5Z6odJzT3Rh6IwEf9D90makNWljABwc3zqy2CJcB
        moC+mZXBIeKEZrRmUlbGO1klv6c=
X-Google-Smtp-Source: APXvYqwFHz820XERQXeDopog7LjIac4wUp2RN27ZKfNOfcZumQKKktikhSc5kB/vwR++lltOP6L5znU=
X-Received: by 2002:a1f:b658:: with SMTP id g85mr19707472vkf.52.1571164288130;
 Tue, 15 Oct 2019 11:31:28 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:31:24 -0700
Message-Id: <20191015183125.124413-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH bpf-next 1/2] bpf: allow __sk_buff tstamp in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's useful for implementing EDT related tests (set tstamp, run the
test, see how the tstamp is changed or observe some other parameter).

Note that bpf_ktime_get_ns() helper is using monotonic clock, so for
the BPF programs that compare tstamp against it, tstamp should be
derived from clock_gettime(CLOCK_MONOTONIC, ...).

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 1153bbcdff72..0be4497cb832 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -218,10 +218,18 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 
 	if (!range_is_zero(__skb, offsetof(struct __sk_buff, cb) +
 			   FIELD_SIZEOF(struct __sk_buff, cb),
+			   offsetof(struct __sk_buff, tstamp)))
+		return -EINVAL;
+
+	/* tstamp is allowed */
+
+	if (!range_is_zero(__skb, offsetof(struct __sk_buff, tstamp) +
+			   FIELD_SIZEOF(struct __sk_buff, tstamp),
 			   sizeof(struct __sk_buff)))
 		return -EINVAL;
 
 	skb->priority = __skb->priority;
+	skb->tstamp = __skb->tstamp;
 	memcpy(&cb->data, __skb->cb, QDISC_CB_PRIV_LEN);
 
 	return 0;
@@ -235,6 +243,7 @@ static void convert_skb_to___skb(struct sk_buff *skb, struct __sk_buff *__skb)
 		return;
 
 	__skb->priority = skb->priority;
+	__skb->tstamp = skb->tstamp;
 	memcpy(__skb->cb, &cb->data, QDISC_CB_PRIV_LEN);
 }
 
-- 
2.23.0.700.g56cf767bdb-goog

