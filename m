Return-Path: <SRS0=fFcV=BQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6237FC433DF
	for <bpf@archiver.kernel.org>; Thu,  6 Aug 2020 17:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA91E20786
	for <bpf@archiver.kernel.org>; Thu,  6 Aug 2020 17:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhX/CubU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgHFRHB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgHFRGk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Aug 2020 13:06:40 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC7AC00214C
        for <bpf@vger.kernel.org>; Thu,  6 Aug 2020 08:52:29 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g3so2816262pjm.7
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2020 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DKaDTZahT68TPrt3y8j8xlCXfU2IoxIayJ09loOj8ZE=;
        b=JhX/CubUYC7aE5m4SNb/d0hwzJDwU2Bbm5eAj2Yyc5a4e+N8KWNhLqWC7VHcPVtjA/
         BDuIqKNdDwQ6tK4UA9tkY3+1yycjawE/a0qINJ872mqNwfgizOcn9j/wuo9lNHEVCYEa
         DcLb49hX1HQQnA4i7Ofv3IwjK5THQAPMnpUSVBC6hBzdsWHkq2VHC4KxoxGBj+bKXSLD
         EsGRZDnp5TrMqf/tGeKbMvq8vtFmjNXmTwsn8WzCsbkGCyKO49uGcuxXhp4lR6XOOreA
         BYOgbj65at0sIRqHUkxUTYZ7AHxsDVtV2Mgl2uud2hT4+MPIynP2K2HlnGh+zE6HBvU3
         6cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DKaDTZahT68TPrt3y8j8xlCXfU2IoxIayJ09loOj8ZE=;
        b=WF11QxCLcqnG3iJgKgpcuOjfjxF34c9CdWQ/cZplomkhDuMyl2M2ccGYhk60udGHuS
         /RWKvIEZYaY73FBEga1aYq1cLiyPtfMEnGMKzBBhRFWFcMnxnZFLwbvwgVUq7idRwIKl
         2AzCBc9G8gB/y2S5Z3ZTQYnVVilBZfzo4Tk5S3PbATeqTbLL4cb0Rb5pYFAnqcGUgLqW
         fyo6QI2ZTctA1/0KAEiBpEQwTAfZUsnzJSVQzjJtFhjaIB4G+tVdIUMMdP7+USzpo4cG
         9Fx+VoHlF4ORVartQdFbxXUH0UMoqmyZvkmLVsoVSlL9Wo1DvmQVjRXqXxfFlXvTfGMJ
         epEA==
X-Gm-Message-State: AOAM530NQIE37mVGPCVQa/NrvRYX0KMMNKV0UWZg8hQ5GTXDgGed5xjQ
        8plfx0eteFjToTBrReHo+Q7oQnY=
X-Google-Smtp-Source: ABdhPJx+QUh0epEg1PjEslt5Re46VsWuyd9HeUPmxJfHw2mw+1qHTKNCTw2mORGskGzXsRnvkmWY1N8=
X-Received: by 2002:a17:90a:9516:: with SMTP id t22mr8184569pjo.134.1596729147206;
 Thu, 06 Aug 2020 08:52:27 -0700 (PDT)
Date:   Thu,  6 Aug 2020 08:52:25 -0700
Message-Id: <20200806155225.637202-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH bpf] bpf: add missing return to resolve_btfids
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

int sets_patch(struct object *obj) doesn't have a 'return 0' at the end.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/resolve_btfids/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 52d883325a23..4d9ecb975862 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -566,6 +566,7 @@ static int sets_patch(struct object *obj)
 
 		next = rb_next(next);
 	}
+	return 0;
 }
 
 static int symbols_patch(struct object *obj)
-- 
2.28.0.236.gb10cc79966-goog

