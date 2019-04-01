Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59467C10F05
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260E02133D
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGwYylDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfDAU5p (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:57:45 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:36095 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfDAU5p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 16:57:45 -0400
Received: by mail-io1-f73.google.com with SMTP id a7so9279138ioq.3
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QvC+6KsvhsCBwL8xB3lTNmZCB09+RPOf/VOErLE0ZCo=;
        b=fGwYylDpN3OpfKwA53Tg7u2Z3YC5EhaQrsWWnIasm70wmXpi+klnRLKAZQDFC1PG8S
         +kJp3xKiih9Y+1XVI74ETqF/AA+50FS6qkWD2+7no4Gr9z8/sAGuf86t/vpFVRfZ824z
         G+T5vrsAIRjtsqnmdBNjc3DyNXq07UWxSvNaEv4WfuyaXVk/JFScJpZnFSlyWQ+djDNF
         nQ3MxjsvarmwHzCbIp2evXUftna1JK8TG87gNSP1H7u7lkxkgEkQ+rtE662alUT9TEc4
         mAv5zdBCXOpntEpb92riFle3URMlpPgtrFvrG75RBROTHWKY3Yy7+pCE24e6S338GAab
         l9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QvC+6KsvhsCBwL8xB3lTNmZCB09+RPOf/VOErLE0ZCo=;
        b=TZd6AvA6VzOEIV5Ty5DnVwZE8o1JWq1BZnMn9+S4BH1HCudaCKzdk41i7gT4Cvb5N1
         j3H3jfKeIjiyPSVyXxOnil/esZ2+PBLGxovL8fF1r78xrlcQF1qbbk6Rj5n0OTIF55/F
         TKMU9/6lJ17FhuS7cEf2XhY3SrCZOTdO4dGmiw9RnstSNRw2C5pIb9yFvn1FSXOazL0V
         a1e8lxnUlYfluFF3tWZjyAVz/n1Vl2+MAE8LjdLhTew6iJr0hcAtiFcXm3Ti4ahXu57v
         OAons+9ribPOlIumiKrcnUqhe5SNMt7kierBsB463UE6tdtnMTdFO1f8T3bWOR6PnUWa
         7CAQ==
X-Gm-Message-State: APjAAAUg6G5KOLRTHXZ0zVrB3052P/hRFNzkIknExcxGC4aIUn9ovTWe
        gFf+5bKqgKlbCmlJuJPBa9P3jP8=
X-Google-Smtp-Source: APXvYqxSzRrsafFo99wqOK7ZGq9+30NvLFSeYT+ty2PNRuDj8MnfOxI/yHeWe76QrePN6U0LZFKBCEk=
X-Received: by 2002:a24:2f4c:: with SMTP id j73mr6659678itj.24.1554152264349;
 Mon, 01 Apr 2019 13:57:44 -0700 (PDT)
Date:   Mon,  1 Apr 2019 13:57:32 -0700
In-Reply-To: <20190401205734.4400-1-sdf@google.com>
Message-Id: <20190401205734.4400-4-sdf@google.com>
Mime-Version: 1.0
References: <20190401205734.4400-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf 3/5] flow_dissector: fix clamping of BPF flow_keys for
 non-zero nhoff
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't allow BPF program to set flow_keys->nhoff to less than initial
value. We currently don't read the value afterwards in anything but
the tests, but it's still a good practice to return consistent
values to the test programs.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/core/flow_dissector.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 9b84250039df..94a450b2191a 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -717,7 +717,8 @@ bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 	/* Restore state */
 	memcpy(cb, &cb_saved, sizeof(cb_saved));
 
-	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, 0, skb->len);
+	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff,
+				   skb_network_offset(skb), skb->len);
 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
 				   flow_keys->nhoff, skb->len);
 
-- 
2.21.0.392.gf8f6787159e-goog

