Return-Path: <SRS0=ansy=YJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82000ECE588
	for <bpf@archiver.kernel.org>; Wed, 16 Oct 2019 08:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B07A20872
	for <bpf@archiver.kernel.org>; Wed, 16 Oct 2019 08:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KkR7GEHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbfJPI6Q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:58:16 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:38202 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbfJPI6P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Oct 2019 04:58:15 -0400
Received: by mail-lf1-f48.google.com with SMTP id u28so16782647lfc.5
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2019 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+4sUm7d4zOmxV/DS5enUnVCl8aumQR4W4v3g1GZPP0=;
        b=KkR7GEHpT+Of8CpaVbhXHSe9RE21dpY6+aaR84aIojff9Bxmpe5s9fMQfIbGgLHVcJ
         8ONYzYo4caQ1EvbJlmInyey0wAUZh1UNlvfFYKXA5sjKUU9JpzyexDnkNTqdxNUlfE78
         QfDoiTvZBoQjmjDVRP20GUB+3dZVa9oss6mpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+4sUm7d4zOmxV/DS5enUnVCl8aumQR4W4v3g1GZPP0=;
        b=uoJBOAPrBn7CmJe6f6W5n+MX6glAgrCv8shejur7YZOBQ37myXToEEgTmxOhXR1YH+
         zrtJhPidgrnmZ6l+YnXvQwKYzXbv+fnjGWnQbSuswiRk2Zsh5DCtbpHoh/i7fY6HPMnf
         fdKk+WnFd2B/xs9dicsER5fVSP/ceQiVlqRxoyV7Fzeb/uwJbwTHiN1fYTM/F+6bJO6f
         XJy5tx/KhVzhJAT0YQd4hifqMxzCUNBwS2MeQX8iNn0ona/hXqKwq7vLOaRkDEMSDMlO
         V2Q2mnIZ3RbC4xKVvgaAK/HWCN6EnJX8AB04uuWkvcu4g3xpwXyripfkCJHrAlXHdl3Q
         FNAg==
X-Gm-Message-State: APjAAAV2Bl8MJqxbaauWtCuX0wEfJ9lU7XbKepEmRZ8N+xntW6Fvh1/y
        bnPxO9ZC8l9yvbzQZ/LZoCq2mPQiBWoyOg==
X-Google-Smtp-Source: APXvYqw5zxBWvIpopn/S5WyBrW/zOe3siFtoi028J+TB9HrUijW5o69Kf8RRT+aK0IjOG/qr5YV72A==
X-Received: by 2002:a19:148:: with SMTP id 69mr12460027lfb.76.1571216293141;
        Wed, 16 Oct 2019 01:58:13 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id h5sm6542515ljf.83.2019.10.16.01.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 01:58:12 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH bpf-next] scripts/bpf: Emit an #error directive known types list needs updating
Date:   Wed, 16 Oct 2019 10:58:11 +0200
Message-Id: <20191016085811.11700-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make the compiler report a clear error when bpf_helpers_doc.py needs
updating rather than rely on the fact that Clang fails to compile
English:

../../../lib/bpf/bpf_helper_defs.h:2707:1: error: unknown type name 'Unrecognized'
Unrecognized type 'struct bpf_inet_lookup', please add it to known types!

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 scripts/bpf_helpers_doc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 7df9ce598ff9..08300bc024da 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -489,7 +489,7 @@ class PrinterHelpers(Printer):
         if t in self.mapped_types:
             return self.mapped_types[t]
         print("")
-        print("Unrecognized type '%s', please add it to known types!" % t)
+        print("#error \"Unrecognized type '%s', please add it to known types!\"" % t)
         sys.exit(1)
 
     seen_helpers = set()
-- 
2.20.1

