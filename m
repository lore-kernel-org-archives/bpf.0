Return-Path: <SRS0=gAxt=WX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A844CC3A5A3
	for <bpf@archiver.kernel.org>; Tue, 27 Aug 2019 23:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FA220856
	for <bpf@archiver.kernel.org>; Tue, 27 Aug 2019 23:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXGv7CtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfH0Xq1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:46:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45465 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfH0Xq0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Aug 2019 19:46:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so286072plr.12;
        Tue, 27 Aug 2019 16:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4MNziSysY8PHh1GoxArbSU82why2KzwS4A+okCO/tZw=;
        b=eXGv7CtOBdS7F9rcrmy8kVUymCdlaa5LeJblww4lTwCfy1FGbtTDLqZEJkD4+6gBUs
         beLhI8BTFpEBCgbM2ZKJz8a+RJ8JNH3cFmc+aVuyjxP7x1+zhIuLgUFSEhmQs8Hnj1g1
         f/mUlUzkk7zHkk0OwzoxK52cJQvlv5WKcMt0c29jwTBhYcl0TChwWQRYrUMtyuq0f0cu
         feblnXe4JDjtNeG5CQwmq9wFgpvxEE34wvquzg+KRXAzc9k6CTZtMz47V111mgYRWAUa
         yZMADqWvdJNIFSUPMPZtw0f29EiTmTAhfNCbHZbohBT5cME/obiPdmCJU0UBzSIuf1Jv
         Mg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4MNziSysY8PHh1GoxArbSU82why2KzwS4A+okCO/tZw=;
        b=nCnkjDyAZ3PqYljnMQCDr5pM3L5OLosyF6CEjYYjUPA1KP4FyAnNvhoefmDkylgkn+
         uziArn9BGLCTSDQkRvmeVANwgkwGEVblrCkPQ9xJUXwqof6EGmlD9v6wtChR/CFYBXT6
         YXjtmSBZteb6oKApJV9cfkKBPJHYOIMQXu3rkqWNSvZVsKzmnVCX8WfXoKDUXDxk30H2
         CRlmLUUS6VIv+VJtEJF7Qfwl1wllLzU3ZzoITMzjumIBcrOjrRAHK8IMykyv5u2LMmJz
         HrEnPIGddqAiy+pi3j32a9bbQB/6KkSsnIr9cUdQCION1y3eMgiSFwhLQLGTAELP5aXt
         Ky7w==
X-Gm-Message-State: APjAAAX9jviWZosas+Uv8oPCVsROFqqA+PrZLI5hUlD1QffFQubJ7azM
        n6NvPKvwCP3YDcCnIVV+eFk/0jg7
X-Google-Smtp-Source: APXvYqwOibL4/nycXmbBk4/lLpx49308ILrGv1RBvkSQ172VvmP+TOcvQ+3raaCKSw8Hms6Ldv/q/A==
X-Received: by 2002:a17:902:110b:: with SMTP id d11mr1534407pla.84.1566949585915;
        Tue, 27 Aug 2019 16:46:25 -0700 (PDT)
Received: from ppenkov.svl.corp.google.com ([2620:15c:2c4:201:7bd4:4f27:abe4:d695])
        by smtp.gmail.com with ESMTPSA id w26sm453181pfq.100.2019.08.27.16.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 16:46:25 -0700 (PDT)
From:   Petar Penkov <ppenkov.kernel@gmail.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Petar Penkov <ppenkov@google.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [bpf-next] bpf: fix error check in bpf_tcp_gen_syncookie
Date:   Tue, 27 Aug 2019 16:46:22 -0700
Message-Id: <20190827234622.76209-1-ppenkov.kernel@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Petar Penkov <ppenkov@google.com>

If a SYN cookie is not issued by tcp_v#_gen_syncookie, then the return
value will be exactly 0, rather than <= 0. Let's change the check to
reflect that, especially since mss is an unsigned value and cannot be
negative.

Fixes: 70d66244317e ("bpf: add bpf_tcp_gen_syncookie helper")
Reported-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Petar Penkov <ppenkov@google.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0c1059cdad3d..17bc9af8f156 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5903,7 +5903,7 @@ BPF_CALL_5(bpf_tcp_gen_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
 	default:
 		return -EPROTONOSUPPORT;
 	}
-	if (mss <= 0)
+	if (mss == 0)
 		return -ENOENT;
 
 	return cookie | ((u64)mss << 32);
-- 
2.23.0.187.g17f5b7556c-goog

