Return-Path: <SRS0=ey3N=6H=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F47C54FCB
	for <bpf@archiver.kernel.org>; Thu, 23 Apr 2020 12:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737272098B
	for <bpf@archiver.kernel.org>; Thu, 23 Apr 2020 12:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEH1jWKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgDWMpq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbgDWMpq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Apr 2020 08:45:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E27C08E934;
        Thu, 23 Apr 2020 05:45:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so6662037wrg.11;
        Thu, 23 Apr 2020 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=out4PF7f/PmTIeJMMNg9xrpl67X2+hDnaDGBvd5Qh6I=;
        b=SEH1jWKV903FaLqMz8aHHnCbdx0XE+eaEso7o5J4JGZkkKyMYT2FZX6gmDu5io9L4O
         XhmCAmk+9ygDNmWYQboRZwlEUxJCWVZlzNzb1DNJAtm/JaG7KBA6SvbmLkAt8a0sH4GA
         P5rsgyQZJbVZ8xU3mf+pD5AF/guqDgQiOE1WBvaCLqoc6+8Xc3FcZlqZSlPC3cIXFKTh
         rlAIgReQKVFuDTSEgklm/rYQp3INflYJLLVmRR2OHBwjaOk3r+wjw5n84VPBcQeJIlix
         uhaRCsjKui/yJF4394LZt6kykocczgiBPim6P8jprY4kcp2LMGrSFXX6/zQKp5Xxvw0R
         qFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=out4PF7f/PmTIeJMMNg9xrpl67X2+hDnaDGBvd5Qh6I=;
        b=ch24rzIoit+KoUnt1QV0tauG/PjHVNa1yAH1kqy5fuhJwrr94wrv5p8Isgjy+lg08R
         v8xn2KV+C5KdoAFT0WIj3Kao0sPFzGsO3sGSaqoghaSh2bqLuWZDlvDW11KAk6LdLYIc
         NpyySItQgWwqLI/RclwLJS7CSNsc/FGSEj49Ot1Ze1yZKawEefri6CUQpAtdywibB4ks
         xCposkzU4RmnrksiZzi11UdQZrHlei401dediDbwJXRb+Lh1CR6o4XAgQQ+Oq3c+OH12
         0eokmaEUoI5lwpo2TPhq4L775HxqK6gygDrl369WQcLmL5wsFcHfk22rb5YHeBLuT6QZ
         85Wg==
X-Gm-Message-State: AGi0PuZpadPl8y0yyMMGt/Rxh3c70e5jYgjZSa1jvM4yBukzsrZ9F7Kw
        ACYM389nm6HcbWG23rhScv8=
X-Google-Smtp-Source: APiQypJLoMPD4aEjRb8mZV8whi87DgBvI13poaPpbJYRJq+2N/ZzLCza99R+9lQnGYTDapul28+r4w==
X-Received: by 2002:adf:ec46:: with SMTP id w6mr2785258wrn.262.1587645943224;
        Thu, 23 Apr 2020 05:45:43 -0700 (PDT)
Received: from net.saheed (563BD1A4.dsl.pool.telekom.hu. [86.59.209.164])
        by smtp.gmail.com with ESMTPSA id s18sm3771640wra.94.2020.04.23.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 05:45:42 -0700 (PDT)
From:   Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
X-Google-Original-From: Bolarinwa Olayemi Saheed <refactormyself@users.noreply.github.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stephen Kitt <steve@sk2.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Eric Biggers <ebiggers@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH] docs: Fix WARNING - Title underline too short
Date:   Thu, 23 Apr 2020 13:45:17 +0200
Message-Id: <20200423114517.18074-1-refactormyself@users.noreply.github.com>
X-Mailer: git-send-email 2.18.2
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

There were two instances of "Title underline too short" and they were
increased to match the title text.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 3e68da9fc066..6f7f01b1180c 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -292,7 +292,7 @@ Default value is "``/sbin/hotplug``".
 
 
 hung_task_all_cpu_backtrace:
-================
+============================
 
 If this option is set, the kernel will send an NMI to all CPUs to dump
 their backtraces when a hung task is detected. This file shows up if
@@ -575,7 +575,7 @@ scanned for a given scan.
 
 
 oops_all_cpu_backtrace:
-================
+=======================
 
 If this option is set, the kernel will send an NMI to all CPUs to dump
 their backtraces when an oops event occurs. It should be used as a last
-- 
2.18.2

