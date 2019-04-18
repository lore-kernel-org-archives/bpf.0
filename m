Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04DFC10F14
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 23:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDC0206B6
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 23:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYUCmsZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfDRXr4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:47:56 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45994 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfDRXrz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 19:47:55 -0400
Received: by mail-pf1-f201.google.com with SMTP id u78so2321440pfa.12
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2019 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q5zeOZoLuoH2wTeHxii/R19XNZLtjB7l+Dxusrt2mNs=;
        b=YYUCmsZ9fWhHSfLimqKWx24mlwEFWVBokrAlbnXb7/61q11wScxIhjQZAc1X7R9nSJ
         dv7u2I8LRF8gk7jF67yNsHaSBJ50Ar+uirMGHrUSQnz9iQU0N0nYTGIqEehT5ht8qvyt
         Nw6BMOfy0OWDs2jDCzk2olwStG+JMxuHEZEKYYiw2HQjFZqk6RJEOBjCuM6YuCyX7Lrz
         OeqLyooM7akeEiCfxv3r7VfL8wqokaavDRqwf+cgk8Qs3dUpXWmbzwhg4UmzF+CL7IZv
         fizyAGbXCBo4yKDtjl5pHXTQFimaS1SkxFP2y4RdecexDpinvg4H3OnsQn1DONrjToOP
         d5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q5zeOZoLuoH2wTeHxii/R19XNZLtjB7l+Dxusrt2mNs=;
        b=DIqYvaBvODVZN1RAJP3yJdYaCcLVo/IoEI4SkwRnqcILnMmBtPVBMMnwhV3V/0dcqC
         B72kUYKtDPcc5cUkGnzqAsquba6jhwSF3lUeykZUq5nYP1TUaBkeuefv8aMPu7/RiA9F
         srt1RCAsuyA+Wq/zTEMIDhc+gxcVcUiS/4tsCnqsC3LOiM3Ztn87W5Ss8ac3TxKXSJ6l
         Uk0IQ20bPj0Enu9Z30pI5RZdcUGfM2vJ4pDbAsdJ9DQPgSKLuyQVqYUrZN3L8G3Dw5vF
         7vXjy7yTHrkW9BVr9a1TDs0ue1ERLUnJSRyq0XpQ21UoLoOQIvYt18AtuOpa3A7a9gCR
         kpdg==
X-Gm-Message-State: APjAAAVZKTJUqjYI8YPhdMs3xPGBbVqWGTMZK0+NpwmrGXLsUoDvZpP/
        eNqqxEyaCV1nKmySqfiOSgeNFF4=
X-Google-Smtp-Source: APXvYqyj57c7S8mWL24e0KVT/M/pfl+vrEx8kZirBsL0Gfp3jfHJ3fzTmlCvq4UHN4x+rFRU6ePBlEc=
X-Received: by 2002:a63:8848:: with SMTP id l69mr734089pgd.137.1555631274703;
 Thu, 18 Apr 2019 16:47:54 -0700 (PDT)
Date:   Thu, 18 Apr 2019 16:47:52 -0700
Message-Id: <20190418234752.214364-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next] bpf: move BPF_PROG_TYPE_FLOW_DISSECTOR documentation
 to a new common place
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In commit da7031491786 ("bpf: Document BPF_PROG_TYPE_CGROUP_SYSCTL")
Andrey proposes to put per-prog type docs under Documentation/bpf/

Let's move flow dissector documentation there as well.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/bpf/index.rst                                 | 1 +
 .../bpf_flow_dissector.rst => bpf/prog_flow_dissector.rst}  | 6 +++---
 Documentation/networking/index.rst                          | 1 -
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/{networking/bpf_flow_dissector.rst => bpf/prog_flow_dissector.rst} (98%)

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index dadcaa9a9f5f..d3fe4cac0c90 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -43,6 +43,7 @@ Program types
    :maxdepth: 1
 
    prog_cgroup_sysctl
+   prog_flow_dissector
 
 
 .. Links:
diff --git a/Documentation/networking/bpf_flow_dissector.rst b/Documentation/bpf/prog_flow_dissector.rst
similarity index 98%
rename from Documentation/networking/bpf_flow_dissector.rst
rename to Documentation/bpf/prog_flow_dissector.rst
index b375ae2ec2c4..ed343abe541e 100644
--- a/Documentation/networking/bpf_flow_dissector.rst
+++ b/Documentation/bpf/prog_flow_dissector.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==================
-BPF Flow Dissector
-==================
+============================
+BPF_PROG_TYPE_FLOW_DISSECTOR
+============================
 
 Overview
 ========
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 984e68f9e026..5449149be496 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -9,7 +9,6 @@ Linux Networking Documentation
    netdev-FAQ
    af_xdp
    batman-adv
-   bpf_flow_dissector
    can
    can_ucan_protocol
    device_drivers/freescale/dpaa2/index
-- 
2.21.0.392.gf8f6787159e-goog

