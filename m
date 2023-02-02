Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CB7C05027
	for <bpf@archiver.kernel.org>; Thu,  2 Feb 2023 22:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjBBWnn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Feb 2023 17:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjBBWnn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 17:43:43 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAD36B36A
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 14:43:42 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4b34cf67fb6so34016147b3.6
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 14:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ETyfBjp/kDN4jefKK3Q6zUxbaFrFVt3ACbzabZOwIuE=;
        b=f+YzL74Biy2AeE/Zv7pl/NQCIMJRpyiBH1LQMN3/bPSp6adF98sWUVFEwoLqYrIBb/
         DOVb7otliIKxY4YUT9qhHBiCjbR9+0a/ItIQlht2WP6mWTWOr0eYmi3AsCnwZOGbhRRg
         bBSyUM8ZJbdDUVrRIMqJitkLWOY7x1tO1GoyqR8HUq+jitRYiv7pI4q1I41omUzKjp+P
         v2SkAtSoTa7EsvXYotDrR3Tqzjl6XANJKeUV/uollY/5OpQnwaLe/e2rLlM7iwQMzvxC
         WsS1KDS12DFVrGGYl6ju5odsW6Z/mLL1fzb5sJBvBwkeVoEG45+KzS+YS/HHMmuHxmem
         2y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETyfBjp/kDN4jefKK3Q6zUxbaFrFVt3ACbzabZOwIuE=;
        b=VRgVT93+lMZQNkTj71N4cQb0TUQXs4GlH5ZsJCZWV1do8UcZre5/GhbtpdkTsNCSYU
         sbvzhbQWj52esjStvBPAtIrsCK0OgGZ78bEt1GMnTUZdj0voAB5uXKNhF/JQWykSBMfo
         capYHC5aQOjuxujMMk75H/cfMEdivaUSr+vvdsCLIo//KLW+OuRRrtJJ8fGSEvsPcG8w
         RGaiJjnE/NBBS1/O7NZpR4akxqSE6CjnIPZNcM4XoaSdhWtq4zgd3z+6rMb6UeaMuMEl
         IsldJ8VSLA6Fjb7cTbq/pYbLKoZKP2CB3UkArgLp3Uh/CV7JY/y0C+VNQRY9jO8xuwzA
         8kNw==
X-Gm-Message-State: AO0yUKWWZ8O3Oj6IX9ZNmPRDmax+T8l4p69L/Na3ifQ3jE2QTY4kHjSF
        enoue4RjQN4OsAbI15xoLX79NGLwG+S/
X-Google-Smtp-Source: AK7set/rWasqhCe1rRkmQpf716Pzhpp5i99MJwOKd7NBWl/NsSb8CYPvVep2h7PP5FQmT5YBD92oe1PMprOL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3bb5:4c1f:1143:605])
 (user=irogers job=sendgmr) by 2002:a81:6d48:0:b0:525:196c:d720 with SMTP id
 i69-20020a816d48000000b00525196cd720mr47098ywc.278.1675377821580; Thu, 02 Feb
 2023 14:43:41 -0800 (PST)
Date:   Thu,  2 Feb 2023 14:42:53 -0800
Message-Id: <20230202224253.40283-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v1] tools/resolve_btfids: Tidy HOST_OVERRIDES
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't set EXTRA_CFLAGS to HOSTCFLAGS, ensure CROSS_COMPILE isn't
passed through.

This patch is based on top of:
https://lore.kernel.org/bpf/20230202112839.1131892-1-jolsa@kernel.org/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index abdd68ac08f4..2abdd85b4a08 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -17,9 +17,9 @@ else
   MAKEFLAGS=--no-print-directory
 endif
 
-# always use the host compiler
+# Overrides for the prepare step libraries.
 HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
+		  CROSS_COMPILE=""
 
 RM      ?= rm
 HOSTCC  ?= gcc
-- 
2.39.1.519.gcb327c4b5f-goog

