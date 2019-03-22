Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715FCC43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 23:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAA8218D3
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 23:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnwIGhSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCVXk1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:40:27 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:57100 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCVXk1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 19:40:27 -0400
Received: by mail-vs1-f74.google.com with SMTP id 2so1103426vsp.23
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 16:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PZra7rmKQL+k4tdBtTMN82t+lKMYWKZNR8QUSSzsFso=;
        b=dnwIGhSpTlC2V/dhInqMZRd7cSQk3DrxC3xYQYmpoh5ifqiTopTrPzDsrL6CKTToLf
         XXVkPUoGPZwMqeouxa0aAudS4dQj2hjRe9I1KICzwxSN5xcXcbwIzbjmiDhOw3MMzBkO
         GjmQrDqiNpMERd65Owihaw0QYtYk99A73qcoiC9yVYTJ8AZaqGd3LTEaovQtT66u7Vny
         pBTJdOpFn89S4dGy6DbAr5rlJBChADypq9btLXwkV+EjRnMTjHmcuG3t1AtOwQnx9N17
         twn5WbDwZB8TuVQdXdtkBbziOY0VRk+O4ZUc3XlEdwK8Uo7jyBgcMfXeCO9WZ2Ec8pVF
         VTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PZra7rmKQL+k4tdBtTMN82t+lKMYWKZNR8QUSSzsFso=;
        b=a/O7AI73LjMyXrsED2h4kfAw+AS6o+8cl1Ywq91Nm+kv8uYyuZtHJpJQABld64CYOe
         GLPRb1O6C6mskhY3vmHC7ozMmd1nSbvB3/9lMgJ9mvdiJ2FDHzRLdQuKJ8SPdgdnESxH
         4fDsZcgHNmfyj4dz7br/FtCjhwTxOSLVh3nU8Lrvt52Z/2Fe4QgsqU/sNpdeLhPXYHSe
         W5eTz2cQC4wMGTEwgz7r7N3cE5ZMth8jZiecEq1VObuYbhtMfCx6+Ou+oNH5jJkoCURb
         fPIvP4LNWUySb3FzgrCy/P2iZ85zNE0N8tMaViaehXoJba9/JocNOWETtgyobJF9GaWa
         LXwA==
X-Gm-Message-State: APjAAAV5vPLL7IRjKHSL91PMdw7Xe5QWXtmIHlkzSKav5h+li2BdFCh1
        OB1N6PG9m2TRmQpxmXJ6nFkjHM1Y
X-Google-Smtp-Source: APXvYqwvsW3+pDre+A2MDpCD7wUjic8TGXHtsMaApbA6SsKo+lX0RYwU8BzMWW4QLJCSMbIuf8I34vGl
X-Received: by 2002:ab0:2653:: with SMTP id q19mr6144254uao.76.1553298026018;
 Fri, 22 Mar 2019 16:40:26 -0700 (PDT)
Date:   Fri, 22 Mar 2019 16:40:18 -0700
Message-Id: <20190322234019.229181-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next 1/2] bpf: make bpf_skb_ecn_set_ce callable from BPF_PROG_TYPE_SCHED_ACT
From:   Peter Oskolkov <posk@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Peter Oskolkov <posk@posk.io>, Peter Oskolkov <posk@google.com>
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
index c1d19b074d6c..0a972fbf60df 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5959,6 +5959,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_skc_lookup_tcp_proto;
 	case BPF_FUNC_tcp_check_syncookie:
 		return &bpf_tcp_check_syncookie_proto;
+	case BPF_FUNC_skb_ecn_set_ce:
+		return &bpf_skb_ecn_set_ce_proto;
 #endif
 	default:
 		return bpf_base_func_proto(func_id);
-- 
2.21.0.392.gf8f6787159e-goog

