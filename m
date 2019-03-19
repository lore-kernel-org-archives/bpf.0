Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB28C4360F
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB742133D
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ohUu0iBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCSKV3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:21:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47004 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCSKV2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 06:21:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id o1so1005592wrs.13
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n4hL1tN1CEOGoCmqb01t2n9uqIM1W+sHW/nYFgLgWGs=;
        b=ohUu0iBmtWMbcU3hhGvpRW8Lc8Ab6B/hrkRjYc4YFRXpc5Q4o6ZrbGmRd1b9YpL5qp
         rB0p8dSWLne4qzEiCBaQDZqdV0XV8CDvJPG1Jy2EdCa5vtQoPjv2KbCgRG8hvR36WEXM
         gYe1/mzyLQpEr/GnPPg2A3jqnaVWwM7SqLqQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n4hL1tN1CEOGoCmqb01t2n9uqIM1W+sHW/nYFgLgWGs=;
        b=bfzGAlEOm/IIjSEfQUjfRChaZ8F4W7K+cCD7V4IVR5WRSdoOOZcqFSfjScweDtZQrL
         hWDYtJ4fM44xBzf94SRUiFhwrUKoDi0JU+9g98fdrWh5xbfiEkppthjR25vDpOVtvCjD
         fiP+4RoKL6ZvQ6RY9IBWOXiQd+jGYTt/hza3plXGnIJFUHyBajJ+znyLuyhgUbkKrG7U
         JBLdB6ak74C+uizsyJnAQFnZm6qrAAELrwoyAXHIg47ZQZ0292d+D7bJEXqjdu/gvjoC
         3etDOu4WDdAGmgT7ZNloqjOh7pyCnNFcjy2goE9UA2Gk2O1Zyzudmv2s+8uAXdoSK6zI
         m3Dg==
X-Gm-Message-State: APjAAAW2S710ClZ4niJg2PnDGLxQpu3272J5blB2r9mnuOWfQlXEYgIM
        0wF1kHPEI+xVUEBQycrKdqJmTQ==
X-Google-Smtp-Source: APXvYqwPpDyXH5/fbClZWt/+4XFK7gCdDdVeTQGnQsKmETe5QpeKPj50/u+5123nNNrDMrw48ZxL0A==
X-Received: by 2002:adf:81a1:: with SMTP id 30mr17638868wra.285.1552990886920;
        Tue, 19 Mar 2019 03:21:26 -0700 (PDT)
Received: from localhost.localdomain ([217.138.62.245])
        by smtp.gmail.com with ESMTPSA id q2sm27895781wrd.46.2019.03.19.03.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:21:26 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 1/8] bpf: track references based on is_acquire_func
Date:   Tue, 19 Mar 2019 10:20:56 +0000
Message-Id: <20190319102103.7380-2-lmb@cloudflare.com>
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

So far, the verifier only acquires reference tracking state for
RET_PTR_TO_SOCKET_OR_NULL. Instead of extending this for every
new return type which desires these semantics, acquire reference
tracking state iff the called helper is an acquire function.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7c80f7f8f331..a52e723c8e5d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3147,19 +3147,7 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 	} else if (fn->ret_type == RET_PTR_TO_SOCKET_OR_NULL) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_SOCKET_OR_NULL;
-		if (is_acquire_function(func_id)) {
-			int id = acquire_reference_state(env, insn_idx);
-
-			if (id < 0)
-				return id;
-			/* For mark_ptr_or_null_reg() */
-			regs[BPF_REG_0].id = id;
-			/* For release_reference() */
-			regs[BPF_REG_0].ref_obj_id = id;
-		} else {
-			/* For mark_ptr_or_null_reg() */
-			regs[BPF_REG_0].id = ++env->id_gen;
-		}
+		regs[BPF_REG_0].id = ++env->id_gen;
 	} else if (fn->ret_type == RET_PTR_TO_TCP_SOCK_OR_NULL) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK_OR_NULL;
@@ -3170,9 +3158,19 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		return -EINVAL;
 	}
 
-	if (is_ptr_cast_function(func_id))
+	if (is_ptr_cast_function(func_id)) {
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
+	} else if (is_acquire_function(func_id)) {
+		int id = acquire_reference_state(env, insn_idx);
+
+		if (id < 0)
+			return id;
+		/* For mark_ptr_or_null_reg() */
+		regs[BPF_REG_0].id = id;
+		/* For release_reference() */
+		regs[BPF_REG_0].ref_obj_id = id;
+	}
 
 	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
 
-- 
2.19.1

