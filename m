Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93E3C10F03
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE2A21900
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4CLVZ3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfCVT7P (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:59:15 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53856 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfCVT7O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 15:59:14 -0400
Received: by mail-pg1-f201.google.com with SMTP id p127so3067727pga.20
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cjne/2oaFJH1zD8V/eZImWH2sckT1/bG7CqFwi1jy5w=;
        b=U4CLVZ3MOxS8kOlcEzRebt1Y2pFqWxJ96x62LyHQWZrpvz07ksS+tZhWMIi6EF/x7V
         +l/XzWcIW6sVd1Q28KT9DkLZqZO3ovkaNZQHExUkX7YM9dkzi8YmAd/LCHnXe1bUJ6WN
         Q2b3WTvs+UhPNalt5Snqqt5mV/lPp8sSD8o0yCUhWK5t4RYBaiVLr9jouxuHvylYGC5J
         akVetAV97x/F6JKX96LisRV4SFwhIdlC7H7RCfFEYX9WbdOO/6PFHkW7BcHpCitxVUue
         RVlU9JhxfO2rD4kS887vdxCKqenNXMaDJ0uDxiiaBN1Bv3/VV7y3RTksC3B7YL1yXOt/
         I2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cjne/2oaFJH1zD8V/eZImWH2sckT1/bG7CqFwi1jy5w=;
        b=qtzHBymjvuPsy6XZK8jwWynyFj4F2mO0U58mmaxyB4WEuNBWZp9G56faRL1+2dd8di
         U33/VyhJhWDHMiSyw2VeOPtWhfEBlRDK5z71tUL+Caqm64WVkdAccyTT54tmz6PVHGrV
         lQ+GAl4ypGRILJJ+HkohKDYuPdRUAlE7lEbiMjXoyt75MunYXn0l4w7hwSzAYE0owlMt
         soasEw7c7nvETAQHvuSumFtDWMeGNXqxCfUAS1qd8Qe678SlC7sAEqvlSiG1zWVS1jIZ
         NPquWbuRgRIDBfPq1cHulZlBpX4i2FYn7WD06LdFHUAMHSjl8JA7osMwBWYTQsCA6kaf
         qlIw==
X-Gm-Message-State: APjAAAWnHKyCJugA3hBm45tX6sJZsvBgzH4Xj8Se0M+y92fz7MvKBzKB
        4D4z5rd/M+wEpW1fW+SxvvYMnRk=
X-Google-Smtp-Source: APXvYqwobB1AiBZk37ey5k748vub0Bx9Cl1yJRXsj3L2hhwDo2v+nfiRD4UwspjpoqyvvgDOL2b/ydI=
X-Received: by 2002:a63:570d:: with SMTP id l13mr2939836pgb.55.1553284753727;
 Fri, 22 Mar 2019 12:59:13 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:58:58 -0700
In-Reply-To: <20190322195903.162516-1-sdf@google.com>
Message-Id: <20190322195903.162516-4-sdf@google.com>
Mime-Version: 1.0
References: <20190322195903.162516-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC bpf-next v3 3/8] flow_dissector: fix clamping of BPF flow_keys
 for non-zero nhoff
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
 net/core/flow_dissector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0dac3382e841..3b35fc35f583 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -716,7 +716,7 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 
 	result = BPF_PROG_RUN(prog, ctx);
 
-	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, 0, hlen);
+	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
 				   flow_keys->nhoff, hlen);
 
-- 
2.21.0.392.gf8f6787159e-goog

