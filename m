Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0408C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBB3218FC
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="jEmMk2Ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCVBya (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:54:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37169 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfCVBy3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 21:54:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so389438pfr.4
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 18:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWNjJMtNxZBeesER0N+UY2Pio+QEW3chILV2c/kFfqU=;
        b=jEmMk2Urvf5UfoxQz34owaICOKq+E7A8fMi10bknhZieRU/nzyOBig8bQzFhEV3Foa
         8XhkW9YtwQZjSflkbjKV0lii44vvbitZ83cROB96Ij+GidNR881OfVXOMdFDcFAB8AGQ
         AHZY+51wNBX2ZqNjwph9OvusChY7KCviDnWAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWNjJMtNxZBeesER0N+UY2Pio+QEW3chILV2c/kFfqU=;
        b=X4SEjnMdTK07hPF8TIBMX8GBFQkEsJbg31QjlW6+EHyJJX34LojNDBTVG6NAKywo5o
         KOIz1nnnywt4vVes4L6sSsOKtqaCkslmf7H/o3qd9MciFkRX1C1zpDQnz3YJm+XX7hNb
         rHzzDOEMwQILtGTILUADN0EcJCIGM0GmHBIRXR80yS2zHuoXdVQwFUQAEYsSIiF0v1Oi
         F0FE5QYw8wOTf7XDGk4d0CPkx1GSK6bTO97loh5J5zdr1lYn43SgGS1xadmuW79vWnTE
         JaMQDj9shDme7nQ6/Q5TWff4QNih3Ar13DwYFlJWpPp6jY3FZFStY3xj8SFpKKNNA1rf
         xJOg==
X-Gm-Message-State: APjAAAUeK6R+u5Lern9yk+BrWmnd8G4sIv5zryWbNPMC2D1DS9TIlW1j
        wNO3W922HO1KHhhdEul7ArAQAw==
X-Google-Smtp-Source: APXvYqzrACzxI5i2uAM57JARWqp3R3A9MQk+WkO4sUdEKP+vCJ4ToSXQeURpY9aRKiJFUPvks68lLw==
X-Received: by 2002:a63:460a:: with SMTP id t10mr6261428pga.354.1553219669036;
        Thu, 21 Mar 2019 18:54:29 -0700 (PDT)
Received: from localhost.localdomain ([157.120.241.186])
        by smtp.gmail.com with ESMTPSA id i10sm7161799pgs.26.2019.03.21.18.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:54:28 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 2/8] bpf: allow helpers to return PTR_TO_SOCK_COMMON
Date:   Fri, 22 Mar 2019 09:54:00 +0800
Message-Id: <20190322015406.26453-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190322015406.26453-1-lmb@cloudflare.com>
References: <20190319102103.7380-1-lmb@cloudflare.com>
 <20190322015406.26453-1-lmb@cloudflare.com>
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
index 868a82ad5597..a476e13201d6 100644
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

