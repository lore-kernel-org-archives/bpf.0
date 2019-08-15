Return-Path: <SRS0=AlFI=WL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F120C3A59B
	for <bpf@archiver.kernel.org>; Thu, 15 Aug 2019 14:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651AE2086C
	for <bpf@archiver.kernel.org>; Thu, 15 Aug 2019 14:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="w00eD6zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732955AbfHOOci (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:32:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35962 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbfHOOcg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 10:32:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so1433742wme.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aDNxpHGNjzIhRdFUHhWdbz14YhYFMSlgXH+UzQL/n/8=;
        b=w00eD6zuYRGH1jIiTVJEf9lLjIVZnhC0QawhAC32fxEEopDqbM7+pSk/U1hD8EBSZY
         /yxX56laY8Y0nO3tLEghixZcIXpdS5dvO1Z3f/OD02kX0sMLzg7Hi5obV7/aO0OSASB2
         74H0Jk8AAzzEU15yE5DzNS4DUzEcbQC4AWywvYV6r+mfcMBR3Sm1saJe4KsrF6Ax+i+A
         Lj36frIWgqgDwygDUu59dq/jgYRHPN0QxpLO8ED+hYdQUkbJyhGsyY2Y4MrbuXdAujnY
         9dExVa93uVTvqdbIzppTifEVJvdkm1zjhojjoyUlouF+EHQt8HQS9/ay5FIS9jzp2UEz
         HSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aDNxpHGNjzIhRdFUHhWdbz14YhYFMSlgXH+UzQL/n/8=;
        b=TL6u8SigHdbPp0cN6ASMOcYIRYAWexVDGJdLUTvaCnoCgp/9DdFOYi2Nyusg/AhQsJ
         raiDP/fOo+tx1nvZyggghfwnymBiyqnPJNBn1TQ09NCECQzrToQ5dkqm1Mxb1FzhPaUw
         PLjM8VKqY6/I5/z3k+q8J2Trqexpmw6pNXKXPm8nMR1b8OQOF1LxcTTg/9BaiFdrx6R9
         +olOVNx6JGhAS71oq9ptRRnI3t0tTYFunnSfIL/xhCl/h3PR/O2ZwCcz3PcDOOBR+1x6
         Rm6mWnTaMN+5rVyjcZoSjUC3S7C12lGoxZsmTjTkBTATyHOmRnRq38KB6cQ2x8Xt7/LF
         wx4g==
X-Gm-Message-State: APjAAAVVrd/lCan7zHNsxjVxMxLlDWhyWGVgIGUyi5H5sii090N/d03v
        hOLg2XDw8SHLBtzEpZjld0qoiilt1z0=
X-Google-Smtp-Source: APXvYqxUUBg66ASuGRViLj9+Zj2B2ANuj8oLlQrkJxxEmO5ygbikhXVzd8iDj+qx4LVlLJbmdKlm2A==
X-Received: by 2002:a1c:a686:: with SMTP id p128mr3228393wme.130.1565879555573;
        Thu, 15 Aug 2019 07:32:35 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a19sm8857463wra.2.2019.08.15.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:32:34 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf 5/6] tools: bpftool: fix format string for p_err() in detect_common_prefix()
Date:   Thu, 15 Aug 2019 15:32:19 +0100
Message-Id: <20190815143220.4199-6-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815143220.4199-1-quentin.monnet@netronome.com>
References: <20190815143220.4199-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is one call to the p_err() function in detect_common_prefix()
where the message to print is passed directly as the first argument,
without using a format string. This is harmless, but may trigger
warnings if the "__printf()" attribute is used correctly for the p_err()
function. Let's fix it by using a "%s" format string.

Fixes: ba95c7452439 ("tools: bpftool: add "prog run" subcommand to test-run programs")
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index e916ff25697f..93d008687020 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -139,7 +139,7 @@ int detect_common_prefix(const char *arg, ...)
 	strncat(msg, "'", sizeof(msg) - strlen(msg) - 1);
 
 	if (count >= 2) {
-		p_err(msg);
+		p_err("%s", msg);
 		return -1;
 	}
 
-- 
2.17.1

