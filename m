Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80403C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 00:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CB721874
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 00:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVWIgeou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfCOA3K (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:29:10 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:35549 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfCOA3J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 20:29:09 -0400
Received: by mail-yw1-f74.google.com with SMTP id d18so9536099ywb.2
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 17:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d7yp4WdJqZWVY56hrYDelpam2jgQ5VJoV5WqLaSFCgk=;
        b=DVWIgeou/uhont0pQWVVUteltNvi+w5UmJk94OHQhMIJnAqvrCicJEMX7q/a8oQbZE
         uHcb4ZqhX6ioR9tFpS8k9ijCKXSrt8DhxDZeDI+QZ3Uv2XGUA5UhqBgTd4wNjN4pR6BS
         8Fz0PZGmcVL9ROyWk80gB256RaZOHGNdiuJ6s7Lk5IzS5BtWp6gaXbdAst8yXXV/bFTD
         2ZCTS9miNc30OipSBUThJ6h+3zVPz5Oj1FyB//+mVhY39dZedoiou1agwdTBHjBrCc8d
         QDhFwA/BwKjU8+uSFDnWgsV6C0Y0J7WsE8prYladJlq9q94JKLbN2lGiFSUncyrP0Z8f
         hiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d7yp4WdJqZWVY56hrYDelpam2jgQ5VJoV5WqLaSFCgk=;
        b=mzcptgBQhH9IOwYT5dS7SxmKB0YkqehPfmCFFPDn8Qk3ykf909LNfDTovFolQ1dl8N
         w4oaCty0JrqC3dCq/1yNWnq8ylqncNvbuWx7rUotdtDfhAHZ4JSPbG5rOJp0bBaImQTV
         k8CBQZH+utacEjt31A7/YFw9uvS2H6bLN6UYZkzJpPpBhR1xHvREsW9UtPXqEV5A5Kkw
         caBkw6pKEgfcEam0GV1rqQ3xFHQktLFrMkEFvfjm01KEGCnBEVFB5TlWKXLI1o7IBGPf
         mHZPEwS08WWvVYkdXfqXLDt/N1zGC8oaRTkIg4Eg/QXBWLfY5VWAmKssGowWBIugcRFE
         io8Q==
X-Gm-Message-State: APjAAAWe4BAxkS5uWL2W4FytbBV/CIygQVbhpRkw/AzxBDOFKVTDjXPq
        EAu9rxQhgZZQJDefYFO+m8/5yj3W
X-Google-Smtp-Source: APXvYqxrXHZOW0HUDcfs+LYoi3OylKxlffhz/zppdYlI3vDTHMMvkKr876H1ONzDm5TzOnRPhRhUQEUK
X-Received: by 2002:a25:50c7:: with SMTP id e190mr331107ybb.37.1552609749032;
 Thu, 14 Mar 2019 17:29:09 -0700 (PDT)
Date:   Thu, 14 Mar 2019 17:28:58 -0700
Message-Id: <20190315002858.228416-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH bpf] bpf: make bpf_skb_ecn_set_ce callable from BPF_PROG_TYPE_SCHED_ACT
From:   Peter Oskolkov <posk@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Lawrence Brakmo <brakmo@fb.com>, Peter Oskolkov <posk@posk.io>,
        Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This helper is useful if a bpf tc filter sets skb->tstamp.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 647c63a7b25b..c6d016d9c4b8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5719,6 +5719,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_tcp_sock_proto;
 	case BPF_FUNC_get_listener_sock:
 		return &bpf_get_listener_sock_proto;
+	case BPF_FUNC_skb_ecn_set_ce:
+		return &bpf_skb_ecn_set_ce_proto;
 #endif
 	default:
 		return bpf_base_func_proto(func_id);
-- 
2.21.0.360.g471c308f928-goog

