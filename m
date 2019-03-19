Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB98C4360F
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F8A20857
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MZlxP/SO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfCSKVa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:21:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39574 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfCSKVa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 06:21:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so6200488wrn.6
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 03:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l67juo/mfoJZKSxkVJ/mLgxXF2knqcvc9keVCMk5kCE=;
        b=MZlxP/SOtQPpaXFxEB5RK/LrYNhqija5Zu7jkHN6yeuhiPSUkuk/LJz08oJ5N5Pm12
         dsjB0lR7kDMv50d9lZ6JgTRFkCTy+Zc1UZ0ApOcwgTXZZ+vInfsgnd5ilVF0pR7aYA4q
         Cn2kkvGBlbRdrdGjMdCpNcaogEUffpu0LfZO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l67juo/mfoJZKSxkVJ/mLgxXF2knqcvc9keVCMk5kCE=;
        b=VaX0c4UlqCVzEc3AZ0l9b0Lf6WFfsPTUjP5JBacRnaTT4PKXU2tihc3fDV2qEqqlkP
         WndReL5+O72Wpip/QxngQJoDdgZRJ3I+t2G5st/dRKyivRGf0Te0w8q2bWy1+ZE/wVQj
         nGJDbnWNZ5QmGsqSlZ2CL1tN+X0uwdoUOD6cz2A5zz36zkjTYcPXpDQ5p+iuw/BcqVmg
         ASL7PyequglFCnwAXr2tRL5+ynwqwa4AMbslA0JAoWpobTGQt6GVlIdPX2Y2MUKP3d7C
         KwN7piajRTDbGOk50LyV508AYw+OhXfKMdnXoglcLKNqWmEAeA7i/JUJppJl57o+RehJ
         Urtw==
X-Gm-Message-State: APjAAAUBfZqAfpoKoj9u9qgRPODEujLq8Zq+zXv0w5lpKCROlXpJXCXW
        W8NOiGqVH5kVEBhTBdaK703yOA==
X-Google-Smtp-Source: APXvYqznpFmzh9CvmbuURZGul7GF4/Kq/SES+kHKZdyIDaske0fBnLTVibO/T15aSlFAM9xByYBqUw==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr7165799wrn.193.1552990888193;
        Tue, 19 Mar 2019 03:21:28 -0700 (PDT)
Received: from localhost.localdomain ([217.138.62.245])
        by smtp.gmail.com with ESMTPSA id q2sm27895781wrd.46.2019.03.19.03.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:21:27 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 2/8] bpf: allow helpers to return PTR_TO_SOCK_COMMON
Date:   Tue, 19 Mar 2019 10:20:57 +0000
Message-Id: <20190319102103.7380-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190319102103.7380-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190319102103.7380-1-lmb@cloudflare.com>
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

