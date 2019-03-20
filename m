Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001A1C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 07:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86442146E
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 07:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Og6AX0iM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCTHGt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:06:49 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:35906 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfCTHGt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 03:06:49 -0400
Received: by mail-pg1-f201.google.com with SMTP id m17so1814047pgk.3
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O76ZRuh4ryFYFDKtXPrkcncLov68bX+7hcSJNmgQXec=;
        b=Og6AX0iMnDJRf7AWFoTKrVtCDI/f05PIrGH/d4ZKNNd4qLScbf0fXitTPjrV3Bzgl9
         r4x/eBhSn+MNcxVVj72R3EFoGQ6HmwgflhIuvhRW3oKhHCjvGaBe3hLGqpDbW75JZ6CU
         xvLjgd77AT3aSkTudn6fW+Wc2zdCHPUeE7vtdjvLVlm7pQ2icsuwz73dnNosPg9UTk2B
         MGi6BezVTOhXln19xVX91sDlgLuuWwrjpy6GA/Iu5LMaekh+U3ov0yFEEO6fgAbTrRYA
         TJMfiTYkiUVq8W8OwTPg5EiZ8rUAX5TLkU7aaWiEx6HeKG8SVpvj6P989sNICNtV2VtT
         gzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O76ZRuh4ryFYFDKtXPrkcncLov68bX+7hcSJNmgQXec=;
        b=ORqSC/tfz96Pi0aqcW6A3TuHxpEcV0J2f4jXkg/F+HNbxOpOWjMOClpz7DdM5JtsxP
         Q8515mYhEqBR8qKAqnHsXWfdd/i5+itihnYUZdHWNpQ/n9o/1m0MZ+e5gS5rai3EYi5M
         OWTyZY7T02V48XFjAdSy2dKOZ0WlGd8JJuqGpmJUtQBR22rc6m6CZZBj0S2j4qdVmrNr
         /RNmFdl2W3B/c+1XiKLAZ3IGmTL21AXweFcR0qlh4pwK6nhnk4JYxj5v0qCi7jqSS9xb
         zc4NaBupO99L6fmGJuteOLYmUlf92d7vEU+Sc7oA+scvZ8ll/+Uu8Y7Lg4y9gQ9S4QG5
         0yiA==
X-Gm-Message-State: APjAAAVgOeLRHf0xe7xoLyrWWxzemE9Mz0hZAkZ596M8Ph3Yciqj/kIP
        svFI+MRM0pK7Kb9RcXhSjhHwZnJg
X-Google-Smtp-Source: APXvYqzA6/GPhcJb2COEhTL7mNiHxuymsjGXmqtk8F7k149LYSNyVOFJgYL/ZEag/JTNAUc7H1DEpREx
X-Received: by 2002:a62:ac18:: with SMTP id v24mr4456042pfe.70.1553065608614;
 Wed, 20 Mar 2019 00:06:48 -0700 (PDT)
Date:   Wed, 20 Mar 2019 00:06:40 -0700
Message-Id: <20190320070640.102721-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH bpf-next] bpf: make bpf_skb_ecn_set_ce callable from BPF_PROG_TYPE_SCHED_ACT
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
2.21.0.225.g810b269d1ac-goog

