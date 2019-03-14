Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF9AC43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EADC21852
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gKOs2oy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfCNLlC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:41:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37797 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfCNLki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 07:40:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15so5486083wro.4
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l67juo/mfoJZKSxkVJ/mLgxXF2knqcvc9keVCMk5kCE=;
        b=gKOs2oy2ymhozF2buAGSuG+waejAIi6ncRlDJFAdT+SAZ5SQDDY7LBTzq/+x6s69hC
         1Ip4f8t5+TsAl76+kctJG5Qtmm67MlBKCteetshhAr5JlMoP5s2JOoVIUYsjroNHjjyS
         Rhyqdl6JIbZkAEEk9Muh16ldrOU2NVOefBpwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l67juo/mfoJZKSxkVJ/mLgxXF2knqcvc9keVCMk5kCE=;
        b=oh74/67dEZolkFPaIUC5Z6tR/08nAfS0CirnqKMD3hyfWDD15vtmJDm98wSAWSYlBO
         6HGimDyvrs6q5AGNsGh9MfHYEs/lvKcCM0EKzFqInRhHmGLT72hMpG7DSdONgzRFkeOu
         18NA/Fm4NX/zcSk2+7NSs5Q913v8Tgev36feJwxD1MnSEaxo5Xqfk1QHJWrzNdTE/IBY
         b/gIcRXtjJHAgAmw5M0dTcQvi43DDkcol3yKctkJJYpIIjB9TGwsbe7J4JbcWmexMAHY
         l3Hr7Zoz1XkLY4DYI9sH3f0jY7UTXWBFo3thpawXfdhWDCQ2t+rGN8Li3hw1GeGbw6QT
         DJQg==
X-Gm-Message-State: APjAAAWAhHtExi0nXEBvijc2NvSM3ZDu3y70lwgr9eiWPl71mAtgs0XX
        NIjBwd+KXbSiJb4bnpA8eSiyDg==
X-Google-Smtp-Source: APXvYqziAm5Cu4RchepkQebZFr+h+rboNqFCL+aa5/sscrlauF6RaqGlH5L0E3Bhz/aCpZls9zQbxg==
X-Received: by 2002:adf:e442:: with SMTP id t2mr18049767wrm.256.1552563636382;
        Thu, 14 Mar 2019 04:40:36 -0700 (PDT)
Received: from antares.lan (5.8.9.5.4.5.2.4.f.f.6.d.4.1.5.8.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:8514:d6ff:4254:5985])
        by smtp.gmail.com with ESMTPSA id a9sm1804017wmb.30.2019.03.14.04.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:40:35 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, theojulienne@github.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 2/8] bpf: allow helpers to return PTR_TO_SOCK_COMMON
Date:   Thu, 14 Mar 2019 11:39:48 +0000
Message-Id: <20190314113954.10210-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190314113954.10210-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190314113954.10210-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's currently not possible to access timewait or request sockets
from eBPF, since there is no way to return a PTR_TO_SOCK_COMMON
from a helper. Introduce RET_PTR_TO_SOCK_COMMON to enable this
behaviour.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f02367faa58d..f62897198844 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -205,6 +205,7 @@ enum bpf_return_type {
 	RET_PTR_TO_MAP_VALUE_OR_NULL,	/* returns a pointer to map elem value or NULL */
 	RET_PTR_TO_SOCKET_OR_NULL,	/* returns a pointer to a socket or NULL */
 	RET_PTR_TO_TCP_SOCK_OR_NULL,	/* returns a pointer to a tcp_sock or NULL */
+	RET_PTR_TO_SOCK_COMMON_OR_NULL,	/* returns a pointer to a sock_common or NULL */
 };
 
 /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF programs
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a52e723c8e5d..f60d9df4e00a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3148,6 +3148,10 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_SOCKET_OR_NULL;
 		regs[BPF_REG_0].id = ++env->id_gen;
+	} else if (fn->ret_type == RET_PTR_TO_SOCK_COMMON_OR_NULL) {
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		regs[BPF_REG_0].type = PTR_TO_SOCK_COMMON_OR_NULL;
+		regs[BPF_REG_0].id = ++env->id_gen;
 	} else if (fn->ret_type == RET_PTR_TO_TCP_SOCK_OR_NULL) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK_OR_NULL;
-- 
2.19.1

