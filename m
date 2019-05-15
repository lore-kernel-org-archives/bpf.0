Return-Path: <SRS0=A4U9=TP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C118C04AA7
	for <bpf@archiver.kernel.org>; Wed, 15 May 2019 03:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06022086A
	for <bpf@archiver.kernel.org>; Wed, 15 May 2019 03:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HM1wr/BK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEODix (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 May 2019 23:38:53 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:47044 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfEODiw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 May 2019 23:38:52 -0400
Received: by mail-vs1-f74.google.com with SMTP id q7so145608vsp.13
        for <bpf@vger.kernel.org>; Tue, 14 May 2019 20:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=64dZO103FjaqqJ22MJxyfeFXub3dklogxlZJawwpYtw=;
        b=HM1wr/BKf8+hUTG+m9Jeld5VnMcx6ZjA0YuiKErnB9MOV8zYv2I8KxQyvF6WI+F13A
         HMeBgcaPhqw+psSVvduehQw7py0qH913PY9e4tCX3z/8roQqgKV4Urz1A0PHXyf5aczd
         I0Yk6+C0arvyJOxZsgWxFkMhzsi09HICz0N/elJVKtvG+CXGjTHBQjrFD2DU5AOuJ5lp
         tQSjDmrWGcCv7tFRWZgKak8WpIqnjJqgzPcut6qT9k61okWx3CmxKnZKTSEHMIgz01s3
         eMmRVyN87kifwOtTmGfuRuYr7e4gM2v2/lh39z1LGAbXyQcDxRTrvD/vjM54dKTwrI/l
         NVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=64dZO103FjaqqJ22MJxyfeFXub3dklogxlZJawwpYtw=;
        b=Y8tPfuwIRgq2/wuEYOg4+4/BnPZsQ6izx/5CLZmnjdZqkpjTcm0UN7y0SxvykBKLLH
         fUDf9RRx+eeDzWpw/5XqhxyHcTiITt/X4pxmaWZVNwZIzVHRGctz0ul/K8SZW7ZSmpcw
         hl5wj4UjKILPb8B5QCi/AUJSox4zhmJTFVK1/eOwICPfY4uI6LEXVKvNTt7Pd7hBBEoD
         ZBWwv6Q/JNtLNAnoWKvLpYq83pzRhQJij/cdTtyWMW4/KcvJKZtRcvpPsZ3mPJG00m7c
         FBtrEJ+TAra94N8BS1eDOYAAkjCFobXyflRpD84YzYrhAOx0YDN2rFS0G2sKNNxaMA9g
         AF9w==
X-Gm-Message-State: APjAAAXQCMywkQysZdmqdg1KIBOHSIh1tGKL14pZJKbDxJGbYEqxE2Pb
        OpY5UGoUCcZ3+8Itb3j2Sy7BFAk=
X-Google-Smtp-Source: APXvYqw9SYTGatPCNNTFUoLzz5PUPxyum/adtbFp5CGLh/BKPFXiattJWaB4hVno3oasdRfEy34uctg=
X-Received: by 2002:a67:bc01:: with SMTP id t1mr15777058vsn.102.1557891531762;
 Tue, 14 May 2019 20:38:51 -0700 (PDT)
Date:   Tue, 14 May 2019 20:38:49 -0700
Message-Id: <20190515033849.62059-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH bpf] libbpf: don't fail when feature probing fails
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Otherwise libbpf is unusable from unprivileged process with
kernel.kernel.unprivileged_bpf_disabled=1.
All I get is EPERM from the probes, even if I just want to
open an ELF object and look at what progs/maps it has.

Instead of dying on probes, let's just pr_debug the error and
try to continue.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7e3b79d7c25f..3562b6ef5fdc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1696,7 +1696,7 @@ bpf_object__probe_caps(struct bpf_object *obj)
 	for (i = 0; i < ARRAY_SIZE(probe_fn); i++) {
 		ret = probe_fn[i](obj);
 		if (ret < 0)
-			return ret;
+			pr_debug("Probe #%d failed with %d.\n", i, ret);
 	}
 
 	return 0;
-- 
2.21.0.1020.gf2820cf01a-goog

